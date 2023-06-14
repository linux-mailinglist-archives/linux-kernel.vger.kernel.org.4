Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6269C714C50
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjE2Oq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjE2OqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:46:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02F5B2;
        Mon, 29 May 2023 07:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58FD4625BA;
        Mon, 29 May 2023 14:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8EFC433EF;
        Mon, 29 May 2023 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685371583;
        bh=5wmKnDZ1QEngg8pOAg+VZ7IcLSNHMh6tgnuCIJY0KSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0zwE0C2bchW/nCkKx0WuUE4N+VcdWvivrZIcC7oeulj9O4e9E6ifH9eVAe7VtelF
         K0V5lIgRgHxQs91wwtM9bATdulCPqjvshLAJAx2nrv/TLCreNEmd8WA3Zxst7ZeDoA
         d/FsKO4/JEvKATeWrfk8gmy7K9xKvXBDve+1gp0w=
Date:   Mon, 29 May 2023 15:46:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Minda Chen <minda.chen@starfivetech.com>,
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
Subject: Re: [PATCH v6 7/7] riscv: dts: starfive: Add USB dts configuration
 for JH7110
Message-ID: <2023052909-speed-cackle-294e@gregkh>
References: <20230518112750.57924-1-minda.chen@starfivetech.com>
 <20230518112750.57924-8-minda.chen@starfivetech.com>
 <20230525-cross-daybreak-24dfed69e5d0@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525-cross-daybreak-24dfed69e5d0@spud>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 10:36:38PM +0100, Conor Dooley wrote:
> Greg,
> 
> On Thu, May 18, 2023 at 07:27:50PM +0800, Minda Chen wrote:
> > Add USB wrapper layer and Cadence USB3 controller dts
> > configuration for StarFive JH7110 SoC and VisionFive2
> > Board.
> > USB controller connect to PHY, The PHY dts configuration
> > are also added.
> > 
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> 
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > index 71a8e9acbe55..b65f06c5b1b7 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > @@ -366,6 +366,59 @@
> >  			status = "disabled";
> >  		};
> >  
> > +		usb0: usb@10100000 {
> > +			compatible = "starfive,jh7110-usb";
> > +			ranges = <0x0 0x0 0x10100000 0x100000>;
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			starfive,stg-syscon = <&stg_syscon 0x4>;
> > +			clocks = <&stgcrg JH7110_STGCLK_USB0_LPM>,
> 
> Please don't pick this patch, if the rest of the series is applicable,
> as this will break building the dtb as stgcrg does not yet exist in any
> maintainer tree.

Ok, I'll just take patch 6/7 then.

thanks,

greg k-h
