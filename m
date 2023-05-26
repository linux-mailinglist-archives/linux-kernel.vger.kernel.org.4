Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F877124A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbjEZK32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242974AbjEZK30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:29:26 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A29212A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:29:24 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2af30a12e84so5888121fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685096963; x=1687688963;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/K6PbDpa1bEXTu9+nLfG+TEYuGga9QGQcY866PUs1S4=;
        b=gls0zD+CZdmTwtc6DNf+QA/lpg0y7Qg2rRgYwry2zZXeUv5j1wUMD2sDzm5rhRPWXh
         r/zFGO0yfdRqz4SmPN5LkZp6IZ9+Egm4C62Yo7iPdgEmYMetTfTs5Ss94LRHToV1jWSI
         hSD3Slnyw1XdcWnCXFmOgPc40IFKdVXQNjoFqtnwRPK2thxVkwTsmbuEbDfyACbeOzqC
         1Fhgl4BLV9RPIncWS2o7iLKiih7fSBcJJPjWDsajIWdYjzD4PBaZBSB7rbw/m7Eb4Koj
         7bynkut6ileHW5xEwktrucRbX++MhLQvPs6Q7nA2cTVMQ5T69EcquDRClle2Y4cRGx4M
         OVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685096963; x=1687688963;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/K6PbDpa1bEXTu9+nLfG+TEYuGga9QGQcY866PUs1S4=;
        b=E23eKRBcHH4k5KXKkybfmt0s2oeSrBwCtEna1yyb34PsMS66ncgpmYGdR1dfKRbj5G
         54UX/GJZ80hhCoOFbfT0N8Hv3ee7sX2XyBSeXAPd+orIFLCwo3sdB3FuZJvsr7isoCmL
         1u42uwKz/ELnxe2LZVcFlYTqRQ70XiMLm/pZxyV5stcmWe2YAQbSANK9mlf8IR3I+D7M
         F0BLdf2jP/LgSq4fosqmnE6Wmx0TRGbVPMYqDBZHTnRM4UmFK3q6eksimgAqr03piefq
         JvxaCHH0RSvxDzG0xA3H+yVCKD43FMJ8K5zilJo2UoTvEeemf8WzOdbJ0e9+GR4/1czg
         HKcQ==
X-Gm-Message-State: AC+VfDxYCxKXEgOmk8fsc3BoDgu5paoNJ9xrlmY1gM1dSAxOafrlMaKW
        O/5/5b2qpy1e6BYNMegIdKBemw==
X-Google-Smtp-Source: ACHHUZ5Iev8xVgOOk2KPuQQZDGrJvE8omFBcgdT2Z9BmUX0sPH8sQxquSzcLsJQ9AqRoacTuX8xVcg==
X-Received: by 2002:a2e:b16b:0:b0:2a8:ac69:bfe with SMTP id a11-20020a2eb16b000000b002a8ac690bfemr489694ljm.42.1685096962859;
        Fri, 26 May 2023 03:29:22 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id a17-20020a2e88d1000000b002af25598f07sm650315ljk.78.2023.05.26.03.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 03:29:22 -0700 (PDT)
Message-ID: <cfbf7e0f-994e-ea93-11e9-cd20733a11e1@linaro.org>
Date:   Fri, 26 May 2023 12:29:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: ipq5332: add QFPROM node
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230526070421.25406-1-quic_kathirav@quicinc.com>
 <20230526070421.25406-3-quic_kathirav@quicinc.com>
 <55200328-735d-6571-fcad-735cc9d1568b@linaro.org>
 <bf0cef36-8286-df96-8c58-82aa6d1a02ad@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <bf0cef36-8286-df96-8c58-82aa6d1a02ad@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.05.2023 12:24, Kathiravan T wrote:
> 
> On 5/26/2023 2:49 PM, Konrad Dybcio wrote:
>>
>> On 26.05.2023 09:04, Kathiravan T wrote:
>>> IPQ5332 has efuse region to determine the various HW quirks. Lets
>>> add the initial support and the individual fuses will be added as they
>>> are required.
>>>
>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> index af4d97143bcf..c2d6cc65a323 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> @@ -135,6 +135,13 @@
>>>           #size-cells = <1>;
>>>           ranges = <0 0 0 0xffffffff>;
>>>   +        qfprom: efuse@a4000 {
>>> +            compatible = "qcom,ipq5332-qfprom", "qcom,qfprom";
>>> +            reg = <0x000a4000 0x721>;
>> That's an odd size. Are you sure this is how long the corrected region is?
> 
> 
> Yes, As per the HW document, this is the size.
OK thanks for confirming

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> 
>>
>> Konrad
>>> +            #address-cells = <1>;
>>> +            #size-cells = <1>;
>>> +        };
>>> +
>>>           rng: rng@e3000 {
>>>               compatible = "qcom,prng-ee";
>>>               reg = <0x000e3000 0x1000>;
