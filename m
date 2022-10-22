Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AE8609056
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJVW4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJVW4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:56:44 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C077CABB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:56:42 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id o65so5111674iof.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFv6klmLex8GcpwEYKFzL/qYorx4xChHakZG9csO4Oc=;
        b=ls2yiRHGXsdCstUQaPjVXs4Hxliu600yIjc9OFSu4EM7wnPYxpMVuRw/VyvKkccNcd
         0amks+DDaCA90Voal+oss6JNmKNXfaAFM1ci7eDHIlbNAbrgGd4QHxsve77Utd1Z7CZC
         mkKqTz1Cd/P6j2zddkZVps3Jrh8Qb2AYjmVv6QoHUhhYizwb1Bj5Y1Ryyy37uBSMe5Br
         dvRrFiK9sqYNUj9yT0pgnY6JCbqgVFEGg74bYTlecmsRh9nEfUmcsvKiEaw5QfSi2ac9
         7woT8a7Cok4RAjr481YXuhQvWTpUp05uQVVl7OkXeK15Xrk1XLrCu8/74mM4qs09nusd
         z6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFv6klmLex8GcpwEYKFzL/qYorx4xChHakZG9csO4Oc=;
        b=3vj9nVTkzFc2OTtAM0UiVyK3Z8qDohRPxtZG+eJnaYP+cHU/S3mxHcQhrNJd0/yiwp
         VeSmdlWJKttepS3R6Y2C+gTSa6P7HK1n8K8VjJ+s4iAxh0jAPSflZ0VlxF9jXCpYJOIU
         5kXiGNplZNNbVUhUbYK0YFSzDoS2U7DXnC6yrfPMZ7vHD45t+rhn6Cj7BSn/e2bo3xJS
         Fv01xRgwJ3fxpy3ZUXnYIV6WTF0BsljHRGQzPayrKSYggsT8D9LsHSAO+CecJvj2Lr8q
         BWb/NlZSANEiumMeryxg0OojENnjI3N2U0xIJ9IUWA9KdkTodTArYnC81AzGnNQ9DHDg
         l7xA==
X-Gm-Message-State: ACrzQf2EvlGNYv1CwOKEN2ro374lmmXNK2hXTVuRqiJQoPiNooUwqKh6
        lCZzD+D7i5Ih0Oxx8le2tD/C/ExVbjA=
X-Google-Smtp-Source: AMsMyM5vvTFkCLfTgh8LSKfi3f5Hst60upTpIh11bICkbdnk5NJqGtXFTPa8kPkUIODhT++erFOlDg==
X-Received: by 2002:a05:6602:29d1:b0:6a9:d284:74a7 with SMTP id z17-20020a05660229d100b006a9d28474a7mr16788200ioq.22.1666479400888;
        Sat, 22 Oct 2022 15:56:40 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o9-20020a927309000000b002fc323a2902sm2492267ilc.62.2022.10.22.15.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 15:56:40 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 1/2] vmlinux.lds.h: add BOUNDED_SECTION* macros
Date:   Sat, 22 Oct 2022 16:56:36 -0600
Message-Id: <20221022225637.1406715-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221022225637.1406715-1-jim.cromie@gmail.com>
References: <20221022225637.1406715-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.lds.h has ~45 occurrences of this general pattern:

  __start_foo = .;
  KEEP(*(foo))
  __stop_foo = .;

Reduce this pattern to a (group of 4) macros, and use them to reduce
linecount.  This was inspired by the codetag patchset.

no functional change.

CC: Suren Baghdasaryan <surenb@google.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---

Shall we bikeshed the names ?
---
 include/asm-generic/vmlinux.lds.h | 219 +++++++++++-------------------
 1 file changed, 79 insertions(+), 140 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c15de165ec8f..9f6352171f88 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -193,100 +193,99 @@
 # endif
 #endif
 
