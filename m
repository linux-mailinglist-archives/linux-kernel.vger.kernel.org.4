Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86186739394
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjFVALl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjFVALk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:11:40 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BE6A3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:11:38 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666eec46206so4442521b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687392698; x=1689984698;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+Wi9xFn6dXeDUKtBRL1SousO88GndmypdoRsR5NJe0=;
        b=eaexNfpaDvkf++Zy0+h5rOjdkwOACx7OGjyAWBR0/Wbe66iD7kwDOP9NhsKKTlcj6P
         mub2ZnsRFGeS9xt5D/uMWSjRBtsoGiv7h3rEGVaL2q6L/zgHINU1hIaxr9Etvtfa9+1l
         WWDfyktYtvpjXHBVuUC008N6kM6dlPvpFkm46KIHDK0Hdk2o+lIk+CaenqXBeJ+EoRzx
         8gXfsoN0CPxYcK6c+JEQlC4ELsKRs5g7vF3C5EB9oAAw8KOKLg8QDr/0Iy6JvuZZVI4E
         w50k6vzJ0BUiwupV5Dq0INVOBBdWhQfs7X5Af89dpeqaWne9eNtOU3VeL/1PVuOUJzBt
         lxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687392698; x=1689984698;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+Wi9xFn6dXeDUKtBRL1SousO88GndmypdoRsR5NJe0=;
        b=Cs0oayhDSjcOLalLkDhmZynKt2qb9NviS/3czpEEbhxLZKAN6XMIGDKGOO+/AAtGWC
         5gEL9UpGp3GjpBi7Q6fglrhr7IrPDnmOYdXt9utBff66npFvVkwpcMlysmDMYnmYOXB5
         Pcsjyp5KzMxGO/k8RnQ1r2S8VC71mMMlPZEL8iS1aEN1Xnc8dZWMikZ0MAMyP+tiY6mr
         U0u9/syek83s1XT/Rv1wGa7PT0laAh0229j08/5ewvYbTYb4KCWDwbl8sFfzTrqBUwVz
         FsU8Pyc1inT240kFUqPIo3rRz0jUTVFPU9vHvVyFgvGko1ox7IkD1lp/V/G/16av7oOY
         JG0w==
X-Gm-Message-State: AC+VfDw1px1DKaQuOpXFJEMY0tN8Ere+xD2Tj78R1tBDqV9tuscibNE1
        KCKvdIe4LQjDotBJTdbuYlyqPg==
X-Google-Smtp-Source: ACHHUZ5gSYeUPjOQt9/JRE6YocmDCougrbafKyH/ySbHLtbKS4yJMxVhhFsVUKEEnWRQIhUSFsFdmw==
X-Received: by 2002:a05:6a00:188e:b0:66a:1f3e:83e6 with SMTP id x14-20020a056a00188e00b0066a1f3e83e6mr6646657pfh.27.1687392697650;
        Wed, 21 Jun 2023 17:11:37 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id j2-20020a62b602000000b00660d80087a8sm3353468pff.187.2023.06.21.17.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 17:11:36 -0700 (PDT)
Date:   Wed, 21 Jun 2023 17:11:36 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Jun 2023 17:10:56 PDT (-0700)
Subject:     Re: [PATCH V3] perf vendor events riscv: add T-HEAD C9xx JSON file
In-Reply-To: <IA1PR20MB4953B6C4CB711506CF542737BB7E9@IA1PR20MB4953.namprd20.prod.outlook.com>
CC:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, n.shubin@yadro.com, inochiama@outlook.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     inochiama@outlook.com
Message-ID: <mhng-4c3ff0f7-43d1-46ca-83ee-bb9deacdaf99@palmer-ri-x1c9a>
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

