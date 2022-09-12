Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F795B5FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiILSHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiILSGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:06:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9995741983
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:06:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id o2so14014861lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kYN4sSnKsnkXEFWeYDTU7HvcPZgEZ/o2shM14281xec=;
        b=UIQYoaC8p51/CcywfdQZB00kFNr5wACgEmQKBjj6VwI91WaPvwOYgu8e5JY6mbLUT7
         ev3HQVjiMNncyGfjUTPN6ZKKD1eYclE00Wf0ymkPdhBSknRXHAzI4+PJdDF6VYw4qVo+
         ooHegD6DcIMWhri6PnnR9QkKEMzuK6rpOpYeCZN1feOq27CAqA5zGPbJWPlg1E7Cobwg
         LzSiMGfWRk8E8QzpQvNXv74fNVSzugWkyFnMDw0mOhA6ILdCowPjYLGn3Tp+ITJsruiB
         BSlgyJuds7AgR25yS9OJSpex3SIVxKXXLHceATcFzRmT1Jd5UBhts65A7PS58HznEXTB
         5cPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kYN4sSnKsnkXEFWeYDTU7HvcPZgEZ/o2shM14281xec=;
        b=CNS2mQ2BsiKQAGmgrMtnVKU3L0zGK2OFBkEo/2g0FGGcVnQhRXZU5pzIfXc0NUlamx
         aaqlFHccuNKD9NxoEWtVvbeBMK+XhoX7CT8bn0njzvSpUIuNOA0dcKOD+b6QKqEQHTBk
         jTGDAVEmyYWOvfemokRXt/xMhxRjPxDIXAUujFfe6yS+JDG0C3uoiTHBGGuTdIrm3I0W
         pf7SDquFPmyUmrcR2neHGeMIlF96zUUe6RQa0TNA7V5kOnmpKNmTKlVMe8e8ap/5OBwT
         O1p4vO0lg1yiD7Tqt9jLTM5mqfiS/3kbqp08MHQCLnH9vlTgaw3rq1BJpct7MIJFlBVj
         TOMg==
X-Gm-Message-State: ACgBeo2CcmhtKr/FJRbpnHAZZ7+9bTCsUKgz2OdyfPe8tXi5ZWRGQQjR
        +BUyo4X4Y0NdLQ39gQlfNHIPlA==
X-Google-Smtp-Source: AA6agR6cA3jIvYOUKP8VSPHJk6ux8JJLyK8cw7y4HqFQKiFhwUGDtUOZq7UW1ujHaN1ejgyp9zqS3A==
X-Received: by 2002:a05:6512:1056:b0:498:efaf:5bd1 with SMTP id c22-20020a056512105600b00498efaf5bd1mr6964212lfb.64.1663005989237;
        Mon, 12 Sep 2022 11:06:29 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g1-20020a0565123b8100b00492dba3c85asm1195593lfv.220.2022.09.12.11.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 11:06:28 -0700 (PDT)
Message-ID: <39cbf0cb-9f25-6a0d-6e56-3f9e0aaa0296@linaro.org>
Date:   Mon, 12 Sep 2022 21:06:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 7/7] drm/msm: drop modeset sanity checks
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220912154046.12900-1-johan+linaro@kernel.org>
 <20220912154046.12900-8-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220912154046.12900-8-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2022 18:40, Johan Hovold wrote:
> Drop the overly defensive modeset sanity checks of function parameters
> which have already been checked or used by the callers.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Again, please split into dp and dsi patches. After that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 7 +------
>   drivers/gpu/drm/msm/dsi/dsi.c       | 7 +------
>   2 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 393af1ea9ed8..8ad28bf81abe 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1597,15 +1597,10 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
>   int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
>   			struct drm_encoder *encoder)
>   {
> -	struct msm_drm_private *priv;
> +	struct msm_drm_private *priv = dev->dev_private;
>   	struct dp_display_private *dp_priv;
>   	int ret;
>   
> -	if (WARN_ON(!encoder) || WARN_ON(!dp_display) || WARN_ON(!dev))
> -		return -EINVAL;
> -
> -	priv = dev->dev_private;
> -
>   	if (priv->num_bridges == ARRAY_SIZE(priv->bridges)) {
>   		DRM_DEV_ERROR(dev->dev, "too many bridges\n");
>   		return -ENOSPC;
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
> index 8a95c744972a..31fdee2052be 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
> @@ -211,14 +211,9 @@ void __exit msm_dsi_unregister(void)
>   int msm_dsi_modeset_init(struct msm_dsi *msm_dsi, struct drm_device *dev,
>   			 struct drm_encoder *encoder)
>   {
> -	struct msm_drm_private *priv;
> +	struct msm_drm_private *priv = dev->dev_private;
>   	int ret;
>   
> -	if (WARN_ON(!encoder) || WARN_ON(!msm_dsi) || WARN_ON(!dev))
> -		return -EINVAL;
> -
> -	priv = dev->dev_private;
> -
>   	if (priv->num_bridges == ARRAY_SIZE(priv->bridges)) {
>   		DRM_DEV_ERROR(dev->dev, "too many bridges\n");
>   		return -ENOSPC;

-- 
With best wishes
Dmitry

