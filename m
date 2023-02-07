Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D361868D408
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjBGKZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjBGKZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:25:47 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DDE16AF7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:25:46 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 823AB5C00FE;
        Tue,  7 Feb 2023 05:25:45 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 07 Feb 2023 05:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1675765545; x=1675851945; bh=fERpdh5ZhQaS6mH1UtMYu3Lm9o59WOgioSw
        nRN0u4Hk=; b=JGrjHmlNZ91P1xJrMN9z5O0gizSxiRC54v5Gh2Rz4sVIf7gUuv9
        PDxWB+kB2Y/6Lc1Q1wskyNnu8HoV4XXSuDsGOcCb5z3BvUO8JX5LD4ZWl6nXxMs4
        FhrNIPi+OXSEmcbLbYsA1NvJ6MzZ+uhUstj9vbW7yw3vXmnsL4mvFDGRoyr1Q5QT
        VpqGmLx7FIeP/S8p6dtimaxk/qZTBpikz5uaPI9+1Wow/nCmkdIgoNuktsAMBv/P
        +V6WXF3AwceNxhIZU31/ljF56kszGvbg0BwEwPVvGTPyya7VWNRGXIsQ4v98ElBi
        074Y1nxcHt+AXWNsXjZYzQcWzLEw4AbJcJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1675765545; x=
        1675851945; bh=fERpdh5ZhQaS6mH1UtMYu3Lm9o59WOgioSwnRN0u4Hk=; b=A
        NmXbvky/vf67WaW3iWd+Tronn/KJdYhzdFKeMTZ43w7mfwyGzwAhYZD3U9P0ToqK
        bNVZxPDgA2MYac8qkK2iqnRL5qdsfPqlzuBRnHzTOpcYka+UrMTIMgmTJ28/lNie
        F+mOwb0kTkK4vtqwVWM9GBywsVFyXrjMEUrkTZ+rjB4linvUZDM2SsIahVGezGX3
        hozfPCUn3It7qbRFgF4rDqjszz9G6esVMQJVxdM2HyODKHwZECuACCZKcBPTTc+L
        zpjchdCJRU52PkENkUe86RHxunhjH+iZWJ6vPi+7MXzfKUk+CgyDznD9zsTUgstg
        xYwWYczwqQw1U+O5MQChg==
X-ME-Sender: <xms:KSfiY9HsuBWmRrksmkY_ukUFEo4BURPantiYy5BssC-F6iGYxCgXoQ>
    <xme:KSfiYyW3IjuHji58zC4EwGt7j-fNxWOLDuOO3Uvz91j7Q1j66hcwIAyWHYra2MkTS
    vA-U9IZu79k8e8YW8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepuefhffffvdekhfeivdfhtdfhueevtdffhfehjeeifeekgeeguedugeefhedufffg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:KSfiY_KQz0GLXuNk0FhetcKoCrUUAe0ZMompvW6JzKc7RvWDVRc1fQ>
    <xmx:KSfiYzGPlUH6SdfLjibmtngkaJj0v4kFgOh9milqKgj5yPFooOeDTQ>
    <xmx:KSfiYzXCwwbsaGKpHf_BVUko-N8q-RytU3C5F2tMpt-A0DTsIUhMUA>
    <xmx:KSfiY6fvopT4E62l8tOPMj_YrHw1I-63cFSIV2Zc7QFwtgBgUjYO4w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3B5D7B60086; Tue,  7 Feb 2023 05:25:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <9698eff1-9680-4f0a-94de-590eaa923e94@app.fastmail.com>
Date:   Tue, 07 Feb 2023 11:25:27 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: current objtool warnings from randconfig builds
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh and Peter,

I've updated my randconfig test setup to use gcc-13 and clang-16, and
have sent fixes for all normal WERROR=y build warnings, but there are a
lot of objtool warnings that remain. I've reported some of them in
the past, some others are new. It would be nice to at least reduce
the number of warnings either through code changes or workarounds
in objtool for any false positives.

Out of 1500 builds, about a third had any warnings, this is the full
list sorted by frequency. Let me know if there are any that you haven't
seen before, I can provide the corresponding object and config files
for reproducing.

    Arnd