+#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _s_, _e_)		\
+	_s_##_label_ = .;						\
+	KEEP(*(_sec_))							\
+	_e_##_label_ = .;
+
+#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _s_, _e_)		\
+	_label_##_s_ = .;						\
+	KEEP(*(_sec_))							\
+	_label_##_e_ = .;
+
+#define BOUNDED_SECTION_BY(_sec_, _label_)				\
+	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
+
+#define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
+
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
-#define LIKELY_PROFILE()	__start_annotated_branch_profile = .;	\
-				KEEP(*(_ftrace_annotated_branch))	\
-				__stop_annotated_branch_profile = .;
+#define LIKELY_PROFILE()						\
+	BOUNDED_SECTION_BY(_ftrace_annotated_branch, _annotated_branch_profile)
 #else
 #define LIKELY_PROFILE()
 #endif
 
 #ifdef CONFIG_PROFILE_ALL_BRANCHES
-#define BRANCH_PROFILE()	__start_branch_profile = .;		\
-				KEEP(*(_ftrace_branch))			\
-				__stop_branch_profile = .;
+#define BRANCH_PROFILE()					\
+	BOUNDED_SECTION_BY(_ftrace_branch, _branch_profile)
 #else
 #define BRANCH_PROFILE()
 #endif
 
 #ifdef CONFIG_KPROBES
-#define KPROBE_BLACKLIST()	. = ALIGN(8);				      \
-				__start_kprobe_blacklist = .;		      \
-				KEEP(*(_kprobe_blacklist))		      \
-				__stop_kprobe_blacklist = .;
+#define KPROBE_BLACKLIST()				\
+	. = ALIGN(8);					\
+	BOUNDED_SECTION(_kprobe_blacklist)
 #else
 #define KPROBE_BLACKLIST()
 #endif
 
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
-#define ERROR_INJECT_WHITELIST()	STRUCT_ALIGN();			      \
-			__start_error_injection_whitelist = .;		      \
-			KEEP(*(_error_injection_whitelist))		      \
-			__stop_error_injection_whitelist = .;
+#define ERROR_INJECT_WHITELIST()			\
+	STRUCT_ALIGN();					\
+	BOUNDED_SECTION(_error_injection_whitelist)
 #else
 #define ERROR_INJECT_WHITELIST()
 #endif
 
 #ifdef CONFIG_EVENT_TRACING
-#define FTRACE_EVENTS()	. = ALIGN(8);					\
-			__start_ftrace_events = .;			\
-			KEEP(*(_ftrace_events))				\
-			__stop_ftrace_events = .;			\
-			__start_ftrace_eval_maps = .;			\
-			KEEP(*(_ftrace_eval_map))			\
-			__stop_ftrace_eval_maps = .;
+#define FTRACE_EVENTS()							\
+	. = ALIGN(8);							\
+	BOUNDED_SECTION(_ftrace_events)					\
+	BOUNDED_SECTION_BY(_ftrace_eval_map, _ftrace_eval_maps)
 #else
 #define FTRACE_EVENTS()
 #endif
 
 #ifdef CONFIG_TRACING
-#define TRACE_PRINTKS()	 __start___trace_bprintk_fmt = .;      \
-			 KEEP(*(__trace_printk_fmt)) /* Trace_printk fmt' pointer */ \
-			 __stop___trace_bprintk_fmt = .;
-#define TRACEPOINT_STR() __start___tracepoint_str = .;	\
-			 KEEP(*(__tracepoint_str)) /* Trace_printk fmt' pointer */ \
-			 __stop___tracepoint_str = .;
+#define TRACE_PRINTKS()		BOUNDED_SECTION_BY(__trace_printk_fmt, ___trace_bprintk_fmt)
+#define TRACEPOINT_STR()	BOUNDED_SECTION_BY(__tracepoint_str, ___tracepoint_str)
 #else
 #define TRACE_PRINTKS()
 #define TRACEPOINT_STR()
 #endif
 
 #ifdef CONFIG_FTRACE_SYSCALLS
-#define TRACE_SYSCALLS() . = ALIGN(8);					\
-			 __start_syscalls_metadata = .;			\
-			 KEEP(*(__syscalls_metadata))			\
-			 __stop_syscalls_metadata = .;
+#define TRACE_SYSCALLS()			\
+	. = ALIGN(8);				\
+	BOUNDED_SECTION_BY(__syscalls_metadata, _syscalls_metadata)
 #else
 #define TRACE_SYSCALLS()
 #endif
 
 #ifdef CONFIG_BPF_EVENTS
