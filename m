Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC127278D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjFHHau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbjFHHas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:30:48 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7894826AC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:30:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so394403e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686209441; x=1688801441;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2IWfjRMKXtAYJWdbpoLM6wscEMkm49OW8tpzuar45To=;
        b=ZaCXG+AYK9XoubTQgCTKf2nRHf7lLi48I1c7N9Tl1pq0ytdsxuYmhLro9CBZxfnwXo
         zWIt+9Xzicpgj6q0FEbc6vPagmXYSqcZVMMOdbSp8/AIT7cIyhnU89DUxYB3L8ekRQ2N
         O8VavVdWcjriLKCALn6IYKn7vhXZN3AwSfb6FM4pR/ji7LcC61AQ3sQrwhVApCZ4j7ax
         jkyVf5ryAfmW22OsG2VAb8dUi1gB1pRIfzBLhuQG2HKp/Y2JfNJfIxagf+oockwW+6iw
         GOJCMWN2TVu5xaZrPHNruk/mLLlqq8Gp6WFcJwFwq1ZSasjqsg5VQD6Dqo9G/B85DPYR
         FyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686209441; x=1688801441;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IWfjRMKXtAYJWdbpoLM6wscEMkm49OW8tpzuar45To=;
        b=iLmoRzFKgDfoIdNKXefDdfy1G+taF/ql4PjRUVpIn0nwMO/dgz2289jFuXFkBIHqzn
         GVm+b66MYCp1//ZMf2eVFL2LMwIBtBPNdz84yANHY6jn1RAH2SWuoxRY8sQDeJFFCOKQ
         5CSGuNZRUu2TDvQkzKHdjTHCXZWuz1ftnTRw3AK0p7tYZundCA99oKWkRuzKbJTntHJo
         xePfjDZvF5H8DlMGpDOC+lesYWstSGJywOxI0drJtG/5CYzst1PwV3wxBRDGyaaVOiO6
         nrsREkZ7NKFd3vxC2EAhmaQnQUGn+BAJcwPkmCN8Nj9AmcDbiSwOQ7BkcqjJldBfEDbc
         MgpQ==
X-Gm-Message-State: AC+VfDxE+xrq8unSUz0w3qjdcCxx1Jq+BCrCjChVOvE67EQBSvkhiJvz
        AyVtZG3LLbB3DK19dCEEf010gA==
X-Google-Smtp-Source: ACHHUZ6IY3k/0igRAxc43HI7Ll38QthT8Wh7k9RTxrOoNxMo98cdVo430gNHE0Pdep8oYW4Yb94CsA==
X-Received: by 2002:a19:f809:0:b0:4f6:3677:54e with SMTP id a9-20020a19f809000000b004f63677054emr2597570lff.36.1686209440730;
        Thu, 08 Jun 2023 00:30:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1b90:b83e:29ce:beb6? ([2a01:e0a:982:cbb0:1b90:b83e:29ce:beb6])
        by smtp.gmail.com with ESMTPSA id q7-20020adff947000000b0030af72bca98sm660713wrr.103.2023.06.08.00.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 00:30:40 -0700 (PDT)
Message-ID: <de71fe1b-870e-fd44-ca20-593d105fc2c1@linaro.org>
Date:   Thu, 8 Jun 2023 09:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: s6d7aa0: remove the unneeded variable in
 s6d7aa0_lock
Content-Language: en-US
To:     Wang Jianzheng <wangjianzheng@vivo.com>,
        Artur Weber <aweber.kernel@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230608033446.18412-1-wangjianzheng@vivo.com>
Organization: Linaro Developer Services
In-Reply-To: <20230608033446.18412-1-wangjianzheng@vivo.com>
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

On 08/06/2023 05:34, Wang Jianzheng wrote:
> Remove unneeded variable and directly return 0.
> 
> Signed-off-by: Wang Jianzheng <wangjianzheng@vivo.com>
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> index 102e1fc7ee38..fec0d014fd0e 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> @@ -66,7 +66,6 @@ static void s6d7aa0_reset(struct s6d7aa0 *ctx)
>   static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
>   {
>   	struct mipi_dsi_device *dsi = ctx->dsi;
> -	int ret = 0;
>   
>   	if (lock) {
>   		mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0xa5, 0xa5);
> @@ -80,7 +79,7 @@ static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
>   			mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0xa5, 0xa5);
>   	}
>   
> -	return ret;
> +	return 0;
>   }
>   
>   static int s6d7aa0_on(struct s6d7aa0 *ctx)

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
