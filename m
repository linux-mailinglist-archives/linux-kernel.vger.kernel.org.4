Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D72272375F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjFFGOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjFFGOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:14:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DDA106
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:14:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5149390b20aso8559736a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 23:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686032076; x=1688624076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c9/ke8vQiyBtX+dMh7jOybxE1aXL3oACs0/tXuO+L4U=;
        b=eWY5hKNC6JKDtcg4koedkUquXkdz4Qm7ioMxMxeSjG40XG3NTMTnzK7wOpWQfTHpZM
         3UipQrboWk2BEtNpxv9nzlw7CkPmQzMREcltPyxNq7b+1A48GKNiLAYrDYMQDD2CxpgU
         jKFLfBUWdm1nlGtj5XilnON1j3BW3L0Vfde6K1BcsaaJAHUoDPUCrwiygj+BBINUFoQG
         +mfNC3eVh7aFzeMtwa4CM0CjLBCegI8dvl1QgNKPSF62tBw2cUrpCPzE92UTSO/rWrSD
         vKVw291npS8n956cbRw5LDbVtiwsemu4h3S1VOup36wy3m1ZJpmQpb1Djcf4XRP2IgbL
         Tq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686032076; x=1688624076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9/ke8vQiyBtX+dMh7jOybxE1aXL3oACs0/tXuO+L4U=;
        b=KkK2X5KOWOhgHnwc9/mcx40cEdanIXtR3OmLFeSNuGXkCSHxvDhhO7WntnVYx3wagf
         31iR9t5B2Bip3IqmG4BXY9ap4BYmsfWQQd8NPzjRxT2IPIevanf0blBo7jZBSRY5Ijwl
         GcwL4F+Vq5uVi4DnjieBzxkHpSJyCM/rj+YMLGc78haiV13I9amJ5msHLLX79A1UrWoY
         S+xgpEDdiaatJs3ZMRPPaMRaYek2wVQja67Lh9WYj2GiiYjwWy424fNvHC2SX+2JuFpj
         ldKxXmeGYVGdWmKQ/l1w0Vm44OeZvzXXFrmQLBH96kJyUFtkmOgyiPuRkUjAajfVixhd
         /bsw==
X-Gm-Message-State: AC+VfDxPMsi1PSoHY5l6qJ3bcHeeclQ8u61/W/xxm10J20H+I/iUyzIv
        zun6Y6/VE08Upjd1vvoAHf3abA==
X-Google-Smtp-Source: ACHHUZ64Z9lKKWilVnf6tdOypQFOM3iC4izULYvUu+KGcG0PYJwTnO62ZR0THx9JxKoLkPlyBtVhVA==
X-Received: by 2002:aa7:d3c3:0:b0:516:4394:244f with SMTP id o3-20020aa7d3c3000000b005164394244fmr954905edr.12.1686032076496;
        Mon, 05 Jun 2023 23:14:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s25-20020aa7c559000000b005163c39645bsm4672584edr.51.2023.06.05.23.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:14:36 -0700 (PDT)
Message-ID: <d187eafb-4a80-9479-d063-3a01b47d8efa@linaro.org>
Date:   Tue, 6 Jun 2023 08:14:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 01/13] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jassisinghbrar@gmail.com,
        mathieu.poirier@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_eberman@quicinc.com, quic_mojha@quicinc.com,
        kvalo@kernel.org, loic.poulain@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com, quic_varada@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-2-quic_mmanikan@quicinc.com>
 <7940c743-815f-f864-d015-43d7e916ecfa@linaro.org>
 <a1456f62-d0a7-d5ec-b379-db1b6035c89c@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a1456f62-d0a7-d5ec-b379-db1b6035c89c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 14:02, Manikanta Mylavarapu wrote:
>>> +  memory-region:
>>> +    items:
>>> +      - description: Q6 pd reserved region
>>> +
>>> +  glink-edge:
>>> +    $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
>>> +    description:
>>> +      Qualcomm G-Link subnode which represents communication edge, channels
>>> +      and devices related to the Modem.
>>> +
>>> +patternProperties:
>>> +  "^pd-1|pd-2|pd-3":
>>> +    type: object
>>> +    description:
>>> +      In Multipd model, WCSS pd depends on Q6 pd i.e Q6 pd should be up before
>>> +      WCSS. It can be achieved by keeping wcss pd node as subnode of Q6
>>> +      device node.
>>
>> That's not enough. Your description does not say what is this, why you
>> have two protection domains for same compatible. What's more, it a bit
>> deviates from hardware description.
>>
> WCSS means 'wireless connectivity sub system', in simple words it's a
> wifi radio block.
> 
> IPQ5018 SOC has both internal (AHB) wifi radio/WCSS and external (PCIE)
> wifi radio/WCSS. In Q6, Root protection domain will provide services to
> both internal (AHB) and external (PCIE) wifi radio's protection domain.
> So we have two protection domains for IPQ5018, one is for internal(AHB) 
> and other is for external(PCIE) wifi radio.

So it is now in email, but not in the code...
> 
>>> +
>>> +    properties:
>>> +      compatible:
>>> +        enum:
>>> +          - qcom,ipq5018-wcss-ahb-mpd
>>> +          - qcom,ipq9574-wcss-ahb-mpd
>>> +          - qcom,ipq5018-wcss-pcie-mpd
>>
>> Keep rather alphabetical order (so both 5018 together).
>>
>> I also do not understand these at all. Why adding bus type to
>> compatible? This rarely is allowed (unless it is PCIe controller within
>> soc).
>>
> IPQ5018 SOC has in-built PCIE controller. Here QDSP6 will bring up
> external(PCIE) and internal (AHB) wifi radio's. To separate AHB, PCIE 
> radio's properties, i have added bus type to compatible.

It's the same device - WCSS - right? We do not create multiple nodes and
compatibles for the same devices. Bus suffixes are almost never parts of
compatibles.


>>
>> Drop.
>>
>>> +
>>> +unevaluatedProperties: false
>>
>> This changed... why?
>>
>>
> 'unevaluatedProperties' is similar to 'additionalProperties' except
> that it recognize properties declared in subschemas as well.

You don't have to explain me what are unevaluatedProperties or
additionalProperties. Let's assume that I know them. What you should
explain is why you changed it. Where is the reference to other schema?


Best regards,
Krzysztof

