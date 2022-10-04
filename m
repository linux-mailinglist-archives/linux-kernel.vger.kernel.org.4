Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA995F3B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJDCyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJDCyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:54:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B70164C4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:54:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d11so11463898pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=bMbyIMpyUL0gZSYHhf+c9J7LwNqUlIt7R/iLTUpZF/I=;
        b=O4CNznk5O8Nv7mb7UvXIhuZjdRyQTlgUxdG74k/QLDKWaDr3J09qizMnjrIivcmIsV
         nK+0bvwJ23q1QUrPryXH8+BbACsA5qguuHj3N4fPgyZfObjMdUoJB+fWGHH3gbd1pn88
         LPWEq82s0km+Ir9zdDkzTHwOUXYsrE/I2qrpYPkquAqs5lqBp6qTsyr0R0mWg4ULo7T6
         gMqxp8TVYxs4OhLeKgbPw/Ld8xzfKQ3/r31puF6ss0vmGSWPX1b27V3TYy3s7+UGmxMQ
         3L5cOV6xW51Du1ctw5axTLQBdBREwmBkzLYVfigVXrqJoLuu5QF0VZ70miy8NZlW+0po
         pQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=bMbyIMpyUL0gZSYHhf+c9J7LwNqUlIt7R/iLTUpZF/I=;
        b=JQ6KAcQG9hrWWt8nh3+MUpi0fgkD7ltdCz9eR3GwEBmyhQtuBq9oSORIEwhi9MU/gU
         BcEC+amC6YxmcCCV17yjR0apYiXLGYA1CQdUgq6zWGvkylTfC9EklFv5XvY54LeHrGa2
         H8H5QOpBaXV76R2Mtw/n6cDNSxppqSnE001VhwMWEoBDqoCqV2h7Zeeh58DJ32Q+R10E
         W8wzWXAf3NQoKr5iHEqLvv9KKrN8IIBC6cbJDgEoiiR+HNS41jf6qk9pxtwMETfsQUhl
         4rucPmP+bgOFFIDSVyCRjWwc2PEgLD1XSXcVNCRXZ8VqUppkHW+YynoqYfj2fpDstFXG
         Elag==
X-Gm-Message-State: ACrzQf0O2oVLIBVjM/GZ65+ouZS2OIIyYzuMgopjlLIlUIeXEW2HI+vt
        E5Cxo/e4kGSXZk+Tk+X/vIlxpg==
X-Google-Smtp-Source: AMsMyM6E3lu79QRXjV9QidXjjHFx5sZsJcYBr7nw+ZF3kLOdgLKD7bJCetjuV4RxDfKTaWnpHjMg+w==
X-Received: by 2002:a17:902:c412:b0:17f:16ce:3886 with SMTP id k18-20020a170902c41200b0017f16ce3886mr9462795plk.35.1664852081498;
        Mon, 03 Oct 2022 19:54:41 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r6-20020a63d906000000b0042254fce5e7sm7329518pgg.50.2022.10.03.19.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:54:40 -0700 (PDT)
Date:   Mon, 03 Oct 2022 19:54:40 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Oct 2022 19:54:34 PDT (-0700)
Subject:     Re: [PATCH v6 0/3] RISC-V: Create unique identification for SoC PMU
In-Reply-To: <20220815132251.25702-1-nikita.shubin@maquefel.me>
CC:     linux@yadro.com, anup@brainfault.org, acme@kernel.org,
        n.shubin@yadro.com, aou@eecs.berkeley.edu,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, namhyung@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, peterz@infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nikita.shubin@maquefel.me, acme@redhat.com
