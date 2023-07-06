Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0302F74989A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjGFJgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjGFJgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:36:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A42110;
        Thu,  6 Jul 2023 02:35:58 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-263121cd04eso288501a91.2;
        Thu, 06 Jul 2023 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688636158; x=1691228158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZvzRFmjovR5CKskt4rAoljf5PyU+bBuPu35GK+CWTg=;
        b=kRAB2kIbcDW/XHAvxyjuu1lqYhOqf+G+STW+APL9XsSoCXqhJ/TDdCjIvJU6KEr1rb
         61FYkcn+CscjIPJTk4MW2VhRpegHuj+ZIwK7HBdqnj6D1njHkwc+2YYL4x7SVpEq8OSL
         jBFzvdMtQPp5HMMOcZSvA48RTmhjSTpFQHsJ0WoJgLvzNHavxDX4O1fXwBqx0tzktNl6
         pPGDnNDSU5Xc1X0mRfV5QfEQ9j5t0nyTjkWZWGehFaghE5z5A74pdVs772A3X9ACkEJg
         W5rosOyjUBNoWnRH1anUI/8I3muubu1GIosT6PeO7hrHp4tU0RZyCW4CUfAVD7Tw+811
         cPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688636158; x=1691228158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kZvzRFmjovR5CKskt4rAoljf5PyU+bBuPu35GK+CWTg=;
        b=gI4cd2O7MsR6bUJDDoodgpoSfxkLROrWG41SZkwZLfqXUP0unDcPrj3LuD4JQ0xV6R
         S1BmgfCpBrdcmp3rg+ugyZnM/1Y1lRdgaISujqVeWP5G85aZEOM8pUlWtwT4/81t1iA+
         8gzAIb4Ln0OqKG5YEylpCtsoDSFDzIJjvqc5/nvWHP8z+iKvU2/siJ5IDRPtf1zEN6pX
         FlyFJ2yPKPMN7IBpfEPWNc04bj4w69LquPWHM19/+ihMLCw7E0YeFYnzjLDRloLT2mMF
         BgLLNx1xPUdTj8gbzaYrWiehzXZgGgviOWopvehNTcwcmX2ecTxJLDQhiJ7SCmMFq+Jr
         Pqlg==
X-Gm-Message-State: ABy/qLaKhRpuc5seInAoIWtbMIlt6sA+WbRlRv9QLX7+VLOJesnSPQWe
        g/6BDDiDeFLRd5r7wl5THMg=
X-Google-Smtp-Source: APBJJlF3PFZNaUoah0CQkHsCRbVoiqED1QGPGBmVuwf/HRO1XrVpD0K5EFFGICd2+MuFn5O+Z9OiZQ==
X-Received: by 2002:a17:90a:c85:b0:263:9e9b:5586 with SMTP id v5-20020a17090a0c8500b002639e9b5586mr756136pja.44.1688636158171;
        Thu, 06 Jul 2023 02:35:58 -0700 (PDT)
Received: from [0.0.0.0] ([5.180.77.117])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a7f8400b0026333ad02c1sm940910pjl.10.2023.07.06.02.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 02:35:57 -0700 (PDT)
Message-ID: <c7090e76-b054-1f0d-8c05-18f041904b22@gmail.com>
Date:   Thu, 6 Jul 2023 17:35:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V11 0/5] riscv: Optimize function trace
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, bjorn@rivosinc.com,
        jszhang@kernel.org, conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, songshuaishuai@tinylab.org
References: <20230627111612.761164-1-suagrfillet@gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
In-Reply-To: <20230627111612.761164-1-suagrfillet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

