Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA1C6F7191
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjEDRw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDRwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2841759FF;
        Thu,  4 May 2023 10:52:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 922E763634;
        Thu,  4 May 2023 17:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B763DC433EF;
        Thu,  4 May 2023 17:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683222740;
        bh=A2w7Y71QqLt52hr0tlxUZFVDq7F6B+lT1dL7dRq4zpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ap8YPEnAH1XR8SFijaOYftny778ROMrxFYLjCqRYBXknC6lhSv2AffeF+9f4b3n8f
         0of9tsL8zKp+0wy8knnjVL4FCUVFbW5fA4ZwnZWJgO6dxWZRFVNdHr4HTCOBWgKqYy
         UmcaVpn3aa9mSBGLp8z2MVQG3vPVhgDOZd5nRESSbZ+bDrDTCKPS2qu22r7eSLFCdA
         QDbEAZxEaQ/Ivh4+pibiWAEvqNhCahxXRvbC/QN/9TUuDASCkqf6bkROCHCTpLojDl
         /15XpTeW0vtNJOj8e2n2YN3Ap7nNG78vyWjctWvxF0gzjMwUGzHG30RVqXUV/8Dd5u
         CUCj2ANnYyriA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2368F403B5; Thu,  4 May 2023 14:52:18 -0300 (-03)
Date:   Thu, 4 May 2023 14:52:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
Message-ID: <ZFPw0scDq1eIzfHr@kernel.org>
References: <20230503211801.897735-1-acme@kernel.org>
 <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org>
 <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
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

Em Thu, May 04, 2023 at 10:25:30AM -0700, Linus Torvalds escreveu:
> On Thu, May 4, 2023 at 4:09 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Does building runqslower works for you in this same environment where
> > building perf failed?
 
> I don't know, and I don't care. I've never used that thing, and I'm
> not going to.
 
> And it's irrelevant. Two wrongs do not make a right.
 
> I'm going to ignore perf tools pulls going forward if this is the kind
> of argument for garbage that you use.
 
> Because a billion flies *can* be wrong.

I pushed two reverts there that make this back into a
opt-in/experimental feature till we fix the issue you reported:

⬢[acme@toolbox perf-tools]$ git log --oneline -3
e7b7a54767a71c67 (HEAD -> perf-tools, acme/perf-tools) Revert "perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL"
6957bdf37a1e6eca Revert "perf build: Warn for BPF skeletons if endian mismatches"
1f85d016768ff19f (tag: perf-tools-for-v6.4-1-2023-05-03) perf test record+probe_libc_inet_pton: Fix call chain match on x86_64
⬢[acme@toolbox perf-tools]$

Its in:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-tools

Using a vmlinux.h file built by bpftool from the BTF info, be it in a
vmlinux file or in /sys/kernel/btf/vmlinux (a RAW BTF file) is used for
building the BPF bytecode, using clang:

⬢[acme@toolbox perf-tools]$ head tools/perf/util/bpf_skel/sample_filter.bpf.c
// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
// Copyright (c) 2023 Google
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <bpf/bpf_core_read.h>

#include "sample-filter.h"

/* BPF map that will be filled by user space */
⬢[acme@toolbox perf-tools]$

So that it can access kernel types and store the type info for those
types together with the BPF bytecode, as BTF info, and later use this
and relocation records for libbpf to be able to adjust things when
accessed data structures change in the kernel and needs adjustments
based in both the kernel BTF info (/sys/kernel/btf/vmlinux) and the
BPF bytecode being loaded (in its .BTF ELF section).

Andrii, can you add some more information about the usage of vmlinux.h
instead of using kernel headers?

- Arnaldo