Message-ID: <mhng-a8eaa55b-16b0-4b17-b202-881e75a65eaf@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 06:22:37 PDT (-0700), nikita.shubin@maquefel.me wrote:
> From: Nikita Shubin <n.shubin@yadro.com>
>
> This series aims to provide matching vendor SoC with corresponded JSON bindings.
>
> The ID string is proposed to be in form of MVENDORID-MARCHID-MIMPID, for example
> for Sifive Unmatched the corresponding string will be:
>
> 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
>
> Where MIMPID can vary as all impl supported the same number of events, this might not
> be true for all future SoC however.
>
> Also added SBI firmware events pretty names, as any firmware that supports SBI PMU
> should also support firmare events [1].
>
> Series depends on patch by Anup Patel, exposing mvendor, marchid and mimpid
> to "/proc/cpuinfo" [2].
>
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> [2] https://lkml.org/lkml/2022/7/27/23
>
> Link to previous version:
> https://patchwork.kernel.org/project/linux-riscv/list/?series=653649
>
> See original cover letter by João Mário Domingos:
> https://patchwork.kernel.org/project/linux-riscv/cover/20211116154812.17008-1-joao.mario@tecnico.ulisboa.pt/
>
> Tested with the following OpenSBI device tree bindings:
>
> ```
> pmu {
>         compatible = "riscv,pmu";
>         riscv,event-to-mhpmcounters =
>                 <0x03 0x06 0x18
>                 0x10001 0x10002 0x18
>                 0x10009 0x10009 0x18
>                 0x10011 0x10011 0x18
>                 0x10019 0x10019 0x18
>                 0x10021 0x10021 0x18>;
>         riscv,event-to-mhpmevent =
>                 <0x03 0x00000000 0x1801
>                 0x04 0x00000000 0x0302
>                 0x05 0x00000000 0x4000
>                 0x06 0x00000000 0x6001
>                 0x10001 0x00000000 0x0202
>                 0x10002 0x00000000 0x0402
>                 0x10009 0x00000000 0x0102
>                 0x10011 0x00000000 0x2002
>                 0x10019 0x00000000 0x1002
>                 0x10021 0x00000000 0x0802>;
>         riscv,raw-event-to-mhpmcounters =
>                 <0x00000000 0x03ffff00 0x0 0x0 0x18
>                 0x00000000 0x0007ff01 0x0 0x1 0x18
>                 0x00000000 0x00003f02 0x0 0x2 0x18>;
> };
> ```
> ---
> v5->v6:
> Will Deacon:
> 	- dropped first patch from v5 series it has been merged into master
> Mayuresh Chitale:
> 	- fixed FW_SFENCE_VMA_SENT event code
>
> - added Tested-by tags
> ---
>
> Nikita Shubin (3):
>   perf arch events: riscv sbi firmware std event files
>   perf vendor events riscv: add Sifive U74 JSON file
>   RISC-V: Added Syntacore SCR7 PMU events
>
>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  18 +++
>  .../arch/riscv/riscv-sbi-firmware.json        | 134 ++++++++++++++++++
>  .../arch/riscv/sifive/u74/firmware.json       |  68 +++++++++
>  .../arch/riscv/sifive/u74/instructions.json   |  92 ++++++++++++
>  .../arch/riscv/sifive/u74/memory.json         |  32 +++++
>  .../arch/riscv/sifive/u74/microarch.json      |  57 ++++++++
>  .../arch/riscv/syntacore/scr7/L1D_cache.json  | 102 +++++++++++++
>  .../arch/riscv/syntacore/scr7/L1I_cache.json  |  67 +++++++++
>  .../arch/riscv/syntacore/scr7/exceptions.json |  67 +++++++++
>  .../arch/riscv/syntacore/scr7/execution.json  |  97 +++++++++++++
>  .../arch/riscv/syntacore/scr7/firmware.json   |  68 +++++++++
>  .../arch/riscv/syntacore/scr7/general.json    |  47 ++++++
>  .../arch/riscv/syntacore/scr7/interrupts.json |  32 +++++
>  .../arch/riscv/syntacore/scr7/prediction.json |  52 +++++++
>  14 files changed, 933 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/riscv/mapfile.csv
>  create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/L1D_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/L1I_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/exceptions.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/execution.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/firmware.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/general.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/interrupts.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/prediction.json

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

not sure if you're looking for this via the RISC-V tree, it looks like 
usually these get merged via a perf tree?  That's OK with me, but I'm 
also OK taking them through the RISC-V tree.  Note that cpuinfo 
dependency seems to be triggering kasan failures, so we'll at least need 
to sort that out.
