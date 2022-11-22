Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6E1633641
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiKVHtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiKVHs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:48:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1C01CFC0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:48:53 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g7so22381194lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w8q3Tqkz8w1zflvZZbd0OuOuonoFEDMsSq7hmze9ZXs=;
        b=f22yi+xqcXW5FuVe86BK3lfg/qHcmgA6lPlQYRor0guywILgg2/Eu8BXRhWBeHNqZW
         7disWPEBD8MNJ8mTXIA93ijDCHLI+xvcdLJAMrwPhMYSAOBEZNNJ5QEbh2Ayzg9MOwjY
         xXcJqUrJAK92bqRiUG/odLy246dSDHkG/MdDWCDR18UqrhOwDRT3SaZ2itdY/L3RVkOB
         RHIwgY16YjxMa0hGGdzcEmj9D6+rRNeLQUEsmaupAOrrt8o9NQ8wRms+G+suKoY1kk7T
         ZghDqMaNX/onLP8n7MOm/ztfRlJxJlD0NFSjopAtEaZJcg632nwzMk1CYHuWVlr75KBG
         vp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8q3Tqkz8w1zflvZZbd0OuOuonoFEDMsSq7hmze9ZXs=;
        b=16pzg/rNnUBr+UsO8b9ODZ219zxhZyQoi/SI9gk6e+OtJhyvi3B0PUUh9fc0yr6iPs
         8eXyvAN3ZWdh3S1MXnw1EIeUdO2zCjf5TtIkS69aoM91M9eE1POAxh9wVt3zzh3cwngk
         FgmGYYoILrkh0YDIrM9K0xnYuNWdTrI8OJnWKX/CVWmgw2h8kZcVJlJy+e1eJPc5EEx9
         +ZM20bpJo0o15f8PYZhM1w3ocpgNmJpUKE65kEA2NqQYyFMqRWfhveCpQozZcb/97ovu
         wm8V2RShtnkNna+SEsajJhh0jTqBEct8WGRjVtPDqUegx21djtqi8F4oRilZbVVEKPQl
         hQdQ==
X-Gm-Message-State: ANoB5pmpa8T83qyuSR6dpDy0uqJlM0aEtifMEuJcyMP+uf3jUpeMrvLr
        ja29ytaFoyOgrA+lUKXqBuXoxg==
X-Google-Smtp-Source: AA0mqf6WFY2yzKLlEyj7ARsSRDcmrYj2hSJMjEFCY4gK/zwWuhI0/ySHS9KM1Lz0QLbU+127L2b44Q==
X-Received: by 2002:ac2:4c29:0:b0:497:a1fe:b0ef with SMTP id u9-20020ac24c29000000b00497a1feb0efmr8392775lfq.311.1669103332101;
        Mon, 21 Nov 2022 23:48:52 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id be34-20020a05651c172200b0026bf43a4d72sm1719731ljb.115.2022.11.21.23.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 23:48:51 -0800 (PST)
Message-ID: <03174a04-440d-a840-1e54-fbdbdfe296c3@linaro.org>
Date:   Tue, 22 Nov 2022 08:48:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and
 QRU1000 pinctrl
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118182039.29236-1-quic_molvera@quicinc.com>
 <20221118182039.29236-2-quic_molvera@quicinc.com>
 <528648f2-17df-ab19-8ad4-76423bbc0ae4@linaro.org>
 <faf2d137-efab-93ab-f325-1fa507f166a7@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <faf2d137-efab-93ab-f325-1fa507f166a7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 21:38, Melody Olvera wrote:
> 
> 
> On 11/20/2022 4:58 AM, Krzysztof Kozlowski wrote:
>> On 18/11/2022 19:20, Melody Olvera wrote:
>>> Add device tree bindings for QDU1000 and QRU1000 TLMM devices.
>>>
>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>> ---
>>>  .../bindings/pinctrl/qcom,qdu1000-tlmm.yaml   | 134 ++++++++++++++++++
>>>  1 file changed, 134 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>>> new file mode 100644
>>> index 000000000000..cb0c496d8666
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>>> @@ -0,0 +1,134 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pinctrl/qcom,qdu1000-tlmm.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm Technologies, Inc. QDU1000/QRU1000 TLMM block
>>> +
>>> +maintainers:
>>> +  - Melody Olvera <quic_molvera@quicinc.com>
>>> +
>>> +description: |
>>> +  This Top Level Mode Multiplexer block (TLMM) is found in the QDU1000 and
>>> +  QRU1000 platforms.
>> It's better to keep consistent style which allows to do easy
>> search/replace, than to have new files using their own sentences. So
>> keep it the same as was unified in few recent commits.
> 
> Ok... Just making sure that's what you want. Last PS you gave comments to change
> the wording of this description to remove "This binding describes..." as we've done
> in all the other qcom pinctrl/tlmm bindings. I can change the wording back to the
> original, just want to be clear here.

I propose to have the same wording as other Qualcomm TLMM bindings,
however you changed it to something not the same. Therefore I wonder -
why having here different wording than all other bindings?

By going back to original - what do you mean? If it matches all others,
then yes, but I doubt it.

Just to be sure - are you working on proper (recent) trees or something old?

Best regards,
Krzysztof

