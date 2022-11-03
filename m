Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5FD617CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiKCMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiKCMmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:42:07 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625DDCE15
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:42:06 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id z1so974611qkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 05:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFdGhL73S/+jHEKQ09FOVskOFKjEeT/ObTagmldOE64=;
        b=UhmeO6dkRKxYTsnynk/YmKaLWxoLJBGfhdaWkpXQLT3rL/PT4GHc0w+oNEST+f5Wpu
         5BdVJ8+j3f/X92lXb7YmGoivnrWQM4GlAlOC8rfVWGIn1/NtdDayvaqUmtvAOxavq3fA
         Bx/fE3WzHSdqQx7S9U55JLVyoEmz5rhu7na071j9GRsVUcc5ZIhmE1zUIKzgoR8Gpflk
         cITiBzoaDcwIL1FmZ5tw9ebS22dAO+Dz4AO3SD/1XpIlWDHCCru4v9iVwui2NBb7jORP
         VgiKcuWXv22YucB5k33HTGfleht/wsklijLF6GMU/+0zM6c6iI6xJ0XjY5LuwPPs8fWI
         yzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFdGhL73S/+jHEKQ09FOVskOFKjEeT/ObTagmldOE64=;
        b=EGyPW2NdV+C6jSkyNLDPSTNvPZOWoZKJMqigeo6uNp1/p8OQImSSKCK7VjI7vtJ8Rg
         XTuv23ehcgH0QM/de3Nu1SZ/MPMRF5XmBv3WWjqfh9vGBhr5oipFriDIv6njT0iSsQZF
         KqX0mSOjLHVExpXL3w5bblWo9NyOcbnFJzUqyj+iqi+jFR93+MMvFG/MAp/eMIvhr1Q8
         gLaJhb5M8E5myFr/94y+0dINNEsgUTA7skekD65JVm8u6EaQZFmbu9e1WlzSkSGHbu6X
         o9L3MtNAkysG0mSAQ35noqNBbp+skDrQDhoeVi4fhJnyH4OWRH6KNU7iUjaQ5BzmfnZC
         RxJw==
X-Gm-Message-State: ACrzQf1V3fSB1ZAYgrnxkG6jLHyGz1nZxeGS2J8uwIUBiM3ZmWJjJg/b
        Gusfv9B4Lhbz4Pdv2lcqmfp1xw==
X-Google-Smtp-Source: AMsMyM7R//pf51CVGfWXHj1GX9wXIzb+LdZphgfmS3saxxTdD1hymSha/Gf+R6TY1XxlbN54wUNd2w==
X-Received: by 2002:a05:620a:430a:b0:6f6:589b:463d with SMTP id u10-20020a05620a430a00b006f6589b463dmr21155132qko.139.1667479325519;
        Thu, 03 Nov 2022 05:42:05 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id bm7-20020a05620a198700b006ed138e89f2sm648038qkb.123.2022.11.03.05.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 05:42:04 -0700 (PDT)
Message-ID: <38e1762b-527f-e913-768b-1149486a9f72@linaro.org>
Date:   Thu, 3 Nov 2022 08:42:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 3/3] arch: arm64: ti: Add support for AM68 SK base board
Content-Language: en-US
To:     Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
References: <20221018123849.23695-1-sinthu.raja@ti.com>
 <20221018123849.23695-4-sinthu.raja@ti.com>
 <3f1afad0-1e93-4843-defd-ca32c308cc9e@linaro.org>
 <CAEd-yTTtQhhECw7jSQb38ThaOT_CtFmHy0dJt3SaKxn1KzSgKg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAEd-yTTtQhhECw7jSQb38ThaOT_CtFmHy0dJt3SaKxn1KzSgKg@mail.gmail.com>
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

On 03/11/2022 04:38, Sinthu Raja M wrote:
> On Tue, Oct 18, 2022 at 6:33 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 18/10/2022 08:38, Sinthu Raja wrote:
>>> From: Sinthu Raja <sinthu.raja@ti.com>
>>>
>>> The SK architecture comprises of baseboard and a SOM board. It is
>>> as follows,
>>>
>>>        +--------------------------------------+---+
>>>        |                                      |   |<--Connectors
>>>        |                                      +---|
>>>        |      +---------------------------+   |   |
>>>        |      | SOM                       |   +---|
>>>        |      |                           |   |   |
>>>        |      |                           |   +---| Power Supply
>>>        |      |                           |       |   |
>>>        |      +---------------------------+       |   |
>>>        |                                          |<--+
>>>        |           BASE BOARD                     |
>>>        +------------------------------------------+
>>
>> This is pretty straightforward for SoM, I am not sure what's the benefit
>> to add it.
>>
>>>
>>> AM68 Starter Kit's baseboard contains most of the actual connectors,
>>> power supply etc. The System on Module (SoM) is plugged on to the base
>>> board. Therefore, add support for peripherals brought out in the base
>>> board.
>>>
>>> Schematics: https://www.ti.com/lit/zip/SPRR463
>>>
>>> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
>>> ---
>>>  arch/arm64/boot/dts/ti/Makefile               |   2 +
>>>  .../boot/dts/ti/k3-am68-sk-base-board.dts     | 459 ++++++++++++++++++
>>>  2 files changed, 461 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>>> index 4555a5be2257..498b089d96f8 100644
>>> --- a/arch/arm64/boot/dts/ti/Makefile
>>> +++ b/arch/arm64/boot/dts/ti/Makefile
>>> @@ -19,6 +19,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>>>
>>>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>>>
>>> +dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
>>> +
>>
>> Alphabetical order, although does not look like other entries are ordered...
>>
>>>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>>>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>>> new file mode 100644
>>> index 000000000000..f51cbd2e3b72
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>>> @@ -0,0 +1,459 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>>> + *
>>> + * Base Board: https://www.ti.com/lit/zip/SPRR463
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "k3-am68-sk-som.dtsi"
>>> +#include <dt-bindings/net/ti-dp83867.h>
>>> +#include <dt-bindings/phy/phy-cadence.h>
>>> +#include <dt-bindings/phy/phy.h>
>>> +#include <dt-bindings/mux/ti-serdes.h>
>>> +
>>> +/ {
>>> +     compatible = "ti,am68-sk", "ti,j721s2";
>>> +     model = "Texas Instruments AM68 SK";
>>> +
>>> +     chosen {
>>> +             stdout-path = "serial2:115200n8";
>>> +             bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x2880000";
>>
>> None of these bootargs are suitable for mainline. earlycon for sure - it
>> is pure debug option.
> Krzysztof,
> In AM68 SK the Linux console is on main_uart8, so to be consistent
> with other J7 families of devices aliasing the serial port to ttyS2. I
> am quite confused why these bootargs are not suitable for mainline. I
> check the below documentation section 2.3, as mentioned it can be used
> as kernel parameters. Please correct me if I am wrong.
> https://www.kernel.org/doc/html/latest/devicetree/usage-model.html?highlight=bootargs

Why? Console is defined by stdout path, so why do you need to redefine
it? Bootargs are for debugging so why all users in entire world by
default must debug?

Best regards,
Krzysztof

