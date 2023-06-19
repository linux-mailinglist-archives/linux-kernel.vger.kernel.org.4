Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22C77358B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjFSNf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjFSNfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:35:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C702C1;
        Mon, 19 Jun 2023 06:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD18160C6C;
        Mon, 19 Jun 2023 13:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6B1C433C8;
        Mon, 19 Jun 2023 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687181752;
        bh=0Clqdzr8ksnDkV+ZCSDshro8OIUJJGdZ5wYLpnZqzUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fwzq1KJKGuiDsTlLvIiQh0/jqhtxg5tocu13OII5gIvkOGmNEhDza3mmh9Gee3JdZ
         0OBPYmd9hVUIlvldbvP3kzO3I8/jV9fG4dVfth4nhqB0wbmQreSQj3eizRIlwyVqDQ
         7veBCotYt2cLnodWKa/VCMMjMwMUEi1NEfQOGfVU=
Date:   Mon, 19 Jun 2023 15:35:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v6 5/7] dt-bindings: usb: Add StarFive JH7110 USB
 controller
Message-ID: <2023061941-bok-gooey-c4fc@gregkh>
References: <20230518112750.57924-1-minda.chen@starfivetech.com>
 <20230518112750.57924-6-minda.chen@starfivetech.com>
 <20230525-shopper-handbrake-27fc06aede32@spud>
 <5124e6a8-8ca6-71a5-19d6-8c15e954c458@starfivetech.com>
 <20230526-grain-cubical-e0af96202007@wendy>
 <a91f4167-e797-435f-8867-dbef4b109df8@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a91f4167-e797-435f-8867-dbef4b109df8@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 08:22:05PM +0800, Minda Chen wrote:
> 
> 
> On 2023/5/26 21:13, Conor Dooley wrote:
> > On Fri, May 26, 2023 at 06:24:48PM +0800, Minda Chen wrote:
> > 
> >> >> +title: StarFive JH7110 wrapper module for the Cadence USBSS-DRD controller
> >> > 
> >> > I think you told Krzysztof you'd rename this to "StarFive JH7110 Cadence
> >> > USBSS-DRD SoC controller"?
> >> > 
> >> The previous title describe whole USB controller for previous dts node is
> >> merged. Now the dts node is split. 
> >> "starfive,jh7110-usb" just contain starfive wrapper layer dts configuration.
> > 
> > Okay, I must have misunderstood the conversation on the previous
> > version. Sorry about that.
> > 
> >> > Otherwise, it looks like all the stuff from him and Rob have been sorted
> >> > out, so other than $title this is
> >> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > 
> 
> Hi Greg
> Can this patch can be applied to Linux-USB-next tree? Since this patch is reviewed by Conor.
> 
> List Below is Conor's previous E-mail.
> 
>    I think I missed this mail somehow. 5/7 had the binding for the driver
>    so probably that should've gone via the USB tree too?
>    Should apply on its own (no deps on the phy patches) & has dt-binding
>    maintainer reviews.
> 
>    `b4 am -P 5 20230518112750.57924-6-minda.chen@starfivetech.com` if
>    that's your cup of tea.

Thanks, I missed that, now applied!

greg k-h
