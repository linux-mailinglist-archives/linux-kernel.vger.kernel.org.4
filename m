Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BD468938B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjBCJUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbjBCJUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:20:20 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0A620D2A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:18:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so4018649wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 01:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGBTcLqitg7YmyUuCVO5u5nfwFsdx7KfIVES4p41zJQ=;
        b=a38sIkJzjv1+ks/NbAWxSeofwNPYSEhrzBKB+49fcu65mqsQdX0eUmst5rRlJlyFX0
         KOtSe6mpucbck0SfuOmYcosiTEWtyA3iOuhpEYa/QvxI0w9KRdYNUIFbHq6/4Jo2SoDW
         TlFm4t1XHnxZZKhujwfw9+3q73yLqUCqs5pudAHn4tBKY5v9TDY0BTKuX0CjhkdGEFD5
         ImLoAsCk39cWN/t+HuxHnP0ugKUK1n0NgZyUzcrBTOO1gpqPgfdmyj/Nu9HAACj12rD5
         sQYtQ24QpI4sNhrh7aTz1V4Gv4Vlu8I7RZSOq9nsSAOxhcxpOEDxzJj7SjFWD8AqaGW0
         PVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGBTcLqitg7YmyUuCVO5u5nfwFsdx7KfIVES4p41zJQ=;
        b=P52/54H9ZN8l08JBD0lx8dLy2228ph0VkpSHDmQEEMykGFR4foEGY6AgkyLCsUCwCF
         K7ortsHIs0+D3hBlp2VmZ1MOBvYFcQDB/PeIXJqrjXz0G9q0UNQvTp/hdqFBsnYmpG6S
         BDYhvZWph3gJmWT2xtXxpAzMYwpJ+/P8zj3ElV1mz6iWRiypZy61oMAggb11RokDbHqj
         2nGZwk8bBFzPWtRWfF1nyOmgQ53mun7Z39w2YjqCRwPLWUO1Em60y3K4DLjp07Fyk3tL
         vQdGAHB/D1bBlZvZnq7Rz0FuvxfFQSflA4dkOomc6mMDBbZh9kdzy292Jhjh3FtfyFV9
         iMeQ==
X-Gm-Message-State: AO0yUKU6VRRTI9fYenXtev/D+zLOjVgPzXKqpw2vJhcijEXrwQMeWq2Y
        OojkYawEO4nDZwlWDiiJvK3YQA==
X-Google-Smtp-Source: AK7set/kXpqSOqXdv7TjryP4gMQtQIcy8LbSh0edPvZWLND6aqj2U7Rxl/+hb/Ojsnj9emLO1S9axg==
X-Received: by 2002:adf:8912:0:b0:2bf:e692:2636 with SMTP id s18-20020adf8912000000b002bfe6922636mr8882294wrs.26.1675415935327;
        Fri, 03 Feb 2023 01:18:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n18-20020adfe792000000b002238ea5750csm1484520wrm.72.2023.02.03.01.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 01:18:54 -0800 (PST)
Message-ID: <59ff815b-baad-02c5-67df-e4d65f63afa3@linaro.org>
Date:   Fri, 3 Feb 2023 10:18:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6/6] clk: samsung: exynos5433: Extract PM support to
 common ARM64 layer
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230203060924.8257-1-semen.protsenko@linaro.org>
 <20230203060924.8257-7-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230203060924.8257-7-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 07:09, Sam Protsenko wrote:
> Exynos5433 clock driver implements PM support internally, which might be
> also useful for other Exynos clock drivers. Extract all PM related code
> from clk-exynos5433 to common ARM64 functions.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---


>  
>  	if (IS_ERR(parent_clk)) {
>  		pr_err("%s: could not find bus clock %s; err = %ld\n",
> @@ -91,6 +112,46 @@ static int __init exynos_arm64_enable_bus_clk(struct device *dev,
>  	return 0;
>  }
>  
> +static int __init exynos_arm64_cmu_prepare_pm(struct device *dev,
> +		const struct samsung_cmu_info *cmu)

Align the arguments.

Rest looks good to me.

Best regards,
Krzysztof

