Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043096C4F50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjCVPVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjCVPVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:21:00 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A848A5F205
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:20:51 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id j6so10044779ilr.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679498451; x=1682090451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LDbptPGFcQQzWvhEVmHUFWpjqD/zMKbil7z697tn1F8=;
        b=Ou7gjQDkru9VhL19tA2bjhfLWsSrWdzi8TBG3iH291dDEALpphtXdGqDvEDB+i11uG
         4Civd2e7uNglhjqDzgep4l/l9e1vclO3z5o43LwihxbJbFfpMKZtmwuEZE8SqHrqiWsK
         pdGLvyZ6yQ5jQmRNEuL3S3W7FHn30+yIGVUVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679498451; x=1682090451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDbptPGFcQQzWvhEVmHUFWpjqD/zMKbil7z697tn1F8=;
        b=QnaHTsesU/Zn1pVymxKN6ZLm3UJ+4BJrlq27vuqv5rYLwinhTyttA+yXMecCADcy4o
         NwPAyk4zgr8pwUNWY5WIMFmV0eGOcKz74sNdyg9TBmcsAVT3ZWP2vuHf239flQFfFgdo
         KIDcKYHfmMH+uPuAJ9YXO6/f1k24ij9R+yRIcMDlQU/nzrn6LR9Jnx8JYs9PCPIF86Wr
         ndnlnIc4UsstrZniBl195KR/mRbe26trjnER6tnindCyc7DYDdfK3IvEfpWzSXo1ura9
         rT47mJzJ1YfdZSl5/pUu//KI+YAGfWW4Kp2zomtWAxHHxkjRt4LRs3eyQAjJ9wOPacmc
         lACA==
X-Gm-Message-State: AO0yUKXVhFTDJRte0E+J6scGLY7FlSaW2CfVJcieiMl0VfLCHry2f1cc
        bfhK8xwrlByll0PjFf0xzUok0w==
X-Google-Smtp-Source: AK7set/74NyAgrVh7ZY2gwiK0Qttvf6dXUMyI11LjQ7BTMSp5D78LfPKGVyBeKRG7P5VsxVr1r6MBA==
X-Received: by 2002:a05:6e02:1d99:b0:319:5431:5d5b with SMTP id h25-20020a056e021d9900b0031954315d5bmr4774806ila.1.1679498450682;
        Wed, 22 Mar 2023 08:20:50 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n20-20020a02a194000000b004046f72271esm5215283jah.100.2023.03.22.08.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 08:20:50 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: add system-state document to admin-guide
Date:   Wed, 22 Mar 2023 09:20:49 -0600
Message-Id: <20230322152049.12723-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new system state document to the admin-guide. This document is
intended to be used as a guide on how to gather higher level information
about a system and its run-time activity.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v1:
-- Addressed review comments

 Documentation/admin-guide/index.rst        |   1 +
 Documentation/admin-guide/system-state.rst | 350 +++++++++++++++++++++
 2 files changed, 351 insertions(+)
 create mode 100644 Documentation/admin-guide/system-state.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index f475554382e2..541372672c55 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -66,6 +66,7 @@ subsystems expectations will be found here.
    :maxdepth: 1
 
    workload-tracing
+   system-state
 
 The rest of this manual consists of various unordered guides on how to
 configure specific aspects of kernel behavior to your liking.
