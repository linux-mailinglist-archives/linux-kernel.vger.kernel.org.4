Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0711E6F7851
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjEDVs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEDVsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:48:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19E61154C;
        Thu,  4 May 2023 14:48:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D42F60FF2;
        Thu,  4 May 2023 21:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64255C433D2;
        Thu,  4 May 2023 21:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683236933;
        bh=E+tiJRiug8u/AhLbDq1jW1M9EjtSX+RGcxzT9cXg0OA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMdA9ogtCuMp0Sz7JLCENwEd4AWatDFzw2WAwjb5ktcXxWjfNKWW7bZyOUArAd8HU
         UL4OumyNy3crnSxBKNshymYNbVbX4lOa279OubixiBydpm/RRHSWJRaHtCqz6uspVU
         NEc6KhOBq9ve6ukXju2/z1noWgOV2W56EGYwUupQ02PcTJikJf+YeE3DIAqvxPQ53s
         WQlvgBJ5hkCpGo7m2vYt5L3CXYee/mEUSciL6LXLUCvyTBXvoOvtADzcgsDvF2MbAq
         UlavxJ2HQQSMEpKZFr9hn0h/eFbXP+IsaAuHElYt2IWahMLk64u0OWUJQ/YRUgoLFc
         W35nmYHgPCemQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4C6A0403B5; Thu,  4 May 2023 18:48:50 -0300 (-03)
Date:   Thu, 4 May 2023 18:48:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
Message-ID: <ZFQoQjCNtyMIulp+@kernel.org>
References: <20230503211801.897735-1-acme@kernel.org>
 <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org>
 <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org>
 <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFQCccsx6GK+gY0j@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 04, 2023 at 04:07:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, May 04, 2023 at 11:50:07AM -0700, Andrii Nakryiko escreveu:
> > On Thu, May 4, 2023 at 10:52 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Andrii, can you add some more information about the usage of vmlinux.h
> > > instead of using kernel headers?
>  
> > I'll just say that vmlinux.h is not a hard requirement to build BPF
> > programs, it's more a convenience allowing easy access to definitions
> > of both UAPI and kernel-internal structures for tracing needs and
> > marking them relocatable using BPF CO-RE machinery. Lots of real-world
> > applications just check-in pregenerated vmlinux.h to avoid build-time
> > dependency on up-to-date host kernel and such.
>  
> > If vmlinux.h generation and usage is causing issues, though, given
> > that perf's BPF programs don't seem to be using many different kernel
> > types, it might be a better option to just use UAPI headers for public
> > kernel type definitions, and just define CO-RE-relocatable minimal
> > definitions locally in perf's BPF code for the other types necessary.
> > E.g., if perf needs only pid and tgid from task_struct, this would
> > suffice:
>  
> > struct task_struct {
> >     int pid;
> >     int tgid;
> > } __attribute__((preserve_access_index));
> 
> Yeah, that seems like a way better approach, no vmlinux involved, libbpf
> CO-RE notices that task_struct changed from this two integers version
> (of course) and does the relocation to where it is in the running kernel
> by using /sys/kernel/btf/vmlinux.

Doing it for one of the skels, build tested, runtime untested, but not
using any vmlinux, BTF to help, not that bad, more verbose, but at least
we state what are the fields we actually use, have those attribute
documenting that those offsets will be recorded for future use, etc.

Namhyung, can you please check that this works?

Thanks,

- Arnaldo

diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
index 6a438e0102c5a2cb..f376d162549ebd74 100644
--- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -1,11 +1,40 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (c) 2021 Facebook
 // Copyright (c) 2021 Google
-#include "vmlinux.h"
+#include <linux/types.h>
+#include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
+// libbpf's CO-RE will take care of the relocations so that these fields match
+// the layout of these structs in the kernel where this ends up running on.
+
+struct cgroup_subsys_state {
+	struct cgroup *cgroup;
+} __attribute__((preserve_access_index));
+
+struct css_set {
+	struct cgroup_subsys_state *subsys[13];
+} __attribute__((preserve_access_index));
+
+struct task_struct {
+	struct css_set *cgroups;
+} __attribute__((preserve_access_index));
+
+struct kernfs_node {
+	__u64 id;
+}  __attribute__((preserve_access_index));
+
+struct cgroup {
+	struct kernfs_node *kn;
+	int                level;
+}  __attribute__((preserve_access_index));
+
+enum cgroup_subsys_id {
+	perf_event_cgrp_id  = 8,
+};
+
 #define MAX_LEVELS  10  // max cgroup hierarchy level: arbitrary
 #define MAX_EVENTS  32  // max events per cgroup: arbitrary
 
@@ -52,7 +81,7 @@ struct cgroup___new {
 /* old kernel cgroup definition */
 struct cgroup___old {
 	int level;
-	u64 ancestor_ids[];
+	__u64 ancestor_ids[];
 } __attribute__((preserve_access_index));
 
 const volatile __u32 num_events = 1;
