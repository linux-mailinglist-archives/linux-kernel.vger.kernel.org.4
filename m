Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6E06BA5D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCOD6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCOD6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:58:35 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91592D177
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:58:33 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id p6so10105705pga.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678852713;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HYuR6tFCyvgHrmckJ1l2C1M5Y1KFC1xHbhtrJS6kSw=;
        b=EC97TzW0CrEe5hSuqkySlThCvA6rC8OWWPnB07b8u+eFPQzG24z7QLN+nSl2Ol+Fpf
         y7ndCuRq3L5iY9cZSJkEEH4ef9/uRN8WXYZiHPwscaeosQengEA6jDmcQsqpW35ibkY9
         Q9BoJ0wB+1ga3hkv5NC5zYwRApnaHXjlcLTDwnZiqrcWKk0Cox0+tUKYDeaOpvh1K75c
         /v14KaYuetjNlrxyFFq76zIgePJ8+O+WbnyB7hpqZp9zBAQ6w2Y1hwIrUUF52Qt36O3D
         N1dhqty7K6t1DM/1tLNAiPIXYbRJQcwqDDByltdDzCxTKMA6bjNOuj8QY/IqNwnOOWPb
         WMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678852713;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HYuR6tFCyvgHrmckJ1l2C1M5Y1KFC1xHbhtrJS6kSw=;
        b=bChrGHP3WF0wOVWJ5xZkAXoxT4l7h375uJkfmZzaCJXmbXFE6bnE5cLlTiyTdk02i3
         Qzx9GE2sgvIDq6F8oqIwpm03JqdRkepw8Wmfnc/Gb26baG60jJt4u24lbaDK9gBe6Rbb
         kPuWY5zyarD4zyx4desdhx4Eza/J5a3dmxcPjutrXr5ltK+RKEBW8owObrZLR+JzZFhs
         HhI8Dt4C3MsEagJCRtTlIGWzsDlIkhhCKEjNen+rxvgMOh8Ka7hcoJGRhX7Vb0qqlah4
         hBdxm/tLA6Fy9MHKVDWjFf2wbbyIZ28WCBimFU9yLnCIBSkzk/v9l3NV2ph0GR6hET4D
         OosA==
X-Gm-Message-State: AO0yUKWgPK+QZI7h6qPFZJ8VzMPUbotJ4ODlsL7OyXoqIghMrDB8enz5
        3HkJiuDFXy8DyMLxX3YbIIZeTQ==
X-Google-Smtp-Source: AK7set/f279w0PNYnzk8p6eaHIA+U2s7JSlU+MedS2TRqoMtPOHNLMkoP1Vc2Z7oekBIxmo0doQfaw==
X-Received: by 2002:a62:8415:0:b0:625:500c:35bd with SMTP id k21-20020a628415000000b00625500c35bdmr6675421pfd.6.1678852712976;
        Tue, 14 Mar 2023 20:58:32 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78755000000b0059442ec49a2sm1143241pfo.146.2023.03.14.20.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 20:58:32 -0700 (PDT)
Date:   Tue, 14 Mar 2023 20:58:32 -0700 (PDT)
X-Google-Original-Date: Tue, 14 Mar 2023 20:57:37 PDT (-0700)
Subject:     Re: [PATCH 0/2] riscv: support ELF format binaries in nommu mode
In-Reply-To: <d641459e-c52b-c42e-dfcb-77bb978414f8@kernel.org>
CC:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     gerg@kernel.org, damien.lemoal@opensource.wdc.com,
        macro@orcam.me.uk
Message-ID: <mhng-a62a57b8-4268-4c51-b79e-f5f6bd0c13a2@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 16:20:35 PST (-0800), gerg@kernel.org wrote:
> Hi Palmer,
>
> On 1/3/23 07:52, Palmer Dabbelt wrote:
>> On Tue, 28 Feb 2023 05:51:24 PST (-0800), gerg@kernel.org wrote:
>>> The following changes add the ability to run ELF format binaries when
>>> running RISC-V in nommu mode. That support is actually part of the
>>> ELF-FDPIC loader, so these changes are all about making that work on
>>> RISC-V.
>>>
>>> The first issue to deal with is making the ELF-FDPIC loader capable of
>>> handling 64-bit ELF files. As coded right now it only supports 32-bit
>>> ELF files.
>>>
>>> Secondly some changes are required to enable and compile the ELF-FDPIC
>>> loader on RISC-V and to pass the ELF-FDPIC mapping addresses through to
>>> user space when execing the new program.
>>>
>>> These changes have not been used to run actual ELF-FDPIC binaries.
>>> It is used to load and run normal ELF - compiled -pie format. Though the
>>> underlying changes are expected to work with full ELF-FDPIC binaries if
>>> or when that is supported on RISC-V in gcc.
>>>
>>> To avoid needing changes to the C-library (tested with uClibc-ng
>>> currently) there is a simple runtime dynamic loader (interpreter)
>>> available to do the final relocations, https://github.com/gregungerer/uldso.
>>> The nice thing about doing it this way is that the same program
>>> binary can also be loaded with the usual ELF loader in MMU linux.
>>>
>>> The motivation here is to provide an easy to use alternative to the
>>> flat format binaries normally used for RISC-V nommu based systems.
>>>
>>> Signed-off-by: Greg Ungerer <gerg@kernel.org>
>>> ---
>>>
>>>  arch/riscv/include/asm/elf.h         |   11 +++++++++-
>>>  arch/riscv/include/asm/mmu.h         |    4 +++
>>>  arch/riscv/include/uapi/asm/ptrace.h |    5 ++++
>>>  fs/Kconfig.binfmt                    |    2 -
>>>  fs/binfmt_elf_fdpic.c                |   38 +++++++++++++++++------------------
>>>  include/linux/elf-fdpic.h            |   14 +++++++++++-
>>>  include/uapi/linux/elf-fdpic.h       |   15 +++++++++++++
>>>  7 files changed, 67 insertions(+), 22 deletions(-)
>>
>> Adding Damien, as IIRC he's had some hacked up userspace bits for the K210.  I'm yet to get anything running, but it'd be great if we get this to a point where I can actually boot test this on QEMU (I'm just doing builds now).
>
> This is a simple script I user to generate a working QEMU example:
>
>    https://raw.githubusercontent.com/gregungerer/simple-linux/master/build-riscvnommu-linux-uclibc-elf.sh
>
> It does reference some configs here https://github.com/gregungerer/simple-linux/tree/master/configs
> and this posted patchset as https://github.com/gregungerer/simple-linux/tree/master/patches (this is
> just these 2 patches combined as a single patch).
>
>
>> Given that it's the second week of the merge window and this is a bunch of new uABI it seems best to hold off until the next cycle.  I poked around and don't see anything wrong, but I'll try and take a more detailed look after the merge window.
>
> Oh, yeah, no hurry.

Maciej and Damien: I'm fine taking this, but not in any rush.  I'd 
rather get the uABI right if things are still in flight, but if we're 
all just waiting for something to get merged first then I'm fine with 
that being Linux.

>
> Regards
> Greg
