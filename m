Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FABD65AE0D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjABIWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjABIWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:22:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0242194
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:21:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E708160CF1
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56077C433EF;
        Mon,  2 Jan 2023 08:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672647685;
        bh=1HJXtNHoGYBgH5Cwu2Oaw2kyPpvyq8RxKQUgogrOkj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j87z6cUH7m99vtmmxYCnBHwlRNIli7v5BNJoc7FJPSXXTc/8lC5FPlYgTadzBG0/V
         nTyRoHnLnpepF6mUZYSU2dZe2Sny3oJx0RGQrGbLMCj/t+2JC3kuV0abGGviN8C2o6
         J8d2NlrpOtQMeIjZ1IzGZi/zTXut0nTb1iSLt2s+u5y5eVamhwGUFZtSslEV994gUk
         hNikSOIw/uUqvE55sdHYvjuqIHiK84F29z1a9htgn6DE/FQZDn9KBUf3hVSShlkSbx
         DKWvusguCnJRdPSp/GfQXOTFtrFxTUsA4dErKHd6LsRNJ7r7slCzwp0ou6JfcwgIam
         kD23ZjY5BR2pQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCG4i-0003G9-TH; Mon, 02 Jan 2023 09:21:41 +0100
Date:   Mon, 2 Jan 2023 09:21:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/panel-edp: fix name for IVO product id 854b
Message-ID: <Y7KUFMjnra22YGlv@hovoldconsulting.com>
References: <20221231142721.338643-1-abel.vesa@linaro.org>
 <CAKXuJqjiEpxnX_E=HGqEaX91YA7XUmUoaK0NQqXHJCUkcqUPoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXuJqjiEpxnX_E=HGqEaX91YA7XUmUoaK0NQqXHJCUkcqUPoQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2023 at 10:58:42PM -0600, Steev Klimaszewski wrote:
> On Sat, Dec 31, 2022 at 8:27 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > The actual name is R133NW4K-R0.
> >
> > Fixes: 0f9fa5f58c784 ("drm/panel-edp: add IVO M133NW4J-R3 panel entry")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >
> > Assuming the information from here is correct:
> > https://raw.githubusercontent.com/linuxhw/EDID/master/DigitalDisplay.md
> >
> >  drivers/gpu/drm/panel/panel-edp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > index 5cb8dc2ebe18..ef70928c3ccb 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -1891,7 +1891,7 @@ static const struct edp_panel_entry edp_panels[] = {
> >         EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
> >
> >         EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140NWF5 RH"),
> > -       EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "M133NW4J-R3"),
> > +       EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "R133NW4K-R0"),
> >
> >         EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
> >         EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
> > --
> > 2.34.1
> >
> 
> Thanks for this - when I was looking for the panel, I simply went with
> what I found on panel-look.

Did you check what string your panel reports? For example, using
something like:

	# strings /sys/class/drm/card0-eDP-1/edid
	...
	B133UAN02.1

Johan
