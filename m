Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13208621369
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiKHNuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbiKHNuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:50:04 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C673245A19
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 05:50:02 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g7so21335292lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 05:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UOTLJIJjlKyMFsd4bjanGUmZl8YyXauAhu1BAnXo0k=;
        b=VlACUCZj5v6rL3K9IrtTakH0zJT4XXALH/f5eC4uaMyl4GCs28MQKq/ys/EZ8E16QU
         DExi4+RdcDQ6W+97Ur/sL7Do7Rx/qjo198KUCzxH0jcAsIU+JrAB6SmeMaNes/I/T3w3
         MBNY/4KNZKAlOhzyFLTIcUhO4p1VwqngwiAZAltPGg44OWXXS2+Grg3MnniQXc6RppeY
         s5FUuoAwWz0jwmEEenLLNw9jbdZm9S0C+8JK8jJS4SFzPVx1x1IaZkYt719levAbr2mj
         uvXXgW+tsTCogDm/fzlqRhJ9l/dYahIdUAaL9jcHYg2+EPZZo0g1LCuGd7L9SA9wayId
         Ys0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UOTLJIJjlKyMFsd4bjanGUmZl8YyXauAhu1BAnXo0k=;
        b=GmTsUc4XZwxXP15K5pM2k8LUI7kKLXz+rIoTMnVoXa5FrZTzmMArUrHNl8FYNI4UAg
         GEiRhPCC6wJgDkebbpD/t7ic/TrFr2qI8SJmmaUKlVcg4YTbVvF2zzpOyYC+G7dM85X2
         Bo498pBeLF/ZbHAP6uKylLH4sXVlaTnQfTmHTuGHrfL8t0TS/X3RWu6AZ/BPibllcOAn
         8W2ByClxmIImgzjpriJb1txcMg0/NrP161sVpMBDqumEOxrmJknkK5htHEa9577fhM2s
         xLqyty2E57NY0r3QsQoXdZ+PGm43zLCEOucBFVRZukZnAbTjJUypSAkvYzbK56NjuC1Z
         svxA==
X-Gm-Message-State: ANoB5pmCseoPnJuCrHo1C1wRSOsckZHDBLQB0fOxI7/p5a62arJDlpBp
        fy3ZdB00Ro5IxlW8dYIMSxqTDQ==
X-Google-Smtp-Source: AA0mqf7uG7BBXftt8g/nQ97DInOy3cCUyJC9Dq/me1lOdWMWoc2EK7UGJ1E8I7haQZUQqmrsgVKiCw==
X-Received: by 2002:a19:6758:0:b0:4b4:c0c:8c64 with SMTP id e24-20020a196758000000b004b40c0c8c64mr801216lfj.122.1667915401027;
        Tue, 08 Nov 2022 05:50:01 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id j29-20020a056512029d00b004ac980a1ba1sm1794354lfp.24.2022.11.08.05.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 05:50:00 -0800 (PST)
Message-ID: <2a2385a0-0055-aeff-cd7c-71270dd4e561@linaro.org>
Date:   Tue, 8 Nov 2022 14:49:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 4/4] dt-bindings: soundwire: Convert text bindings to
 DT Schema
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org
Cc:     Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
References: <1667911156-19238-1-git-send-email-quic_srivasam@quicinc.com>
 <1667911156-19238-5-git-send-email-quic_srivasam@quicinc.com>
 <ec87eaa6-2e76-db16-f300-686a92e4f324@linaro.org>
 <b8175f2a-0096-80d4-5733-26ce9f7fd437@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b8175f2a-0096-80d4-5733-26ce9f7fd437@quicinc.com>
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

On 08/11/2022 14:29, Srinivasa Rao Mandadapu wrote:
>>> +  qcom,ports-block-pack-mode:
>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>> +    description: Indicate the block packing mode.
>>> +                 0 to indicate Blocks are per Channel
>>> +                 1 to indicate Blocks are per Port.
>>> +                 Out ports followed by In ports.
>>> +                 Value of 0xFF indicates that this option is not implemented
>>> +                 or applicable for the respective data port.
>>> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
>>> +    minItems: 3
>>> +    maxItems: 8
>>> +
>>> +  qcom,ports-hstart:
>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>> +    description: Identifying lowerst numbered coloum in
>>> +                 SoundWire Frame, i.e. left edge of the Transport sub-frame
>>> +                 for each port. Values between 0 and 15 are valid.
>> minimum: 0
>> maximum: 15
>> and drop that one sentence.
>>
>> The same in other places.
> 
> As below mentioned it will also have 0xFF value. I think we can't 
> restrict with minimum and maximum values.
> 
> Please suggest if my understanding is wrong.

Then (and it is actually an array):
minItems: 3
maxItems: 5
items:
  oneOf:
    - minimum: 0
      maximum: 15
    - const: 0xff

> 
>>
>>> +                 Out ports followed by In ports.
>>> +                 Value of 0xFF indicates that this option is not implemented
>>> +                 or applicable for the respective data port.
>>> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
>>> +    minItems: 3
>>> +    maxItems: 5
>>> +
>>> +  qcom,ports-hstop:
>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>> +    description: Identifying highest numbered coloum in
>>> +                 SoundWire Frame, i.e. the right edge of the Transport
>>> +                 sub-frame for each port. Values between 0 and 15 are valid.
>>> +                 Out ports followed by In ports.
>>> +                 Value of 0xFF indicates that this option is not implemented
>>> +                 or applicable for the respective data port.
>>> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
>>> +    minItems: 3
>>> +    maxItems: 5
>>> +
>>> +  qcom,ports-block-group-count:
>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>> +    description: In range 1 to 4 to indicate how many sample
>>> +                 intervals are combined into a payload.
>>> +                 Out ports followed by In ports.
>>> +                 Value of 0xFF indicates that this option is not implemented
>>> +                 or applicable for the respective data port.
>>> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
>>> +    minItems: 3
>>> +    maxItems: 5
>>> +
>>> +  label:
>>> +    maxItems: 1
>>> +
>>> +patternProperties:
>>> +  "^.*@[0-9a-f],[0-9a-f]$":
>>> +    type: object
>>> +    description: Child nodes for a standalone audio codec or speaker amplifier IC.
>>> +                 It has RX and TX Soundwire slave devices.
>> s/slave/secondary/
>>
>> This is some odd indentation. Please use standard, like example-schema
>> is showing, so:
>>
>>      description:
>>        Child nodes for a standalone audio codec or speaker amplifier IC.
>>        RX and TX Soundwire slave devices.
>>
>> It looks you used such pattern in other places here - they should also
>> be corrected.
> Okay. Will change accordingly.
>>
>>> +    properties:
>>> +      compatible:
>>> +        pattern: "^sdw[0-9a-f]{1}[0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
>>> +
>>
>> Best regards,
>> Krzysztof
>>

Best regards,
Krzysztof

