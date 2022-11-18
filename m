Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD3962F0D7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbiKRJRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241860AbiKRJQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:16:51 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59A362C67F;
        Fri, 18 Nov 2022 01:16:47 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Axjrd9TXdjhpIIAA--.19369S3;
        Fri, 18 Nov 2022 17:16:45 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHuJ4TXdj1nAWAA--.59179S2;
        Fri, 18 Nov 2022 17:16:40 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH] tools: perf: Use "grep -E" instead of "egrep"
Date:   Fri, 18 Nov 2022 17:16:39 +0800
Message-Id: <1668762999-9297-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8BxHuJ4TXdj1nAWAA--.59179S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoWDCr47Ary8CF1fuFW3KF17ZFb_yoWrAw18Wo
        Z2gFsIyw4vkryfXa4DGFWIq34xJws8C343XaykW3sYyF47JrW5Aw1Yka4xX3W3ZrW8t3s5
        Ga1ftFy5Gw4xG34xn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2
        z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I
        0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCI
        bckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
        0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version of grep claims the egrep is now obsolete so the build
now contains warnings that look like:
	egrep: warning: egrep is obsolescent; using grep -E
fix this up by moving the related file to use "grep -E" instead.

  sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/perf`

Here are the steps to install the latest grep:

  wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
  tar xf grep-3.8.tar.gz
  cd grep-3.8 && ./configure && make
  sudo make install
  export PATH=/usr/local/bin:$PATH

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/Makefile                                |  2 +-
 tools/perf/builtin-trace.c                         |  2 +-
 tools/perf/tests/make                              |  2 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |  4 ++--
 .../tests/shell/record+probe_libc_inet_pton.sh     |  2 +-
 .../tests/shell/record+script_probe_vfs_getname.sh |  2 +-
 tools/perf/tests/shell/record.sh                   |  8 ++++----
 tools/perf/tests/shell/record_offcpu.sh            |  2 +-
 tools/perf/tests/shell/stat.sh                     | 10 +++++-----
 tools/perf/tests/shell/test_arm_coresight.sh       |  8 ++++----
 tools/perf/tests/shell/test_arm_spe.sh             |  6 +++---
 tools/perf/tests/shell/test_arm_spe_fork.sh        |  2 +-
 tools/perf/tests/shell/test_brstack.sh             | 18 +++++++++---------
 tools/perf/tests/shell/test_data_symbol.sh         |  4 ++--
 tools/perf/tests/shell/test_java_symbol.sh         |  2 +-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |  4 ++--
 tools/perf/trace/beauty/fadvise.sh                 |  2 +-
 tools/perf/trace/beauty/fsmount.sh                 |  2 +-
 tools/perf/trace/beauty/fspick.sh                  |  2 +-
 tools/perf/trace/beauty/kcmp_type.sh               |  2 +-
 tools/perf/trace/beauty/kvm_ioctl.sh               |  4 ++--
 tools/perf/trace/beauty/madvise_behavior.sh        |  2 +-
 tools/perf/trace/beauty/mmap_flags.sh              | 22 +++++++++++-----------
 tools/perf/trace/beauty/mmap_prot.sh               | 12 ++++++------
 tools/perf/trace/beauty/mount_flags.sh             |  4 ++--
 tools/perf/trace/beauty/move_mount_flags.sh        |  2 +-
 tools/perf/trace/beauty/mremap_flags.sh            |  4 ++--
 tools/perf/trace/beauty/perf_ioctl.sh              |  2 +-
 .../perf/trace/beauty/pkey_alloc_access_rights.sh  |  2 +-
 tools/perf/trace/beauty/prctl_option.sh            |  4 ++--
 tools/perf/trace/beauty/rename_flags.sh            |  4 ++--
 tools/perf/trace/beauty/sockaddr.sh                |  4 ++--
 tools/perf/trace/beauty/socket.sh                  |  4 ++--
 tools/perf/trace/beauty/sync_file_range.sh         |  2 +-
 .../trace/beauty/tracepoints/x86_irq_vectors.sh    |  4 ++--
 tools/perf/trace/beauty/tracepoints/x86_msr.sh     | 12 ++++++------
 tools/perf/trace/beauty/usbdevfs_ioctl.sh          |  4 ++--
 tools/perf/trace/beauty/vhost_virtio_ioctl.sh      |  4 ++--
 tools/perf/trace/beauty/x86_arch_prctl.sh          |  4 ++--
 39 files changed, 93 insertions(+), 93 deletions(-)

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index f3fe360..75f3f6e 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -25,7 +25,7 @@ unexport MAKEFLAGS
 # (To override it, run 'make JOBS=1' and similar.)
 #
 ifeq ($(JOBS),)
-  JOBS := $(shell (getconf _NPROCESSORS_ONLN || egrep -c '^processor|^CPU[0-9]' /proc/cpuinfo) 2>/dev/null)
+  JOBS := $(shell (getconf _NPROCESSORS_ONLN || grep -E -c '^processor|^CPU[0-9]' /proc/cpuinfo) 2>/dev/null)
   ifeq ($(JOBS),0)
     JOBS := 1
   endif
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d3c7577..7969c66 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1730,7 +1730,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			 len >= 2 && strcmp(field->name + len - 2, "fd") == 0) {
 			/*
 			 * /sys/kernel/tracing/events/syscalls/sys_enter*
-			 * egrep 'field:.*fd;' .../format|sed -r 's/.*field:([a-z ]+) [a-z_]*fd.+/\1/g'|sort|uniq -c
+			 * grep -E 'field:.*fd;' .../format|sed -r 's/.*field:([a-z ]+) [a-z_]*fd.+/\1/g'|sort|uniq -c
 			 * 65 int
 			 * 23 unsigned int
 			 * 7 unsigned long
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index da013e9..05e818a 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -29,7 +29,7 @@ endif
 PARALLEL_OPT=
 ifeq ($(SET_PARALLEL),1)
   ifeq ($(JOBS),)
-    cores := $(shell (getconf _NPROCESSORS_ONLN || egrep -c '^processor|^CPU[0-9]' /proc/cpuinfo) 2>/dev/null)
+    cores := $(shell (getconf _NPROCESSORS_ONLN || grep -E -c '^processor|^CPU[0-9]' /proc/cpuinfo) 2>/dev/null)
     ifeq ($(cores),0)
       cores := 1
     endif
diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index b616d42..ed0a397 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -12,13 +12,13 @@ cleanup_probe_vfs_getname() {
 add_probe_vfs_getname() {
 	local verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
-		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
+		line=$(perf probe -L getname_flags 2>&1 | grep -E 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
 		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
 		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
 	fi
 }
 
 skip_if_no_debuginfo() {
-	add_probe_vfs_getname -v 2>&1 | egrep -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
+	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
 	return 1
 }
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index f12a4e2..34c400c 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -64,7 +64,7 @@ trace_libc_inet_pton_backtrace() {
 	while read line <&3 && read -r pattern <&4; do
 		[ -z "$pattern" ] && break
 		echo $line
-		echo "$line" | egrep -q "$pattern"
+		echo "$line" | grep -E -q "$pattern"
 		if [ $? -ne 0 ] ; then
 			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" "$line"
 			return 1
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 8d9c04e..7f83b27 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -23,7 +23,7 @@ record_open_file() {
 perf_script_filenames() {
 	echo "Looking at perf.data file for vfs_getname records for the file we touched:"
 	perf script -i ${perfdata} | \
-	egrep " +touch +[0-9]+ +\[[0-9]+\] +[0-9]+\.[0-9]+: +probe:vfs_getname[_0-9]*: +\([[:xdigit:]]+\) +pathname=\"${file}\""
+	grep -E " +touch +[0-9]+ +\[[0-9]+\] +[0-9]+\.[0-9]+: +probe:vfs_getname[_0-9]*: +\([[:xdigit:]]+\) +pathname=\"${file}\""
 }
 
 add_probe_vfs_getname || skip_if_no_debuginfo
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 301f954..2ad2d28 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -36,7 +36,7 @@ test_per_thread() {
     err=1
     return
   fi
-  if ! perf report -i ${perfdata} -q | egrep -q true
+  if ! perf report -i ${perfdata} -q | grep -E -q true
   then
     echo "Per-thread record [Failed missing output]"
     err=1
@@ -47,7 +47,7 @@ test_per_thread() {
 
 test_register_capture() {
   echo "Register capture test"
-  if ! perf list | egrep -q 'br_inst_retired.near_call'
+  if ! perf list | grep -E -q 'br_inst_retired.near_call'
   then
     echo "Register capture test [Skipped missing instruction]"
     if [ $err -ne 1 ]
@@ -56,7 +56,7 @@ test_register_capture() {
     fi
     return
   fi
-  if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
+  if ! perf record --intr-regs=\? 2>&1 | grep -E -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
   then
     echo "Register capture test [Skipped missing registers]"
     return
@@ -64,7 +64,7 @@ test_register_capture() {
   if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
     -c 1000 --per-thread true 2> /dev/null \
     | perf script -F ip,sym,iregs -i - 2> /dev/null \
-    | egrep -q "DI:"
+    | grep -E -q "DI:"
   then
     echo "Register capture test [Failed missing output]"
     err=1
diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index d2eba58..e01973d 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -51,7 +51,7 @@ test_offcpu_basic() {
     err=1
     return
   fi
-  if ! perf report -i ${perfdata} -q --percent-limit=90 | egrep -q sleep
+  if ! perf report -i ${perfdata} -q --percent-limit=90 | grep -E -q sleep
   then
     echo "Basic off-cpu test [Failed missing output]"
     err=1
diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 26a51b4..2c1d3f7 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -7,7 +7,7 @@ set -e
 err=0
 test_default_stat() {
   echo "Basic stat command test"
-  if ! perf stat true 2>&1 | egrep -q "Performance counter stats for 'true':"
+  if ! perf stat true 2>&1 | grep -E -q "Performance counter stats for 'true':"
   then
     echo "Basic stat command test [Failed]"
     err=1
@@ -19,7 +19,7 @@ test_default_stat() {
 test_stat_record_report() {
   echo "stat record and report test"
   if ! perf stat record -o - true | perf stat report -i - 2>&1 | \
-    egrep -q "Performance counter stats for 'pipe':"
+    grep -E -q "Performance counter stats for 'pipe':"
   then
     echo "stat record and report test [Failed]"
     err=1
@@ -55,13 +55,13 @@ test_topdown_groups() {
     echo "Topdown event group test [Skipped event parsing failed]"
     return
   fi
-  if perf stat -e '{slots,topdown-retiring}' true 2>&1 | egrep -q "<not supported>"
+  if perf stat -e '{slots,topdown-retiring}' true 2>&1 | grep -E -q "<not supported>"
   then
     echo "Topdown event group test [Failed events not supported]"
     err=1
     return
   fi
-  if perf stat -e '{topdown-retiring,slots}' true 2>&1 | egrep -q "<not supported>"
+  if perf stat -e '{topdown-retiring,slots}' true 2>&1 | grep -E -q "<not supported>"
   then
     echo "Topdown event group test [Failed slots not reordered first]"
     err=1
@@ -82,7 +82,7 @@ test_topdown_weak_groups() {
     return
   fi
   group_needs_break="{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,cache-misses,cache-references}:W"
-  if perf stat --no-merge -e "$group_needs_break" true 2>&1 | egrep -q "<not supported>"
+  if perf stat --no-merge -e "$group_needs_break" true 2>&1 | grep -E -q "<not supported>"
   then
     echo "Topdown weak groups test [Failed events not supported]"
     err=1
diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index daad786..565ce52 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -49,7 +49,7 @@ perf_script_branch_samples() {
 	#   touch  6512          1         branches:u:      ffffb22082e0 strcmp+0xa0 (/lib/aarch64-linux-gnu/ld-2.27.so)
 	#   touch  6512          1         branches:u:      ffffb2208320 strcmp+0xe0 (/lib/aarch64-linux-gnu/ld-2.27.so)
 	perf script -F,-time -i ${perfdata} 2>&1 | \
-		egrep " +$1 +[0-9]+ .* +branches:(.*:)? +" > /dev/null 2>&1
+		grep -E " +$1 +[0-9]+ .* +branches:(.*:)? +" > /dev/null 2>&1
 }
 
 perf_report_branch_samples() {
@@ -60,7 +60,7 @@ perf_report_branch_samples() {
 	#    7.71%     7.71%  touch    libc-2.27.so      [.] getenv
 	#    2.59%     2.59%  touch    ld-2.27.so        [.] strcmp
 	perf report --stdio -i ${perfdata} 2>&1 | \
-		egrep " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 " > /dev/null 2>&1
+		grep -E " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 " > /dev/null 2>&1
 }
 
 perf_report_instruction_samples() {
@@ -71,7 +71,7 @@ perf_report_instruction_samples() {
 	#    5.80%  touch    libc-2.27.so   [.] getenv
 	#    4.35%  touch    ld-2.27.so     [.] _dl_fixup
 	perf report --itrace=i20i --stdio -i ${perfdata} 2>&1 | \
-		egrep " +[0-9]+\.[0-9]+% +$1" > /dev/null 2>&1
+		grep -E " +[0-9]+\.[0-9]+% +$1" > /dev/null 2>&1
 }
 
 arm_cs_report() {
@@ -87,7 +87,7 @@ is_device_sink() {
 	# If the node of "enable_sink" is existed under the device path, this
 	# means the device is a sink device.  Need to exclude 'tpiu' since it
 	# cannot support perf PMU.
-	echo "$1" | egrep -q -v "tpiu"
+	echo "$1" | grep -E -q -v "tpiu"
 
 	if [ $? -eq 0 -a -e "$1/enable_sink" ]; then
 
diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
index 0d47479..aa094d7 100755
--- a/tools/perf/tests/shell/test_arm_spe.sh
+++ b/tools/perf/tests/shell/test_arm_spe.sh
@@ -9,7 +9,7 @@
 # German Gomez <german.gomez@arm.com>, 2021
 
 skip_if_no_arm_spe_event() {
-	perf list | egrep -q 'arm_spe_[0-9]+//' && return 0
+	perf list | grep -E -q 'arm_spe_[0-9]+//' && return 0
 
 	# arm_spe event doesn't exist
 	return 2
@@ -51,7 +51,7 @@ perf_script_samples() {
 	#	dd  3048 [002]          1    tlb-access:      ffffaa64999c __GI___libc_write+0x3c (/lib/aarch64-linux-gnu/libc-2.27.so)
 	#	dd  3048 [002]          1        memory:      ffffaa64999c __GI___libc_write+0x3c (/lib/aarch64-linux-gnu/libc-2.27.so)
 	perf script -F,-time -i ${perfdata} 2>&1 | \
-		egrep " +$1 +[0-9]+ .* +${events}:(.*:)? +" > /dev/null 2>&1
+		grep -E " +$1 +[0-9]+ .* +${events}:(.*:)? +" > /dev/null 2>&1
 }
 
 perf_report_samples() {
@@ -62,7 +62,7 @@ perf_report_samples() {
 	#    7.71%     7.71%  dd    libc-2.27.so      [.] getenv
 	#    2.59%     2.59%  dd    ld-2.27.so        [.] strcmp
 	perf report --stdio -i ${perfdata} 2>&1 | \
-		egrep " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 " > /dev/null 2>&1
+		grep -E " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 " > /dev/null 2>&1
 }
 
 arm_spe_snapshot_test() {
diff --git a/tools/perf/tests/shell/test_arm_spe_fork.sh b/tools/perf/tests/shell/test_arm_spe_fork.sh
index c920d35..7528782 100755
--- a/tools/perf/tests/shell/test_arm_spe_fork.sh
+++ b/tools/perf/tests/shell/test_arm_spe_fork.sh
@@ -5,7 +5,7 @@
 # German Gomez <german.gomez@arm.com>, 2022
 
 skip_if_no_arm_spe_event() {
-	perf list | egrep -q 'arm_spe_[0-9]+//' && return 0
+	perf list | grep -E -q 'arm_spe_[0-9]+//' && return 0
 	return 2
 }
 
diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index d7ff5c4..74117dd 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -69,14 +69,14 @@ test_user_branches() {
 	# 	foo+0x14/bar+0x40/P/-/-/0/CALL
 
 	set -x
-	egrep -m1 "^bench\+[^ ]*/foo\+[^ ]*/IND_CALL$"	$TMPDIR/perf.script
-	egrep -m1 "^foo\+[^ ]*/bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
-	egrep -m1 "^bench\+[^ ]*/foo\+[^ ]*/CALL$"	$TMPDIR/perf.script
-	egrep -m1 "^bench\+[^ ]*/bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
-	egrep -m1 "^bar\+[^ ]*/foo\+[^ ]*/RET$"		$TMPDIR/perf.script
-	egrep -m1 "^foo\+[^ ]*/bench\+[^ ]*/RET$"	$TMPDIR/perf.script
-	egrep -m1 "^bench\+[^ ]*/bench\+[^ ]*/COND$"	$TMPDIR/perf.script
-	egrep -m1 "^main\+[^ ]*/main\+[^ ]*/UNCOND$"	$TMPDIR/perf.script
+	grep -E -m1 "^bench\+[^ ]*/foo\+[^ ]*/IND_CALL$"	$TMPDIR/perf.script
+	grep -E -m1 "^foo\+[^ ]*/bar\+[^ ]*/CALL$"		$TMPDIR/perf.script
+	grep -E -m1 "^bench\+[^ ]*/foo\+[^ ]*/CALL$"		$TMPDIR/perf.script
+	grep -E -m1 "^bench\+[^ ]*/bar\+[^ ]*/CALL$"		$TMPDIR/perf.script
+	grep -E -m1 "^bar\+[^ ]*/foo\+[^ ]*/RET$"		$TMPDIR/perf.script
+	grep -E -m1 "^foo\+[^ ]*/bench\+[^ ]*/RET$"		$TMPDIR/perf.script
+	grep -E -m1 "^bench\+[^ ]*/bench\+[^ ]*/COND$"		$TMPDIR/perf.script
+	grep -E -m1 "^main\+[^ ]*/main\+[^ ]*/UNCOND$"		$TMPDIR/perf.script
 	set +x
 
 	# some branch types are still not being tested:
@@ -99,7 +99,7 @@ test_filter() {
 
 	# fail if we find any branch type that doesn't match any of the expected ones
 	# also consider UNKNOWN branch types (-)
-	if egrep -vm1 "^[^ ]*/($expect|-|( *))$" $TMPDIR/perf.script; then
+	if grep -E -vm1 "^[^ ]*/($expect|-|( *))$" $TMPDIR/perf.script; then
 		return 1
 	fi
 }
diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index cd6eb54..e6a60b9 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -5,7 +5,7 @@
 # Leo Yan <leo.yan@linaro.org>, 2022
 
 skip_if_no_mem_event() {
-	perf mem record -e list 2>&1 | egrep -q 'available' && return 0
+	perf mem record -e list 2>&1 | grep -E -q 'available' && return 0
 	return 2
 }
 
@@ -75,7 +75,7 @@ echo "Recording workload..."
 # perf mem/c2c internally uses IBS PMU on AMD CPU which doesn't support
 # user/kernel filtering and per-process monitoring, spin program on
 # specific CPU and test in per-CPU mode.
-is_amd=$(egrep -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
+is_amd=$(grep -E -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
 if (($is_amd >= 1)); then
 	perf mem record -o ${PERF_DATA} -C 0 -- taskset -c 0 $TEST_PROGRAM &
 else
diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
index f221225..90cea88 100755
--- a/tools/perf/tests/shell/test_java_symbol.sh
+++ b/tools/perf/tests/shell/test_java_symbol.sh
@@ -65,7 +65,7 @@ fi
 #   8.18%  jshell           jitted-50116-29.so    [.] Interpreter
 #   0.75%  Thread-1         jitted-83602-1670.so  [.] jdk.internal.jimage.BasicImageReader.getString(int)
 perf report --stdio -i ${PERF_INJ_DATA} 2>&1 | \
-	egrep " +[0-9]+\.[0-9]+% .* (Interpreter|jdk\.internal).*" > /dev/null 2>&1
+	grep -E " +[0-9]+\.[0-9]+% .* (Interpreter|jdk\.internal).*" > /dev/null 2>&1
 
 if [ $? -ne 0 ]; then
 	echo "Fail to find java symbols"
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 3d60e99..0a4bac3 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -18,9 +18,9 @@ skip_if_no_perf_trace || exit 2
 . $(dirname $0)/lib/probe_vfs_getname.sh
 
 trace_open_vfs_getname() {
-	evts=$(echo $(perf list syscalls:sys_enter_open* 2>/dev/null | egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
+	evts=$(echo $(perf list syscalls:sys_enter_open* 2>/dev/null | grep -E 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
 	perf trace -e $evts touch $file 2>&1 | \
-	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
+	grep -E " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
 
 
diff --git a/tools/perf/trace/beauty/fadvise.sh b/tools/perf/trace/beauty/fadvise.sh
index b15ae38..4d3dd6e 100755
--- a/tools/perf/trace/beauty/fadvise.sh
+++ b/tools/perf/trace/beauty/fadvise.sh
@@ -6,7 +6,7 @@
 printf "static const char *fadvise_advices[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+POSIX_FADV_(\w+)[[:space:]]+([[:digit:]]+)[[:space:]]+.*'
 
-egrep $regex ${header_dir}/fadvise.h | \
+grep -E $regex ${header_dir}/fadvise.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort | xargs printf "\t[%s] = \"%s\",\n" | \
 	grep -v "[6].*DONTNEED" | grep -v "[7].*NOREUSE"
diff --git a/tools/perf/trace/beauty/fsmount.sh b/tools/perf/trace/beauty/fsmount.sh
index 615cc0f..cba8897 100755
--- a/tools/perf/trace/beauty/fsmount.sh
+++ b/tools/perf/trace/beauty/fsmount.sh
@@ -16,7 +16,7 @@ linux_mount=${linux_header_dir}/mount.h
 
 printf "static const char *fsmount_attr_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MOUNT_ATTR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
-egrep $regex ${linux_mount} | grep -v MOUNT_ATTR_RELATIME | \
+grep -E $regex ${linux_mount} | grep -v MOUNT_ATTR_RELATIME | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/fspick.sh b/tools/perf/trace/beauty/fspick.sh
index b220e07..1f08832 100755
--- a/tools/perf/trace/beauty/fspick.sh
+++ b/tools/perf/trace/beauty/fspick.sh
@@ -11,7 +11,7 @@ linux_mount=${linux_header_dir}/mount.h
 
 printf "static const char *fspick_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+FSPICK_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
-egrep $regex ${linux_mount} | \
+grep -E $regex ${linux_mount} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/kcmp_type.sh b/tools/perf/trace/beauty/kcmp_type.sh
index df8b174..5df9dcb 100755
--- a/tools/perf/trace/beauty/kcmp_type.sh
+++ b/tools/perf/trace/beauty/kcmp_type.sh
@@ -5,7 +5,7 @@
 
 printf "static const char *kcmp_types[] = {\n"
 regex='^[[:space:]]+(KCMP_(\w+)),'
-egrep $regex ${header_dir}/kcmp.h | grep -v KCMP_TYPES, | \
+grep -E $regex ${header_dir}/kcmp.h | grep -v KCMP_TYPES, | \
 	sed -r "s/$regex/\1 \2/g" | \
 	xargs printf "\t[%s]\t= \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/kvm_ioctl.sh b/tools/perf/trace/beauty/kvm_ioctl.sh
index 4ce54f5..bd0efd4 100755
--- a/tools/perf/trace/beauty/kvm_ioctl.sh
+++ b/tools/perf/trace/beauty/kvm_ioctl.sh
@@ -5,8 +5,8 @@
 
 printf "static const char *kvm_ioctl_cmds[] = {\n"
 regex='^#[[:space:]]*define[[:space:]]+KVM_(\w+)[[:space:]]+_IO[RW]*\([[:space:]]*KVMIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
-egrep $regex ${header_dir}/kvm.h	| \
+grep -E $regex ${header_dir}/kvm.h	| \
 	sed -r "s/$regex/\2 \1/g"	| \
-	egrep -v " ((ARM|PPC|S390)_|[GS]ET_(DEBUGREGS|PIT2|XSAVE|TSC_KHZ)|CREATE_SPAPR_TCE_64)" | \
+	grep -E -v " ((ARM|PPC|S390)_|[GS]ET_(DEBUGREGS|PIT2|XSAVE|TSC_KHZ)|CREATE_SPAPR_TCE_64)" | \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/madvise_behavior.sh b/tools/perf/trace/beauty/madvise_behavior.sh
index 4527d29..c659c33 100755
--- a/tools/perf/trace/beauty/madvise_behavior.sh
+++ b/tools/perf/trace/beauty/madvise_behavior.sh
@@ -5,7 +5,7 @@
 
 printf "static const char *madvise_advices[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MADV_([[:alnum:]_]+)[[:space:]]+([[:digit:]]+)[[:space:]]*.*'
-egrep $regex ${header_dir}/mman-common.h | \
+grep -E $regex ${header_dir}/mman-common.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort -n | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
index 7682571..3022597 100755
--- a/tools/perf/trace/beauty/mmap_flags.sh
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -15,26 +15,26 @@ fi
 linux_mman=${linux_header_dir}/mman.h
 arch_mman=${arch_header_dir}/mman.h
 
-# those in egrep -vw are flags, we want just the bits
+# those in grep -E -vw are flags, we want just the bits
 
 printf "static const char *mmap_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MAP_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
-egrep -q $regex ${arch_mman} && \
-(egrep $regex ${arch_mman} | \
+grep -E -q $regex ${arch_mman} && \
+(grep -E $regex ${arch_mman} | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
-egrep -q $regex ${linux_mman} && \
-(egrep $regex ${linux_mman} | \
-	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
+grep -E -q $regex ${linux_mman} && \
+(grep -E $regex ${linux_mman} | \
+	grep -E -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g" | \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
-([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*' ${arch_mman}) &&
-(egrep $regex ${header_dir}/mman-common.h | \
-	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
+([ ! -f ${arch_mman} ] || grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*' ${arch_mman}) &&
+(grep -E $regex ${header_dir}/mman-common.h | \
+	grep -E -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
-([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.h>.*' ${arch_mman}) &&
-(egrep $regex ${header_dir}/mman.h | \
+([ ! -f ${arch_mman} ] || grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.h>.*' ${arch_mman}) &&
+(grep -E $regex ${header_dir}/mman.h | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
 printf "};\n"
diff --git a/tools/perf/trace/beauty/mmap_prot.sh b/tools/perf/trace/beauty/mmap_prot.sh
index 664d8d5..49e8c86 100755
--- a/tools/perf/trace/beauty/mmap_prot.sh
+++ b/tools/perf/trace/beauty/mmap_prot.sh
@@ -17,14 +17,14 @@ prefix="PROT"
 
 printf "static const char *mmap_prot[] = {\n"
 regex=`printf '^[[:space:]]*#[[:space:]]*define[[:space:]]+%s_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*' ${prefix}`
-([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*' ${arch_mman}) &&
-(egrep $regex ${common_mman} | \
-	egrep -vw PROT_NONE | \
+([ ! -f ${arch_mman} ] || grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*' ${arch_mman}) &&
+(grep -E $regex ${common_mman} | \
+	grep -E -vw PROT_NONE | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef ${prefix}_%s\n#define ${prefix}_%s %s\n#endif\n")
-[ -f ${arch_mman} ] && egrep -q $regex ${arch_mman} && 
-(egrep $regex ${arch_mman} | \
-	egrep -vw PROT_NONE | \
+[ -f ${arch_mman} ] && grep -E -q $regex ${arch_mman} &&
+(grep -E $regex ${arch_mman} | \
+	grep -E -vw PROT_NONE | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef ${prefix}_%s\n#define ${prefix}_%s %s\n#endif\n")
 printf "};\n"
diff --git a/tools/perf/trace/beauty/mount_flags.sh b/tools/perf/trace/beauty/mount_flags.sh
index 847850b..730099a 100755
--- a/tools/perf/trace/beauty/mount_flags.sh
+++ b/tools/perf/trace/beauty/mount_flags.sh
@@ -5,11 +5,11 @@
 
 printf "static const char *mount_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+([[:digit:]]+)[[:space:]]*.*'
-egrep $regex ${header_dir}/mount.h | egrep -v '(MSK|VERBOSE|MGC_VAL)\>' | \
+grep -E $regex ${header_dir}/mount.h | grep -E -v '(MSK|VERBOSE|MGC_VAL)\>' | \
 	sed -r "s/$regex/\2 \2 \1/g" | sort -n | \
 	xargs printf "\t[%s ? (ilog2(%s) + 1) : 0] = \"%s\",\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+\(1<<([[:digit:]]+)\)[[:space:]]*.*'
-egrep $regex ${header_dir}/mount.h | \
+grep -E $regex ${header_dir}/mount.h | \
 	sed -r "s/$regex/\2 \1/g" | \
 	xargs printf "\t[%s + 1] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/move_mount_flags.sh b/tools/perf/trace/beauty/move_mount_flags.sh
index 4b1d9ac..32e552f 100755
--- a/tools/perf/trace/beauty/move_mount_flags.sh
+++ b/tools/perf/trace/beauty/move_mount_flags.sh
@@ -11,7 +11,7 @@ linux_mount=${linux_header_dir}/mount.h
 
 printf "static const char *move_mount_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MOVE_MOUNT_([^_]+_[[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
-egrep $regex ${linux_mount} | \
+grep -E $regex ${linux_mount} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/mremap_flags.sh b/tools/perf/trace/beauty/mremap_flags.sh
index d581823..4d01835 100755
--- a/tools/perf/trace/beauty/mremap_flags.sh
+++ b/tools/perf/trace/beauty/mremap_flags.sh
@@ -11,8 +11,8 @@ linux_mman=${linux_header_dir}/mman.h
 
 printf "static const char *mremap_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MREMAP_([[:alnum:]_]+)[[:space:]]+((0x)?[[:xdigit:]]+)[[:space:]]*.*'
-egrep -q $regex ${linux_mman} && \
-(egrep $regex ${linux_mman} | \
+grep -E -q $regex ${linux_mman} && \
+(grep -E $regex ${linux_mman} | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MREMAP_%s\n#define MREMAP_%s %s\n#endif\n")
 printf "};\n"
diff --git a/tools/perf/trace/beauty/perf_ioctl.sh b/tools/perf/trace/beauty/perf_ioctl.sh
index 9aabd97..06c2774 100755
--- a/tools/perf/trace/beauty/perf_ioctl.sh
+++ b/tools/perf/trace/beauty/perf_ioctl.sh
@@ -5,7 +5,7 @@
 
 printf "static const char *perf_ioctl_cmds[] = {\n"
 regex='^#[[:space:]]*define[[:space:]]+PERF_EVENT_IOC_(\w+)[[:space:]]+_IO[RW]*[[:space:]]*\([[:space:]]*.\$.[[:space:]]*,[[:space:]]*([[:digit:]]+).*'
-egrep $regex ${header_dir}/perf_event.h	| \
+grep -E $regex ${header_dir}/perf_event.h	| \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/pkey_alloc_access_rights.sh b/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
index f8f1b56..74da888 100755
--- a/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
+++ b/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
@@ -5,7 +5,7 @@
 
 printf "static const char *pkey_alloc_access_rights[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+PKEY_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*'
-egrep $regex ${header_dir}/mman-common.h	| \
+grep -E $regex ${header_dir}/mman-common.h	| \
 	sed -r "s/$regex/\2 \2 \1/g"	| \
 	sort | xargs printf "\t[%s ? (ilog2(%s) + 1) : 0] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
index 3d27878..8059342 100755
--- a/tools/perf/trace/beauty/prctl_option.sh
+++ b/tools/perf/trace/beauty/prctl_option.sh
@@ -5,14 +5,14 @@
 
 printf "static const char *prctl_options[] = {\n"
 regex='^#define[[:space:]]{1}PR_(\w+)[[:space:]]*([[:xdigit:]]+)([[:space:]]*\/.*)?$'
-egrep $regex ${header_dir}/prctl.h | grep -v PR_SET_PTRACER | \
+grep -E $regex ${header_dir}/prctl.h | grep -v PR_SET_PTRACER | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort -n | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
 
 printf "static const char *prctl_set_mm_options[] = {\n"
 regex='^#[[:space:]]+define[[:space:]]+PR_SET_MM_(\w+)[[:space:]]*([[:digit:]]+).*'
-egrep $regex ${header_dir}/prctl.h | \
+grep -E $regex ${header_dir}/prctl.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort -n | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/rename_flags.sh b/tools/perf/trace/beauty/rename_flags.sh
index 54c87c7..94bf7f4 100755
--- a/tools/perf/trace/beauty/rename_flags.sh
+++ b/tools/perf/trace/beauty/rename_flags.sh
@@ -8,8 +8,8 @@ fs_header=${header_dir}/fs.h
 
 printf "static const char *rename_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+RENAME_([[:alnum:]_]+)[[:space:]]+\(1[[:space:]]*<<[[:space:]]*([[:xdigit:]]+)[[:space:]]*\)[[:space:]]*.*'
-egrep -q $regex ${fs_header} && \
-(egrep $regex ${fs_header} | \
+grep -E -q $regex ${fs_header} && \
+(grep -E $regex ${fs_header} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[%d + 1] = \"%s\",\n")
 printf "};\n"
diff --git a/tools/perf/trace/beauty/sockaddr.sh b/tools/perf/trace/beauty/sockaddr.sh
index 3820e5c..a59827e 100755
--- a/tools/perf/trace/beauty/sockaddr.sh
+++ b/tools/perf/trace/beauty/sockaddr.sh
@@ -17,8 +17,8 @@ printf "static const char *socket_families[] = {\n"
 # #define AF_LOCAL	1	/* POSIX name for AF_UNIX	*/
 regex='^#define[[:space:]]+AF_(\w+)[[:space:]]+([[:digit:]]+).*'
 
-egrep $regex ${header_dir}/socket.h | \
+grep -E $regex ${header_dir}/socket.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[%s] = \"%s\",\n" | \
-	egrep -v "\"(UNIX|MAX)\""
+	grep -E -v "\"(UNIX|MAX)\""
 printf "};\n"
diff --git a/tools/perf/trace/beauty/socket.sh b/tools/perf/trace/beauty/socket.sh
index 76330ac..8bc7ba62 100755
--- a/tools/perf/trace/beauty/socket.sh
+++ b/tools/perf/trace/beauty/socket.sh
@@ -12,7 +12,7 @@ fi
 printf "static const char *socket_ipproto[] = {\n"
 ipproto_regex='^[[:space:]]+IPPROTO_(\w+)[[:space:]]+=[[:space:]]+([[:digit:]]+),.*'
 
-egrep $ipproto_regex ${uapi_header_dir}/in.h | \
+grep -E $ipproto_regex ${uapi_header_dir}/in.h | \
 	sed -r "s/$ipproto_regex/\2 \1/g"	| \
 	sort -n | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n\n"
@@ -20,7 +20,7 @@ printf "};\n\n"
 printf "static const char *socket_level[] = {\n"
 socket_level_regex='^#define[[:space:]]+SOL_(\w+)[[:space:]]+([[:digit:]]+)([[:space:]]+\/.*)?'
 
-egrep $socket_level_regex ${beauty_header_dir}/socket.h | \
+grep -E $socket_level_regex ${beauty_header_dir}/socket.h | \
 	sed -r "s/$socket_level_regex/\2 \1/g"	| \
 	sort -n | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n\n"
diff --git a/tools/perf/trace/beauty/sync_file_range.sh b/tools/perf/trace/beauty/sync_file_range.sh
index 7a9282d..90bf633 100755
--- a/tools/perf/trace/beauty/sync_file_range.sh
+++ b/tools/perf/trace/beauty/sync_file_range.sh
@@ -11,7 +11,7 @@ linux_fs=${linux_header_dir}/fs.h
 
 printf "static const char *sync_file_range_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+SYNC_FILE_RANGE_([[:alnum:]_]+)[[:space:]]+([[:xdigit:]]+)[[:space:]]*.*'
-egrep $regex ${linux_fs} | \
+grep -E $regex ${linux_fs} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh b/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
index f920003..eed9ce0 100755
--- a/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
+++ b/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
@@ -15,12 +15,12 @@ x86_irq_vectors=${arch_x86_header_dir}/irq_vectors.h
 # the time of writing of this script was: IRQ_MOVE_CLEANUP_VECTOR.
 
 first_external_regex='^#define[[:space:]]+FIRST_EXTERNAL_VECTOR[[:space:]]+(0x[[:xdigit:]]+)$'
-first_external_vector=$(egrep ${first_external_regex} ${x86_irq_vectors} | sed -r "s/${first_external_regex}/\1/g")
+first_external_vector=$(grep -E ${first_external_regex} ${x86_irq_vectors} | sed -r "s/${first_external_regex}/\1/g")
 
 printf "static const char *x86_irq_vectors[] = {\n"
 regex='^#define[[:space:]]+([[:alnum:]_]+)_VECTOR[[:space:]]+(0x[[:xdigit:]]+)$'
 sed -r "s/FIRST_EXTERNAL_VECTOR/${first_external_vector}/g" ${x86_irq_vectors} | \
-egrep ${regex} | \
+grep -E ${regex} | \
 	sed -r "s/${regex}/\2 \1/g" | sort -n | \
 	xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n\n"
diff --git a/tools/perf/trace/beauty/tracepoints/x86_msr.sh b/tools/perf/trace/beauty/tracepoints/x86_msr.sh
index 9b0614a..0078689 100755
--- a/tools/perf/trace/beauty/tracepoints/x86_msr.sh
+++ b/tools/perf/trace/beauty/tracepoints/x86_msr.sh
@@ -15,7 +15,7 @@ x86_msr_index=${arch_x86_header_dir}/msr-index.h
 
 printf "static const char *x86_MSRs[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x00000[[:xdigit:]]+)[[:space:]]*.*'
-egrep $regex ${x86_msr_index} | egrep -v 'MSR_(ATOM|P[46]|IA32_(TSC_DEADLINE|UCODE_REV)|IDT_FCR4)' | \
+grep -E $regex ${x86_msr_index} | grep -E -v 'MSR_(ATOM|P[46]|IA32_(TSC_DEADLINE|UCODE_REV)|IDT_FCR4)' | \
 	sed -r "s/$regex/\2 \1/g" | sort -n | \
 	xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n\n"
@@ -23,18 +23,18 @@ printf "};\n\n"
 # Remove MSR_K6_WHCR, clashes with MSR_LSTAR
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0xc0000[[:xdigit:]]+)[[:space:]]*.*'
 printf "#define x86_64_specific_MSRs_offset "
-egrep $regex ${x86_msr_index} | sed -r "s/$regex/\2/g" | sort -n | head -1
+grep -E $regex ${x86_msr_index} | sed -r "s/$regex/\2/g" | sort -n | head -1
 printf "static const char *x86_64_specific_MSRs[] = {\n"
-egrep $regex ${x86_msr_index} | \
-	sed -r "s/$regex/\2 \1/g" | egrep -vw 'K6_WHCR' | sort -n | \
+grep -E $regex ${x86_msr_index} | \
+	sed -r "s/$regex/\2 \1/g" | grep -E -vw 'K6_WHCR' | sort -n | \
 	xargs printf "\t[%s - x86_64_specific_MSRs_offset] = \"%s\",\n"
 printf "};\n\n"
 
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0xc0010[[:xdigit:]]+)[[:space:]]*.*'
 printf "#define x86_AMD_V_KVM_MSRs_offset "
-egrep $regex ${x86_msr_index} | sed -r "s/$regex/\2/g" | sort -n | head -1
+grep -E $regex ${x86_msr_index} | sed -r "s/$regex/\2/g" | sort -n | head -1
 printf "static const char *x86_AMD_V_KVM_MSRs[] = {\n"
-egrep $regex ${x86_msr_index} | \
+grep -E $regex ${x86_msr_index} | \
 	sed -r "s/$regex/\2 \1/g" | sort -n | \
 	xargs printf "\t[%s - x86_AMD_V_KVM_MSRs_offset] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/usbdevfs_ioctl.sh b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
index aa597ae..b39cfb3 100755
--- a/tools/perf/trace/beauty/usbdevfs_ioctl.sh
+++ b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
@@ -8,14 +8,14 @@
 
 printf "static const char *usbdevfs_ioctl_cmds[] = {\n"
 regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)(\(\w+\))?[[:space:]]+_IO[CWR]{0,2}\([[:space:]]*(_IOC_\w+,[[:space:]]*)?'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
-egrep "$regex" ${header_dir}/usbdevice_fs.h | egrep -v 'USBDEVFS_\w+32[[:space:]]' | \
+grep -E "$regex" ${header_dir}/usbdevice_fs.h | grep -E -v 'USBDEVFS_\w+32[[:space:]]' | \
 	sed -r "s/$regex/\4 \1/g"	| \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n\n"
 printf "#if 0\n"
 printf "static const char *usbdevfs_ioctl_32_cmds[] = {\n"
 regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
-egrep $regex ${header_dir}/usbdevice_fs.h | egrep 'USBDEVFS_\w+32[[:space:]]' | \
+grep -E $regex ${header_dir}/usbdevice_fs.h | grep -E 'USBDEVFS_\w+32[[:space:]]' | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/vhost_virtio_ioctl.sh b/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
index 439773d..2dd0a3b 100755
--- a/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
+++ b/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
@@ -5,14 +5,14 @@
 
 printf "static const char *vhost_virtio_ioctl_cmds[] = {\n"
 regex='^#[[:space:]]*define[[:space:]]+VHOST_(\w+)[[:space:]]+_IOW?\([[:space:]]*VHOST_VIRTIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
-egrep $regex ${header_dir}/vhost.h | \
+grep -E $regex ${header_dir}/vhost.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
 
 printf "static const char *vhost_virtio_ioctl_read_cmds[] = {\n"
 regex='^#[[:space:]]*define[[:space:]]+VHOST_(\w+)[[:space:]]+_IOW?R\([[:space:]]*VHOST_VIRTIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
-egrep $regex ${header_dir}/vhost.h | \
+grep -E $regex ${header_dir}/vhost.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/x86_arch_prctl.sh b/tools/perf/trace/beauty/x86_arch_prctl.sh
index 7372d3c..57fa6aa 100755
--- a/tools/perf/trace/beauty/x86_arch_prctl.sh
+++ b/tools/perf/trace/beauty/x86_arch_prctl.sh
@@ -15,8 +15,8 @@ print_range () {
 	printf "static const char *x86_arch_prctl_codes_%d[] = {\n" $idx
 	regex=`printf '^[[:space:]]*#[[:space:]]*define[[:space:]]+ARCH_([[:alnum:]_]+)[[:space:]]+(%s[[:xdigit:]]+).*' ${prefix}`
 	fmt="\t[%#x - ${first_entry}]= \"%s\",\n"
-	egrep -q $regex ${prctl_arch_header} && \
-	(egrep $regex ${prctl_arch_header} | \
+	grep -E -q $regex ${prctl_arch_header} && \
+	(grep -E $regex ${prctl_arch_header} | \
 		sed -r "s/$regex/\2 \1/g"	| \
 		xargs printf "$fmt")
 	printf "};\n\n"
-- 
2.1.0