-#define BPF_RAW_TP() STRUCT_ALIGN();					\
-			 __start__bpf_raw_tp = .;			\
-			 KEEP(*(__bpf_raw_tp_map))			\
-			 __stop__bpf_raw_tp = .;
+#define BPF_RAW_TP() STRUCT_ALIGN();				\
+	BOUNDED_SECTION_BY(__bpf_raw_tp_map, __bpf_raw_tp)
 #else
 #define BPF_RAW_TP()
 #endif
 
 #ifdef CONFIG_SERIAL_EARLYCON
-#define EARLYCON_TABLE() . = ALIGN(8);				\
-			 __earlycon_table = .;			\
-			 KEEP(*(__earlycon_table))		\
-			 __earlycon_table_end = .;
+#define EARLYCON_TABLE()						\
+	. = ALIGN(8);							\
+	BOUNDED_SECTION_POST_LABEL(__earlycon_table, __earlycon_table, , _end)
 #else
 #define EARLYCON_TABLE()
 #endif
 
 #ifdef CONFIG_SECURITY
-#define LSM_TABLE()	. = ALIGN(8);					\
-			__start_lsm_info = .;				\
-			KEEP(*(.lsm_info.init))				\
-			__end_lsm_info = .;
-#define EARLY_LSM_TABLE()	. = ALIGN(8);				\
-			__start_early_lsm_info = .;			\
-			KEEP(*(.early_lsm_info.init))			\
-			__end_early_lsm_info = .;
+#define LSM_TABLE()					\
+	. = ALIGN(8);					\
+	BOUNDED_SECTION_PRE_LABEL(.lsm_info.init, _lsm_info, __start, __end)
+
+#define EARLY_LSM_TABLE()						\
+	. = ALIGN(8);							\
+	BOUNDED_SECTION_PRE_LABEL(.early_lsm_info.init, _early_lsm_info, __start, __end)
 #else
 #define LSM_TABLE()
 #define EARLY_LSM_TABLE()
@@ -312,9 +311,8 @@
 #ifdef CONFIG_ACPI
 #define ACPI_PROBE_TABLE(name)						\
 	. = ALIGN(8);							\
