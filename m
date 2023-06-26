Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D5E73E0D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjFZNif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjFZNic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:38:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F202B1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:38:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f86fbe5e4fso4082294e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687786709; x=1690378709;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XCRpr4Gn4c355LF3VbDoLS++0IHVvVI8q7hRDfXr51g=;
        b=jNNBFaGqCW6Nojl+/WSsfBEcUQBBOwpSKxcbC1ey7zkIpFa7rqbBDsgj1e/4w+bnwM
         dOjwSCSUHDvMGjbsOcMsVT+JyThMhkAiEnrwwRlscOIHQe+k66M/6yjecnJiWvdtqfPb
         CRolHfWa6O0XPUfShc+wa+pnsMYExyhWpVftQDLj0x+YbFNZY8hTXM8JGk1L0DkptPGL
         IpVVc6Usb3uh4ANGdgjnsc7dNfDFlI8xMExGee0evKbvx230h1gz2U1AwPup8MBQouuV
         N+tvUXRaXUzLGoMNMLl3AgwSQo/UVfRv21uKLoG598iNdGl3owsEnw3gL5Xk1flPi8hg
         0j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687786709; x=1690378709;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCRpr4Gn4c355LF3VbDoLS++0IHVvVI8q7hRDfXr51g=;
        b=J7KW8mU/dXBM+P+x/UBqEWa0s7nOJEVWYi7TRz2MrBcZ1ZvQ2sehRzi8OYyVNFNBCJ
         QhTa5JQ2lcfe/26V1bK0zS7+Mdl1NngCVww2c7mns/TVibdGM5lLM90zJsesat2YrA6u
         1rLvRxzXCfpN3Z+tvJmYOSkPsnD7M2wQa260Wrk8i9SnKL9/xMo6DmEniPsud5L8TKb7
         9dFT5KDIOEyHHYl2BYZ40gpLUeHwefknuAKZctNdkiDuRtS/v4kfHFK2YC1Kk3fcn51+
         pwD4Nvzygha9qiSMUpcbTNCt804Cw52wulSxZY/8ucs1NC4hYR64f8LCHqY5t+Q7e5QI
         XCkA==
X-Gm-Message-State: AC+VfDyjB7enTTL0mkAK2waUB3YpnLyrXzulzODLZaPC5EzZq9MZZQ8Y
        XUg4jFH2YXnMr1vbdjwvXpQ+GA==
X-Google-Smtp-Source: ACHHUZ6jy6WM6eFMu2q0Ug4BCB/4+Jk6RV0d5rm4frwryvckqO1X/NAdW9tzKf3BfxUm6yWvElxzLw==
X-Received: by 2002:a19:8c49:0:b0:4f8:5e3c:f3a7 with SMTP id i9-20020a198c49000000b004f85e3cf3a7mr14695992lfj.43.1687786709251;
        Mon, 26 Jun 2023 06:38:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b25a:b26e:71f3:870c? ([2a01:e0a:982:cbb0:b25a:b26e:71f3:870c])
        by smtp.gmail.com with ESMTPSA id l1-20020a1ced01000000b003f9b0830107sm10726315wmh.41.2023.06.26.06.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:38:28 -0700 (PDT)
Message-ID: <5c3bcc62-28ba-e88f-6a19-4f620489284a@linaro.org>
Date:   Mon, 26 Jun 2023 15:38:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: Fine tune Starry-ili9882t panel HFP and HBP
Content-Language: en-US
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        sam@ravnborg.org, daniel@ffwll.ch, airlied@gmail.com,
        dianders@google.com, hsinyi@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230626120724.161117-1-yangcong5@huaqin.corp-partner.google.com>
Organization: Linaro Developer Services
In-Reply-To: <20230626120724.161117-1-yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/06/2023 14:07, Cong Yang wrote:
> Because the setting of hproch is too small, there will be warning in
> kernel log[1]. After fine tune the HFP and HBP, this warning can be
> solved. The actual measurement frame rate is 60.1Hz.
> 
> [1]: WARNING kernel:[drm] HFP + HBP less than d-phy, FPS will under 60Hz
> 
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>   drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index 3cc9fb0d4f5d..dc276c346fd1 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -2139,9 +2139,9 @@ static const struct panel_desc starry_himax83102_j02_desc = {
>   static const struct drm_display_mode starry_ili9882t_default_mode = {
>   	.clock = 165280,
>   	.hdisplay = 1200,
> -	.hsync_start = 1200 + 32,
> -	.hsync_end = 1200 + 32 + 30,
> -	.htotal = 1200 + 32 + 30 + 32,
> +	.hsync_start = 1200 + 72,
> +	.hsync_end = 1200 + 72 + 30,
> +	.htotal = 1200 + 72 + 30 + 72,
>   	.vdisplay = 1920,
>   	.vsync_start = 1920 + 68,
>   	.vsync_end = 1920 + 68 + 2,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

but can you resend with a appropriate Fixes tag ?

thanks,
Neil
