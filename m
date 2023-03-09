Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F18D6B1E91
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCIIrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCIIrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:47:05 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0E34333
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:47:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ay14so3910455edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGqSi8rJkPEYNb50K8BZLZGOLTylgAMP+xBcfwszraY=;
        b=uWrOPunOG/IX7IXgMC9nNzBAL3RVSJDMIQAhPRLPF7D7yJ63ZEUf6n4B9kZXT8EJra
         5+lMkJFQGjwuxI/vKqAjH7GCS7/mokXszHTPnV4wsXEkyAViezjc+qd0H9KpnnQXibsk
         cexqB/EpVgwEZTQVDS1OjOmQtO5/c7FKZHQdDC+TJb2EGxdpf/ulhTWLcngwpatM0bqU
         xKMAnSRae3omimeoZUwNa0/Zu6XM4MK1h1k+wy2uTIii0U4oLtklUv/mrZXkWWz1KHg3
         yXLIz1kjPyFqXSHnvpKygQSNhB+OrnXxWB4gRxWbTafxbX/LvQUFLue7GldjnhLB5oAv
         Frow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGqSi8rJkPEYNb50K8BZLZGOLTylgAMP+xBcfwszraY=;
        b=shcMH3d9cHgn0A7p74pJ8h1dqUZjeVhQeOxl8w+S/OPZF/DZr7XGTTP25dmqOTlwIJ
         eb3rCmAQSrNTJ/g8HJNnMESH5cHwj9BVokvgNmBbrWLfEJi3XleXAPGtVSoAsO5lahj1
         wKuQqCnUm5pGcadFPHv23bPM2WvOMumJUaNEES2CZrZ2zlxR2rrm6yLAhvw/vupOIYg5
         eZOqUu7BHkbl6uapUOqLaLDJ3FFXej5tbbcONZCYx0BMfSz8Iv+7A30Vi1fq01FzCQ9L
         SjzhcXV0LbOlzZSMj0OJ1LUkhUGrpYShcMI6gDwbTRtu8fXLMRKWBrpgPX9vaM7m/yJS
         ySrw==
X-Gm-Message-State: AO0yUKXifDdMvwrDzD4aNqHs2ozsCC/8/oGQOJy9DuF1zxHDFqT+4G6j
        cCDDNlgyyo1Aqsc704L+ZY70WQ==
X-Google-Smtp-Source: AK7set8c8UmjoKmMwhvKXt6i586YTl/YQ9n2bzrcv3YZRo7O7HO0PDCg9C2uNGptPLP5DV9WQJiM/Q==
X-Received: by 2002:a05:6402:2028:b0:4af:70a5:55ee with SMTP id ay8-20020a056402202800b004af70a555eemr18130112edb.3.1678351622391;
        Thu, 09 Mar 2023 00:47:02 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id a25-20020a509b59000000b004c0eac41829sm9183008edj.63.2023.03.09.00.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 00:47:01 -0800 (PST)
Message-ID: <2691debf-0596-c265-468f-bb66d19f6db0@linaro.org>
Date:   Thu, 9 Mar 2023 09:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 05/15] dt-bindings: soc: amd: amd,pensando-elbasr: Add
 AMD Pensando SoC System Controller
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>
Cc:     adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, broonie@kernel.org,
        catalin.marinas@arm.com, davidgow@google.com,
        devicetree@vger.kernel.org, fancer.lancer@gmail.com,
        gerg@linux-m68k.org, gsomlo@gmail.com, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        lee@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, p.yadav@ti.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, rdunlap@infradead.org, robh+dt@kernel.org,
        samuel@sholland.org, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, will@kernel.org, yamada.masahiro@socionext.com
References: <e82ca6f6-0870-f9b0-172f-bc6d54a9749b@linaro.org>
 <20230307021822.71245-1-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230307021822.71245-1-blarson@amd.com>
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

On 07/03/2023 03:18, Brad Larson wrote:
> On 06/03/2023 09:35, Krzysztof Kozlowski wrote:
>>> On 06/03/2023 05:07, Brad Larson wrote:
>>>> Support the AMD Pensando SoC Controller which is a SPI connected device
>>>> providing a miscellaneous set of essential board control/status registers.
>>>> This device is present in all Pensando SoC based designs.
>>>>
>>>> Signed-off-by: Brad Larson <blarson@amd.com>
>>>> ---
>>>>
>>>> v10 changes:
>>>> - Property renamed to amd,pensando-ctrl
>>>> - Driver is renamed and moved to soc/drivers/amd affecting binding
>>>> - Delete cs property, driver handles device node creation from parent num-cs
>>>>   fixing schema reg error in a different way
>>>>
>>>> v9 changes:
>>>> - Instead of four nodes, one per chip-select, a single
>>>>   node is used with reset-cells in the parent.
>>>> - No MFD API is used anymore in the driver so it made
>>>>   sense to move this to drivers/spi.
>>>> - This driver is common for all Pensando SoC based designs
>>>>   so changed the name to pensando-sr.c to not make it Elba
>>>>   SoC specific.
>>>> - Added property cs for the chip-select number which is used
>>>>   by the driver to create /dev/pensr0.<cs>
>>>>
>>>> ---
>>>>  .../bindings/soc/amd/amd,pensando-ctrl.yaml   | 60 +++++++++++++++++++
>>>>  1 file changed, 60 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>>>> new file mode 100644
>>>> index 000000000000..36694077b2e6
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>>>
>>> Your subject suggests this is pensando-elbasr but you write everywhere
>>> pensando-ctrl. Confusing. Pick one.
>>
>> Actually pensando-ctrl is for sure not correct, because it misses the
>> name of the SoC (you call it everywhere "elba").
> 
> The reason I dropped elba as part of the name is this driver and its associated 
> SPI attached device (cpld or fpga depending on the board design) will be used
> across a series of SoCs starting with Elba.  Implying its Elba specific is misleading.

Compatibles must be specific.
https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
If this is SoC part it must match SoC. What is misleading in this? Why
Pensando is different than all other SoCs (I am really getting tired
everytime asking why people think their solution is special)?

If this is not part of the SoC, then your commit msg is misleading.
Maybe bindings as well, so rework it.

Best regards,
Krzysztof

