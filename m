Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BF5669A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjAMOaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjAMO33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:29:29 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E976CFE8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:20:30 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ss4so45410242ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXm/KVhv1Q+MJT4WARwvCEecY+Pt3DzZrZnoHTVBa9c=;
        b=nr2atzfb+mPTcqxh+qo03K/MkGPKipx/pu1w6IOQaCy0ubgEMTWuZi8M1DPRQ7Qd6E
         isy4pAbJYsnTbrPbQ4Nt/grugBLz6qFkTPvLapBXsfA5EEHDBnS0dGSZnuiWL114xQdH
         qnfI3Ze7DBplXLb3ssiXrPUBlLyYozd3YeRKK8YxZ75Z1mE3fbFBi0RD1FjZtepCKF6X
         gANHMg2asjUUGdRT/E5ekZNGKOc4JFGqexCFymrDgvvILVHiwHf/7yr9wYpMY2VwbqsT
         8iv19WITTw12jTtEdvpQ8Kv4N+r6fbOSvID/VaVqT4HznN5MUcuwmXte4aEd4E9rfoEa
         vuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXm/KVhv1Q+MJT4WARwvCEecY+Pt3DzZrZnoHTVBa9c=;
        b=a1K8AshR9QfU1NaZ2QS63Wz3lJ9YTYixnzMEa92IN+POZlKbPU7V8CMbRFNfRn3uuc
         5Fe563S0rUTV+VK+FKzdMK9G8XndUUJ7n1jw3uqdVcWefUEDaYyIPKlZsp1EwuaQYUMv
         KLyAKe/lOSXVz9mS+fhi1Fr1Zc6yMPn8+ykB1qVdWy077cjfKLLHy2gl4WXGSHRPF01R
         CIsKtaiFQgCMRR6+py/MsmgpqN3QoNDodWe7KZFy/5t9QsgOPWXuEBSsmF7Rda8vj3Gk
         maBgBNajBZ4C5CEXFu9vMJ4Z+J0RokVbUuvk2h4Sk47iJWU3jqZq4w8beFqDLxCehhES
         ZdlQ==
X-Gm-Message-State: AFqh2kql9Qv2o0TiUr1+ei0UjcYElIYZAeFXrunUsxMwgcqvVFHMl8dH
        FSKPfi7PrGwfBT4QPMT3z2nRbQ==
X-Google-Smtp-Source: AMrXdXuhoTbM4wM81X8S1RJYwrtdyd2fyIBnofyfbBJZ4gOKdtlpxhGW8rh1SA9w6+Q0K44Yhwoq9g==
X-Received: by 2002:a17:907:c48d:b0:7c1:4bb:b157 with SMTP id tp13-20020a170907c48d00b007c104bbb157mr3645542ejc.4.1673619629025;
        Fri, 13 Jan 2023 06:20:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709067c4300b007c0a7286ac8sm8606501ejp.69.2023.01.13.06.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 06:20:28 -0800 (PST)
Message-ID: <84aa79c3-b793-0d0e-d6a5-035aff5a17b4@linaro.org>
Date:   Fri, 13 Jan 2023 15:20:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/7] arm64: dts: Add ipq9574 SoC and AL02 board support
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-7-quic_devipriy@quicinc.com>
 <f6ef1834-b629-b76c-9cde-55af56320665@linaro.org>
 <7f157b73-f856-04d2-1b39-e1f8861d0439@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7f157b73-f856-04d2-1b39-e1f8861d0439@quicinc.com>
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

On 13/01/2023 14:29, Devi Priya wrote:
>>> +
>>> +	soc: soc@0 {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		ranges = <0 0 0 0xffffffff>;
>>> +		compatible = "simple-bus";
>>> +
>>> +		tlmm: pinctrl@1000000 {
>>> +			compatible = "qcom,ipq9574-tlmm";
>>> +			reg = <0x01000000 0x300000>;
>>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>>> +			gpio-controller;
>>> +			#gpio-cells = <2>;
>>> +			gpio-ranges = <&tlmm 0 0 65>;
>>> +			gpio-reserved-ranges = <59 1>;
>>
>> Hm, why reserved ranges are in SoC?
> As the gpio is forbidden on all ipq9574 boards, we have added it in SoC

Why it is forbidden on all boards? I guess it depends on the firmware
and this can differ, can't it?

Best regards,
Krzysztof

