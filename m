Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BDF6AFC3C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCHB0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCHB0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:26:20 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1090B8235E;
        Tue,  7 Mar 2023 17:26:19 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id h19so16676105qtk.7;
        Tue, 07 Mar 2023 17:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678238778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HrGCJ5MSZDYIh72odbfCXv3OjB4aPWORM8fS9BuSe6U=;
        b=V6/rzhlNCD4Os6IPrpRaMcKvSZkNbVv8YoB7DAg2rZNFKC/gq+qYQANoB5tjiqIuLE
         aECdRlPQgor7Pln0eWGQxW47KU3XgYoWhkjeQ1QqHmzG+ZE1L79qaQh9nn7Zq92RmdSa
         0lS3qBCvE3YFBkMInugQln3+6mkx0+NyqRGp5xna1rxdDh5mC0u4PpjnMkTFDXkhLFtN
         LkgXd0+46L1ciRg4NOCNI+Owbmn9UjB0EIgqMthqbsIoRJOyo54tFotuUIFApzw1stLY
         Lwqu/LPD+WEdJ5Mq5j7p/xH7ofwhdWPmESuesK4j80nHuZKXlLd+G2uc2l1dP0vb+MHF
         FeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678238778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrGCJ5MSZDYIh72odbfCXv3OjB4aPWORM8fS9BuSe6U=;
        b=Kh5sbxq9hKUJMcC4aS+IvLefdoTUHoA8UOFjdorsP7hD6EeYMN9bRzEfiVu6ktbsYN
         agzjnlBTNtJUQECxHom7ZouC8Yd8cTjJJyTqd2uHrqBsSQwAMfTARljs0HSBNVZ/BtRg
         b+f1u2emo/ffIxIXH38xbM+U1Ei9oNhARhdubKus0B+8aLC6ZDCN04tGeHXMqVQZgOz2
         dFS1ILiEmjcatsC2GPFV8giYb8ERk1IcC+gKr3Yl2Sv3lLstI9/6gZ5NUOXZ1BJZ4q2k
         7s1d8OyJg6vZJDDtDIKQFhqrNUmsE85fr0Py7f50ahIchu6S9h2iSuj6EYJtdrjcThrm
         wTow==
X-Gm-Message-State: AO0yUKUU7Yj5bJ7ewaqOVs+JfUByyjMQabJ5rZBf55EL9Rs4Mw4fxcS0
        kNQZYfFiItCFXFs6NYR4MWA=
X-Google-Smtp-Source: AK7set+dLHC4u0TbTmIumEqq6CCL5QcowmU62gPkQsoL1ySasKdM1qxtjrlwpgd66H5jV9QMV/5sNQ==
X-Received: by 2002:a05:622a:d1:b0:3bf:d372:a5bf with SMTP id p17-20020a05622a00d100b003bfd372a5bfmr29304085qtw.45.1678238778121;
        Tue, 07 Mar 2023 17:26:18 -0800 (PST)
Received: from [10.4.10.38] (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id r2-20020ac83b42000000b003c034837d8fsm3325676qtf.33.2023.03.07.17.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 17:26:17 -0800 (PST)
Message-ID: <f8f291d9-2723-4ab8-3020-49018757d470@gmail.com>
Date:   Tue, 7 Mar 2023 20:26:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/3] Add RISC-V 32 NOMMU support
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-riscv@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
 <42446784-a88b-df09-41e9-5f685b4df6ee@infradead.org>
 <556ce787-80eb-dc48-f8d6-83e415538e36@opensource.wdc.com>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <556ce787-80eb-dc48-f8d6-83e415538e36@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/23 23:42, Damien Le Moal wrote:
> On 3/1/23 13:07, Randy Dunlap wrote:
>> Hi--
>>
>> On 2/28/23 16:26, Jesse Taube wrote:
>>> This patch-set aims to add NOMMU support to RV32.
>>> Many people want to build simple emulators or HDL
>>> models of RISC-V this patch makes it possible to
>>> run linux on them.
>>>
>>> Yimin Gu is the original author of this set.
>>> Submitted here:
>>> https://lists.buildroot.org/pipermail/buildroot/2022-November/656134.html
>>>
>>> Though Jesse T rewrote the Dconf.
>>
>> Dconf?
>>
>>>
>>> The new set:
>>> https://lists.buildroot.org/pipermail/buildroot/2022-December/658258.html
>>> ---
>>> V1->V2:
>>>   - Add Conor's clock patch for implicit div64
>>>   - Fix typo in commit title 3/3
>>>   - Fix typo in commit description 2/3
>>> V2->V3
>>>   - Change from defconfig file to a PHONY config
>>> ---
>>
>> Is this 'rv32_nommu_virt_defconfig' target the only build target
>> that is supported?
>>
>> I ask because I applied the 3 patches and did 25 randconfig builds.
>> 5 of them failed the same way:
>>
>> riscv32-linux-ld: drivers/soc/canaan/k210-sysctl.o: in function `k210_soc_early_init':
>> k210-sysctl.c:(.init.text+0x78): undefined reference to `k210_clk_early_init'
I can not recreate this error.
can you send me the .config you used.

Thanks,
Jesse Taube
> 
> Arg. Forgot about that. k210 is rv64 only and while the clk driver could still
> compile test with rv32 (or any arch), that driver provides the
> k210_clk_early_init() function which is called very early in the boot process
> from k210_soc_early_init(), which is an SOC_EARLY_INIT_DECLARE() call. The
> problem may be there. Probably should be disabled for rv32 if no SoC need that
> sort of early init call.
> 
>>
>> because
>> # CONFIG_COMMON_CLK_K210 is not set
>>
>>
>> Maybe SOC_CANAAN needs some more selects for required code?
>>
>>> Conor Dooley (1):
>>>    clk: k210: remove an implicit 64-bit division
>>>
>>> Jesse Taube (1):
>>>    riscv: configs: Add nommu PHONY defconfig for RV32
>>>
>>> Yimin Gu (1):
>>>    riscv: Kconfig: Allow RV32 to build with no MMU
>>>
>>>   arch/riscv/Kconfig     | 5 ++---
>>>   arch/riscv/Makefile    | 4 ++++
>>>   drivers/clk/clk-k210.c | 2 +-
>>>   3 files changed, 7 insertions(+), 4 deletions(-)
>>>
>>
> 
