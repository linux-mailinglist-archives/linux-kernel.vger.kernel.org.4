Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B5873752B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjFTThI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFTThF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:37:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE151170A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:37:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b5251e5774so24422385ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687289823; x=1689881823;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6ZvEIvPRbw9YNSa9BHGX9FrNyDby/XoggIiNhXPl28=;
        b=SdApUZ2IPk+Z6mxD9bFN0GFN1iJ7suUDIehCiJCdXHL8ldfd46S6J1UZsAE7iR7ZJU
         izpY2GNrrEI44t9EM/b20YnXDICrn/D8moO/8NEpzGwCAY1agUTJl+UdfJ5+8QpelNv+
         9K/j1tdea6Hu4niHWHT+P8KJGXmymypUFKnvQArKlpy2ea/+WMjZj3Ctz0BTjm2jg1va
         4gY93UCcuTq5K+M+NtQze22SfMEpp5TbyWWC0mQWc2knBTZqQ+3Ee2rqVJ4UXLO7/jNO
         04A2GOWTyfq0DDKKxvkII7dNF0kzyLukffby9J16G3VyQBOmXNpHq+pUsgDuRm2dqE6G
         Gv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687289823; x=1689881823;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6ZvEIvPRbw9YNSa9BHGX9FrNyDby/XoggIiNhXPl28=;
        b=iBlCSyKSynMchtwZGb3T4k9QeQeATFiMas5u9AXq216PrYki0fy7clIQQO8biCak0y
         T9HSborj2m2y2AKmWisgwWGdxqpxglMhrCKzes7q87cVu+AvpCRVS6V4wpJaLHTktX7m
         l39FpiGWJF28FgN//j7Cjy03V1/Qndy+De3SZ9dVTRwTB1BuyMmqHG7CTyyra2g+MnIf
         QCodnv9DSVpuX4q7JxFbT2oHtPgvrTAcfYc6LpNyDxCJ1VVGvDoHNp+6J8pscYIFrdZy
         8qg5Cea1cpdAKB7kM8yBolt2rAEvt3Vsk6EuSd/YXi5S3pKvwbTT9IMqoO077a7JycrS
         1Y3Q==
X-Gm-Message-State: AC+VfDwdBvX6an+EXiDZz1fgWaz2q1Pf7RrHneCZlgwHKjzW263ujcWB
        076k6pYEIeDmN+js9h6C1IDTqR+npNvEfEKHQDA=
X-Google-Smtp-Source: ACHHUZ4CTI6udmmYo/7mpA0VeK/ywfX4bUnFBYVGoDxs8EypawA8sKHygWNb2fbGKEDNZGXmOY1Gqw==
X-Received: by 2002:a17:902:f7d2:b0:1b5:450a:4b5e with SMTP id h18-20020a170902f7d200b001b5450a4b5emr3161005plw.17.1687289823442;
        Tue, 20 Jun 2023 12:37:03 -0700 (PDT)
Received: from [172.31.0.109] ([136.36.130.248])
        by smtp.gmail.com with ESMTPSA id i14-20020a170902c94e00b001ae2b94701fsm1996816pla.21.2023.06.20.12.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 12:37:03 -0700 (PDT)
Message-ID: <75cf8335-af1f-e06c-c770-b2b540e812ed@ventanamicro.com>
Date:   Tue, 20 Jun 2023 13:37:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/4] RISC-V: add Zbc extension detection
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>
Cc:     heiko@sntech.de, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        heiko.stuebner@vrull.eu
References: <mhng-919a6ed5-c8b0-4311-9a8f-8c204b81a8e0@palmer-ri-x1c9a>
From:   Jeff Law <jlaw@ventanamicro.com>
In-Reply-To: <mhng-919a6ed5-c8b0-4311-9a8f-8c204b81a8e0@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/23 13:09, Palmer Dabbelt wrote:
> On Mon, 12 Jun 2023 14:31:14 PDT (-0700), Conor Dooley wrote:
>> Hey Heiko,
>>
>> On Mon, Jun 12, 2023 at 11:04:39PM +0200, Heiko Stuebner wrote:
>>> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>>>
>>> Add handling for Zbc extension.
>>>
>>> Zbc provides instruction for carry-less multiplication.
>>>
>>> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
>>> ---
>>>  arch/riscv/Kconfig             | 22 ++++++++++++++++++++++
>>>  arch/riscv/include/asm/hwcap.h |  1 +
>>>  arch/riscv/kernel/cpu.c        |  1 +
>>>  arch/riscv/kernel/cpufeature.c |  1 +
>>>  4 files changed, 25 insertions(+)
>>
>> Plumbing into the hwprobe stuff would be nice, but that's not a
>> requirement for getting stuff merged :)
> 
> IIRC we talked about this on IRC, but IMO we shouldn't require something 
> be user visible for it to be merged in the kernel.
Note that exposing Zbc is potentially useful.  We've got GCC and LLVM 
code that can detect and rewrite a bitwise CRC into clmul.

Jeff