-	__##name##_acpi_probe_table = .;				\
-	KEEP(*(__##name##_acpi_probe_table))				\
-	__##name##_acpi_probe_table_end = .;
+	BOUNDED_SECTION_POST_LABEL(__##name##_acpi_probe_table,		\
+				   __##name##_acpi_probe_table,, _end)
 #else
 #define ACPI_PROBE_TABLE(name)
 #endif
@@ -322,9 +320,8 @@
 #ifdef CONFIG_THERMAL
 #define THERMAL_TABLE(name)						\
 	. = ALIGN(8);							\
-	__##name##_thermal_table = .;					\
-	KEEP(*(__##name##_thermal_table))				\
-	__##name##_thermal_table_end = .;
+	BOUNDED_SECTION_POST_LABEL(__##name##_thermal_table,		\
+				   __##name##_thermal_table,, _end)
 #else
 #define THERMAL_TABLE(name)
 #endif
@@ -353,12 +350,8 @@
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);							\
-	__start___dyndbg_classes = .;					\
-	KEEP(*(__dyndbg_classes))					\
-	__stop___dyndbg_classes = .;					\
-	__start___dyndbg = .;						\
-	KEEP(*(__dyndbg))						\
-	__stop___dyndbg = .;						\
+	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
+	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)				\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
@@ -401,19 +394,13 @@
 
 #define JUMP_TABLE_DATA							\
 	. = ALIGN(8);							\
-	__start___jump_table = .;					\
-	KEEP(*(__jump_table))						\
-	__stop___jump_table = .;
+	BOUNDED_SECTION_BY(__jump_table, ___jump_table)
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 #define STATIC_CALL_DATA						\
 	. = ALIGN(8);							\
-	__start_static_call_sites = .;					\
-	KEEP(*(.static_call_sites))					\
-	__stop_static_call_sites = .;					\
-	__start_static_call_tramp_key = .;				\
-	KEEP(*(.static_call_tramp_key))					\
-	__stop_static_call_tramp_key = .;
+	BOUNDED_SECTION_BY(.static_call_sites, _static_call_sites)	\
+	BOUNDED_SECTION_BY(.static_call_tramp_key, _static_call_tramp_key)
 #else
 #define STATIC_CALL_DATA
 #endif
@@ -439,9 +426,7 @@
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
 #define KCFI_TRAPS							\
 	__kcfi_traps : AT(ADDR(__kcfi_traps) - LOAD_OFFSET) {		\
-		__start___kcfi_traps = .;				\
-		KEEP(*(.kcfi_traps))					\
-		__stop___kcfi_traps = .;				\
+		BOUNDED_SECTION_BY(.kcfi_traps, ___kcfi_traps)		\
 	}
 #else
 #define KCFI_TRAPS
@@ -459,9 +444,7 @@
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
-		__start___tracepoints_ptrs = .;				\
-		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
-		__stop___tracepoints_ptrs = .;				\
+		BOUNDED_SECTION_BY(__tracepoints_ptrs, ___tracepoints_ptrs) \
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
 	}								\
 									\
@@ -471,30 +454,14 @@
 									\
 	/* PCI quirks */						\
 	.pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {	\
-		__start_pci_fixups_early = .;				\
-		KEEP(*(.pci_fixup_early))				\
-		__end_pci_fixups_early = .;				\
-		__start_pci_fixups_header = .;				\
-		KEEP(*(.pci_fixup_header))				\
-		__end_pci_fixups_header = .;				\
-		__start_pci_fixups_final = .;				\
-		KEEP(*(.pci_fixup_final))				\
-		__end_pci_fixups_final = .;				\
-		__start_pci_fixups_enable = .;				\
-		KEEP(*(.pci_fixup_enable))				\
-		__end_pci_fixups_enable = .;				\
-		__start_pci_fixups_resume = .;				\
-		KEEP(*(.pci_fixup_resume))				\
-		__end_pci_fixups_resume = .;				\
-		__start_pci_fixups_resume_early = .;			\
-		KEEP(*(.pci_fixup_resume_early))			\
-		__end_pci_fixups_resume_early = .;			\
-		__start_pci_fixups_suspend = .;				\
-		KEEP(*(.pci_fixup_suspend))				\
-		__end_pci_fixups_suspend = .;				\
-		__start_pci_fixups_suspend_late = .;			\
-		KEEP(*(.pci_fixup_suspend_late))			\
-		__end_pci_fixups_suspend_late = .;			\
+		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_early,  _pci_fixups_early,  __start, __end) \
+		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_header, _pci_fixups_header, __start, __end) \
+		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_final,  _pci_fixups_final,  __start, __end) \
+		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_enable, _pci_fixups_enable, __start, __end) \
+		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_resume, _pci_fixups_resume, __start, __end) \
+		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_suspend, _pci_fixups_suspend, __start, __end) \
+		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_resume_early, _pci_fixups_resume_early, __start, __end) \
+		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_suspend_late, _pci_fixups_suspend_late, __start, __end) \
 	}								\
 									\
 	FW_LOADER_BUILT_IN_DATA						\
@@ -544,16 +511,12 @@
 									\
 	/* Built-in module parameters. */				\
 	__param : AT(ADDR(__param) - LOAD_OFFSET) {			\
-		__start___param = .;					\
-		KEEP(*(__param))					\
-		__stop___param = .;					\
+		BOUNDED_SECTION_BY(__param, ___param)			\
 	}								\
 									\
 	/* Built-in module versions. */					\
 	__modver : AT(ADDR(__modver) - LOAD_OFFSET) {			\
-		__start___modver = .;					\
-		KEEP(*(__modver))					\
-		__stop___modver = .;					\
+		BOUNDED_SECTION_BY(__modver, ___modver)			\
 	}								\
 									\
 	KCFI_TRAPS							\
