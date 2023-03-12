Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AC76B67A9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 16:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCLPtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 11:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjCLPtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 11:49:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CBE38B41
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 08:49:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s11so39328031edy.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 08:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678636159;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ze1sZZfvq/o3HPIuxYy3C9whN6R344n7Jno797TGzZw=;
        b=EdYr9Y2NNVd69Fe8ci4f1VHqYC77SF2qg/Jlybb2r7i6w9HWYRoDi3prZL6yLzRE8u
         zz4EZEEKzCvM+/kerG/cumr0hQs1hEkBBJfXfmXEHrJcbgUSf0l6lOTBudAG5Yudq1yZ
         z8l3mKtb5w+NwMPXFKZFOUwcy5qycSIyK99s+zo53XoIsl11nUwotJQD1cnHHCMN65VX
         mrSTQtqAhT3YNU207Oh300USWGnoSu7eIEWeCVS1XPVnZpn97/2h3MGCTOHD+NK4YV/y
         7zlveTFIHrRgwdp8tjAsvJyuxn666YWoURqbrrKWMnipMpxHOLkh1EeqG4Mcbna4v/uz
         5l3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678636159;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ze1sZZfvq/o3HPIuxYy3C9whN6R344n7Jno797TGzZw=;
        b=4C8+nA40Q+VfclxpDIGi702K2PF3jQJY7P5dw6Dvld4jt48D//+FSDuASxmP0zVMj/
         ldTHC4yDotcqYUmTJ6NEKeZRfRgcSvXwtfha9q9LcwGX/GyMSSQYXVDPwzVli6U/H2Pz
         HS0TorfIsG7CLaKSlhfJnup8dXEQg999xrwZhrOY91gz0KmeUslBvn5eOyam2DVg/bwl
         gNPuf+haDKNwS5eyInnxRZe7dWllojqyHh1kVLMJayd9mhUlh3SpAv9d9y547i0Lo9Ar
         dZpytVKIPDDEojG6tRKeJIyXUWkvLA4BTVmJFR4gJr1tH9Xkah6Irk4hCdQti8I4Xcef
         mqTg==
X-Gm-Message-State: AO0yUKVn8vhiiJeQAaLxI4lW9UhoN9xIOwo4+87Am3avM5XRMTjxjgvw
        JcEO7O97+TDIipj4AtMjLIfRqw==
X-Google-Smtp-Source: AK7set8udaJr3jonmmaxfmotBUdoyBVYzuKxMre3xI0ZisJg58IQP/BbH1HtpCaF3M/edo7bzjfXEg==
X-Received: by 2002:a17:907:2ceb:b0:88a:8e57:f063 with SMTP id hz11-20020a1709072ceb00b0088a8e57f063mr27906362ejc.62.1678636159425;
        Sun, 12 Mar 2023 08:49:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id pk10-20020a170906d7aa00b008d1693c212csm2349659ejb.8.2023.03.12.08.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 08:49:19 -0700 (PDT)
Message-ID: <be1eea98-ee16-751d-b833-72a8a667b553@linaro.org>
Date:   Sun, 12 Mar 2023 16:49:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V3 4/6] hte: Add Tegra234 provider
Content-Language: en-US
To:     Dipen Patel <dipenp@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230310190634.5053-1-dipenp@nvidia.com>
 <20230310190634.5053-5-dipenp@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230310190634.5053-5-dipenp@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 20:06, Dipen Patel wrote:
> This patch adds HTE provider support for the Tegra234 and reflects the
> changes made in the device tree as follow.
> - Add slices field in the SoC specific structure
> - Remove gpio chip find by name function instead make use of the phandle
> parsed from the DT node
> 
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>

(...)

>  	hte_dev->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(hte_dev->regs))
>  		return PTR_ERR(hte_dev->regs);
> @@ -635,8 +750,15 @@ static int tegra_hte_probe(struct platform_device *pdev)
>  
>  		gc->match_from_linedata = tegra_hte_match_from_linedata;
>  
> -		hte_dev->c = gpiochip_find("tegra194-gpio-aon",
> -					   tegra_get_gpiochip_from_name);
> +		gpio_ctrl = of_parse_phandle(dev->of_node,
> +					     "nvidia,gpio-controller", 0);
> +		if (!gpio_ctrl) {
> +			dev_err(dev, "gpio controller node not found\n");
> +			return -ENODEV;

This is non-bisectable patchset. Remember that DTS cannot go with the
code, thus your code should handle existing DTS (which is BTW already
released with v6.2).

Any remarks to comments that no ABI was broken back then in 2022 are not
valid now. They were valid that time, but sorry, the time passed.

Best regards,
Krzysztof

