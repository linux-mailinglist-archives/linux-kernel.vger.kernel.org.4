Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1447D74AABF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjGGFrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGGFrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:47:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7C71BC9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 22:47:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-668730696a4so938372b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 22:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1688708839; x=1691300839;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAvpISnydoFWHqQk7bImyRAY/c0bnv6qrhMGgGyMhhY=;
        b=Zy8W5lHJTad1YEeB5b6krk0nPtoGPBw249SleGYm8eYRKDy8kgDHGRQmAzProRjj9C
         ZA6n1SHCyYdmza/16J5txdF8Ra3jP4vmGhNr1IJthuSYn5ENXEKDJQl9We1+hx4ExA3d
         4AipisBM0dD6HGPOrT7iGrAnl7Bw8xn5nPcE5ok762+55FapMBVfBrO3ODXjBWDu2QnA
         FH127RchZQiEDHkDo9k/YGkI74sazJJN3L5jP9r6djIW9XXe9C50u7ELdxFhgZJ4i1X4
         NVBTXF9X+sv3P4Xchgkx6K8WkmhCdcQTnhn/LH0R3Dpk2TvzKHGx5dcG3258TSqijQ6X
         sJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688708839; x=1691300839;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAvpISnydoFWHqQk7bImyRAY/c0bnv6qrhMGgGyMhhY=;
        b=bCyBS82rwMWTenuNdgPy+53CfmrvECcHyRlBJol7EZqhFTE/YF9ixu6tVIin7q9aeY
         ILLtQYK9OOUp4wiwNwAaXt2Sv+vy5hDn/neFwY568/QvCQtEiCPOr9K1YFS6vs61gCFN
         Kwhe5WP9KiwL7e85OKACW+391OUJRm19kr/kmtIv6hkkuKoSbn/FdeHsWcnmpU1GjATh
         2fut1sZftHhrP9l6J16jyHROzlc+efe9jXCGr6NLEet3px8/JoBMK1j6SxVRvWqiU544
         7jSifVOEt897JbtmBlKWB3WpnAuGnriu74/vsuzpGg+ZcV//qBC1s0W54f0jEBWuf+xU
         DPwg==
X-Gm-Message-State: ABy/qLauRCxEC0Ga3gsiPoSo9vNP/ahaB+yHT5na90F5OMX6z2U2z0P3
        i9Jxi8X+RQDPrmaveEOquWG7fA==
X-Google-Smtp-Source: APBJJlEkryK+Im9QKPXSsQlHuvQpZ2OrLluHoKw6NMANX53P/yWi8uzpp2a2uJLD9k+j67MTRXqQZQ==
X-Received: by 2002:a05:6a00:c87:b0:681:ccc3:3cd9 with SMTP id a7-20020a056a000c8700b00681ccc33cd9mr3759673pfv.19.1688708838768;
        Thu, 06 Jul 2023 22:47:18 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id l14-20020a65680e000000b0055b0c330b30sm1928754pgt.84.2023.07.06.22.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 22:47:18 -0700 (PDT)
Date:   Thu, 06 Jul 2023 22:47:18 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jul 2023 22:45:22 PDT (-0700)
Subject:     Re: linux-next: Tree for Jul 6 (arch/riscv/)
In-Reply-To: <278886bf-f469-a8cc-130a-f3e4614e7e1f@infradead.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor Dooley <conor@kernel.org>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-0a55bc01-88cb-412a-ac38-7919f6f596fc@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023 16:40:27 PDT (-0700), rdunlap@infradead.org wrote:
> Hi Palmer,
>
> On 7/6/23 14:46, Palmer Dabbelt wrote:
>> On Thu, 06 Jul 2023 14:36:05 PDT (-0700), rdunlap@infradead.org wrote:
>>>
>>>
>>> On 7/6/23 14:32, Palmer Dabbelt wrote:
>>>> On Thu, 06 Jul 2023 14:27:53 PDT (-0700), rdunlap@infradead.org wrote:
>>>>>
>>>>>
>>>>> On 7/5/23 18:57, Stephen Rothwell wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Please do *not* add any v6.6 related stuff to your linux-next included
>>>>>> branches until after v6.5-rc1 has been released.
>>>>>>
>>>>>> Changes since 20230705:
>>>>>>
>>>>>
>>>>> on riscv64:
>>>>>
>>>>> WARNING: modpost: vmlinux: section mismatch in reference: $xrv64i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x14 (section: .text.unlikely.set_bit.constprop.0) -> numa_nodes_parsed (section: .init.data)
>>>>>
>>>>>
>>>>> Full randconfig file is attached.
>>>>
>>>> Thanks, I'm giving it a look.  Do you happen to also have your toolchain version easily availiable?  The mapping symbols are new and we've seen some odd stuff happen, something is likely broken somewhere...
>>>
>>> I'm using gcc-13.1.0 from  https://mirrors.edge.kernel.org/pub/tools/crosstool/
>>
>> Cool, those are pretty easy to run.  I've yet to actually reproduce the
>> failures, but I'd guess we just want to ignore the mapping symbols with
>> something like
>>
>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>> index b29b29707f10..2f801469301d 100644
>> --- a/scripts/mod/modpost.c
>> +++ b/scripts/mod/modpost.c
>> @@ -614,6 +614,18 @@ static int ignore_undef_symbol(struct elf_info *info, const char *symname)
>>         /* Expoline thunks are linked on all kernel modules during final link of .ko */
>>         if (strstarts(symname, "__s390_indirect_jump_r"))
>>             return 1;
>> +
>> +    /*
>> +     * RISC-V defines various special symbols that start with "$".  The
>> +     * mapping symbols, which exist to differentiate between incompatible
>> +     * instruction encodings when disassembling, show up all over the place
>> +     * and are generally not meant to be treated like other symbols.  So
>> +     * just ignore any of the special symbols.
>> +     */
>> +    if (info->hdr->e_machine == EM_RISCV)
>> +        if (symname[0] == '$')
>> +            return 1;
>> +
>>     /* Do not ignore this symbol */
>>     return 0;
>> }
>>
>> I haven't even built that, though...
>
> That builds without any errors or warnings, but it doesn't fix the section mismatch
> warning.

Turns out there's a hook for mapping symbols, this fixes it for me:

https://lore.kernel.org/r/20230707054007.32591-1-palmer@rivosinc.com/

>> These also trip up backtraces, so we probably need something over there as
>> well.

I think that might fix the backtraces as well.
