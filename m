Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10D56320BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiKULeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiKULdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:33:43 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2483A3057F;
        Mon, 21 Nov 2022 03:29:29 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n20so27929508ejh.0;
        Mon, 21 Nov 2022 03:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5wAGqxHFekK2a3K2dnGtE+wgtyOKfjyzcWPwOBM3e4=;
        b=hHGRc+ErTgVBmDvQpU9tTYMO6uC7Unl0nVAMHyEK7UY8zQO8787ASrZ0ZInLZL0MqD
         ETbvZNNr4I18qonBpjwUxchDp8HAgYQQiqj2+3lPzCvImGmWb7PNdoWHBw5qlDqjqiNT
         L9zkXLA0djixZGILG9S5CIFJVzu0oWe8tK6aPtghfpec9Rl66sl71Jw3rEE0dkG/5SPY
         +TJVnLtXjpGleHAzfeUOtulCSRF/+fGEvgYhEZLUSEmBOxx+gV2DvmyWhMlzhiaJfhvU
         +MJGAfMQy8drTOWd7pv2mx3fXv1YiJkUda64YVsR+pO8wtngAsRk/Rpwm5uDkxoCW+0p
         flxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p5wAGqxHFekK2a3K2dnGtE+wgtyOKfjyzcWPwOBM3e4=;
        b=ZRTAEikTBvLEsGJfna5/HK7TlNbG7MguzzXEt6OrmxkJjxTeCFQoo4vRLS4acXRuzZ
         lj/r6fjJSoFLKees/ddw+3X2TA3ZCpx4NsMoS5O4OS5OvVHs6RhDBEFBkIlTRvibP9m7
         d4jqY7laFUgrCeJAosC5ys1QkLq+KH58AWrKj07GNRoEh12c/9qIrSdoGs2dzfMqRXBn
         W9h0ImhBnCZK7V+Qzv+eoldIDCSyovN1IY+iEjPMa2bV8PjoGoe1UEEUNuUAumcJbbF7
         XAj7CZxUElIWQwJTCo99VgD3TalkTGhQhwEIkWvZ1l/gRTV0Cvl1vCiJqDHtsbSKpoLx
         9bRQ==
X-Gm-Message-State: ANoB5pmqdEno/g+c28FzrJihzg6Q/okfjZFzngZult4kDTPxRMuvSX6L
        CIUfKzeIJQvus06drvhLhP0=
X-Google-Smtp-Source: AA0mqf4yRlIfdY/MUfL3UoaCa7+S+Ok0mR2+dPe7bQkvja+lPtuJ4zId7zkYJDriUe88r4sgje+z6A==
X-Received: by 2002:a17:906:a8a:b0:7ae:6cdd:9bc9 with SMTP id y10-20020a1709060a8a00b007ae6cdd9bc9mr14614529ejf.619.1669030167659;
        Mon, 21 Nov 2022 03:29:27 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id o13-20020a170906768d00b0073dc4385d3bsm4857902ejm.105.2022.11.21.03.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:29:27 -0800 (PST)
Message-ID: <36b1389a-f08c-96df-47d5-e8ca93b9f8ab@gmail.com>
Date:   Mon, 21 Nov 2022 12:29:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH dt-schema.git] schemas: add NVMEM cell with
 #nvmem-cell-cells
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20221121105830.7411-1-zajec5@gmail.com>
 <259ad74e-ec86-34e6-661f-7b7b172c4ddd@linaro.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <259ad74e-ec86-34e6-661f-7b7b172c4ddd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.2022 12:25, Krzysztof Kozlowski wrote:
> On 21/11/2022 11:58, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Some NVMEM cells may provide more than 1 value. An example can be base
>> MAC address that is used for calculating multiple MACs (for few
>> different devices). For specifying value to read phandle needs to be
>> used with an argument.
>>
>> Cc: Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>
>> Cc: Michael Walle <michael@walle.cc>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>> This bit is required for moving forward with the
>> [PATCH v2 00/20] nvmem: core: introduce NVMEM layouts
>> https://lore.kernel.org/linux-arm-kernel/20220901221857.2600340-1-michael@walle.cc/
>>
>> As pointed out by Rob #nvmem-cell-cells should be added to the dt-schema
>> and not a Linux binding:
>> Re: [PATCH v2 15/20] dt-bindings: nvmem: add YAML schema for the sl28 vpd layout
>> https://lore.kernel.org/linux-arm-kernel/20220912192038.GA1661550-robh@kernel.org/
>>
>> sl28 is one example that needs #nvmem-cell-cells
>> u-boot,env is another one
>>
>> Please let me know if I got this binding right at all.
>> ---
>>   dtschema/schemas/nvmem/nvmem-cell.yaml | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>   create mode 100644 dtschema/schemas/nvmem/nvmem-cell.yaml
>>
>> diff --git a/dtschema/schemas/nvmem/nvmem-cell.yaml b/dtschema/schemas/nvmem/nvmem-cell.yaml
>> new file mode 100644
>> index 0000000..dfa99b8
>> --- /dev/null
>> +++ b/dtschema/schemas/nvmem/nvmem-cell.yaml
>> @@ -0,0 +1,23 @@
>> +# SPDX-License-Identifier: BSD-2-Clause
>> +$id: "http://devicetree.org/schemas/nvmem/nvmem-cell.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/base.yaml#"
> 
> Drop quotes from both.
> 
>> +
>> +title: NVMEM Cell Common Properties
>> +description: "Schema for NVMEM cell devicetree bindings"
> 
> Drop quotes.
> 
>> +maintainers:
>> +  - Rafał Miłecki <rafal@milecki.pl>
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +
>> +# always select the core schema
>> +select: true
>> +
>> +properties:
>> +  "#nvmem-cell-cells":
>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> 
> Drop quotes.
> 
> Rest looks fine to me, except a bit funny cell-cell name, but that's
> just life. :)

Bothers me a bit too, I was even thinking about renaming NVMEM cells to
NVMEM entries but I'm not sure if it's not too late for that.

We already have "nvmem-cells" and "nvmem-cell-names" properties so
adding "entries" not would be probably confusing.


>> +    description: >
>> +      Some NVMEM cells may consist of raw data that requires some extra
>> +      processing. They may provide more than 1 value.
>> +
>> +      Passing extra argument(s) allows selecting data to access.
>> +
>> +additionalProperties: true

