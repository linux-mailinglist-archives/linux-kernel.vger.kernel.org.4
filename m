Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8729A66B343
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 18:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjAORmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 12:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjAORl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 12:41:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B59A113D5;
        Sun, 15 Jan 2023 09:41:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1877560DB6;
        Sun, 15 Jan 2023 17:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642BAC433D2;
        Sun, 15 Jan 2023 17:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673804504;
        bh=ok2GpqvsbxT2ZfL/AmAdt1BO0nq0vW1Jn+mHxtduKxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SV/snAwAwpxL8EzMHAr1Z4GCQ20dBOxw6Ccz03/HaOz7qS7AjJgsFuyAi+Pk4oHZR
         EndTE69vmf2MNHN29wRzjxrjg42l0MRsHubXlyZ/IBIsc6CRjat02w1XVXohC7EzNT
         N9HQO9FGViFcbdswl7MwRqTnbYvawq1bNJwwNOsqgX/9ITJqkDpoUJPxVIeWkXHuan
         fm0LZMLtiztLC5hCelPmVDtq4iI3W329SuWs2DWlJNfFe48JI/suI7Q6GbtYFB1vPs
         n30njjOx8x+Afsaiwv0Hk5ZK8QdKUeH2QDyd0tK13OUFdb/1KO3AcwM99GXoiBRffd
         NynT1SmBAT7qA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pH716-0002oh-3j; Sun, 15 Jan 2023 18:42:00 +0100
Date:   Sun, 15 Jan 2023 18:42:00 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Daniele Palmas <dnlplm@gmail.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable Qualcomm PCIe modem drivers
Message-ID: <Y8Q66ClSIcww0GWq@hovoldconsulting.com>
References: <20230114162236.22615-1-johan+linaro@kernel.org>
 <CAGRyCJHcbc3kad=8ugpo+hF9TGQZv2akzrYXa175HwCM7kVb9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRyCJHcbc3kad=8ugpo+hF9TGQZv2akzrYXa175HwCM7kVb9w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 01:11:08PM +0100, Daniele Palmas wrote:
> Hello Johan,
> 
> Il giorno sab 14 gen 2023 alle ore 17:23 Johan Hovold
> <johan+linaro@kernel.org> ha scritto:
> >
> > Enable the MHI PCI controller driver and MHI WWAN drivers for Qualcomm
> > based PCIe modems such as the ones found on the SC8280XP Compute
> > Reference Design (CRD) and Lenovo Thinkpad X13s.
> >
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---

> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 86aa3730a8b6..117b49f3f1c1 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -250,6 +250,7 @@ CONFIG_DEVTMPFS_MOUNT=y
> >  CONFIG_FW_LOADER_USER_HELPER=y
> >  CONFIG_HISILICON_LPC=y
> >  CONFIG_TEGRA_ACONNECT=m
> > +CONFIG_MHI_BUS_PCI_GENERIC=m
> >  CONFIG_ARM_SCMI_PROTOCOL=y
> >  CONFIG_ARM_SCPI_PROTOCOL=y
> >  CONFIG_RASPBERRYPI_FIRMWARE=y
> > @@ -405,6 +406,9 @@ CONFIG_MWIFIEX_SDIO=m
> >  CONFIG_MWIFIEX_PCIE=m
> >  CONFIG_WL18XX=m
> >  CONFIG_WLCORE_SDIO=m
> > +CONFIG_WWAN=m
> > +CONFIG_MHI_WWAN_CTRL=m
> > +CONFIG_MHI_WWAN_MBIM=m
> 
> wondering if it could make sense to also enable CONFIG_MHI_NET, since
> in mhi_pci_generic there are also modems bound to that driver and, if
> not enabled, those would show just the control device, but not the
> netdevice.

Yes, indeed, that's a good idea. I had it enabled in my local config but
didn't include it as it isn't needed for the two machines I'm currently
working on.

I'll send a v2. Thanks!

Johan
