Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BA163EFB7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiLALmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiLALlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:41:55 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0596F9582D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:41:52 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id d6so2048464lfs.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0UiAnxiG5gru9IeukT0uPFqmufGik114HWN4x39w6FA=;
        b=zopg1txRN5QgqaXfvugj89RD4LqFxqoqVjHWRsqgKB0npSUazcU7D9c2uZ9eF+aBjn
         YF6qfci1wHSt4AFzDdaT6TP9OhQ3Mdaza3DpmSV5hpIUekk3KR80oodi3SN9yWI5tGS6
         BuQ4A1vklebhvhifCHCdZnMSoSeCWvFM/Ob8qdlXPxy4zsG7kk5g+VQP3o6YbOTvD/iZ
         2WoTXkrwVdgV3weLjEU6HWVghtCCvmbFUyO94sTViyHwjHW1koa5iH6wuV0IKiROfrwq
         tf+I6a/cjSMNzM9dEX7KO+nfOz8/O/3aZxCS+RhXktnqnxBEzb01V5YJ95RsD8VHUo5a
         Jrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UiAnxiG5gru9IeukT0uPFqmufGik114HWN4x39w6FA=;
        b=2ou4lMOmyoxLdajqqe85eGRdoe1WyvvtJ2oN8YznnrBkbsqxiqd60uCvWUDhMqNF1A
         GuxVj03aAaU+4Gq5fMNU7H13jHOncUI/1u9mr0+erpxdi1mKuPMiVrYt8Qd8WZ77zk3/
         62/klLe1PiBrq7Vj6o/q324O455xXBQ7KCn2Yjb6W85D2k7PzxXVa1Kdag5/zJg+sP4v
         behVKhaZH1yHqBu9AGU/klEN5wYAhb/e0oUTPF2ssrj5VOUvE6P9HHsByNVS9xH/uooN
         begS1LZSQM42gk8QDbOTqQC1TnyfnOcWOxBqKuC6eVXe/GjUPCLwPlr0+LM/JXufZEEK
         Lyrg==
X-Gm-Message-State: ANoB5pk3+dcmkBAy+ykF+ZJIwHKg/4ja2OEY89kcdV8pcR6q8PhzBlnq
        ir4QokWzJrnAEzopztjMK6pbAA==
X-Google-Smtp-Source: AA0mqf5NJwSDFJVZ4ee0obiZShaUI/uPkLiEO75TR/uSDPOAHIZkEPvJJ1JC3LaLkJUeMh2M4XFoqQ==
X-Received: by 2002:a05:6512:a83:b0:4aa:f944:f7ec with SMTP id m3-20020a0565120a8300b004aaf944f7ecmr17809472lfu.467.1669894910308;
        Thu, 01 Dec 2022 03:41:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w10-20020a05651234ca00b0048a8c907fe9sm612837lfr.167.2022.12.01.03.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 03:41:47 -0800 (PST)
Message-ID: <a1d8197e-33fa-e853-ab73-81b167ec45ec@linaro.org>
Date:   Thu, 1 Dec 2022 12:41:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 5/9] dt-bindings: riscv: Add bouffalolab bl808 board
 compatibles
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-6-jszhang@kernel.org>
 <60991459-945f-35db-f26a-fb27824728ad@linaro.org> <Y4iMrKjLAHpkCygo@wendy>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y4iMrKjLAHpkCygo@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 12:14, Conor Dooley wrote:
> Hey Krzysztof,
> 
> On Thu, Dec 01, 2022 at 12:05:04PM +0100, Krzysztof Kozlowski wrote:
>> On 27/11/2022 14:24, Jisheng Zhang wrote:
>>> Several SoMs and boards are available that feature the Bouffalolab
>>> bl808 SoC. Document the compatible strings.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>> ---
>>>  .../bindings/riscv/bouffalolab.yaml           | 34 +++++++++++++++++++
>>>  1 file changed, 34 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/riscv/bouffalolab.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/bouffalolab.yaml b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
>>> new file mode 100644
>>> index 000000000000..91ca9dbdc798
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
>>> @@ -0,0 +1,34 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/riscv/bouffalolab.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Bouffalo Lab Technology SoC-based boards
>>> +
>>> +maintainers:
>>> +  - Jisheng Zhang <jszhang@kernel.org>
>>> +
>>> +description:
>>> +  Bouffalo Lab Technology SoC-based boards
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    const: '/'
>>> +  compatible:
>>> +    oneOf:
>>> +      - description: Sipeed M1s SoM:
>>> +        items:
>>> +          - const: sipeed,m1s
>>> +          - const: bouffalolab,bl808
>>
>> I don't think that SoM is usable alone. It always needs a carrier, so
>> drop this entry.
> 
> For my own information, if a SoM is not capable of functioning without a
> carrier there is no merit in it having a compatible?
> Does this also apply if there are multiple possible carriers from
> different vendors?

Compatible makes sense anyway. There will be different boards using this
SoM (not only carriers, but final products) and they all will have
common piece - the SoM. It's the same for other SoM designs (e.g. for iMX).

Best regards,
Krzysztof

