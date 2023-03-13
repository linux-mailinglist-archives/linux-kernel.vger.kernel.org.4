Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8606D6B7443
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjCMKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCMKiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:38:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5A84608C;
        Mon, 13 Mar 2023 03:37:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k2so4532979pll.8;
        Mon, 13 Mar 2023 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678703867;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KU7DMY9k7DfRs8YYS0f44VoUtgWgosku2UjOg2Dqy5A=;
        b=Z1uya8RuNbWxfnRK9B1p4JS3cvIl9X+qZHFgPVyN/aHwEMX/UOABbdeRabhUHAIgON
         aB+lKl3DzzrXH0AbEh0C5aX3X8q/Q9MaMckSq90uEWd2AxyvfGrhKol7t2h+JO2QAirE
         aPGQ0EMR/KB1+QnjgPzZbdmlgRTLyjBT8KvZVwfSRbW0QjncGBhy0qkuJtkPqHgxK9co
         Ohft7TiBWuaPj4KXSVKjI+SaahbygujLxe2rBZt0HltJ+asnglPbW21VGuxwtZBzSYS7
         W8xRYRFDlYzK9xJSLUU1ij0FkpF64Ic+Jco/UQnxOgLb412lCS7KqvKkNVn3/l6tYpV+
         m2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678703867;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KU7DMY9k7DfRs8YYS0f44VoUtgWgosku2UjOg2Dqy5A=;
        b=yBb8e3qWrA0Vg0JxDnqC86/hmh4B2KGw+EtPzcpXvwrWEmbRDL9h8KfmdosfA+BEH7
         yUjOTwpRlozIvWEjXoAYp8+oZYnGe28YyViHdaeSK+CnTNH140Itd+/ln91BBjySLxKg
         MxjrfVWVypWc/H0ZFflGFI99xrZvbWRr+l1pT+2jVhvzT4aTuLr4LW8CD9Ko3rq5lQAb
         S50f8FQ9wkD6Zt5m5Zh4Lz0pluqmmjG4wc5R5Fddb4/hjjYVsOYeQhqXauVu5LQlBFfO
         NEGh08HH9Z/+k9fxRyMAtSd2MrSEk8urOXkEt+HB2aGGDGns+7yPx44jaTFIdQnFwYBl
         t0pw==
X-Gm-Message-State: AO0yUKUPu3V/qzfsEdvYHcDrV4j5AelxjQwr7bD7kB5+81nU09w4r0Iu
        MnaRFfBFv3DTk2jTKIxmHU0=
X-Google-Smtp-Source: AK7set8NWZf5ZuTQmuFcIevA1d7F10D+nLjVlsIq1XWd3B8TEqCd7UiHsIr7GKU4PzlppyuWARfpnA==
X-Received: by 2002:a17:902:e886:b0:199:4a00:9788 with SMTP id w6-20020a170902e88600b001994a009788mr43057201plg.19.1678703867538;
        Mon, 13 Mar 2023 03:37:47 -0700 (PDT)
Received: from [172.30.1.89] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id jx18-20020a170903139200b001a057d36dc1sm741713plb.138.2023.03.13.03.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 03:37:47 -0700 (PDT)
Message-ID: <f1019d0e-78ec-2783-5537-b8759993064b@gmail.com>
Date:   Mon, 13 Mar 2023 19:37:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] devfreq: exyos-bus: drop of_match_ptr for ID table
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230311173753.263390-1-krzysztof.kozlowski@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
In-Reply-To: <20230311173753.263390-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 12. 02:37, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).
> 
>   drivers/devfreq/exynos-bus.c:504:34: error: ‘exynos_bus_of_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/devfreq/exynos-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 027e8f336acc..f7c554051232 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -513,7 +513,7 @@ static struct platform_driver exynos_bus_platdrv = {
>  	.driver = {
>  		.name	= "exynos-bus",
>  		.pm	= &exynos_bus_pm,
> -		.of_match_table = of_match_ptr(exynos_bus_of_match),
> +		.of_match_table = exynos_bus_of_match,
>  	},
>  };
>  module_platform_driver(exynos_bus_platdrv);

Applied it with 'PM / ' prefix to keep the consistent title style.
- PM / devfreq: exyos-bus: drop of_match_ptr for ID table

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