@@ -663,9 +626,7 @@
 #define EXCEPTION_TABLE(align)						\
 	. = ALIGN(align);						\
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {		\
-		__start___ex_table = .;					\
-		KEEP(*(__ex_table))					\
-		__stop___ex_table = .;					\
+		BOUNDED_SECTION_BY(__ex_table, ___ex_table)		\
 	}
 
 /*
@@ -674,9 +635,7 @@
 #ifdef CONFIG_DEBUG_INFO_BTF
 #define BTF								\
 	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {				\
-		__start_BTF = .;					\
-		KEEP(*(.BTF))						\
-		__stop_BTF = .;						\
+		BOUNDED_SECTION_BY(.BTF, _BTF)				\
 	}								\
 	. = ALIGN(4);							\
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
@@ -853,9 +812,7 @@
 #define BUG_TABLE							\
 	. = ALIGN(8);							\
 	__bug_table : AT(ADDR(__bug_table) - LOAD_OFFSET) {		\
-		__start___bug_table = .;				\
-		KEEP(*(__bug_table))					\
-		__stop___bug_table = .;					\
+		BOUNDED_SECTION_BY(__bug_table, ___bug_table)		\
 	}
 #else
 #define BUG_TABLE
@@ -865,15 +822,11 @@
 #define ORC_UNWIND_TABLE						\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
-		__start_orc_unwind_ip = .;				\
-		KEEP(*(.orc_unwind_ip))					\
-		__stop_orc_unwind_ip = .;				\
+		BOUNDED_SECTION_BY(.orc_unwind_ip, _orc_unwind_ip)	\
 	}								\
 	. = ALIGN(2);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
-		__start_orc_unwind = .;					\
-		KEEP(*(.orc_unwind))					\
-		__stop_orc_unwind = .;					\
+		BOUNDED_SECTION_BY(.orc_unwind, _orc_unwind)		\
 	}								\
 	text_size = _etext - _stext;					\
 	. = ALIGN(4);							\
@@ -891,9 +844,7 @@
 #ifdef CONFIG_FW_LOADER
 #define FW_LOADER_BUILT_IN_DATA						\
 	.builtin_fw : AT(ADDR(.builtin_fw) - LOAD_OFFSET) ALIGN(8) {	\
-		__start_builtin_fw = .;					\
-		KEEP(*(.builtin_fw))					\
-		__end_builtin_fw = .;					\
+		BOUNDED_SECTION_PRE_LABEL(.builtin_fw, _builtin_fw, __start, __end) \
 	}
 #else
 #define FW_LOADER_BUILT_IN_DATA
@@ -903,9 +854,7 @@
 #define TRACEDATA							\
 	. = ALIGN(4);							\
 	.tracedata : AT(ADDR(.tracedata) - LOAD_OFFSET) {		\
-		__tracedata_start = .;					\
-		KEEP(*(.tracedata))					\
-		__tracedata_end = .;					\
+		BOUNDED_SECTION_POST_LABEL(.tracedata, __tracedata, _start, _end) \
 	}
 #else
 #define TRACEDATA
@@ -914,9 +863,7 @@
 #ifdef CONFIG_PRINTK_INDEX
 #define PRINTK_INDEX							\
 	.printk_index : AT(ADDR(.printk_index) - LOAD_OFFSET) {		\
-		__start_printk_index = .;				\
-		*(.printk_index)					\
-		__stop_printk_index = .;				\
+		BOUNDED_SECTION_BY(.printk_index, _printk_index)	\
 	}
 #else
 #define PRINTK_INDEX
@@ -924,17 +871,13 @@
 
 #define NOTES								\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
-		__start_notes = .;					\
-		KEEP(*(.note.*))					\
-		__stop_notes = .;					\
+		BOUNDED_SECTION_BY(.note.*, _notes)			\
 	} NOTES_HEADERS							\
 	NOTES_HEADERS_RESTORE
 
 #define INIT_SETUP(initsetup_align)					\
 		. = ALIGN(initsetup_align);				\
-		__setup_start = .;					\
-		KEEP(*(.init.setup))					\
-		__setup_end = .;
+		BOUNDED_SECTION_POST_LABEL(.init.setup, __setup, _start, _end)
 
 #define INIT_CALLS_LEVEL(level)						\
 		__initcall##level##_start = .;				\
@@ -956,16 +899,12 @@
 		__initcall_end = .;
 
 #define CON_INITCALL							\
-		__con_initcall_start = .;				\
-		KEEP(*(.con_initcall.init))				\
-		__con_initcall_end = .;
+	BOUNDED_SECTION_POST_LABEL(.con_initcall.init, __con_initcall, _start, _end)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
 		. = ALIGN(8);						\
-		__kunit_suites_start = .;				\
-		KEEP(*(.kunit_test_suites))				\
-		__kunit_suites_end = .;
+		BOUNDED_SECTION_POST_LABEL(.kunit_test_suites, __kunit_suites, _start, _end)
 
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
-- 
2.37.3

