Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77301649AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiLLJTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiLLJSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:18:24 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2BFCC0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:17:39 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id v11so2153678ljk.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwizwMeJHVnIqxYQTWpLPjTX6OvJJvAC5GhdBfjnNQ0=;
        b=affrJT4hem8O1lqVnSDgHNXg/+zsTBxTUU6UsfjgTMz4PksrKhg0mZTFEYUHz3NZM3
         LqENqVcpwIw7Qf/1JfU+vHCzQBXNcU6WJw5ELmsA56h1zxaowrHBM+ysS7yAi768bzAF
         i+xJT/9Lzbps8cCL/4lPgKYvzbvy+4G0Nb7mNBQxzJOLiZzAdxiGAIFb8IEw4Z6TqY0o
         TWsN5HFRAsE169Tw0tcnzX16SIj6bbJ8rl3CQkBiWP/qC9M18DjvLRLPjJtm4RS9Gk0/
         TDGO0NzSdDpNPHQpUasNvEV7XDrNrvO0D6Q54rgpGbttQ95j4bfcst6x25jlrKA1Zg88
         QoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwizwMeJHVnIqxYQTWpLPjTX6OvJJvAC5GhdBfjnNQ0=;
        b=YI17lHRUFu9QeS40cORMFc9TWCTVyt92G7wHRf7iwFaj2U4+un9vDIk98iPdrPUJPO
         edDuLK2xOWHCfplPBCWaX0umeM1vGOr8IUvALjkMJkSCDARtQ2CAHnYZHZdAVm7zd/hW
         5cAKg5hfxYnhzrS6bsktx8eJLpnlXMKV8Fm1ulGS5/QOuUFmw+gDGW/9vZEgwPvVx0vp
         KMBayXi4W31VgmP9jYpsr7BQr3BaFU3BZ0UgDgL4aa4PXeiWtKgwc3HWn2Qr5JWDhGNm
         aHr5A8XH+KLDF5AzIkvUQmmTC7uWmjPaxobf1WseWrW1x8TKUMRtVIGKF5lZKg/7KHDl
         O90g==
X-Gm-Message-State: ANoB5plGtl0KCZHf/DJCkUBcXSic9nFDMo2BLY0JQsVDBdZD1MuraTE8
        sZdwMgZiEkSasD1wLNoAQShsTQ==
X-Google-Smtp-Source: AA0mqf4ZnWiCIvMl8Ad3+RVR26iAgfDgkl//qqIbR33QumVLTAk22yGTF105i1GLtcmlUMDCbuw/XA==
X-Received: by 2002:a2e:a602:0:b0:279:873a:56b9 with SMTP id v2-20020a2ea602000000b00279873a56b9mr3329552ljp.44.1670836658154;
        Mon, 12 Dec 2022 01:17:38 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 133-20020a2e058b000000b002775d0ae776sm1186560ljf.14.2022.12.12.01.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 01:17:36 -0800 (PST)
Message-ID: <2cf2eae9-9f32-05c5-c802-1d8cec9b4802@linaro.org>
Date:   Mon, 12 Dec 2022 10:17:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc7180: move QUP and QSPI opp
 tables out of SoC node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
 <f38f0bfd-858e-1995-167c-de747e57597b@linaro.org>
 <77246ee3-8ff5-1049-6b2a-d8925bc87b33@linaro.org>
 <4522aa1d-99fd-66ad-70bb-d39d9f5ca878@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4522aa1d-99fd-66ad-70bb-d39d9f5ca878@linaro.org>
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

On 12/12/2022 10:15, Konrad Dybcio wrote:
>>>> +
>>>> +	qup_opp_table: opp-table-qup {
>>>> +		compatible = "operating-points-v2";
>>>> +
>>>> +		opp-75000000 {
>>>> +			opp-hz = /bits/ 64 <75000000>;
>>>> +			required-opps = <&rpmhpd_opp_low_svs>;
>>>> +		};
>>>> +
>>>> +		opp-100000000 {
>>>> +			opp-hz = /bits/ 64 <100000000>;
>>>> +			required-opps = <&rpmhpd_opp_svs>;
>>>> +		};
>>>> +
>>>> +		opp-128000000 {
>>>> +			opp-hz = /bits/ 64 <128000000>;
>>>> +			required-opps = <&rpmhpd_opp_nom>;
>>>> +		};
>>>> +	};
>>>> +
>>>>  	memory@80000000 {
>>> Sidenote: memory@ should be moved above opp-*, alphabetically
>>>
>>> For this:
>>>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> You sure? Because before there is already opp for cpu...
> Which are called opp-table-cpuN and not cpuN-opp-table, 'm' comes
> before 'o'.

So you want to have broken order?
opp-table-cpu
memory
opp-table-qup
?

They are at least all together in my patch.

Best regards,
Krzysztof

