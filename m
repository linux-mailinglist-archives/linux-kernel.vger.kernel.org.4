Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3DA6F5BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjECQ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:27:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909475258
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:27:37 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50b8d2eed3dso7485450a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683131256; x=1685723256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oofjhUkDBoyhSvfn9xrML4y1PXC5qidRBwwApXpHT6w=;
        b=Bl4pOO1vK6PiYX4R0E5x+2r6wpefXs0TO2KYo0suP/IyYAE/jQZnl1B5t0Tj4qVi1l
         xEKoNmVlUWxmCmnOQBTHZLS/3EF+lFZ3L7fGbfCwK3vjLscktYuQfUqLk2oBr3d9MEgW
         WwjBrMZqWRJbtjgZvJcnJw09Cpuo1oTc3yqXZMdyvZjgY8k8IkivZs3NPjEt85kpmsWQ
         DILKEsm1DwEmd32GhmNrmUlZQhgHTSZXlp6hM+mm2ToeslG01YtJ+CwDfNesTVlzUXDJ
         Bu8a80YnvjDN1pzCDQLMjm0wg16nEodegUiN1zh2gIUWLCrVWboV1luik4BJhhhJJMjA
         V2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131256; x=1685723256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oofjhUkDBoyhSvfn9xrML4y1PXC5qidRBwwApXpHT6w=;
        b=Xbi9fRnG/hz4RhzdRS6Nw+vbRikCbDR3Wv/RjMtKvdYUmaldGDD51RAS5bPPYRL4gP
         XL9AjXJBZijzsD49wzZtUzwVf6L68geOwniEtN+feFfAp4Ao0+njeEJ3Uwe3+pvRjzaw
         xiJux6gXtQ2aqUXkMgoI0Hamaaz2MX+KyF2/V+YhwTqef07q0jX9xN7npm+ys1MNwAT/
         J1HN6BpvsnC8FgyTr2RFJECiICo4j91nbFwuESM9M5dcTgCI54WOWgaVfv0+zGRA3lBU
         /4/rZETWuWf8ufMgvq+cLXcpwGQjJ4eXKaP2d6Tbcb77woEWPKzZgn7z45KI5sHydRee
         aJdA==
X-Gm-Message-State: AC+VfDwcuu/ulU0rG5/rbszEzfyjFZJNjecr0omUZZtHOLvMZEBpNBTg
        Bf/wX645XXFXiweS/QCt2fCWsw==
X-Google-Smtp-Source: ACHHUZ4Heu2hUEMlfp5wVbyQPUTiI0ylQQqFhGqns/GKAE1nOsQMqxyigR11MSo5s4yCryK+QQV6Ew==
X-Received: by 2002:a17:907:1c21:b0:94b:cd7c:59f4 with SMTP id nc33-20020a1709071c2100b0094bcd7c59f4mr3980503ejc.16.1683131255932;
        Wed, 03 May 2023 09:27:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:db42:e3d0:c55a:8cf1? ([2a02:810d:15c0:828:db42:e3d0:c55a:8cf1])
        by smtp.gmail.com with ESMTPSA id ia1-20020a170907a06100b009614fea69e8sm5438304ejc.74.2023.05.03.09.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 09:27:34 -0700 (PDT)
Message-ID: <fdb8e5a9-d8a0-1881-894f-1202ceefcc21@linaro.org>
Date:   Wed, 3 May 2023 18:27:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 01/11] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Rob Herring <robh@kernel.org>
Cc:     quic_sjaganat@quicinc.com, quic_gurus@quicinc.com,
        quic_gokulsri@quicinc.com, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, jassisinghbrar@gmail.com,
        konrad.dybcio@linaro.org, quic_eberman@quicinc.com,
        quic_poovendh@quicinc.com, robimarko@gmail.com,
        mturquette@baylibre.com, mathieu.poirier@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, quic_arajkuma@quicinc.com,
        sboyd@kernel.org, robh+dt@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, loic.poulain@linaro.org,
        quic_anusha@quicinc.com, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com, quic_kathirav@quicinc.com,
        agross@kernel.org, linux-remoteproc@vger.kernel.org
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com>
 <167819522915.3831.12765243745569076133.robh@kernel.org>
 <9de5629f-0a69-7b5b-c312-ab6fe19d60f8@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9de5629f-0a69-7b5b-c312-ab6fe19d60f8@quicinc.com>
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

On 03/05/2023 12:59, Manikanta Mylavarapu wrote:
> 
> 
> On 3/7/2023 6:53 PM, Rob Herring wrote:
>>
>> On Tue, 07 Mar 2023 10:11:27 +0530, Manikanta Mylavarapu wrote:
>>> Add new binding document for multipd model remoteproc.
>>> IPQ5018, IPQ9574 follows multipd model.
>>>
>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>> ---
>>>   .../bindings/remoteproc/qcom,multipd-pil.yaml | 282 ++++++++++++++++++
>>>   1 file changed, 282 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.example.dts:22:18: fatal error: dt-bindings/clock/qcom,gcc-ipq5018.h: No such file or directory
>>     22 |         #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>>        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> compilation terminated.
>> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.example.dtb] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [Makefile:1512: dt_binding_check] Error 2
>>
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com
>>
>> The base for the series is generally the latest rc1. A different dependency
>> should be noted in *this* patch.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit after running the above command yourself. Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>> your schema. However, it must be unset to test all examples with your schema.
>>
> 
> I mentioned dependency link 
> (https://lore.kernel.org/linux-arm-msm/20220621161126.15883-1-quic_srichara@quicinc.com/) 
> in cover page patch because it's required for entire series. I will add 
> dependency link's and raise new patchset.

Is the dependency merged for v6.4-rc1? Looks not, so this means the
patch cannot be merged for next three months.

Why do you need any dependency here in this binding?

Best regards,
Krzysztof

