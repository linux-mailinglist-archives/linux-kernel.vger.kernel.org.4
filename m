Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C15360D14D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiJYQIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJYQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:08:00 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538641849A0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:07:59 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id f8so8398867qkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGivQRStsoGf3SydFu3ANoXyWUjFTilvELDG+BbTvYI=;
        b=iw9I6KJoH3uq3FjUeyyNKlMPTkxb4nt9tH+/dSagR/eweyCkbm+PyMKuN2xyyiRMyD
         xlNnF0wpeHkTJFCMDd36xXav2K6TPU9WpLgL1NQZIosSavy55UY0yzQdqynb4P50NSKc
         bYQEN5DthdU7bExoKATgoUmFOjghxBh2wy47kC5zVG149Taq2Ag7knUl1WZUXBS60OBb
         u824dZdpsM7BmFNhu4qzs+BYwlmPMbejHOGRmujl+MjBpoy6jE2Ax8DaCxFXlg0T+ubQ
         G1UNvFseGcIoEB1ohwcbULVOxtOwNTXocSu6LDr8X+ZAp7ZX5QXqtf5aksAlcKdY4Xzx
         yI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGivQRStsoGf3SydFu3ANoXyWUjFTilvELDG+BbTvYI=;
        b=4nw9TkctFYvNCnVsTOekV7RldbPIKEiSG7JrhKMUUjT0VvXha0sR5VLGIpHNq5tRBa
         ml2z0CdDIckuAY50X8n1SAP2TUxq/2iXoI68NN7ZkywFLxNmtawKV4JcMxD3cLaZiw8Z
         Q9EN0PKcERay6CMDe4q+y9szgKcm/fv0XNF/KOMS9bif49x5CrLYdBcwTius9i6qCsdn
         A1CNRNlNFyjdGxe+/7VypkFNRBv9e535lPUcv/tLTSD9OdrFuwTBkX5azlVLnQlVO6d5
         dj6usWh7TAk5Skx3BWsNbYbCaLZMCKz26nVVqwAR+Z65sR6EB/JmZNPszSRAZuo8MEEx
         2k2Q==
X-Gm-Message-State: ACrzQf23KWjMn8omrKseFlkBJE2V/TFGxCP51GItQINSvhUUVy1GaN9c
        Jic/UTKWAEAtMAvtkuUZX2uhjA==
X-Google-Smtp-Source: AMsMyM5Zmrzl9C9XrKzWREQHAGtCFXulnRiKpQK68TLkdV0erplmbn7PUQyf5hYARg6ekSjwwJ/B2A==
X-Received: by 2002:a05:620a:4510:b0:6ee:e598:a185 with SMTP id t16-20020a05620a451000b006eee598a185mr25704272qkp.765.1666714078483;
        Tue, 25 Oct 2022 09:07:58 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id cq13-20020a05622a424d00b003972790deb9sm1743072qtb.84.2022.10.25.09.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 09:07:57 -0700 (PDT)
Message-ID: <a5a5c18f-476c-2f45-8cd0-3c88b3aa509d@linaro.org>
Date:   Tue, 25 Oct 2022 12:07:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver
 support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20221024014209.5327-1-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024014209.5327-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2022 21:42, Yinbo Zhu wrote:
> The loongson2 SoC has a few pins that can be used as GPIOs or take
> multiple other functions. Add a driver for the pinmuxing.
> 
> There is currently no support for GPIO pin pull-up and pull-down.

Thank you for your patch. There is something to discuss/improve.

> +static const struct pinmux_ops loongson2_pmx_ops = {
> +	.set_mux = loongson2_pmx_set_mux,
> +	.get_functions_count = loongson2_pmx_get_funcs_count,
> +	.get_function_name = loongson2_pmx_get_func_name,
> +	.get_function_groups = loongson2_pmx_get_groups,
> +};
> +
> +static int loongson2_pinctrl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct loongson2_pinctrl *pctrl;
> +	struct resource *res;
> +
> +	pctrl = devm_kzalloc(dev, sizeof(*pctrl), GFP_KERNEL);
> +	if (!pctrl)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pctrl->reg_base = devm_ioremap_resource(dev, res);

This is still not fixed.

> +	if (IS_ERR(pctrl->reg_base))
> +		return dev_err_probe(pctrl->dev, PTR_ERR(pctrl->reg_base),
> +				     "unable to map I/O memory");


Best regards,
Krzysztof

