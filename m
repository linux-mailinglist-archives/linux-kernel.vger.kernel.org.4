Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F8366587D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjAKKC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbjAKKCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:02:15 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B01DF8C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:59:14 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r2so14470750wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qW5mgg0txJDMGDLolojBqvPVG3n1xb0Fs1NR3NSfaOQ=;
        b=ZXUXQmr9mTTBcG/UYZm3fg2cx06J54xaym917KctEKmY1qGNEiLlwH4Y7pJVsT7Qv0
         ta6Q0D2g2LlP9p3xgW2EpAz3wUSRfl4MiWESHfXGFHoDhUAzG3jtC46wMaJbNOzXmUTT
         RVlwQW0jrfr4zK3TWx3ZqWcu/D8kXZHfB2su6VtaMo3MwiKxJFWvu2C2VrUCmq39UHnd
         l+EkXJwnHmf3NtfLpBld6OSKn63NHLufRPFZ6+iRARxd/kpVfHpawVFG3a6oUWbZTvBq
         oefI8GqWyvRIMbTrIN4uTI9uZVFfkovFMUK4UiHgoCLKann//LQcBwSSVO4dqgLFiM0o
         MRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qW5mgg0txJDMGDLolojBqvPVG3n1xb0Fs1NR3NSfaOQ=;
        b=1Ix9BZwZg7oodvsERhqGmj+ggD7Gy3sc/xseOYhVoEX7fDueo0fKk8afWgB8PRwuLE
         8XfFSI87OYdXypzIr4UKq5oJTPqSTT8DCaIp3/81dBjqj7d/PMne7MfjnfPJI3PHlFdp
         1qoTxk8K+w6QN6LkdJWZXR202oIulwj66JyltRgwQCN7K4/NKc87TwEkrPH76302n61Y
         dVNTW++KS89DslX1+2cKxdfKRo953j0olw+sIgw1ZxG0vXkn8chpog84bc+yRX7WG3vA
         FiJLV9euUHiAKahrx7LSA+CwDN6U0QijW0P+eY9kFP3DXufdxaC9HDdDL5cMK8SJS6WU
         Vtzg==
X-Gm-Message-State: AFqh2krWHShA8eIP9ZbuehMA3qZ2u+GkZsJ287fWhIE/zsJOcyZcHChY
        QxZtnpOTB03qCIY2j5d2mQF6vA==
X-Google-Smtp-Source: AMrXdXtiVTp+3xy/WVITPFWGlg+pbPLIr6qDVR4twsd3qMdRN/aj3bgM0Q//hbdLvEyZumDbnh2y+A==
X-Received: by 2002:a05:6000:18c9:b0:242:82a4:2bf4 with SMTP id w9-20020a05600018c900b0024282a42bf4mr42935847wrq.10.1673431152707;
        Wed, 11 Jan 2023 01:59:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b10-20020adfe64a000000b00287da7ee033sm13382550wrn.46.2023.01.11.01.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 01:59:12 -0800 (PST)
Message-ID: <ab6a99da-e91b-20de-3126-3f1f94ce277b@linaro.org>
Date:   Wed, 11 Jan 2023 10:59:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: Add TCSR halt register space
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1673428818-26112-1-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1673428818-26112-1-git-send-email-quic_mojha@quicinc.com>
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

On 11/01/2023 10:20, Mukesh Ojha wrote:
> Add TCSR register space and refer it from scm node, so that
> it can be used by SCM driver.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 5704750..e0fa733 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -270,6 +270,7 @@
>  	firmware {
>  		scm: scm {
>  			compatible = "qcom,scm-sm8450", "qcom,scm";
> +			qcom,dload-mode = <&tcsr 0x13000>;
>  			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
>  			#reset-cells = <1>;
>  		};
> @@ -1986,6 +1987,11 @@
>  			#hwlock-cells = <1>;
>  		};
>  
> +		tcsr: syscon@1fc0000 {
> +			compatible = "syscon";

This is not allowed by itself. You should have warnings when running
dtbs_check.

Best regards,
Krzysztof

