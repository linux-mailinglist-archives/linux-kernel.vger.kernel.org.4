Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97E73C74F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 09:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjFXHTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 03:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjFXHTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 03:19:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D4B2729
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 00:19:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51d884a22e7so134235a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 00:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687591179; x=1690183179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cdfM92BhhAeh05SY/R6fVtpusudWUNpng54QzU9UWbU=;
        b=rNbFdPh14tBWeSges/cMQ9go41B5Hn/tpW/F0tt7ObNSkytzILlgG/wJy+CNQEjKGk
         ScTTJhmpDAXiD2kJqQrIQcSEnZkVBIcfJ45X8NKwVhnjB/FO5bZYBG892oEmCsqH2SUn
         3+vvN6mXZ6rLkqmWyOCxKyoOGUsbi74zi+tF8wgUdnEHOqYvCLUiRKqSXf8q2sZVc1Du
         9DwkomciC3q3h4YfSzLhKRqjcNRpyDKTjTWP7FAYHe1wot2Cf9ArAMgxA9wxk1ivzGnG
         Y74mY726deK2j+h9sk3Vz28BX2DAYP7ipCiTqkhQdzO0enhd/sQMCBsqajNFr85/X8Ti
         GVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687591179; x=1690183179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdfM92BhhAeh05SY/R6fVtpusudWUNpng54QzU9UWbU=;
        b=bxFd+UtMEs/nJW5S+ui5TZbCJN8qk/WxzOzk/21B+guP5wgpsTVIRHv1vesHC3fLDO
         8L9ebz00Qgd5rUtLji/Rpf7dMaTNDquQZ6g3bX3Mi7QGuNYQ+LtC2VEB+YrXjiUwtbWF
         SsTPHVCVY9/sYXZMY9rLCHzmA8ZqdAtE4dRLgIQVSYoFjxg8Ng4HzTEnEIaj7RSonD5E
         ZrqxzvByWK0PND+/1+2rhtiICZIqezLD/W4EPVOGrxLMyfA5ylKVvymZcDPpg4wWaBnN
         uUHR0iYxAf4bhFk1DtSueEaHlMkSNkT0hx9FtGc2L4L5NqY1YhFNJv9jfd63ZGd7+PUs
         Y8lg==
X-Gm-Message-State: AC+VfDxWfQ3QQ+1smC1Qa3LLnVF43SwXLfycDR3VSSqmk5dySHWuQTir
        C5DoUYZCPrNUUPMVewpKDsWmFw==
X-Google-Smtp-Source: ACHHUZ5533eWDYyUp50ARA4XSsrrhtN7Q+/3k06QMxdyY+esPAACxRSNJILMK6WQu3kKNqqeYOyT8A==
X-Received: by 2002:aa7:d981:0:b0:51b:ebea:18ee with SMTP id u1-20020aa7d981000000b0051bebea18eemr4821972eds.22.1687591178932;
        Sat, 24 Jun 2023 00:19:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s22-20020aa7cb16000000b0051bed498851sm388765edt.54.2023.06.24.00.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 00:19:38 -0700 (PDT)
Message-ID: <8dbd8330-de83-b663-8105-e33c16687a88@linaro.org>
Date:   Sat, 24 Jun 2023 09:19:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 01/13] dt-bindings: remoteproc: qcom: Add support for
 multipd model
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jassisinghbrar@gmail.com,
        mathieu.poirier@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_eberman@quicinc.com, quic_mojha@quicinc.com,
        loic.poulain@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org,
        quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com, quic_varada@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-2-quic_mmanikan@quicinc.com>
 <7940c743-815f-f864-d015-43d7e916ecfa@linaro.org>
 <a1456f62-d0a7-d5ec-b379-db1b6035c89c@quicinc.com>
 <d187eafb-4a80-9479-d063-3a01b47d8efa@linaro.org>
 <feb0d11d-0930-d0b8-ab6e-cf477bbf114b@quicinc.com>
 <87edmoitu3.fsf@kernel.org>
 <0555c089-9d0d-7d19-9646-f0f9b8630d12@quicinc.com>
 <5f9cc367-eaa5-4c19-4e5e-7052b0259ccf@linaro.org>
 <04f5e3cb-d2f5-747c-1fd0-4b61d845e2c5@quicinc.com>
 <36900050-2ffd-b5dd-f768-986624a83c70@linaro.org>
 <59d92b83-f759-50de-9b8b-834c3c0bec5a@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <59d92b83-f759-50de-9b8b-834c3c0bec5a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 13:39, Manikanta Mylavarapu wrote:
>>> on number of wcss radios connected on that board and only one instance
>>> of 'qcom,ipq5018-q6-mpd'.
>>>
>>
>> I don't understand why the user protection domains need a specific
>> compatible. Why do they need compatible at all?
>>
>> Not mentioning that amount of your domains on Q6 is actually fixed per
>> SoC and probably should not be in DT at all.
>>
>    root domain is fixed per soc (One Q6 DSP, one per soc)
>    user domain(s) are variable (based on number of wcss radios attached)
> 
>    The sequence to initialize, bring up, tear down the Q6 and wcss radios
>    are completely different. So in order to differentiate them, we will
>    need different compatibles. So this is a new rproc driver/architecture
>    which has a parent/child topology (Q6 DSP -> Master/parent controls
>    the WCSS (child)).

I understand you need different properties, but I don't see yet the
benefit of creating here artificial compatibles. Look at your ipq9574
DTSI change - it does not use even ipq9574 compatibles for 66% of its
children.

Maybe you should have there just property describing type of device or
bringup?

Given SoC cannot come with different amount of children (PD) and
different amount of radios. You even fix the firmware name, so
boards/customers cannot use anything else. It's fixed and the only
variable element here is disabling some of the blocks per board, if they
do not have physical interface (e.g. radio).

You even hard-code the number of PD by using "pd-[123]", without unit
address, so you do not expect it will grow.

Unless you want to say that these are devices? But your binding does not
really suggest it...


Best regards,
Krzysztof

