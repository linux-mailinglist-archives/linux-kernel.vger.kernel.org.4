Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06C96FB7D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjEHTzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjEHTzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:55:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD09B76BA
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 12:55:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so52236210a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 12:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683575715; x=1686167715;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6K8tZRHm3ktbeHIa7Lnv7wLaqb40G7qOij8yLE39M0=;
        b=HFQbA/Rp4/5v4RTxWhltNJ+enPCVmZ0mOdENcDnhdh75dD7SDjs9AS2C+A1dDEGEDM
         czgk20ZOaoEl+dmKGAWJ4hdxgsCNct9v2VHGNxrj8x/nfG2MdRHyErmkRfPI60itdcQD
         eduWo+/Egv3YtARV2Rkt5jitJxjbD5RrE7aFkG0RHCKeVB5LQNn/AWoWywuvFPMiUhAH
         gVCJN/zV+acQANIH3o83420zdctQZtpNl5uYi8SBi4L19BayPTcrXBEOtRWxwiC6s3Sj
         c2tRnOCGz++7c4MseTyioH63xRs2Jdy52lUPFemSRlSQcgsvnWrsGaYPPuGJnpOAuiCy
         AsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683575715; x=1686167715;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6K8tZRHm3ktbeHIa7Lnv7wLaqb40G7qOij8yLE39M0=;
        b=ZYjbaV0MhZ1qOWE/CHm/Sb7CCcOJsPKFqRUBsquIZXBo0k61RfCkFq8HnrgrGf1DS0
         HiMZrfgMM+ZNdQdlY173b4qgcGxFxmOV6N5GO8n/HnBwxBMn+mKNK8Cu5s6QIxZ+YgID
         ETlDNQGFJuOGKDmGwqtai2kxdAzsP7l1ZobuPAWa24EbaCS1c4/BeLLeSIxeNT7vOmnS
         XYKViC1qAlB3WMZGMpYEZqtmtH5iap3KuzvxOiy6HtrwfvRAasNkP3AK0ocGXqDmyJ/5
         w92F6cckwguDY18AHW9LhQvCiDXMsdcC85+XWEw8hoXSfIuOnIiQaVTLXmbttQPgND7z
         nmSw==
X-Gm-Message-State: AC+VfDydm3yAKXqsrYs4jcL5As7aWzzLI0jbTI9H5STDusdwaKHPSWP4
        kz8/IEkFVGVn53fBB74NaOKsbg==
X-Google-Smtp-Source: ACHHUZ7Jjn3I+hqyy58I0ppJxc2pCFSnM+O7DU4Mz6qp5o5RVfk+JoJq3v6bNCtOXITFMgbwEPsHsQ==
X-Received: by 2002:a50:ed95:0:b0:50d:a804:423 with SMTP id h21-20020a50ed95000000b0050da8040423mr3155042edr.10.1683575714964;
        Mon, 08 May 2023 12:55:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac? ([2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac])
        by smtp.gmail.com with ESMTPSA id c19-20020aa7d613000000b0050488d1d376sm6461191edr.0.2023.05.08.12.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 12:55:14 -0700 (PDT)
Message-ID: <186bc2b0-21e6-9fae-a273-ec71268bf95c@linaro.org>
Date:   Mon, 8 May 2023 21:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/7] dt-bindings: power: supply: max77658: Add ADI
 MAX77654/58/59 Charger
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
 <20230508131045.9399-3-Zeynep.Arslanbenzer@analog.com>
 <222ed4ee-4122-7ea8-5d94-69976f247599@linaro.org>
In-Reply-To: <222ed4ee-4122-7ea8-5d94-69976f247599@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 21:45, Krzysztof Kozlowski wrote:
> On 08/05/2023 15:10, Zeynep Arslanbenzer wrote:
>> Add ADI MAX77654/58/59 power supply devicetree document.
>>
>> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
>> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
>> ---
>>  .../power/supply/adi,max77658-charger.yaml    | 53 +++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml b/Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
>> new file mode 100644
>> index 000000000000..1b487d82cdbf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/supply/adi,max77658-charger.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Battery charger for MAX77658 PMICs family from ADI
>> +
>> +maintainers:
>> +  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>
>> +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
>> +
>> +description: |
>> +  This module is part of the MAX77658 MFD device. For more details
>> +  see Documentation/devicetree/bindings/mfd/adi,max77658.yaml.
>> +
>> +  The charger is represented as a sub-node of the PMIC node on the device tree.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - adi,max77654-charger
>> +      - adi,max77658-charger
>> +      - adi,max77659-charger
> 
> What are the differences between them? Driver suggests they are
> compatible. Your match data is empty there.
> 
>> +
>> +  adi,input-current-limit-microamp:
>> +    description: Input current limit value.
> 
> Your description is an exact copy of property name. That's not helpful.
> What do you limit? Total current? Charging current? Top-off current?
> 
> You have default value, why it is not here? minimum/maximum?
> 

BTW,  this is duplicating constant-charge-current-max-microamp. If it
has different meaning, you need to explain this in description, not just
say what property name is saying.

Best regards,
Krzysztof

