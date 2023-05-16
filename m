Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4C2704643
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjEPHY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjEPHYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:24:39 -0400
X-Greylist: delayed 408 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 00:24:34 PDT
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532BF18E;
        Tue, 16 May 2023 00:24:34 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2f8a:0:640:b50b:0])
        by forward500a.mail.yandex.net (Yandex) with ESMTP id 9DE985EE9C;
        Tue, 16 May 2023 10:17:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id dHVrTK7WrW20-V20BbRZk;
        Tue, 16 May 2023 10:17:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1684221461;
        bh=2kRMUuAVEBFpEeN+FejcIVQONATDS4Jda1LwbThGWFE=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=QdC4uJC3ifix+88KCrNYCPELBdalvqExQWQJBec8lwyW8dMYiB18Zn6LZ+blo5Iwp
         yLeQN+Mey0n94xJv4/k5M/i3tv+6EneQkVfXN/A0iMi0E/kWMycUDLLoK0/7jItN12
         5AiRqdD95tp9SKLLY7D8YksimqDvzDvsNS9BL9pg=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <38eaec6b495786b048f78be08470f7c770793d7b.camel@maquefel.me>
Subject: Re: [PATCH 2/2] perf vendor events riscv: add T-HEAD C9xx JSON file
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Inochi Amaoto <inochiama@outlook.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Tue, 16 May 2023 13:17:40 +0300
In-Reply-To: <IA1PR20MB4953DF5B158C820D61D48CD6BB799@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20230516023714.306240-1-inochiama@outlook.com>
         <IA1PR20MB4953DF5B158C820D61D48CD6BB799@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Inochi Amaoto!

Do c906 and c910 have same HPM events ?

https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/=
pmu/rtl/aq_hpcp_top.v

and


https://github.com/T-head-Semi/openc910/blob/main/C910_RTL_FACTORY/gen_rtl/=
pmu/rtl/ct_hpcp_top.v

Look different to me - am i missing something ?

On Tue, 2023-05-16 at 10:37 +0800, Inochi Amaoto wrote:
> Add json file of T-HEAD C9xx events.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
> =C2=A0tools/perf/pmu-events/arch/riscv/mapfile.csv=C2=A0 |=C2=A0 1 +
> =C2=A0.../arch/riscv/t-head/c9xx/cache.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 67
> ++++++++++++++++++
> =C2=A0.../arch/riscv/t-head/c9xx/firmware.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 68
> +++++++++++++++++++
> =C2=A0.../arch/riscv/t-head/c9xx/instruction.json=C2=A0=C2=A0 | 22 ++++++
> =C2=A0.../arch/riscv/t-head/c9xx/microarch.json=C2=A0=C2=A0=C2=A0=C2=A0 |=
 42 ++++++++++++
