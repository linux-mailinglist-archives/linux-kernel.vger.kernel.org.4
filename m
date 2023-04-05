Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED2D6D7E0B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbjDENtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237595AbjDENt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:49:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FC8CE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:49:27 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y20so46760560lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680702566;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRVYRoa8ozshD72EL4Ot+Yf75tZYAgHGaKUZVJ5Hh1w=;
        b=weOOOXL6zAOO6ZNgdEln5WMvuA7Spho/qmQx+TOdv0rshX/YS2p666TA1/1/WkLrsu
         K4/FQ11SnU43VuVe8UKNzL4fpKX9mQAvpk4AklJYemjkou1QDTFol8e1apPWMKDtLHxn
         9z2pgaMs26TypTYA+x07EHEdW7AcfCZYwfSjhoS97sG7eNO8wjAFAc3kt/3+6pGfjTMu
         v69LzUZUq8X+ATu7xvt4c2m5SDX5UTLJHKkUY8H+k7wS2ZuoSYAHOmGeEq5rePEwDDc0
         koXrU97O37/pa59/VU+B69PBV2jqs18YcG0hkGt7I0DNzW5eP0JZVTJKQ1Y2rlci401e
         GR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680702566;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRVYRoa8ozshD72EL4Ot+Yf75tZYAgHGaKUZVJ5Hh1w=;
        b=pIxZ0KPFgrGi30UvL7OTKeoY0r/vOh3I/ca/eQbePOtf3vSfoDvj0Nv0HXKzJchXLx
         nt48mORQTdd7qR4TWd0JjEyRqj6vDv8riq8H2ff+I8pnVHbkb2dSEM0wmoYtv0VBjup7
         YPiKb1RY1gAaxeQsMQ2ftOJXRgB3SJW2hpefCa/De2RsTdk7xbcPDWtuk2JMXezaP94g
         I6Em18omhup4B20iSznm+Lc48M0pUt1l/iFuMgV2mXVjDsjTZ9w3zwj3Ioe+xPBW3zEl
         t+X3Nhp82taTaKbvCOAPOyZQblFop0QXFJJCG1KmFC7VkIMjxyV5ODEtib26EZS5z3Ie
         uMpg==
X-Gm-Message-State: AAQBX9f/g3SvWAL4AaLdNPjkFhyworjFMdrz82M/FG0UAMfmWxRWVyO1
        hifUNffy9Pm2wkKRFHl8f+KDoQ==
X-Google-Smtp-Source: AKy350Zrsq00SJ1pSF7aBbAAZy+BMtnGVtMGVGvo5B8KXlB3hq08yM/IsAok5T3J68qTwznWVAdxRw==
X-Received: by 2002:ac2:5106:0:b0:4eb:2523:e929 with SMTP id q6-20020ac25106000000b004eb2523e929mr1499378lfb.43.1680702565968;
        Wed, 05 Apr 2023 06:49:25 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id v8-20020a056512096800b004bb766e01a4sm2846881lft.245.2023.04.05.06.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 06:49:25 -0700 (PDT)
Message-ID: <1e6e2590-ac78-400b-35ce-321d5e52f385@linaro.org>
Date:   Wed, 5 Apr 2023 15:49:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
 <20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org>
 <168069726278.2356075.14351594478003012447.robh@kernel.org>
 <20230405134727.GA2461305-robh@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230405134727.GA2461305-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.04.2023 15:47, Rob Herring wrote:
> On Wed, Apr 05, 2023 at 07:22:40AM -0500, Rob Herring wrote:
>>
>> On Wed, 05 Apr 2023 12:48:34 +0200, Konrad Dybcio wrote:
>>> Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
>>> use 'reg' to point to the MPM's slice of Message RAM without cutting into
>>> an already-defined RPM MSG RAM node used for GLINK and SMEM.
>>>
>>> Document passing the register space as a slice of SRAM through the
>>> qcom,rpm-msg-ram property. This also makes 'reg' deprecated.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>  .../devicetree/bindings/interrupt-controller/qcom,mpm.yaml   | 12 +++++++++---
>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.example.dts:22.35-38.11: Warning (node_name_vs_property_name): /example-0/interrupt-controller: node name and property name conflict
> 
> Looks like this is colliding with the example template which has to 
> craft an interrupt provider for 'interrupts' properties. Either adding a 
> parent node or using interrupts-extended instead should work-around it.
Check the devicetree-org issue linked in the cover letter, please!

I suppose wrapping it in a parent node could work as a temporary
measure, but since it belongs outside /soc, I'd have to make up
a bogus simple-bus, I think.

Konrad
> 
> Rob
