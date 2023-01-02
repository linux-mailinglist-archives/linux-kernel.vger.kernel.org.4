Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A833765AE15
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjABI1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjABI1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:27:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409F6223
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:27:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDDDE60ECE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3885FC433D2;
        Mon,  2 Jan 2023 08:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672648027;
        bh=xdXxYKAZd6QpjVcR1FSXry2pfitKPL1S0xMqTVjvgYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9rZjoqEY/mWaZlK+30DxUhWhMtOstiVyX0Tt8wR9hx0C5EO+MULPikbUf7JSdTLG
         H6uTjLaxtJvyzXKpteYoK/F64XQgP+w98BFmm6ubbbXjGr2hit3tNmw+17pB0uF6Ru
         q8BwtYTAeDy4Vo90x+eHJhctCxRHZ00ghXbBxUDTyuFwhGCxM9PBhXVeyryzxDUmlA
         c7yVwp59BoYgqGimQp26Iiig/ABaYN8DOxhflbTmjW4PYG6Fxjnwskg1Q0vG2C7sgw
         PpqyG70aLK/DeGrkHC/Bbj2xfjYZ33tjt2R8+cUanxHwbkghms+kRyF/Q7g2vw/W9v
         9pkBH1onRaXXw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCGAE-0003LC-SU; Mon, 02 Jan 2023 09:27:23 +0100
Date:   Mon, 2 Jan 2023 09:27:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steev Klimaszewski <steev@kali.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel-edp: add IVO M133NW4J panel entry
Message-ID: <Y7KVamauvz44UB/o@hovoldconsulting.com>
References: <20221231142721.338643-1-abel.vesa@linaro.org>
 <20221231142721.338643-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231142721.338643-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 04:27:21PM +0200, Abel Vesa wrote:
> Add an eDP panel entry for IVO M133NW4J.
> 
> Due to lack of documentation, use the delay_200_500_p2e100 timings like
> some other IVO entries for now.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Assuming the information from here is correct:
> https://raw.githubusercontent.com/linuxhw/EDID/master/DigitalDisplay.md
 
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index ef70928c3ccb..bef5cdf6a582 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1891,6 +1891,7 @@ static const struct edp_panel_entry edp_panels[] = {
>  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
>  
>  	EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140NWF5 RH"),
> +	EDP_PANEL_ENTRY('I', 'V', 'O', 0x854a, &delay_200_500_p2e100, "M133NW4J"),
>  	EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "R133NW4K-R0"),
>  
>  	EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),

Can you also check the edid data for the string in case there's been
some mixup? For example,

	# strings /sys/class/drm/card0-eDP-1/edid
	...
	B133UAN02.1

Johan
