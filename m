Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F2F74ABEC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjGGH2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjGGH1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:27:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0711FCE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:27:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso17128935e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 00:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688714869; x=1691306869;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mfGfzIB+RcA72dyodym3yq746uqRLSsXTKVVkcw8AD8=;
        b=G0luk0upz8DSdbX6QT6rROaZMATKsr9FAmewd7D9/BT72cYJnx6Xt/yPD4ZcZr+bHv
         ikZ9fZZQGnAxx/hgxxD9DXEhaAAcNmwtkd5XKQaKQDxvWuxTVjsw4qe+FvQSb7A76ZeR
         JSrbS2GWudguU+JqiMNsd9Q7Tejsm7Cl9gV0FXqU/plqaXIXNNs76HPqJYxXQ3peHtsU
         h+53sCYRocwqAz8CGygdBNzoFghJtDzRoN1Vm+r+xAQfsEpBMNyf9ZWOqGxs39vCod4q
         XJnlgr4gxZRtHIJEiM3sewMnZAwZGhlndBy/8JHcVhm0u5n7Y91xfIrsmbPB1KIhrq3c
         O5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688714869; x=1691306869;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfGfzIB+RcA72dyodym3yq746uqRLSsXTKVVkcw8AD8=;
        b=KnwcJIlIXJHBfe7v+jeuiO7eq6j9++Z5fdh68uZby0Q8XfPkhOk3rNxVF/UCqPJKLs
         roL3QH4SaOsRVRHUAyAWSY0cDTjcnXfmd1K5yMyCZ+R7I3/5h0GslD3Xprv6PSZIRZ3F
         qWhDL9dsLpGhIS/y404LK5EyqZU41iaBzZUVN9pGu95OLgb2PdwWDlsUDfe6kJw1sEi3
         PVuO0ZDsLdHc49MNdbwjcH37HYiATHFbHTRNRk3+oY+A3DeQNDr5sRxsgau2/aq2RwzP
         UQUogq9ZN9u30zBwzPo+gGomdG6kmO2ddu3JHiJRDdIce1UBkakNdkntNMEAeH8w5kLq
         +zmA==
X-Gm-Message-State: ABy/qLawKjEO9iPoaUtPkbd/bg72Lo039kT+ZAwJLACKh/x2MpeKXGGY
        ePnXpG5fTIj94WPY4vByKKtuOQ==
X-Google-Smtp-Source: APBJJlE1Lp8Td/p603T/IB8hb6xWItINAd4yu2c/zsIWdZt1qXYK9Z1W/EalIOZfv5OMAfcOKI6MDw==
X-Received: by 2002:a05:6000:4ec:b0:314:1483:d8ad with SMTP id cr12-20020a05600004ec00b003141483d8admr3314256wrb.44.1688714869253;
        Fri, 07 Jul 2023 00:27:49 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id g7-20020adff3c7000000b00313e59cb371sm3736792wrp.12.2023.07.07.00.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 00:27:48 -0700 (PDT)
Message-ID: <3c0ff63e-a35d-60b6-38aa-178219e65cbd@linaro.org>
Date:   Fri, 7 Jul 2023 09:27:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 07/18] drm/bridge: analogix_dp: Convert to
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230707072034.48977-1-frank.li@vivo.com>
 <20230707072034.48977-7-frank.li@vivo.com>
Organization: Linaro Developer Services
In-Reply-To: <20230707072034.48977-7-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2023 09:20, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index df9370e0ff23..c6b228f1ed4c 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1686,7 +1686,6 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
>   {
>   	struct platform_device *pdev = to_platform_device(dev);
>   	struct analogix_dp_device *dp;
> -	struct resource *res;
>   	unsigned int irq_flags;
>   	int ret;
>   
> @@ -1740,9 +1739,7 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
>   
>   	clk_prepare_enable(dp->clock);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> -	dp->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	dp->reg_base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(dp->reg_base)) {
>   		ret = PTR_ERR(dp->reg_base);
>   		goto err_disable_clk;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
