Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5285B5701
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiILJO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiILJOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:14:54 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EF095B0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:14:46 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:cc25:8ef2:d433:c52b])
        by albert.telenet-ops.be with bizsmtp
        id JxEj280053GaAlK06xEjN5; Mon, 12 Sep 2022 11:14:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oXfWd-004voP-FA
        for linux-kernel@vger.kernel.org; Mon, 12 Sep 2022 11:14:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oXfVN-007TCz-DA
        for linux-kernel@vger.kernel.org; Mon, 12 Sep 2022 11:13:25 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.0-rc5
Date:   Mon, 12 Sep 2022 11:13:25 +0200
Message-Id: <20220912091325.1780524-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
References: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v6.0-rc5[1] compared to v5.19[2].

Summarized:
  - build errors: +19/-15
  - build warnings: +7/-28

JFYI, when comparing v6.0-rc5[1] to v6.0-rc4[3], the summaries are:
  - build errors: +16/-1
  - build warnings: +0/-0

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/80e78fcce86de0288793a0ef0f6acf37656ee4cf/ (all 135 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3d7cb6b04c3f3115719235cc6866b10326de34cd/ (all 135 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e18e42e4b280c85b76967a9106a13ca61c16179/ (all 135 configs)


*** ERRORS ***

19 error regressions:
  + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: .cfi_endproc without corresponding .cfi_startproc:  => 32
  + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: bad or irreducible absolute expression:  => 16
  + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: junk at end of line, first unrecognized character is `:':  => 16
  + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: no such instruction: `be 0x100(%sr2,%r0)':  => 29
  + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: no such instruction: `ldi 0,%r20':  => 30
  + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: no such instruction: `ldw 0(%sp),%r31':  => 26
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ble 0x100(%sr2,%r0)':  => 51, 46
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ldi 0,%r25':  => 44
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ldi 1,%r25':  => 49
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ldi 173,%r20':  => 45, 50
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.callinfo':  => 40
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.entry':  => 41
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.exit':  => 54
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.proc':  => 39
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.procend':  => 55
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.stringz':  => 76
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: error: the frame size of 2096 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 6806:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: error: the frame size of 2144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 3768:1
  + /kisskb/src/include/linux/bitfield.h: error: call to '__field_overflow' declared with attribute error: value doesn't fit into mask:  => 151:3

15 error improvements:
  - /kisskb/src/arch/um/include/asm/processor-generic.h: error: called object is not a function or function pointer: 103:18 => 
  - /kisskb/src/crypto/blake2b_generic.c: error: the frame size of 2288 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]: 109:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: control reaches end of non-void function [-Werror=return-type]: 1614:1 => 
  - /kisskb/src/drivers/gpu/drm/r128/r128_cce.c: error: case label does not reduce to an integer constant: 418:2, 417:2 => 
  - /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'X86_VENDOR_AMD' undeclared (first use in this function): 149:37 => 
  - /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'struct cpuinfo_um' has no member named 'x86_vendor': 149:22 => 
  - /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: control reaches end of non-void function [-Werror=return-type]: 150:1 => 
  - /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size': 88:22 => 
  - /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]: 89:1 => 
  - /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]: 100:2 => 
  - {standard input}: Error: displacement to undefined symbol .L271 overflows 12-bit field: 1625 => 
  - {standard input}: Error: displacement to undefined symbol .L271 overflows 8-bit field : 1634 => 
  - {standard input}: Error: displacement to undefined symbol .L318 overflows 8-bit field : 1681, 1665, 1711, 1693 => 
  - {standard input}: Error: pcrel too far: 1673, 1684, 1667, 1698, 1644, 1655, 1702, 1676, 1670, 1660, 1686, 1705, 1656, 1695, 1609, 1657, 1672, 1700, 1635, 1685, 1649, 1629, 1618, 1632 => 
  - {standard input}: Error: unknown opcode: 1713 => 


*** WARNINGS ***

7 warning regressions:
  + /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 407:1
  + /kisskb/src/fs/mpage.c: warning: the frame size of 1092 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 308:1
  + /kisskb/src/fs/mpage.c: warning: the frame size of 1144 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 634:1
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_100000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: vmlinux.o: section mismatch in reference: __trace_event_discard_commit (section: .text.unlikely) -> initcall_level_names (section: .init.data):  => N/A

28 warning improvements:
  - /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 407:1 => 
  - /kisskb/src/fs/mpage.c: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 303:1 => 
  - /kisskb/src/fs/mpage.c: warning: the frame size of 1148 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 638:1 => 
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for ZPOOL: 61 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for ZPOOL: 37 => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14410): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14428): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14440): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14458): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14470): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14488): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x144a0): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x144f0): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14508): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14520): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14538): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14550): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14568): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14580): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14598): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47b0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47c8): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47e0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47f8): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4810): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4828): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4840): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x52bc): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
