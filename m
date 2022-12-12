Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EB1649AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiLLJQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiLLJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:16:00 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B31BE0C5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:15:55 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a19so11873758ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3i8DxZYukDlFANivRrDcpJlJ1yInWzN03lkuTs3FHs0=;
        b=FkaasSlxJvIZIdRZa5WYAeHRkTMVNEfuyD/Tymm3CmuhnwfbgxtwLhAFF56ItxzmS3
         yNNpcWNoznIYFiHqCzf5Xg+LF7y1ViCrmKzUkla+a8KcpltCQRXAH0/ENEDSE4o+WFeX
         8HXRLl/WjiZvWB6FfAfPBs/2qLU5oLwplrDNC9BQnPhFTEclgePVkmoZYHWoYRGYQbfD
         AG51XJ2jDoxahwPP+kVCbjSArv/ib87McVYVHfy+Wze03lXpnEABiLsm/m94bATv677h
         VCjux1hOvqZU88y5Pc+BQ477MQT3vOwjsc3wr1xgcVms8gMpQIK3/gJbfSpRmsPd+Osj
         3Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3i8DxZYukDlFANivRrDcpJlJ1yInWzN03lkuTs3FHs0=;
        b=x7HFJg+aeOrTv83gc2vHBXvw+PAjHARehv8J9G4VDzn3NNLEyjjKgta5NhNAS5/vL+
         Qj7YZNt7pEK4sxbUbTKjXWuhzfR3EMVg+w6UzTjCPkNxKK61xxYIF0jyshgjccwpAotK
         zghntPZmp4CXPdyDqf1ABNdAL9jnvLgNp0dQyoi35USovzCw19xC0GtiQy3RndJ7Et/Q
         50p/45OdS8LAaDcfxv6eN5c4VyYRcyGIdfzZTXDLmlRazIO6+is5zHdA8KB3t4J5NSTy
         f9rfJfDruDvgzyw2QNgX5ZAAvwr1MnxqqP+qiBA5vdfNjW7GHJDSLnhleRafPku1oHyJ
         RaZg==
X-Gm-Message-State: ANoB5plIl2GKELb25sQgOtoaNP4bKKinYSoS1o0Wp1coZ2vp4AfSaOV+
        urEjbhk9WD6GJxIxYKx46nrdoQ==
X-Google-Smtp-Source: AA0mqf4+LREp008KNa6o91TXG5e7yPmbpxuO8UZ+w1ay0Mp6aoyKqEWJoqXDRC5BAUg7SuYD44hZOw==
X-Received: by 2002:a2e:be8c:0:b0:278:e872:cade with SMTP id a12-20020a2ebe8c000000b00278e872cademr4681270ljr.39.1670836553299;
        Mon, 12 Dec 2022 01:15:53 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e8e72000000b002778a76a3c3sm1135404ljk.112.2022.12.12.01.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 01:15:52 -0800 (PST)
Message-ID: <4522aa1d-99fd-66ad-70bb-d39d9f5ca878@linaro.org>
Date:   Mon, 12 Dec 2022 10:15:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc7180: move QUP and QSPI opp
 tables out of SoC node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
 <f38f0bfd-858e-1995-167c-de747e57597b@linaro.org>
 <77246ee3-8ff5-1049-6b2a-d8925bc87b33@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <77246ee3-8ff5-1049-6b2a-d8925bc87b33@linaro.org>
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



On 11.12.2022 21:14, Krzysztof Kozlowski wrote:
> On 10/12/2022 13:29, Konrad Dybcio wrote:
>>
>>
>> On 10.12.2022 12:57, Krzysztof Kozlowski wrote:
>>> The SoC node is a simple-bus and its schema expect to have nodes only
>>> with unit addresses:
>>>
>>>   sc7180-trogdor-lazor-r3.dtb: soc@0: opp-table-qspi: {'compatible': ['operating-points-v2'], 'phandle': [[186]], 'opp-75000000':
>>>     ...  'required-opps': [[47]]}} should not be valid under {'type': 'object'}
>>>
>>> Move to top-level OPP tables:
>>>  - QUP which is shared between multiple nodes,
>>>  - QSPI which cannot be placed in its node due to address/size cells.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 76 ++++++++++++++--------------
>>>  1 file changed, 38 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>>> index ea886cf08b4d..735581097295 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>>> @@ -538,6 +538,44 @@ cpu6_opp16: opp-2553600000 {
>>>  		};
>>>  	};
>>>  
>>> +	qspi_opp_table: opp-table-qspi {
>>> +		compatible = "operating-points-v2";
>>> +
>>> +		opp-75000000 {
>>> +			opp-hz = /bits/ 64 <75000000>;
>>> +			required-opps = <&rpmhpd_opp_low_svs>;
>>> +		};
>>> +
>>> +		opp-150000000 {
>>> +			opp-hz = /bits/ 64 <150000000>;
>>> +			required-opps = <&rpmhpd_opp_svs>;
>>> +		};
>>> +
>>> +		opp-300000000 {
>>> +			opp-hz = /bits/ 64 <300000000>;
>>> +			required-opps = <&rpmhpd_opp_nom>;
>>> +		};
>>> +	};
>>> +
>>> +	qup_opp_table: opp-table-qup {
>>> +		compatible = "operating-points-v2";
>>> +
>>> +		opp-75000000 {
>>> +			opp-hz = /bits/ 64 <75000000>;
>>> +			required-opps = <&rpmhpd_opp_low_svs>;
>>> +		};
>>> +
>>> +		opp-100000000 {
>>> +			opp-hz = /bits/ 64 <100000000>;
>>> +			required-opps = <&rpmhpd_opp_svs>;
>>> +		};
>>> +
>>> +		opp-128000000 {
>>> +			opp-hz = /bits/ 64 <128000000>;
>>> +			required-opps = <&rpmhpd_opp_nom>;
>>> +		};
>>> +	};
>>> +
>>>  	memory@80000000 {
>> Sidenote: memory@ should be moved above opp-*, alphabetically
>>
>> For this:
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> You sure? Because before there is already opp for cpu...
Which are called opp-table-cpuN and not cpuN-opp-table, 'm' comes
before 'o'.

Konrad
> 
> Best regards,
> Krzysztof
> 
