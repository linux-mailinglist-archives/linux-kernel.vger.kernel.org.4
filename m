Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A406EC7D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjDXIZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXIZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:25:20 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D035E6F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:25:13 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230424082511euoutp021fd53e8fb5148c12106ae042fda04e94~Y0WlMtSKT2678126781euoutp02L
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:25:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230424082511euoutp021fd53e8fb5148c12106ae042fda04e94~Y0WlMtSKT2678126781euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682324711;
        bh=a8mRBFCihAlbJxSTGq0qF9HfVNE/vS02KdPCxCIpeQY=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=iN8YTAvxo8evczlFYM7kEHf0UT2qXx4Vl3OyWaMePMc3xf0O7AZwTRMTj6muCL2g7
         4TbLkpNxtp9ObKm27P4dueJg/dreUaDXV20ypguZg8+0IfS/o4M3Y+5MzO3HVSg+pr
         Lz81tJfNRyWym66eChBxk3heYsTGVycm+FmtyEVw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230424082510eucas1p269bb33932383921e38366c0ed9fcbba7~Y0Wk2Mofb0729107291eucas1p2K;
        Mon, 24 Apr 2023 08:25:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AB.E8.09966.6EC36446; Mon, 24
        Apr 2023 09:25:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230424082510eucas1p2baee575b3d6671741dbe35aea271e6ea~Y0WkVMeT00729107291eucas1p2I;
        Mon, 24 Apr 2023 08:25:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230424082510eusmtrp1ddb02fcd7ba2696a61d74ca1ad1f38b0~Y0WkUU9n_2899528995eusmtrp1s;
        Mon, 24 Apr 2023 08:25:10 +0000 (GMT)
X-AuditID: cbfec7f4-d4fff700000026ee-f1-64463ce6962c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 16.14.22108.5EC36446; Mon, 24
        Apr 2023 09:25:09 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230424082509eusmtip2a8bd4c7374ac2d6146376c5daa9b223d~Y0WjWkFrh2112821128eusmtip2j;
        Mon, 24 Apr 2023 08:25:08 +0000 (GMT)
Message-ID: <b6b53da5-6986-a958-ef84-650b3a57ad9c@samsung.com>
Date:   Mon, 24 Apr 2023 10:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH V2 5/6] drm: bridge: samsung-dsim: Support non-burst
 mode
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, dario.binacchi@amarulasolutions.com,
        l.stach@pengutronix.de, Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230423121232.1345909-6-aford173@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZduznOd1nNm4pBqt2ylrcuX2a2WL31W52
        ixPXFzFZ3F/8mcXi/7aJzBYTd8xms7jy9T2bRe/Sc6wWk+5PYLH4smkCm8Xz+esYLU6+ucpi
        8WDuTSaLzolL2C0u75rDZvGmrZHR4v3OW4wWk+bdZHUQ8lj78T6rx8vlDcwe82adYPHY+20B
        i8fOWXfZPWZ3zGT1WLznJZPHplWdbB5Hri5m9Tgx4RKTx51re9g87ncfZ/Lo/2vg0bdlFaPH
        501yAfxRXDYpqTmZZalF+nYJXBl7X3WxFJwUrZh39zVzA+M6wS5GDg4JAROJw3ssuxi5OIQE
        VjBKfL85nQXC+cIoceH+bXYI5zOjxL9D+4EynGAdu8/sZ4VILGeUuHnyMxOE85FRYtH7J0wg
        VbwCdhKTnx1kBLFZBFQlzjzpY4WIC0qcnPkEbJKoQKpE0+w37CC2sIC/xLVLq8BsZgFxiVtP
        5oPNERFwljj59xvYAmaBGywSB94eBCtiEzCU6HrbxQZicwpYSVx/cgSqWV5i+9s5zCANEgLf
        OCXaJzxmgrjbRWLZqUmMELawxKvjW9ghbBmJ05N7WCAa2hklFvy+zwThTGCUaHh+C6rDWuLO
        uV9soDBjFtCUWL9LHyLsKHFm6WRmSFDySdx4KwhxBJ/EpG3TocK8Eh1tQhDVahKzjq+DW3vw
        wiXmCYxKs5DCZRaS/2cheWcWwt4FjCyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAtPq
        6X/Hv+xgXP7qo94hRiYOxkOMEhzMSiK8HqVOKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5tW1P
        JgsJpCeWpGanphakFsFkmTg4pRqYVlZPnVQz9YaRwd+1AXXLqxlMmjXmPF8yn68twrpqupjg
        uVeWfdUlJ7mZ3nnfOSya5G1gz3u98ZCHAH9H3tS4uesk/DeHmToG8ekbNnOFqc7Z5rKvPl2i
        S2/zx7hX4du2RZ+4d6/TyHSbUfBjAU2ZaTkpBj5JmlPfuojkKTAqvF2epflC6tjnC2oVc6+u
        eR2X3Fk2SzvAtYklhFPX+VK3iH2Ad8Bdk4UyPGdmtXes2FohLrwlrVjpwHPeGb6czYo6u7T6
        Wtez3V0ifL4844i/2M4QN9FGVqdrM1ewd9YHrWn/qdE5pUV0+RbJyX/vhDJM2/Vf4Cp7qA9H
        vAl3c0zmiSbhw6kChznv7on7p8RSnJFoqMVcVJwIAPy2En4aBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsVy+t/xe7pPbdxSDOYdtbG4c/s0s8Xuq93s
        FieuL2KyuL/4M4vF/20TmS0m7pjNZnHl63s2i96l51gtJt2fwGLxZdMENovn89cxWpx8c5XF
        4sHcm0wWnROXsFtc3jWHzeJNWyOjxfudtxgtJs27yeog5LH2431Wj5fLG5g95s06weKx99sC
        Fo+ds+6ye8zumMnqsXjPSyaPTas62TyOXF3M6nFiwiUmjzvX9rB53O8+zuTR/9fAo2/LKkaP
        z5vkAvij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S
        9DL2vupiKTgpWjHv7mvmBsZ1gl2MnBwSAiYSu8/sZ+1i5OIQEljKKPFyfTMjREJG4uS0BlYI
        W1jiz7UuNoii94wS+3/vZwFJ8ArYSUx+dhCsgUVAVeLMkz5WiLigxMmZT8BqRAVSJW7s+cMG
        YgsL+Eqcm9MAVs8sIC5x68l8JhBbRMBZ4uTfb0wgC5gFbrFIPD5/nhli215GiUuvP4J1sAkY
        SnS97QKbxClgJXH9yRF2iElmEl1bu6CmyktsfzuHeQKj0Cwkh8xCsnAWkpZZSFoWMLKsYhRJ
        LS3OTc8tNtQrTswtLs1L10vOz93ECEwk24793LyDcd6rj3qHGJk4GA8xSnAwK4nwepQ6pQjx
        piRWVqUW5ccXleakFh9iNAWGxkRmKdHkfGAqyyuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhP
        LEnNTk0tSC2C6WPi4JRqYFI1sd9462Ky8FYVpZAl29mOnPt58miMYserHg3vawGSKnr3b2Ty
        G/xLVGlIWvi9RSFhqo7lpL18e5NmOykk9NuffcDmkDfta7Gy0lxjxsnvOphf9y945aJg8ChW
        rPRenJ/Glp+Pq1LDL6tNOmLMHmP2YeGXWXeqOJsvi7w69FRW1zlje5C+n5vZhjUvdAR3yF38
        FN4Zl/y4Zd1emdlGcSlOKwwPsC4/pWZ46in/3wVc1cu3G9StrJXf+2Pbnml35DlFs+SfX26P
        L+VZEGOR4JTzxNvibKPSL8X0uVuDW+46FCzKkHzI9sbn8tng9YmXHBzNdNgqGF1e3Ir4HM2k
        vVL98y75G475Vme0F126oMRSnJFoqMVcVJwIAPGas+mtAwAA
