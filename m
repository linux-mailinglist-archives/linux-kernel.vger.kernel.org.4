Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C728E7203A8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjFBNpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjFBNpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:45:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465F0136
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:45:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30ae61354fbso1947009f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685713534; x=1688305534;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gF49zRdU5uYPaFJUudEu7rAmB8Wh16UloOD04JQ8NIs=;
        b=RVJEO2eVuCuiL1511OFZBGs54XGY4/XZu7MAVL9WepBFRG2JZjVui9DsL7r3zRTsfS
         AtGDQQzas3aSWpLbtbl6G0ZFPkbaOKdwRUfVLu76hUoIYRUh3MIQSFsy82zLtF1S5PZn
         zMe2R76tOb/Yv1lAf7Q1FTQi59VTSwVi8ODHs2nn8dyR7k/mhsb1/0zMmK2tjYhfx/25
         tKJvKlq8j94Sf6vyQwR2SyM93KBsPTp+LY5KnSkOWzN6MKI96mUuhR6cVIeYyFisHsA4
         zgh0QxEEMbq0Sw7hSZVN73QrgTEdmWhWcioTGzztTTnYGbDoG2UO1Bs7+sxNW6LFUhPf
         3YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685713534; x=1688305534;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gF49zRdU5uYPaFJUudEu7rAmB8Wh16UloOD04JQ8NIs=;
        b=NUc++EQEP5wfmnO+Muj4n0yU1OgILAggWid5yxGl1N9BrlHgKWHlCzUnv6fb5fq7f6
         vklzdggdVzXBFRI+cGwRbBjhnIMZjfp+C6PjIScFMKjy6c7QfjBVv++JiztroPhS36qP
         tn+C9nVVFAfEKww52dynqCmoktMQ2g/iGpAnty9qE3yS9Xid418os1MhnmXETGDETUzc
         fKvymDUhvFrRG3msjfG98WEfidXEw0Rhr3Hy7dNF3kX6FgxpOA4OavP1BxH0bljWb1ac
         1KTXeYIZq1l53hP4ZxGdMeP1kCoLt2Itpfvzew6XQ25DC4X4MsjhCMNROFGTMs3p/s6M
         nztw==
X-Gm-Message-State: AC+VfDxsG4nnY5Lv1di9aGS2Q6Hw6HYpiqsawkDoEzcXZLy/mVCfrrH5
        U/fy+xitMTVmQpf57bziL4B8kg==
X-Google-Smtp-Source: ACHHUZ7e5gX8srqJY3LI2LuOHEcTHAy31A308Z2pNKwyz3Q8cm4AnEw6BqUi6wXA0jx4C2egKv13DA==
X-Received: by 2002:adf:f2c7:0:b0:309:e24:57aa with SMTP id d7-20020adff2c7000000b003090e2457aamr45060wrp.19.1685713533710;
        Fri, 02 Jun 2023 06:45:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cabd:b6f:39ae:51a2? ([2a01:e0a:982:cbb0:cabd:b6f:39ae:51a2])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600000cc00b003093a412310sm1741471wrx.92.2023.06.02.06.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 06:45:29 -0700 (PDT)
Message-ID: <cc95cd30-ef3c-63e3-0f44-ad6338c7ed8e@linaro.org>
Date:   Fri, 2 Jun 2023 15:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/meson: venc: include linux/bitfield.h
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Nicolas Belin <nbelin@baylibre.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Tom Rix <trix@redhat.com>, Carlo Caione <ccaione@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230602124539.894888-1-arnd@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <20230602124539.894888-1-arnd@kernel.org>
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

On 02/06/2023 14:45, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without this header, the use of FIELD_PREP() can cause a build failure:
> 
> drivers/gpu/drm/meson/meson_venc.c: In function 'meson_encl_set_gamma_table':
> drivers/gpu/drm/meson/meson_venc.c:1595:24: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
> 
> Fixes: 51fc01a03442c ("drm/meson: venc: add ENCL encoder setup for MIPI-DSI output")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/meson/meson_venc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> index 2bdc2855e249b..3bf0d6e4fc30a 100644
> --- a/drivers/gpu/drm/meson/meson_venc.c
> +++ b/drivers/gpu/drm/meson/meson_venc.c
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
>    */
>   
> +#include <linux/bitfield.h>
>   #include <linux/export.h>
>   #include <linux/iopoll.h>
>   

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
