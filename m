Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC8A714BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjE2OZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjE2OZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:25:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FEABE;
        Mon, 29 May 2023 07:25:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C02326108F;
        Mon, 29 May 2023 14:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ABEC433D2;
        Mon, 29 May 2023 14:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685370335;
        bh=HXadNXLfa2pbjtGXi2soLzjDLazsmd3HtXkwWcxlYt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGci5ftxukNC7rajgrAB0odDczjRsSI1tM9XB83O3u3Qp5ipQeWPupRAzGEkY82y9
         lGaeFs8LdcFF4Jx60BEDegK2e2cGvNOm82GfW5Wg61wYKzkGo74q7dA3o6LJYQmPaD
         fXwNoUGhZ6tnRhuV/VT4+PtDZlUk9vNAdCheiGTU=
Date:   Mon, 29 May 2023 15:25:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     kernel test robot <lkp@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ray Chi <raychi@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Flavio Suligoi <f.suligoi@asem.it>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/3] phy: realtek: usb: Add driver for the Realtek SoC
 USB 2.0/3.0 PHY
Message-ID: <2023052915-repurpose-partner-20a8@gregkh>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <20230525022617.30537-2-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525022617.30537-2-stanley_chang@realtek.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 10:26:03AM +0800, Stanley Chang wrote:
> Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB 2.0/3.0
> controller. Added two drivers to drive the  USB 2.0/3.0 PHY transceivers.
> For USB 3.0 transceivers, a driver phy-rtk-usb3 is provided.
> The driver phy-rtk-usb2 is used to support USB 2.0 transceivers.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> Reported-by: kernel test robot <lkp@intel.com>

The kernel test robot did not report that a new driver was needed :(