在 2023/6/27 19:16, Song Shuai 写道:
> Changes in V11:
> 
> - append a patch that makes the DIRECT_CALL samples support RV32I in
>    this series fixing the rv32 build failure reported by Palmer
> 
> - validated with ftrace boottime selftest and manual sample modules test
>    in qemu-system for RV32I and RV64I
> 
> This series optimizes function trace. The first 3 independent
> patches has been picked in the V7 version of this series, the
> subsequent version continues the following 4 patches:
> 
> select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY [1] (patch 1)
> ==========================================================
> 
> In RISC-V, -fpatchable-function-entry option is used to support
> dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
> PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
> don't have to be called to create the __mcount_loc section before
> the vmlinux linking.
> 
> Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
> Makefile not to run recordmcount.
> 
> Make function graph use ftrace directly [2] (patch 2)
> ========================================================
> 
> In RISC-V architecture, when we enable the ftrace_graph tracer on some
> functions, the function tracings on other functions will suffer extra
> graph tracing work. In essence, graph_ops isn't limited by its func_hash
> due to the global ftrace_graph_[regs]_call label. That should be
> corrected.
> 
> What inspires me is the commit 0c0593b45c9b ("x86/ftrace: Make function
> graph use ftrace directly") that uses graph_ops::func function to
> install return_hooker and makes the function called against its
> func_hash.
> 
> Add WITH_DIRECT_CALLS support [3] (patch 3, 4)
> ==============================================
> 
> This series adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
> SAMPLE_FTRACE_DIRECT and SAMPLE_FTRACE_DIRECT_MULTI are also included
> here as the samples for testing DIRECT_CALLS related interface.
> 
> First, select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide
> register_ftrace_direct[_multi] interfaces allowing user to register
> the customed trampoline (direct_caller) as the mcount for one or
> more target functions. And modify_ftrace_direct[_multi] are also
> provided for modify direct_caller.
> 
> At the same time, the samples in ./samples/ftrace/ can be built
> as kerenl module for testing these interfaces with SAMPLE_FTRACE_DIRECT
> and SAMPLE_FTRACE_DIRECT_MULTI selected.
> 
> Second, to make the direct_caller and the other ftrace hooks
> (eg. function/fgraph tracer, k[ret]probes) co-exist, a temporary
> register
> are nominated to store the address of direct_caller in
> ftrace_regs_caller.
> After the setting of the address direct_caller by direct_ops->func and
> the RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
> by the `jr` inst.
> 
> The series's old changes related these patches
> ==========================================
> 
> Changes in v10:
> https://lore.kernel.org/all/20230511093234.3123181-1-suagrfillet@gmail.com/
> 
> - add Acked-by from Björn Töpel in patch 2 and patch 4
> - replace `move` with `mv` in patch3
> - prettify patch 2/4 with proper tabs
> 
> Changes in v9:
> https://lore.kernel.org/linux-riscv/20230510101857.2953955-1-suagrfillet@gmail.com/
> 
> 1. add Acked-by from Björn Töpel in patch 1
> 
> 2. rebase patch2/patch3 on Linux v6.4-rc1
> 
>    - patch 2: to make the `SAVE_ABI_REGS` configurable, revert the
>      modification of mcount-dyn.S from commit (45b32b946a97 "riscv:
> entry: Consolidate general regs saving/restoring")
> 
>    - patch 3: to pass the trace_selftest, add the implement of
>      `ftrace_stub_direct_tramp` from commit (fee86a4ed536 "ftrace:
> selftest: remove broken trace_direct_tramp") ; and fixup the context
> conflict in Kconfig
> 
> Changes in v8:
> https://lore.kernel.org/linux-riscv/20230324033342.3177979-1-suagrfillet@gmail.com/
>   - Fix incorrect address values in the 4nd patch
>   - Rebased on v6.3-rc2
> 
> Changes in v7:
> https://lore.kernel.org/linux-riscv/20230112090603.1295340-1-guoren@kernel.org/
>   - Fixup RESTORE_ABI_REGS by remove PT_T0(sp) overwrite.
>   - Add FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY [1]
>   - Fixup kconfig with HAVE_SAMPLE_FTRACE_DIRECT &
>     HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> 
> Changes in v6:
> https://lore.kernel.org/linux-riscv/20230107133549.4192639-1-guoren@kernel.org/
>   - Replace 8 with MCOUNT_INSN_SIZE
>   - Replace "REG_L a1, PT_RA(sp)" with "mv a1, ra"
>   - Add Evgenii Shatokhin comment
> 
> Changes in v5:
> https://lore.kernel.org/linux-riscv/20221208091244.203407-1-guoren@kernel.org/
>   - Sort Kconfig entries in alphabetical order.
> 
> Changes in v4:
> https://lore.kernel.org/linux-riscv/20221129033230.255947-1-guoren@kernel.org/
>   - Include [3] for maintenance. [Song Shuai]
> 
> Changes in V3:
> https://lore.kernel.org/linux-riscv/20221123153950.2911981-1-guoren@kernel.org/
>   - Include [2] for maintenance. [Song Shuai]
> 
> [1]: https://lore.kernel.org/linux-riscv/CAAYs2=j3Eak9vU6xbAw0zPuoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
> [2]: https://lore.kernel.org/lkml/20221120084230.910152-1-suagrfillet@gmail.com/
> [3]: https://lore.kernel.org/linux-riscv/20221123142025.1504030-1-suagrfillet@gmail.com/
> 
> Song Shuai (5):
>    riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
>    riscv: ftrace: Add ftrace_graph_func
>    riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
>    samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
>    samples: ftrace: Make the riscv samples support RV32I
> 
>   arch/riscv/Kconfig                          |   4 +
>   arch/riscv/include/asm/ftrace.h             |  19 +-
>   arch/riscv/kernel/ftrace.c                  |  30 ++-
>   arch/riscv/kernel/mcount-dyn.S              | 200 ++++++++++++++++----
>   samples/ftrace/ftrace-direct-modify.c       |  35 ++++
>   samples/ftrace/ftrace-direct-multi-modify.c |  41 ++++
>   samples/ftrace/ftrace-direct-multi.c        |  25 +++
>   samples/ftrace/ftrace-direct-too.c          |  28 +++
>   samples/ftrace/ftrace-direct.c              |  24 +++
>   9 files changed, 350 insertions(+), 56 deletions(-)
> 

-- 
Thanks
Song Shuai