diff --git a/Documentation/admin-guide/system-state.rst b/Documentation/admin-guide/system-state.rst
new file mode 100644
index 000000000000..2a6fdf85c35c
--- /dev/null
+++ b/Documentation/admin-guide/system-state.rst
@@ -0,0 +1,350 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
+
+===========================================================
+Discovering system calls and features supported on a system
+===========================================================
+
+:Author: Shuah Khan <skhan@linuxfoundation.org>
+:maintained-by: Shuah Khan <skhan@linuxfoundation.org>
+
+Key Points
+==========
+
+ * System state includes system calls, features, static and dynamic
+   modules enabled in the kernel configuration.
+ * Supported system calls and Kernel features are architecture dependent.
+ * auditd, checksyscalls.sh, and get_feat.pl tools can be used to discover
+   static system state.
+ * Understanding Linux kernel hardening configurations options and making
+   sure they are enabled will make a system more secure.
+ * Employing run-time tracing can shed light on the dynamic system state.
+ * Workloads could change the system state by loading and unloading dynamic
+   modules and tuning system parameters.
+
+System State Visualization
+==========================
+
+The kernel system state can be viewed as a combination of static and
+dynamic features and modules. Let’s first define what static and dynamic
+system states are and then explore how we can visualize the static and
+dynamic system parts of the kernel.
+
+Static System View comprises system calls, features, static and dynamic
+modules enabled in the kernel configuration. Supported system calls
+and Kernel features are architecture dependent. System call numbering is
+different on different architectures. We can get the supported system call
+information using auditd utilities.
+
+ausyscall –dump prints out the supported system calls on a system and allows
+mapping syscall names and numbers. You can install the auditd package on
+Debian based systems::
+
+  sudo apt-get install auditd
+
+scripts/checksyscalls.sh can be used to check if current architecture is
+missing any system calls compared to i386.
+
+scripts/get_feat.pl can be used to list the Kernel feature support matrix
+for an architecture.
+
+Dynamic System View comprises system calls, ioctls invoked, and subsystems
+used during the runtime. A workload could load and unload modules and also
+change the dynamic system configuration to suit its needs by tuning system
+parameters.
+
+What is the methodology?
+========================
+
+The first step is gathering the default system state such as the dynamic
+and static modules loaded on the system. lsmod command prints out the
+dynamically loaded modules on a system. Statically configured modules can
+be found in the kernel configuration file.
+
+The next step is discovering system activity during run-time. You can do so
+by enabling event tracing and then running your favorite application. After
+a period of time, gather the event logs, and kernel messages.
+
+Once you have the necessary information, you can extract the system call
+numbers from the event trace log and map them to the supported system calls.
+
+Finding supported system calls
+==============================
+
+As mentioned earlier, ausyscall prints out supported system calls
+on a system and allows mapping syscalls names and numbers::
+
+ ausyscall --dump
+
+You can look for specific system calls as shown in the below::
+
+  ausyscall open
+    open               2
+    mq_open            240
+    openat             257
+    perf_event_open    298
+    open_by_handle_at  304
+    open_tree          428
+    fsopen             430
+    pidfd_open         434
+    openat2            437
+
+  ausyscall time
+
+    getitimer          36
+    setitimer          38
+    gettimeofday       96
+    times              100
+    rt_sigtimedwait    128
+    utime              132
+    adjtimex           159
+    settimeofday       164
+    time               201
+    semtimedop         220
+    timer_create       222
+    timer_settime      223
+    timer_gettime      224
+    timer_getoverrun   225
+    timer_delete       226
+    clock_settime      227
+    clock_gettime      228
+    utimes             235
+    mq_timedsend       242
+    mq_timedreceive    243
+    futimesat          261
+    utimensat          280
+    timerfd_create     283
+    timerfd_settime    286
+    timerfd_gettime    287
+    clock_adjtime      305
+
+Finding unsupported system calls
+================================
+
+As mentioned earlier, scripts/checksyscalls.sh checks missing system calls
+on current architecture compared to i386. Example run::
+
+  checksyscalls.sh gcc
+    warning: #warning syscall mmap2 not implemented [-Wcpp]
+    warning: #warning syscall truncate64 not implemented [-Wcpp]
+    warning: #warning syscall ftruncate64 not implemented [-Wcpp]
+    warning: #warning syscall fcntl64 not implemented [-Wcpp]
+    warning: #warning syscall sendfile64 not implemented [-Wcpp]
+    warning: #warning syscall statfs64 not implemented [-Wcpp]
+    warning: #warning syscall fstatfs64 not implemented [-Wcpp]
+    warning: #warning syscall fadvise64_64 not implemented [-Wcpp]
+
+Let's check this against ausyscall now::
+
+  ausyscall map
+    mmap               9
+    munmap             11
+    mremap             25
+    remap_file_pages   216
+
+  ausyscall trunc
+    truncate           76
+    ftruncate          77
+
+As you can see, ausyscall shows mmap2, truncate64, and ftruncate64 aren't
+implemented on this system. This matches what checksyscalls.sh shows.
+
+Finding supported features
+==========================
+
+scripts/get_feat.pl can be used to list the Kernel feature support matrix
+for an architecture::
+
+ get_feat.pl list
+ get_feat.pl list –arch=arm64 lists
+
+This scripts parses Documentation/features to find the support status
+information. It can be used to validate the contents of the files under
+Documentation/features or simply list them::
+
+  --arch Outputs features for an specific architecture, optionally filtering
+         for a single specific feature.
+  --feat or --feature Output features for a single specific feature.
+
+Here is how you can find if stackprotector and hread-info-in-task features
+are supported::
+
+  scripts/get_feat.pl --arch=arm64 --feat=stackprotector list
+    #
+    # Kernel feature support matrix of the 'arm64' architecture:
+    #
+    debug/ stackprotector       :  ok  |            HAVE_STACKPROTECTOR #
+    arch supports compiler driven stack overflow protection
+
+  scripts/get_feat.pl --feat=thread-info-in-task list
+    #
+    # Kernel feature support matrix of the 'x86' architecture:
+    #
+      core/ thread-info-in-task  :  ok  |           THREAD_INFO_IN_TASK #
+      arch makes use of the core kernel facility to embed thread_info in
+      task_struct
+
+Finding kernel module status
+============================
+
+lsmod command shows the kernel modules that are currently loaded. This
+program displays the contents of /proc/modules. Let's pick uvcvideo
+module which is found on most laptops::
+
+  lsmod | grep uvc
+  uvcvideo              126976  0
+  videobuf2_vmalloc      20480  1 uvcvideo
+  uvc                    16384  1 uvcvideo
+  videobuf2_v4l2         36864  1 uvcvideo
+  videodev              315392  2 videobuf2_v4l2,uvcvideo
+  videobuf2_common       65536  4 videobuf2_vmalloc,videobuf2_v4l2,uvcvideo,videobuf2_memops
+  mc                     77824  4 videodev,videobuf2_v4l2,uvcvideo,videobuf2_common
+
+You can see that lsmod shows uvcvideo and the modules it depends on and how
+many modules are using them. videobuf2_common is in use by 4 other modules.
+In other words, this is the reference count for this module and rmmod will
+refuse to unload it as long as the reference count is > 0.
+
+You can get the same information from /proc.modules::
+
+  less /proc/modules | grep uvc
+  uvcvideo 126976 0 - Live 0x0000000000000000
+  videobuf2_vmalloc 20480 1 uvcvideo, Live 0x0000000000000000
+  uvc 16384 1 uvcvideo, Live 0x0000000000000000
+  videobuf2_v4l2 36864 1 uvcvideo, Live 0x0000000000000000
+  videodev 315392 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
+  videobuf2_common 65536 4 uvcvideo,videobuf2_vmalloc,videobuf2_memops,videobuf2_v4l2, Live 0x0000000000000000
+  mc 77824 4 uvcvideo,videobuf2_v4l2,videodev,videobuf2_common, Live 0x0000000000000000
+
+The information is similar with a few more extra fields. The address is the
+base address for the module in kernel virtual memory space. When run as a
+normal user, the address is all zeros. The same command when run as root will
+be as follows::
+
+  sudo less /proc/modules | grep uvc
+  uvcvideo 126976 0 - Live 0xffffffffc1c8b000
+  videobuf2_vmalloc 20480 1 uvcvideo, Live 0xffffffffc167f000
+  uvc 16384 1 uvcvideo, Live 0xffffffffc0ab0000
+  videobuf2_v4l2 36864 1 uvcvideo, Live 0xffffffffc0a28000
+  videodev 315392 2 uvcvideo,videobuf2_v4l2, Live 0xffffffffc16e9000
+  videobuf2_common 65536 4 uvcvideo,videobuf2_vmalloc,videobuf2_memops,videobuf2_v4l2, Live 0xffffffffc094d000
+  mc 77824 4 uvcvideo,videobuf2_v4l2,videodev,videobuf2_common, Live 0xffffffffc15eb000
+
+Let's check what modinfo shows that is important for us::
+
+  /sbin/modinfo uvcvideo
+  filename:       /lib/modules/6.3.0-rc2/kernel/drivers/media/usb/uvc/uvcvideo.ko
+  license:        GPL
+  description:    USB Video Class driver
+  depends:        videobuf2-v4l2,videodev,mc,uvc,videobuf2-common,videobuf2-vmalloc
+  retpoline:      Y
+  intree:         Y
+  name:           uvcvideo
+  vermagic:       6.3.0-rc2 SMP preempt mod_unload modversions
+  sig_id:         PKCS#7
+  signer:         Build time autogenerated kernel key
+
+This tells us that this module is built intree and the signed with a build
+time autogenerated key.
+
+Let's do one last sanity check on the system to see if the following two
+command outputs match::
+
+  ps ax | wc -l
+  ls -d /proc/* | grep [0-9]|wc -l
+
+If they don't match, examine your system closely. kernel rootkits install
+their own ps, find, etc. utilities to mask their activity. The outputs
+match on my system. Do they on yours?
+
+Is my system as secure as it could be?
+======================================
+
+Linux kernel supports several hardening options to make system secure.
+kconfig-hardened-check tool sanity checks kernel configuration for
+security. You can clone the latest kconfig-hardened-check repository::
+
+  git clone https://github.com/a13xp0p0v/kconfig-hardened-check.git
+  cd kconfig-hardened-check
+  bin/kconfig-hardened-check --config <config file> --cmdline /proc/cmdline
+
+This will generate detailed report of kernel security configuration and
+command line options that are enabled (OK) and the ones that aren't (FAIL)
+and a summary line at the end::
+
+  [+] Config check is finished: 'OK' - 100 / 'FAIL' - 100
+
+You will have to analyze the information to determine which options make
+sense to enable on your system.
+
+Understanding system run-time activity
+======================================
+
+Enabling event tracing gives insight into system run-time activity. This is
+a good way to identify which parts of the kernel are used at a higher level
+while system is in and/or while a specific workload/process is running.
+
+Event tracing depends on the CONFIG_EVENT_TRACING option enabled. You can
+enable event tracing before starting workload/process. Event tracing allows
+you to dynamically enable and disable tracing on supported/available events.
+You can find available events, tracers, and filter functions in the following
+files::
+
+  /sys/kernel/debug/tracing/available_events
+  /sys/kernel/debug/tracing/available_filter_functions
+  /sys/kernel/debug/tracing/available_tracers
+
+Now this is how you can enable tracing::
+
+  sudo echo 1 > /sys/kernel/debug/tracing/events/enable
+
+Once the workload/process stops or when you decide you have the status you
+need, you can disable event tracing::
+
+  sudo echo 0 > /sys/kernel/debug/tracing/events/enable
+
+You can find the tracing information in the file::
+
+  /sys/kernel/debug/tracing
+
+Here is the information shown in this file::
+
+  cat trace
+  # tracer: nop
+  #
+  # entries-in-buffer/entries-written: 0/0   #P:16
+  #
+  #                                _-----=> irqs-off/BH-disabled
+  #                               / _----=> need-resched
+  #                              | / _---=> hardirq/softirq
+  #                              || / _--=> preempt-depth
+  #                              ||| / _-=> migrate-disable
+  #                              |||| /     delay
+  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+  #              | |         |   |||||     |         |
+
+
+Analyzing traces
+================
+
+You will be able map the functions to system calls and other kernel features
+to get insight into the overall system activity while a workload/process is
+running.
+
+Map the NR (syscal) numbers from the trace to syscalls from the syscalls dump.
+Categorize system calls and map them to Linux subsystems.
+
+Conclusion
+==========
+
+This document is intended to be used as a guide on how to gather higher level
+information about a system and its run-time activity. The approach described
+in this document helps us get insight into supported system calls, features,
+assess how secure a system is, and its run-time activity.
+
+References
+==========
+
+ * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/checksyscalls.sh
+ * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/get_feat.pl
+ * https://github.com/a13xp0p0v/kconfig-hardened-check
+ * https://docs.kernel.org/trace/index.html
-- 
2.34.1

