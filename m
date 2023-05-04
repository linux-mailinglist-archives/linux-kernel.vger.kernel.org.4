Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460F76F64F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjEDG0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjEDG0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:26:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34C72D5E
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:26:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso18141a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 23:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683181582; x=1685773582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dbeuFUbN+y4wxPm3oNkN4WEWogtuu7yxovAZHZoB3w=;
        b=VobsL5Scs2vgAmRMkxycXT+xrCPU+jPFqqTXaOJPyEAbGoDDMr9MFBkv8QUK0LmATx
         qghwQ/nLmcl8qoTsu//Br7HKMZtqrEh6nWJSo856SlKI3doqwIavRMYyp8JMftlMnKgn
         xQBg+1/ToIfVIhfRPNJpu7TxrVFLUnf4I4a92TU8WzmEa9g5eMcXt9RAPgpqBlHHT7sN
         mJrzgqYZcIJWW2cNVeJi2dqtKgm5LOq8RonxxiuSU5inJOyu8xWigflOFWh2znwFJnsD
         ExovGIOTQ85oAaGnPBEFkm2Kb3fjAZ6mCswCYnOZEdiR19dfvAVhBPanhk9gs9GsZfrK
         JigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683181582; x=1685773582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dbeuFUbN+y4wxPm3oNkN4WEWogtuu7yxovAZHZoB3w=;
        b=GtCc0ZDRrd+DudgCpcHpRG5sZbniiGxuAhWxx4T2vIIbNQJSIRJ4xkGy6p0du4otJY
         c+qwni5ifWJrhYgLOS6v6BGJDA/IxDZjeHrf6ZBOlwZDMVM8P7AnTuBxdFJyUp57upxq
         rr6gJOiTw/XiZs5jDMc2cInXEjL2wx4PJ+WCnGyB3BQWY9w2yWnK0bDX/kXrRtcClUY3
         wlOGsXDCyTP1R74T8hXhlj88ctSvA97F7uUMZBHXbnLyJQEQ+SlmJenZnkJTqzJBZHpK
         dRAT5vVqjD8FP23kZDZ7ILkTbchxdy6jmDv3ogJkuworgEbxUI+nCrDSdnKU/PdudxNu
         f30A==
X-Gm-Message-State: AC+VfDyTY+3j+o4s8z67NlvSK8DfVQJy1BoKOZsmrHdM1XNrqZecuyOD
        mZAyUD9K8jQ10BQ20eRDr/H7tg==
X-Google-Smtp-Source: ACHHUZ6t+EL/u7uHURsbl4J/qlD1Pt6oPGzIFE5VVTf06CBazX2WXBko9bRa6S+qPjwEOOku/eZwwA==
X-Received: by 2002:aa7:d156:0:b0:504:a248:3741 with SMTP id r22-20020aa7d156000000b00504a2483741mr814382edo.14.1683181582428;
        Wed, 03 May 2023 23:26:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id g14-20020aa7c84e000000b00506addaaab0sm1461849edt.32.2023.05.03.23.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 23:26:21 -0700 (PDT)
Message-ID: <3ef818c8-1ee4-5bee-6b37-20658b2e4637@linaro.org>
Date:   Thu, 4 May 2023 08:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V4 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1681742910.git.quic_schowdhu@quicinc.com>
 <NO2MhqhxQqjQ33CVOtaXXxo2iBfl6Ugz1lE5oJAl-mjUyrRu4l9vCBWV8AVJZoCrVF0Cw0j49t44Bn5yEAv3mA==@protonmail.internalid>
 <bd3350e3b0b02669cffa4bdaf9a0a1d8ae9072d1.1681742910.git.quic_schowdhu@quicinc.com>
 <9da030c6-6a9f-6766-7120-94aaa8fcd8ab@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9da030c6-6a9f-6766-7120-94aaa8fcd8ab@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 00:10, Caleb Connolly wrote:
> 
> 
> On 17/04/2023 16:08, Souradeep Chowdhury wrote:
>> All Qualcomm bootloaders log useful timestamp information related
>> to bootloader stats in the IMEM region. Add the child node within
>> IMEM for the boot stat region containing register address and
>> compatible string.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>  .../devicetree/bindings/sram/qcom,imem.yaml        | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> index ba694ce..d028bed 100644
>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> @@ -49,6 +49,28 @@ patternProperties:
>>      $ref: /schemas/remoteproc/qcom,pil-info.yaml#
>>      description: Peripheral image loader relocation region
>>
>> +  "^stats@[0-9a-f]+$":
>> +    type: object
>> +    description:
>> +      Imem region dedicated for storing timestamps related
>> +      information regarding bootstats.
>> +
>> +    additionalProperties: false
>> +
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - enum:
>> +              - qcom,sm8450-bootstats
> 
> This region isn't exclusive to sm8450, it exists also on sdm845 and
> presumably other platforms. Is there any need for an SoC specific
> compatible?

Yes.
https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

Also see many discussions on LKML about this.

Best regards,
Krzysztof

