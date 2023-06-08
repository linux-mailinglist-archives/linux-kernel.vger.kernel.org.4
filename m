Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC59727C62
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjFHKKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjFHKKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:10:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6CE1FF3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:10:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51494659d49so691405a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 03:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686219042; x=1688811042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJHTuCsEoea12NU1L8aVFWLw5Li+6FBeT87B7EVpk0U=;
        b=hshqQqKhS2lrmEIPaTGyfZ0xo1tLzW5OuF36pfweYlvn/pcwF7jYRNq04H9+23ssfm
         RHApcs/x6bZKx+JK7r1hNNiJiWudXij6IcS2L07dzs7mIp0A9mVK5un82ZKJc2mIR/5z
         LgRV2/FPPkb1hD8S9rzv52rP2t8mM/xxJRIGehiuzgJUM8qZTzKDuN8i97wzJyAThMq7
         e4vzsbtH4sJDQOn8bSMYf2+p1iO5ZwjG6w3X6jGkGZv/DpUd+CN6v9WGIpJPCNmmnWOL
         Ot6ITR0eDAOJsmV2YJtHjmXk4jidDYlPiThY4LyRWb3eAWj5EZAa8s3Et8u3J8YihxRS
         csaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686219042; x=1688811042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJHTuCsEoea12NU1L8aVFWLw5Li+6FBeT87B7EVpk0U=;
        b=LLibCzTDvHl2NQdTGUjgNIFkxRz0dvLl9Qa7ObF0/50aLOrqEhe2E2RDawQAwfjC4D
         4QOjtzgXaKc8L1tlbC4iKxwzBp0JwgiXiSjFadDv2VTzCByKTsSYqJPiawUUUY0e+Kig
         PpqVoNM2qTKfO2zQK9/lRFZP4BC3tRYUTOA4qSaBvLvHns+wzxR0FSD32puDfh5/VIJI
         ryc0kXdQfJlUyzLfF8rEzPzd52TS0z0sNyLiEhCMLm7+p66WZr5TJpuR/RjKl5OIwpKY
         ZjsCjDMOhar2FV+ZPePkev3Xh2sXs3z4P6hm53RDKouhxj7rNfzlGYBcWvA455ffZRC9
         aPyQ==
X-Gm-Message-State: AC+VfDzm7rwH5WyBNKNZMleH9JLKYXQeqId1NWTYbotODPcccRHd2tN/
        Oc1bmSZ/z6feKERolsM8wZ8=
X-Google-Smtp-Source: ACHHUZ5coC8s5m6rUE7HiOKz4pn6a1g+ifnOsD3nW3M/0KYXh9LRR4CX9KrILx/+g+W2KioYH5DzpA==
X-Received: by 2002:a17:907:60cc:b0:96f:136e:eadd with SMTP id hv12-20020a17090760cc00b0096f136eeaddmr9129019ejc.66.1686219041847;
        Thu, 08 Jun 2023 03:10:41 -0700 (PDT)
Received: from [192.168.50.244] (83.8.122.24.ipv4.supernova.orange.pl. [83.8.122.24])
        by smtp.gmail.com with ESMTPSA id n26-20020a1709065e1a00b00978897577c6sm488863eju.44.2023.06.08.03.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:10:41 -0700 (PDT)
Message-ID: <5d96d7a6-3f91-0464-17c4-29125ef76bd5@gmail.com>
Date:   Thu, 8 Jun 2023 12:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] drm/panel: s6d7aa0: remove the unneeded variable in
 s6d7aa0_lock
Content-Language: en-US
To:     Wang Jianzheng <wangjianzheng@vivo.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230608033446.18412-1-wangjianzheng@vivo.com>
From:   Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20230608033446.18412-1-wangjianzheng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
>  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> index 102e1fc7ee38..fec0d014fd0e 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> @@ -66,7 +66,6 @@ static void s6d7aa0_reset(struct s6d7aa0 *ctx)
>  static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
>  {
>  	struct mipi_dsi_device *dsi = ctx->dsi;
> -	int ret = 0;
>  
>  	if (lock) {
>  		mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0xa5, 0xa5);
> @@ -80,7 +79,7 @@ static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
>  			mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0xa5, 0xa5);
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int s6d7aa0_on(struct s6d7aa0 *ctx)

Reviewed-by: Artur Weber <aweber.kernel@gmail.com>

Best regards
Artur
