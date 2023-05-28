Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16E87140EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 00:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjE1WBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 18:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE1WBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 18:01:10 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79701B1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 15:01:05 -0700 (PDT)
Date:   Sun, 28 May 2023 22:00:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1685311263; x=1685570463;
        bh=kwQFJjiwN8twYz8De04hRwMEmGC/2PFsVzynq91D79U=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=F/cTeYLBdhPu3Va3xDShJgxFvuy0fBNfgarvf5EVEnkyxkudW4susNCI4Ujn7aJf7
         9mEKOtymlS7YixdWIXlx+rCB4B2p0Vv5ZR0ki6KS+3qL6HVGopwwmM1TAYukqdIH5T
         Prk+H0dwpO592WPdDfIj0W7LSOg/Pc3x2ymODBUk=
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH RFC 01/10] drm/panel: Clean up SOFEF00 config dependencies
Message-ID: <fca259bd-5047-06bf-2c66-21acc92d22a7@connolly.tech>
In-Reply-To: <20230521-drm-panels-sony-v1-1-541c341d6bee@somainline.org>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org> <20230521-drm-panels-sony-v1-1-541c341d6bee@somainline.org>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/05/2023 22:23, Marijn Suijten wrote:
> As per the config name this Display IC features a DSI command-mode
> interface (or the command to switch to video mode is not
> known/documented) and does not use any of the video-mode helper
> utilities, hence should not select VIDEOMODE_HELPERS.  In addition it
> uses devm_gpiod_get() and related functions from GPIOLIB.
>=20
> Fixes: 5933baa36e26 ("drm/panel/samsung-sofef00: Add panel for OnePlus 6/=
T devices")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  drivers/gpu/drm/panel/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfi=
g
> index 2b9d6db7860ba..67ef898d133f2 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -608,10 +608,10 @@ config DRM_PANEL_SAMSUNG_S6E8AA0
>=20
>  config DRM_PANEL_SAMSUNG_SOFEF00
>  =09tristate "Samsung sofef00/s6e3fc2x01 OnePlus 6/6T DSI cmd mode panels=
"
> +=09depends on GPIOLIB
>  =09depends on OF
>  =09depends on DRM_MIPI_DSI
>  =09depends on BACKLIGHT_CLASS_DEVICE
> -=09select VIDEOMODE_HELPERS
>  =09help
>  =09  Say Y or M here if you want to enable support for the Samsung AMOLE=
D
>  =09  command mode panels found in the OnePlus 6/6T smartphones.
>=20
> --
> 2.40.1
>=20

--=20
Kind Regards,
Caleb

