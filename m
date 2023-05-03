Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294AE6F5A94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjECPE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjECPEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:04:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D568B4C15;
        Wed,  3 May 2023 08:04:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7472060C75;
        Wed,  3 May 2023 15:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72BAC4339B;
        Wed,  3 May 2023 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683126263;
        bh=O4yYd1WUoawxWUlnbi//Aw0bkKIFeQzVHOZgaaz1lTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3rJ730VI76xVq/Yd1qBPXxaILS4zJabwDhQ2vA6Yb9BlQh9sENrclIc9gGVWJQ9H
         KV6DuZycHxJV/BBy7k0dK9Ta13yE8Ett9wsuZKlyQ+BxKOWRjaiRU/rhXBKi6LrAYU
         y5oYasffYdx3HXVQNIKRGIxJ4hgUJAsnY7lkD1ti2MBqSOOZb7cfustxWhVO1y0S/9
         5UG01TApZYbA2AfrXcDLDCmP9xbZhAYl1YB/KdbUhMNdBSSLG2Ck9H6h8grJq9hGf1
         vRd+69Wf0NBoOOmfyQP9pvaROWgtsnajHTMs/0FEADx3ohNTcJEiA9ZDLZb6/PwlpX
         4b4IdvUq2V06A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EBEC6403B5; Wed,  3 May 2023 12:04:20 -0300 (-03)
Date:   Wed, 3 May 2023 12:04:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: Re: [PATCH v2] perf: Avoid implicit function declarations in
 lexer/parse interface
Message-ID: <ZFJ39HKzBUg64QPO@kernel.org>
References: <87sfcn7uot.fsf@oldenburg.str.redhat.com>
 <CAP-5=fXZv+KCdCN05wVUcAwDCZAgXjWunoaviGBQEiUPqNwOmg@mail.gmail.com>
 <ZEx0IQAtBatrRDCR@kernel.org>
 <ZEx0xAamEl66qk2w@kernel.org>
 <874jot69ks.fsf@oldenburg.str.redhat.com>
 <87zg6l4utl.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zg6l4utl.fsf@oldenburg.str.redhat.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 03, 2023 at 11:40:06AM +0200, Florian Weimer escreveu:
> * Florian Weimer:
> > * Arnaldo Carvalho de Melo:

> >>> Thanks, applied. BTW b4 coulnd't find this message (nor the original):

> > Yes, vger drops the message after accepting it for some reason, probably
> > something in the patch contents.  I tried to resubmit from a completely
> > separate account, no luck.
> >
> >> Not so fast, removed it for now:
> >>
> >>   CC      /tmp/build/perf-tools-next/util/parse-events-bison.o
> >> In file included from util/pmu.y:14:
> >> /tmp/build/perf-tools-next/util/pmu-flex.h:496:1: error: unknown type name ‘YYSTYPE’
> >>   496 |
> >>       | ^
> >> /tmp/build/perf-tools-next/util/pmu-flex.h:498:19: error: unknown type name ‘YYSTYPE’
> >>   498 |
> >>       |                   ^
> >> /tmp/build/perf-tools-next/util/pmu-flex.h:546:17: error: unknown type name ‘YYSTYPE’
> >>   546 | extern int yylex \
> >>       |                 ^~
> >> util/pmu-bison.c: In function ‘perf_pmu_parse’:
> >> /tmp/build/perf-tools-next/util/pmu-bison.c:69:25: error: implicit declaration of function ‘perf_pmu_lex’; did you mean ‘perf_pmu_free’? [-Werror=implicit-function-declaration]
> >>    69 | #define yylex           perf_pmu_lex
> >>       |                         ^~~~~~~~~~~~
> >> util/pmu-bison.c:1007:16: note: in expansion of macro ‘yylex’
> >
> > This appears to be related to some BPF filter stuff that is only in
> > perf-next, not mainline.
> >
> > Is this the right tree on which to base the patch?
> >
> >   <https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/>
> >
> > Branch perf-tools-next?
> 
> Sorry, it doesn't build even without my patch:
> 
> make[4]: *** No rule to make target 'zip.h', needed by '/tmp/build/libbpf/staticobjs/libbpf.o'.  Stop.

I'm noticing this, but then I haven't merged with upstream yet, I bet
this is something upstream after merging the bpf branch... Nope, I just
did a test merge of what is in
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-tools
with upstream and it builds without problems on:

[acme@quaco perf-tools]$ head -2 /etc/os-release
NAME="Fedora Linux"
VERSION="37 (Workstation Edition)"
[acme@quaco perf-tools]$

I'll check on f38 and rawhide.

- Arnaldo