X-CMS-MailID: 20230424082510eucas1p2baee575b3d6671741dbe35aea271e6ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230423121305eucas1p287a952d41b1884b117fa15a748b9e1a2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230423121305eucas1p287a952d41b1884b117fa15a748b9e1a2
References: <20230423121232.1345909-1-aford173@gmail.com>
        <CGME20230423121305eucas1p287a952d41b1884b117fa15a748b9e1a2@eucas1p2.samsung.com>
        <20230423121232.1345909-6-aford173@gmail.com>
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.04.2023 14:12, Adam Ford wrote:
> The high-speed clock is hard-coded to the burst-clock
> frequency specified in the device tree.  However, when
> using devices like certain bridge chips without burst mode
> and varying resolutions and refresh rates, it may be
> necessary to set the high-speed clock dynamically based
> on the desired pixel clock for the connected device.
>
> This also removes the need to set a clock speed from
> the device tree for non-burst mode operation, since the
> pixel clock rate is the rate requested from the attached
> device like an HDMI bridge chip.  This should have no
> impact for people using burst-mode and setting the burst
> clock rate is still required for those users.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

This one breaks Exynos-5433 based TM2e board with a DSI panel.

> ---
>   drivers/gpu/drm/bridge/samsung-dsim.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index f165483d5044..cea847b8e23c 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -657,11 +657,21 @@ static unsigned long samsung_dsim_set_pll(struct samsung_dsim *dsi,
>   
>   static int samsung_dsim_enable_clock(struct samsung_dsim *dsi)
>   {
> -	unsigned long hs_clk, byte_clk, esc_clk;
> +	unsigned long hs_clk, byte_clk, esc_clk, pix_clk;
>   	unsigned long esc_div;
>   	u32 reg;
> +	struct drm_display_mode *m = &dsi->mode;
> +	int bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
> +
> +	/* m->clock is in KHz */
> +	pix_clk = m->clock * 1000;
> +
> +	/* Use burst_clk_rate for burst mode, otherwise use the pix_clk */
> +	if ((dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) && dsi->burst_clk_rate)
> +		hs_clk = samsung_dsim_set_pll(dsi, dsi->burst_clk_rate);
> +	else
> +		hs_clk = samsung_dsim_set_pll(dsi, DIV_ROUND_UP(pix_clk * bpp, dsi->lanes));
>   
> -	hs_clk = samsung_dsim_set_pll(dsi, dsi->burst_clk_rate);
>   	if (!hs_clk) {
>   		dev_err(dsi->dev, "failed to configure DSI PLL\n");
>   		return -EFAULT;
> @@ -1800,10 +1810,11 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
>   			return PTR_ERR(pll_clk);
>   	}
>   
> +	/* If it doesn't exist, use pixel clock instead of failing */
>   	ret = samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequency",
>   				       &dsi->burst_clk_rate);
>   	if (ret < 0)
> -		return ret;
> +		dsi->burst_clk_rate = 0;
>   
>   	ret = samsung_dsim_of_read_u32(node, "samsung,esc-clock-frequency",
>   				       &dsi->esc_clk_rate);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

