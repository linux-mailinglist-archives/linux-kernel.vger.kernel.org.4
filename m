Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777997015A5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbjEMJ0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjEMJ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:26:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF3D10D5
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:26:47 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f1411e8111so12202088e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683970006; x=1686562006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2F71NeKdPntAy3Z+ybix75zHfY0YIpg6kv622GJFXbM=;
        b=kIB5yKWaX6ZaCvUKn3kXUrjMYUF88HJaMXHgVi2t3hQ3JTo5HnpCt14+OuQb+b4vRX
         J+nsWQ88vatV/5dehwNGRTZQa3qFh+FcpuHXXzJ5f0p6S0aVlRJwOeO3j3kfXc6z+p0c
         pvLytz7PGqC5TOD+xDD55tJvTYCujKFIiaLxGqc7OrDRqdQ/Yyl/B3XX+g/dKUalwFCr
         dNFjzPfJvRLaOIkYEUKqTGRL0WLey4gkM0KdV058ooXgfHA5pZgAI8zZ3kUGJ/jcYVXi
         FxuxPg13WjebERx/pQVOcCAk2coAPVVFYLTdBxvSDA7E9PBqQFiWgIcoH4WzwQGsL/sB
         wzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683970006; x=1686562006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2F71NeKdPntAy3Z+ybix75zHfY0YIpg6kv622GJFXbM=;
        b=KSJpDtm7FAZ5QgIohA10lcsHb6nKiaLj13+VYg3KZPpmCWz65CBC4x8e7+4Oeo5HFY
         +2mv/r0PQ9zL1ny5bdZMkG2KLUcQCo1PBAAxt7gdjikWr4+k0Uo39fDYg6hHfr8ZSm6Q
         I95JRLXUOYU6Cy2rZh2DJmEI/gBMb70R+6zAEAs1VUE0gMku1QQK5TcHuQlQx173t0l8
         F+KlSAOdwquVgBUE1zZgs3CJ5Kfd0HgBkmuS1kT3k5neYnBfV6azCyS38Op1MHxsYwt1
         HH7dqXO8OIVccs2g2eRxg7zU/pGxGQJNV+/gcG1vs4P43mr1UU8SnE7gKYql9UOTy5ks
         IMYQ==
X-Gm-Message-State: AC+VfDzVf9JjzO/+8iow/Sh9MYUj6C8r0t/oFjXtfJ/iqtVfuSBcBoXQ
        BOfbxjppyu7zpGNKpHJ8nWbht3cAQVmIY5Q9gZM=
X-Google-Smtp-Source: ACHHUZ4IdptFTHvQTAPgHe+AFQmfte3OSLwL1OE2oj7TahT+Pg06PNqiQBcQ8sIHgGgpBlxTuXKK/g==
X-Received: by 2002:a05:6512:3907:b0:4f1:dcd2:ab6d with SMTP id a7-20020a056512390700b004f1dcd2ab6dmr3841495lfu.28.1683970005801;
        Sat, 13 May 2023 02:26:45 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id e28-20020ac2547c000000b004f13634da05sm1772978lfn.180.2023.05.13.02.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 02:26:45 -0700 (PDT)
Message-ID: <7738357b-801c-e1a7-8ea9-28d8a3d3d997@linaro.org>
Date:   Sat, 13 May 2023 11:26:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] pinctrl: qcom: sa8775p: add the wakeirq map
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230512153232.92450-1-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230512153232.92450-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.05.2023 17:32, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The SA8775P TLMM driver is missing the GPIO-to-wakeup-pin mapping. This
> adds it.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
This almost matches

https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/d7af4a14603957d414e931b5f175f36f3537ae34

minus one diff:

< { 39, 200 },
---
> { 30, 200 },

please consult which one is correct with qc folks

Konrad
>  drivers/pinctrl/qcom/pinctrl-sa8775p.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sa8775p.c b/drivers/pinctrl/qcom/pinctrl-sa8775p.c
> index 2ae7cdca65d3..422d72ed1012 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sa8775p.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sa8775p.c
> @@ -1491,6 +1491,23 @@ static const struct msm_pingroup sa8775p_groups[] = {
>  	[153] = SDC_QDSD_PINGROUP(sdc1_data, 0x199000, 9, 0),
>  };
>  
> +static const struct msm_gpio_wakeirq_map sa8775p_pdc_map[] = {
> +	{ 0, 169 }, { 1, 174 }, { 2, 170 }, { 3, 175 }, { 4, 171 }, { 5, 173 },
> +	{ 6, 172 }, { 7, 182 }, { 10, 220 }, { 11, 213 }, { 12, 221 },
> +	{ 16, 230 }, { 19, 231 }, { 20, 232 }, { 23, 233 }, { 24, 234 },
> +	{ 26, 223 }, { 27, 235 }, { 28, 209 }, { 29, 176 }, { 39, 200 },
> +	{ 31, 201 }, { 32, 212 }, { 35, 177 }, { 36, 178 }, { 39, 184 },
> +	{ 40, 185 }, { 41, 227 }, { 42, 186 }, { 43, 228 }, { 45, 187 },
> +	{ 47, 188 }, { 48, 194 }, { 51, 195 }, { 52, 196 }, { 55, 197 },
> +	{ 56, 198 }, { 57, 236 }, { 58, 192 }, { 59, 193 }, { 72, 179 },
> +	{ 73, 180 }, { 74, 181 }, { 75, 202 }, { 76, 183 }, { 77, 189 },
> +	{ 78, 190 }, { 79, 191 }, { 80, 199 }, { 83, 204 }, { 84, 205 },
> +	{ 85, 229 }, { 86, 206 }, { 89, 207 }, { 91, 208 }, { 94, 214 },
> +	{ 95, 215 }, { 96, 237 }, { 97, 216 }, { 98, 238 }, { 99, 217 },
> +	{ 100, 239 }, { 105, 219 }, { 106, 210 }, { 107, 211 }, { 108, 222 },
> +	{ 109, 203 }, { 145, 225 }, { 146, 226 },
> +};
> +
>  static const struct msm_pinctrl_soc_data sa8775p_pinctrl = {
>  	.pins = sa8775p_pins,
>  	.npins = ARRAY_SIZE(sa8775p_pins),
> @@ -1499,6 +1516,8 @@ static const struct msm_pinctrl_soc_data sa8775p_pinctrl = {
>  	.groups = sa8775p_groups,
>  	.ngroups = ARRAY_SIZE(sa8775p_groups),
>  	.ngpios = 150,
> +	.wakeirq_map = sa8775p_pdc_map,
> +	.nwakeirq_map = ARRAY_SIZE(sa8775p_pdc_map),
>  };
>  
>  static int sa8775p_pinctrl_probe(struct platform_device *pdev)
