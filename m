Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFE4638A95
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiKYMyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKYMyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:54:11 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5EA20F6B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:54:10 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id t4so3373196wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+L0OH+CqCrtKGjPWmm+w9b2BzfAcQ+LiOOKvg/k27GY=;
        b=wvDY0pWbo6THktZFD4aifCIxFvHXKL7viQcPE/adaQ5CNQZoa9l46JTneVViRi4V7T
         k0ufBv95R6X4aAwvhyQE2YLpaHAJk+qGibfFnH0zfvL3JLrffCfLvVcMj4IROGSh2C1V
         yZ7UTNPpOWRz1ounE6CfNLUoutWq7ACVTXSI5biIYCf+vKbT9JyeKsuYo1789XPxkfY3
         Ci2Ib87jwCrw3S4Eo/4RL3W0IkmAK0t6JRJutc1ari90thY1oYKbfrkBh57TcxlqS0Uw
         /5p4BglUyjLt7Z8CtZZ1V/URUEOz963ya0LmUYU36jTqwRNLNAcc3Mr52dnoW5iTQyfW
         42ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+L0OH+CqCrtKGjPWmm+w9b2BzfAcQ+LiOOKvg/k27GY=;
        b=ZhdjBCFWX45mWYvlKNzWySYCnNsQ73PZ63JRUOALalD9TmK2WqQOAHIu9mEIEVtX9J
         e63oXkKgpbJyGgyjSxbRDhVEhh/jOw4+gjXuh6huBWxIswrjBmkqOQWOYtrrpQor2mAG
         gGb1x7wvaHkxOF+Y6LyuBo47sOt3esloYI/BwCyn3+aySgU1wSgsgyOZOyfeBtr+G0ky
         Cc8Gsh8aN1se4qgiNLhvJV03NJKgZYiYDZA75NxL1TfqTYb0sSB1MjfVep+KQuF+RInF
         sgs8/OA5hjK63ePeq2LV/LKkjcDsBWZnMP2x14LWK5T/4Jfk+nsDfWsLrWibvcYpGmko
         JQNg==
X-Gm-Message-State: ANoB5pmUpdQFdaMT9BHycFCbdq9lw6z1iuZ94ZWbulFLwK9it1G9Qglw
        ExuJtfLS+rGHgx4sYP/n1bEehg==
X-Google-Smtp-Source: AA0mqf6QaUOeyJHGelkdGQQDqg9Cr3tOC9ZY97MzYk83EKyrbG639t0bn4eiUyXQ/Mg/djl5bTpecg==
X-Received: by 2002:a05:600c:5113:b0:3cf:77c0:48ea with SMTP id o19-20020a05600c511300b003cf77c048eamr30706150wms.130.1669380849331;
        Fri, 25 Nov 2022 04:54:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:84a5:7e09:b15:f1fe? ([2a01:e0a:982:cbb0:84a5:7e09:b15:f1fe])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c3b1800b003cf47556f21sm10620871wms.2.2022.11.25.04.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 04:54:08 -0800 (PST)
Message-ID: <84c685c5-9205-237d-588c-57d33f956325@linaro.org>
Date:   Fri, 25 Nov 2022 13:54:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/6] dt-bindings: reset: meson-g12a: Add missing NNA reset
Content-Language: en-US
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221125111921.37261-1-tomeu.vizoso@collabora.com>
 <20221125111921.37261-2-tomeu.vizoso@collabora.com>
Organization: Linaro Developer Services
In-Reply-To: <20221125111921.37261-2-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 12:19, Tomeu Vizoso wrote:
> Doesn't appear in the TRM I have, but it is used by the downstream
> galcore driver.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>   include/dt-bindings/reset/amlogic,meson-g12a-reset.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> index 6d487c5eba2c..45f6b8a951d0 100644
> --- a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> +++ b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> @@ -69,7 +69,9 @@
>   #define RESET_PARSER_FETCH		72
>   #define RESET_CTL			73
>   #define RESET_PARSER_TOP		74
> -/*					75-77	*/
> +/*					75	*/
> +#define RESET_NNA			76
> +/*					77	*/
>   #define RESET_DVALIN			78
>   #define RESET_HDMITX			79
>   /*					80-95	*/



Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
