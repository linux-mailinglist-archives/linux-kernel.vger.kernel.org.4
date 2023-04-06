Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D8C6DA3FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbjDFUqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbjDFUq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:46:29 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA4C1024E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:43:05 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b6so21852826ljr.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjYb+JJW8I3O+mIrtvD7Toze9rRPQIAniPP/DyAemws=;
        b=V0r8ogOPUHVQWm/U05RejhjJjC6dWRxD1yPdyxlOCuku+kCvNxsl4EsRbuIoRTaCQq
         o+rVWhpvr9te+49j25Ba0s4/Dzo3INZWmUAkGzF+H/QTfX3ueiiAlXlgqqJo2oKKcgeG
         uyMJoQqNorh2fVv/I/8z+WxVIwcTIj9hLH9/9QQYfRg/K651mJGDH4UpcxiIKyXqx50n
         YaL+ieyRfxJIB1MhLeAxky1I3pLc2/3Vfyb5c9hDgWYrvCc2sNQ+u+L3ILc/LM8J2Nco
         SbIvYDBtfghO0ngYUK53m+Rvc2OU9ONK8dXU/eStzZYM9q3b6OjFP3gGKc3qV8S9aTw7
         JMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjYb+JJW8I3O+mIrtvD7Toze9rRPQIAniPP/DyAemws=;
        b=YaR6WjjD6OGVAkLBMIWMX9tKW0lCXlAJW3ffrZnJgSRvkdU5dUL8SExLfppxFuF474
         6i3m04YPiNtNqETvWl5A2sqztdr6jjRABnt7gSF05JDG+uuReTOXou5Y9zHzD+kOPYN7
         QWgCw30blGhto2xaoKGCb1FRPe5oSuCNU4jNAq1LkL+EHLPPyXKuSI/08jrnVNbOP8BI
         zmPwFhffLPjjhluzePY2dq0NU0VTtWuxfjRuwP4NyKWpL/RoW0Lu56SjBb1NQ4Ojz2em
         +CSMwmCgI/GYR1mJgwReHXPboOD1FKPU4qjE5Y+p0BO6mFleBNWnT0CNMIYkEWqW8l3Z
         LeXg==
X-Gm-Message-State: AAQBX9d4MDSkBiOkn5G7cwOKsl+aKhFYlkV95W562JMfYQTbjdk99kDk
        xOzN5HuKhMRDU8dxc0fhg8g0Bg==
X-Google-Smtp-Source: AKy350ZJdq9Hh31L8H3mS/MSrbl7fhNNRkQjz0P/GlAc/2GKPBiUxYHvpIMONNiMcHjKx2M1VDl5VQ==
X-Received: by 2002:a2e:a268:0:b0:2a0:5a99:65d8 with SMTP id k8-20020a2ea268000000b002a05a9965d8mr2390419ljm.18.1680813784266;
        Thu, 06 Apr 2023 13:43:04 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id k20-20020a2e8894000000b0029f3e2efbb9sm432968lji.90.2023.04.06.13.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 13:43:03 -0700 (PDT)
Message-ID: <955adf22-6b52-652e-0215-efacc9a13799@linaro.org>
Date:   Thu, 6 Apr 2023 22:42:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V3 5/5] arm64: defconfig: Enable ipq6018 apss clock and
 PLL controller
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        dmitry.baryshkov@linaro.org, arnd@arndb.de,
        geert+renesas@glider.be, nfraprado@collabora.com,
        broonie@kernel.org, rafal@milecki.pl,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_ipkumar@quicinc.com
References: <20230406061314.10916-1-quic_devipriy@quicinc.com>
 <20230406061314.10916-6-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230406061314.10916-6-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.04.2023 08:13, Devi Priya wrote:
> The PLL and IPQ6018 APSS clock controller are used on several
> IPQ platforms to clock the CPU. Hence it should be enabled and built-in.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  Changes in V3:
> 	- No change
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 8f24c280dec2..27dc617ec296 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1153,6 +1153,7 @@ CONFIG_QCOM_CLK_APCS_MSM8916=y
>  CONFIG_QCOM_CLK_APCC_MSM8996=y
>  CONFIG_QCOM_CLK_SMD_RPM=y
>  CONFIG_QCOM_CLK_RPMH=y
> +CONFIG_IPQ_APSS_6018=y
>  CONFIG_IPQ_GCC_5332=y
>  CONFIG_IPQ_GCC_6018=y
>  CONFIG_IPQ_GCC_8074=y
