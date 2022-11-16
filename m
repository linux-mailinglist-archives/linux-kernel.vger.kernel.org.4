Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E881B62B654
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbiKPJVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiKPJVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:21:51 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3675C2649A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:21:50 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j4so28605270lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJGDgjAYzHCIAoX8j9X+fWTaQJQAOPrS/p0kAef7wxk=;
        b=mONqG2odwNB/ARB8TqLKMmsnA7B9r4RtzDzCL4dTrWPhIpL+hWl+10qbXl06om0viA
         0ESHfIhTmuhMlBRdsNtdpkUKM5ebg/XE78C6BcPy+8h6FZfdmqiP52vni3I4IxG7jPl8
         qOQmDIBEVmohMeEuB95jnypjds7X3SGSPV+polz9oseF5fV3vCuFdUMTVDnwETHrrWr0
         vndpVI0jggOcMjStfg9G12FGcXbJ9ke2U9bsuXO0rhiFyJWeXVtJI4hp8xsPTaDJ4LHg
         DrCvcHqzLhKR61b5cewymmGG8fArZll1lsttXnFHKcN4kKRTyzcVGEtxqCJ4tMb4MI0k
         fqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJGDgjAYzHCIAoX8j9X+fWTaQJQAOPrS/p0kAef7wxk=;
        b=BJIjkFKOC+AhJNFL/jL49rzTqMQdsCLdYo/z/TwkCDDgZe1XqtzFqniTvKC6/957Ja
         gYppr0ANzcqacarNSn8EqGARGe/FJQ2f7xElDa5jZp7/SNN7yThEbRjQtz1DyqHxVHbx
         sX4ZoLPVWMOSBZyHDKSErMjiUlBbAtUfH3WRNMs/id3mbs6bnr5k467iBTGihQ6LUKyl
         kdJmR95qq0RgTi7ZdzODYYUKzfMlPH74favpuG0VK3NF2w55oBnuw5UqIwHM5CNQMOK0
         PGgK5j1xnxODcirmG6OHFy+NCSUW1Bwn+Vah/Of7k8UTK0oRtQkOe/Y1gQKePU0bf0Mw
         WnCw==
X-Gm-Message-State: ANoB5plWjhBve0Ypzy+srOdt0GTRodKamdCf0ylub12iMaxyuYJKvvnU
        kn2jQRY1FaZ6wUGLXw7ZXg9JCQ==
X-Google-Smtp-Source: AA0mqf4nQfEaPTARH+N7BGurePdhUCQlFUm5bUoqFbP9cLw0sv+nR0LJaVhlKtPAqmlhccJ75cNTgg==
X-Received: by 2002:a05:6512:370e:b0:4a2:4560:61e7 with SMTP id z14-20020a056512370e00b004a2456061e7mr6727723lfr.170.1668590508579;
        Wed, 16 Nov 2022 01:21:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a22-20020a056512201600b004b48cc444ccsm2399043lfb.100.2022.11.16.01.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 01:21:48 -0800 (PST)
Message-ID: <60e8ed22-b865-2ba1-1e34-248159746ea6@linaro.org>
Date:   Wed, 16 Nov 2022 10:21:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/9] dt-bindings: Add RISC-V incoming MSI controller
 bindings
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-5-apatel@ventanamicro.com> <Y3EDuaW0zQSSfiQ/@spud>
 <CAK9=C2WDQCnVnxKR6SFspdwope2KffyASLJDF_Ygo_417ekJ5w@mail.gmail.com>
 <Y3QT5Vy3RnIXobHz@spud> <3037b4f9-268d-df03-380c-393a5d01f3ba@linaro.org>
 <Y3SrVMYjkWEx4wYw@wendy>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3SrVMYjkWEx4wYw@wendy>
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

On 16/11/2022 10:20, Conor Dooley wrote:
> On Wed, Nov 16, 2022 at 10:00:27AM +0100, Krzysztof Kozlowski wrote:
>> On 15/11/2022 23:34, Conor Dooley wrote:
>>> On Mon, Nov 14, 2022 at 05:59:00PM +0530, Anup Patel wrote:
>>>> On Sun, Nov 13, 2022 at 8:18 PM Conor Dooley <conor@kernel.org> wrote:
>>>
>>>>> Also, the file name says "riscv,imsic", the description says "IMSIC" but
>>>>> you've used "imsics" in the compatible. Is this a typo, or a plural?
>>>>
>>>> Yes, the file name should be consistent. I will update the file name.
>>>
>>> Is there a reason why the compatible is plural when all of the other
>>> mentions etc do not have an "s"? It really did look like a typo to me.
>>>
>>> It's the "incoming MSI controller", so I am unsure as to where the "s"
>>> actually even comes from. Why not just use "riscv,imsic"?
>>
>> Yep, should be rather consistent with all others, and IMSIC stands for
>> Integrated Circuit?
> 
> Incoming Message Signalled Interrupts Controller, no?

Ah, then still singular :)

Best regards,
Krzysztof

