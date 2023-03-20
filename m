Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76A06C0E87
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjCTKSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCTKSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:18:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7726F758
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:18:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x3so44473550edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679307491;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9QmThArlU3j/do0x0/HOKynN3iklRKOHG46pnLsnHw=;
        b=cfKIOkAWt2qSqihZu+iJRamjO6lMQhnDcRYEV6P8j561vRc+Apj+CESbo74m4MU+20
         z9OBbShtAEkZXCjwdfPwxH/ywg1w5QPwP9bau6B9z4Q/oH49tCRBl8T+BkWeKhLPydnM
         lnzyhQdu7Vb9qPzNsdiq1JFCZoZzQO4X8acut3VxbpUKfcKZuLNLV+0Z3L5DqNDZ+xsK
         JnHhYXCM5S9UEVNvGNen4IMgdSyYhxc2QKDgIBv0N2CAk6ckjDpirwCHmctbEqCf1bmS
         T/4zDrlak6vMHplZHupoUBnpvz8So809N2GkYn2G45EMTc8ETGSxAl64KotQ1g3KGbwp
         8/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679307491;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9QmThArlU3j/do0x0/HOKynN3iklRKOHG46pnLsnHw=;
        b=32IBLUPXesI1E+QuPh7MgRnRrD25nOal2XpgQ2IYzCbpe/l17RagJCuCM0HLFQK38z
         0fSo+uXxMno/L2nOEQjXSaKjIsaZlm2ccQC85sKvoocgOBoW0kf0qrO3KDaY/aMHS8XF
         /GeJosFe6fzdMT1wbobCjOQYwUG8jNOOePA6QLWaFlFKK2nZ84K5UUdodIV4us7E/0Pb
         tK74zm0UIjuqwa5aBDVqEAbxXs/9eoeLaF6+StAG5Sz9gtP2DxtQTgguyDfe9B8mEV1y
         zk69SAcJpmdsnijwJ9l5K7B+5ot1efNpUmNZ0sZsF+AoR4UqbmnjyS0CPV6HyGLzXMWZ
         CbJA==
X-Gm-Message-State: AO0yUKV31RYSTJhq6NIZr3bLMyn6c3H1WAywPNfX6WyZxF119qPCXXu3
        3/x2Oi1QiHDsjhHfNR12lUd3qg==
X-Google-Smtp-Source: AK7set+TovgWorTvh0ACBLoB6PXtYdY+uBaQ+fhbXWNdFqjwNLDcjjjMwN+Ujio9D2J6NyIVvckFig==
X-Received: by 2002:a05:6402:12c1:b0:4ff:844a:ed4c with SMTP id k1-20020a05640212c100b004ff844aed4cmr12664996edx.0.1679307491486;
        Mon, 20 Mar 2023 03:18:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4428:8354:afb6:2992? ([2a02:810d:15c0:828:4428:8354:afb6:2992])
        by smtp.gmail.com with ESMTPSA id o2-20020a509b02000000b004faa1636758sm4633214edi.68.2023.03.20.03.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:18:11 -0700 (PDT)
Message-ID: <713745fe-4963-6008-89b8-f0fb68c8056c@linaro.org>
Date:   Mon, 20 Mar 2023 11:18:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5332: add few device nodes
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230320094450.8015-1-quic_kathirav@quicinc.com>
 <20230320094450.8015-3-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320094450.8015-3-quic_kathirav@quicinc.com>
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

On 20/03/2023 10:44, Kathiravan T wrote:
> Add the nodes for QUP peripheral, PRNG and WDOG. While at it, enable the
> I2C device for MI01.2 board.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts | 14 +++++
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi       | 67 +++++++++++++++++++++
>  2 files changed, 81 insertions(+)

Thank you for your patch. There is something to discuss/improve.

> +
>  		blsp1_uart0: serial@78af000 {
>  			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>  			reg = <0x078af000 0x200>;
> @@ -201,6 +218,48 @@
>  			status = "disabled";
>  		};
>  
> +		blsp1_spi0: spi@78b5000 {
> +			compatible = "qcom,spi-qup-v2.2.1";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x078b5000 0x600>;

Please keep the reg as second property, after compatible.


Best regards,
Krzysztof

