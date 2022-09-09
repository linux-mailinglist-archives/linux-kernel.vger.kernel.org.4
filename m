Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933425B2FC5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiIIH2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiIIH16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:27:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3225117780;
        Fri,  9 Sep 2022 00:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 450C8B81AD8;
        Fri,  9 Sep 2022 07:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C35AC433D6;
        Fri,  9 Sep 2022 07:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662708474;
        bh=mnzTTxDh8PH0IXMo6zEj1N+2BnrD3K/mqm5cDR3dKA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1zjYMpdfhCXPCSPrYli9XUVpiqogqzjwfL+8WJpBrKEuThmS7fK/WqLUmLWJ5SbG+
         exvx2T/uu6bjPhd2UqSKL2fp6wJQ/1gbW5xdAv7HO1VHrmkMDXIpLSe67a1CFN1UFB
         HlC98PmAOchOqVMaiN3rES6BapDYt7W68elSp428=
Date:   Fri, 9 Sep 2022 09:27:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jun Li <jun.li@nxp.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
Message-ID: <Yxrq9wUWa3/WKI3Q@kroah.com>
References: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
 <PA4PR04MB9640CB3CA93301CA1571D85789419@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <3126965.5fSG56mABF@steina-w>
 <PA4PR04MB9640E5CB572980CB087BE9E389409@PA4PR04MB9640.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9640E5CB572980CB087BE9E389409@PA4PR04MB9640.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 09:07:06AM +0000, Jun Li wrote:
> Hi,
> 
> > -----Original Message-----
> > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Sent: Thursday, September 8, 2022 1:50 PM
> > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Shawn Guo <shawnguo@kernel.org>;
> > Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-imx
> > <linux-imx@nxp.com>; Jun Li <jun.li@nxp.com>
> > Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
> > 
> > Hi,
> > 
> > Am Mittwoch, 7. September 2022, 18:08:25 CEST schrieb Jun Li:
> > > Hi
> > >
> > > > -----Original Message-----
> > > > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > Sent: Wednesday, September 7, 2022 10:46 PM
> > > > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> > > > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > > <krzysztof.kozlowski+dt@linaro.org>; Shawn Guo
> > > > <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> > > > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > > > <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Jun Li
> > > > <jun.li@nxp.com>
> > > > Cc: Alexander Stein <alexander.stein@ew.tq-group.com>;
> > > > linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
> > > >
> > > > Hi everybody,
> > > >
> > > > this is a series based on the RFC at [1] for USB host support on
> > > > TQMa8MPxL
> > > > + MBa8MPxL. The main difference is that USB DR support has already
> > > > + been
> > > > added and has been removed from this series.
> > > >
> > > > The DT configuration itself (patch 4) is rather straight forward,
> > > > but leads
> > > >
> > > > to the following dmesg errors regarding superspeed ports:
> > > > > [    8.549243] hub 2-1:1.0: hub_ext_port_status failed (err = -110)
> > > > > [   22.885263] usb 2-1: Failed to suspend device, error -110
> > > >
> > > > This hardware works fine using the downstream kernel, because for
> > > > imx8mp this ITP sync feature is enabled conditionally [2] & [3].
> > > > Hacking this into mainline resulted in a working superspeed setup as
> > well.
> > > > I also noticed that on some android kernel [4] depending in IP core
> > > > version either GCTL.SOFTITPSYNC or GFLADJ.GFLADJ_REFCLK_LPM_SEL is
> > > > enabled unconditionally.
> > > > So I opted for the latter one using some quirk (patch 1-3).
> > > >
> > > > I have to admit I do not know what this is actually about, nor why
> > > > my setup does not work without this change or why this fixed my
> > > > problem. So maybe someone with more knowledge can say if this is the
> > > > way to go or what this is about.
> > >
> > > This can be updated:)
> > >
> > > > I also added snps,dis_u3_susphy_quirk to the board level as for some
> > > > reason USB Superspeed U3 does not work. Detecting the onboard hub
> > > > takes much longer and once all devices are diconnected from the hub
> > > > it is put into runtime suspend (U3) and new attached devices are not
> > > > detected at all.
> > > > Until the cause is known and fixed runtime suspend has to be disabled.
> > >
> > > For this issue you are reporting, I am not sure if this is caused by a
> > > USB clock change merged on v5.19, if you use latest kernel, can you
> > > try with below patches applied to see if U3 can work for you?
> > 
> > Awesome, This does the trick!
> > I was already running with patches [1] & [2], but was missing patch [3].
> > With all of them applied, USB detects a newly attached superspeed device
> > when the HUB is in runtime suspend (U3).
> 
> Yes, patch[3] needs to apply with patches [1]&[2], I am applying the
> same tag to make sure the 3 patches land on the same target release
> as they will go through diff maintainer's trees.

What "tag"?

And I'm confused as to the status of all of these, please resend the
series once you have a new version with the proper acked and reviewed-by
added.

thanks,

greg k-h