> =C2=A05 files changed, 200 insertions(+)
> =C2=A0create mode 100644 tools/perf/pmu-events/arch/riscv/t-
> head/c9xx/cache.json
> =C2=A0create mode 100644 tools/perf/pmu-events/arch/riscv/t-
> head/c9xx/firmware.json
> =C2=A0create mode 100644 tools/perf/pmu-events/arch/riscv/t-
> head/c9xx/instruction.json
> =C2=A0create mode 100644 tools/perf/pmu-events/arch/riscv/t-
> head/c9xx/microarch.json
>=20
> diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv
> b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> index c61b3d6ef616..9fbdfcdc17ad 100644
> --- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> @@ -15,3 +15,4 @@
> =C2=A0#
> =C2=A0#MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
> =C2=A00x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
> +0x5b7-0x0000000000000000-0x[[:xdigit:]]+,v1,t-head/c9xx,core
> diff --git a/tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json
> b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json
> new file mode 100644
> index 000000000000..2c6e9a904a11
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json
> @@ -0,0 +1,67 @@
> +[
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "L1_ICACHE_ACCESS",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000001",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "L1 instruction cache access"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "L1_ICACHE_MISS",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000002",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "L1 instruction cache miss"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "INST_TLB_MISS",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000003",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "Instruction TLB (I-UTLB) miss"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "DATA_TLB_MISS",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000004",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "Data TLB (D-UTLB) miss"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "JTLB_MISS",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000005",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "JTLB access miss"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "L1_DCACHE_READ_ACCESS",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x00000c",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "L1 data cache read access"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "L1_DCACHE_READ_MISS",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x00000d",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "L1 data cache read miss"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "L1_DCACHE_WRITE_ACCESS",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x00000e",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "L1 data cache write access"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "L1_DCACHE_WRITE_MISS",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x00000f",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "L1 data cache write miss"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "L2_CACHE_READ_ACCESS",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000010",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "L2 cache read access"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "L2_CACHE_READ_MISS",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000011",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "L2 cache read miss"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "L2_CACHE_WRITE_ACCESS",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000012",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "L2 cache write access"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "L2_CACHE_WRITE_MISS",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000013",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "L2 cache write miss"
> +=C2=A0 }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/t-
> head/c9xx/firmware.json b/tools/perf/pmu-events/arch/riscv/t-
> head/c9xx/firmware.json
> new file mode 100644
> index 000000000000..9b4a032186a7
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json
> @@ -0,0 +1,68 @@
> +[
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_MISALIGNED_LOAD"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_MISALIGNED_STORE"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_ACCESS_LOAD"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_ACCESS_STORE"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_ILLEGAL_INSN"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_SET_TIMER"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_IPI_SENT"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_IPI_RECEIVED"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_FENCE_I_SENT"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_FENCE_I_RECEIVED"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_SFENCE_VMA_SENT"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_HFENCE_GVMA_SENT"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_HFENCE_GVMA_RECEIVED"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_HFENCE_GVMA_VMID_SENT"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_HFENCE_GVMA_VMID_RECEIVED"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_HFENCE_VVMA_SENT"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_HFENCE_VVMA_RECEIVED"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_HFENCE_VVMA_ASID_SENT"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "ArchStdEvent": "FW_HFENCE_VVMA_ASID_RECEIVED"
> +=C2=A0 }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/t-
> head/c9xx/instruction.json b/tools/perf/pmu-events/arch/riscv/t-
> head/c9xx/instruction.json
> new file mode 100644
> index 000000000000..53c5a9838400
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json
> @@ -0,0 +1,22 @@
> +[
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "BR_COND_MIS_PRED",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000006",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "Conditional branch mispredict"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "BR_INDIRECT_MIS_PRED",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000008",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "Indirect branch mispredict"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "BR_INDIRECT_INST",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000009",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "Indirect branch instruction"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "INST_STORE",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x00000b",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "Store instruction retired"
> +=C2=A0 }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/t-
> head/c9xx/microarch.json b/tools/perf/pmu-events/arch/riscv/t-
> head/c9xx/microarch.json
> new file mode 100644
> index 000000000000..47f94890d20f
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json
> @@ -0,0 +1,42 @@
> +[
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "LSU_SPEC_FAIL",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x00000a",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "LSU Spec Fail"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "RF_LAUNCH_FAIL",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000014",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "Register file launch fail"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "RF_REG_LAUNCH",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000015",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "Register file reg launch"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "RF_INSTRUCTION",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000016",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "Register file instruction"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "LSU_STALL_CROSS_4K",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000017",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "LSU stall with cross 4K access"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "LSU_STALL_OTHER",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000018",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "LSU stall with other events"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "LSU_SQ_DISCARD",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x000019",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "LSU SQ discard"
> +=C2=A0 },
> +=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 "EventName": "LSU_SQ_DISCARD_DATA",
> +=C2=A0=C2=A0=C2=A0 "EventCode": "0x00001a",
> +=C2=A0=C2=A0=C2=A0 "BriefDescription": "LSU SQ data discard"
> +=C2=A0 }
> +]