On Wed, 17 May 2023 00:12:38 PDT (-0700), inochiama@outlook.com wrote:
> Add json file of T-HEAD C9xx series events.
>
> The event idx (raw value) is summary as following:
>
> event id range   | support cpu
>  0x01 - 0x06     |  c906,c910,c920
>  0x07            |  c906
>  0x08 - 0x0a     |  c910,c920
>  0x0b - 0x0f     |  c906,c910,c920
>  0x10 - 0x1a     |  c910,c920
>  0x1b - 0x1c     |  c910,c920 (software defined for all >= 0x1b)
>  0x1d - 0x2a     |  c906
>
> The event ids are based on the public document of T-HEAD and cover
> the c9xx series.
>
> These events are the max that c9xx series support.
> Since T-HEAD let manufacturers decide whether events are usable,
> the final support of the perf events is determined by the pmu node
> of the soc dtb.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
> Change from v2:
> 1. add C906 0x07 events to the instruction.json file
> 2. fix name for events 0x07 and 0x09 in instruction.json
>
> Example:
>
> This pmu node example can be used on sophgo sg2042 platform (c920) with
> mainline OpenSBI.
> It should also work on T-HEAD th1520.
>
> For the one use C906 core. Only event 0x01 - 0x07, 0xb - 0xf has known
> CSR mapping. The other events do not have known CSR mapping in document
> until now.
> This pmu node needs to be shorten to adopt c906
>
> pmu {
> 	compatible = "riscv,pmu";
> 	riscv,event-to-mhpmcounters =
> 		// event-start event-end a bitmap of all the MHPMCOUNTERx
> 		<0x00006 0x00006 0x00000400>,
> 		<0x00005 0x00005 0x00000800>,
> 		<0x10000 0x10000 0x00004000>,
> 		<0x10001 0x10001 0x00008000>,
> 		<0x10002 0x10002 0x00010000>,
> 		<0x10003 0x10003 0x00020000>,
> 		<0x10008 0x10008 0x00000008>,
> 		<0x10009 0x10009 0x00000010>,
> 		<0x10010 0x10010 0x00040000>,
> 		<0x10011 0x10011 0x00080000>,
> 		<0x10012 0x10012 0x00100000>,
> 		<0x10013 0x10013 0x00200000>,
> 		<0x10019 0x10019 0x00000040>,
> 		<0x10021 0x10021 0x00000020>;
> 	riscv,event-to-mhpmevent =
> 		// event-id event-selector
> 		/* mhpmevent3: L1I_READ_ACCESS */
> 		<0x10008 0x00000000 0x00000001>,
> 		/* mhpmevent4: L1I_READ_MISS */
> 		<0x10009 0x00000000 0x00000002>,
> 		/* mhpmevent5: ITLB_READ_MISS */
> 		<0x10021 0x00000000 0x00000003>,
> 		/* mhpmevent6: DTLB_READ_MISS */
> 		<0x10019 0x00000000 0x00000004>,
> 		/* mhpmevent10: PMU_HW_BRANCH_MISSES */
> 		<0x00006 0x00000000 0x00000008>,
> 		/* mhpmevent11: PMU_HW_BRANCH_INSTRUCTIONS */
> 		<0x00005 0x00000000 0x00000009>,
> 		/* mhpmevent14: L1D_READ_ACCESS */
> 		<0x10000 0x00000000 0x0000000c>,
> 		/* mhpmevent15: L1D_READ_MISS */
> 		<0x10001 0x00000000 0x0000000d>,
> 		/* mhpmevent16: L1D_WRITE_ACCESS */
> 		<0x10002 0x00000000 0x0000000e>,
> 		/* mhpmevent17: L1D_WRITE_MISS */
> 		<0x10003 0x00000000 0x0000000f>,
> 		/* mhpmevent18: LL_READ_ACCESS */
> 		<0x10010 0x00000000 0x00000010>,
> 		/* mhpmevent19: LL_READ_MISS */
> 		<0x10011 0x00000000 0x00000011>,
> 		/* mhpmevent20: LL_WRITE_ACCESS */
> 		<0x10012 0x00000000 0x00000012>,
> 		/* mhpmevent21: LL_WRITE_MISS */
> 		<0x10013 0x00000000 0x00000013>;
> 	riscv,raw-event-to-mhpmcounters =
> 		/* mhpmevent3: L1 ICache Access Counter */
> 		<0x00000000 0x00000001 0xffffffff 0xffffffff 0x00000008>,
> 		/* mhpmevent4: L1 ICache Miss Counter */
> 		<0x00000000 0x00000002 0xffffffff 0xffffffff 0x00000010>,
> 		/* mhpmevent5: I-UTLB Miss Counter */
> 		<0x00000000 0x00000003 0xffffffff 0xffffffff 0x00000020>,
> 		/* mhpmevent6: D-UTLB Miss Counter */
> 		<0x00000000 0x00000004 0xffffffff 0xffffffff 0x00000040>,
> 		/* mhpmevent7: JTLB Miss */
> 		<0x00000000 0x00000005 0xffffffff 0xffffffff 0x00000080>,
> 		/* mhpmevent8: Conditional Branch Mispredict */
> 		<0x00000000 0x00000006 0xffffffff 0xffffffff 0x00000100>,
> 		/* mhpmevent9: Conditional Branch Instruction Counter (reserved for c910)*/
> 		/* <0x00000000 0x00000007 0xffffffff 0xffffffff 0x00000200>, */
> 		/* mhpmevent10: Indirect Branch Mispredict Counter */
> 		<0x00000000 0x00000008 0xffffffff 0xffffffff 0x00000400>,
> 		/* mhpmevent11: Indirect Branch Instruction Counter */
> 		<0x00000000 0x00000009 0xffffffff 0xffffffff 0x00000800>,
> 		/* mhpmevent12: LSU Spec Fail */
> 		<0x00000000 0x0000000a 0xffffffff 0xffffffff 0x00001000>,
> 		/* mhpmevent13: Store Instruction */
> 		<0x00000000 0x0000000b 0xffffffff 0xffffffff 0x00002000>,
> 		/* mhpmevent14: L1 DCache read access Counter */
> 		<0x00000000 0x0000000c 0xffffffff 0xffffffff 0x00004000>,
> 		/* mhpmevent15: L1 DCache read miss Counter */
> 		<0x00000000 0x0000000d 0xffffffff 0xffffffff 0x00008000>,
> 		/* mhpmevent16: L1 DCache write access Counter */
> 		<0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00010000>,
> 		/* mhpmevent17: L1 DCache write access Counter */
> 		<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>,
> 		/* mhpmevent18: L2 Cache read access Counter */
> 		<0x00000000 0x00000010 0xffffffff 0xffffffff 0x00040000>,
> 		/* mhpmevent19: L2 Cache read miss Counter */
> 		<0x00000000 0x00000011 0xffffffff 0xffffffff 0x00080000>,
> 		/* mhpmevent20: L2 Cache write access Counter */
> 		<0x00000000 0x00000012 0xffffffff 0xffffffff 0x00100000>,
> 		/* mhpmevent21: L2 Cache write miss Counter */
> 		<0x00000000 0x00000013 0xffffffff 0xffffffff 0x00200000>,
> 		/* mhpmevent22: RF Launch Fail */
> 		<0x00000000 0x00000014 0xffffffff 0xffffffff 0x00400000>,
> 		/* mhpmevent23: RF Reg Launch Fail */
> 		<0x00000000 0x00000015 0xffffffff 0xffffffff 0x00800000>,
> 		/* mhpmevent24: RF Instruction */
> 		<0x00000000 0x00000016 0xffffffff 0xffffffff 0x01000000>,
> 		/* mhpmevent25: LSU Cross 4K Stall */
> 		<0x00000000 0x00000017 0xffffffff 0xffffffff 0x02000000>,
> 		/* mhpmevent26: LSU Other Stall */
> 		<0x00000000 0x00000018 0xffffffff 0xffffffff 0x04000000>,
> 		/* mhpmevent27: LSU SQ Discard */
> 		<0x00000000 0x00000019 0xffffffff 0xffffffff 0x08000000>,
> 		/* mhpmevent28: LSU SQ Data Discard */
> 		<0x00000000 0x0000001a 0xffffffff 0xffffffff 0x10000000>;
> };
>
> ---
>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
>  .../arch/riscv/t-head/c9xx/cache.json         | 67 +++++++++++++++++
>  .../arch/riscv/t-head/c9xx/firmware.json      | 68 ++++++++++++++++++
>  .../arch/riscv/t-head/c9xx/instruction.json   | 72 +++++++++++++++++++
>  .../arch/riscv/t-head/c9xx/microarch.json     | 67 +++++++++++++++++
>  5 files changed, 275 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json
>
> diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> index c61b3d6ef616..dd1d998a7ad6 100644
> --- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> @@ -15,3 +15,4 @@
>  #
>  #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
>  0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
> +0x5b7-0x0-0x0,v1,t-head/c9xx,core
> diff --git a/tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json
> new file mode 100644
> index 000000000000..2c6e9a904a11
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json
> @@ -0,0 +1,67 @@
> +[
> +  {
> +    "EventName": "L1_ICACHE_ACCESS",
> +    "EventCode": "0x000001",
> +    "BriefDescription": "L1 instruction cache access"
> +  },
> +  {
> +    "EventName": "L1_ICACHE_MISS",
> +    "EventCode": "0x000002",
> +    "BriefDescription": "L1 instruction cache miss"
> +  },
> +  {
> +    "EventName": "INST_TLB_MISS",
> +    "EventCode": "0x000003",
> +    "BriefDescription": "Instruction TLB (I-UTLB) miss"
> +  },
> +  {
> +    "EventName": "DATA_TLB_MISS",
> +    "EventCode": "0x000004",
> +    "BriefDescription": "Data TLB (D-UTLB) miss"
> +  },
> +  {
> +    "EventName": "JTLB_MISS",
> +    "EventCode": "0x000005",
> +    "BriefDescription": "JTLB access miss"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_READ_ACCESS",
> +    "EventCode": "0x00000c",
> +    "BriefDescription": "L1 data cache read access"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_READ_MISS",
> +    "EventCode": "0x00000d",
> +    "BriefDescription": "L1 data cache read miss"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_WRITE_ACCESS",
> +    "EventCode": "0x00000e",
> +    "BriefDescription": "L1 data cache write access"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_WRITE_MISS",
> +    "EventCode": "0x00000f",
> +    "BriefDescription": "L1 data cache write miss"
> +  },
> +  {
> +    "EventName": "L2_CACHE_READ_ACCESS",
> +    "EventCode": "0x000010",
> +    "BriefDescription": "L2 cache read access"
> +  },
> +  {
> +    "EventName": "L2_CACHE_READ_MISS",
> +    "EventCode": "0x000011",
> +    "BriefDescription": "L2 cache read miss"
> +  },
> +  {
> +    "EventName": "L2_CACHE_WRITE_ACCESS",
> +    "EventCode": "0x000012",
> +    "BriefDescription": "L2 cache write access"
> +  },
> +  {
> +    "EventName": "L2_CACHE_WRITE_MISS",
> +    "EventCode": "0x000013",
> +    "BriefDescription": "L2 cache write miss"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json
> new file mode 100644
> index 000000000000..9b4a032186a7
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json
> @@ -0,0 +1,68 @@
> +[
> +  {
> +    "ArchStdEvent": "FW_MISALIGNED_LOAD"
> +  },
> +  {
> +    "ArchStdEvent": "FW_MISALIGNED_STORE"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ACCESS_LOAD"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ACCESS_STORE"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ILLEGAL_INSN"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SET_TIMER"
> +  },
> +  {
> +    "ArchStdEvent": "FW_IPI_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_IPI_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_FENCE_I_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_FENCE_I_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_RECEIVED"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json
> new file mode 100644
> index 000000000000..7f1649548177
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json
> @@ -0,0 +1,72 @@
> +[
> +  {
> +    "EventName": "BR_COND_MIS_PRED",
> +    "EventCode": "0x000006",
> +    "BriefDescription": "Conditional branch mispredict"
> +  },
> +  {
> +    "EventName": "INST_BR_COND_MIS",
> +    "EventCode": "0x000007",
> +    "BriefDescription": "Conditional branch instruction"
> +  },
> +  {
> +    "EventName": "BR_INDIRECT_MIS_PRED",
> +    "EventCode": "0x000008",
> +    "BriefDescription": "Indirect branch mispredict"
> +  },
> +  {
> +    "EventName": "INST_BR_COND_MIS",
> +    "EventCode": "0x000009",
> +    "BriefDescription": "Indirect branch instruction"
> +  },
> +  {
> +    "EventName": "INST_STORE",
> +    "EventCode": "0x00000b",
> +    "BriefDescription": "Store instruction retired"
> +  },
> +  {
> +    "EventName": "INST_ALU",
> +    "EventCode": "0x00001d",
> +    "BriefDescription": "ALU instruction retired"
> +  },
> +  {
> +    "EventName": "INST_LOAD_SAVE",
> +    "EventCode": "0x00001e",
> +    "BriefDescription": "LOAD/Store instruction retired"
> +  },
> +  {
> +    "EventName": "INST_VECTOR",
> +    "EventCode": "0x00001f",
> +    "BriefDescription": "Vector instruction retired"
> +  },
> +  {
> +    "EventName": "INST_CSR_ACCESS",
> +    "EventCode": "0x000020",
> +    "BriefDescription": "CSR access instruction retired"
> +  },
> +  {
> +    "EventName": "INST_SYNC",
> +    "EventCode": "0x000021",
> +    "BriefDescription": "Sync instruction retired"
> +  },
> +  {
> +    "EventName": "INST_LOAD_SAVE_UNALIGNED",
> +    "EventCode": "0x000022",
> +    "BriefDescription": "Load/Store unaligned access instruction retired"
> +  },
> +  {
> +    "EventName": "INST_ENV_CALL",
> +    "EventCode": "0x000025",
> +    "BriefDescription": "Environment call instruction retired"
> +  },
> +  {
> +    "EventName": "INST_LONGJUMP",
> +    "EventCode": "0x000026",
> +    "BriefDescription": "Long jump instruction retired (jump dist over 8MB)"
> +  },
> +  {
> +    "EventName": "INST_FP",
> +    "EventCode": "0x00002a",
> +    "BriefDescription": "Float point instruction retired"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json
> new file mode 100644
> index 000000000000..073c1d085021
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json
> @@ -0,0 +1,67 @@
> +[
> +  {
> +    "EventName": "LSU_SPEC_FAIL",
> +    "EventCode": "0x00000a",
> +    "BriefDescription": "LSU Spec Fail"
> +  },
> +  {
> +    "EventName": "RF_LAUNCH_FAIL",
> +    "EventCode": "0x000014",
> +    "BriefDescription": "Register file launch fail"
> +  },
> +  {
> +    "EventName": "RF_REG_LAUNCH",
> +    "EventCode": "0x000015",
> +    "BriefDescription": "Register file reg launch"
> +  },
> +  {
> +    "EventName": "RF_INSTRUCTION",
> +    "EventCode": "0x000016",
> +    "BriefDescription": "Register file instruction"
> +  },
> +  {
> +    "EventName": "LSU_STALL_CROSS_4K",
> +    "EventCode": "0x000017",
> +    "BriefDescription": "LSU stall with cross 4K access"
> +  },
> +  {
> +    "EventName": "LSU_STALL_OTHER",
> +    "EventCode": "0x000018",
> +    "BriefDescription": "LSU stall with other events"
> +  },
> +  {
> +    "EventName": "LSU_SQ_DISCARD",
> +    "EventCode": "0x000019",
> +    "BriefDescription": "LSU SQ discard"
> +  },
> +  {
> +    "EventName": "LSU_SQ_DISCARD_DATA",
> +    "EventCode": "0x00001a",
> +    "BriefDescription": "LSU SQ data discard"
> +  },
> +  {
> +    "EventName": "INT_NUMBER",
> +    "EventCode": "0x000023",
> +    "BriefDescription": "Interrupt number respond"
> +  },
> +  {
> +    "EventName": "INT_OFF_CYCLE",
> +    "EventCode": "0x000024",
> +    "BriefDescription": "Off cycle before interrupt arbitrating"
> +  },
> +  {
> +    "EventName": "STALLED_CYCLE_IFU",
> +    "EventCode": "0x000027",
> +    "BriefDescription": "Stall cycles of the instruction fetch unit"
> +  },
> +  {
> +    "EventName": "STALLED_CYCLE_IDU",
> +    "EventCode": "0x000028",
> +    "BriefDescription": "Stall cycles of the instruction decoding unit and next-level pipeline unit"
> +  },
> +  {
> +    "EventName": "STALLED_CYCLE_SYNC",
> +    "EventCode": "0x000029",
> +    "BriefDescription": "Stalled cycle for sync instructions (FENCE/FENCE.i/SFENCE/SYNC...)"
> +  }
> +]

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
