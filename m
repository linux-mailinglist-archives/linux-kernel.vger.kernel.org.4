Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167DE62E966
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiKQXQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiKQXQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:16:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E7716EE;
        Thu, 17 Nov 2022 15:16:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE90D622BB;
        Thu, 17 Nov 2022 23:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ADAC433D6;
        Thu, 17 Nov 2022 23:16:25 +0000 (UTC)
Date:   Thu, 17 Nov 2022 18:16:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Steven Rostedt <rostedt@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 2/2] tools lib traceevent: Remove libtraceevent
Message-ID: <20221117181622.3c13bb13@gandalf.local.home>
In-Reply-To: <20221117224952.358639-3-irogers@google.com>
References: <20221117224952.358639-1-irogers@google.com>
        <20221117224952.358639-3-irogers@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 14:49:52 -0800
Ian Rogers <irogers@google.com> wrote:

> libtraceevent is now out-of-date and it is better to depend on the
> system version. Remove this code that is no longer depended upon by
> any builds.
> 

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/traceevent/.gitignore               |    4 -
>  tools/lib/traceevent/Build                    |    8 -
>  tools/lib/traceevent/Documentation/Makefile   |  207 -
>  .../traceevent/Documentation/asciidoc.conf    |  120 -
>  .../Documentation/libtraceevent-commands.txt  |  153 -
>  .../Documentation/libtraceevent-cpus.txt      |   77 -
>  .../libtraceevent-endian_read.txt             |   78 -
>  .../libtraceevent-event_find.txt              |  103 -
>  .../Documentation/libtraceevent-event_get.txt |   99 -
>  .../libtraceevent-event_list.txt              |  122 -
>  .../libtraceevent-event_print.txt             |  130 -
>  .../libtraceevent-field_find.txt              |  118 -
>  .../libtraceevent-field_get_val.txt           |  122 -
>  .../libtraceevent-field_print.txt             |  126 -
>  .../libtraceevent-field_read.txt              |   81 -
>  .../Documentation/libtraceevent-fields.txt    |  105 -
>  .../libtraceevent-file_endian.txt             |   91 -
>  .../Documentation/libtraceevent-filter.txt    |  209 -
>  .../Documentation/libtraceevent-func_apis.txt |  183 -
>  .../Documentation/libtraceevent-func_find.txt |   88 -
>  .../Documentation/libtraceevent-handle.txt    |  101 -
>  .../libtraceevent-header_page.txt             |  102 -
>  .../libtraceevent-host_endian.txt             |  104 -
>  .../Documentation/libtraceevent-long_size.txt |   78 -
>  .../Documentation/libtraceevent-page_size.txt |   82 -
>  .../libtraceevent-parse_event.txt             |   90 -
>  .../libtraceevent-parse_head.txt              |   82 -
>  .../Documentation/libtraceevent-plugins.txt   |  122 -
>  .../libtraceevent-record_parse.txt            |  137 -
>  .../libtraceevent-reg_event_handler.txt       |  156 -
>  .../libtraceevent-reg_print_func.txt          |  155 -
>  .../Documentation/libtraceevent-set_flag.txt  |  104 -
>  .../Documentation/libtraceevent-strerror.txt  |   85 -
>  .../Documentation/libtraceevent-tseq.txt      |  158 -
>  .../Documentation/libtraceevent.txt           |  192 -
>  .../traceevent/Documentation/manpage-1.72.xsl |   14 -
>  .../traceevent/Documentation/manpage-base.xsl |   35 -
>  .../Documentation/manpage-bold-literal.xsl    |   17 -
>  .../Documentation/manpage-normal.xsl          |   13 -
>  .../Documentation/manpage-suppress-sp.xsl     |   21 -
>  tools/lib/traceevent/Makefile                 |  300 -
>  tools/lib/traceevent/event-parse-api.c        |  333 -
>  tools/lib/traceevent/event-parse-local.h      |  123 -
>  tools/lib/traceevent/event-parse.c            | 7624 -----------------
>  tools/lib/traceevent/event-parse.h            |  750 --
>  tools/lib/traceevent/event-plugin.c           |  711 --
>  tools/lib/traceevent/event-utils.h            |   67 -
>  tools/lib/traceevent/kbuffer-parse.c          |  809 --
>  tools/lib/traceevent/kbuffer.h                |   68 -
>  .../lib/traceevent/libtraceevent.pc.template  |   10 -
>  tools/lib/traceevent/parse-filter.c           | 2281 -----
>  tools/lib/traceevent/parse-utils.c            |   71 -
>  tools/lib/traceevent/plugins/Build            |   12 -
>  tools/lib/traceevent/plugins/Makefile         |  225 -
>  .../lib/traceevent/plugins/plugin_cfg80211.c  |   43 -
>  .../lib/traceevent/plugins/plugin_function.c  |  282 -
>  tools/lib/traceevent/plugins/plugin_futex.c   |  123 -
>  tools/lib/traceevent/plugins/plugin_hrtimer.c |   74 -
>  tools/lib/traceevent/plugins/plugin_jbd2.c    |   61 -
>  tools/lib/traceevent/plugins/plugin_kmem.c    |   80 -
>  tools/lib/traceevent/plugins/plugin_kvm.c     |  527 --
>  .../lib/traceevent/plugins/plugin_mac80211.c  |   88 -
>  .../traceevent/plugins/plugin_sched_switch.c  |  146 -
>  tools/lib/traceevent/plugins/plugin_scsi.c    |  434 -
>  tools/lib/traceevent/plugins/plugin_tlb.c     |   66 -
>  tools/lib/traceevent/plugins/plugin_xen.c     |  138 -
>  tools/lib/traceevent/tep_strerror.c           |   53 -
>  tools/lib/traceevent/trace-seq.c              |  249 -
>  tools/lib/traceevent/trace-seq.h              |   55 -
>  69 files changed, 19875 deletions(-)
>  delete mode 100644 tools/lib/traceevent/.gitignore
>  delete mode 100644 tools/lib/traceevent/Build
>  delete mode 100644 tools/lib/traceevent/Documentation/Makefile
>  delete mode 100644 tools/lib/traceevent/Documentation/asciidoc.conf
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-commands.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-cpus.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-endian_read.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_find.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_get.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_list.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_print.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_find.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_get_val.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_print.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_read.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-fields.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-file_endian.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-filter.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-func_find.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-handle.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-header_page.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-long_size.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-page_size.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-parse_event.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-parse_head.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-plugins.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-reg_event_handler.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-reg_print_func.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-set_flag.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-strerror.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-tseq.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent.txt
>  delete mode 100644 tools/lib/traceevent/Documentation/manpage-1.72.xsl
>  delete mode 100644 tools/lib/traceevent/Documentation/manpage-base.xsl
>  delete mode 100644 tools/lib/traceevent/Documentation/manpage-bold-literal.xsl
>  delete mode 100644 tools/lib/traceevent/Documentation/manpage-normal.xsl
>  delete mode 100644 tools/lib/traceevent/Documentation/manpage-suppress-sp.xsl
>  delete mode 100644 tools/lib/traceevent/Makefile
>  delete mode 100644 tools/lib/traceevent/event-parse-api.c
>  delete mode 100644 tools/lib/traceevent/event-parse-local.h
>  delete mode 100644 tools/lib/traceevent/event-parse.c
>  delete mode 100644 tools/lib/traceevent/event-parse.h
>  delete mode 100644 tools/lib/traceevent/event-plugin.c
>  delete mode 100644 tools/lib/traceevent/event-utils.h
>  delete mode 100644 tools/lib/traceevent/kbuffer-parse.c
>  delete mode 100644 tools/lib/traceevent/kbuffer.h
>  delete mode 100644 tools/lib/traceevent/libtraceevent.pc.template
>  delete mode 100644 tools/lib/traceevent/parse-filter.c
>  delete mode 100644 tools/lib/traceevent/parse-utils.c
>  delete mode 100644 tools/lib/traceevent/plugins/Build
>  delete mode 100644 tools/lib/traceevent/plugins/Makefile
>  delete mode 100644 tools/lib/traceevent/plugins/plugin_cfg80211.c
>  delete mode 100644 tools/lib/traceevent/plugins/plugin_function.c
>  delete mode 100644 tools/lib/traceevent/plugins/plugin_futex.c
>  delete mode 100644 tools/lib/traceevent/plugins/plugin_hrtimer.c
>  delete mode 100644 tools/lib/traceevent/plugins/plugin_jbd2.c
>  delete mode 100644 tools/lib/traceevent/plugins/plugin_kmem.c
>  delete mode 100644 tools/lib/traceevent/plugins/plugin_kvm.c
>  delete mode 100644 tools/lib/traceevent/plugins/plugin_mac80211.c
>  delete mode 100644 tools/lib/traceevent/plugins/plugin_sched_switch.c
>  delete mode 100644 tools/lib/traceevent/plugins/plugin_scsi.c
>  delete mode 100644 tools/lib/traceevent/plugins/plugin_tlb.c
>  delete mode 100644 tools/lib/traceevent/plugins/plugin_xen.c
>  delete mode 100644 tools/lib/traceevent/tep_strerror.c
>  delete mode 100644 tools/lib/traceevent/trace-seq.c
>  delete mode 100644 tools/lib/traceevent/trace-seq.h

