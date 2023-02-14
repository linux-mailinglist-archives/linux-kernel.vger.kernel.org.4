Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9576961B5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjBNLDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjBNLDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:03:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E99BB92
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:03:40 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id z13so10692531wmp.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOM3CPZuCbZR0lhVymV8+GULNDOaWi8QToMxaRMMdmA=;
        b=xe8dIVaq3d4Ucivu0Wo6j5i77pzOnavSz8szQx5dlpj4lZYMlS1Cp9XW/iSzhVqmVt
         VNKZshEyKn9+M9YTAXX8GXd8lfE/AdJZ3vN6N1/mTzuduy8HHdfuam9hj5gm5KYN8v6f
         vWCjwf6xSBomhiBBj07larllzuDkruDeckb8pMPP9f1owrjxT8726fMXfkrze77mqaLu
         aEbo5/qpF4sImWZSApoj3Qm2yLQodjatgO7yEUNISueAhoCy8EDlWk5DgP2s6dwLqTXi
         Wc0mOjfpuRuOwhp1bPhyB+K+yUXxsU26JHcmFeIuESV108HkmkUqIzbaKLC0UXykJgEJ
         n62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOM3CPZuCbZR0lhVymV8+GULNDOaWi8QToMxaRMMdmA=;
        b=BvaxI7jG2U5Pr6AEwvpsuwjQSJxXsse9XrB2zmohvAco4s5xH6/1wo5SFSEByCskUD
         pnH6pVea2RShcY2A0Im2903vZhkcZ3Kov9weH0jAFmYtxq7ovi1dyWcIiRoq+SQySCrQ
         7/XHJsjJHfUh5u4QDvOxWwe8zpSYh8xz4BWwo54+PpRbDIUPLUbomtr9A6p+6ojS7tRB
         iSDTlgTw0FBVGMMI5ZiWkagV7wCmImDcpp/gxK6gWMwAQzm8hvybxeWB2f6VmUGWaMge
         8tDvnHUoEwDU8BrFqaq33vjNJYzBaIpH97UfrsTjKXZdMASMMRRmmCA3lRUVDELhVju5
         YOmg==
X-Gm-Message-State: AO0yUKWtDJgU78ljxWJJ3dJNvEiJNCGmZALXTgYZSufnxLlhXm72OzEC
        PCnsB/GntE55fsVh6TGTqktOEQ==
X-Google-Smtp-Source: AK7set/KyeFjRnmHgnn3gWuPfhM+h5w3KI8G9HiR61pgvWGdhLErkIsTE/954hofgST1+mcgbF8uFQ==
X-Received: by 2002:a05:600c:2208:b0:3df:9858:c038 with SMTP id z8-20020a05600c220800b003df9858c038mr9401100wml.13.1676372618878;
        Tue, 14 Feb 2023 03:03:38 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j16-20020adfff90000000b002c55efa9cbesm3263069wrr.39.2023.02.14.03.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:03:38 -0800 (PST)
Message-ID: <20508eea-859b-ffa3-0ebe-0ca2e48090b9@linaro.org>
Date:   Tue, 14 Feb 2023 12:03:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sm6350: add power domain to
 camcc
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230213-sm6350-camcc-runtime_pm-v3-0-d35e0d833cc4@fairphone.com>
 <20230213-sm6350-camcc-runtime_pm-v3-2-d35e0d833cc4@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213-sm6350-camcc-runtime_pm-v3-2-d35e0d833cc4@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 12:01, Luca Weiss wrote:
> Add the CX power domain to the camcc node so the power domain gets
> marked as in-use when camcc is used.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index 1e1d366c92c1..62d6dcd8d1fe 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1507,6 +1507,8 @@ camcc: clock-controller@ad00000 {
>  			compatible = "qcom,sm6350-camcc";
>  			reg = <0 0x0ad00000 0 0x16000>;
>  			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			power-domains = <&rpmhpd SM6350_CX>;
> +			required-opps = <&rpmhpd_opp_low_svs>;

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

Best regards,
Krzysztof

