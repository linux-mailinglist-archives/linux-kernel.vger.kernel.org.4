Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CA1679D61
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjAXPZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjAXPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:25:48 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1B422DEC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:25:45 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id y1so9747585wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRSOqByjWCTfw2IqSfQf3MSHv6dQgoH4nISayRjMtHk=;
        b=X9d2a5S1g5Pu1uaUjGX2GmiGuc4pN82zNBWoOGOHcX8XaQC8rGQrGiJeXXPupqndP2
         8frDjvCY3lM6xNFSYA37yXGrSvy5PYBkJRHC13Eebenn9F/ojaSOUKhG8VARQjtYRVYn
         eyh99YAjdmXe4Gp4/R2uFIpD527C8xf2I7+NFSRUlRlo9EXl/zd1PWGeJhTzjq5WLhXG
         Y/ThQ8UtiHVxbsyVAIkJpb/mPo5NATRefd9rcH8Gd6LFhuuxtTwrJPZXScuDn/u/GrVE
         1FPsN2T235cxTxWMatD3/N/G53cTuBreun53e4j1UQNouUppryVeArPL0OvtowLyQd/d
         CPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRSOqByjWCTfw2IqSfQf3MSHv6dQgoH4nISayRjMtHk=;
        b=sJNlKDgFYmMJm8QObkyOLLsNDZfwrrH+0BGEprh37jznKR7Y1++uFmFO6K/VULvaZg
         i2jiSg5qRxqulSILwBf0DfS74ChsoV57lNQEWBtkfScmppAwuECoKv6JJDOkoCP+C8uH
         fsljoUhRpg+KX36xe/18lx6ll0dA4cNN6J4tTJuHpurlnVnU749ZeSoIo1tTwAu34FlS
         0FI4A/GQ9PsmeMpiQTnRUW9GlHNrzECikzha0f2Jo86YV6Je0cbAbm+x/cV0kK/ARXfL
         LZJ69fvG+5S3ln1uxZGQ89Ikmr8tczMhJQf2u7UP75rkxUsMt1UrNexWmLkRsf37MuVH
         uxtA==
X-Gm-Message-State: AFqh2kqRi+/MRG56fgUfX49dld95KUEpaL2enpaDxiuoZ2i4EtNuzMPD
        coHtJL2C6BFSzpHllddcuwXPUw==
X-Google-Smtp-Source: AMrXdXsmytFzOSiZqt0rtnYj8izFdVm0myDTdxvXTy/+LHsqw85xIPz2gUD9Dr7unVsJyyy14GVP4g==
X-Received: by 2002:adf:fe05:0:b0:2be:bfcb:b1d4 with SMTP id n5-20020adffe05000000b002bebfcbb1d4mr13392077wrr.57.1674573943928;
        Tue, 24 Jan 2023 07:25:43 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r1-20020a0560001b8100b002bfae16ee2fsm2037656wru.111.2023.01.24.07.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 07:25:43 -0800 (PST)
Message-ID: <3ae863df-3260-4863-d88f-da4d3f442174@linaro.org>
Date:   Tue, 24 Jan 2023 15:25:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sm6350: Add camera clock
 controller
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221213-sm6350-cci-v2-0-15c2c14c34bb@fairphone.com>
 <20221213-sm6350-cci-v2-2-15c2c14c34bb@fairphone.com>
 <e5ff49d4-45c7-8c4a-d624-d8f7cc9ce2cb@linaro.org>
 <CQ0I4ONEI6J4.3KWS1KBE7RTKD@otso>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CQ0I4ONEI6J4.3KWS1KBE7RTKD@otso>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 14:48, Luca Weiss wrote:
> On Fri Jan 20, 2023 at 5:49 PM CET, Bryan O'Donoghue wrote:
>> On 20/01/2023 13:13, Luca Weiss wrote:
>>> +		camcc: clock-controller@ad00000 {
>>> +			compatible = "qcom,sm6350-camcc";
>>> +			reg = <0 0x0ad00000 0 0x16000>;
>>> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
>>> +			#clock-cells = <1>;
>>> +			#reset-cells = <1>;
>>> +			#power-domain-cells = <1>;
>>> +		};
>>
>> Should you include
>>
>> required-opps = <&rpmhpd_opp_low_svs>;
>>
>> ?
> 
> I don't know, it works without. But doesn't this property not just
> affect power-domains? I haven't passed any here.
> 

Should you have a TITAN_TOP pd though ?

---
bod