8<---
205 mm/kasan/shadow.o: warning: objtool: __asan_memset+0x2e: call to __memset() with UACCESS enabled
205 mm/kasan/shadow.o: warning: objtool: __asan_memmove+0x48: call to __memmove() with UACCESS enabled
205 mm/kasan/shadow.o: warning: objtool: __asan_memcpy+0x48: call to __memcpy() with UACCESS enabled
80 vmlinux.o: warning: objtool: ibt_selftest+0x11: sibling call from callable instruction with modified stack frame
49 vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0x100: relocation to !ENDBR: native_write_cr4+0x4
29 mm/kasan/generic.o: warning: objtool: kasan_check_range+0x1e: call to addr_has_metadata() with UACCESS enabled
29 mm/kasan/generic.o: warning: objtool: __asan_load2+0x11: call to addr_has_metadata() with UACCESS enabled
29 drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool: vmw_port_hb_out+0x15e: return with modified stack frame
29 drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool: vmw_port_hb_out+0x11d: stack state mismatch: cfa1=5+16 cfa2=4+8
29 drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool: vmw_port_hb_in+0x150: return with modified stack frame
29 drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool: vmw_port_hb_in+0x13d: stack state mismatch: cfa1=5+16 cfa2=4+8
29 drivers/gpu/drm/vmwgfx/vmwgfx.o: warning: objtool: vmw_port_hb_out+0xe2: return with modified stack frame
29 drivers/gpu/drm/vmwgfx/vmwgfx.o: warning: objtool: vmw_port_hb_out+0xd1: stack state mismatch: cfa1=5+16 cfa2=4+8
29 drivers/gpu/drm/vmwgfx/vmwgfx.o: warning: objtool: vmw_port_hb_in+0xea: return with modified stack frame
29 drivers/gpu/drm/vmwgfx/vmwgfx.o: warning: objtool: vmw_port_hb_in+0xcc: stack state mismatch: cfa1=5+16 cfa2=4+8
28 mm/kasan/generic.o: warning: objtool: __asan_store16+0x11: call to addr_has_metadata() with UACCESS enabled
28 mm/kasan/generic.o: warning: objtool: __asan_load16+0x11: call to addr_has_metadata() with UACCESS enabled
23 fs/reiserfs/do_balan.o: warning: objtool: balance_leaf+0x100ac: stack state mismatch: cfa1=4+464 cfa2=4+456
22 mm/kasan/generic.o: warning: objtool: __asan_load4+0x11: call to addr_has_metadata() with UACCESS enabled
21 mm/kasan/generic.o: warning: objtool: __asan_store4+0x11: call to addr_has_metadata() with UACCESS enabled
21 mm/kasan/generic.o: warning: objtool: __asan_store1+0x11: call to addr_has_metadata() with UACCESS enabled
21 mm/kasan/generic.o: warning: objtool: __asan_load8+0x11: call to addr_has_metadata() with UACCESS enabled
21 mm/kasan/generic.o: warning: objtool: __asan_load1+0x11: call to addr_has_metadata() with UACCESS enabled
18 fs/reiserfs/reiserfs.o: warning: objtool: balance_internal+0x1238: stack state mismatch: cfa1=4+248 cfa2=4+256
18 fs/reiserfs/ibalance.o: warning: objtool: balance_internal+0x10a2: stack state mismatch: cfa1=4+232 cfa2=4+256
17 arch/x86/coco/tdx/tdcall.o: warning: objtool: __tdx_hypercall+0xb0: return with modified stack frame
15 vmlinux.o: warning: objtool: ftrace_likely_update+0xd2: call to __stack_chk_fail() with UACCESS enabled
15 kernel/trace/trace_branch.o: warning: objtool: ftrace_likely_update+0x201: call to __stack_chk_fail() with UACCESS enabled
14 mm/kasan/generic.o: warning: objtool: __asan_store2+0x11: call to addr_has_metadata() with UACCESS enabled
14 arch/x86/kvm/kvm.o: warning: objtool: .text+0x0: unreachable instruction
13 mm/kasan/generic.o: warning: objtool: __asan_store8+0x11: call to addr_has_metadata() with UACCESS enabled
11 vmlinux.o: warning: objtool: replace_key+0x1b2: stack state mismatch: cfa1=4+72 cfa2=4+88
8 vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x49: relocation to !ENDBR: kgdb_ll_trap+0x6a
8 vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to !ENDBR: kgdb_arch_late+0x193
8 vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !ENDBR: kexec_mark_range+0x13
8 vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !ENDBR: kexec_mark_crashkres+0x53
8 vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !ENDBR: .text+0x4b314
8 drivers/media/platform/qcom/camss/qcom-camss.o: warning: objtool: csiphy_lanes_enable() falls through to next function __cfi_csiphy_hw_version_read()
8 drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.o: warning: objtool: csiphy_lanes_enable() falls through to next function __cfi_csiphy_get_lane_mask()
7 vmlinux.o: warning: objtool: internal_move_pointers_items+0x3fa: stack state mismatch: cfa1=4+144 cfa2=4+136
7 fs/jffs2/jffs2.o: warning: objtool: jffs2_erase_pending_blocks() falls through to next function jffs2_free_jeb_node_refs()
7 fs/jffs2/erase.o: warning: objtool: jffs2_erase_pending_blocks() falls through to next function __cfi_jffs2_free_jeb_node_refs()
7 drivers/hwmon/pmbus/adm1275.o: warning: objtool: adm1275_probe+0x574: unreachable instruction
5 vmlinux.o: warning: objtool: exynos3250_cmu_isp_probe+0x17: unreachable instruction
5 arch/x86/mm/fault.o: warning: objtool: do_user_addr_fault+0x2c0: unreachable instruction
5 arch/x86/kvm/kvm-amd.o: warning: objtool: __svm_vcpu_run+0x141: BP used as a scratch register
5 arch/x86/kvm/kvm-amd.o: warning: objtool: __svm_sev_es_vcpu_run+0x36: BP used as a scratch register
4 vmlinux.o: warning: objtool: resume_play_dead+0xe: unreachable instruction
4 vmlinux.o: warning: objtool: hyperv_init+0x55c: unreachable instruction
4 vmlinux.o: warning: objtool: do_idle+0x15e: unreachable instruction
4 drivers/media/i2c/m5mols/m5mols_core.o: warning: objtool: m5mols_set_fmt() falls through to next function __cfi_m5mols_get_frame_desc()
3 vmlinux.o: warning: objtool: nmi_panic+0x2d: unreachable instruction
3 vmlinux.o: warning: objtool: mptscsih_abort+0x319: unreachable instruction
3 vmlinux.o: warning: objtool: internal_delete_pointers_items+0x392: stack state mismatch: cfa1=4+136 cfa2=4+144
3 vmlinux.o: warning: objtool: emulate_vsyscall+0x1ff: unreachable instruction
3 vmlinux.o: warning: objtool: do_arch_prctl_64+0x1ac: unreachable instruction
3 fs/xfs/libxfs/xfs_da_btree.o: warning: objtool: xfs_da_grow_inode_int+0x397: stack state mismatch: reg1[12]=-2-48 reg2[12]=-1+0
3 drivers/spi/spi-amd.o: warning: objtool: amd_spi_master_transfer() falls through to next function __cfi_amd_spi_max_transfer_size()
3 drivers/pwm/pwm-mediatek.o: warning: objtool: .text: unexpected end of section
3 drivers/gpu/drm/i915/gt/intel_timeline.o: warning: objtool: live_hwsp_read+0x318: stack state mismatch: cfa1=4+240 cfa2=5+48
3 arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0xba7: unreachable instruction
2 vmlinux.o: warning: objtool: xenpv_exc_double_fault+0x9: unreachable instruction
2 vmlinux.o: warning: objtool: pwm_mediatek_apply() falls through to next function mtk_disp_pwm_probe()
2 vmlinux.o: warning: objtool: force_ibs_eilvt_setup+0xad: unreachable instruction
2 vmlinux.o: warning: objtool: exynos7885_cmu_probe+0x1b: unreachable instruction
2 vmlinux.o: warning: objtool: do_one_initcall+0x1f6: unreachable instruction
2 mm/kmsan/report.o: warning: objtool: kmsan_report+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_warning+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_poison_alloca+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_store_n+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_store_8+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_store_4+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_store_2+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_store_1+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_load_n+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_load_8+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_load_4+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_load_2+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_load_1+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_instrument_asm_store+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_get_context_state+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/instrumentation.o: warning: objtool: __msan_chain_origin+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/hooks.o: warning: objtool: kmsan_unpoison_memory+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/hooks.o: warning: objtool: kmsan_unpoison_entry_regs+0x0: call to __fentry__() with UACCESS enabled
2 mm/kmsan/hooks.o: warning: objtool: kmsan_copy_to_user+0x0: call to __fentry__() with UACCESS enabled
2 fs/reiserfs/lbalance.o: warning: objtool: leaf_move_items+0x7ab: stack state mismatch: cfa1=4+160 cfa2=4+152
2 drivers/video/fbdev/omap2/omapfb/dss/omapdss.o: warning: objtool: hdmi_power_on_full.isra.0+0x5e: unreachable instruction
2 drivers/net/wwan/iosm/iosm.o: warning: objtool: ipc_imem_run_state_worker() falls through to next function ipc_imem_startup_timer_cb()
2 drivers/iio/imu/bmi160/bmi160_core.o: warning: objtool: bmi160_setup_irq() falls through to next function bmi160_data_rdy_trigger_set_state()
1 vmlinux.o: warning: objtool: trace_initcall_finish+0xee: unreachable instruction
1 vmlinux.o: warning: objtool: native_sched_clock_from_tsc+0x60: unreachable instruction
1 vmlinux.o: warning: objtool: lpass_cdc_dma_daiops_trigger() falls through to next function lpass_hdmi_daiops_hw_params()
1 drivers/crypto/keembay/keembay-ocs-hcu.o: warning: objtool: ocs_hcu_hmac+0x153: stack state mismatch: cfa1=4+136 cfa2=5+48
1 arch/x86/kvm/kvm-amd.o: warning: objtool: .altinstr_replacement+0x108: call without frame pointer save/setup
