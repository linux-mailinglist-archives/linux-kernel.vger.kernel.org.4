Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E82F6C2D83
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjCUJEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjCUJE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:04:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777AA728B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:03:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso10649701wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679389424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PFpQeuwuxYq7wZtArv5D2lpNhMJ5VsJ2OapWoAXxd/s=;
        b=3K9ISW/+lEplq2clx8BsC7oSBcfy6iDwr04Lm4F9DXwz+uwzKB/96L6qnmdK85eX8O
         /S0kPjZ79fO9n5GLcQ1WwC2qKdoMxtsx13O0kyDZqQoMI3Pn5xeN44fh/q0Kue9l9qoM
         pWmJCbTYn5LpY9z5LcmUR9OZE4zfUEIRHrnD97z3fpPrmRAHs89iXB281xNobfae43bc
         Xe5g8E3ijju3Jo/IZbsOhb8PJhRuuNnlSqS4ff7FYoJkFxFvKG22v/YbPOtmAm+rN3/j
         /cqE8qTyF+Y87xnDUj9vUT0+1YTX+4cP4KqZbY2A/nZWIkLkHvBSFXACH45c1/xErqAJ
         lgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679389424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFpQeuwuxYq7wZtArv5D2lpNhMJ5VsJ2OapWoAXxd/s=;
        b=THjQsQVYkMJlvsnvmB0OJ3ss6H30WPbx8ZQmJ1oEUr6tEccvjBj2Mr2bTpTzPQszTe
         EFHA2kyIFhnMlqhhGR5PyHjeF3XCR6su5hUuZyaI97yV381ochtx4GMzEQGOBlPO6DA2
         xOThPJiARldm+Igh/W8Hxmi53IPyTUeXHOyAWmvZB4i9fH/Sq/Di//sGu4VJMiY8nzsC
         JSnSuiVvac4DgQV2Ep+44zuwqdPHpSK/yAr+2uE0gEdexamnH82uKIYQKmgHTCgFtVld
         aokM3acOIqPnshArdj6gKm+tM9x0igOacEQxfPqFj15xLvNfRfSEL2no/VI/bwVyTbia
         cgYw==
X-Gm-Message-State: AO0yUKVNwhEA9j2Dk7KWSYBNYHqkWDdKjLF3ZjaCqvee6cM6uiGDZrAF
        L8PEsiy/yRZsxFnqfmOXHUhJhQ==
X-Google-Smtp-Source: AK7set9/QFtumvHHRHPszzfZDMpsCX6rvKpHJaht7S8cuL3hzwKKJHx3HKC7jKSNqzrx0mk9iRM7wA==
X-Received: by 2002:a05:600c:228d:b0:3ed:a07b:c591 with SMTP id 13-20020a05600c228d00b003eda07bc591mr1775142wmf.1.1679389423904;
        Tue, 21 Mar 2023 02:03:43 -0700 (PDT)
Received: from [192.168.1.70] (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bcb90000000b003edf2dc7ca3sm5600424wmi.34.2023.03.21.02.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 02:03:43 -0700 (PDT)
Message-ID: <887d5e71-334c-b206-08e6-2cc822df9eda@baylibre.com>
Date:   Tue, 21 Mar 2023 10:03:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: Add TI TPS6594 PMIC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     lee@kernel.org, krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        eric.auger@redhat.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, davem@davemloft.net,
        christian.koenig@amd.com, contact@emersion.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
References: <20230315110736.35506-1-jpanis@baylibre.com>
 <20230315110736.35506-2-jpanis@baylibre.com>
 <20230320155354.GB1733616-robh@kernel.org>
 <04914464-2bc2-9d86-e9e2-8a716b929f28@baylibre.com>
 <2dcfd9dc-6c43-20b7-e27b-8ec2883be237@linaro.org>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <2dcfd9dc-6c43-20b7-e27b-8ec2883be237@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/23 08:36, Krzysztof Kozlowski wrote:
> On 20/03/2023 17:35, Julien Panis wrote:
>>
>> On 3/20/23 16:53, Rob Herring wrote:
>>> On Wed, Mar 15, 2023 at 12:07:33PM +0100, Julien Panis wrote:
>>>> TPS6594 is a Power Management IC which provides regulators and others
>>>> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
>>>> PFSM (Pre-configurable Finite State Machine) managing the state of the
>>>> device.
>>>> TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
>>> As mentioned, the binding needs to be complete. It's missing GPIO at
>>> least. RTC and watchdog may or may not need binding changes.
>> Thank you for your feedback.
>>
>> About GPIO, do you speak about 'gpio-controller'
>> and/or '#gpio-cells' properties ?
> Yes.
>
>> For RTC (and for watchdog, once the driver will be
>> implemented), our driver do not require any node
>> to work. What could make an explicit instantiation
>> necessary in DT ?
> Properties from RTC schema, e.g. start-year, wakeup etc.

TPS6594 RTC driver is being reviewed (this is another patch
series, not merged yet). These properties are not used by our
driver, that's why we did not have to add some RTC node in
the DT (until now, using such properties in our driver was not
requested by RTC sub-system maintainers).

>>>> +  ti,spmi-controller:
>>>> +    type: boolean
>>>> +    description: |
>>>> +      Identify the primary PMIC on SPMI bus.
>>> Perhaps the property name should include 'primary' and 'pmic'.
>>> Otherwise, it looks like it is just marked as 'a SPMI controller'.
>> Including 'primary' and 'pmic' will be more understandable indeed.
>> I will change that in v3.
>>
>>>
>>>> +      A multi-PMIC synchronization scheme is implemented in the PMIC device
>>>> +      to synchronize the power state changes with other PMIC devices. This is
>>>> +      accomplished through a SPMI bus: the primary PMIC is the controller
>>>> +      device on the SPMI bus, and the secondary PMICs are the target devices
>>>> +      on the SPMI bus.
>>> Is this a TI specific feature?
>> I don't think so. I will double-check that.
>> If not, shall I remove the 'ti,' prefix ?
> Somehow reminds me qcom,bus-id, but the wording and code are not exactly
> the same. The question here is whether this is generic feature of all
> SPMI devices or PMICs, or device specific. If it is generic, then naming
> and type should be chosen a bit more carefully and then indeed skip
> "ti," prefix.

Apparently, it's not TI specific. Besides, all the information
I found about SPMI were related to PMIC devices. I have to
double-check with TI, though.
I will either rename it to 'ti,primary-pmic' if TI specific or
'primary-pmic' if not TI specific.

>
>>>> +
>>>> +  system-power-controller: true
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  ti,multi-phase-id:
>>>> +    description: |
>>>> +      Describes buck multi-phase configuration, if any. For instance, XY id means
>>>> +      that outputs of buck converters X and Y are combined in multi-phase mode.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum: [12, 34, 123, 1234]
>>> coupled regulator stuff doesn't work here?
>> Coupled regulator stuff works here.
>> Is it also necessary to specify some 'allOf' logic here to ensure
>> that mutual exclusions described below (for regulators) will be
>> applied ?
> None of other regulators do it but you could add something.
>
>
> Best regards,
> Krzysztof
>

