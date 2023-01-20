Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235346748CD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjATB16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjATB14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:27:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED884C35;
        Thu, 19 Jan 2023 17:27:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAA0F61DD2;
        Fri, 20 Jan 2023 01:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07CFC433D2;
        Fri, 20 Jan 2023 01:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674178073;
        bh=trOccCtKJdAbvxVkpZn02r9ePecCo+7hkHsdUok6MFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=efoG82ZG3fenq1hPZQJcQmo7Gq0pTmIW2z6WkYBoS3BhAL9kTQBgqUKvMJgWv12Hp
         sQh2qU5z7cC3gkoBndc1aGBHlw37Ia+ODUV2eKRVn0p/kLmvyhuy3vpt06NpPP4Wry
         nhuh/FPXdUYGG6sE/zIXkm3gEmVglRjV8lfg4onK005u4RF/DSGyUf1PQMOf+QHKTS
         dWq/Og0grT4CflliqRN6o2R2gFU94hgjHiGAdzBO3pgd+7cMDH5qlbaycrWmBfc4KA
         /GlW8jwP+r1QdbEqenkSxi5ZNptGvf+OFU8pjRLwgY0zXHVnx9FVxRDAWtcj/4CP8R
         jx0oEgM51fHnA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4948C405BE; Thu, 19 Jan 2023 22:27:50 -0300 (-03)
Date:   Thu, 19 Jan 2023 22:27:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Sohom Datta <sohomdatta1+git@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf tools fixes for v6.2: 3rd batch
Message-ID: <Y8nuFmDDQU5c/4tS@kernel.org>
References: <20230119171510.166368-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119171510.166368-1-acme@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Humm,

	I'm not finding this on the lkml archives, so please ignore it
if this is going as a duplicate for anyone :-\

Thanks,

- Arnaldo

Em Thu, Jan 19, 2023 at 02:15:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Linus,
> 
> 	Sync of UAPI headers with the kernel sources, to address
> warnings while building perf and two small fixes for the main tools + a
> 'perf test' fix related to the build-id fix.
> 
> 	 Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> The following changes since commit c1649ec55708ae42091a2f1bca1ab49ecd722d55:
> 
>   Merge tag 'nfsd-6.2-4' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux (2023-01-17 09:29:17 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.2-3-2023-01-19
> 
> for you to fetch changes up to 3d9c07c4cfc06cf7927cd00c04dffd1165d03c53:
> 
>   perf test build-id: Fix test check for PE file (2023-01-18 10:52:06 -0300)
> 
> ----------------------------------------------------------------
> perf tools fixes for v6.2: 3rd batch.
> 
> - Prevent reading into undefined memory in the expression lexer,
>   accounting for a trailer backslash followed by the null byte.
> 
> - Fix file mode when copying files to the build id cache, the problem
>   happens when the cache directory is in a different file system than the
>   file being cached, otherwise the mode was preserved as only a hard link
>   would be done to save space.
> 
> - Fix a related build-id 'perf test' entry that checked that permission
>   when caching PE (Portable Executable) files, used when profiling
>   Windows executables under wine.
> 
> - Sync the tools/ copies of kvm headers, build_bug.h, socket.h and
>   arm64's cputype.h with the kernel sources.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (6):
>       tools headers UAPI: Sync linux/kvm.h with the kernel sources
>       tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
>       tools kvm headers arm64: Update KVM header from the kernel sources
>       tools headers arm64: Sync arm64's cputype.h with the kernel sources
>       perf beauty: Update copy of linux/socket.h with the kernel sources
>       tools headers: Syncronize linux/build_bug.h with the kernel sources
> 
> Athira Rajeev (2):
>       perf buildid-cache: Fix the file mode with copyfile() while adding file to build-id cache
>       perf test build-id: Fix test check for PE file
> 
> Sohom Datta (1):
>       perf expr: Prevent normalize() from reading into undefined memory in the expression lexer
> 
>  tools/arch/arm64/include/asm/cputype.h         |  8 +++++++-
>  tools/arch/arm64/include/uapi/asm/kvm.h        |  1 +
>  tools/arch/x86/include/uapi/asm/kvm.h          |  5 +++++
>  tools/include/linux/build_bug.h                |  9 +++++++++
>  tools/include/uapi/linux/kvm.h                 |  3 +++
>  tools/perf/tests/shell/buildid.sh              | 15 ++++++++++++++-
>  tools/perf/trace/beauty/include/linux/socket.h |  5 ++++-
>  tools/perf/util/build-id.c                     | 10 +++++++---
>  tools/perf/util/expr.l                         |  5 ++++-
>  9 files changed, 54 insertions(+), 7 deletions(-)
