Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15E564F981
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 15:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLQOuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 09:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLQOuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 09:50:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E3E12AC0;
        Sat, 17 Dec 2022 06:50:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E3D1B80171;
        Sat, 17 Dec 2022 14:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52510C433EF;
        Sat, 17 Dec 2022 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671288610;
        bh=aJwNqUMn5+EVjm93LvFd66mFnVeLrNviIvzH7Hx2Vic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6J+HwbxWev69W4PhBWqKN76DPLrq8cgerqGXSacAuUZaEfAErUwrw1t+04bEerea
         Ld+WsAEt+20gtjOcPXuqORNwT8PiDN55EtfCBjRJCy4G6HPaPmMz5Xg0D5hx7TXmw6
         7krVFep342vKxDbZbAIksiTyZG7zUxbSh90zBhQ5gp4GjStX9L9xipESyYEp0ISNgU
         +GBR3HTy05GraF4Xz1oY0MSYnCfkehoQlrSuBw/9qdgjPm37fxhuqIZJdjmGi4tLah
         nDllZPQ5Tb8j2mAQlNIhhb7XinggaOV4+g8YGJcIUJCfe3qjLi7IJenhsf28Q4/aYA
         F6oELwGpxgoqg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5B7F240367; Sat, 17 Dec 2022 11:50:07 -0300 (-03)
Date:   Sat, 17 Dec 2022 11:50:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kautuk Consul <kconsul@ventanamicro.com>,
        Leo Yan <leo.yan@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikita Shubin <n.shubin@yadro.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf tools changes for v6.2: 1st batch
Message-ID: <Y53XHw3rlsaaUgOs@kernel.org>
References: <20221216143609.186415-1-acme@kernel.org>
 <CAHk-=wj+FNSnspKwVWAatD+DHz3Uy4eHxQryrfoZz6=4D=1X1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+FNSnspKwVWAatD+DHz3Uy4eHxQryrfoZz6=4D=1X1w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 16, 2022 at 01:41:24PM -0600, Linus Torvalds escreveu:
> On Fri, Dec 16, 2022 at 8:36 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> >         This time there is a trivial resolution of a merge conflict
> > related to commit c302378bc157f6a7 ("libbpf: Hashmap interface update to
> > allow both long and void* keys/values"), that touched tools/perf/ files.
 
> Normally I'd ask you very sternly to please not resolve merge
> conflicts for me, but since I just screwed up another merge due to

I thought I was helping you... Now I know better :-/

> being on the road and not having done a full build test, I guess I
> will just be quiet this time.
 
> So the real reason for this email is that I get an error like this on
> my laptop when trying to build the perf tools:
 
>     INSTALL libbpf_headers
>   Traceback (most recent call last):
>     File "util/setup.py", line 31, in <module>
>       from setuptools import setup, Extension
>   ImportError: No module named setuptools
>   cp: cannot stat 'python_ext_build/lib/perf*.so': No such file or directory
>   make[2]: *** [Makefile.perf:651: python/perf] Error 1
>   make[2]: *** Waiting for unfinished jobs....
>   make[1]: *** [Makefile.perf:236: sub-make] Error 2
>   make: *** [Makefile:70: all] Error 2
 
> and it's not new to this pull - I've seen it before and it's something
> stupid I've done.
 
> I think it's a missing package dependency that this laptop then hits.
> But considering my previous merge failure, I'm not super-happy about
> traveling with a laptop that then can't do this build test.

My bad, I should have acted upon that immediately, oh well, fell thru
the cracks but now I have a fix in my perf/core and perf/urgent
branches.

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/urgent

It will be in my next pull req if you prefer not to apply it unsigned or
manually from the copy below.
 
> It would be lovely to have that package dependency - whatever it may
> be - tested for explicitly. Hint hint.

And below you have it, now back to the pool, the kids are waiting :-)

Regards,

- Arnaldo

From 71c2c68e4fadc9019d727bdcf54490c438d59cdb Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Sat, 17 Dec 2022 11:37:15 -0300
Subject: [PATCH 1/1] perf python: Don't stop building if python setuptools
 isn't installed

The python3-setuptools package is needed to build the python binding, so
that one can use things like:

  # ~acme/git/perf/tools/perf/python/twatch.py
  cpu: 6, pid: 4573, tid: 2184618 { type: exit, pid: 4573, ppid: 4172, tid: 2184618, ptid: 4172, time: 12563190090107}
  cpu: 24, pid: 4573, tid: 4573 { type: fork, pid: 4573, ppid: 4573, tid: 2190991, ptid: 4573, time: 12563415289331}
  cpu: 29, pid: 4573, tid: 2190991 { type: comm, pid: 4573, tid: 2190991, comm: StreamT~ns #401 }
  cpu: 29, pid: 4573, tid: 2190991 { type: comm, pid: 4573, tid: 2190991, comm: StreamT~ns #401 }
  ^CTraceback (most recent call last):
    File "/var/home/acme/git/perf/tools/perf/python/twatch.py", line 61, in <module>
      main()
    File "/var/home/acme/git/perf/tools/perf/python/twatch.py", line 33, in main
      evlist.poll(timeout = -1)
  KeyboardInterrupt

  #

That have 'import perf;'.

But distros don't always have that python3-setuptools (or equivalent)
installed, which was breaking the build. Just check if it is installed
and emit a warning that such binding isn't being built and continue the
build without it:

With it:

  $ rpm -q python3-setuptools
  python3-setuptools-59.6.0-3.fc36.noarch
  $ rm -rf /tmp/build/perf; mkdir -p /tmp/build/perf
  $ make O=/tmp/build/perf -C tools/perf install-bin
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  <SNIP>
  ...                               libpython: [ on  ]
  <SNIP>
    GEN     /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so
  <SNIP>
  $ ls -la /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so
  -rwxr-xr-x. 1 acme acme 1609112 Dec 17 11:39 /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so
  $

Without it:

  $ sudo rpm -e python3-setuptools
  $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
  $ make O=/tmp/build/perf -C tools/perf install-bin
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  <SNIP>
  ...                               libpython: [ on  ]
  <SNIP>
  $ ls -la /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so
  ls: cannot access '/tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so': No such file or directory
  $

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 83ed969b95b4a53f..c21bd6010be1384c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -890,8 +890,13 @@ else
       else
          LDFLAGS += $(PYTHON_EMBED_LDFLAGS)
          EXTLIBS += $(PYTHON_EMBED_LIBADD)
-         PYTHON_EXTENSION_SUFFIX := $(shell $(PYTHON) -c 'from importlib import machinery; print(machinery.EXTENSION_SUFFIXES[0])')
-         LANG_BINDINGS += $(obj-perf)python/perf$(PYTHON_EXTENSION_SUFFIX)
+         PYTHON_SETUPTOOLS_INSTALLED := $(shell $(PYTHON) -c 'import setuptools;' 2> /dev/null && echo "yes" || echo "no")
+         ifeq ($(PYTHON_SETUPTOOLS_INSTALLED), yes)
+           PYTHON_EXTENSION_SUFFIX := $(shell $(PYTHON) -c 'from importlib import machinery; print(machinery.EXTENSION_SUFFIXES[0])')
+           LANG_BINDINGS += $(obj-perf)python/perf$(PYTHON_EXTENSION_SUFFIX)
+	 else
+           msg := $(warning Missing python setuptools, the python binding won't be built, please install python3-setuptools or equivalent);
+         endif
          CFLAGS += -DHAVE_LIBPYTHON_SUPPORT
          $(call detected,CONFIG_LIBPYTHON)
       endif
-- 
2.38.1

