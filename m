Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805D1604BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiJSPni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJSPm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:42:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBE1159945
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C148B824B6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC7BC433C1;
        Wed, 19 Oct 2022 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666193841;
        bh=Pyf/5jc/F9OftiOaZ8cadnCvgMF+wR9y0maSC3y+b+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kXZ97hzKsXMjDn1yi/1wrzjDyE//rw6Yxp68W4bztYZI4P/e1ouPvU/G397ijyWMA
         FwPzJp0JJwojQ/E/QJn7RNEjchfZWiAHW4rHjJJAkmfEAvxUMFhgN99wpJ/EsZXWF0
         iAWHqbOjfZFFzDZiKH5R5WTTaH9EZeLPHY3mFbqrMRkQ/arnGzCN01NAWQUtZqi2o6
         uuoez5ji/3XdHoKIT5m1glqcCn66F5jc+FzTWUZEW9c6HdjkkkYAJLT7mUqLBp1sR+
         dKXI5CKZhG/StgkxTzTbzu3T74W5rFyCTZ2z6N+Kng0K1xHCqZOmEIlmVdtiqCHWLf
         2/M5owLyFYiFw==
Date:   Thu, 20 Oct 2022 00:37:16 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] selftests/ftrace: Add check for ping command for
 trigger tests
Message-Id: <20221020003716.00dce32c60ac97c06682f4b8@kernel.org>
In-Reply-To: <4ec67d1b5c5d4e693a4826a89c9fd4eca5343eb6.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
        <4ec67d1b5c5d4e693a4826a89c9fd4eca5343eb6.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 19:33:40 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> All these tests depend on the ping command and will fail if it is not
> found. Allow tests to specify dependencies on programs through the
> 'requires' field. Add dependency on 'ping' for some of the trigger
> tests.
> 
> Reported-by: Akanksha J N <akanksha@linux.vnet.ibm.com>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> ---
>  tools/testing/selftests/ftrace/test.d/functions           | 8 +++++++-
>  .../trigger/inter-event/trigger-field-variable-support.tc | 2 +-
>  .../inter-event/trigger-inter-event-combined-hist.tc      | 2 +-
>  .../trigger/inter-event/trigger-onchange-action-hist.tc   | 2 +-
>  .../trigger/inter-event/trigger-onmatch-action-hist.tc    | 2 +-
>  .../inter-event/trigger-onmatch-onmax-action-hist.tc      | 2 +-
>  .../trigger/inter-event/trigger-onmax-action-hist.tc      | 2 +-
>  .../trigger/inter-event/trigger-snapshot-action-hist.tc   | 2 +-
>  .../inter-event/trigger-synthetic-event-dynstring.tc      | 2 +-
>  .../trigger/inter-event/trigger-trace-action-hist.tc      | 2 +-
>  10 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 5f6cbec847fc99..779f3e62ec9005 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -142,9 +142,15 @@ finish_ftrace() {
>  
>  check_requires() { # Check required files and tracers
>      for i in "$@" ; do
> +	p=${i%:program}
>          r=${i%:README}
>          t=${i%:tracer}
> -        if [ $t != $i ]; then
> +	if [ $p != $i ]; then
> +	    if ! which $p ; then
> +                echo "Required program $p is not found."
> +                exit_unresolved
> +	    fi
> +        elif [ $t != $i ]; then
>              if ! grep -wq $t available_tracers ; then
>                  echo "Required tracer $t is not configured."
>                  exit_unsupported
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
> index 41119e0440e960..04c5dd7d0acc4b 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: event trigger - test field variable support
> -# requires: set_event synthetic_events events/sched/sched_process_fork/hist
> +# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
>  
>  fail() { #msg
>      echo $1
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
> index 9098f1e7433fd0..f7447d800899ac 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: event trigger - test inter-event combined histogram trigger
> -# requires: set_event synthetic_events events/sched/sched_process_fork/hist
> +# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
>  
>  fail() { #msg
>      echo $1
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> index adaabb873ed4ab..91339c1308324b 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: event trigger - test inter-event histogram trigger onchange action
> -# requires: set_event "onchange(var)":README
> +# requires: set_event "onchange(var)":README ping:program
>  
>  fail() { #msg
>      echo $1
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
> index 20e39471052e9a..d645abcf11c4f7 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: event trigger - test inter-event histogram trigger onmatch action
> -# requires: set_event synthetic_events events/sched/sched_process_fork/hist
> +# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
>  
>  fail() { #msg
>      echo $1
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
> index f4b03ab7c28714..c369247efb3501 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: event trigger - test inter-event histogram trigger onmatch-onmax action
> -# requires: set_event synthetic_events events/sched/sched_process_fork/hist
> +# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
>  
>  fail() { #msg
>      echo $1
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
> index 71c9b5911c7067..e28dc5f11b2be0 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: event trigger - test inter-event histogram trigger onmax action
> -# requires: set_event synthetic_events events/sched/sched_process_fork/hist
> +# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
>  
>  fail() { #msg
>      echo $1
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> index 67fa328b830f5f..147967e86584ac 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: event trigger - test inter-event histogram trigger snapshot action
> -# requires: set_event snapshot events/sched/sched_process_fork/hist "onchange(var)":README "snapshot()":README
> +# requires: set_event snapshot events/sched/sched_process_fork/hist "onchange(var)":README "snapshot()":README ping:program
>  
>  fail() { #msg
>      echo $1
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
> index 3d65c856eca3e6..213d890ed1886e 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: event trigger - test inter-event histogram trigger trace action with dynamic string param
> -# requires: set_event synthetic_events events/sched/sched_process_exec/hist "char name[]' >> synthetic_events":README
> +# requires: set_event synthetic_events events/sched/sched_process_exec/hist "char name[]' >> synthetic_events":README ping:program
>  
>  fail() { #msg
>      echo $1
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
> index c126d2350a6d41..d7312047ce2818 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: event trigger - test inter-event histogram trigger trace action
> -# requires: set_event synthetic_events events/sched/sched_process_fork/hist "trace(<synthetic_event>":README
> +# requires: set_event synthetic_events events/sched/sched_process_fork/hist "trace(<synthetic_event>":README ping:program
>  
>  fail() { #msg
>      echo $1
> -- 
> 2.38.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
