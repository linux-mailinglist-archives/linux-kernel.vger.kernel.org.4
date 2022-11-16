Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69A562B5D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiKPJAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiKPJAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:00:32 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCA7765D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:00:30 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id r12so28474824lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVdV6LebjwCpmwDk6trJqC8cySRjktuHUoTqdWNdcms=;
        b=khTlLRnGvCZXS8zSbmdGUxyvWawM2fSnfv8ljuguxkvPyAT5UUql0SYa5oohRXhQTd
         I88GbIyvvk7Q5jqHMKbJtEm/uFyFy0ZmiUAnPm0/uFL+innZxOko6G7JEv2kZT/9hERJ
         th/tEufxqaMEx421Dyo6sxDbbABvx6rLxB997bMfwk+g/1DjUf9UXDUNk3t8XsM2WT4j
         pgG/vIRMFhV+6XQSwNYnzaAenrqk7fU49GBqbb0pPU13Q/4+JDNkIL0Y9u6ZoZmE8dQc
         Lm2pM5RzmBs8uGXIir8fPW7SJvcdkVYnEwLBs0Ajo6yXndizM7u2F1/Xes/K5ILVZPOB
         9+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVdV6LebjwCpmwDk6trJqC8cySRjktuHUoTqdWNdcms=;
        b=aLTrMa6X8hB1LmEvZNWPuFFI44+/pV4P8jEe7Tu8CHpJApakB2ontLwwr5pHy57rAM
         y6fjoV0R5HP39BDrx0PFscqM9d0Rptw4g0LPsfa4QAtWVhp+OSwV7Mm2Z2eqk2yv+2Rq
         Ca3Im8hAFkYnxMsoClXDSses0ykvyUJbYlAU2fFYwtgcTi8uuaTfer1mYtBxkFJERfEA
         Vqkg91/7jJdTOd/Cy52+FjsEQPJIogn/awIaDclrsgoWud2PpCC1P9B0PzceQpALtF3M
         xQtAk3b0r7S12A/0sZTUF7PTZKtPswiXT9hrqTZRUOcjAU0ycZ3lRnVp1Dm2w5m70G60
         lmJw==
X-Gm-Message-State: ANoB5pnZ1ZYioqBrCGhJB8G+NfFcftK/eax+z7wOurYToRhNB7lIZC1g
        pNn+IIF1UPx04WNJ12WSx2bYnA==
X-Google-Smtp-Source: AA0mqf4ACaYKe07LviNcmJVRzmLlpSA+Y194j1OxaF80zT6bNeKpJkTnKfKaXj01iJCNB7gYnIy8Pg==
X-Received: by 2002:a05:6512:239d:b0:4a2:7574:b64a with SMTP id c29-20020a056512239d00b004a27574b64amr6712826lfv.336.1668589229325;
        Wed, 16 Nov 2022 01:00:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q21-20020a0565123a9500b0048afb8b8e53sm2510621lfu.80.2022.11.16.01.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 01:00:28 -0800 (PST)
Message-ID: <3037b4f9-268d-df03-380c-393a5d01f3ba@linaro.org>
Date:   Wed, 16 Nov 2022 10:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/9] dt-bindings: Add RISC-V incoming MSI controller
 bindings
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
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
 <Y3QT5Vy3RnIXobHz@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3QT5Vy3RnIXobHz@spud>
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

On 15/11/2022 23:34, Conor Dooley wrote:
> On Mon, Nov 14, 2022 at 05:59:00PM +0530, Anup Patel wrote:
>> On Sun, Nov 13, 2022 at 8:18 PM Conor Dooley <conor@kernel.org> wrote:
> 
>>> Also, the file name says "riscv,imsic", the description says "IMSIC" but
>>> you've used "imsics" in the compatible. Is this a typo, or a plural?
>>
>> Yes, the file name should be consistent. I will update the file name.
> 
> Is there a reason why the compatible is plural when all of the other
> mentions etc do not have an "s"? It really did look like a typo to me.
> 
> It's the "incoming MSI controller", so I am unsure as to where the "s"
> actually even comes from. Why not just use "riscv,imsic"?

Yep, should be rather consistent with all others, and IMSIC stands for
Integrated Circuit?

Best regards,
Krzysztof

