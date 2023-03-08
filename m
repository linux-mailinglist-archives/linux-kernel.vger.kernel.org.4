Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630D56AFD0E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 03:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCHCvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 21:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCHCvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 21:51:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94310A1FF6;
        Tue,  7 Mar 2023 18:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=zz8XIrqQ9KHvA5O0CyBi6qT6Uf9Kop0CvFk8d/hlRvM=; b=JdN7q0ht+aYt/Z+kGlLvyjn5mx
        19KMsWKQz5gIiuzNJg/O78aoHpMWdHJcU7XVbRZzYVYMsfYVgjPinnBq2Cn6T+R5XDkk9/94ZnI0T
        7X50wBh8+kWZt/dIDkfBJyaFGJ1UYvLk55RemiobYDWLfWfvyssk/HVPyUtkr/GRmmCNH8hEKMl4C
        C1pKwlglgGCyUgjkwjN9nZdNYExZpkUZzEwldhqgjmA1DjqVB2qeZQsmvpVg1dI573qk7Y3wFdtPf
        CERcF4GzWT5qlITS57cWz8oC+9ShvJ1Y50fVTpIHvgJWGsyBs4d9/RiBs3RFFHsrEsn3CpH5MOKNI
        1GN1/JkA==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZjtO-003EQx-74; Wed, 08 Mar 2023 02:51:02 +0000
Message-ID: <db3b3412-9616-d13c-3374-48647325e057@infradead.org>
Date:   Tue, 7 Mar 2023 18:51:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 0/3] Add RISC-V 32 NOMMU support
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Jesse Taube <mr.bossman075@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
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
 <f8f291d9-2723-4ab8-3020-49018757d470@gmail.com>
 <62852ee1-3763-3323-c3a8-f1e84f70204a@infradead.org>
 <c7941231-8ebd-dea5-81f8-3180cfc3f286@gmail.com>
 <1d858dbb-ae85-95a0-3e46-b67017733c04@infradead.org>
In-Reply-To: <1d858dbb-ae85-95a0-3e46-b67017733c04@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/23 18:33, Randy Dunlap wrote:
> 
> 
> On 3/7/23 18:30, Jesse Taube wrote:
>>
>>
>> On 3/7/23 21:16, Randy Dunlap wrote:
>>> Hi--
>>>
>>> On 3/7/23 17:26, Jesse Taube wrote:
>>>>
>>>>
>>>> On 2/28/23 23:42, Damien Le Moal wrote:
>>>>> On 3/1/23 13:07, Randy Dunlap wrote:
>>>>>> Hi--
>>>>>>
>>>>>> On 2/28/23 16:26, Jesse Taube wrote:
>>>>>>> This patch-set aims to add NOMMU support to RV32.
>>>>>>> Many people want to build simple emulators or HDL
>>>>>>> models of RISC-V this patch makes it possible to
>>>>>>> run linux on them.
>>>>>>>
>>>>>>> Yimin Gu is the original author of this set.
>>>>>>> Submitted here:
>>>>>>> https://lists.buildroot.org/pipermail/buildroot/2022-November/656134.html
>>>>>>>
>>>>>>> Though Jesse T rewrote the Dconf.
>>>>>>
>>>>>> Dconf?
>>>>>>
>>>>>>>
>>>>>>> The new set:
>>>>>>> https://lists.buildroot.org/pipermail/buildroot/2022-December/658258.html
>>>>>>> ---
>>>>>>> V1->V2:
>>>>>>>    - Add Conor's clock patch for implicit div64
>>>>>>>    - Fix typo in commit title 3/3
>>>>>>>    - Fix typo in commit description 2/3
>>>>>>> V2->V3
>>>>>>>    - Change from defconfig file to a PHONY config
>>>>>>> ---
>>>>>>
>>>>>> Is this 'rv32_nommu_virt_defconfig' target the only build target
>>>>>> that is supported?
>>>>>>
>>>>>> I ask because I applied the 3 patches and did 25 randconfig builds.
>>>>>> 5 of them failed the same way:
>>>>>>
>>>>>> riscv32-linux-ld: drivers/soc/canaan/k210-sysctl.o: in function `k210_soc_early_init':
>>>>>> k210-sysctl.c:(.init.text+0x78): undefined reference to `k210_clk_early_init'
>>>> I can not recreate this error.
>>>> can you send me the .config you used.
>>>>
>>>> Thanks,
>>>> Jesse Taube
>>>
>>> Sure, it's attached.
>>
>> Hmmm, it links fine for me.
>>
>> objdump -x vmlinux | grep k210_clk_early_init
>> 81e40124 g     F .init.text     00000088 k210_clk_early_init
>>
>> gcc version 11.3.0 (Buildroot 2022.11-361-g1be0d438f7)
>> GNU assembler version 2.38 (riscv32-buildroot-linux-uclibc)
>> GNU ld (GNU Binutils) 2.38
>>
>> what gcc version are you using?
> 
> 
> gcc (SUSE Linux) 12.2.1 20230124 [revision 193f7e62815b4089dfaed4c2bd34fd4f10209e27]
> from opensuse Tumbleweed.
> 
> I'll try it on a current tree...

OK, I don't know how it happened. I cannot reproduce it now.
The failing .config files has CONFIG_MMU is not set (for RV32I), which
appears to be impossible.

Sorry to bother you.

Thanks.

>>>
>>>>> Arg. Forgot about that. k210 is rv64 only and while the clk driver could still
>>>>> compile test with rv32 (or any arch), that driver provides the
>>>>> k210_clk_early_init() function which is called very early in the boot process
>>>>> from k210_soc_early_init(), which is an SOC_EARLY_INIT_DECLARE() call. The
>>>>> problem may be there. Probably should be disabled for rv32 if no SoC need that
>>>>> sort of early init call.
>>>>>
>>>>>>
>>>>>> because
>>>>>> # CONFIG_COMMON_CLK_K210 is not set
>>>>>>
>>>>>>
>>>>>> Maybe SOC_CANAAN needs some more selects for required code?
>>>>>>
>>>>>>> Conor Dooley (1):
>>>>>>>     clk: k210: remove an implicit 64-bit division
>>>>>>>
>>>>>>> Jesse Taube (1):
>>>>>>>     riscv: configs: Add nommu PHONY defconfig for RV32
>>>>>>>
>>>>>>> Yimin Gu (1):
>>>>>>>     riscv: Kconfig: Allow RV32 to build with no MMU
>>>>>>>
>>>>>>>    arch/riscv/Kconfig     | 5 ++---
>>>>>>>    arch/riscv/Makefile    | 4 ++++
>>>>>>>    drivers/clk/clk-k210.c | 2 +-
>>>>>>>    3 files changed, 7 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>
>>>>>
>>>
> 

-- 
~Randy
