Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B0D7028A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjEOJcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjEOJcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:32:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B254A1AD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:32:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f37b860173so1926186e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684143164; x=1686735164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kL96h2tqkNFwcSW2y3vEwRRRBP7d2GAr46VUhlv3Hr8=;
        b=sh5khvKPLIZlLhYC9YBG6EKZnB4UGlPNvQ5MgeOjfutwSwD88Tp2Fn4gdRrqvNdE8Y
         3f5EhRG7XeguLt7IMvBFYLjan5FCTVMjGu4VeQuZPCi152nZ0543hXrfO6h6AAVPC7Gg
         e717katOTER+htDtBnmLzoyL1uSbocTjtA/K0fqtydFAJVjFrrfeNUjx54Do4sRDa3x6
         WiQqt72Ck6qGvO88AKYtScMoR/9i4g3vhFKSyayN+QOs1lJvUFdcT+YdmVKAXliSz5aM
         EVtHzy8WDqjbuvcTUUTdSXKmLA7+/mnFmFZwUFWNjhQGka7eG2XY1oj2FgcbCnwApyo2
         UP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684143164; x=1686735164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kL96h2tqkNFwcSW2y3vEwRRRBP7d2GAr46VUhlv3Hr8=;
        b=fCAgod4cB3b3WrznEmPEd4oNj9s7qTRnfdUqYHn74JgwXTAyy/ywLDQx9XJszfWOAH
         IIvn/5hescl4NAM8Kl+VfkdLHdi0mLOaZ2rdO44jTvKn2N/Ev5HB+kQQnEZFM4mvmx87
         7jefNIOur02wxLNLcUBW/LdyOqZcdJU8xaX64S9CsY9boR6kuAHwx/C9s6cUb0qlhddV
         axXrHjUVnyoGWxmVuVyHJzRP/5FVOBEr00SYFo099H5plu/E4AAUKV++W3lumXbbBMbJ
         q6N1SYmTmbDTPXjqjFlmAJSmcRzlTf/acBCmrj8f2mMnFJhr3rAxgS7aE5DCCSnH3P7J
         qD/w==
X-Gm-Message-State: AC+VfDwhnIzGXkib7OOCcBhn8R5O1MJ+9RMmXjrlgufcKNlKbjHnsqEs
        3CaUg23rKOncqx8Lruu372GICj/oleOp9g7LwZs=
X-Google-Smtp-Source: ACHHUZ7KG9ZxMNEt7xHG9G/ZmJMhzXz86/mOQ91rfFFn6qdkMaQSIKKnUr76qMuQdVDvoj65xNKaMA==
X-Received: by 2002:ac2:44b8:0:b0:4dd:9fd8:3a36 with SMTP id c24-20020ac244b8000000b004dd9fd83a36mr5473230lfm.1.1684143163939;
        Mon, 15 May 2023 02:32:43 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id i22-20020a056512007600b004ece331c830sm2538803lfo.206.2023.05.15.02.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 02:32:43 -0700 (PDT)
Message-ID: <80047944-b155-d1fb-2959-4354d4f0a829@linaro.org>
Date:   Mon, 15 May 2023 11:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] pinctrl: qcom: sa8775p: add the wakeirq map
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230515092515.180920-1-brgl@bgdev.pl>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230515092515.180920-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.05.2023 11:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The SA8775P TLMM driver is missing the GPIO-to-wakeup-pin mapping. This
> adds it.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> v1 -> v2:
> - fix the 30->200 mapping
> 
>  drivers/pinctrl/qcom/pinctrl-sa8775p.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sa8775p.c b/drivers/pinctrl/qcom/pinctrl-sa8775p.c
> index 2ae7cdca65d3..6ea0197b36c6 100644
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
> +	{ 26, 223 }, { 27, 235 }, { 28, 209 }, { 29, 176 }, { 30, 200 },
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
