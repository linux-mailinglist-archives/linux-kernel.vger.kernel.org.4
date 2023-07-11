Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B7674EBF7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGKKtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjGKKs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:48:58 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6344E7A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:48:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so8528624e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689072535; x=1691664535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k3hVozTzTK3YpKr6keu2WXQ1FFPISWGGNo2UDTZRi9Q=;
        b=nU/C676GyY21hAj+KRX6jRPDoXxBLxRpQ5tiHgw/ZMtBl1OUkqwjasHhY6RDZsyNVU
         4GGS4GTyrQTnU41lUp8zeu51RqkNmwwfawQanRriSSMpKrj1OBR1wz242jRO4aitsGxm
         //q83alAYwGQk7ekHZ9mvV7cYdsgwz7yUDg6jFW3ipXf/PZvu6CmDDbDWFiPM87pd0aH
         7vaQgg6rdWHH/klRgqVJX/bDS8XioTllvSejePpOsUADiYqtqkiD/wibaFzHSOYExBhM
         R5UOyVWk5IMkCml0yhWUgy5Uwro76it/Ax9LXJ8Ha40dqTjJYHwKRUckQmGb25/kn/xJ
         5uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689072535; x=1691664535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3hVozTzTK3YpKr6keu2WXQ1FFPISWGGNo2UDTZRi9Q=;
        b=T/4jmALta2TpWMd3BjOx5kssF5OoW6o5CxdYocGs0hMqKhw6/y1WKc+zN53RqWA4AZ
         gNeHJ16YhqfinQKmWvgDvcULUp6+2RLDeEkth3DocFgEKD+UzcZr+KR6GV+DyUL4H/aQ
         35vNVKixtjHF5KyI0o7+gp5oLWuUTjw3YykAXZfSdcMXLGvN7xCmi1ooMnopv7Zh98EP
         Jismf4d3AC702NnGOzL5ezQQRzuKk04hQptga06s49hNyFmezcf2pkrEv9fVr1S3n/Bb
         LNlSHA9aK6DpQ1bABh9yj6KfX7Tp5hncamPKoLzAnWd/bITf4qOmm6z9wBmKEhlQXQbb
         8BlA==
X-Gm-Message-State: ABy/qLZIKJXM9aMYb5z3HJXnA3Y5MzUd6uKysBfMqq4WbhGqkLDxwj0J
        V8whp0Zio492DM6r6FzM3opaSg==
X-Google-Smtp-Source: APBJJlHyMlnWO4airaDPNcfvE8dSS4VL8N9jsft2L9pAPDgY0hTH+0GFSvSQwhNkgEST/eS/lAkWyA==
X-Received: by 2002:a05:6512:3da1:b0:4f8:7781:9870 with SMTP id k33-20020a0565123da100b004f877819870mr14270790lfv.60.1689072534973;
        Tue, 11 Jul 2023 03:48:54 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u12-20020a056512040c00b004fb57f28773sm264107lfk.285.2023.07.11.03.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:48:54 -0700 (PDT)
Message-ID: <f234891f-c508-20de-6d6b-c7b37f6adb2b@linaro.org>
Date:   Tue, 11 Jul 2023 13:48:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/6] arm64: defconfig: Build NSS Clock Controller driver
 for IPQ9574
Content-Language: en-GB
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, arnd@arndb.de, geert+renesas@glider.be,
        neil.armstrong@linaro.org, nfraprado@collabora.com,
        rafal@milecki.pl, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org
Cc:     quic_saahtoma@quicinc.com
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-7-quic_devipriy@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230711093529.18355-7-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 12:35, Devi Priya wrote:
> Build Qualcomm IPQ9574 NSSCC driver.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 9ce0f1554f4d..d10083da2401 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1180,6 +1180,7 @@ CONFIG_IPQ_GCC_5332=y
>   CONFIG_IPQ_GCC_6018=y
>   CONFIG_IPQ_GCC_8074=y
>   CONFIG_IPQ_GCC_9574=y
> +CONFIG_IPQ_NSSCC_9574=y

Can it work if it is built as a module? This defconfig is used on all 
variety of platforms, including even non-Qualcomm ones. We are trying to 
limit the built-in drivers list to the crucial-only ones.

>   CONFIG_MSM_GCC_8916=y
>   CONFIG_MSM_GCC_8994=y
>   CONFIG_MSM_MMCC_8994=m

-- 
With best wishes
Dmitry

