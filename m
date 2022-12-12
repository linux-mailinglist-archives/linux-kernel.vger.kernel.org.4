Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9101464A84B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiLLTxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLLTw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:52:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5602AD2;
        Mon, 12 Dec 2022 11:52:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 339D3B80E05;
        Mon, 12 Dec 2022 19:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF256C433EF;
        Mon, 12 Dec 2022 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670874770;
        bh=v7+5fU/TDSWlgm6zLFF+T9b36jVmH+lVw8YHcQgS1qE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fK5Ldm4f7sZn1fJ1CLJIVoyrghEMH347KhE5x23deOzFumvl9hWYE3dOdUhR50mKZ
         oEKfoCKE3bymYcIXPywZIPsjBpZpTlAnvTqs34vlbF3wiL3lQlxZK3wqFUbL/jlRNv
         kqNUt8PbRHWXaHR0wjJ9DpRNxWdiJ+BfaYWK/s52bELWWyNjqvAsdaRvk+m+yfeq+G
         jaWAz8FU7+hwDDL3JbA3W6x6ojDvR/UvPca4l3cka1TkZVD3+wiWhljqRmPBF9qtKj
         s7sQpj0hYCkJ4vXa2Z87x6K9BPz9BcAY5FV1R9KuusM6g6I4xmUNrtshdAGJdYz2Uk
         0zrKTPcrMSimQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 37D2940483; Mon, 12 Dec 2022 16:52:47 -0300 (-03)
Date:   Mon, 12 Dec 2022 16:52:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 4/4] tools lib traceevent: Remove libtraceevent
Message-ID: <Y5eGj4CuQKjr2I6h@kernel.org>
References: <20221130062935.2219247-1-irogers@google.com>
 <20221130062935.2219247-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130062935.2219247-5-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 29, 2022 at 10:29:35PM -0800, Ian Rogers escreveu:
> libtraceevent is now out-of-date and it is better to depend on the
> system version. Remove this code that is no longer depended upon by
> any builds.



Thanks, applied and Added Steven's Acked-by.

- Arnaldo

 
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
> 
> diff --git a/tools/lib/traceevent/.gitignore b/tools/lib/traceevent/.gitignore
> deleted file mode 100644
> index 7123c70b9ebc..000000000000
> --- a/tools/lib/traceevent/.gitignore
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -TRACEEVENT-CFLAGS
> -libtraceevent-dynamic-list
> -libtraceevent.so.*
> diff --git a/tools/lib/traceevent/Build b/tools/lib/traceevent/Build
> deleted file mode 100644
> index f9a5d79578f5..000000000000
> --- a/tools/lib/traceevent/Build
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -libtraceevent-y += event-parse.o
> -libtraceevent-y += event-plugin.o
> -libtraceevent-y += trace-seq.o
> -libtraceevent-y += parse-filter.o
> -libtraceevent-y += parse-utils.o
> -libtraceevent-y += kbuffer-parse.o
> -libtraceevent-y += tep_strerror.o
> -libtraceevent-y += event-parse-api.o
> diff --git a/tools/lib/traceevent/Documentation/Makefile b/tools/lib/traceevent/Documentation/Makefile
> deleted file mode 100644
> index aa72ab96c3c1..000000000000
> --- a/tools/lib/traceevent/Documentation/Makefile
> +++ /dev/null
> @@ -1,207 +0,0 @@
> -include ../../../scripts/Makefile.include
> -include ../../../scripts/utilities.mak
> -
> -# This Makefile and manpage XSL files were taken from tools/perf/Documentation
> -# and modified for libtraceevent.
> -
> -MAN3_TXT= \
> -	$(wildcard libtraceevent-*.txt) \
> -	libtraceevent.txt
> -
> -MAN_TXT = $(MAN3_TXT)
> -_MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
> -_MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
> -_DOC_MAN3=$(patsubst %.txt,%.3,$(MAN3_TXT))
> -
> -MAN_XML=$(addprefix $(OUTPUT),$(_MAN_XML))
> -MAN_HTML=$(addprefix $(OUTPUT),$(_MAN_HTML))
> -DOC_MAN3=$(addprefix $(OUTPUT),$(_DOC_MAN3))
> -
> -# Make the path relative to DESTDIR, not prefix
> -ifndef DESTDIR
> -prefix?=$(HOME)
> -endif
> -bindir?=$(prefix)/bin
> -htmldir?=$(prefix)/share/doc/libtraceevent-doc
> -pdfdir?=$(prefix)/share/doc/libtraceevent-doc
> -mandir?=$(prefix)/share/man
> -man3dir=$(mandir)/man3
> -
> -ASCIIDOC=asciidoc
> -ASCIIDOC_EXTRA = --unsafe -f asciidoc.conf
> -ASCIIDOC_HTML = xhtml11
> -MANPAGE_XSL = manpage-normal.xsl
> -XMLTO_EXTRA =
> -INSTALL?=install
> -RM ?= rm -f
> -
> -ifdef USE_ASCIIDOCTOR
> -ASCIIDOC = asciidoctor
> -ASCIIDOC_EXTRA = -a compat-mode
> -ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
> -ASCIIDOC_EXTRA += -a mansource="libtraceevent" -a manmanual="libtraceevent Manual"
> -ASCIIDOC_HTML = xhtml5
> -endif
> -
> -XMLTO=xmlto
> -
> -_tmp_tool_path := $(call get-executable,$(ASCIIDOC))
> -ifeq ($(_tmp_tool_path),)
> -	missing_tools = $(ASCIIDOC)
> -endif
> -
> -ifndef USE_ASCIIDOCTOR
> -_tmp_tool_path := $(call get-executable,$(XMLTO))
> -ifeq ($(_tmp_tool_path),)
> -	missing_tools += $(XMLTO)
> -endif
> -endif
> -
> -#
> -# For asciidoc ...
> -#	-7.1.2,	no extra settings are needed.
> -#	8.0-,	set ASCIIDOC8.
> -#
> -
> -#
> -# For docbook-xsl ...
> -#	-1.68.1,	set ASCIIDOC_NO_ROFF? (based on changelog from 1.73.0)
> -#	1.69.0,		no extra settings are needed?
> -#	1.69.1-1.71.0,	set DOCBOOK_SUPPRESS_SP?
> -#	1.71.1,		no extra settings are needed?
> -#	1.72.0,		set DOCBOOK_XSL_172.
> -#	1.73.0-,	set ASCIIDOC_NO_ROFF
> -#
> -
> -#
> -# If you had been using DOCBOOK_XSL_172 in an attempt to get rid
> -# of 'the ".ft C" problem' in your generated manpages, and you
> -# instead ended up with weird characters around callouts, try
> -# using ASCIIDOC_NO_ROFF instead (it works fine with ASCIIDOC8).
> -#
> -
> -ifdef ASCIIDOC8
> -ASCIIDOC_EXTRA += -a asciidoc7compatible
> -endif
> -ifdef DOCBOOK_XSL_172
> -ASCIIDOC_EXTRA += -a libtraceevent-asciidoc-no-roff
> -MANPAGE_XSL = manpage-1.72.xsl
> -else
> -	ifdef ASCIIDOC_NO_ROFF
> -	# docbook-xsl after 1.72 needs the regular XSL, but will not
> -	# pass-thru raw roff codes from asciidoc.conf, so turn them off.
> -	ASCIIDOC_EXTRA += -a libtraceevent-asciidoc-no-roff
> -	endif
> -endif
> -ifdef MAN_BOLD_LITERAL
> -XMLTO_EXTRA += -m manpage-bold-literal.xsl
> -endif
> -ifdef DOCBOOK_SUPPRESS_SP
> -XMLTO_EXTRA += -m manpage-suppress-sp.xsl
> -endif
> -
> -SHELL_PATH ?= $(SHELL)
> -# Shell quote;
> -SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
> -
> -DESTDIR ?=
> -DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
> -
> -export DESTDIR DESTDIR_SQ
> -
> -#
> -# Please note that there is a minor bug in asciidoc.
> -# The version after 6.0.3 _will_ include the patch found here:
> -#   http://marc.theaimsgroup.com/?l=libtraceevent&m=111558757202243&w=2
> -#
> -# Until that version is released you may have to apply the patch
> -# yourself - yes, all 6 characters of it!
> -#
> -QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
> -QUIET_SUBDIR1  =
> -
> -ifneq ($(findstring $(MAKEFLAGS),w),w)
> -PRINT_DIR = --no-print-directory
> -else # "make -w"
> -NO_SUBDIR = :
> -endif
> -
> -ifneq ($(findstring $(MAKEFLAGS),s),s)
> -ifneq ($(V),1)
> -	QUIET_ASCIIDOC	= @echo '  ASCIIDOC '$@;
> -	QUIET_XMLTO	= @echo '  XMLTO    '$@;
> -	QUIET_SUBDIR0	= +@subdir=
> -	QUIET_SUBDIR1	= ;$(NO_SUBDIR) \
> -			   echo '  SUBDIR   ' $$subdir; \
> -			  $(MAKE) $(PRINT_DIR) -C $$subdir
> -	export V
> -endif
> -endif
> -
> -all: html man
> -
> -man: man3
> -man3: $(DOC_MAN3)
> -
> -html: $(MAN_HTML)
> -
> -$(MAN_HTML) $(DOC_MAN3): asciidoc.conf
> -
> -install: install-man
> -
> -check-man-tools:
> -ifdef missing_tools
> -	$(error "You need to install $(missing_tools) for man pages")
> -endif
> -
> -do-install-man: man
> -	$(call QUIET_INSTALL, Documentation-man) \
> -		$(INSTALL) -d -m 755 $(DESTDIR)$(man3dir); \
> -		$(INSTALL) -m 644 $(DOC_MAN3) $(DESTDIR)$(man3dir);
> -
> -install-man: check-man-tools man do-install-man
> -
> -uninstall: uninstall-man
> -
> -uninstall-man:
> -	$(call QUIET_UNINST, Documentation-man) \
> -		$(Q)$(RM) $(addprefix $(DESTDIR)$(man3dir)/,$(DOC_MAN3))
> -
> -
> -ifdef missing_tools
> -  DO_INSTALL_MAN = $(warning Please install $(missing_tools) to have the man pages installed)
> -else
> -  DO_INSTALL_MAN = do-install-man
> -endif
> -
> -CLEAN_FILES =					\
> -	$(MAN_XML) $(addsuffix +,$(MAN_XML))	\
> -	$(MAN_HTML) $(addsuffix +,$(MAN_HTML))	\
> -	$(DOC_MAN3) *.3
> -
> -clean:
> -	$(call QUIET_CLEAN, Documentation) $(RM) $(CLEAN_FILES)
> -
> -ifdef USE_ASCIIDOCTOR
> -$(OUTPUT)%.3 : $(OUTPUT)%.txt
> -	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> -	$(ASCIIDOC) -b manpage -d manpage \
> -		$(ASCIIDOC_EXTRA) -alibtraceevent_version=$(EVENT_PARSE_VERSION) -o $@+ $< && \
> -	mv $@+ $@
> -endif
> -
> -$(OUTPUT)%.3 : $(OUTPUT)%.xml
> -	$(QUIET_XMLTO)$(RM) $@ && \
> -	$(XMLTO) -o $(OUTPUT). -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
> -
> -$(OUTPUT)%.xml : %.txt
> -	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> -	$(ASCIIDOC) -b docbook -d manpage \
> -		$(ASCIIDOC_EXTRA) -alibtraceevent_version=$(EVENT_PARSE_VERSION) -o $@+ $< && \
> -	mv $@+ $@
> -
> -$(MAN_HTML): $(OUTPUT)%.html : %.txt
> -	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> -	$(ASCIIDOC) -b $(ASCIIDOC_HTML) -d manpage \
> -		$(ASCIIDOC_EXTRA) -aperf_version=$(EVENT_PARSE_VERSION) -o $@+ $< && \
> -	mv $@+ $@
> diff --git a/tools/lib/traceevent/Documentation/asciidoc.conf b/tools/lib/traceevent/Documentation/asciidoc.conf
> deleted file mode 100644
> index 07595717f06e..000000000000
> --- a/tools/lib/traceevent/Documentation/asciidoc.conf
> +++ /dev/null
> @@ -1,120 +0,0 @@
> -## linktep: macro
> -#
> -# Usage: linktep:command[manpage-section]
> -#
> -# Note, {0} is the manpage section, while {target} is the command.
> -#
> -# Show TEP link as: <command>(<section>); if section is defined, else just show
> -# the command.
> -
> -[macros]
> -(?su)[\\]?(?P<name>linktep):(?P<target>\S*?)\[(?P<attrlist>.*?)\]=
> -
> -[attributes]
> -asterisk=&#42;
> -plus=&#43;
> -caret=&#94;
> -startsb=&#91;
> -endsb=&#93;
> -tilde=&#126;
> -
> -ifdef::backend-docbook[]
> -[linktep-inlinemacro]
> -{0%{target}}
> -{0#<citerefentry>}
> -{0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
> -{0#</citerefentry>}
> -endif::backend-docbook[]
> -
> -ifdef::backend-docbook[]
> -ifndef::tep-asciidoc-no-roff[]
> -# "unbreak" docbook-xsl v1.68 for manpages. v1.69 works with or without this.
> -# v1.72 breaks with this because it replaces dots not in roff requests.
> -[listingblock]
> -<example><title>{title}</title>
> -<literallayout>
> -ifdef::doctype-manpage[]
> -&#10;.ft C&#10;
> -endif::doctype-manpage[]
> -|
> -ifdef::doctype-manpage[]
> -&#10;.ft&#10;
> -endif::doctype-manpage[]
> -</literallayout>
> -{title#}</example>
> -endif::tep-asciidoc-no-roff[]
> -
> -ifdef::tep-asciidoc-no-roff[]
> -ifdef::doctype-manpage[]
> -# The following two small workarounds insert a simple paragraph after screen
> -[listingblock]
> -<example><title>{title}</title>
> -<literallayout>
> -|
> -</literallayout><simpara></simpara>
> -{title#}</example>
> -
> -[verseblock]
> -<formalpara{id? id="{id}"}><title>{title}</title><para>
> -{title%}<literallayout{id? id="{id}"}>
> -{title#}<literallayout>
> -|
> -</literallayout>
> -{title#}</para></formalpara>
> -{title%}<simpara></simpara>
> -endif::doctype-manpage[]
> -endif::tep-asciidoc-no-roff[]
> -endif::backend-docbook[]
> -
> -ifdef::doctype-manpage[]
> -ifdef::backend-docbook[]
> -[header]
> -template::[header-declarations]
> -<refentry>
> -<refmeta>
> -<refentrytitle>{mantitle}</refentrytitle>
> -<manvolnum>{manvolnum}</manvolnum>
> -<refmiscinfo class="source">libtraceevent</refmiscinfo>
> -<refmiscinfo class="version">{libtraceevent_version}</refmiscinfo>
> -<refmiscinfo class="manual">libtraceevent Manual</refmiscinfo>
> -</refmeta>
> -<refnamediv>
> -  <refname>{manname1}</refname>
> -  <refname>{manname2}</refname>
> -  <refname>{manname3}</refname>
> -  <refname>{manname4}</refname>
> -  <refname>{manname5}</refname>
> -  <refname>{manname6}</refname>
> -  <refname>{manname7}</refname>
> -  <refname>{manname8}</refname>
> -  <refname>{manname9}</refname>
> -  <refname>{manname10}</refname>
> -  <refname>{manname11}</refname>
> -  <refname>{manname12}</refname>
> -  <refname>{manname13}</refname>
> -  <refname>{manname14}</refname>
> -  <refname>{manname15}</refname>
> -  <refname>{manname16}</refname>
> -  <refname>{manname17}</refname>
> -  <refname>{manname18}</refname>
> -  <refname>{manname19}</refname>
> -  <refname>{manname20}</refname>
> -  <refname>{manname21}</refname>
> -  <refname>{manname22}</refname>
> -  <refname>{manname23}</refname>
> -  <refname>{manname24}</refname>
> -  <refname>{manname25}</refname>
> -  <refname>{manname26}</refname>
> -  <refname>{manname27}</refname>
> -  <refname>{manname28}</refname>
> -  <refname>{manname29}</refname>
> -  <refname>{manname30}</refname>
> -  <refpurpose>{manpurpose}</refpurpose>
> -</refnamediv>
> -endif::backend-docbook[]
> -endif::doctype-manpage[]
> -
> -ifdef::backend-xhtml11[]
> -[linktep-inlinemacro]
> -<a href="{target}.html">{target}{0?({0})}</a>
> -endif::backend-xhtml11[]
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-commands.txt b/tools/lib/traceevent/Documentation/libtraceevent-commands.txt
> deleted file mode 100644
> index bec552001f8e..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-commands.txt
> +++ /dev/null
> @@ -1,153 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_register_comm, tep_override_comm, tep_pid_is_registered,
> -tep_data_comm_from_pid, tep_data_pid_from_comm, tep_cmdline_pid -
> -Manage pid to process name mappings.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -int *tep_register_comm*(struct tep_handle pass:[*]_tep_, const char pass:[*]_comm_, int _pid_);
> -int *tep_override_comm*(struct tep_handle pass:[*]_tep_, const char pass:[*]_comm_, int _pid_);
> -bool *tep_is_pid_registered*(struct tep_handle pass:[*]_tep_, int _pid_);
> -const char pass:[*]*tep_data_comm_from_pid*(struct tep_handle pass:[*]_pevent_, int _pid_);
> -struct cmdline pass:[*]*tep_data_pid_from_comm*(struct tep_handle pass:[*]_pevent_, const char pass:[*]_comm_, struct cmdline pass:[*]_next_);
> -int *tep_cmdline_pid*(struct tep_handle pass:[*]_pevent_, struct cmdline pass:[*]_cmdline_);
> ---
> -
> -DESCRIPTION
> ------------
> -These functions can be used to handle the mapping between pid and process name.
> -The library builds a cache of these mappings, which is used to display the name
> -of the process, instead of its pid. This information can be retrieved from
> -tracefs/saved_cmdlines file.
> -
> -The _tep_register_comm()_ function registers a _pid_ / process name mapping.
> -If a command with the same _pid_ is already registered, an error is returned.
> -The _pid_ argument is the process ID, the _comm_ argument is the process name,
> -_tep_ is the event context. The _comm_ is duplicated internally.
> -
> -The _tep_override_comm()_ function registers a _pid_ / process name mapping.
> -If a process with the same pid is already registered, the process name string is
> -udapted with the new one. The _pid_ argument is the process ID, the _comm_
> -argument is the process name, _tep_ is the event context. The _comm_ is
> -duplicated internally.
> -
> -The _tep_is_pid_registered()_ function checks if a pid has a process name
> -mapping registered. The _pid_ argument is the process ID, _tep_ is the event
> -context.
> -
> -The _tep_data_comm_from_pid()_ function returns the process name for a given
> -pid. The _pid_ argument is the process ID, _tep_ is the event context.
> -The returned string should not be freed, but will be freed when the _tep_
> -handler is closed.
> -
> -The _tep_data_pid_from_comm()_ function returns a pid for a given process name.
> -The _comm_ argument is the process name, _tep_ is the event context.
> -The argument _next_ is the cmdline structure to search for the next pid.
> -As there may be more than one pid for a given process, the result of this call
> -can be passed back into a recurring call in the _next_ parameter, to search for
> -the next pid. If _next_ is NULL, it will return the first pid associated with
> -the _comm_. The function performs a linear search, so it may be slow.
> -
> -The _tep_cmdline_pid()_ function returns the pid associated with a given
> -_cmdline_. The _tep_ argument is the event context.
> -
> -RETURN VALUE
> -------------
> -_tep_register_comm()_ function returns 0 on success. In case of an error -1 is
> -returned and errno is set to indicate the cause of the problem: ENOMEM, if there
> -is not enough memory to duplicate the _comm_ or EEXIST if a mapping for this
> -_pid_ is already registered.
> -
> -_tep_override_comm()_ function returns 0 on success. In case of an error -1 is
> -returned and errno is set to indicate the cause of the problem: ENOMEM, if there
> -is not enough memory to duplicate the _comm_.
> -
> -_tep_is_pid_registered()_ function returns true if the _pid_ has a process name
> -mapped to it, false otherwise.
> -
> -_tep_data_comm_from_pid()_ function returns the process name as string, or the
> -string "<...>" if there is no mapping for the given pid.
> -
> -_tep_data_pid_from_comm()_ function returns a pointer to a struct cmdline, that
> -holds a pid for a given process, or NULL if none is found. This result can be
> -passed back into a recurring call as the _next_ parameter of the function.
> -
> -_tep_cmdline_pid()_ functions returns the pid for the give cmdline. If _cmdline_
> - is NULL, then -1 is returned.
> -
> -EXAMPLE
> --------
> -The following example registers pid for command "ls", in context of event _tep_
> -and performs various searches for pid / process name mappings:
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -int ret;
> -int ls_pid = 1021;
> -struct tep_handle *tep = tep_alloc();
> -...
> -	ret = tep_register_comm(tep, "ls", ls_pid);
> -	if (ret != 0 && errno == EEXIST)
> -		ret = tep_override_comm(tep, "ls", ls_pid);
> -	if (ret != 0) {
> -		/* Failed to register pid / command mapping */
> -	}
> -...
> -	if (tep_is_pid_registered(tep, ls_pid) == 0) {
> -		/* Command mapping for ls_pid is not registered */
> -	}
> -...
> -	const char *comm = tep_data_comm_from_pid(tep, ls_pid);
> -	if (comm) {
> -		/* Found process name for ls_pid */
> -	}
> -...
> -	int pid;
> -	struct cmdline *cmd = tep_data_pid_from_comm(tep, "ls", NULL);
> -	while (cmd) {
> -		pid = tep_cmdline_pid(tep, cmd);
> -		/* Found pid for process "ls" */
> -		cmd = tep_data_pid_from_comm(tep, "ls", cmd);
> -	}
> ---
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-cpus.txt b/tools/lib/traceevent/Documentation/libtraceevent-cpus.txt
> deleted file mode 100644
> index 5ad70e43b752..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-cpus.txt
> +++ /dev/null
> @@ -1,77 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_get_cpus, tep_set_cpus - Get / set the number of CPUs, which have a tracing
> -buffer representing it. Note, the buffer may be empty.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -int *tep_get_cpus*(struct tep_handle pass:[*]_tep_);
> -void *tep_set_cpus*(struct tep_handle pass:[*]_tep_, int _cpus_);
> ---
> -
> -DESCRIPTION
> ------------
> -The _tep_get_cpus()_ function gets the number of CPUs, which have a tracing
> -buffer representing it. The _tep_ argument is trace event parser context.
> -
> -The _tep_set_cpus()_ function sets the number of CPUs, which have a tracing
> -buffer representing it. The _tep_ argument is trace event parser context.
> -The _cpu_ argument is the number of CPUs with tracing data.
> -
> -RETURN VALUE
> -------------
> -The _tep_get_cpus()_ functions returns the number of CPUs, which have tracing
> -data recorded.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -	tep_set_cpus(tep, 5);
> -...
> -	printf("We have tracing data for %d CPUs", tep_get_cpus(tep));
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-endian_read.txt b/tools/lib/traceevent/Documentation/libtraceevent-endian_read.txt
> deleted file mode 100644
> index e64851b6e189..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-endian_read.txt
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_read_number - Reads a number from raw data.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -unsigned long long *tep_read_number*(struct tep_handle pass:[*]_tep_, const void pass:[*]_ptr_, int _size_);
> ---
> -
> -DESCRIPTION
> ------------
> -The _tep_read_number()_ function reads an integer from raw data, taking into
> -account the endianness of the raw data and the current host. The _tep_ argument
> -is the trace event parser context. The _ptr_ is a pointer to the raw data, where
> -the integer is, and the _size_ is the size of the integer.
> -
> -RETURN VALUE
> -------------
> -The _tep_read_number()_ function returns the integer in the byte order of
> -the current host. In case of an error, 0 is returned.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -void process_record(struct tep_record *record)
> -{
> -	int offset = 24;
> -	int data = tep_read_number(tep, record->data + offset, 4);
> -
> -	/* Read the 4 bytes at the offset 24 of data as an integer */
> -}
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-event_find.txt b/tools/lib/traceevent/Documentation/libtraceevent-event_find.txt
> deleted file mode 100644
> index 7bc062c9f76f..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-event_find.txt
> +++ /dev/null
> @@ -1,103 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_find_event,tep_find_event_by_name,tep_find_event_by_record -
> -Find events by given key.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -struct tep_event pass:[*]*tep_find_event*(struct tep_handle pass:[*]_tep_, int _id_);
> -struct tep_event pass:[*]*tep_find_event_by_name*(struct tep_handle pass:[*]_tep_, const char pass:[*]_sys_, const char pass:[*]_name_);
> -struct tep_event pass:[*]*tep_find_event_by_record*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_record_);
> ---
> -
> -DESCRIPTION
> ------------
> -This set of functions can be used to search for an event, based on a given
> -criteria. All functions require a pointer to a _tep_, trace event parser
> -context.
> -
> -The _tep_find_event()_ function searches for an event by given event _id_. The
> -event ID is assigned dynamically and can be viewed in event's format file,
> -"ID" field.
> -
> -The tep_find_event_by_name()_ function searches for an event by given
> -event _name_, under the system _sys_. If the _sys_ is NULL (not specified),
> -the first event with _name_ is returned.
> -
> -The tep_find_event_by_record()_ function searches for an event from a given
> -_record_.
> -
> -RETURN VALUE
> -------------
> -All these functions return a pointer to the found event, or NULL if there is no
> -such event.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -struct tep_event *event;
> -
> -event = tep_find_event(tep, 1857);
> -if (event == NULL) {
> -	/* There is no event with ID 1857 */
> -}
> -
> -event = tep_find_event_by_name(tep, "kvm", "kvm_exit");
> -if (event == NULL) {
> -	/* There is no kvm_exit event, from kvm system */
> -}
> -
> -void event_from_record(struct tep_record *record)
> -{
> - struct tep_event *event = tep_find_event_by_record(tep, record);
> -	if (event == NULL) {
> -		/* There is no event from given record */
> -	}
> -}
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-event_get.txt b/tools/lib/traceevent/Documentation/libtraceevent-event_get.txt
> deleted file mode 100644
> index 6525092fc417..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-event_get.txt
> +++ /dev/null
> @@ -1,99 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_get_event, tep_get_first_event, tep_get_events_count - Access events.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -struct tep_event pass:[*]*tep_get_event*(struct tep_handle pass:[*]_tep_, int _index_);
> -struct tep_event pass:[*]*tep_get_first_event*(struct tep_handle pass:[*]_tep_);
> -int *tep_get_events_count*(struct tep_handle pass:[*]_tep_);
> ---
> -
> -DESCRIPTION
> ------------
> -The _tep_get_event()_ function returns a pointer to event at the given _index_.
> -The _tep_ argument is trace event parser context, the _index_ is the index of
> -the requested event.
> -
> -The _tep_get_first_event()_ function returns a pointer to the first event.
> -As events are stored in an array, this function returns the pointer to the
> -beginning of the array. The _tep_ argument is trace event parser context.
> -
> -The _tep_get_events_count()_ function returns the number of the events
> -in the array. The _tep_ argument is trace event parser context.
> -
> -RETURN VALUE
> -------------
> -The _tep_get_event()_ returns a pointer to the event located at _index_.
> -NULL is returned in case of error, in case there are no events or _index_ is
> -out of range.
> -
> -The _tep_get_first_event()_ returns a pointer to the first event. NULL is
> -returned in case of error, or in case there are no events.
> -
> -The _tep_get_events_count()_ returns the number of the events. 0 is
> -returned in case of error, or in case there are no events.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -int i,count = tep_get_events_count(tep);
> -struct tep_event *event, *events = tep_get_first_event(tep);
> -
> -if (events == NULL) {
> -	/* There are no events */
> -} else {
> -	for (i = 0; i < count; i++) {
> -		event = (events+i);
> -		/* process events[i] */
> -	}
> -
> -	/* Get the last event */
> -	event = tep_get_event(tep, count-1);
> -}
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-event_list.txt b/tools/lib/traceevent/Documentation/libtraceevent-event_list.txt
> deleted file mode 100644
> index fba350e5a4cb..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-event_list.txt
> +++ /dev/null
> @@ -1,122 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_list_events, tep_list_events_copy -
> -Get list of events, sorted by given criteria.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -enum *tep_event_sort_type* {
> -	_TEP_EVENT_SORT_ID_,
> -	_TEP_EVENT_SORT_NAME_,
> -	_TEP_EVENT_SORT_SYSTEM_,
> -};
> -
> -struct tep_event pass:[*]pass:[*]*tep_list_events*(struct tep_handle pass:[*]_tep_, enum tep_event_sort_type _sort_type_);
> -struct tep_event pass:[*]pass:[*]*tep_list_events_copy*(struct tep_handle pass:[*]_tep_, enum tep_event_sort_type _sort_type_);
> ---
> -
> -DESCRIPTION
> ------------
> -The _tep_list_events()_ function returns an array of pointers to the events,
> -sorted by the _sort_type_ criteria. The last element of the array is NULL.
> -The returned memory must not be freed, it is managed by the library.
> -The function is not thread safe. The _tep_ argument is trace event parser
> -context. The _sort_type_ argument is the required sort criteria:
> -[verse]
> ---
> -	_TEP_EVENT_SORT_ID_	- sort by the event ID.
> -	_TEP_EVENT_SORT_NAME_	- sort by the event (name, system, id) triplet.
> -	_TEP_EVENT_SORT_SYSTEM_	- sort by the event (system, name, id) triplet.
> ---
> -
> -The _tep_list_events_copy()_ is a thread safe version of _tep_list_events()_.
> -It has the same behavior, but the returned array is allocated internally and
> -must be freed by the caller. Note that the content of the array must not be
> -freed (see the EXAMPLE below).
> -
> -RETURN VALUE
> -------------
> -The _tep_list_events()_ function returns an array of pointers to events.
> -In case of an error, NULL is returned. The returned array must not be freed,
> -it is managed by the library.
> -
> -The _tep_list_events_copy()_ function returns an array of pointers to events.
> -In case of an error, NULL is returned. The returned array must be freed by
> -the caller.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -int i;
> -struct tep_event_format **events;
> -
> -i=0;
> -events = tep_list_events(tep, TEP_EVENT_SORT_ID);
> -if (events == NULL) {
> -	/* Failed to get the events, sorted by ID */
> -} else {
> -	while(events[i]) {
> -		/* walk through the list of the events, sorted by ID */
> -		i++;
> -	}
> -}
> -
> -i=0;
> -events = tep_list_events_copy(tep, TEP_EVENT_SORT_NAME);
> -if (events == NULL) {
> -	/* Failed to get the events, sorted by name */
> -} else {
> -	while(events[i]) {
> -		/* walk through the list of the events, sorted by name */
> -		i++;
> -	}
> -	free(events);
> -}
> -
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-event_print.txt b/tools/lib/traceevent/Documentation/libtraceevent-event_print.txt
> deleted file mode 100644
> index 2c6a61811118..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-event_print.txt
> +++ /dev/null
> @@ -1,130 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_print_event - Writes event information into a trace sequence.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -*#include <trace-seq.h>*
> -
> -void *tep_print_event*(struct tep_handle pass:[*]_tep_, struct trace_seqpass:[*]_s_, struct tep_record pass:[*]_record_, const char pass:[*]_fmt_, _..._)
> ---
> -
> -DESCRIPTION
> ------------
> -
> -The _tep_print_event()_ function parses the event information of the given
> -_record_ and writes it into the trace sequence _s_, according to the format
> -string _fmt_. The desired information is specified after the format string.
> -The _fmt_ is printf-like format string, following arguments are supported:
> -[verse]
> ---
> -	TEP_PRINT_PID, "%d"  - PID of the event.
> -	TEP_PRINT_CPU, "%d"  - Event CPU.
> -	TEP_PRINT_COMM, "%s" - Event command string.
> -	TEP_PRINT_NAME, "%s" - Event name.
> -	TEP_PRINT_LATENCY, "%s" - Latency of the event. It prints 4 or more
> -			fields - interrupt state, scheduling state,
> -			current context, and preemption count.
> -			Field 1 is the interrupt enabled state:
> -				d : Interrupts are disabled
> -				. : Interrupts are enabled
> -				X : The architecture does not support this
> -				    information
> -			Field 2 is the "need resched" state.
> -				N : The task is set to call the scheduler when
> -				    possible, as another higher priority task
> -				    may need to be scheduled in.
> -				. : The task is not set to call the scheduler.
> -			Field 3 is the context state.
> -				. : Normal context
> -				s : Soft interrupt context
> -				h : Hard interrupt context
> -				H : Hard interrupt context which triggered
> -				    during soft interrupt context.
> -				z : NMI context
> -				Z : NMI context which triggered during hard
> -				    interrupt context
> -			Field 4 is the preemption count.
> -				. : The preempt count is zero.
> -			On preemptible kernels (where the task can be scheduled
> -			out in arbitrary locations while in kernel context), the
> -			preempt count, when non zero, will prevent the kernel
> -			from scheduling out the current task. The preempt count
> -			number is displayed when it is not zero.
> -			Depending on the kernel, it may show other fields
> -			(lock depth, or migration disabled, which are unique to
> -			specialized kernels).
> -	TEP_PRINT_TIME, %d - event time stamp. A divisor and precision can be
> -			specified as part of this format string:
> -			"%precision.divisord". Example:
> -			"%3.1000d" - divide the time by 1000 and print the first
> -			3 digits before the dot. Thus, the time stamp
> -			"123456000" will be printed as "123.456"
> -	TEP_PRINT_INFO, "%s" - event information.
> -	TEP_PRINT_INFO_RAW, "%s" - event information, in raw format.
> -
> ---
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -#include <trace-seq.h>
> -...
> -struct trace_seq seq;
> -trace_seq_init(&seq);
> -struct tep_handle *tep = tep_alloc();
> -...
> -void print_my_event(struct tep_record *record)
> -{
> -	trace_seq_reset(&seq);
> -	tep_print_event(tep, s, record, "%16s-%-5d [%03d] %s %6.1000d %s %s",
> -			TEP_PRINT_COMM, TEP_PRINT_PID, TEP_PRINT_CPU,
> -			TEP_PRINT_LATENCY, TEP_PRINT_TIME, TEP_PRINT_NAME,
> -			TEP_PRINT_INFO);
> -}
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*trace-seq.h*
> -	Header file to include in order to have access to trace sequences related APIs.
> -	Trace sequences are used to allow a function to call several other functions
> -	to create a string of data to use.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-field_find.txt b/tools/lib/traceevent/Documentation/libtraceevent-field_find.txt
> deleted file mode 100644
> index 0896af5b9eff..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-field_find.txt
> +++ /dev/null
> @@ -1,118 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_find_common_field, tep_find_field, tep_find_any_field -
> -Search for a field in an event.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -struct tep_format_field pass:[*]*tep_find_common_field*(struct tep_event pass:[*]_event_, const char pass:[*]_name_);
> -struct tep_format_field pass:[*]*tep_find_field*(struct tep_event_ormat pass:[*]_event_, const char pass:[*]_name_);
> -struct tep_format_field pass:[*]*tep_find_any_field*(struct tep_event pass:[*]_event_, const char pass:[*]_name_);
> ---
> -
> -DESCRIPTION
> ------------
> -These functions search for a field with given name in an event. The field
> -returned can be used to find the field content from within a data record.
> -
> -The _tep_find_common_field()_ function searches for a common field with _name_
> -in the _event_.
> -
> -The _tep_find_field()_ function searches for an event specific field with
> -_name_ in the _event_.
> -
> -The _tep_find_any_field()_ function searches for any field with _name_ in the
> -_event_.
> -
> -RETURN VALUE
> -------------
> -The _tep_find_common_field(), _tep_find_field()_ and _tep_find_any_field()_
> -functions return a pointer to the found field, or NULL in case there is no field
> -with the requested name.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -void get_htimer_info(struct tep_handle *tep, struct tep_record *record)
> -{
> -	struct tep_format_field *field;
> -	struct tep_event *event;
> -	long long softexpires;
> -	int mode;
> -	int pid;
> -
> -	event = tep_find_event_by_name(tep, "timer", "hrtimer_start");
> -
> -	field = tep_find_common_field(event, "common_pid");
> -	if (field == NULL) {
> -		/* Cannot find "common_pid" field in the event */
> -	} else {
> -		/* Get pid from the data record */
> -		pid = tep_read_number(tep, record->data + field->offset,
> -				      field->size);
> -	}
> -
> -	field = tep_find_field(event, "softexpires");
> -	if (field == NULL) {
> -		/* Cannot find "softexpires" event specific field in the event */
> -	} else {
> -		/* Get softexpires parameter from the data record */
> -		softexpires = tep_read_number(tep, record->data + field->offset,
> -					      field->size);
> -	}
> -
> -	field = tep_find_any_field(event, "mode");
> -	if (field == NULL) {
> -		/* Cannot find "mode" field in the event */
> -	} else
> -	{
> -		/* Get mode parameter from the data record */
> -		mode = tep_read_number(tep, record->data + field->offset,
> -				       field->size);
> -	}
> -}
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-field_get_val.txt b/tools/lib/traceevent/Documentation/libtraceevent-field_get_val.txt
> deleted file mode 100644
> index 6324f0d48aeb..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-field_get_val.txt
> +++ /dev/null
> @@ -1,122 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_get_any_field_val, tep_get_common_field_val, tep_get_field_val,
> -tep_get_field_raw - Get value of a field.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -*#include <trace-seq.h>*
> -
> -int *tep_get_any_field_val*(struct trace_seq pass:[*]_s_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, unsigned long long pass:[*]_val_, int _err_);
> -int *tep_get_common_field_val*(struct trace_seq pass:[*]_s_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, unsigned long long pass:[*]_val_, int _err_);
> -int *tep_get_field_val*(struct trace_seq pass:[*]_s_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, unsigned long long pass:[*]_val_, int _err_);
> -void pass:[*]*tep_get_field_raw*(struct trace_seq pass:[*]_s_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, int pass:[*]_len_, int _err_);
> ---
> -
> -DESCRIPTION
> ------------
> -These functions can be used to find a field and retrieve its value.
> -
> -The _tep_get_any_field_val()_ function searches in the _record_ for a field
> -with _name_, part of the _event_. If the field is found, its value is stored in
> -_val_. If there is an error and _err_ is not zero, then an error string is
> -written into _s_.
> -
> -The _tep_get_common_field_val()_ function does the same as
> -_tep_get_any_field_val()_, but searches only in the common fields. This works
> -for any event as all events include the common fields.
> -
> -The _tep_get_field_val()_ function does the same as _tep_get_any_field_val()_,
> -but searches only in the event specific fields.
> -
> -The _tep_get_field_raw()_ function searches in the _record_ for a field with
> -_name_, part of the _event_. If the field is found, a pointer to where the field
> -exists in the record's raw data is returned. The size of the data is stored in
> -_len_. If there is an error and _err_ is not zero, then an error string is
> -written into _s_.
> -
> -RETURN VALUE
> -------------
> -The _tep_get_any_field_val()_, _tep_get_common_field_val()_ and
> -_tep_get_field_val()_ functions return 0 on success, or -1 in case of an error.
> -
> -The _tep_get_field_raw()_ function returns a pointer to field's raw data, and
> -places the length of this data in _len_. In case of an error NULL is returned.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -#include <trace-seq.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -struct tep_event *event = tep_find_event_by_name(tep, "kvm", "kvm_exit");
> -...
> -void process_record(struct tep_record *record)
> -{
> -	int len;
> -	char *comm;
> -	struct tep_event_format *event;
> -	unsigned long long val;
> -
> -	event = tep_find_event_by_record(pevent, record);
> -	if (event != NULL) {
> -		if (tep_get_common_field_val(NULL, event, "common_type",
> -					     record, &val, 0) == 0) {
> -			/* Got the value of common type field */
> -		}
> -		if (tep_get_field_val(NULL, event, "pid", record, &val, 0) == 0) {
> -			/* Got the value of pid specific field */
> -		}
> -		comm = tep_get_field_raw(NULL, event, "comm", record, &len, 0);
> -		if (comm != NULL) {
> -			/* Got a pointer to the comm event specific field */
> -		}
> -	}
> -}
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*trace-seq.h*
> -	Header file to include in order to have access to trace sequences
> -	related APIs. Trace sequences are used to allow a function to call
> -	several other functions to create a string of data to use.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-field_print.txt b/tools/lib/traceevent/Documentation/libtraceevent-field_print.txt
> deleted file mode 100644
> index 9a9df98ac44d..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-field_print.txt
> +++ /dev/null
> @@ -1,126 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_print_field, tep_print_fields, tep_print_num_field, tep_print_func_field -
> -Print the field content.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -*#include <trace-seq.h>*
> -
> -void *tep_print_field*(struct trace_seq pass:[*]_s_, void pass:[*]_data_, struct tep_format_field pass:[*]_field_);
> -void *tep_print_fields*(struct trace_seq pass:[*]_s_, void pass:[*]_data_, int _size_, struct tep_event pass:[*]_event_);
> -int *tep_print_num_field*(struct trace_seq pass:[*]_s_, const char pass:[*]_fmt_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, int _err_);
> -int *tep_print_func_field*(struct trace_seq pass:[*]_s_, const char pass:[*]_fmt_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, int _err_);
> ---
> -
> -DESCRIPTION
> ------------
> -These functions print recorded field's data, according to the field's type.
> -
> -The _tep_print_field()_ function extracts from the recorded raw _data_ value of
> -the _field_ and prints it into _s_, according to the field type.
> -
> -The _tep_print_fields()_ prints each field name followed by the record's field
> -value according to the field's type:
> -[verse]
> ---
> -"field1_name=field1_value field2_name=field2_value ..."
> ---
> -It iterates all fields of the _event_, and calls _tep_print_field()_ for each of
> -them.
> -
> -The _tep_print_num_field()_ function prints a numeric field with given format
> -string. A search is performed in the _event_ for a field with _name_. If such
> -field is found, its value is extracted from the _record_ and is printed in the
> -_s_, according to the given format string _fmt_. If the argument _err_ is
> -non-zero, and an error occures - it is printed in the _s_.
> -
> -The _tep_print_func_field()_ function prints a function field with given format
> -string.  A search is performed in the _event_ for a field with _name_. If such
> -field is found, its value is extracted from the _record_. The value is assumed
> -to be a function address, and a search is perform to find the name of this
> -function. The function name (if found) and its address are printed in the _s_,
> -according to the given format string _fmt_. If the argument _err_ is non-zero,
> -and an error occures - it is printed in _s_.
> -
> -RETURN VALUE
> -------------
> -The _tep_print_num_field()_ and _tep_print_func_field()_ functions return 1
> -on success, -1 in case of an error or 0 if the print buffer _s_ is full.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -#include <trace-seq.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -struct trace_seq seq;
> -trace_seq_init(&seq);
> -struct tep_event *event = tep_find_event_by_name(tep, "timer", "hrtimer_start");
> -...
> -void process_record(struct tep_record *record)
> -{
> -	struct tep_format_field *field_pid = tep_find_common_field(event, "common_pid");
> -
> -	trace_seq_reset(&seq);
> -
> -	/* Print the value of "common_pid" */
> -	tep_print_field(&seq, record->data, field_pid);
> -
> -	/* Print all fields of the "hrtimer_start" event */
> -	tep_print_fields(&seq, record->data, record->size, event);
> -
> -	/* Print the value of "expires" field with custom format string */
> -	tep_print_num_field(&seq, " timer expires in %llu ", event, "expires", record, 0);
> -
> -	/* Print the address and the name of "function" field with custom format string */
> -	tep_print_func_field(&seq, " timer function is %s ", event, "function", record, 0);
> - }
> - ...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*trace-seq.h*
> -	Header file to include in order to have access to trace sequences related APIs.
> -	Trace sequences are used to allow a function to call several other functions
> -	to create a string of data to use.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-field_read.txt b/tools/lib/traceevent/Documentation/libtraceevent-field_read.txt
> deleted file mode 100644
> index 64e9e25d3fd9..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-field_read.txt
> +++ /dev/null
> @@ -1,81 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_read_number_field - Reads a number from raw data.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -int *tep_read_number_field*(struct tep_format_field pass:[*]_field_, const void pass:[*]_data_, unsigned long long pass:[*]_value_);
> ---
> -
> -DESCRIPTION
> ------------
> -The _tep_read_number_field()_ function reads the value of the _field_ from the
> -raw _data_ and stores it in the _value_. The function sets the _value_ according
> -to the endianness of the raw data and the current machine and stores it in
> -_value_.
> -
> -RETURN VALUE
> -------------
> -The _tep_read_number_field()_ function retunrs 0 in case of success, or -1 in
> -case of an error.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -struct tep_event *event = tep_find_event_by_name(tep, "timer", "hrtimer_start");
> -...
> -void process_record(struct tep_record *record)
> -{
> -	unsigned long long pid;
> -	struct tep_format_field *field_pid = tep_find_common_field(event, "common_pid");
> -
> -	if (tep_read_number_field(field_pid, record->data, &pid) != 0) {
> -		/* Failed to get "common_pid" value */
> -	}
> -}
> -...
> ---
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-fields.txt b/tools/lib/traceevent/Documentation/libtraceevent-fields.txt
> deleted file mode 100644
> index 1ccb531d5114..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-fields.txt
> +++ /dev/null
> @@ -1,105 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_event_common_fields, tep_event_fields - Get a list of fields for an event.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -struct tep_format_field pass:[*]pass:[*]*tep_event_common_fields*(struct tep_event pass:[*]_event_);
> -struct tep_format_field pass:[*]pass:[*]*tep_event_fields*(struct tep_event pass:[*]_event_);
> ---
> -
> -DESCRIPTION
> ------------
> -The _tep_event_common_fields()_ function returns an array of pointers to common
> -fields for the _event_. The array is allocated in the function and must be freed
> -by free(). The last element of the array is NULL.
> -
> -The _tep_event_fields()_ function returns an array of pointers to event specific
> -fields for the _event_. The array is allocated in the function and must be freed
> -by free(). The last element of the array is NULL.
> -
> -RETURN VALUE
> -------------
> -Both _tep_event_common_fields()_ and _tep_event_fields()_ functions return
> -an array of pointers to tep_format_field structures in case of success, or
> -NULL in case of an error.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -int i;
> -struct tep_format_field **fields;
> -struct tep_event *event = tep_find_event_by_name(tep, "kvm", "kvm_exit");
> -if (event != NULL) {
> -	fields = tep_event_common_fields(event);
> -	if (fields != NULL) {
> -		i = 0;
> -		while (fields[i]) {
> -			/*
> -			  walk through the list of the common fields
> -			  of the kvm_exit event
> -			*/
> -			i++;
> -		}
> -		free(fields);
> -	}
> -	fields = tep_event_fields(event);
> -	if (fields != NULL) {
> -		i = 0;
> -		while (fields[i]) {
> -			/*
> -			  walk through the list of the event specific
> -			  fields of the kvm_exit event
> -			*/
> -			i++;
> -		}
> -		free(fields);
> -	}
> -}
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-file_endian.txt b/tools/lib/traceevent/Documentation/libtraceevent-file_endian.txt
> deleted file mode 100644
> index f401ad311047..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-file_endian.txt
> +++ /dev/null
> @@ -1,91 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_is_file_bigendian, tep_set_file_bigendian - Get / set the endianness of the
> -raw data being accessed by the tep handler.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -enum *tep_endian* {
> -	TEP_LITTLE_ENDIAN = 0,
> -	TEP_BIG_ENDIAN
> -};
> -
> -bool *tep_is_file_bigendian*(struct tep_handle pass:[*]_tep_);
> -void *tep_set_file_bigendian*(struct tep_handle pass:[*]_tep_, enum tep_endian _endian_);
> -
> ---
> -DESCRIPTION
> ------------
> -The _tep_is_file_bigendian()_ function gets the endianness of the raw data,
> -being accessed by the tep handler. The _tep_ argument is trace event parser
> -context.
> -
> -The _tep_set_file_bigendian()_ function sets the endianness of raw data being
> -accessed by the tep handler. The _tep_ argument is trace event parser context.
> -[verse]
> ---
> -The _endian_ argument is the endianness:
> -	_TEP_LITTLE_ENDIAN_ - the raw data is in little endian format,
> -	_TEP_BIG_ENDIAN_ - the raw data is in big endian format.
> ---
> -RETURN VALUE
> -------------
> -The _tep_is_file_bigendian()_ function returns true if the data is in bigendian
> -format, false otherwise.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -	tep_set_file_bigendian(tep, TEP_LITTLE_ENDIAN);
> -...
> -	if (tep_is_file_bigendian(tep)) {
> -		/* The raw data is in big endian */
> -	} else {
> -		/* The raw data is in little endian */
> -	}
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-filter.txt b/tools/lib/traceevent/Documentation/libtraceevent-filter.txt
> deleted file mode 100644
> index 4a9962d8cb59..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-filter.txt
> +++ /dev/null
> @@ -1,209 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_filter_alloc, tep_filter_free, tep_filter_reset, tep_filter_make_string,
> -tep_filter_copy, tep_filter_compare, tep_filter_match, tep_event_filtered,
> -tep_filter_remove_event, tep_filter_strerror, tep_filter_add_filter_str -
> -Event filter related APIs.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -struct tep_event_filter pass:[*]*tep_filter_alloc*(struct tep_handle pass:[*]_tep_);
> -void *tep_filter_free*(struct tep_event_filter pass:[*]_filter_);
> -void *tep_filter_reset*(struct tep_event_filter pass:[*]_filter_);
> -enum tep_errno *tep_filter_add_filter_str*(struct tep_event_filter pass:[*]_filter_, const char pass:[*]_filter_str_);
> -int *tep_event_filtered*(struct tep_event_filter pass:[*]_filter_, int _event_id_);
> -int *tep_filter_remove_event*(struct tep_event_filter pass:[*]_filter_, int _event_id_);
> -enum tep_errno *tep_filter_match*(struct tep_event_filter pass:[*]_filter_, struct tep_record pass:[*]_record_);
> -int *tep_filter_copy*(struct tep_event_filter pass:[*]_dest_, struct tep_event_filter pass:[*]_source_);
> -int *tep_filter_compare*(struct tep_event_filter pass:[*]_filter1_, struct tep_event_filter pass:[*]_filter2_);
> -char pass:[*]*tep_filter_make_string*(struct tep_event_filter pass:[*]_filter_, int _event_id_);
> -int *tep_filter_strerror*(struct tep_event_filter pass:[*]_filter_, enum tep_errno _err_, char pass:[*]buf, size_t _buflen_);
> ---
> -
> -DESCRIPTION
> ------------
> -Filters can be attached to traced events. They can be used to filter out various
> -events when outputting them. Each event can be filtered based on its parameters,
> -described in the event's format file. This set of functions can be used to
> -create, delete, modify and attach event filters.
> -
> -The _tep_filter_alloc()_ function creates a new event filter. The _tep_ argument
> -is the trace event parser context.
> -
> -The _tep_filter_free()_ function frees an event filter and all resources that it
> -had used.
> -
> -The _tep_filter_reset()_ function removes all rules from an event filter and
> -resets it.
> -
> -The _tep_filter_add_filter_str()_ function adds a new rule to the _filter_. The
> -_filter_str_ argument is the filter string, that contains the rule.
> -
> -The _tep_event_filtered()_ function checks if the event with _event_id_ has
> -_filter_.
> -
> -The _tep_filter_remove_event()_ function removes a _filter_ for an event with
> -_event_id_.
> -
> -The _tep_filter_match()_ function tests if a _record_ matches given _filter_.
> -
> -The _tep_filter_copy()_ function copies a _source_ filter into a _dest_ filter.
> -
> -The _tep_filter_compare()_ function compares two filers - _filter1_ and _filter2_.
> -
> -The _tep_filter_make_string()_ function constructs a string, displaying
> -the _filter_ contents for given _event_id_.
> -
> -The _tep_filter_strerror()_ function copies the _filter_ error buffer into the
> -given _buf_ with the size _buflen_. If the error buffer is empty, in the _buf_
> -is copied a string, describing the error _err_.
> -
> -RETURN VALUE
> -------------
> -The _tep_filter_alloc()_ function returns a pointer to the newly created event
> -filter, or NULL in case of an error.
> -
> -The _tep_filter_add_filter_str()_ function returns 0 if the rule was
> -successfully added or a negative error code.  Use _tep_filter_strerror()_ to see
> -actual error message in case of an error.
> -
> -The _tep_event_filtered()_ function returns 1 if the filter is found for given
> -event, or 0 otherwise.
> -
> -The _tep_filter_remove_event()_ function returns 1 if the vent was removed, or
> -0 if the event was not found.
> -
> -The _tep_filter_match()_ function returns _tep_errno_, according to the result:
> -[verse]
> ---
> -_pass:[TEP_ERRNO__FILTER_MATCH]_	- filter found for event, the record matches.
> -_pass:[TEP_ERRNO__FILTER_MISS]_		- filter found for event, the record does not match.
> -_pass:[TEP_ERRNO__FILTER_NOT_FOUND]_	- no filter found for record's event.
> -_pass:[TEP_ERRNO__NO_FILTER]_		- no rules in the filter.
> ---
> -or any other _tep_errno_, if an error occurred during the test.
> -
> -The _tep_filter_copy()_ function returns 0 on success or -1 if not all rules
> - were copied.
> -
> -The _tep_filter_compare()_ function returns 1 if the two filters hold the same
> -content, or 0 if they do not.
> -
> -The _tep_filter_make_string()_ function returns a string, which must be freed
> -with free(), or NULL in case of an error.
> -
> -The _tep_filter_strerror()_ function returns 0 if message was filled
> -successfully, or -1 in case of an error.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -char errstr[200];
> -int ret;
> -
> -struct tep_event_filter *filter = tep_filter_alloc(tep);
> -struct tep_event_filter *filter1 = tep_filter_alloc(tep);
> -ret = tep_filter_add_filter_str(filter, "sched/sched_wakeup:target_cpu==1");
> -if(ret < 0) {
> -	tep_filter_strerror(filter, ret, errstr, sizeof(errstr));
> -	/* Failed to add a new rule to the filter, the error string is in errstr */
> -}
> -if (tep_filter_copy(filter1, filter) != 0) {
> -	/* Failed to copy filter in filter1 */
> -}
> -...
> -if (tep_filter_compare(filter, filter1) != 1) {
> -	/* Both filters are different */
> -}
> -...
> -void process_record(struct tep_handle *tep, struct tep_record *record)
> -{
> -	struct tep_event *event;
> -	char *fstring;
> -
> -	event = tep_find_event_by_record(tep, record);
> -
> -	if (tep_event_filtered(filter, event->id) == 1) {
> -		/* The event has filter */
> -		fstring = tep_filter_make_string(filter, event->id);
> -		if (fstring != NULL) {
> -			/* The filter for the event is in fstring */
> -			free(fstring);
> -		}
> -	}
> -
> -	switch (tep_filter_match(filter, record)) {
> -	case TEP_ERRNO__FILTER_MATCH:
> -		/* The filter matches the record */
> -		break;
> -	case TEP_ERRNO__FILTER_MISS:
> -		/* The filter does not match the record */
> -		break;
> -	case TEP_ERRNO__FILTER_NOT_FOUND:
> -		/* No filter found for record's event */
> -		break;
> -	case TEP_ERRNO__NO_FILTER:
> -		/* There are no rules in the filter */
> -		break
> -	default:
> -		/* An error occurred during the test */
> -		break;
> -	}
> -
> -	if (tep_filter_remove_event(filter, event->id) == 1) {
> -		/* The event was removed from the filter */
> -	}
> -}
> -
> -...
> -tep_filter_reset(filter);
> -...
> -tep_filter_free(filter);
> -tep_filter_free(filter1);
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt b/tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt
> deleted file mode 100644
> index f6aca0df2151..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt
> +++ /dev/null
> @@ -1,183 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_find_function, tep_find_function_address, tep_set_function_resolver,
> -tep_reset_function_resolver, tep_register_function, tep_register_print_string -
> -function related tep APIs
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -typedef char pass:[*](*tep_func_resolver_t*)(void pass:[*]_priv_, unsigned long long pass:[*]_addrp_, char pass:[**]_modp_);
> -int *tep_set_function_resolver*(struct tep_handle pass:[*]_tep_, tep_func_resolver_t pass:[*]_func_, void pass:[*]_priv_);
> -void *tep_reset_function_resolver*(struct tep_handle pass:[*]_tep_);
> -const char pass:[*]*tep_find_function*(struct tep_handle pass:[*]_tep_, unsigned long long _addr_);
> -unsigned long long *tep_find_function_address*(struct tep_handle pass:[*]_tep_, unsigned long long _addr_);
> -int *tep_register_function*(struct tep_handle pass:[*]_tep_, char pass:[*]_name_, unsigned long long _addr_, char pass:[*]_mod_);
> -int *tep_register_print_string*(struct tep_handle pass:[*]_tep_, const char pass:[*]_fmt_, unsigned long long _addr_);
> ---
> -
> -DESCRIPTION
> ------------
> -Some tools may have already a way to resolve the kernel functions. These APIs
> -allow them to keep using it instead of duplicating all the entries inside.
> -
> -The _tep_func_resolver_t_ type is the prototype of the alternative kernel
> -functions resolver. This function receives a pointer to its custom context
> -(set with the _tep_set_function_resolver()_ call ) and the address of a kernel
> -function, which has to be resolved. In case of success, it should return
> -the name of the function and its module (if any) in _modp_.
> -
> -The _tep_set_function_resolver()_ function registers _func_ as an alternative
> -kernel functions resolver. The _tep_ argument is trace event parser context.
> -The _priv_ argument is a custom context of the _func_ function. The function
> -resolver is used by the APIs _tep_find_function()_,
> -_tep_find_function_address()_, and _tep_print_func_field()_ to resolve
> -a function address to a function name.
> -
> -The _tep_reset_function_resolver()_ function resets the kernel functions
> -resolver to the default function.  The _tep_ argument is trace event parser
> -context.
> -
> -
> -These APIs can be used to find function name and start address, by given
> -address. The given address does not have to be exact, it will select
> -the function that would contain it.
> -
> -The _tep_find_function()_ function returns the function name, which contains the
> -given address _addr_. The _tep_ argument is the trace event parser context.
> -
> -The _tep_find_function_address()_ function returns the function start address,
> -by given address _addr_. The _addr_ does not have to be exact, it will select
> -the function that would contain it. The _tep_ argument is the trace event
> -parser context.
> -
> -The _tep_register_function()_ function registers a function name mapped to an
> -address and (optional) module. This mapping is used in case the function tracer
> -or events have "%pS" parameter in its format string. It is common to pass in
> -the kallsyms function names with their corresponding addresses with this
> -function. The _tep_ argument is the trace event parser context. The _name_ is
> -the name of the function, the string is copied internally. The _addr_ is the
> -start address of the function. The _mod_ is the kernel module the function may
> -be in (NULL for none).
> -
> -The _tep_register_print_string()_ function  registers a string by the address
> -it was stored in the kernel. Some strings internal to the kernel with static
> -address are passed to certain events. The "%s" in the event's format field
> -which has an address needs to know what string would be at that address. The
> -tep_register_print_string() supplies the parsing with the mapping between kernel
> -addresses and those strings. The _tep_ argument is the trace event parser
> -context. The _fmt_ is the string to register, it is copied internally.
> -The _addr_ is the address the string was located at.
> -
> -
> -RETURN VALUE
> -------------
> -The _tep_set_function_resolver()_ function returns 0 in case of success, or -1
> -in case of an error.
> -
> -The _tep_find_function()_ function returns the function name, or NULL in case
> -it cannot be found.
> -
> -The _tep_find_function_address()_ function returns the function start address,
> -or 0 in case it cannot be found.
> -
> -The _tep_register_function()_ function returns 0 in case of success. In case of
> -an error -1 is returned, and errno is set to the appropriate error number.
> -
> -The _tep_register_print_string()_ function returns 0 in case of success. In case
> -of an error -1 is returned, and errno is set to the appropriate error number.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -char *my_resolve_kernel_addr(void *context,
> -			     unsigned long long *addrp, char **modp)
> -{
> -	struct db *function_database = context;
> -	struct symbol *sym = sql_lookup(function_database, *addrp);
> -
> -	if (!sym)
> -		return NULL;
> -
> -	*modp = sym->module_name;
> -	return sym->name;
> -}
> -
> -void show_function( unsigned long long addr)
> -{
> -	unsigned long long fstart;
> -	const char *fname;
> -
> -	if (tep_set_function_resolver(tep, my_resolve_kernel_addr,
> -				      function_database) != 0) {
> -		/* failed to register my_resolve_kernel_addr */
> -	}
> -
> -	/* These APIs use my_resolve_kernel_addr() to resolve the addr */
> -	fname = tep_find_function(tep, addr);
> -	fstart = tep_find_function_address(tep, addr);
> -
> -	/*
> -	   addr is in function named fname, starting at fstart address,
> -	   at offset (addr - fstart)
> -	*/
> -
> -	tep_reset_function_resolver(tep);
> -
> -}
> -...
> -	if (tep_register_function(tep, "kvm_exit",
> -				(unsigned long long) 0x12345678, "kvm") != 0) {
> -		/* Failed to register kvm_exit address mapping */
> -	}
> -...
> -	if (tep_register_print_string(tep, "print string",
> -				(unsigned long long) 0x87654321, NULL) != 0) {
> -		/* Failed to register "print string" address mapping */
> -	}
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-func_find.txt b/tools/lib/traceevent/Documentation/libtraceevent-func_find.txt
> deleted file mode 100644
> index 04840e244445..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-func_find.txt
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_find_function,tep_find_function_address - Find function name / start address.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -const char pass:[*]*tep_find_function*(struct tep_handle pass:[*]_tep_, unsigned long long _addr_);
> -unsigned long long *tep_find_function_address*(struct tep_handle pass:[*]_tep_, unsigned long long _addr_);
> ---
> -
> -DESCRIPTION
> ------------
> -These functions can be used to find function name and start address, by given
> -address. The given address does not have to be exact, it will select the function
> -that would contain it.
> -
> -The _tep_find_function()_ function returns the function name, which contains the
> -given address _addr_. The _tep_ argument is the trace event parser context.
> -
> -The _tep_find_function_address()_ function returns the function start address,
> -by given address _addr_. The _addr_ does not have to be exact, it will select the
> -function that would contain it. The _tep_ argument is the trace event parser context.
> -
> -RETURN VALUE
> -------------
> -The _tep_find_function()_ function returns the function name, or NULL in case
> -it cannot be found.
> -
> -The _tep_find_function_address()_ function returns the function start address,
> -or 0 in case it cannot be found.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -void show_function( unsigned long long addr)
> -{
> -	const char *fname = tep_find_function(tep, addr);
> -	unsigned long long fstart = tep_find_function_address(tep, addr);
> -
> -	/* addr is in function named fname, starting at fstart address, at offset (addr - fstart) */
> -}
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-handle.txt b/tools/lib/traceevent/Documentation/libtraceevent-handle.txt
> deleted file mode 100644
> index 45b20172e262..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-handle.txt
> +++ /dev/null
> @@ -1,101 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_alloc, tep_free,tep_ref, tep_unref,tep_get_ref - Create, destroy, manage
> -references of trace event parser context.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -struct tep_handle pass:[*]*tep_alloc*(void);
> -void *tep_free*(struct tep_handle pass:[*]_tep_);
> -void *tep_ref*(struct tep_handle pass:[*]_tep_);
> -void *tep_unref*(struct tep_handle pass:[*]_tep_);
> -int *tep_get_ref*(struct tep_handle pass:[*]_tep_);
> ---
> -
> -DESCRIPTION
> ------------
> -These are the main functions to create and destroy tep_handle - the main
> -structure, representing the trace event parser context. This context is used as
> -the input parameter of most library APIs.
> -
> -The _tep_alloc()_ function allocates and initializes the tep context.
> -
> -The _tep_free()_ function will decrement the reference of the _tep_ handler.
> -When there is no more references, then it will free the handler, as well
> -as clean up all its resources that it had used. The argument _tep_ is
> -the pointer to the trace event parser context.
> -
> -The _tep_ref()_ function adds a reference to the _tep_ handler.
> -
> -The _tep_unref()_ function removes a reference from the _tep_ handler. When
> -the last reference is removed, the _tep_ is destroyed, and all resources that
> -it had used are cleaned up.
> -
> -The _tep_ref_get()_ functions gets the current references of the _tep_ handler.
> -
> -RETURN VALUE
> -------------
> -_tep_alloc()_ returns a pointer to a newly created tep_handle structure.
> -NULL is returned in case there is not enough free memory to allocate it.
> -
> -_tep_ref_get()_ returns the current references of _tep_.
> -If _tep_ is NULL, 0 is returned.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -int ref = tep_get_ref(tep);
> -tep_ref(tep);
> -if ( (ref+1) != tep_get_ref(tep)) {
> -	/* Something wrong happened, the counter is not incremented by 1 */
> -}
> -tep_unref(tep);
> -...
> -tep_free(tep);
> -...
> ---
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-header_page.txt b/tools/lib/traceevent/Documentation/libtraceevent-header_page.txt
> deleted file mode 100644
> index 615d117dc39f..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-header_page.txt
> +++ /dev/null
> @@ -1,102 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_get_header_page_size, tep_get_header_timestamp_size, tep_is_old_format -
> -Get the data stored in the header page, in kernel context.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -int *tep_get_header_page_size*(struct tep_handle pass:[*]_tep_);
> -int *tep_get_header_timestamp_size*(struct tep_handle pass:[*]_tep_);
> -bool *tep_is_old_format*(struct tep_handle pass:[*]_tep_);
> ---
> -DESCRIPTION
> ------------
> -These functions retrieve information from kernel context, stored in tracefs
> -events/header_page. Old kernels do not have header page info, so default values
> -from user space context are used.
> -
> -The _tep_get_header_page_size()_ function returns the size of a long integer,
> -in kernel context. The _tep_ argument is trace event parser context.
> -This information is retrieved from tracefs events/header_page, "commit" field.
> -
> -The _tep_get_header_timestamp_size()_ function returns the size of timestamps,
> -in kernel context. The _tep_ argument is trace event parser context. This
> -information is retrieved from tracefs events/header_page, "timestamp" field.
> -
> -The _tep_is_old_format()_ function returns true if the kernel predates
> -the addition of events/header_page, otherwise it returns false.
> -
> -RETURN VALUE
> -------------
> -The _tep_get_header_page_size()_ function returns the size of a long integer,
> -in bytes.
> -
> -The _tep_get_header_timestamp_size()_ function returns the size of timestamps,
> -in bytes.
> -
> -The _tep_is_old_format()_ function returns true, if an old kernel is used to
> -generate the tracing data, which has no event/header_page. If the kernel is new,
> -or _tep_ is NULL, false is returned.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -	int longsize;
> -	int timesize;
> -	bool old;
> -
> -	longsize = tep_get_header_page_size(tep);
> -	timesize = tep_get_header_timestamp_size(tep);
> -	old = tep_is_old_format(tep);
> -
> -	printf ("%s kernel is used to generate the tracing data.\n",
> -		old?"Old":"New");
> -	printf("The size of a long integer is %d bytes.\n", longsize);
> -	printf("The timestamps size is %d bytes.\n", timesize);
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt b/tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt
> deleted file mode 100644
> index d5d375eb8d1e..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt
> +++ /dev/null
> @@ -1,104 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_is_bigendian, tep_is_local_bigendian, tep_set_local_bigendian - Get / set
> -the endianness of the local machine.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -enum *tep_endian* {
> -	TEP_LITTLE_ENDIAN = 0,
> -	TEP_BIG_ENDIAN
> -};
> -
> -int *tep_is_bigendian*(void);
> -bool *tep_is_local_bigendian*(struct tep_handle pass:[*]_tep_);
> -void *tep_set_local_bigendian*(struct tep_handle pass:[*]_tep_, enum tep_endian _endian_);
> ---
> -
> -DESCRIPTION
> ------------
> -
> -The _tep_is_bigendian()_ gets the endianness of the machine, executing
> -the function.
> -
> -The _tep_is_local_bigendian()_ function gets the endianness of the local
> -machine, saved in the _tep_ handler. The _tep_ argument is the trace event
> -parser context. This API is a bit faster than _tep_is_bigendian()_, as it
> -returns cached endianness of the local machine instead of checking it each time.
> -
> -The _tep_set_local_bigendian()_ function sets the endianness of the local
> -machine in the _tep_ handler. The _tep_ argument is trace event parser context.
> -The _endian_ argument is the endianness:
> -[verse]
> ---
> -	_TEP_LITTLE_ENDIAN_ - the machine is little endian,
> -	_TEP_BIG_ENDIAN_ - the machine is big endian.
> ---
> -
> -RETURN VALUE
> -------------
> -The _tep_is_bigendian()_ function returns non zero if the endianness of the
> -machine, executing the code, is big endian and zero otherwise.
> -
> -The _tep_is_local_bigendian()_ function returns true, if the endianness of the
> -local machine, saved in the _tep_ handler, is big endian, or false otherwise.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -	if (tep_is_bigendian())
> -		tep_set_local_bigendian(tep, TEP_BIG_ENDIAN);
> -	else
> -		tep_set_local_bigendian(tep, TEP_LITTLE_ENDIAN);
> -...
> -	if (tep_is_local_bigendian(tep))
> -		printf("This machine you are running on is bigendian\n");
> -	else
> -		printf("This machine you are running on is little endian\n");
> -
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-long_size.txt b/tools/lib/traceevent/Documentation/libtraceevent-long_size.txt
> deleted file mode 100644
> index 01d78ea2519a..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-long_size.txt
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_get_long_size, tep_set_long_size - Get / set the size of a long integer on
> -the machine, where the trace is generated, in bytes
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -int *tep_get_long_size*(strucqt tep_handle pass:[*]_tep_);
> -void *tep_set_long_size*(struct tep_handle pass:[*]_tep_, int _long_size_);
> ---
> -
> -DESCRIPTION
> ------------
> -The _tep_get_long_size()_ function returns the size of a long integer on the machine,
> -where the trace is generated. The _tep_ argument is trace event parser context.
> -
> -The _tep_set_long_size()_ function sets the size of a long integer on the machine,
> -where the trace is generated. The _tep_ argument is trace event parser context.
> -The _long_size_ is the size of a long integer, in bytes.
> -
> -RETURN VALUE
> -------------
> -The _tep_get_long_size()_ function returns the size of a long integer on the machine,
> -where the trace is generated, in bytes.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -tep_set_long_size(tep, 4);
> -...
> -int long_size = tep_get_long_size(tep);
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-page_size.txt b/tools/lib/traceevent/Documentation/libtraceevent-page_size.txt
> deleted file mode 100644
> index 452c0cfa1822..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-page_size.txt
> +++ /dev/null
> @@ -1,82 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_get_page_size, tep_set_page_size - Get / set the size of a memory page on
> -the machine, where the trace is generated
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -int *tep_get_page_size*(struct tep_handle pass:[*]_tep_);
> -void *tep_set_page_size*(struct tep_handle pass:[*]_tep_, int _page_size_);
> ---
> -
> -DESCRIPTION
> ------------
> -The _tep_get_page_size()_ function returns the size of a memory page on
> -the machine, where the trace is generated. The _tep_ argument is trace
> -event parser context.
> -
> -The _tep_set_page_size()_ function stores in the _tep_ context the size of a
> -memory page on the machine, where the trace is generated.
> -The _tep_ argument is trace event parser context.
> -The _page_size_ argument is the size of a memory page, in bytes.
> -
> -RETURN VALUE
> -------------
> -The _tep_get_page_size()_ function returns size of the memory page, in bytes.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <unistd.h>
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -	int page_size = getpagesize();
> -
> -	tep_set_page_size(tep, page_size);
> -
> -	printf("The page size for this machine is %d\n", tep_get_page_size(tep));
> -
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-parse_event.txt b/tools/lib/traceevent/Documentation/libtraceevent-parse_event.txt
> deleted file mode 100644
> index f248114ca1ff..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-parse_event.txt
> +++ /dev/null
> @@ -1,90 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_parse_event, tep_parse_format - Parse the event format information
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -enum tep_errno *tep_parse_event*(struct tep_handle pass:[*]_tep_, const char pass:[*]_buf_, unsigned long _size_, const char pass:[*]_sys_);
> -enum tep_errno *tep_parse_format*(struct tep_handle pass:[*]_tep_, struct tep_event pass:[*]pass:[*]_eventp_, const char pass:[*]_buf_, unsigned long _size_, const char pass:[*]_sys_);
> ---
> -
> -DESCRIPTION
> ------------
> -The _tep_parse_event()_ function parses the event format and creates an event
> -structure to quickly parse raw data for a given event. The _tep_ argument is
> -the trace event parser context. The created event structure is stored in the
> -_tep_ context. The _buf_ argument is a buffer with _size_, where the event
> -format data is. The event format data can be taken from
> -tracefs/events/.../.../format files. The _sys_ argument is the system of
> -the event.
> -
> -The _tep_parse_format()_ function does the same as _tep_parse_event()_. The only
> -difference is in the extra _eventp_ argument, where the newly created event
> -structure is returned.
> -
> -RETURN VALUE
> -------------
> -Both _tep_parse_event()_ and _tep_parse_format()_ functions return 0 on success,
> -or TEP_ERRNO__... in case of an error.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -char *buf;
> -int size;
> -struct tep_event *event = NULL;
> -buf = read_file("/sys/kernel/tracing/events/ftrace/print/format", &size);
> -if (tep_parse_event(tep, buf, size, "ftrace") != 0) {
> -	/* Failed to parse the ftrace print format */
> -}
> -
> -if (tep_parse_format(tep, &event, buf, size, "ftrace") != 0) {
> -	/* Failed to parse the ftrace print format */
> -}
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-parse_head.txt b/tools/lib/traceevent/Documentation/libtraceevent-parse_head.txt
> deleted file mode 100644
> index c90f16c7d8e6..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-parse_head.txt
> +++ /dev/null
> @@ -1,82 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_parse_header_page - Parses the data stored in the header page.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -int *tep_parse_header_page*(struct tep_handle pass:[*]_tep_, char pass:[*]_buf_, unsigned long _size_, int _long_size_);
> ---
> -
> -DESCRIPTION
> ------------
> -The _tep_parse_header_page()_ function parses the header page data from _buf_,
> -and initializes the _tep_, trace event parser context, with it. The buffer
> -_buf_ is with _size_, and is supposed to be copied from
> -tracefs/events/header_page.
> -
> -Some old kernels do not have header page info, in this case the
> -_tep_parse_header_page()_ function  can be called with _size_ equal to 0. The
> -_tep_ context is initialized with default values. The _long_size_ can be used in
> -this use case, to set the size of a long integer to be used.
> -
> -RETURN VALUE
> -------------
> -The _tep_parse_header_page()_ function returns 0 in case of success, or -1
> -in case of an error.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -char *buf;
> -int size;
> -buf = read_file("/sys/kernel/tracing/events/header_page", &size);
> -if (tep_parse_header_page(tep, buf, size, sizeof(unsigned long)) != 0) {
> -	/* Failed to parse the header page */
> -}
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-plugins.txt b/tools/lib/traceevent/Documentation/libtraceevent-plugins.txt
> deleted file mode 100644
> index 4d6394397d92..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-plugins.txt
> +++ /dev/null
> @@ -1,122 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_load_plugins, tep_unload_plugins, tep_load_plugins_hook - Load / unload traceevent plugins.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -struct tep_plugin_list pass:[*]*tep_load_plugins*(struct tep_handle pass:[*]_tep_);
> -void *tep_unload_plugins*(struct tep_plugin_list pass:[*]_plugin_list_, struct tep_handle pass:[*]_tep_);
> -void *tep_load_plugins_hook*(struct tep_handle pass:[*]_tep_, const char pass:[*]_suffix_,
> -			   void (pass:[*]_load_plugin_)(struct tep_handle pass:[*]tep,
> -					       const char pass:[*]path,
> -					       const char pass:[*]name,
> -					       void pass:[*]data),
> -			   void pass:[*]_data_);
> ---
> -
> -DESCRIPTION
> ------------
> -The _tep_load_plugins()_ function loads all plugins, located in the plugin
> -directories. The _tep_ argument is trace event parser context.
> -The plugin directories are :
> -[verse]
> ---
> -	- Directories, specified in _tep_->plugins_dir with priority TEP_PLUGIN_FIRST
> -	- System's plugin directory, defined at the library compile time. It
> -	  depends on the library installation prefix and usually is
> -	  _(install_preffix)/lib/traceevent/plugins_
> -	- Directory, defined by the environment variable _TRACEEVENT_PLUGIN_DIR_
> -	- User's plugin directory, located at _~/.local/lib/traceevent/plugins_
> -	- Directories, specified in _tep_->plugins_dir with priority TEP_PLUGIN_LAST
> ---
> -Loading of plugins can be controlled by the _tep_flags_, using the
> -_tep_set_flag()_ API:
> -[verse]
> ---
> -	_TEP_DISABLE_SYS_PLUGINS_	- do not load plugins, located in
> -					the system's plugin directory.
> -	_TEP_DISABLE_PLUGINS_		- do not load any plugins.
> ---
> -The _tep_set_flag()_ API needs to be called before _tep_load_plugins()_, if
> -loading of all plugins is not the desired case.
> -
> -The _tep_unload_plugins()_ function unloads the plugins, previously loaded by
> -_tep_load_plugins()_. The _tep_ argument is trace event parser context. The
> -_plugin_list_ is the list of loaded plugins, returned by
> -the _tep_load_plugins()_ function.
> -
> -The _tep_load_plugins_hook_ function walks through all directories with plugins
> -and calls user specified _load_plugin()_ hook for each plugin file. Only files
> -with given _suffix_ are considered to be plugins. The _data_ is a user specified
> -context, passed to _load_plugin()_. Directories and the walk order are the same
> -as in _tep_load_plugins()_ API.
> -
> -RETURN VALUE
> -------------
> -The _tep_load_plugins()_ function returns a list of successfully loaded plugins,
> -or NULL in case no plugins are loaded.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -struct tep_plugin_list *plugins = tep_load_plugins(tep);
> -if (plugins == NULL) {
> -	/* no plugins are loaded */
> -}
> -...
> -tep_unload_plugins(plugins, tep);
> -...
> -void print_plugin(struct tep_handle *tep, const char *path,
> -		  const char *name, void *data)
> -{
> -	pritnf("Found libtraceevent plugin %s/%s\n", path, name);
> -}
> -...
> -tep_load_plugins_hook(tep, ".so", print_plugin, NULL);
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_, _tep_set_flag(3)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt b/tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt
> deleted file mode 100644
> index e9a69116c78b..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt
> +++ /dev/null
> @@ -1,137 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_data_type, tep_data_pid,tep_data_preempt_count, tep_data_flags -
> -Extract common fields from a record.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -enum *trace_flag_type* {
> -	_TRACE_FLAG_IRQS_OFF_,
> -	_TRACE_FLAG_IRQS_NOSUPPORT_,
> -	_TRACE_FLAG_NEED_RESCHED_,
> -	_TRACE_FLAG_HARDIRQ_,
> -	_TRACE_FLAG_SOFTIRQ_,
> -};
> -
> -int *tep_data_type*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
> -int *tep_data_pid*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
> -int *tep_data_preempt_count*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
> -int *tep_data_flags*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
> ---
> -
> -DESCRIPTION
> ------------
> -This set of functions can be used to extract common fields from a record.
> -
> -The _tep_data_type()_ function gets the event id from the record _rec_.
> -It reads the "common_type" field. The _tep_ argument is the trace event parser
> -context.
> -
> -The _tep_data_pid()_ function gets the process id from the record _rec_.
> -It reads the "common_pid" field. The _tep_ argument is the trace event parser
> -context.
> -
> -The _tep_data_preempt_count()_ function gets the preemption count from the
> -record _rec_. It reads the "common_preempt_count" field. The _tep_ argument is
> -the trace event parser context.
> -
> -The _tep_data_flags()_ function gets the latency flags from the record _rec_.
> -It reads the "common_flags" field. The _tep_ argument is the trace event parser
> -context. Supported latency flags are:
> -[verse]
> ---
> -	_TRACE_FLAG_IRQS_OFF_,		Interrupts are disabled.
> -	_TRACE_FLAG_IRQS_NOSUPPORT_,	Reading IRQ flag is not supported by the architecture.
> -	_TRACE_FLAG_NEED_RESCHED_,	Task needs rescheduling.
> -	_TRACE_FLAG_HARDIRQ_,		Hard IRQ is running.
> -	_TRACE_FLAG_SOFTIRQ_,		Soft IRQ is running.
> ---
> -
> -RETURN VALUE
> -------------
> -The _tep_data_type()_ function returns an integer, representing the event id.
> -
> -The _tep_data_pid()_ function returns an integer, representing the process id
> -
> -The _tep_data_preempt_count()_ function returns an integer, representing the
> -preemption count.
> -
> -The _tep_data_flags()_ function returns an integer, representing the latency
> -flags. Look at the _trace_flag_type_ enum for supported flags.
> -
> -All these functions in case of an error return a negative integer.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -void process_record(struct tep_record *record)
> -{
> -	int data;
> -
> -	data = tep_data_type(tep, record);
> -	if (data >= 0) {
> -		/* Got the ID of the event */
> -	}
> -
> -	data = tep_data_pid(tep, record);
> -	if (data >= 0) {
> -		/* Got the process ID */
> -	}
> -
> -	data = tep_data_preempt_count(tep, record);
> -	if (data >= 0) {
> -		/* Got the preemption count */
> -	}
> -
> -	data = tep_data_flags(tep, record);
> -	if (data >= 0) {
> -		/* Got the latency flags */
> -	}
> -}
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-reg_event_handler.txt b/tools/lib/traceevent/Documentation/libtraceevent-reg_event_handler.txt
> deleted file mode 100644
> index 53d37d72a1c1..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-reg_event_handler.txt
> +++ /dev/null
> @@ -1,156 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_register_event_handler, tep_unregister_event_handler -  Register /
> -unregisters a callback function to parse an event information.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -enum *tep_reg_handler* {
> -	_TEP_REGISTER_SUCCESS_,
> -	_TEP_REGISTER_SUCCESS_OVERWRITE_,
> -};
> -
> -int *tep_register_event_handler*(struct tep_handle pass:[*]_tep_, int _id_, const char pass:[*]_sys_name_, const char pass:[*]_event_name_, tep_event_handler_func _func_, void pass:[*]_context_);
> -int *tep_unregister_event_handler*(struct tep_handle pass:[*]tep, int id, const char pass:[*]sys_name, const char pass:[*]event_name, tep_event_handler_func func, void pass:[*]_context_);
> -
> -typedef int (*pass:[*]tep_event_handler_func*)(struct trace_seq pass:[*]s, struct tep_record pass:[*]record, struct tep_event pass:[*]event, void pass:[*]context);
> ---
> -
> -DESCRIPTION
> ------------
> -The _tep_register_event_handler()_ function registers a handler function,
> -which is going to be called to parse the information for a given event.
> -The _tep_ argument is the trace event parser context. The _id_ argument is
> -the id of the event. The _sys_name_ argument is the name of the system,
> -the event belongs to. The _event_name_ argument is the name of the event.
> -If _id_ is >= 0, it is used to find the event, otherwise _sys_name_ and
> -_event_name_ are used. The _func_ is a pointer to the function, which is going
> -to be called to parse the event information. The _context_ argument is a pointer
> -to the context data, which will be passed to the _func_. If a handler function
> -for the same event is already registered, it will be overridden with the new
> -one. This mechanism allows a developer to override the parsing of a given event.
> -If for some reason the default print format is not sufficient, the developer
> -can register a function for an event to be used to parse the data instead.
> -
> -The _tep_unregister_event_handler()_ function unregisters the handler function,
> -previously registered with _tep_register_event_handler()_. The _tep_ argument
> -is the trace event parser context. The _id_, _sys_name_, _event_name_, _func_,
> -and _context_ are the same arguments, as when the callback function _func_ was
> -registered.
> -
> -The _tep_event_handler_func_ is the type of the custom event handler
> -function. The _s_ argument is the trace sequence, it can be used to create a
> -custom string, describing the event. A _record_  to get the event from is passed
> -as input parameter and also the _event_ - the handle to the record's event. The
> -_context_ is custom context, set when the custom event handler is registered.
> -
> -RETURN VALUE
> -------------
> -The _tep_register_event_handler()_ function returns _TEP_REGISTER_SUCCESS_
> -if the new handler is registered successfully or
> -_TEP_REGISTER_SUCCESS_OVERWRITE_ if an existing handler is overwritten.
> -If there is not  enough memory to complete the registration,
> -TEP_ERRNO__MEM_ALLOC_FAILED is returned.
> -
> -The _tep_unregister_event_handler()_ function returns 0 if _func_ was removed
> -successful or, -1 if the event was not found.
> -
> -The _tep_event_handler_func_ should return -1 in case of an error,
> -or 0 otherwise.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -#include <trace-seq.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -int timer_expire_handler(struct trace_seq *s, struct tep_record *record,
> -			 struct tep_event *event, void *context)
> -{
> -	trace_seq_printf(s, "hrtimer=");
> -
> -	if (tep_print_num_field(s, "0x%llx", event, "timer", record, 0) == -1)
> -		tep_print_num_field(s, "0x%llx", event, "hrtimer", record, 1);
> -
> -	trace_seq_printf(s, " now=");
> -
> -	tep_print_num_field(s, "%llu", event, "now", record, 1);
> -
> -	tep_print_func_field(s, " function=%s", event, "function", record, 0);
> -
> -	return 0;
> -}
> -...
> -	int ret;
> -
> -	ret = tep_register_event_handler(tep, -1, "timer", "hrtimer_expire_entry",
> -					 timer_expire_handler, NULL);
> -	if (ret < 0) {
> -		char buf[32];
> -
> -		tep_strerror(tep, ret, buf, 32)
> -		printf("Failed to register handler for hrtimer_expire_entry: %s\n", buf);
> -	} else {
> -		switch (ret) {
> -		case TEP_REGISTER_SUCCESS:
> -			printf ("Registered handler for hrtimer_expire_entry\n");
> -			break;
> -		case TEP_REGISTER_SUCCESS_OVERWRITE:
> -			printf ("Overwrote handler for hrtimer_expire_entry\n");
> -			break;
> -		}
> -	}
> -...
> -	ret = tep_unregister_event_handler(tep, -1, "timer", "hrtimer_expire_entry",
> -					   timer_expire_handler, NULL);
> -	if ( ret )
> -		printf ("Failed to unregister handler for hrtimer_expire_entry\n");
> -
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*trace-seq.h*
> -	Header file to include in order to have access to trace sequences
> -	related APIs. Trace sequences are used to allow a function to call
> -	several other functions to create a string of data to use.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-reg_print_func.txt b/tools/lib/traceevent/Documentation/libtraceevent-reg_print_func.txt
> deleted file mode 100644
> index 708dce91ebd8..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-reg_print_func.txt
> +++ /dev/null
> @@ -1,155 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_register_print_function,tep_unregister_print_function -
> -Registers / Unregisters a helper function.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -enum *tep_func_arg_type* {
> -	TEP_FUNC_ARG_VOID,
> -	TEP_FUNC_ARG_INT,
> -	TEP_FUNC_ARG_LONG,
> -	TEP_FUNC_ARG_STRING,
> -	TEP_FUNC_ARG_PTR,
> -	TEP_FUNC_ARG_MAX_TYPES
> -};
> -
> -typedef unsigned long long (*pass:[*]tep_func_handler*)(struct trace_seq pass:[*]s, unsigned long long pass:[*]args);
> -
> -int *tep_register_print_function*(struct tep_handle pass:[*]_tep_, tep_func_handler _func_, enum tep_func_arg_type _ret_type_, char pass:[*]_name_, _..._);
> -int *tep_unregister_print_function*(struct tep_handle pass:[*]_tep_, tep_func_handler _func_, char pass:[*]_name_);
> ---
> -
> -DESCRIPTION
> ------------
> -Some events may have helper functions in the print format arguments.
> -This allows a plugin to dynamically create a way to process one of
> -these functions.
> -
> -The _tep_register_print_function()_ registers such helper function. The _tep_
> -argument is the trace event parser context. The _func_ argument  is a pointer
> -to the helper function. The _ret_type_ argument is  the return type of the
> -helper function, value from the _tep_func_arg_type_ enum. The _name_ is the name
> -of the helper function, as seen in the print format arguments. The _..._ is a
> -variable list of _tep_func_arg_type_ enums, the _func_ function arguments.
> -This list must end with _TEP_FUNC_ARG_VOID_. See 'EXAMPLE' section.
> -
> -The _tep_unregister_print_function()_ unregisters a helper function, previously
> -registered with _tep_register_print_function()_. The _tep_ argument is the
> -trace event parser context. The _func_ and _name_ arguments are the same, used
> -when the helper function was registered.
> -
> -The _tep_func_handler_ is the type of the helper function. The _s_ argument is
> -the trace sequence, it can be used to create a custom string.
> -The _args_  is a list of arguments, defined when the helper function was
> -registered.
> -
> -RETURN VALUE
> -------------
> -The _tep_register_print_function()_ function returns 0 in case of success.
> -In case of an error, TEP_ERRNO_... code is returned.
> -
> -The _tep_unregister_print_function()_ returns 0 in case of success, or -1 in
> -case of an error.
> -
> -EXAMPLE
> --------
> -Some events have internal functions calls, that appear in the print format
> -output. For example "tracefs/events/i915/g4x_wm/format" has:
> -[source,c]
> ---
> -print fmt: "pipe %c, frame=%u, scanline=%u, wm %d/%d/%d, sr %s/%d/%d/%d, hpll %s/%d/%d/%d, fbc %s",
> -	    ((REC->pipe) + 'A'), REC->frame, REC->scanline, REC->primary,
> -	    REC->sprite, REC->cursor, yesno(REC->cxsr), REC->sr_plane,
> -	    REC->sr_cursor, REC->sr_fbc, yesno(REC->hpll), REC->hpll_plane,
> -	    REC->hpll_cursor, REC->hpll_fbc, yesno(REC->fbc)
> ---
> -Notice the call to function _yesno()_ in the print arguments. In the kernel
> -context, this function has the following implementation:
> -[source,c]
> ---
> -static const char *yesno(int x)
> -{
> -	static const char *yes = "yes";
> -	static const char *no = "no";
> -
> -	return x ? yes : no;
> -}
> ---
> -The user space event parser has no idea how to handle this _yesno()_ function.
> -The _tep_register_print_function()_ API can be used to register a user space
> -helper function, mapped to the kernel's _yesno()_:
> -[source,c]
> ---
> -#include <event-parse.h>
> -#include <trace-seq.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -static const char *yes_no_helper(int x)
> -{
> -	return x ? "yes" : "no";
> -}
> -...
> -	if ( tep_register_print_function(tep,
> -				    yes_no_helper,
> -				    TEP_FUNC_ARG_STRING,
> -				    "yesno",
> -				    TEP_FUNC_ARG_INT,
> -				    TEP_FUNC_ARG_VOID) != 0) {
> -		/* Failed to register yes_no_helper function */
> -	}
> -
> -/*
> -   Now, when the event parser encounters this yesno() function, it will know
> -   how to handle it.
> -*/
> -...
> -	if (tep_unregister_print_function(tep, yes_no_helper, "yesno") != 0) {
> -		/* Failed to unregister yes_no_helper function */
> -	}
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*trace-seq.h*
> -	Header file to include in order to have access to trace sequences
> -	related APIs. Trace sequences are used to allow a function to call
> -	several other functions to create a string of data to use.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-set_flag.txt b/tools/lib/traceevent/Documentation/libtraceevent-set_flag.txt
> deleted file mode 100644
> index b0599780b9a6..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-set_flag.txt
> +++ /dev/null
> @@ -1,104 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_set_flag, tep_clear_flag, tep_test_flag -
> -Manage flags of trace event parser context.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -enum *tep_flag* {
> -	_TEP_NSEC_OUTPUT_,
> -	_TEP_DISABLE_SYS_PLUGINS_,
> -	_TEP_DISABLE_PLUGINS_
> -};
> -void *tep_set_flag*(struct tep_handle pass:[*]_tep_, enum tep_flag _flag_);
> -void *tep_clear_flag*(struct tep_handle pass:[*]_tep_, enum tep_flag _flag_);
> -bool *tep_test_flag*(struct tep_handle pass:[*]_tep_, enum tep_flag _flag_);
> ---
> -
> -DESCRIPTION
> ------------
> -Trace event parser context flags are defined in *enum tep_flag*:
> -[verse]
> ---
> -_TEP_NSEC_OUTPUT_ - print event's timestamp in nano seconds, instead of micro seconds.
> -_TEP_DISABLE_SYS_PLUGINS_ - disable plugins, located in system's plugin
> -			directory. This directory is defined at library compile
> -			time, and usually depends on library installation
> -			prefix: (install_preffix)/lib/traceevent/plugins
> -_TEP_DISABLE_PLUGINS_ - disable all library plugins:
> -			- in system's plugin directory
> -			- in directory, defined by the environment variable _TRACEEVENT_PLUGIN_DIR_
> -			- in user's home directory, _~/.traceevent/plugins_
> ---
> -Note: plugin related flags must me set before calling _tep_load_plugins()_ API.
> -
> -The _tep_set_flag()_ function sets _flag_ to _tep_ context.
> -
> -The _tep_clear_flag()_ function clears _flag_ from _tep_ context.
> -
> -The _tep_test_flag()_ function tests if _flag_ is set to _tep_ context.
> -
> -RETURN VALUE
> -------------
> -_tep_test_flag()_ function returns true if _flag_ is set, false otherwise.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -/* Print timestamps in nanoseconds */
> -tep_set_flag(tep,  TEP_NSEC_OUTPUT);
> -...
> -if (tep_test_flag(tep, TEP_NSEC_OUTPUT)) {
> -	/* print timestamps in nanoseconds */
> -} else {
> -	/* print timestamps in microseconds */
> -}
> -...
> -/* Print timestamps in microseconds */
> -tep_clear_flag(tep, TEP_NSEC_OUTPUT);
> -...
> ---
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-strerror.txt b/tools/lib/traceevent/Documentation/libtraceevent-strerror.txt
> deleted file mode 100644
> index ee4062a00c9f..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-strerror.txt
> +++ /dev/null
> @@ -1,85 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -tep_strerror - Returns a string describing regular errno and tep error number.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -int *tep_strerror*(struct tep_handle pass:[*]_tep_, enum tep_errno _errnum_, char pass:[*]_buf_, size_t _buflen_);
> -
> ---
> -DESCRIPTION
> ------------
> -The _tep_strerror()_ function converts tep error number into a human
> -readable string.
> -The _tep_ argument is trace event parser context. The _errnum_ is a regular
> -errno, defined in errno.h, or a tep error number. The string, describing this
> -error number is copied in the _buf_ argument. The _buflen_ argument is
> -the size of the _buf_.
> -
> -It as a thread safe wrapper around strerror_r(). The library function has two
> -different behaviors - POSIX and GNU specific. The _tep_strerror()_ API always
> -behaves as the POSIX version - the error string is copied in the user supplied
> -buffer.
> -
> -RETURN VALUE
> -------------
> -The _tep_strerror()_ function returns 0, if a valid _errnum_ is passed and the
> -string is copied into _buf_. If _errnum_ is not a valid error number,
> --1 is returned and _buf_ is not modified.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -...
> -struct tep_handle *tep = tep_alloc();
> -...
> -char buf[32];
> -char *pool = calloc(1, 128);
> -if (tep == NULL) {
> -	tep_strerror(tep, TEP_ERRNO__MEM_ALLOC_FAILED, buf, 32);
> -	printf ("The pool is not initialized, %s", buf);
> -}
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-tseq.txt b/tools/lib/traceevent/Documentation/libtraceevent-tseq.txt
> deleted file mode 100644
> index 8ac6aa174e12..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent-tseq.txt
> +++ /dev/null
> @@ -1,158 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -trace_seq_init, trace_seq_destroy, trace_seq_reset, trace_seq_terminate,
> -trace_seq_putc, trace_seq_puts, trace_seq_printf, trace_seq_vprintf,
> -trace_seq_do_fprintf, trace_seq_do_printf -
> -Initialize / destroy a trace sequence.
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -*#include <trace-seq.h>*
> -
> -void *trace_seq_init*(struct trace_seq pass:[*]_s_);
> -void *trace_seq_destroy*(struct trace_seq pass:[*]_s_);
> -void *trace_seq_reset*(struct trace_seq pass:[*]_s_);
> -void *trace_seq_terminate*(struct trace_seq pass:[*]_s_);
> -int *trace_seq_putc*(struct trace_seq pass:[*]_s_, unsigned char _c_);
> -int *trace_seq_puts*(struct trace_seq pass:[*]_s_, const char pass:[*]_str_);
> -int *trace_seq_printf*(struct trace_seq pass:[*]_s_, const char pass:[*]_fmt_, _..._);
> -int *trace_seq_vprintf*(struct trace_seq pass:[*]_s_, const char pass:[*]_fmt_, va_list _args_);
> -int *trace_seq_do_printf*(struct trace_seq pass:[*]_s_);
> -int *trace_seq_do_fprintf*(struct trace_seq pass:[*]_s_, FILE pass:[*]_fp_);
> ---
> -
> -DESCRIPTION
> ------------
> -Trace sequences are used to allow a function to call several other functions
> -to create a string of data to use.
> -
> -The _trace_seq_init()_ function initializes the trace sequence _s_.
> -
> -The _trace_seq_destroy()_ function destroys the trace sequence _s_ and frees
> -all its resources that it had used.
> -
> -The _trace_seq_reset()_ function re-initializes the trace sequence _s_. All
> -characters already written in _s_ will be deleted.
> -
> -The _trace_seq_terminate()_ function terminates the trace sequence _s_. It puts
> -the null character pass:['\0'] at the end of the buffer.
> -
> -The _trace_seq_putc()_ function puts a single character _c_ in the trace
> -sequence _s_.
> -
> -The _trace_seq_puts()_ function puts a NULL terminated string _str_ in the
> -trace sequence _s_.
> -
> -The _trace_seq_printf()_ function puts a formated string _fmt _with
> -variable arguments _..._ in the trace sequence _s_.
> -
> -The _trace_seq_vprintf()_ function puts a formated string _fmt _with
> -list of arguments _args_ in the trace sequence _s_.
> -
> -The _trace_seq_do_printf()_ function prints the buffer of trace sequence _s_ to
> -the standard output stdout.
> -
> -The _trace_seq_do_fprintf()_ function prints the buffer of trace sequence _s_
> -to the given file _fp_.
> -
> -RETURN VALUE
> -------------
> -Both _trace_seq_putc()_ and _trace_seq_puts()_ functions return the number of
> -characters put in the trace sequence, or 0 in case of an error
> -
> -Both _trace_seq_printf()_ and _trace_seq_vprintf()_ functions return 0 if the
> -trace oversizes the buffer's free space, the number of characters printed, or
> -a negative value in case of an error.
> -
> -Both _trace_seq_do_printf()_ and _trace_seq_do_fprintf()_ functions return the
> -number of printed characters, or -1 in case of an error.
> -
> -EXAMPLE
> --------
> -[source,c]
> ---
> -#include <event-parse.h>
> -#include <trace-seq.h>
> -...
> -struct trace_seq seq;
> -trace_seq_init(&seq);
> -...
> -void foo_seq_print(struct trace_seq *tseq, char *format, ...)
> -{
> -	va_list ap;
> -	va_start(ap, format);
> -	if (trace_seq_vprintf(tseq, format, ap) <= 0) {
> -		/* Failed to print in the trace sequence */
> -	}
> -	va_end(ap);
> -}
> -
> -trace_seq_reset(&seq);
> -
> -char *str = " MAN page example";
> -if (trace_seq_puts(&seq, str) != strlen(str)) {
> -	/* Failed to put str in the trace sequence */
> -}
> -if (trace_seq_putc(&seq, ':') != 1) {
> -	/* Failed to put ':' in the trace sequence */
> -}
> -if (trace_seq_printf(&seq, " trace sequence: %d", 1) <= 0) {
> -	/* Failed to print in the trace sequence */
> -}
> -foo_seq_print( &seq, "  %d\n", 2);
> -
> -trace_seq_terminate(&seq);
> -...
> -
> -if (trace_seq_do_printf(&seq) < 0 ) {
> -	/* Failed to print the sequence buffer to the standard output */
> -}
> -FILE *fp = fopen("trace.txt", "w");
> -if (trace_seq_do_fprintf(&seq, fp) < 0 ) [
> -	/* Failed to print the sequence buffer to the trace.txt file */
> -}
> -
> -trace_seq_destroy(&seq);
> -...
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*trace-seq.h*
> -	Header file to include in order to have access to trace sequences related APIs.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_libtraceevent(3)_, _trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent.txt b/tools/lib/traceevent/Documentation/libtraceevent.txt
> deleted file mode 100644
> index d530a7ce8fb2..000000000000
> --- a/tools/lib/traceevent/Documentation/libtraceevent.txt
> +++ /dev/null
> @@ -1,192 +0,0 @@
> -libtraceevent(3)
> -================
> -
> -NAME
> -----
> -libtraceevent - Linux kernel trace event library
> -
> -SYNOPSIS
> ---------
> -[verse]
> ---
> -*#include <event-parse.h>*
> -
> -Management of tep handler data structure and access of its members:
> -	struct tep_handle pass:[*]*tep_alloc*(void);
> -	void *tep_free*(struct tep_handle pass:[*]_tep_);
> -	void *tep_ref*(struct tep_handle pass:[*]_tep_);
> -	void *tep_unref*(struct tep_handle pass:[*]_tep_);
> -	int *tep_get_ref*(struct tep_handle pass:[*]_tep_);
> -	void *tep_set_flag*(struct tep_handle pass:[*]_tep_, enum tep_flag _flag_);
> -	void *tep_clear_flag*(struct tep_handle pass:[*]_tep_, enum tep_flag _flag_);
> -	bool *tep_test_flag*(struct tep_handle pass:[*]_tep_, enum tep_flag _flags_);
> -	int *tep_get_cpus*(struct tep_handle pass:[*]_tep_);
> -	void *tep_set_cpus*(struct tep_handle pass:[*]_tep_, int _cpus_);
> -	int *tep_get_long_size*(strucqt tep_handle pass:[*]_tep_);
> -	void *tep_set_long_size*(struct tep_handle pass:[*]_tep_, int _long_size_);
> -	int *tep_get_page_size*(struct tep_handle pass:[*]_tep_);
> -	void *tep_set_page_size*(struct tep_handle pass:[*]_tep_, int _page_size_);
> -	int *tep_get_header_page_size*(struct tep_handle pass:[*]_tep_);
> -	int *tep_get_header_timestamp_size*(struct tep_handle pass:[*]_tep_);
> -	bool *tep_is_old_format*(struct tep_handle pass:[*]_tep_);
> -	int *tep_strerror*(struct tep_handle pass:[*]_tep_, enum tep_errno _errnum_, char pass:[*]_buf_, size_t _buflen_);
> -
> -Register / unregister APIs:
> -	int *tep_register_function*(struct tep_handle pass:[*]_tep_, char pass:[*]_name_, unsigned long long _addr_, char pass:[*]_mod_);
> -	int *tep_register_event_handler*(struct tep_handle pass:[*]_tep_, int _id_, const char pass:[*]_sys_name_, const char pass:[*]_event_name_, tep_event_handler_func _func_, void pass:[*]_context_);
> -	int *tep_unregister_event_handler*(struct tep_handle pass:[*]tep, int id, const char pass:[*]sys_name, const char pass:[*]event_name, tep_event_handler_func func, void pass:[*]_context_);
> -	int *tep_register_print_string*(struct tep_handle pass:[*]_tep_, const char pass:[*]_fmt_, unsigned long long _addr_);
> -	int *tep_register_print_function*(struct tep_handle pass:[*]_tep_, tep_func_handler _func_, enum tep_func_arg_type _ret_type_, char pass:[*]_name_, _..._);
> -	int *tep_unregister_print_function*(struct tep_handle pass:[*]_tep_, tep_func_handler _func_, char pass:[*]_name_);
> -
> -Plugins management:
> -	struct tep_plugin_list pass:[*]*tep_load_plugins*(struct tep_handle pass:[*]_tep_);
> -	void *tep_unload_plugins*(struct tep_plugin_list pass:[*]_plugin_list_, struct tep_handle pass:[*]_tep_);
> -	char pass:[*]pass:[*]*tep_plugin_list_options*(void);
> -	void *tep_plugin_free_options_list*(char pass:[*]pass:[*]_list_);
> -	int *tep_plugin_add_options*(const char pass:[*]_name_, struct tep_plugin_option pass:[*]_options_);
> -	void *tep_plugin_remove_options*(struct tep_plugin_option pass:[*]_options_);
> -	void *tep_print_plugins*(struct trace_seq pass:[*]_s_, const char pass:[*]_prefix_, const char pass:[*]_suffix_, const struct tep_plugin_list pass:[*]_list_);
> -
> -Event related APIs:
> -	struct tep_event pass:[*]*tep_get_event*(struct tep_handle pass:[*]_tep_, int _index_);
> -	struct tep_event pass:[*]*tep_get_first_event*(struct tep_handle pass:[*]_tep_);
> -	int *tep_get_events_count*(struct tep_handle pass:[*]_tep_);
> -	struct tep_event pass:[*]pass:[*]*tep_list_events*(struct tep_handle pass:[*]_tep_, enum tep_event_sort_type _sort_type_);
> -	struct tep_event pass:[*]pass:[*]*tep_list_events_copy*(struct tep_handle pass:[*]_tep_, enum tep_event_sort_type _sort_type_);
> -	void *tep_print_event*(struct tep_handle pass:[*]_tep_, struct trace_seq pass:[*]_s_, struct tep_record pass:[*]_record_, const char pass:[*]_fmt_, _..._);
> -
> -Event finding:
> -	struct tep_event pass:[*]*tep_find_event*(struct tep_handle pass:[*]_tep_, int _id_);
> -	struct tep_event pass:[*]*tep_find_event_by_name*(struct tep_handle pass:[*]_tep_, const char pass:[*]_sys_, const char pass:[*]_name_);
> -	struct tep_event pass:[*]*tep_find_event_by_record*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_record_);
> -
> -Parsing of event files:
> -	int *tep_parse_header_page*(struct tep_handle pass:[*]_tep_, char pass:[*]_buf_, unsigned long _size_, int _long_size_);
> -	enum tep_errno *tep_parse_event*(struct tep_handle pass:[*]_tep_, const char pass:[*]_buf_, unsigned long _size_, const char pass:[*]_sys_);
> -	enum tep_errno *tep_parse_format*(struct tep_handle pass:[*]_tep_, struct tep_event pass:[*]pass:[*]_eventp_, const char pass:[*]_buf_, unsigned long _size_, const char pass:[*]_sys_);
> -
> -APIs related to fields from event's format files:
> -	struct tep_format_field pass:[*]pass:[*]*tep_event_common_fields*(struct tep_event pass:[*]_event_);
> -	struct tep_format_field pass:[*]pass:[*]*tep_event_fields*(struct tep_event pass:[*]_event_);
> -	void pass:[*]*tep_get_field_raw*(struct trace_seq pass:[*]_s_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, int pass:[*]_len_, int _err_);
> -	int *tep_get_field_val*(struct trace_seq pass:[*]_s_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, unsigned long long pass:[*]_val_, int _err_);
> -	int *tep_get_common_field_val*(struct trace_seq pass:[*]_s_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, unsigned long long pass:[*]_val_, int _err_);
> -	int *tep_get_any_field_val*(struct trace_seq pass:[*]_s_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, unsigned long long pass:[*]_val_, int _err_);
> -	int *tep_read_number_field*(struct tep_format_field pass:[*]_field_, const void pass:[*]_data_, unsigned long long pass:[*]_value_);
> -
> -Event fields printing:
> -	void *tep_print_field*(struct trace_seq pass:[*]_s_, void pass:[*]_data_, struct tep_format_field pass:[*]_field_);
> -	void *tep_print_fields*(struct trace_seq pass:[*]_s_, void pass:[*]_data_, int _size_, struct tep_event pass:[*]_event_);
> -	int *tep_print_num_field*(struct trace_seq pass:[*]_s_, const char pass:[*]_fmt_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, int _err_);
> -	int *tep_print_func_field*(struct trace_seq pass:[*]_s_, const char pass:[*]_fmt_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, int _err_);
> -
> -Event fields finding:
> -	struct tep_format_field pass:[*]*tep_find_common_field*(struct tep_event pass:[*]_event_, const char pass:[*]_name_);
> -	struct tep_format_field pass:[*]*tep_find_field*(struct tep_event_ormat pass:[*]_event_, const char pass:[*]_name_);
> -	struct tep_format_field pass:[*]*tep_find_any_field*(struct tep_event pass:[*]_event_, const char pass:[*]_name_);
> -
> -Functions resolver:
> -	int *tep_set_function_resolver*(struct tep_handle pass:[*]_tep_, tep_func_resolver_t pass:[*]_func_, void pass:[*]_priv_);
> -	void *tep_reset_function_resolver*(struct tep_handle pass:[*]_tep_);
> -	const char pass:[*]*tep_find_function*(struct tep_handle pass:[*]_tep_, unsigned long long _addr_);
> -	unsigned long long *tep_find_function_address*(struct tep_handle pass:[*]_tep_, unsigned long long _addr_);
> -
> -Filter management:
> -	struct tep_event_filter pass:[*]*tep_filter_alloc*(struct tep_handle pass:[*]_tep_);
> -	enum tep_errno *tep_filter_add_filter_str*(struct tep_event_filter pass:[*]_filter_, const char pass:[*]_filter_str_);
> -	enum tep_errno *tep_filter_match*(struct tep_event_filter pass:[*]_filter_, struct tep_record pass:[*]_record_);
> -	int *tep_filter_strerror*(struct tep_event_filter pass:[*]_filter_, enum tep_errno _err_, char pass:[*]buf, size_t _buflen_);
> -	int *tep_event_filtered*(struct tep_event_filter pass:[*]_filter_, int _event_id_);
> -	void *tep_filter_reset*(struct tep_event_filter pass:[*]_filter_);
> -	void *tep_filter_free*(struct tep_event_filter pass:[*]_filter_);
> -	char pass:[*]*tep_filter_make_string*(struct tep_event_filter pass:[*]_filter_, int _event_id_);
> -	int *tep_filter_remove_event*(struct tep_event_filter pass:[*]_filter_, int _event_id_);
> -	int *tep_filter_copy*(struct tep_event_filter pass:[*]_dest_, struct tep_event_filter pass:[*]_source_);
> -	int *tep_filter_compare*(struct tep_event_filter pass:[*]_filter1_, struct tep_event_filter pass:[*]_filter2_);
> -
> -Parsing various data from the records:
> -	int *tep_data_type*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
> -	int *tep_data_pid*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
> -	int *tep_data_preempt_count*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
> -	int *tep_data_flags*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
> -
> -Command and task related APIs:
> -	const char pass:[*]*tep_data_comm_from_pid*(struct tep_handle pass:[*]_tep_, int _pid_);
> -	struct cmdline pass:[*]*tep_data_pid_from_comm*(struct tep_handle pass:[*]_tep_, const char pass:[*]_comm_, struct cmdline pass:[*]_next_);
> -	int *tep_register_comm*(struct tep_handle pass:[*]_tep_, const char pass:[*]_comm_, int _pid_);
> -	int *tep_override_comm*(struct tep_handle pass:[*]_tep_, const char pass:[*]_comm_, int _pid_);
> -	bool *tep_is_pid_registered*(struct tep_handle pass:[*]_tep_, int _pid_);
> -	int *tep_cmdline_pid*(struct tep_handle pass:[*]_tep_, struct cmdline pass:[*]_cmdline_);
> -
> -Endian related APIs:
> -	int *tep_is_bigendian*(void);
> -	unsigned long long *tep_read_number*(struct tep_handle pass:[*]_tep_, const void pass:[*]_ptr_, int _size_);
> -	bool *tep_is_file_bigendian*(struct tep_handle pass:[*]_tep_);
> -	void *tep_set_file_bigendian*(struct tep_handle pass:[*]_tep_, enum tep_endian _endian_);
> -	bool *tep_is_local_bigendian*(struct tep_handle pass:[*]_tep_);
> -	void *tep_set_local_bigendian*(struct tep_handle pass:[*]_tep_, enum tep_endian _endian_);
> -
> -Trace sequences:
> -*#include <trace-seq.h>*
> -	void *trace_seq_init*(struct trace_seq pass:[*]_s_);
> -	void *trace_seq_reset*(struct trace_seq pass:[*]_s_);
> -	void *trace_seq_destroy*(struct trace_seq pass:[*]_s_);
> -	int *trace_seq_printf*(struct trace_seq pass:[*]_s_, const char pass:[*]_fmt_, ...);
> -	int *trace_seq_vprintf*(struct trace_seq pass:[*]_s_, const char pass:[*]_fmt_, va_list _args_);
> -	int *trace_seq_puts*(struct trace_seq pass:[*]_s_, const char pass:[*]_str_);
> -	int *trace_seq_putc*(struct trace_seq pass:[*]_s_, unsigned char _c_);
> -	void *trace_seq_terminate*(struct trace_seq pass:[*]_s_);
> -	int *trace_seq_do_fprintf*(struct trace_seq pass:[*]_s_, FILE pass:[*]_fp_);
> -	int *trace_seq_do_printf*(struct trace_seq pass:[*]_s_);
> ---
> -
> -DESCRIPTION
> ------------
> -The libtraceevent(3) library provides APIs to access kernel tracepoint events,
> -located in the tracefs file system under the events directory.
> -
> -ENVIRONMENT
> ------------
> -[verse]
> ---
> -TRACEEVENT_PLUGIN_DIR
> -	Additional plugin directory. All shared object files, located in this directory will be loaded as traceevent plugins.
> ---
> -
> -FILES
> ------
> -[verse]
> ---
> -*event-parse.h*
> -	Header file to include in order to have access to the library APIs.
> -*trace-seq.h*
> -	Header file to include in order to have access to trace sequences related APIs.
> -	Trace sequences are used to allow a function to call several other functions
> -	to create a string of data to use.
> -*-ltraceevent*
> -	Linker switch to add when building a program that uses the library.
> ---
> -
> -SEE ALSO
> ---------
> -_trace-cmd(1)_
> -
> -AUTHOR
> -------
> -[verse]
> ---
> -*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> -*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> ---
> -REPORTING BUGS
> ---------------
> -Report bugs to  <linux-trace-devel@vger.kernel.org>
> -
> -LICENSE
> --------
> -libtraceevent is Free Software licensed under the GNU LGPL 2.1
> -
> -RESOURCES
> ----------
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> diff --git a/tools/lib/traceevent/Documentation/manpage-1.72.xsl b/tools/lib/traceevent/Documentation/manpage-1.72.xsl
> deleted file mode 100644
> index b4d315cb8c47..000000000000
> --- a/tools/lib/traceevent/Documentation/manpage-1.72.xsl
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -<!-- manpage-1.72.xsl:
> -     special settings for manpages rendered from asciidoc+docbook
> -     handles peculiarities in docbook-xsl 1.72.0 -->
> -<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
> -		version="1.0">
> -
> -<xsl:import href="manpage-base.xsl"/>
> -
> -<!-- these are the special values for the roff control characters
> -     needed for docbook-xsl 1.72.0 -->
> -<xsl:param name="git.docbook.backslash">&#x2593;</xsl:param>
> -<xsl:param name="git.docbook.dot"      >&#x2302;</xsl:param>
> -
> -</xsl:stylesheet>
> diff --git a/tools/lib/traceevent/Documentation/manpage-base.xsl b/tools/lib/traceevent/Documentation/manpage-base.xsl
> deleted file mode 100644
> index a264fa616093..000000000000
> --- a/tools/lib/traceevent/Documentation/manpage-base.xsl
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -<!-- manpage-base.xsl:
> -     special formatting for manpages rendered from asciidoc+docbook -->
> -<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
> -		version="1.0">
> -
> -<!-- these params silence some output from xmlto -->
> -<xsl:param name="man.output.quietly" select="1"/>
> -<xsl:param name="refentry.meta.get.quietly" select="1"/>
> -
> -<!-- convert asciidoc callouts to man page format;
> -     git.docbook.backslash and git.docbook.dot params
> -     must be supplied by another XSL file or other means -->
> -<xsl:template match="co">
> -	<xsl:value-of select="concat(
> -			      $git.docbook.backslash,'fB(',
> -			      substring-after(@id,'-'),')',
> -			      $git.docbook.backslash,'fR')"/>
> -</xsl:template>
> -<xsl:template match="calloutlist">
> -	<xsl:value-of select="$git.docbook.dot"/>
> -	<xsl:text>sp&#10;</xsl:text>
> -	<xsl:apply-templates/>
> -	<xsl:text>&#10;</xsl:text>
> -</xsl:template>
> -<xsl:template match="callout">
> -	<xsl:value-of select="concat(
> -			      $git.docbook.backslash,'fB',
> -			      substring-after(@arearefs,'-'),
> -			      '. ',$git.docbook.backslash,'fR')"/>
> -	<xsl:apply-templates/>
> -	<xsl:value-of select="$git.docbook.dot"/>
> -	<xsl:text>br&#10;</xsl:text>
> -</xsl:template>
> -
> -</xsl:stylesheet>
> diff --git a/tools/lib/traceevent/Documentation/manpage-bold-literal.xsl b/tools/lib/traceevent/Documentation/manpage-bold-literal.xsl
> deleted file mode 100644
> index 608eb5df6281..000000000000
> --- a/tools/lib/traceevent/Documentation/manpage-bold-literal.xsl
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -<!-- manpage-bold-literal.xsl:
> -     special formatting for manpages rendered from asciidoc+docbook -->
> -<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
> -		version="1.0">
> -
> -<!-- render literal text as bold (instead of plain or monospace);
> -     this makes literal text easier to distinguish in manpages
> -     viewed on a tty -->
> -<xsl:template match="literal">
> -	<xsl:value-of select="$git.docbook.backslash"/>
> -	<xsl:text>fB</xsl:text>
> -	<xsl:apply-templates/>
> -	<xsl:value-of select="$git.docbook.backslash"/>
> -	<xsl:text>fR</xsl:text>
> -</xsl:template>
> -
> -</xsl:stylesheet>
> diff --git a/tools/lib/traceevent/Documentation/manpage-normal.xsl b/tools/lib/traceevent/Documentation/manpage-normal.xsl
> deleted file mode 100644
> index a48f5b11f3dc..000000000000
> --- a/tools/lib/traceevent/Documentation/manpage-normal.xsl
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -<!-- manpage-normal.xsl:
> -     special settings for manpages rendered from asciidoc+docbook
> -     handles anything we want to keep away from docbook-xsl 1.72.0 -->
> -<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
> -		version="1.0">
> -
> -<xsl:import href="manpage-base.xsl"/>
> -
> -<!-- these are the normal values for the roff control characters -->
> -<xsl:param name="git.docbook.backslash">\</xsl:param>
> -<xsl:param name="git.docbook.dot"	>.</xsl:param>
> -
> -</xsl:stylesheet>
> diff --git a/tools/lib/traceevent/Documentation/manpage-suppress-sp.xsl b/tools/lib/traceevent/Documentation/manpage-suppress-sp.xsl
> deleted file mode 100644
> index a63c7632a87d..000000000000
> --- a/tools/lib/traceevent/Documentation/manpage-suppress-sp.xsl
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -<!-- manpage-suppress-sp.xsl:
> -     special settings for manpages rendered from asciidoc+docbook
> -     handles erroneous, inline .sp in manpage output of some
> -     versions of docbook-xsl -->
> -<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
> -		version="1.0">
> -
> -<!-- attempt to work around spurious .sp at the tail of the line
> -     that some versions of docbook stylesheets seem to add -->
> -<xsl:template match="simpara">
> -  <xsl:variable name="content">
> -    <xsl:apply-templates/>
> -  </xsl:variable>
> -  <xsl:value-of select="normalize-space($content)"/>
> -  <xsl:if test="not(ancestor::authorblurb) and
> -                not(ancestor::personblurb)">
> -    <xsl:text>&#10;&#10;</xsl:text>
> -  </xsl:if>
> -</xsl:template>
> -
> -</xsl:stylesheet>
> diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
> deleted file mode 100644
> index 98dfd4badea3..000000000000
> --- a/tools/lib/traceevent/Makefile
> +++ /dev/null
> @@ -1,300 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -# trace-cmd version
> -EP_VERSION = 1
> -EP_PATCHLEVEL = 1
> -EP_EXTRAVERSION = 0
> -
> -# file format version
> -FILE_VERSION = 6
> -
> -MAKEFLAGS += --no-print-directory
> -
> -
> -# Makefiles suck: This macro sets a default value of $(2) for the
> -# variable named by $(1), unless the variable has been set by
> -# environment or command line. This is necessary for CC and AR
> -# because make sets default values, so the simpler ?= approach
> -# won't work as expected.
> -define allow-override
> -  $(if $(or $(findstring environment,$(origin $(1))),\
> -            $(findstring command line,$(origin $(1)))),,\
> -    $(eval $(1) = $(2)))
> -endef
> -
> -# Allow setting CC and AR, or setting CROSS_COMPILE as a prefix.
> -$(call allow-override,CC,$(CROSS_COMPILE)gcc)
> -$(call allow-override,AR,$(CROSS_COMPILE)ar)
> -$(call allow-override,NM,$(CROSS_COMPILE)nm)
> -$(call allow-override,PKG_CONFIG,pkg-config)
> -
> -EXT = -std=gnu99
> -INSTALL = install
> -
> -# Use DESTDIR for installing into a different root directory.
> -# This is useful for building a package. The program will be
> -# installed in this directory as if it was the root directory.
> -# Then the build tool can move it later.
> -DESTDIR ?=
> -DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
> -
> -LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
> -ifeq ($(LP64), 1)
> -  libdir_relative_temp = lib64
> -else
> -  libdir_relative_temp = lib
> -endif
> -
> -libdir_relative ?= $(libdir_relative_temp)
> -prefix ?= /usr/local
> -libdir = $(prefix)/$(libdir_relative)
> -man_dir = $(prefix)/share/man
> -man_dir_SQ = '$(subst ','\'',$(man_dir))'
> -pkgconfig_dir ?= $(word 1,$(shell $(PKG_CONFIG) 		\
> -			--variable pc_path pkg-config | tr ":" " "))
> -includedir_relative = traceevent
> -includedir = $(prefix)/include/$(includedir_relative)
> -includedir_SQ = '$(subst ','\'',$(includedir))'
> -
> -export man_dir man_dir_SQ INSTALL
> -export DESTDIR DESTDIR_SQ
> -export EVENT_PARSE_VERSION
> -
> -include ../../scripts/Makefile.include
> -
> -# copy a bit from Linux kbuild
> -
> -ifeq ("$(origin V)", "command line")
> -  VERBOSE = $(V)
> -endif
> -ifndef VERBOSE
> -  VERBOSE = 0
> -endif
> -
> -ifeq ($(srctree),)
> -srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> -srctree := $(patsubst %/,%,$(dir $(srctree)))
> -srctree := $(patsubst %/,%,$(dir $(srctree)))
> -#$(info Determined 'srctree' to be $(srctree))
> -endif
> -
> -export prefix libdir src obj
> -
> -# Shell quotes
> -libdir_SQ = $(subst ','\'',$(libdir))
> -libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
> -
> -CONFIG_INCLUDES = 
> -CONFIG_LIBS	=
> -CONFIG_FLAGS	=
> -
> -VERSION		= $(EP_VERSION)
> -PATCHLEVEL	= $(EP_PATCHLEVEL)
> -EXTRAVERSION	= $(EP_EXTRAVERSION)
> -
> -OBJ		= $@
> -N		=
> -
> -EVENT_PARSE_VERSION = $(EP_VERSION).$(EP_PATCHLEVEL).$(EP_EXTRAVERSION)
> -
> -LIB_TARGET  = libtraceevent.a libtraceevent.so.$(EVENT_PARSE_VERSION)
> -LIB_INSTALL = libtraceevent.a libtraceevent.so*
> -LIB_INSTALL := $(addprefix $(OUTPUT),$(LIB_INSTALL))
> -
> -INCLUDES = -I. -I $(srctree)/tools/include $(CONFIG_INCLUDES)
> -
> -# Set compile option CFLAGS
> -ifdef EXTRA_CFLAGS
> -  CFLAGS := $(EXTRA_CFLAGS)
> -else
> -  CFLAGS := -g -Wall
> -endif
> -
> -# Append required CFLAGS
> -override CFLAGS += -fPIC
> -override CFLAGS += $(CONFIG_FLAGS) $(INCLUDES) $(PLUGIN_DIR_SQ)
> -override CFLAGS += $(udis86-flags) -D_GNU_SOURCE
> -
> -ifeq ($(VERBOSE),1)
> -  Q =
> -else
> -  Q = @
> -endif
> -
> -# Disable command line variables (CFLAGS) override from top
> -# level Makefile (perf), otherwise build Makefile will get
> -# the same command line setup.
> -MAKEOVERRIDES=
> -
> -export srctree OUTPUT CC LD CFLAGS V
> -build := -f $(srctree)/tools/build/Makefile.build dir=. obj
> -
> -TE_IN      := $(OUTPUT)libtraceevent-in.o
> -LIB_TARGET := $(addprefix $(OUTPUT),$(LIB_TARGET))
> -
> -CMD_TARGETS = $(LIB_TARGET)
> -
> -TARGETS = $(CMD_TARGETS)
> -
> -all: all_cmd plugins
> -
> -all_cmd: $(CMD_TARGETS)
> -
> -$(TE_IN): force
> -	$(Q)$(MAKE) $(build)=libtraceevent
> -
> -$(OUTPUT)libtraceevent.so.$(EVENT_PARSE_VERSION): $(TE_IN)
> -	$(QUIET_LINK)$(CC) --shared $(LDFLAGS) $^ -Wl,-soname,libtraceevent.so.$(EP_VERSION) -o $@
> -	@ln -sf $(@F) $(OUTPUT)libtraceevent.so
> -	@ln -sf $(@F) $(OUTPUT)libtraceevent.so.$(EP_VERSION)
> -
> -$(OUTPUT)libtraceevent.a: $(TE_IN)
> -	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
> -
> -$(OUTPUT)%.so: $(OUTPUT)%-in.o
> -	$(QUIET_LINK)$(CC) $(CFLAGS) -shared $(LDFLAGS) -nostartfiles -o $@ $^
> -
> -define make_version.h
> -  (echo '/* This file is automatically generated. Do not modify. */';		\
> -   echo \#define VERSION_CODE $(shell						\
> -   expr $(VERSION) \* 256 + $(PATCHLEVEL));					\
> -   echo '#define EXTRAVERSION ' $(EXTRAVERSION);				\
> -   echo '#define VERSION_STRING "'$(VERSION).$(PATCHLEVEL).$(EXTRAVERSION)'"';	\
> -   echo '#define FILE_VERSION '$(FILE_VERSION);					\
> -  ) > $1
> -endef
> -
> -define update_version.h
> -  ($(call make_version.h, $@.tmp);		\
> -    if [ -r $@ ] && cmp -s $@ $@.tmp; then	\
> -      rm -f $@.tmp;				\
> -    else					\
> -      echo '  UPDATE                 $@';	\
> -      mv -f $@.tmp $@;				\
> -    fi);
> -endef
> -
> -ep_version.h: force
> -	$(Q)$(N)$(call update_version.h)
> -
> -VERSION_FILES = ep_version.h
> -
> -define update_dir
> -  (echo $1 > $@.tmp;				\
> -   if [ -r $@ ] && cmp -s $@ $@.tmp; then	\
> -     rm -f $@.tmp;				\
> -   else						\
> -     echo '  UPDATE                 $@';	\
> -     mv -f $@.tmp $@;				\
> -   fi);
> -endef
> -
> -tags:	force
> -	$(RM) tags
> -	find . -name '*.[ch]' | xargs ctags --extra=+f --c-kinds=+px \
> -	--regex-c++='/_PE\(([^,)]*).*/TEP_ERRNO__\1/'
> -
> -TAGS:	force
> -	$(RM) TAGS
> -	find . -name '*.[ch]' | xargs etags \
> -	--regex='/_PE(\([^,)]*\).*/TEP_ERRNO__\1/'
> -
> -define do_install_mkdir
> -	if [ ! -d '$(DESTDIR_SQ)$1' ]; then		\
> -		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1';	\
> -	fi
> -endef
> -
> -define do_install
> -	$(call do_install_mkdir,$2);			\
> -	$(INSTALL) $(if $3,-m $3,) $1 '$(DESTDIR_SQ)$2'
> -endef
> -
> -PKG_CONFIG_SOURCE_FILE = libtraceevent.pc
> -PKG_CONFIG_FILE := $(addprefix $(OUTPUT),$(PKG_CONFIG_SOURCE_FILE))
> -define do_install_pkgconfig_file
> -	if [ -n "${pkgconfig_dir}" ]; then 					\
> -		cp -f ${PKG_CONFIG_SOURCE_FILE}.template ${PKG_CONFIG_FILE};	\
> -		sed -i "s|INSTALL_PREFIX|${1}|g" ${PKG_CONFIG_FILE}; 		\
> -		sed -i "s|LIB_VERSION|${EVENT_PARSE_VERSION}|g" ${PKG_CONFIG_FILE}; \
> -		sed -i "s|LIB_DIR|${libdir}|g" ${PKG_CONFIG_FILE}; \
> -		sed -i "s|HEADER_DIR|$(includedir)|g" ${PKG_CONFIG_FILE}; \
> -		$(call do_install,$(PKG_CONFIG_FILE),$(pkgconfig_dir),644); 	\
> -	else 									\
> -		(echo Failed to locate pkg-config directory) 1>&2;		\
> -	fi
> -endef
> -
> -install_lib: all_cmd install_plugins install_headers install_pkgconfig
> -	$(call QUIET_INSTALL, $(LIB_TARGET)) \
> -		$(call do_install_mkdir,$(libdir_SQ)); \
> -		cp -fpR $(LIB_INSTALL) $(DESTDIR)$(libdir_SQ)
> -
> -install_pkgconfig:
> -	$(call QUIET_INSTALL, $(PKG_CONFIG_FILE)) \
> -		$(call do_install_pkgconfig_file,$(prefix))
> -
> -install_headers:
> -	$(call QUIET_INSTALL, traceevent_headers) \
> -		$(call do_install,event-parse.h,$(includedir_SQ),644); \
> -		$(call do_install,event-utils.h,$(includedir_SQ),644); \
> -		$(call do_install,trace-seq.h,$(includedir_SQ),644); \
> -		$(call do_install,kbuffer.h,$(includedir_SQ),644);
> -
> -install: install_lib
> -
> -clean: clean_plugins
> -	$(call QUIET_CLEAN, libtraceevent) \
> -		$(RM) *.o *~ $(TARGETS) *.a *.so $(VERSION_FILES) .*.d .*.cmd; \
> -		$(RM) TRACEEVENT-CFLAGS tags TAGS; \
> -		$(RM) $(PKG_CONFIG_FILE)
> -
> -PHONY += doc
> -doc:
> -	$(call descend,Documentation)
> -
> -PHONY += doc-clean
> -doc-clean:
> -	$(call descend,Documentation,clean)
> -
> -PHONY += doc-install
> -doc-install:
> -	$(call descend,Documentation,install)
> -
> -PHONY += doc-uninstall
> -doc-uninstall:
> -	$(call descend,Documentation,uninstall)
> -
> -PHONY += help
> -help:
> -	@echo 'Possible targets:'
> -	@echo''
> -	@echo '  all                 - default, compile the library and the'\
> -				      'plugins'
> -	@echo '  plugins             - compile the plugins'
> -	@echo '  install             - install the library, the plugins,'\
> -					'the header and pkgconfig files'
> -	@echo '  clean               - clean the library and the plugins object files'
> -	@echo '  doc                 - compile the documentation files - man'\
> -					'and html pages, in the Documentation directory'
> -	@echo '  doc-clean           - clean the documentation files'
> -	@echo '  doc-install         - install the man pages'
> -	@echo '  doc-uninstall       - uninstall the man pages'
> -	@echo''
> -
> -PHONY += plugins
> -plugins:
> -	$(call descend,plugins)
> -
> -PHONY += install_plugins
> -install_plugins:
> -	$(call descend,plugins,install)
> -
> -PHONY += clean_plugins
> -clean_plugins:
> -	$(call descend,plugins,clean)
> -
> -force:
> -
> -# Declare the contents of the .PHONY variable as phony.  We keep that
> -# information in a variable so we can use it in if_changed and friends.
> -.PHONY: $(PHONY)
> diff --git a/tools/lib/traceevent/event-parse-api.c b/tools/lib/traceevent/event-parse-api.c
> deleted file mode 100644
> index f8361e45d446..000000000000
> --- a/tools/lib/traceevent/event-parse-api.c
> +++ /dev/null
> @@ -1,333 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - *
> - */
> -
> -#include "event-parse.h"
> -#include "event-parse-local.h"
> -#include "event-utils.h"
> -
> -/**
> - * tep_get_event - returns the event with the given index
> - * @tep: a handle to the tep_handle
> - * @index: index of the requested event, in the range 0 .. nr_events
> - *
> - * This returns pointer to the element of the events array with the given index
> - * If @tep is NULL, or @index is not in the range 0 .. nr_events, NULL is returned.
> - */
> -struct tep_event *tep_get_event(struct tep_handle *tep, int index)
> -{
> -	if (tep && tep->events && index < tep->nr_events)
> -		return tep->events[index];
> -
> -	return NULL;
> -}
> -
> -/**
> - * tep_get_first_event - returns the first event in the events array
> - * @tep: a handle to the tep_handle
> - *
> - * This returns pointer to the first element of the events array
> - * If @tep is NULL, NULL is returned.
> - */
> -struct tep_event *tep_get_first_event(struct tep_handle *tep)
> -{
> -	return tep_get_event(tep, 0);
> -}
> -
> -/**
> - * tep_get_events_count - get the number of defined events
> - * @tep: a handle to the tep_handle
> - *
> - * This returns number of elements in event array
> - * If @tep is NULL, 0 is returned.
> - */
> -int tep_get_events_count(struct tep_handle *tep)
> -{
> -	if (tep)
> -		return tep->nr_events;
> -	return 0;
> -}
> -
> -/**
> - * tep_set_flag - set event parser flag
> - * @tep: a handle to the tep_handle
> - * @flag: flag, or combination of flags to be set
> - * can be any combination from enum tep_flag
> - *
> - * This sets a flag or combination of flags from enum tep_flag
> - */
> -void tep_set_flag(struct tep_handle *tep, int flag)
> -{
> -	if (tep)
> -		tep->flags |= flag;
> -}
> -
> -/**
> - * tep_clear_flag - clear event parser flag
> - * @tep: a handle to the tep_handle
> - * @flag: flag to be cleared
> - *
> - * This clears a tep flag
> - */
> -void tep_clear_flag(struct tep_handle *tep, enum tep_flag flag)
> -{
> -	if (tep)
> -		tep->flags &= ~flag;
> -}
> -
> -/**
> - * tep_test_flag - check the state of event parser flag
> - * @tep: a handle to the tep_handle
> - * @flag: flag to be checked
> - *
> - * This returns the state of the requested tep flag.
> - * Returns: true if the flag is set, false otherwise.
> - */
> -bool tep_test_flag(struct tep_handle *tep, enum tep_flag flag)
> -{
> -	if (tep)
> -		return tep->flags & flag;
> -	return false;
> -}
> -
> -__hidden unsigned short data2host2(struct tep_handle *tep, unsigned short data)
> -{
> -	unsigned short swap;
> -
> -	if (!tep || tep->host_bigendian == tep->file_bigendian)
> -		return data;
> -
> -	swap = ((data & 0xffULL) << 8) |
> -		((data & (0xffULL << 8)) >> 8);
> -
> -	return swap;
> -}
> -
> -__hidden unsigned int data2host4(struct tep_handle *tep, unsigned int data)
> -{
> -	unsigned int swap;
> -
> -	if (!tep || tep->host_bigendian == tep->file_bigendian)
> -		return data;
> -
> -	swap = ((data & 0xffULL) << 24) |
> -		((data & (0xffULL << 8)) << 8) |
> -		((data & (0xffULL << 16)) >> 8) |
> -		((data & (0xffULL << 24)) >> 24);
> -
> -	return swap;
> -}
> -
> -__hidden  unsigned long long
> -data2host8(struct tep_handle *tep, unsigned long long data)
> -{
> -	unsigned long long swap;
> -
> -	if (!tep || tep->host_bigendian == tep->file_bigendian)
> -		return data;
> -
> -	swap = ((data & 0xffULL) << 56) |
> -		((data & (0xffULL << 8)) << 40) |
> -		((data & (0xffULL << 16)) << 24) |
> -		((data & (0xffULL << 24)) << 8) |
> -		((data & (0xffULL << 32)) >> 8) |
> -		((data & (0xffULL << 40)) >> 24) |
> -		((data & (0xffULL << 48)) >> 40) |
> -		((data & (0xffULL << 56)) >> 56);
> -
> -	return swap;
> -}
> -
> -/**
> - * tep_get_header_page_size - get size of the header page
> - * @tep: a handle to the tep_handle
> - *
> - * This returns size of the header page
> - * If @tep is NULL, 0 is returned.
> - */
> -int tep_get_header_page_size(struct tep_handle *tep)
> -{
> -	if (tep)
> -		return tep->header_page_size_size;
> -	return 0;
> -}
> -
> -/**
> - * tep_get_header_timestamp_size - get size of the timestamp in the header page
> - * @tep: a handle to the tep_handle
> - *
> - * This returns size of the timestamp in the header page
> - * If @tep is NULL, 0 is returned.
> - */
> -int tep_get_header_timestamp_size(struct tep_handle *tep)
> -{
> -	if (tep)
> -		return tep->header_page_ts_size;
> -	return 0;
> -}
> -
> -/**
> - * tep_get_cpus - get the number of CPUs
> - * @tep: a handle to the tep_handle
> - *
> - * This returns the number of CPUs
> - * If @tep is NULL, 0 is returned.
> - */
> -int tep_get_cpus(struct tep_handle *tep)
> -{
> -	if (tep)
> -		return tep->cpus;
> -	return 0;
> -}
> -
> -/**
> - * tep_set_cpus - set the number of CPUs
> - * @tep: a handle to the tep_handle
> - *
> - * This sets the number of CPUs
> - */
> -void tep_set_cpus(struct tep_handle *tep, int cpus)
> -{
> -	if (tep)
> -		tep->cpus = cpus;
> -}
> -
> -/**
> - * tep_get_long_size - get the size of a long integer on the traced machine
> - * @tep: a handle to the tep_handle
> - *
> - * This returns the size of a long integer on the traced machine
> - * If @tep is NULL, 0 is returned.
> - */
> -int tep_get_long_size(struct tep_handle *tep)
> -{
> -	if (tep)
> -		return tep->long_size;
> -	return 0;
> -}
> -
> -/**
> - * tep_set_long_size - set the size of a long integer on the traced machine
> - * @tep: a handle to the tep_handle
> - * @size: size, in bytes, of a long integer
> - *
> - * This sets the size of a long integer on the traced machine
> - */
> -void tep_set_long_size(struct tep_handle *tep, int long_size)
> -{
> -	if (tep)
> -		tep->long_size = long_size;
> -}
> -
> -/**
> - * tep_get_page_size - get the size of a memory page on the traced machine
> - * @tep: a handle to the tep_handle
> - *
> - * This returns the size of a memory page on the traced machine
> - * If @tep is NULL, 0 is returned.
> - */
> -int tep_get_page_size(struct tep_handle *tep)
> -{
> -	if (tep)
> -		return tep->page_size;
> -	return 0;
> -}
> -
> -/**
> - * tep_set_page_size - set the size of a memory page on the traced machine
> - * @tep: a handle to the tep_handle
> - * @_page_size: size of a memory page, in bytes
> - *
> - * This sets the size of a memory page on the traced machine
> - */
> -void tep_set_page_size(struct tep_handle *tep, int _page_size)
> -{
> -	if (tep)
> -		tep->page_size = _page_size;
> -}
> -
> -/**
> - * tep_is_file_bigendian - return the endian of the file
> - * @tep: a handle to the tep_handle
> - *
> - * This returns true if the file is in big endian order
> - * If @tep is NULL, false is returned.
> - */
> -bool tep_is_file_bigendian(struct tep_handle *tep)
> -{
> -	if (tep)
> -		return (tep->file_bigendian == TEP_BIG_ENDIAN);
> -	return false;
> -}
> -
> -/**
> - * tep_set_file_bigendian - set if the file is in big endian order
> - * @tep: a handle to the tep_handle
> - * @endian: non zero, if the file is in big endian order
> - *
> - * This sets if the file is in big endian order
> - */
> -void tep_set_file_bigendian(struct tep_handle *tep, enum tep_endian endian)
> -{
> -	if (tep)
> -		tep->file_bigendian = endian;
> -}
> -
> -/**
> - * tep_is_local_bigendian - return the endian of the saved local machine
> - * @tep: a handle to the tep_handle
> - *
> - * This returns true if the saved local machine in @tep is big endian.
> - * If @tep is NULL, false is returned.
> - */
> -bool tep_is_local_bigendian(struct tep_handle *tep)
> -{
> -	if (tep)
> -		return (tep->host_bigendian == TEP_BIG_ENDIAN);
> -	return 0;
> -}
> -
> -/**
> - * tep_set_local_bigendian - set the stored local machine endian order
> - * @tep: a handle to the tep_handle
> - * @endian: non zero, if the local host has big endian order
> - *
> - * This sets the endian order for the local machine.
> - */
> -void tep_set_local_bigendian(struct tep_handle *tep, enum tep_endian endian)
> -{
> -	if (tep)
> -		tep->host_bigendian = endian;
> -}
> -
> -/**
> - * tep_is_old_format - get if an old kernel is used
> - * @tep: a handle to the tep_handle
> - *
> - * This returns true, if an old kernel is used to generate the tracing events or
> - * false if a new kernel is used. Old kernels did not have header page info.
> - * If @tep is NULL, false is returned.
> - */
> -bool tep_is_old_format(struct tep_handle *tep)
> -{
> -	if (tep)
> -		return tep->old_format;
> -	return false;
> -}
> -
> -/**
> - * tep_set_test_filters - set a flag to test a filter string
> - * @tep: a handle to the tep_handle
> - * @test_filters: the new value of the test_filters flag
> - *
> - * This sets a flag to test a filter string. If this flag is set, when
> - * tep_filter_add_filter_str() API as called,it will print the filter string
> - * instead of adding it.
> - */
> -void tep_set_test_filters(struct tep_handle *tep, int test_filters)
> -{
> -	if (tep)
> -		tep->test_filters = test_filters;
> -}
> diff --git a/tools/lib/traceevent/event-parse-local.h b/tools/lib/traceevent/event-parse-local.h
> deleted file mode 100644
> index fd4bbcfbb849..000000000000
> --- a/tools/lib/traceevent/event-parse-local.h
> +++ /dev/null
> @@ -1,123 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - *
> - */
> -
> -#ifndef _PARSE_EVENTS_INT_H
> -#define _PARSE_EVENTS_INT_H
> -
> -struct tep_cmdline;
> -struct cmdline_list;
> -struct func_map;
> -struct func_list;
> -struct event_handler;
> -struct func_resolver;
> -struct tep_plugins_dir;
> -
> -#define __hidden __attribute__((visibility ("hidden")))
> -
> -struct tep_handle {
> -	int ref_count;
> -
> -	int header_page_ts_offset;
> -	int header_page_ts_size;
> -	int header_page_size_offset;
> -	int header_page_size_size;
> -	int header_page_data_offset;
> -	int header_page_data_size;
> -	int header_page_overwrite;
> -
> -	enum tep_endian file_bigendian;
> -	enum tep_endian host_bigendian;
> -
> -	int old_format;
> -
> -	int cpus;
> -	int long_size;
> -	int page_size;
> -
> -	struct tep_cmdline *cmdlines;
> -	struct cmdline_list *cmdlist;
> -	int cmdline_count;
> -
> -	struct func_map *func_map;
> -	struct func_resolver *func_resolver;
> -	struct func_list *funclist;
> -	unsigned int func_count;
> -
> -	struct printk_map *printk_map;
> -	struct printk_list *printklist;
> -	unsigned int printk_count;
> -
> -	struct tep_event **events;
> -	int nr_events;
> -	struct tep_event **sort_events;
> -	enum tep_event_sort_type last_type;
> -
> -	int type_offset;
> -	int type_size;
> -
> -	int pid_offset;
> -	int pid_size;
> -
> -	int pc_offset;
> -	int pc_size;
> -
> -	int flags_offset;
> -	int flags_size;
> -
> -	int ld_offset;
> -	int ld_size;
> -
> -	int test_filters;
> -
> -	int flags;
> -
> -	struct tep_format_field *bprint_ip_field;
> -	struct tep_format_field *bprint_fmt_field;
> -	struct tep_format_field *bprint_buf_field;
> -
> -	struct event_handler *handlers;
> -	struct tep_function_handler *func_handlers;
> -
> -	/* cache */
> -	struct tep_event *last_event;
> -
> -	struct tep_plugins_dir *plugins_dir;
> -};
> -
> -enum tep_print_parse_type {
> -	PRINT_FMT_STRING,
> -	PRINT_FMT_ARG_DIGIT,
> -	PRINT_FMT_ARG_POINTER,
> -	PRINT_FMT_ARG_STRING,
> -};
> -
> -struct tep_print_parse {
> -	struct tep_print_parse	*next;
> -
> -	char				*format;
> -	int				ls;
> -	enum tep_print_parse_type	type;
> -	struct tep_print_arg		*arg;
> -	struct tep_print_arg		*len_as_arg;
> -};
> -
> -void free_tep_event(struct tep_event *event);
> -void free_tep_format_field(struct tep_format_field *field);
> -void free_tep_plugin_paths(struct tep_handle *tep);
> -
> -unsigned short data2host2(struct tep_handle *tep, unsigned short data);
> -unsigned int data2host4(struct tep_handle *tep, unsigned int data);
> -unsigned long long data2host8(struct tep_handle *tep, unsigned long long data);
> -
> -/* access to the internal parser */
> -int peek_char(void);
> -void init_input_buf(const char *buf, unsigned long long size);
> -unsigned long long get_input_buf_ptr(void);
> -const char *get_input_buf(void);
> -enum tep_event_type read_token(char **tok);
> -void free_token(char *tok);
> -
> -#endif /* _PARSE_EVENTS_INT_H */
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> deleted file mode 100644
> index 8e24c4c78c7f..000000000000
> --- a/tools/lib/traceevent/event-parse.c
> +++ /dev/null
> @@ -1,7624 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - *
> - *
> - *  The parts for function graph printing was taken and modified from the
> - *  Linux Kernel that were written by
> - *    - Copyright (C) 2009  Frederic Weisbecker,
> - *  Frederic Weisbecker gave his permission to relicense the code to
> - *  the Lesser General Public License.
> - */
> -#include <inttypes.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <stdarg.h>
> -#include <ctype.h>
> -#include <errno.h>
> -#include <stdint.h>
> -#include <limits.h>
> -#include <linux/time64.h>
> -
> -#include <netinet/in.h>
> -#include "event-parse.h"
> -
> -#include "event-parse-local.h"
> -#include "event-utils.h"
> -#include "trace-seq.h"
> -
> -static const char *input_buf;
> -static unsigned long long input_buf_ptr;
> -static unsigned long long input_buf_siz;
> -
> -static int is_flag_field;
> -static int is_symbolic_field;
> -
> -static int show_warning = 1;
> -
> -#define do_warning(fmt, ...)				\
> -	do {						\
> -		if (show_warning)			\
> -			warning(fmt, ##__VA_ARGS__);	\
> -	} while (0)
> -
> -#define do_warning_event(event, fmt, ...)			\
> -	do {							\
> -		if (!show_warning)				\
> -			continue;				\
> -								\
> -		if (event)					\
> -			warning("[%s:%s] " fmt, event->system,	\
> -				event->name, ##__VA_ARGS__);	\
> -		else						\
> -			warning(fmt, ##__VA_ARGS__);		\
> -	} while (0)
> -
> -/**
> - * init_input_buf - init buffer for parsing
> - * @buf: buffer to parse
> - * @size: the size of the buffer
> - *
> - * Initializes the internal buffer that tep_read_token() will parse.
> - */
> -__hidden void init_input_buf(const char *buf, unsigned long long size)
> -{
> -	input_buf = buf;
> -	input_buf_siz = size;
> -	input_buf_ptr = 0;
> -}
> -
> -__hidden const char *get_input_buf(void)
> -{
> -	return input_buf;
> -}
> -
> -__hidden unsigned long long get_input_buf_ptr(void)
> -{
> -	return input_buf_ptr;
> -}
> -
> -struct event_handler {
> -	struct event_handler		*next;
> -	int				id;
> -	const char			*sys_name;
> -	const char			*event_name;
> -	tep_event_handler_func		func;
> -	void				*context;
> -};
> -
> -struct func_params {
> -	struct func_params	*next;
> -	enum tep_func_arg_type	type;
> -};
> -
> -struct tep_function_handler {
> -	struct tep_function_handler	*next;
> -	enum tep_func_arg_type		ret_type;
> -	char				*name;
> -	tep_func_handler		func;
> -	struct func_params		*params;
> -	int				nr_args;
> -};
> -
> -static unsigned long long
> -process_defined_func(struct trace_seq *s, void *data, int size,
> -		     struct tep_event *event, struct tep_print_arg *arg);
> -
> -static void free_func_handle(struct tep_function_handler *func);
> -
> -void breakpoint(void)
> -{
> -	static int x;
> -	x++;
> -}
> -
> -static struct tep_print_arg *alloc_arg(void)
> -{
> -	return calloc(1, sizeof(struct tep_print_arg));
> -}
> -
> -struct tep_cmdline {
> -	char *comm;
> -	int pid;
> -};
> -
> -static int cmdline_cmp(const void *a, const void *b)
> -{
> -	const struct tep_cmdline *ca = a;
> -	const struct tep_cmdline *cb = b;
> -
> -	if (ca->pid < cb->pid)
> -		return -1;
> -	if (ca->pid > cb->pid)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -/* Looking for where to place the key */
> -static int cmdline_slot_cmp(const void *a, const void *b)
> -{
> -	const struct tep_cmdline *ca = a;
> -	const struct tep_cmdline *cb = b;
> -	const struct tep_cmdline *cb1 = cb + 1;
> -
> -	if (ca->pid < cb->pid)
> -		return -1;
> -
> -	if (ca->pid > cb->pid) {
> -		if (ca->pid <= cb1->pid)
> -			return 0;
> -		return 1;
> -	}
> -
> -	return 0;
> -}
> -
> -struct cmdline_list {
> -	struct cmdline_list	*next;
> -	char			*comm;
> -	int			pid;
> -};
> -
> -static int cmdline_init(struct tep_handle *tep)
> -{
> -	struct cmdline_list *cmdlist = tep->cmdlist;
> -	struct cmdline_list *item;
> -	struct tep_cmdline *cmdlines;
> -	int i;
> -
> -	cmdlines = malloc(sizeof(*cmdlines) * tep->cmdline_count);
> -	if (!cmdlines)
> -		return -1;
> -
> -	i = 0;
> -	while (cmdlist) {
> -		cmdlines[i].pid = cmdlist->pid;
> -		cmdlines[i].comm = cmdlist->comm;
> -		i++;
> -		item = cmdlist;
> -		cmdlist = cmdlist->next;
> -		free(item);
> -	}
> -
> -	qsort(cmdlines, tep->cmdline_count, sizeof(*cmdlines), cmdline_cmp);
> -
> -	tep->cmdlines = cmdlines;
> -	tep->cmdlist = NULL;
> -
> -	return 0;
> -}
> -
> -static const char *find_cmdline(struct tep_handle *tep, int pid)
> -{
> -	const struct tep_cmdline *comm;
> -	struct tep_cmdline key;
> -
> -	if (!pid)
> -		return "<idle>";
> -
> -	if (!tep->cmdlines && cmdline_init(tep))
> -		return "<not enough memory for cmdlines!>";
> -
> -	key.pid = pid;
> -
> -	comm = bsearch(&key, tep->cmdlines, tep->cmdline_count,
> -		       sizeof(*tep->cmdlines), cmdline_cmp);
> -
> -	if (comm)
> -		return comm->comm;
> -	return "<...>";
> -}
> -
> -/**
> - * tep_is_pid_registered - return if a pid has a cmdline registered
> - * @tep: a handle to the trace event parser context
> - * @pid: The pid to check if it has a cmdline registered with.
> - *
> - * Returns true if the pid has a cmdline mapped to it
> - * false otherwise.
> - */
> -bool tep_is_pid_registered(struct tep_handle *tep, int pid)
> -{
> -	const struct tep_cmdline *comm;
> -	struct tep_cmdline key;
> -
> -	if (!pid)
> -		return true;
> -
> -	if (!tep->cmdlines && cmdline_init(tep))
> -		return false;
> -
> -	key.pid = pid;
> -
> -	comm = bsearch(&key, tep->cmdlines, tep->cmdline_count,
> -		       sizeof(*tep->cmdlines), cmdline_cmp);
> -
> -	if (comm)
> -		return true;
> -	return false;
> -}
> -
> -/*
> - * If the command lines have been converted to an array, then
> - * we must add this pid. This is much slower than when cmdlines
> - * are added before the array is initialized.
> - */
> -static int add_new_comm(struct tep_handle *tep,
> -			const char *comm, int pid, bool override)
> -{
> -	struct tep_cmdline *cmdlines = tep->cmdlines;
> -	struct tep_cmdline *cmdline;
> -	struct tep_cmdline key;
> -	char *new_comm;
> -	int cnt;
> -
> -	if (!pid)
> -		return 0;
> -
> -	/* avoid duplicates */
> -	key.pid = pid;
> -
> -	cmdline = bsearch(&key, tep->cmdlines, tep->cmdline_count,
> -			  sizeof(*tep->cmdlines), cmdline_cmp);
> -	if (cmdline) {
> -		if (!override) {
> -			errno = EEXIST;
> -			return -1;
> -		}
> -		new_comm = strdup(comm);
> -		if (!new_comm) {
> -			errno = ENOMEM;
> -			return -1;
> -		}
> -		free(cmdline->comm);
> -		cmdline->comm = new_comm;
> -
> -		return 0;
> -	}
> -
> -	cmdlines = realloc(cmdlines, sizeof(*cmdlines) * (tep->cmdline_count + 1));
> -	if (!cmdlines) {
> -		errno = ENOMEM;
> -		return -1;
> -	}
> -	tep->cmdlines = cmdlines;
> -
> -	key.comm = strdup(comm);
> -	if (!key.comm) {
> -		errno = ENOMEM;
> -		return -1;
> -	}
> -
> -	if (!tep->cmdline_count) {
> -		/* no entries yet */
> -		tep->cmdlines[0] = key;
> -		tep->cmdline_count++;
> -		return 0;
> -	}
> -
> -	/* Now find where we want to store the new cmdline */
> -	cmdline = bsearch(&key, tep->cmdlines, tep->cmdline_count - 1,
> -			  sizeof(*tep->cmdlines), cmdline_slot_cmp);
> -
> -	cnt = tep->cmdline_count;
> -	if (cmdline) {
> -		/* cmdline points to the one before the spot we want */
> -		cmdline++;
> -		cnt -= cmdline - tep->cmdlines;
> -
> -	} else {
> -		/* The new entry is either before or after the list */
> -		if (key.pid > tep->cmdlines[tep->cmdline_count - 1].pid) {
> -			tep->cmdlines[tep->cmdline_count++] = key;
> -			return 0;
> -		}
> -		cmdline = &tep->cmdlines[0];
> -	}
> -	memmove(cmdline + 1, cmdline, (cnt * sizeof(*cmdline)));
> -	*cmdline = key;
> -
> -	tep->cmdline_count++;
> -
> -	return 0;
> -}
> -
> -static int _tep_register_comm(struct tep_handle *tep,
> -			      const char *comm, int pid, bool override)
> -{
> -	struct cmdline_list *item;
> -
> -	if (tep->cmdlines)
> -		return add_new_comm(tep, comm, pid, override);
> -
> -	item = malloc(sizeof(*item));
> -	if (!item)
> -		return -1;
> -
> -	if (comm)
> -		item->comm = strdup(comm);
> -	else
> -		item->comm = strdup("<...>");
> -	if (!item->comm) {
> -		free(item);
> -		return -1;
> -	}
> -	item->pid = pid;
> -	item->next = tep->cmdlist;
> -
> -	tep->cmdlist = item;
> -	tep->cmdline_count++;
> -
> -	return 0;
> -}
> -
> -/**
> - * tep_register_comm - register a pid / comm mapping
> - * @tep: a handle to the trace event parser context
> - * @comm: the command line to register
> - * @pid: the pid to map the command line to
> - *
> - * This adds a mapping to search for command line names with
> - * a given pid. The comm is duplicated. If a command with the same pid
> - * already exist, -1 is returned and errno is set to EEXIST
> - */
> -int tep_register_comm(struct tep_handle *tep, const char *comm, int pid)
> -{
> -	return _tep_register_comm(tep, comm, pid, false);
> -}
> -
> -/**
> - * tep_override_comm - register a pid / comm mapping
> - * @tep: a handle to the trace event parser context
> - * @comm: the command line to register
> - * @pid: the pid to map the command line to
> - *
> - * This adds a mapping to search for command line names with
> - * a given pid. The comm is duplicated. If a command with the same pid
> - * already exist, the command string is udapted with the new one
> - */
> -int tep_override_comm(struct tep_handle *tep, const char *comm, int pid)
> -{
> -	if (!tep->cmdlines && cmdline_init(tep)) {
> -		errno = ENOMEM;
> -		return -1;
> -	}
> -	return _tep_register_comm(tep, comm, pid, true);
> -}
> -
> -struct func_map {
> -	unsigned long long		addr;
> -	char				*func;
> -	char				*mod;
> -};
> -
> -struct func_list {
> -	struct func_list	*next;
> -	unsigned long long	addr;
> -	char			*func;
> -	char			*mod;
> -};
> -
> -static int func_cmp(const void *a, const void *b)
> -{
> -	const struct func_map *fa = a;
> -	const struct func_map *fb = b;
> -
> -	if (fa->addr < fb->addr)
> -		return -1;
> -	if (fa->addr > fb->addr)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -/*
> - * We are searching for a record in between, not an exact
> - * match.
> - */
> -static int func_bcmp(const void *a, const void *b)
> -{
> -	const struct func_map *fa = a;
> -	const struct func_map *fb = b;
> -
> -	if ((fa->addr == fb->addr) ||
> -
> -	    (fa->addr > fb->addr &&
> -	     fa->addr < (fb+1)->addr))
> -		return 0;
> -
> -	if (fa->addr < fb->addr)
> -		return -1;
> -
> -	return 1;
> -}
> -
> -static int func_map_init(struct tep_handle *tep)
> -{
> -	struct func_list *funclist;
> -	struct func_list *item;
> -	struct func_map *func_map;
> -	int i;
> -
> -	func_map = malloc(sizeof(*func_map) * (tep->func_count + 1));
> -	if (!func_map)
> -		return -1;
> -
> -	funclist = tep->funclist;
> -
> -	i = 0;
> -	while (funclist) {
> -		func_map[i].func = funclist->func;
> -		func_map[i].addr = funclist->addr;
> -		func_map[i].mod = funclist->mod;
> -		i++;
> -		item = funclist;
> -		funclist = funclist->next;
> -		free(item);
> -	}
> -
> -	qsort(func_map, tep->func_count, sizeof(*func_map), func_cmp);
> -
> -	/*
> -	 * Add a special record at the end.
> -	 */
> -	func_map[tep->func_count].func = NULL;
> -	func_map[tep->func_count].addr = 0;
> -	func_map[tep->func_count].mod = NULL;
> -
> -	tep->func_map = func_map;
> -	tep->funclist = NULL;
> -
> -	return 0;
> -}
> -
> -static struct func_map *
> -__find_func(struct tep_handle *tep, unsigned long long addr)
> -{
> -	struct func_map *func;
> -	struct func_map key;
> -
> -	if (!tep->func_map)
> -		func_map_init(tep);
> -
> -	key.addr = addr;
> -
> -	func = bsearch(&key, tep->func_map, tep->func_count,
> -		       sizeof(*tep->func_map), func_bcmp);
> -
> -	return func;
> -}
> -
> -struct func_resolver {
> -	tep_func_resolver_t	*func;
> -	void			*priv;
> -	struct func_map		map;
> -};
> -
> -/**
> - * tep_set_function_resolver - set an alternative function resolver
> - * @tep: a handle to the trace event parser context
> - * @resolver: function to be used
> - * @priv: resolver function private state.
> - *
> - * Some tools may have already a way to resolve kernel functions, allow them to
> - * keep using it instead of duplicating all the entries inside tep->funclist.
> - */
> -int tep_set_function_resolver(struct tep_handle *tep,
> -			      tep_func_resolver_t *func, void *priv)
> -{
> -	struct func_resolver *resolver = malloc(sizeof(*resolver));
> -
> -	if (resolver == NULL)
> -		return -1;
> -
> -	resolver->func = func;
> -	resolver->priv = priv;
> -
> -	free(tep->func_resolver);
> -	tep->func_resolver = resolver;
> -
> -	return 0;
> -}
> -
> -/**
> - * tep_reset_function_resolver - reset alternative function resolver
> - * @tep: a handle to the trace event parser context
> - *
> - * Stop using whatever alternative resolver was set, use the default
> - * one instead.
> - */
> -void tep_reset_function_resolver(struct tep_handle *tep)
> -{
> -	free(tep->func_resolver);
> -	tep->func_resolver = NULL;
> -}
> -
> -static struct func_map *
> -find_func(struct tep_handle *tep, unsigned long long addr)
> -{
> -	struct func_map *map;
> -
> -	if (!tep->func_resolver)
> -		return __find_func(tep, addr);
> -
> -	map = &tep->func_resolver->map;
> -	map->mod  = NULL;
> -	map->addr = addr;
> -	map->func = tep->func_resolver->func(tep->func_resolver->priv,
> -					     &map->addr, &map->mod);
> -	if (map->func == NULL)
> -		return NULL;
> -
> -	return map;
> -}
> -
> -/**
> - * tep_find_function - find a function by a given address
> - * @tep: a handle to the trace event parser context
> - * @addr: the address to find the function with
> - *
> - * Returns a pointer to the function stored that has the given
> - * address. Note, the address does not have to be exact, it
> - * will select the function that would contain the address.
> - */
> -const char *tep_find_function(struct tep_handle *tep, unsigned long long addr)
> -{
> -	struct func_map *map;
> -
> -	map = find_func(tep, addr);
> -	if (!map)
> -		return NULL;
> -
> -	return map->func;
> -}
> -
> -/**
> - * tep_find_function_address - find a function address by a given address
> - * @tep: a handle to the trace event parser context
> - * @addr: the address to find the function with
> - *
> - * Returns the address the function starts at. This can be used in
> - * conjunction with tep_find_function to print both the function
> - * name and the function offset.
> - */
> -unsigned long long
> -tep_find_function_address(struct tep_handle *tep, unsigned long long addr)
> -{
> -	struct func_map *map;
> -
> -	map = find_func(tep, addr);
> -	if (!map)
> -		return 0;
> -
> -	return map->addr;
> -}
> -
> -/**
> - * tep_register_function - register a function with a given address
> - * @tep: a handle to the trace event parser context
> - * @function: the function name to register
> - * @addr: the address the function starts at
> - * @mod: the kernel module the function may be in (NULL for none)
> - *
> - * This registers a function name with an address and module.
> - * The @func passed in is duplicated.
> - */
> -int tep_register_function(struct tep_handle *tep, char *func,
> -			  unsigned long long addr, char *mod)
> -{
> -	struct func_list *item = malloc(sizeof(*item));
> -
> -	if (!item)
> -		return -1;
> -
> -	item->next = tep->funclist;
> -	item->func = strdup(func);
> -	if (!item->func)
> -		goto out_free;
> -
> -	if (mod) {
> -		item->mod = strdup(mod);
> -		if (!item->mod)
> -			goto out_free_func;
> -	} else
> -		item->mod = NULL;
> -	item->addr = addr;
> -
> -	tep->funclist = item;
> -	tep->func_count++;
> -
> -	return 0;
> -
> -out_free_func:
> -	free(item->func);
> -	item->func = NULL;
> -out_free:
> -	free(item);
> -	errno = ENOMEM;
> -	return -1;
> -}
> -
> -/**
> - * tep_print_funcs - print out the stored functions
> - * @tep: a handle to the trace event parser context
> - *
> - * This prints out the stored functions.
> - */
> -void tep_print_funcs(struct tep_handle *tep)
> -{
> -	int i;
> -
> -	if (!tep->func_map)
> -		func_map_init(tep);
> -
> -	for (i = 0; i < (int)tep->func_count; i++) {
> -		printf("%016llx %s",
> -		       tep->func_map[i].addr,
> -		       tep->func_map[i].func);
> -		if (tep->func_map[i].mod)
> -			printf(" [%s]\n", tep->func_map[i].mod);
> -		else
> -			printf("\n");
> -	}
> -}
> -
> -struct printk_map {
> -	unsigned long long		addr;
> -	char				*printk;
> -};
> -
> -struct printk_list {
> -	struct printk_list	*next;
> -	unsigned long long	addr;
> -	char			*printk;
> -};
> -
> -static int printk_cmp(const void *a, const void *b)
> -{
> -	const struct printk_map *pa = a;
> -	const struct printk_map *pb = b;
> -
> -	if (pa->addr < pb->addr)
> -		return -1;
> -	if (pa->addr > pb->addr)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static int printk_map_init(struct tep_handle *tep)
> -{
> -	struct printk_list *printklist;
> -	struct printk_list *item;
> -	struct printk_map *printk_map;
> -	int i;
> -
> -	printk_map = malloc(sizeof(*printk_map) * (tep->printk_count + 1));
> -	if (!printk_map)
> -		return -1;
> -
> -	printklist = tep->printklist;
> -
> -	i = 0;
> -	while (printklist) {
> -		printk_map[i].printk = printklist->printk;
> -		printk_map[i].addr = printklist->addr;
> -		i++;
> -		item = printklist;
> -		printklist = printklist->next;
> -		free(item);
> -	}
> -
> -	qsort(printk_map, tep->printk_count, sizeof(*printk_map), printk_cmp);
> -
> -	tep->printk_map = printk_map;
> -	tep->printklist = NULL;
> -
> -	return 0;
> -}
> -
> -static struct printk_map *
> -find_printk(struct tep_handle *tep, unsigned long long addr)
> -{
> -	struct printk_map *printk;
> -	struct printk_map key;
> -
> -	if (!tep->printk_map && printk_map_init(tep))
> -		return NULL;
> -
> -	key.addr = addr;
> -
> -	printk = bsearch(&key, tep->printk_map, tep->printk_count,
> -			 sizeof(*tep->printk_map), printk_cmp);
> -
> -	return printk;
> -}
> -
> -/**
> - * tep_register_print_string - register a string by its address
> - * @tep: a handle to the trace event parser context
> - * @fmt: the string format to register
> - * @addr: the address the string was located at
> - *
> - * This registers a string by the address it was stored in the kernel.
> - * The @fmt passed in is duplicated.
> - */
> -int tep_register_print_string(struct tep_handle *tep, const char *fmt,
> -			      unsigned long long addr)
> -{
> -	struct printk_list *item = malloc(sizeof(*item));
> -	char *p;
> -
> -	if (!item)
> -		return -1;
> -
> -	item->next = tep->printklist;
> -	item->addr = addr;
> -
> -	/* Strip off quotes and '\n' from the end */
> -	if (fmt[0] == '"')
> -		fmt++;
> -	item->printk = strdup(fmt);
> -	if (!item->printk)
> -		goto out_free;
> -
> -	p = item->printk + strlen(item->printk) - 1;
> -	if (*p == '"')
> -		*p = 0;
> -
> -	p -= 2;
> -	if (strcmp(p, "\\n") == 0)
> -		*p = 0;
> -
> -	tep->printklist = item;
> -	tep->printk_count++;
> -
> -	return 0;
> -
> -out_free:
> -	free(item);
> -	errno = ENOMEM;
> -	return -1;
> -}
> -
> -/**
> - * tep_print_printk - print out the stored strings
> - * @tep: a handle to the trace event parser context
> - *
> - * This prints the string formats that were stored.
> - */
> -void tep_print_printk(struct tep_handle *tep)
> -{
> -	int i;
> -
> -	if (!tep->printk_map)
> -		printk_map_init(tep);
> -
> -	for (i = 0; i < (int)tep->printk_count; i++) {
> -		printf("%016llx %s\n",
> -		       tep->printk_map[i].addr,
> -		       tep->printk_map[i].printk);
> -	}
> -}
> -
> -static struct tep_event *alloc_event(void)
> -{
> -	return calloc(1, sizeof(struct tep_event));
> -}
> -
> -static int add_event(struct tep_handle *tep, struct tep_event *event)
> -{
> -	int i;
> -	struct tep_event **events = realloc(tep->events, sizeof(event) *
> -					    (tep->nr_events + 1));
> -	if (!events)
> -		return -1;
> -
> -	tep->events = events;
> -
> -	for (i = 0; i < tep->nr_events; i++) {
> -		if (tep->events[i]->id > event->id)
> -			break;
> -	}
> -	if (i < tep->nr_events)
> -		memmove(&tep->events[i + 1],
> -			&tep->events[i],
> -			sizeof(event) * (tep->nr_events - i));
> -
> -	tep->events[i] = event;
> -	tep->nr_events++;
> -
> -	event->tep = tep;
> -
> -	return 0;
> -}
> -
> -static int event_item_type(enum tep_event_type type)
> -{
> -	switch (type) {
> -	case TEP_EVENT_ITEM ... TEP_EVENT_SQUOTE:
> -		return 1;
> -	case TEP_EVENT_ERROR ... TEP_EVENT_DELIM:
> -	default:
> -		return 0;
> -	}
> -}
> -
> -static void free_flag_sym(struct tep_print_flag_sym *fsym)
> -{
> -	struct tep_print_flag_sym *next;
> -
> -	while (fsym) {
> -		next = fsym->next;
> -		free(fsym->value);
> -		free(fsym->str);
> -		free(fsym);
> -		fsym = next;
> -	}
> -}
> -
> -static void free_arg(struct tep_print_arg *arg)
> -{
> -	struct tep_print_arg *farg;
> -
> -	if (!arg)
> -		return;
> -
> -	switch (arg->type) {
> -	case TEP_PRINT_ATOM:
> -		free(arg->atom.atom);
> -		break;
> -	case TEP_PRINT_FIELD:
> -		free(arg->field.name);
> -		break;
> -	case TEP_PRINT_FLAGS:
> -		free_arg(arg->flags.field);
> -		free(arg->flags.delim);
> -		free_flag_sym(arg->flags.flags);
> -		break;
> -	case TEP_PRINT_SYMBOL:
> -		free_arg(arg->symbol.field);
> -		free_flag_sym(arg->symbol.symbols);
> -		break;
> -	case TEP_PRINT_HEX:
> -	case TEP_PRINT_HEX_STR:
> -		free_arg(arg->hex.field);
> -		free_arg(arg->hex.size);
> -		break;
> -	case TEP_PRINT_INT_ARRAY:
> -		free_arg(arg->int_array.field);
> -		free_arg(arg->int_array.count);
> -		free_arg(arg->int_array.el_size);
> -		break;
> -	case TEP_PRINT_TYPE:
> -		free(arg->typecast.type);
> -		free_arg(arg->typecast.item);
> -		break;
> -	case TEP_PRINT_STRING:
> -	case TEP_PRINT_BSTRING:
> -		free(arg->string.string);
> -		break;
> -	case TEP_PRINT_BITMASK:
> -		free(arg->bitmask.bitmask);
> -		break;
> -	case TEP_PRINT_DYNAMIC_ARRAY:
> -	case TEP_PRINT_DYNAMIC_ARRAY_LEN:
> -		free(arg->dynarray.index);
> -		break;
> -	case TEP_PRINT_OP:
> -		free(arg->op.op);
> -		free_arg(arg->op.left);
> -		free_arg(arg->op.right);
> -		break;
> -	case TEP_PRINT_FUNC:
> -		while (arg->func.args) {
> -			farg = arg->func.args;
> -			arg->func.args = farg->next;
> -			free_arg(farg);
> -		}
> -		break;
> -
> -	case TEP_PRINT_NULL:
> -	default:
> -		break;
> -	}
> -
> -	free(arg);
> -}
> -
> -static enum tep_event_type get_type(int ch)
> -{
> -	if (ch == '\n')
> -		return TEP_EVENT_NEWLINE;
> -	if (isspace(ch))
> -		return TEP_EVENT_SPACE;
> -	if (isalnum(ch) || ch == '_')
> -		return TEP_EVENT_ITEM;
> -	if (ch == '\'')
> -		return TEP_EVENT_SQUOTE;
> -	if (ch == '"')
> -		return TEP_EVENT_DQUOTE;
> -	if (!isprint(ch))
> -		return TEP_EVENT_NONE;
> -	if (ch == '(' || ch == ')' || ch == ',')
> -		return TEP_EVENT_DELIM;
> -
> -	return TEP_EVENT_OP;
> -}
> -
> -static int __read_char(void)
> -{
> -	if (input_buf_ptr >= input_buf_siz)
> -		return -1;
> -
> -	return input_buf[input_buf_ptr++];
> -}
> -
> -/**
> - * peek_char - peek at the next character that will be read
> - *
> - * Returns the next character read, or -1 if end of buffer.
> - */
> -__hidden int peek_char(void)
> -{
> -	if (input_buf_ptr >= input_buf_siz)
> -		return -1;
> -
> -	return input_buf[input_buf_ptr];
> -}
> -
> -static int extend_token(char **tok, char *buf, int size)
> -{
> -	char *newtok = realloc(*tok, size);
> -
> -	if (!newtok) {
> -		free(*tok);
> -		*tok = NULL;
> -		return -1;
> -	}
> -
> -	if (!*tok)
> -		strcpy(newtok, buf);
> -	else
> -		strcat(newtok, buf);
> -	*tok = newtok;
> -
> -	return 0;
> -}
> -
> -static enum tep_event_type force_token(const char *str, char **tok);
> -
> -static enum tep_event_type __read_token(char **tok)
> -{
> -	char buf[BUFSIZ];
> -	int ch, last_ch, quote_ch, next_ch;
> -	int i = 0;
> -	int tok_size = 0;
> -	enum tep_event_type type;
> -
> -	*tok = NULL;
> -
> -
> -	ch = __read_char();
> -	if (ch < 0)
> -		return TEP_EVENT_NONE;
> -
> -	type = get_type(ch);
> -	if (type == TEP_EVENT_NONE)
> -		return type;
> -
> -	buf[i++] = ch;
> -
> -	switch (type) {
> -	case TEP_EVENT_NEWLINE:
> -	case TEP_EVENT_DELIM:
> -		if (asprintf(tok, "%c", ch) < 0)
> -			return TEP_EVENT_ERROR;
> -
> -		return type;
> -
> -	case TEP_EVENT_OP:
> -		switch (ch) {
> -		case '-':
> -			next_ch = peek_char();
> -			if (next_ch == '>') {
> -				buf[i++] = __read_char();
> -				break;
> -			}
> -			/* fall through */
> -		case '+':
> -		case '|':
> -		case '&':
> -		case '>':
> -		case '<':
> -			last_ch = ch;
> -			ch = peek_char();
> -			if (ch != last_ch)
> -				goto test_equal;
> -			buf[i++] = __read_char();
> -			switch (last_ch) {
> -			case '>':
> -			case '<':
> -				goto test_equal;
> -			default:
> -				break;
> -			}
> -			break;
> -		case '!':
> -		case '=':
> -			goto test_equal;
> -		default: /* what should we do instead? */
> -			break;
> -		}
> -		buf[i] = 0;
> -		*tok = strdup(buf);
> -		return type;
> -
> - test_equal:
> -		ch = peek_char();
> -		if (ch == '=')
> -			buf[i++] = __read_char();
> -		goto out;
> -
> -	case TEP_EVENT_DQUOTE:
> -	case TEP_EVENT_SQUOTE:
> -		/* don't keep quotes */
> -		i--;
> -		quote_ch = ch;
> -		last_ch = 0;
> - concat:
> -		do {
> -			if (i == (BUFSIZ - 1)) {
> -				buf[i] = 0;
> -				tok_size += BUFSIZ;
> -
> -				if (extend_token(tok, buf, tok_size) < 0)
> -					return TEP_EVENT_NONE;
> -				i = 0;
> -			}
> -			last_ch = ch;
> -			ch = __read_char();
> -			buf[i++] = ch;
> -			/* the '\' '\' will cancel itself */
> -			if (ch == '\\' && last_ch == '\\')
> -				last_ch = 0;
> -		} while (ch != quote_ch || last_ch == '\\');
> -		/* remove the last quote */
> -		i--;
> -
> -		/*
> -		 * For strings (double quotes) check the next token.
> -		 * If it is another string, concatinate the two.
> -		 */
> -		if (type == TEP_EVENT_DQUOTE) {
> -			unsigned long long save_input_buf_ptr = input_buf_ptr;
> -
> -			do {
> -				ch = __read_char();
> -			} while (isspace(ch));
> -			if (ch == '"')
> -				goto concat;
> -			input_buf_ptr = save_input_buf_ptr;
> -		}
> -
> -		goto out;
> -
> -	case TEP_EVENT_ERROR ... TEP_EVENT_SPACE:
> -	case TEP_EVENT_ITEM:
> -	default:
> -		break;
> -	}
> -
> -	while (get_type(peek_char()) == type) {
> -		if (i == (BUFSIZ - 1)) {
> -			buf[i] = 0;
> -			tok_size += BUFSIZ;
> -
> -			if (extend_token(tok, buf, tok_size) < 0)
> -				return TEP_EVENT_NONE;
> -			i = 0;
> -		}
> -		ch = __read_char();
> -		buf[i++] = ch;
> -	}
> -
> - out:
> -	buf[i] = 0;
> -	if (extend_token(tok, buf, tok_size + i + 1) < 0)
> -		return TEP_EVENT_NONE;
> -
> -	if (type == TEP_EVENT_ITEM) {
> -		/*
> -		 * Older versions of the kernel has a bug that
> -		 * creates invalid symbols and will break the mac80211
> -		 * parsing. This is a work around to that bug.
> -		 *
> -		 * See Linux kernel commit:
> -		 *  811cb50baf63461ce0bdb234927046131fc7fa8b
> -		 */
> -		if (strcmp(*tok, "LOCAL_PR_FMT") == 0) {
> -			free(*tok);
> -			*tok = NULL;
> -			return force_token("\"%s\" ", tok);
> -		} else if (strcmp(*tok, "STA_PR_FMT") == 0) {
> -			free(*tok);
> -			*tok = NULL;
> -			return force_token("\" sta:%pM\" ", tok);
> -		} else if (strcmp(*tok, "VIF_PR_FMT") == 0) {
> -			free(*tok);
> -			*tok = NULL;
> -			return force_token("\" vif:%p(%d)\" ", tok);
> -		}
> -	}
> -
> -	return type;
> -}
> -
> -static enum tep_event_type force_token(const char *str, char **tok)
> -{
> -	const char *save_input_buf;
> -	unsigned long long save_input_buf_ptr;
> -	unsigned long long save_input_buf_siz;
> -	enum tep_event_type type;
> -	
> -	/* save off the current input pointers */
> -	save_input_buf = input_buf;
> -	save_input_buf_ptr = input_buf_ptr;
> -	save_input_buf_siz = input_buf_siz;
> -
> -	init_input_buf(str, strlen(str));
> -
> -	type = __read_token(tok);
> -
> -	/* reset back to original token */
> -	input_buf = save_input_buf;
> -	input_buf_ptr = save_input_buf_ptr;
> -	input_buf_siz = save_input_buf_siz;
> -
> -	return type;
> -}
> -
> -/**
> - * free_token - free a token returned by tep_read_token
> - * @token: the token to free
> - */
> -__hidden void free_token(char *tok)
> -{
> -	if (tok)
> -		free(tok);
> -}
> -
> -/**
> - * read_token - access to utilities to use the tep parser
> - * @tok: The token to return
> - *
> - * This will parse tokens from the string given by
> - * tep_init_data().
> - *
> - * Returns the token type.
> - */
> -__hidden enum tep_event_type read_token(char **tok)
> -{
> -	enum tep_event_type type;
> -
> -	for (;;) {
> -		type = __read_token(tok);
> -		if (type != TEP_EVENT_SPACE)
> -			return type;
> -
> -		free_token(*tok);
> -	}
> -
> -	/* not reached */
> -	*tok = NULL;
> -	return TEP_EVENT_NONE;
> -}
> -
> -/* no newline */
> -static enum tep_event_type read_token_item(char **tok)
> -{
> -	enum tep_event_type type;
> -
> -	for (;;) {
> -		type = __read_token(tok);
> -		if (type != TEP_EVENT_SPACE && type != TEP_EVENT_NEWLINE)
> -			return type;
> -		free_token(*tok);
> -		*tok = NULL;
> -	}
> -
> -	/* not reached */
> -	*tok = NULL;
> -	return TEP_EVENT_NONE;
> -}
> -
> -static int test_type(enum tep_event_type type, enum tep_event_type expect)
> -{
> -	if (type != expect) {
> -		do_warning("Error: expected type %d but read %d",
> -		    expect, type);
> -		return -1;
> -	}
> -	return 0;
> -}
> -
> -static int test_type_token(enum tep_event_type type, const char *token,
> -		    enum tep_event_type expect, const char *expect_tok)
> -{
> -	if (type != expect) {
> -		do_warning("Error: expected type %d but read %d",
> -		    expect, type);
> -		return -1;
> -	}
> -
> -	if (strcmp(token, expect_tok) != 0) {
> -		do_warning("Error: expected '%s' but read '%s'",
> -		    expect_tok, token);
> -		return -1;
> -	}
> -	return 0;
> -}
> -
> -static int __read_expect_type(enum tep_event_type expect, char **tok, int newline_ok)
> -{
> -	enum tep_event_type type;
> -
> -	if (newline_ok)
> -		type = read_token(tok);
> -	else
> -		type = read_token_item(tok);
> -	return test_type(type, expect);
> -}
> -
> -static int read_expect_type(enum tep_event_type expect, char **tok)
> -{
> -	return __read_expect_type(expect, tok, 1);
> -}
> -
> -static int __read_expected(enum tep_event_type expect, const char *str,
> -			   int newline_ok)
> -{
> -	enum tep_event_type type;
> -	char *token;
> -	int ret;
> -
> -	if (newline_ok)
> -		type = read_token(&token);
> -	else
> -		type = read_token_item(&token);
> -
> -	ret = test_type_token(type, token, expect, str);
> -
> -	free_token(token);
> -
> -	return ret;
> -}
> -
> -static int read_expected(enum tep_event_type expect, const char *str)
> -{
> -	return __read_expected(expect, str, 1);
> -}
> -
> -static int read_expected_item(enum tep_event_type expect, const char *str)
> -{
> -	return __read_expected(expect, str, 0);
> -}
> -
> -static char *event_read_name(void)
> -{
> -	char *token;
> -
> -	if (read_expected(TEP_EVENT_ITEM, "name") < 0)
> -		return NULL;
> -
> -	if (read_expected(TEP_EVENT_OP, ":") < 0)
> -		return NULL;
> -
> -	if (read_expect_type(TEP_EVENT_ITEM, &token) < 0)
> -		goto fail;
> -
> -	return token;
> -
> - fail:
> -	free_token(token);
> -	return NULL;
> -}
> -
> -static int event_read_id(void)
> -{
> -	char *token;
> -	int id;
> -
> -	if (read_expected_item(TEP_EVENT_ITEM, "ID") < 0)
> -		return -1;
> -
> -	if (read_expected(TEP_EVENT_OP, ":") < 0)
> -		return -1;
> -
> -	if (read_expect_type(TEP_EVENT_ITEM, &token) < 0)
> -		goto fail;
> -
> -	id = strtoul(token, NULL, 0);
> -	free_token(token);
> -	return id;
> -
> - fail:
> -	free_token(token);
> -	return -1;
> -}
> -
> -static int field_is_string(struct tep_format_field *field)
> -{
> -	if ((field->flags & TEP_FIELD_IS_ARRAY) &&
> -	    (strstr(field->type, "char") || strstr(field->type, "u8") ||
> -	     strstr(field->type, "s8")))
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static int field_is_dynamic(struct tep_format_field *field)
> -{
> -	if (strncmp(field->type, "__data_loc", 10) == 0)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static int field_is_relative_dynamic(struct tep_format_field *field)
> -{
> -	if (strncmp(field->type, "__rel_loc", 9) == 0)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static int field_is_long(struct tep_format_field *field)
> -{
> -	/* includes long long */
> -	if (strstr(field->type, "long"))
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static unsigned int type_size(const char *name)
> -{
> -	/* This covers all TEP_FIELD_IS_STRING types. */
> -	static struct {
> -		const char *type;
> -		unsigned int size;
> -	} table[] = {
> -		{ "u8",   1 },
> -		{ "u16",  2 },
> -		{ "u32",  4 },
> -		{ "u64",  8 },
> -		{ "s8",   1 },
> -		{ "s16",  2 },
> -		{ "s32",  4 },
> -		{ "s64",  8 },
> -		{ "char", 1 },
> -		{ },
> -	};
> -	int i;
> -
> -	for (i = 0; table[i].type; i++) {
> -		if (!strcmp(table[i].type, name))
> -			return table[i].size;
> -	}
> -
> -	return 0;
> -}
> -
> -static int append(char **buf, const char *delim, const char *str)
> -{
> -	char *new_buf;
> -
> -	new_buf = realloc(*buf, strlen(*buf) + strlen(delim) + strlen(str) + 1);
> -	if (!new_buf)
> -		return -1;
> -	strcat(new_buf, delim);
> -	strcat(new_buf, str);
> -	*buf = new_buf;
> -	return 0;
> -}
> -
> -static int event_read_fields(struct tep_event *event, struct tep_format_field **fields)
> -{
> -	struct tep_format_field *field = NULL;
> -	enum tep_event_type type;
> -	char *token;
> -	char *last_token;
> -	char *delim = " ";
> -	int count = 0;
> -	int ret;
> -
> -	do {
> -		unsigned int size_dynamic = 0;
> -
> -		type = read_token(&token);
> -		if (type == TEP_EVENT_NEWLINE) {
> -			free_token(token);
> -			return count;
> -		}
> -
> -		count++;
> -
> -		if (test_type_token(type, token, TEP_EVENT_ITEM, "field"))
> -			goto fail;
> -		free_token(token);
> -
> -		type = read_token(&token);
> -		/*
> -		 * The ftrace fields may still use the "special" name.
> -		 * Just ignore it.
> -		 */
> -		if (event->flags & TEP_EVENT_FL_ISFTRACE &&
> -		    type == TEP_EVENT_ITEM && strcmp(token, "special") == 0) {
> -			free_token(token);
> -			type = read_token(&token);
> -		}
> -
> -		if (test_type_token(type, token, TEP_EVENT_OP, ":") < 0)
> -			goto fail;
> -
> -		free_token(token);
> -		if (read_expect_type(TEP_EVENT_ITEM, &token) < 0)
> -			goto fail;
> -
> -		last_token = token;
> -
> -		field = calloc(1, sizeof(*field));
> -		if (!field)
> -			goto fail;
> -
> -		field->event = event;
> -
> -		/* read the rest of the type */
> -		for (;;) {
> -			type = read_token(&token);
> -			if (type == TEP_EVENT_ITEM ||
> -			    (type == TEP_EVENT_OP && strcmp(token, "*") == 0) ||
> -			    /*
> -			     * Some of the ftrace fields are broken and have
> -			     * an illegal "." in them.
> -			     */
> -			    (event->flags & TEP_EVENT_FL_ISFTRACE &&
> -			     type == TEP_EVENT_OP && strcmp(token, ".") == 0)) {
> -
> -				if (strcmp(token, "*") == 0)
> -					field->flags |= TEP_FIELD_IS_POINTER;
> -
> -				if (field->type) {
> -					ret = append(&field->type, delim, last_token);
> -					free(last_token);
> -					if (ret < 0)
> -						goto fail;
> -				} else
> -					field->type = last_token;
> -				last_token = token;
> -				delim = " ";
> -				continue;
> -			}
> -
> -			/* Handle __attribute__((user)) */
> -			if ((type == TEP_EVENT_DELIM) &&
> -			    strcmp("__attribute__", last_token) == 0 &&
> -			    token[0] == '(') {
> -				int depth = 1;
> -				int ret;
> -
> -				ret = append(&field->type, " ", last_token);
> -				ret |= append(&field->type, "", "(");
> -				if (ret < 0)
> -					goto fail;
> -
> -				delim = " ";
> -				while ((type = read_token(&token)) != TEP_EVENT_NONE) {
> -					if (type == TEP_EVENT_DELIM) {
> -						if (token[0] == '(')
> -							depth++;
> -						else if (token[0] == ')')
> -							depth--;
> -						if (!depth)
> -							break;
> -						ret = append(&field->type, "", token);
> -						delim = "";
> -					} else {
> -						ret = append(&field->type, delim, token);
> -						delim = " ";
> -					}
> -					if (ret < 0)
> -						goto fail;
> -					free(last_token);
> -					last_token = token;
> -				}
> -				continue;
> -			}
> -			break;
> -		}
> -
> -		if (!field->type) {
> -			do_warning_event(event, "%s: no type found", __func__);
> -			goto fail;
> -		}
> -		field->name = field->alias = last_token;
> -
> -		if (test_type(type, TEP_EVENT_OP))
> -			goto fail;
> -
> -		if (strcmp(token, "[") == 0) {
> -			enum tep_event_type last_type = type;
> -			char *brackets = token;
> -
> -			field->flags |= TEP_FIELD_IS_ARRAY;
> -
> -			type = read_token(&token);
> -
> -			if (type == TEP_EVENT_ITEM)
> -				field->arraylen = strtoul(token, NULL, 0);
> -			else
> -				field->arraylen = 0;
> -
> -		        while (strcmp(token, "]") != 0) {
> -				const char *delim;
> -
> -				if (last_type == TEP_EVENT_ITEM &&
> -				    type == TEP_EVENT_ITEM)
> -					delim = " ";
> -				else
> -					delim = "";
> -
> -				last_type = type;
> -
> -				ret = append(&brackets, delim, token);
> -				if (ret < 0) {
> -					free(brackets);
> -					goto fail;
> -				}
> -				/* We only care about the last token */
> -				field->arraylen = strtoul(token, NULL, 0);
> -				free_token(token);
> -				type = read_token(&token);
> -				if (type == TEP_EVENT_NONE) {
> -					free(brackets);
> -					do_warning_event(event, "failed to find token");
> -					goto fail;
> -				}
> -			}
> -
> -			free_token(token);
> -
> -			ret = append(&brackets, "", "]");
> -			if (ret < 0) {
> -				free(brackets);
> -				goto fail;
> -			}
> -
> -			/* add brackets to type */
> -
> -			type = read_token(&token);
> -			/*
> -			 * If the next token is not an OP, then it is of
> -			 * the format: type [] item;
> -			 */
> -			if (type == TEP_EVENT_ITEM) {
> -				ret = append(&field->type, " ", field->name);
> -				if (ret < 0) {
> -					free(brackets);
> -					goto fail;
> -				}
> -				ret = append(&field->type, "", brackets);
> -
> -				size_dynamic = type_size(field->name);
> -				free_token(field->name);
> -				field->name = field->alias = token;
> -				type = read_token(&token);
> -			} else {
> -				ret = append(&field->type, "", brackets);
> -				if (ret < 0) {
> -					free(brackets);
> -					goto fail;
> -				}
> -			}
> -			free(brackets);
> -		}
> -
> -		if (field_is_string(field))
> -			field->flags |= TEP_FIELD_IS_STRING;
> -		if (field_is_dynamic(field))
> -			field->flags |= TEP_FIELD_IS_DYNAMIC;
> -		if (field_is_relative_dynamic(field))
> -			field->flags |= TEP_FIELD_IS_DYNAMIC | TEP_FIELD_IS_RELATIVE;
> -		if (field_is_long(field))
> -			field->flags |= TEP_FIELD_IS_LONG;
> -
> -		if (test_type_token(type, token,  TEP_EVENT_OP, ";"))
> -			goto fail;
> -		free_token(token);
> -
> -		if (read_expected(TEP_EVENT_ITEM, "offset") < 0)
> -			goto fail_expect;
> -
> -		if (read_expected(TEP_EVENT_OP, ":") < 0)
> -			goto fail_expect;
> -
> -		if (read_expect_type(TEP_EVENT_ITEM, &token))
> -			goto fail;
> -		field->offset = strtoul(token, NULL, 0);
> -		free_token(token);
> -
> -		if (read_expected(TEP_EVENT_OP, ";") < 0)
> -			goto fail_expect;
> -
> -		if (read_expected(TEP_EVENT_ITEM, "size") < 0)
> -			goto fail_expect;
> -
> -		if (read_expected(TEP_EVENT_OP, ":") < 0)
> -			goto fail_expect;
> -
> -		if (read_expect_type(TEP_EVENT_ITEM, &token))
> -			goto fail;
> -		field->size = strtoul(token, NULL, 0);
> -		free_token(token);
> -
> -		if (read_expected(TEP_EVENT_OP, ";") < 0)
> -			goto fail_expect;
> -
> -		type = read_token(&token);
> -		if (type != TEP_EVENT_NEWLINE) {
> -			/* newer versions of the kernel have a "signed" type */
> -			if (test_type_token(type, token, TEP_EVENT_ITEM, "signed"))
> -				goto fail;
> -
> -			free_token(token);
> -
> -			if (read_expected(TEP_EVENT_OP, ":") < 0)
> -				goto fail_expect;
> -
> -			if (read_expect_type(TEP_EVENT_ITEM, &token))
> -				goto fail;
> -
> -			if (strtoul(token, NULL, 0))
> -				field->flags |= TEP_FIELD_IS_SIGNED;
> -
> -			free_token(token);
> -			if (read_expected(TEP_EVENT_OP, ";") < 0)
> -				goto fail_expect;
> -
> -			if (read_expect_type(TEP_EVENT_NEWLINE, &token))
> -				goto fail;
> -		}
> -
> -		free_token(token);
> -
> -		if (field->flags & TEP_FIELD_IS_ARRAY) {
> -			if (field->arraylen)
> -				field->elementsize = field->size / field->arraylen;
> -			else if (field->flags & TEP_FIELD_IS_DYNAMIC)
> -				field->elementsize = size_dynamic;
> -			else if (field->flags & TEP_FIELD_IS_STRING)
> -				field->elementsize = 1;
> -			else if (field->flags & TEP_FIELD_IS_LONG)
> -				field->elementsize = event->tep ?
> -						     event->tep->long_size :
> -						     sizeof(long);
> -		} else
> -			field->elementsize = field->size;
> -
> -		*fields = field;
> -		fields = &field->next;
> -
> -	} while (1);
> -
> -	return 0;
> -
> -fail:
> -	free_token(token);
> -fail_expect:
> -	if (field) {
> -		free(field->type);
> -		free(field->name);
> -		free(field);
> -	}
> -	return -1;
> -}
> -
> -static int event_read_format(struct tep_event *event)
> -{
> -	char *token;
> -	int ret;
> -
> -	if (read_expected_item(TEP_EVENT_ITEM, "format") < 0)
> -		return -1;
> -
> -	if (read_expected(TEP_EVENT_OP, ":") < 0)
> -		return -1;
> -
> -	if (read_expect_type(TEP_EVENT_NEWLINE, &token))
> -		goto fail;
> -	free_token(token);
> -
> -	ret = event_read_fields(event, &event->format.common_fields);
> -	if (ret < 0)
> -		return ret;
> -	event->format.nr_common = ret;
> -
> -	ret = event_read_fields(event, &event->format.fields);
> -	if (ret < 0)
> -		return ret;
> -	event->format.nr_fields = ret;
> -
> -	return 0;
> -
> - fail:
> -	free_token(token);
> -	return -1;
> -}
> -
> -static enum tep_event_type
> -process_arg_token(struct tep_event *event, struct tep_print_arg *arg,
> -		  char **tok, enum tep_event_type type);
> -
> -static enum tep_event_type
> -process_arg(struct tep_event *event, struct tep_print_arg *arg, char **tok)
> -{
> -	enum tep_event_type type;
> -	char *token;
> -
> -	type = read_token(&token);
> -	*tok = token;
> -
> -	return process_arg_token(event, arg, tok, type);
> -}
> -
> -static enum tep_event_type
> -process_op(struct tep_event *event, struct tep_print_arg *arg, char **tok);
> -
> -/*
> - * For __print_symbolic() and __print_flags, we need to completely
> - * evaluate the first argument, which defines what to print next.
> - */
> -static enum tep_event_type
> -process_field_arg(struct tep_event *event, struct tep_print_arg *arg, char **tok)
> -{
> -	enum tep_event_type type;
> -
> -	type = process_arg(event, arg, tok);
> -
> -	while (type == TEP_EVENT_OP) {
> -		type = process_op(event, arg, tok);
> -	}
> -
> -	return type;
> -}
> -
> -static enum tep_event_type
> -process_cond(struct tep_event *event, struct tep_print_arg *top, char **tok)
> -{
> -	struct tep_print_arg *arg, *left, *right;
> -	enum tep_event_type type;
> -	char *token = NULL;
> -
> -	arg = alloc_arg();
> -	left = alloc_arg();
> -	right = alloc_arg();
> -
> -	if (!arg || !left || !right) {
> -		do_warning_event(event, "%s: not enough memory!", __func__);
> -		/* arg will be freed at out_free */
> -		free_arg(left);
> -		free_arg(right);
> -		goto out_free;
> -	}
> -
> -	arg->type = TEP_PRINT_OP;
> -	arg->op.left = left;
> -	arg->op.right = right;
> -
> -	*tok = NULL;
> -	type = process_arg(event, left, &token);
> -
> - again:
> -	if (type == TEP_EVENT_ERROR)
> -		goto out_free;
> -
> -	/* Handle other operations in the arguments */
> -	if (type == TEP_EVENT_OP && strcmp(token, ":") != 0) {
> -		type = process_op(event, left, &token);
> -		goto again;
> -	}
> -
> -	if (test_type_token(type, token, TEP_EVENT_OP, ":"))
> -		goto out_free;
> -
> -	arg->op.op = token;
> -
> -	type = process_arg(event, right, &token);
> -
> -	top->op.right = arg;
> -
> -	*tok = token;
> -	return type;
> -
> -out_free:
> -	/* Top may point to itself */
> -	top->op.right = NULL;
> -	free_token(token);
> -	free_arg(arg);
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static enum tep_event_type
> -process_array(struct tep_event *event, struct tep_print_arg *top, char **tok)
> -{
> -	struct tep_print_arg *arg;
> -	enum tep_event_type type;
> -	char *token = NULL;
> -
> -	arg = alloc_arg();
> -	if (!arg) {
> -		do_warning_event(event, "%s: not enough memory!", __func__);
> -		/* '*tok' is set to top->op.op.  No need to free. */
> -		*tok = NULL;
> -		return TEP_EVENT_ERROR;
> -	}
> -
> -	*tok = NULL;
> -	type = process_arg(event, arg, &token);
> -	if (test_type_token(type, token, TEP_EVENT_OP, "]"))
> -		goto out_free;
> -
> -	top->op.right = arg;
> -
> -	free_token(token);
> -	type = read_token_item(&token);
> -	*tok = token;
> -
> -	return type;
> -
> -out_free:
> -	free_token(token);
> -	free_arg(arg);
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static int get_op_prio(char *op)
> -{
> -	if (!op[1]) {
> -		switch (op[0]) {
> -		case '~':
> -		case '!':
> -			return 4;
> -		case '*':
> -		case '/':
> -		case '%':
> -			return 6;
> -		case '+':
> -		case '-':
> -			return 7;
> -			/* '>>' and '<<' are 8 */
> -		case '<':
> -		case '>':
> -			return 9;
> -			/* '==' and '!=' are 10 */
> -		case '&':
> -			return 11;
> -		case '^':
> -			return 12;
> -		case '|':
> -			return 13;
> -		case '?':
> -			return 16;
> -		default:
> -			do_warning("unknown op '%c'", op[0]);
> -			return -1;
> -		}
> -	} else {
> -		if (strcmp(op, "++") == 0 ||
> -		    strcmp(op, "--") == 0) {
> -			return 3;
> -		} else if (strcmp(op, ">>") == 0 ||
> -			   strcmp(op, "<<") == 0) {
> -			return 8;
> -		} else if (strcmp(op, ">=") == 0 ||
> -			   strcmp(op, "<=") == 0) {
> -			return 9;
> -		} else if (strcmp(op, "==") == 0 ||
> -			   strcmp(op, "!=") == 0) {
> -			return 10;
> -		} else if (strcmp(op, "&&") == 0) {
> -			return 14;
> -		} else if (strcmp(op, "||") == 0) {
> -			return 15;
> -		} else {
> -			do_warning("unknown op '%s'", op);
> -			return -1;
> -		}
> -	}
> -}
> -
> -static int set_op_prio(struct tep_print_arg *arg)
> -{
> -
> -	/* single ops are the greatest */
> -	if (!arg->op.left || arg->op.left->type == TEP_PRINT_NULL)
> -		arg->op.prio = 0;
> -	else
> -		arg->op.prio = get_op_prio(arg->op.op);
> -
> -	return arg->op.prio;
> -}
> -
> -/* Note, *tok does not get freed, but will most likely be saved */
> -static enum tep_event_type
> -process_op(struct tep_event *event, struct tep_print_arg *arg, char **tok)
> -{
> -	struct tep_print_arg *left, *right = NULL;
> -	enum tep_event_type type;
> -	char *token;
> -
> -	/* the op is passed in via tok */
> -	token = *tok;
> -
> -	if (arg->type == TEP_PRINT_OP && !arg->op.left) {
> -		/* handle single op */
> -		if (token[1]) {
> -			do_warning_event(event, "bad op token %s", token);
> -			goto out_free;
> -		}
> -		switch (token[0]) {
> -		case '~':
> -		case '!':
> -		case '+':
> -		case '-':
> -			break;
> -		default:
> -			do_warning_event(event, "bad op token %s", token);
> -			goto out_free;
> -
> -		}
> -
> -		/* make an empty left */
> -		left = alloc_arg();
> -		if (!left)
> -			goto out_warn_free;
> -
> -		left->type = TEP_PRINT_NULL;
> -		arg->op.left = left;
> -
> -		right = alloc_arg();
> -		if (!right)
> -			goto out_warn_free;
> -
> -		arg->op.right = right;
> -
> -		/* do not free the token, it belongs to an op */
> -		*tok = NULL;
> -		type = process_arg(event, right, tok);
> -
> -	} else if (strcmp(token, "?") == 0) {
> -
> -		left = alloc_arg();
> -		if (!left)
> -			goto out_warn_free;
> -
> -		/* copy the top arg to the left */
> -		*left = *arg;
> -
> -		arg->type = TEP_PRINT_OP;
> -		arg->op.op = token;
> -		arg->op.left = left;
> -		arg->op.prio = 0;
> -
> -		/* it will set arg->op.right */
> -		type = process_cond(event, arg, tok);
> -
> -	} else if (strcmp(token, ">>") == 0 ||
> -		   strcmp(token, "<<") == 0 ||
> -		   strcmp(token, "&") == 0 ||
> -		   strcmp(token, "|") == 0 ||
> -		   strcmp(token, "&&") == 0 ||
> -		   strcmp(token, "||") == 0 ||
> -		   strcmp(token, "-") == 0 ||
> -		   strcmp(token, "+") == 0 ||
> -		   strcmp(token, "*") == 0 ||
> -		   strcmp(token, "^") == 0 ||
> -		   strcmp(token, "/") == 0 ||
> -		   strcmp(token, "%") == 0 ||
> -		   strcmp(token, "<") == 0 ||
> -		   strcmp(token, ">") == 0 ||
> -		   strcmp(token, "<=") == 0 ||
> -		   strcmp(token, ">=") == 0 ||
> -		   strcmp(token, "==") == 0 ||
> -		   strcmp(token, "!=") == 0) {
> -
> -		left = alloc_arg();
> -		if (!left)
> -			goto out_warn_free;
> -
> -		/* copy the top arg to the left */
> -		*left = *arg;
> -
> -		arg->type = TEP_PRINT_OP;
> -		arg->op.op = token;
> -		arg->op.left = left;
> -		arg->op.right = NULL;
> -
> -		if (set_op_prio(arg) == -1) {
> -			event->flags |= TEP_EVENT_FL_FAILED;
> -			/* arg->op.op (= token) will be freed at out_free */
> -			arg->op.op = NULL;
> -			goto out_free;
> -		}
> -
> -		type = read_token_item(&token);
> -		*tok = token;
> -
> -		/* could just be a type pointer */
> -		if ((strcmp(arg->op.op, "*") == 0) &&
> -		    type == TEP_EVENT_DELIM && (strcmp(token, ")") == 0)) {
> -			int ret;
> -
> -			if (left->type != TEP_PRINT_ATOM) {
> -				do_warning_event(event, "bad pointer type");
> -				goto out_free;
> -			}
> -			ret = append(&left->atom.atom, " ", "*");
> -			if (ret < 0)
> -				goto out_warn_free;
> -
> -			free(arg->op.op);
> -			*arg = *left;
> -			free(left);
> -
> -			return type;
> -		}
> -
> -		right = alloc_arg();
> -		if (!right)
> -			goto out_warn_free;
> -
> -		type = process_arg_token(event, right, tok, type);
> -		if (type == TEP_EVENT_ERROR) {
> -			free_arg(right);
> -			/* token was freed in process_arg_token() via *tok */
> -			token = NULL;
> -			goto out_free;
> -		}
> -
> -		if (right->type == TEP_PRINT_OP &&
> -		    get_op_prio(arg->op.op) < get_op_prio(right->op.op)) {
> -			struct tep_print_arg tmp;
> -
> -			/* rotate ops according to the priority */
> -			arg->op.right = right->op.left;
> -
> -			tmp = *arg;
> -			*arg = *right;
> -			*right = tmp;
> -
> -			arg->op.left = right;
> -		} else {
> -			arg->op.right = right;
> -		}
> -
> -	} else if (strcmp(token, "[") == 0) {
> -
> -		left = alloc_arg();
> -		if (!left)
> -			goto out_warn_free;
> -
> -		*left = *arg;
> -
> -		arg->type = TEP_PRINT_OP;
> -		arg->op.op = token;
> -		arg->op.left = left;
> -
> -		arg->op.prio = 0;
> -
> -		/* it will set arg->op.right */
> -		type = process_array(event, arg, tok);
> -
> -	} else {
> -		do_warning_event(event, "unknown op '%s'", token);
> -		event->flags |= TEP_EVENT_FL_FAILED;
> -		/* the arg is now the left side */
> -		goto out_free;
> -	}
> -
> -	if (type == TEP_EVENT_OP && strcmp(*tok, ":") != 0) {
> -		int prio;
> -
> -		/* higher prios need to be closer to the root */
> -		prio = get_op_prio(*tok);
> -
> -		if (prio > arg->op.prio)
> -			return process_op(event, arg, tok);
> -
> -		return process_op(event, right, tok);
> -	}
> -
> -	return type;
> -
> -out_warn_free:
> -	do_warning_event(event, "%s: not enough memory!", __func__);
> -out_free:
> -	free_token(token);
> -	*tok = NULL;
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static enum tep_event_type
> -process_entry(struct tep_event *event __maybe_unused, struct tep_print_arg *arg,
> -	      char **tok)
> -{
> -	enum tep_event_type type;
> -	char *field;
> -	char *token;
> -
> -	if (read_expected(TEP_EVENT_OP, "->") < 0)
> -		goto out_err;
> -
> -	if (read_expect_type(TEP_EVENT_ITEM, &token) < 0)
> -		goto out_free;
> -	field = token;
> -
> -	arg->type = TEP_PRINT_FIELD;
> -	arg->field.name = field;
> -
> -	if (is_flag_field) {
> -		arg->field.field = tep_find_any_field(event, arg->field.name);
> -		arg->field.field->flags |= TEP_FIELD_IS_FLAG;
> -		is_flag_field = 0;
> -	} else if (is_symbolic_field) {
> -		arg->field.field = tep_find_any_field(event, arg->field.name);
> -		arg->field.field->flags |= TEP_FIELD_IS_SYMBOLIC;
> -		is_symbolic_field = 0;
> -	}
> -
> -	type = read_token(&token);
> -	*tok = token;
> -
> -	return type;
> -
> - out_free:
> -	free_token(token);
> - out_err:
> -	*tok = NULL;
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static int alloc_and_process_delim(struct tep_event *event, char *next_token,
> -				   struct tep_print_arg **print_arg)
> -{
> -	struct tep_print_arg *field;
> -	enum tep_event_type type;
> -	char *token;
> -	int ret = 0;
> -
> -	field = alloc_arg();
> -	if (!field) {
> -		do_warning_event(event, "%s: not enough memory!", __func__);
> -		errno = ENOMEM;
> -		return -1;
> -	}
> -
> -	type = process_arg(event, field, &token);
> -
> -	if (test_type_token(type, token, TEP_EVENT_DELIM, next_token)) {
> -		errno = EINVAL;
> -		ret = -1;
> -		free_arg(field);
> -		goto out_free_token;
> -	}
> -
> -	*print_arg = field;
> -
> -out_free_token:
> -	free_token(token);
> -
> -	return ret;
> -}
> -
> -static char *arg_eval (struct tep_print_arg *arg);
> -
> -static unsigned long long
> -eval_type_str(unsigned long long val, const char *type, int pointer)
> -{
> -	int sign = 0;
> -	char *ref;
> -	int len;
> -
> -	len = strlen(type);
> -
> -	if (pointer) {
> -
> -		if (type[len-1] != '*') {
> -			do_warning("pointer expected with non pointer type");
> -			return val;
> -		}
> -
> -		ref = malloc(len);
> -		if (!ref) {
> -			do_warning("%s: not enough memory!", __func__);
> -			return val;
> -		}
> -		memcpy(ref, type, len);
> -
> -		/* chop off the " *" */
> -		ref[len - 2] = 0;
> -
> -		val = eval_type_str(val, ref, 0);
> -		free(ref);
> -		return val;
> -	}
> -
> -	/* check if this is a pointer */
> -	if (type[len - 1] == '*')
> -		return val;
> -
> -	/* Try to figure out the arg size*/
> -	if (strncmp(type, "struct", 6) == 0)
> -		/* all bets off */
> -		return val;
> -
> -	if (strcmp(type, "u8") == 0)
> -		return val & 0xff;
> -
> -	if (strcmp(type, "u16") == 0)
> -		return val & 0xffff;
> -
> -	if (strcmp(type, "u32") == 0)
> -		return val & 0xffffffff;
> -
> -	if (strcmp(type, "u64") == 0 ||
> -	    strcmp(type, "s64") == 0)
> -		return val;
> -
> -	if (strcmp(type, "s8") == 0)
> -		return (unsigned long long)(char)val & 0xff;
> -
> -	if (strcmp(type, "s16") == 0)
> -		return (unsigned long long)(short)val & 0xffff;
> -
> -	if (strcmp(type, "s32") == 0)
> -		return (unsigned long long)(int)val & 0xffffffff;
> -
> -	if (strncmp(type, "unsigned ", 9) == 0) {
> -		sign = 0;
> -		type += 9;
> -	}
> -
> -	if (strcmp(type, "char") == 0) {
> -		if (sign)
> -			return (unsigned long long)(char)val & 0xff;
> -		else
> -			return val & 0xff;
> -	}
> -
> -	if (strcmp(type, "short") == 0) {
> -		if (sign)
> -			return (unsigned long long)(short)val & 0xffff;
> -		else
> -			return val & 0xffff;
> -	}
> -
> -	if (strcmp(type, "int") == 0) {
> -		if (sign)
> -			return (unsigned long long)(int)val & 0xffffffff;
> -		else
> -			return val & 0xffffffff;
> -	}
> -
> -	return val;
> -}
> -
> -/*
> - * Try to figure out the type.
> - */
> -static unsigned long long
> -eval_type(unsigned long long val, struct tep_print_arg *arg, int pointer)
> -{
> -	if (arg->type != TEP_PRINT_TYPE) {
> -		do_warning("expected type argument");
> -		return 0;
> -	}
> -
> -	return eval_type_str(val, arg->typecast.type, pointer);
> -}
> -
> -static int arg_num_eval(struct tep_print_arg *arg, long long *val)
> -{
> -	long long left, right;
> -	int ret = 1;
> -
> -	switch (arg->type) {
> -	case TEP_PRINT_ATOM:
> -		*val = strtoll(arg->atom.atom, NULL, 0);
> -		break;
> -	case TEP_PRINT_TYPE:
> -		ret = arg_num_eval(arg->typecast.item, val);
> -		if (!ret)
> -			break;
> -		*val = eval_type(*val, arg, 0);
> -		break;
> -	case TEP_PRINT_OP:
> -		switch (arg->op.op[0]) {
> -		case '|':
> -			ret = arg_num_eval(arg->op.left, &left);
> -			if (!ret)
> -				break;
> -			ret = arg_num_eval(arg->op.right, &right);
> -			if (!ret)
> -				break;
> -			if (arg->op.op[1])
> -				*val = left || right;
> -			else
> -				*val = left | right;
> -			break;
> -		case '&':
> -			ret = arg_num_eval(arg->op.left, &left);
> -			if (!ret)
> -				break;
> -			ret = arg_num_eval(arg->op.right, &right);
> -			if (!ret)
> -				break;
> -			if (arg->op.op[1])
> -				*val = left && right;
> -			else
> -				*val = left & right;
> -			break;
> -		case '<':
> -			ret = arg_num_eval(arg->op.left, &left);
> -			if (!ret)
> -				break;
> -			ret = arg_num_eval(arg->op.right, &right);
> -			if (!ret)
> -				break;
> -			switch (arg->op.op[1]) {
> -			case 0:
> -				*val = left < right;
> -				break;
> -			case '<':
> -				*val = left << right;
> -				break;
> -			case '=':
> -				*val = left <= right;
> -				break;
> -			default:
> -				do_warning("unknown op '%s'", arg->op.op);
> -				ret = 0;
> -			}
> -			break;
> -		case '>':
> -			ret = arg_num_eval(arg->op.left, &left);
> -			if (!ret)
> -				break;
> -			ret = arg_num_eval(arg->op.right, &right);
> -			if (!ret)
> -				break;
> -			switch (arg->op.op[1]) {
> -			case 0:
> -				*val = left > right;
> -				break;
> -			case '>':
> -				*val = left >> right;
> -				break;
> -			case '=':
> -				*val = left >= right;
> -				break;
> -			default:
> -				do_warning("unknown op '%s'", arg->op.op);
> -				ret = 0;
> -			}
> -			break;
> -		case '=':
> -			ret = arg_num_eval(arg->op.left, &left);
> -			if (!ret)
> -				break;
> -			ret = arg_num_eval(arg->op.right, &right);
> -			if (!ret)
> -				break;
> -
> -			if (arg->op.op[1] != '=') {
> -				do_warning("unknown op '%s'", arg->op.op);
> -				ret = 0;
> -			} else
> -				*val = left == right;
> -			break;
> -		case '!':
> -			ret = arg_num_eval(arg->op.left, &left);
> -			if (!ret)
> -				break;
> -			ret = arg_num_eval(arg->op.right, &right);
> -			if (!ret)
> -				break;
> -
> -			switch (arg->op.op[1]) {
> -			case '=':
> -				*val = left != right;
> -				break;
> -			default:
> -				do_warning("unknown op '%s'", arg->op.op);
> -				ret = 0;
> -			}
> -			break;
> -		case '-':
> -			/* check for negative */
> -			if (arg->op.left->type == TEP_PRINT_NULL)
> -				left = 0;
> -			else
> -				ret = arg_num_eval(arg->op.left, &left);
> -			if (!ret)
> -				break;
> -			ret = arg_num_eval(arg->op.right, &right);
> -			if (!ret)
> -				break;
> -			*val = left - right;
> -			break;
> -		case '+':
> -			if (arg->op.left->type == TEP_PRINT_NULL)
> -				left = 0;
> -			else
> -				ret = arg_num_eval(arg->op.left, &left);
> -			if (!ret)
> -				break;
> -			ret = arg_num_eval(arg->op.right, &right);
> -			if (!ret)
> -				break;
> -			*val = left + right;
> -			break;
> -		case '~':
> -			ret = arg_num_eval(arg->op.right, &right);
> -			if (!ret)
> -				break;
> -			*val = ~right;
> -			break;
> -		default:
> -			do_warning("unknown op '%s'", arg->op.op);
> -			ret = 0;
> -		}
> -		break;
> -
> -	case TEP_PRINT_NULL:
> -	case TEP_PRINT_FIELD ... TEP_PRINT_SYMBOL:
> -	case TEP_PRINT_STRING:
> -	case TEP_PRINT_BSTRING:
> -	case TEP_PRINT_BITMASK:
> -	default:
> -		do_warning("invalid eval type %d", arg->type);
> -		ret = 0;
> -
> -	}
> -	return ret;
> -}
> -
> -static char *arg_eval (struct tep_print_arg *arg)
> -{
> -	long long val;
> -	static char buf[24];
> -
> -	switch (arg->type) {
> -	case TEP_PRINT_ATOM:
> -		return arg->atom.atom;
> -	case TEP_PRINT_TYPE:
> -		return arg_eval(arg->typecast.item);
> -	case TEP_PRINT_OP:
> -		if (!arg_num_eval(arg, &val))
> -			break;
> -		sprintf(buf, "%lld", val);
> -		return buf;
> -
> -	case TEP_PRINT_NULL:
> -	case TEP_PRINT_FIELD ... TEP_PRINT_SYMBOL:
> -	case TEP_PRINT_STRING:
> -	case TEP_PRINT_BSTRING:
> -	case TEP_PRINT_BITMASK:
> -	default:
> -		do_warning("invalid eval type %d", arg->type);
> -		break;
> -	}
> -
> -	return NULL;
> -}
> -
> -static enum tep_event_type
> -process_fields(struct tep_event *event, struct tep_print_flag_sym **list, char **tok)
> -{
> -	enum tep_event_type type;
> -	struct tep_print_arg *arg = NULL;
> -	struct tep_print_flag_sym *field;
> -	char *token = *tok;
> -	char *value;
> -
> -	do {
> -		free_token(token);
> -		type = read_token_item(&token);
> -		if (test_type_token(type, token, TEP_EVENT_OP, "{"))
> -			break;
> -
> -		arg = alloc_arg();
> -		if (!arg)
> -			goto out_free;
> -
> -		free_token(token);
> -		type = process_arg(event, arg, &token);
> -
> -		if (type == TEP_EVENT_OP)
> -			type = process_op(event, arg, &token);
> -
> -		if (type == TEP_EVENT_ERROR)
> -			goto out_free;
> -
> -		if (test_type_token(type, token, TEP_EVENT_DELIM, ","))
> -			goto out_free;
> -
> -		field = calloc(1, sizeof(*field));
> -		if (!field)
> -			goto out_free;
> -
> -		value = arg_eval(arg);
> -		if (value == NULL)
> -			goto out_free_field;
> -		field->value = strdup(value);
> -		if (field->value == NULL)
> -			goto out_free_field;
> -
> -		free_arg(arg);
> -		arg = alloc_arg();
> -		if (!arg)
> -			goto out_free;
> -
> -		free_token(token);
> -		type = process_arg(event, arg, &token);
> -		if (test_type_token(type, token, TEP_EVENT_OP, "}"))
> -			goto out_free_field;
> -
> -		value = arg_eval(arg);
> -		if (value == NULL)
> -			goto out_free_field;
> -		field->str = strdup(value);
> -		if (field->str == NULL)
> -			goto out_free_field;
> -		free_arg(arg);
> -		arg = NULL;
> -
> -		*list = field;
> -		list = &field->next;
> -
> -		free_token(token);
> -		type = read_token_item(&token);
> -	} while (type == TEP_EVENT_DELIM && strcmp(token, ",") == 0);
> -
> -	*tok = token;
> -	return type;
> -
> -out_free_field:
> -	free_flag_sym(field);
> -out_free:
> -	free_arg(arg);
> -	free_token(token);
> -	*tok = NULL;
> -
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static enum tep_event_type
> -process_flags(struct tep_event *event, struct tep_print_arg *arg, char **tok)
> -{
> -	struct tep_print_arg *field;
> -	enum tep_event_type type;
> -	char *token = NULL;
> -
> -	memset(arg, 0, sizeof(*arg));
> -	arg->type = TEP_PRINT_FLAGS;
> -
> -	field = alloc_arg();
> -	if (!field) {
> -		do_warning_event(event, "%s: not enough memory!", __func__);
> -		goto out_free;
> -	}
> -
> -	type = process_field_arg(event, field, &token);
> -
> -	/* Handle operations in the first argument */
> -	while (type == TEP_EVENT_OP)
> -		type = process_op(event, field, &token);
> -
> -	if (test_type_token(type, token, TEP_EVENT_DELIM, ","))
> -		goto out_free_field;
> -	free_token(token);
> -
> -	arg->flags.field = field;
> -
> -	type = read_token_item(&token);
> -	if (event_item_type(type)) {
> -		arg->flags.delim = token;
> -		type = read_token_item(&token);
> -	}
> -
> -	if (test_type_token(type, token, TEP_EVENT_DELIM, ","))
> -		goto out_free;
> -
> -	type = process_fields(event, &arg->flags.flags, &token);
> -	if (test_type_token(type, token, TEP_EVENT_DELIM, ")"))
> -		goto out_free;
> -
> -	free_token(token);
> -	type = read_token_item(tok);
> -	return type;
> -
> -out_free_field:
> -	free_arg(field);
> -out_free:
> -	free_token(token);
> -	*tok = NULL;
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static enum tep_event_type
> -process_symbols(struct tep_event *event, struct tep_print_arg *arg, char **tok)
> -{
> -	struct tep_print_arg *field;
> -	enum tep_event_type type;
> -	char *token = NULL;
> -
> -	memset(arg, 0, sizeof(*arg));
> -	arg->type = TEP_PRINT_SYMBOL;
> -
> -	field = alloc_arg();
> -	if (!field) {
> -		do_warning_event(event, "%s: not enough memory!", __func__);
> -		goto out_free;
> -	}
> -
> -	type = process_field_arg(event, field, &token);
> -
> -	if (test_type_token(type, token, TEP_EVENT_DELIM, ","))
> -		goto out_free_field;
> -
> -	arg->symbol.field = field;
> -
> -	type = process_fields(event, &arg->symbol.symbols, &token);
> -	if (test_type_token(type, token, TEP_EVENT_DELIM, ")"))
> -		goto out_free;
> -
> -	free_token(token);
> -	type = read_token_item(tok);
> -	return type;
> -
> -out_free_field:
> -	free_arg(field);
> -out_free:
> -	free_token(token);
> -	*tok = NULL;
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static enum tep_event_type
> -process_hex_common(struct tep_event *event, struct tep_print_arg *arg,
> -		   char **tok, enum tep_print_arg_type type)
> -{
> -	memset(arg, 0, sizeof(*arg));
> -	arg->type = type;
> -
> -	if (alloc_and_process_delim(event, ",", &arg->hex.field))
> -		goto out;
> -
> -	if (alloc_and_process_delim(event, ")", &arg->hex.size))
> -		goto free_field;
> -
> -	return read_token_item(tok);
> -
> -free_field:
> -	free_arg(arg->hex.field);
> -	arg->hex.field = NULL;
> -out:
> -	*tok = NULL;
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static enum tep_event_type
> -process_hex(struct tep_event *event, struct tep_print_arg *arg, char **tok)
> -{
> -	return process_hex_common(event, arg, tok, TEP_PRINT_HEX);
> -}
> -
> -static enum tep_event_type
> -process_hex_str(struct tep_event *event, struct tep_print_arg *arg,
> -		char **tok)
> -{
> -	return process_hex_common(event, arg, tok, TEP_PRINT_HEX_STR);
> -}
> -
> -static enum tep_event_type
> -process_int_array(struct tep_event *event, struct tep_print_arg *arg, char **tok)
> -{
> -	memset(arg, 0, sizeof(*arg));
> -	arg->type = TEP_PRINT_INT_ARRAY;
> -
> -	if (alloc_and_process_delim(event, ",", &arg->int_array.field))
> -		goto out;
> -
> -	if (alloc_and_process_delim(event, ",", &arg->int_array.count))
> -		goto free_field;
> -
> -	if (alloc_and_process_delim(event, ")", &arg->int_array.el_size))
> -		goto free_size;
> -
> -	return read_token_item(tok);
> -
> -free_size:
> -	free_arg(arg->int_array.count);
> -	arg->int_array.count = NULL;
> -free_field:
> -	free_arg(arg->int_array.field);
> -	arg->int_array.field = NULL;
> -out:
> -	*tok = NULL;
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static enum tep_event_type
> -process_dynamic_array(struct tep_event *event, struct tep_print_arg *arg, char **tok)
> -{
> -	struct tep_format_field *field;
> -	enum tep_event_type type;
> -	char *token;
> -
> -	memset(arg, 0, sizeof(*arg));
> -	arg->type = TEP_PRINT_DYNAMIC_ARRAY;
> -
> -	/*
> -	 * The item within the parenthesis is another field that holds
> -	 * the index into where the array starts.
> -	 */
> -	type = read_token(&token);
> -	*tok = token;
> -	if (type != TEP_EVENT_ITEM)
> -		goto out_free;
> -
> -	/* Find the field */
> -
> -	field = tep_find_field(event, token);
> -	if (!field)
> -		goto out_free;
> -
> -	arg->dynarray.field = field;
> -	arg->dynarray.index = 0;
> -
> -	if (read_expected(TEP_EVENT_DELIM, ")") < 0)
> -		goto out_free;
> -
> -	free_token(token);
> -	type = read_token_item(&token);
> -	*tok = token;
> -	if (type != TEP_EVENT_OP || strcmp(token, "[") != 0)
> -		return type;
> -
> -	free_token(token);
> -	arg = alloc_arg();
> -	if (!arg) {
> -		do_warning_event(event, "%s: not enough memory!", __func__);
> -		*tok = NULL;
> -		return TEP_EVENT_ERROR;
> -	}
> -
> -	type = process_arg(event, arg, &token);
> -	if (type == TEP_EVENT_ERROR)
> -		goto out_free_arg;
> -
> -	if (!test_type_token(type, token, TEP_EVENT_OP, "]"))
> -		goto out_free_arg;
> -
> -	free_token(token);
> -	type = read_token_item(tok);
> -	return type;
> -
> - out_free_arg:
> -	free_arg(arg);
> - out_free:
> -	free_token(token);
> -	*tok = NULL;
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static enum tep_event_type
> -process_dynamic_array_len(struct tep_event *event, struct tep_print_arg *arg,
> -			  char **tok)
> -{
> -	struct tep_format_field *field;
> -	enum tep_event_type type;
> -	char *token;
> -
> -	if (read_expect_type(TEP_EVENT_ITEM, &token) < 0)
> -		goto out_free;
> -
> -	arg->type = TEP_PRINT_DYNAMIC_ARRAY_LEN;
> -
> -	/* Find the field */
> -	field = tep_find_field(event, token);
> -	if (!field)
> -		goto out_free;
> -
> -	arg->dynarray.field = field;
> -	arg->dynarray.index = 0;
> -
> -	if (read_expected(TEP_EVENT_DELIM, ")") < 0)
> -		goto out_err;
> -
> -	free_token(token);
> -	type = read_token(&token);
> -	*tok = token;
> -
> -	return type;
> -
> - out_free:
> -	free_token(token);
> - out_err:
> -	*tok = NULL;
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static enum tep_event_type
> -process_paren(struct tep_event *event, struct tep_print_arg *arg, char **tok)
> -{
> -	struct tep_print_arg *item_arg;
> -	enum tep_event_type type;
> -	char *token;
> -
> -	type = process_arg(event, arg, &token);
> -
> -	if (type == TEP_EVENT_ERROR)
> -		goto out_free;
> -
> -	if (type == TEP_EVENT_OP)
> -		type = process_op(event, arg, &token);
> -
> -	if (type == TEP_EVENT_ERROR)
> -		goto out_free;
> -
> -	if (test_type_token(type, token, TEP_EVENT_DELIM, ")"))
> -		goto out_free;
> -
> -	free_token(token);
> -	type = read_token_item(&token);
> -
> -	/*
> -	 * If the next token is an item or another open paren, then
> -	 * this was a typecast.
> -	 */
> -	if (event_item_type(type) ||
> -	    (type == TEP_EVENT_DELIM && strcmp(token, "(") == 0)) {
> -
> -		/* make this a typecast and contine */
> -
> -		/* prevous must be an atom */
> -		if (arg->type != TEP_PRINT_ATOM) {
> -			do_warning_event(event, "previous needed to be TEP_PRINT_ATOM");
> -			goto out_free;
> -		}
> -
> -		item_arg = alloc_arg();
> -		if (!item_arg) {
> -			do_warning_event(event, "%s: not enough memory!",
> -					 __func__);
> -			goto out_free;
> -		}
> -
> -		arg->type = TEP_PRINT_TYPE;
> -		arg->typecast.type = arg->atom.atom;
> -		arg->typecast.item = item_arg;
> -		type = process_arg_token(event, item_arg, &token, type);
> -
> -	}
> -
> -	*tok = token;
> -	return type;
> -
> - out_free:
> -	free_token(token);
> -	*tok = NULL;
> -	return TEP_EVENT_ERROR;
> -}
> -
> -
> -static enum tep_event_type
> -process_str(struct tep_event *event __maybe_unused, struct tep_print_arg *arg,
> -	    char **tok)
> -{
> -	enum tep_event_type type;
> -	char *token;
> -
> -	if (read_expect_type(TEP_EVENT_ITEM, &token) < 0)
> -		goto out_free;
> -
> -	arg->type = TEP_PRINT_STRING;
> -	arg->string.string = token;
> -	arg->string.field = NULL;
> -
> -	if (read_expected(TEP_EVENT_DELIM, ")") < 0)
> -		goto out_err;
> -
> -	type = read_token(&token);
> -	*tok = token;
> -
> -	return type;
> -
> - out_free:
> -	free_token(token);
> - out_err:
> -	*tok = NULL;
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static enum tep_event_type
> -process_bitmask(struct tep_event *event __maybe_unused, struct tep_print_arg *arg,
> -		char **tok)
> -{
> -	enum tep_event_type type;
> -	char *token;
> -
> -	if (read_expect_type(TEP_EVENT_ITEM, &token) < 0)
> -		goto out_free;
> -
> -	arg->type = TEP_PRINT_BITMASK;
> -	arg->bitmask.bitmask = token;
> -	arg->bitmask.field = NULL;
> -
> -	if (read_expected(TEP_EVENT_DELIM, ")") < 0)
> -		goto out_err;
> -
> -	type = read_token(&token);
> -	*tok = token;
> -
> -	return type;
> -
> - out_free:
> -	free_token(token);
> - out_err:
> -	*tok = NULL;
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static struct tep_function_handler *
> -find_func_handler(struct tep_handle *tep, char *func_name)
> -{
> -	struct tep_function_handler *func;
> -
> -	if (!tep)
> -		return NULL;
> -
> -	for (func = tep->func_handlers; func; func = func->next) {
> -		if (strcmp(func->name, func_name) == 0)
> -			break;
> -	}
> -
> -	return func;
> -}
> -
> -static void remove_func_handler(struct tep_handle *tep, char *func_name)
> -{
> -	struct tep_function_handler *func;
> -	struct tep_function_handler **next;
> -
> -	next = &tep->func_handlers;
> -	while ((func = *next)) {
> -		if (strcmp(func->name, func_name) == 0) {
> -			*next = func->next;
> -			free_func_handle(func);
> -			break;
> -		}
> -		next = &func->next;
> -	}
> -}
> -
> -static enum tep_event_type
> -process_func_handler(struct tep_event *event, struct tep_function_handler *func,
> -		     struct tep_print_arg *arg, char **tok)
> -{
> -	struct tep_print_arg **next_arg;
> -	struct tep_print_arg *farg;
> -	enum tep_event_type type;
> -	char *token;
> -	int i;
> -
> -	arg->type = TEP_PRINT_FUNC;
> -	arg->func.func = func;
> -
> -	*tok = NULL;
> -
> -	next_arg = &(arg->func.args);
> -	for (i = 0; i < func->nr_args; i++) {
> -		farg = alloc_arg();
> -		if (!farg) {
> -			do_warning_event(event, "%s: not enough memory!",
> -					 __func__);
> -			return TEP_EVENT_ERROR;
> -		}
> -
> -		type = process_arg(event, farg, &token);
> -		if (i < (func->nr_args - 1)) {
> -			if (type != TEP_EVENT_DELIM || strcmp(token, ",") != 0) {
> -				do_warning_event(event,
> -					"Error: function '%s()' expects %d arguments but event %s only uses %d",
> -					func->name, func->nr_args,
> -					event->name, i + 1);
> -				goto err;
> -			}
> -		} else {
> -			if (type != TEP_EVENT_DELIM || strcmp(token, ")") != 0) {
> -				do_warning_event(event,
> -					"Error: function '%s()' only expects %d arguments but event %s has more",
> -					func->name, func->nr_args, event->name);
> -				goto err;
> -			}
> -		}
> -
> -		*next_arg = farg;
> -		next_arg = &(farg->next);
> -		free_token(token);
> -	}
> -
> -	type = read_token(&token);
> -	*tok = token;
> -
> -	return type;
> -
> -err:
> -	free_arg(farg);
> -	free_token(token);
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static enum tep_event_type
> -process_builtin_expect(struct tep_event *event, struct tep_print_arg *arg, char **tok)
> -{
> -	enum tep_event_type type;
> -	char *token = NULL;
> -
> -	/* Handle __builtin_expect( cond, #) */
> -	type = process_arg(event, arg, &token);
> -
> -	if (type != TEP_EVENT_DELIM || token[0] != ',')
> -		goto out_free;
> -
> -	free_token(token);
> -
> -	/* We don't care what the second parameter is of the __builtin_expect() */
> -	if (read_expect_type(TEP_EVENT_ITEM, &token) < 0)
> -		goto out_free;
> -
> -	if (read_expected(TEP_EVENT_DELIM, ")") < 0)
> -		goto out_free;
> -
> -	free_token(token);
> -	type = read_token_item(tok);
> -	return type;
> -
> -out_free:
> -	free_token(token);
> -	*tok = NULL;
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static enum tep_event_type
> -process_function(struct tep_event *event, struct tep_print_arg *arg,
> -		 char *token, char **tok)
> -{
> -	struct tep_function_handler *func;
> -
> -	if (strcmp(token, "__print_flags") == 0) {
> -		free_token(token);
> -		is_flag_field = 1;
> -		return process_flags(event, arg, tok);
> -	}
> -	if (strcmp(token, "__print_symbolic") == 0) {
> -		free_token(token);
> -		is_symbolic_field = 1;
> -		return process_symbols(event, arg, tok);
> -	}
> -	if (strcmp(token, "__print_hex") == 0) {
> -		free_token(token);
> -		return process_hex(event, arg, tok);
> -	}
> -	if (strcmp(token, "__print_hex_str") == 0) {
> -		free_token(token);
> -		return process_hex_str(event, arg, tok);
> -	}
> -	if (strcmp(token, "__print_array") == 0) {
> -		free_token(token);
> -		return process_int_array(event, arg, tok);
> -	}
> -	if (strcmp(token, "__get_str") == 0 ||
> -	    strcmp(token, "__get_rel_str") == 0) {
> -		free_token(token);
> -		return process_str(event, arg, tok);
> -	}
> -	if (strcmp(token, "__get_bitmask") == 0 ||
> -	    strcmp(token, "__get_rel_bitmask") == 0) {
> -		free_token(token);
> -		return process_bitmask(event, arg, tok);
> -	}
> -	if (strcmp(token, "__get_dynamic_array") == 0 ||
> -	    strcmp(token, "__get_rel_dynamic_array") == 0) {
> -		free_token(token);
> -		return process_dynamic_array(event, arg, tok);
> -	}
> -	if (strcmp(token, "__get_dynamic_array_len") == 0 ||
> -	    strcmp(token, "__get_rel_dynamic_array_len") == 0) {
> -		free_token(token);
> -		return process_dynamic_array_len(event, arg, tok);
> -	}
> -	if (strcmp(token, "__builtin_expect") == 0) {
> -		free_token(token);
> -		return process_builtin_expect(event, arg, tok);
> -	}
> -
> -	func = find_func_handler(event->tep, token);
> -	if (func) {
> -		free_token(token);
> -		return process_func_handler(event, func, arg, tok);
> -	}
> -
> -	do_warning_event(event, "function %s not defined", token);
> -	free_token(token);
> -	return TEP_EVENT_ERROR;
> -}
> -
> -static enum tep_event_type
> -process_arg_token(struct tep_event *event, struct tep_print_arg *arg,
> -		  char **tok, enum tep_event_type type)
> -{
> -	char *token;
> -	char *atom;
> -
> -	token = *tok;
> -
> -	switch (type) {
> -	case TEP_EVENT_ITEM:
> -		if (strcmp(token, "REC") == 0) {
> -			free_token(token);
> -			type = process_entry(event, arg, &token);
> -			break;
> -		}
> -		atom = token;
> -		/* test the next token */
> -		type = read_token_item(&token);
> -
> -		/*
> -		 * If the next token is a parenthesis, then this
> -		 * is a function.
> -		 */
> -		if (type == TEP_EVENT_DELIM && strcmp(token, "(") == 0) {
> -			free_token(token);
> -			token = NULL;
> -			/* this will free atom. */
> -			type = process_function(event, arg, atom, &token);
> -			break;
> -		}
> -		/* atoms can be more than one token long */
> -		while (type == TEP_EVENT_ITEM) {
> -			int ret;
> -
> -			ret = append(&atom, " ", token);
> -			if (ret < 0) {
> -				free(atom);
> -				*tok = NULL;
> -				free_token(token);
> -				return TEP_EVENT_ERROR;
> -			}
> -			free_token(token);
> -			type = read_token_item(&token);
> -		}
> -
> -		arg->type = TEP_PRINT_ATOM;
> -		arg->atom.atom = atom;
> -		break;
> -
> -	case TEP_EVENT_DQUOTE:
> -	case TEP_EVENT_SQUOTE:
> -		arg->type = TEP_PRINT_ATOM;
> -		arg->atom.atom = token;
> -		type = read_token_item(&token);
> -		break;
> -	case TEP_EVENT_DELIM:
> -		if (strcmp(token, "(") == 0) {
> -			free_token(token);
> -			type = process_paren(event, arg, &token);
> -			break;
> -		}
> -	case TEP_EVENT_OP:
> -		/* handle single ops */
> -		arg->type = TEP_PRINT_OP;
> -		arg->op.op = token;
> -		arg->op.left = NULL;
> -		type = process_op(event, arg, &token);
> -
> -		/* On error, the op is freed */
> -		if (type == TEP_EVENT_ERROR)
> -			arg->op.op = NULL;
> -
> -		/* return error type if errored */
> -		break;
> -
> -	case TEP_EVENT_ERROR ... TEP_EVENT_NEWLINE:
> -	default:
> -		do_warning_event(event, "unexpected type %d", type);
> -		return TEP_EVENT_ERROR;
> -	}
> -	*tok = token;
> -
> -	return type;
> -}
> -
> -static int event_read_print_args(struct tep_event *event, struct tep_print_arg **list)
> -{
> -	enum tep_event_type type = TEP_EVENT_ERROR;
> -	struct tep_print_arg *arg;
> -	char *token;
> -	int args = 0;
> -
> -	do {
> -		if (type == TEP_EVENT_NEWLINE) {
> -			type = read_token_item(&token);
> -			continue;
> -		}
> -
> -		arg = alloc_arg();
> -		if (!arg) {
> -			do_warning_event(event, "%s: not enough memory!",
> -					 __func__);
> -			return -1;
> -		}
> -
> -		type = process_arg(event, arg, &token);
> -
> -		if (type == TEP_EVENT_ERROR) {
> -			free_token(token);
> -			free_arg(arg);
> -			return -1;
> -		}
> -
> -		*list = arg;
> -		args++;
> -
> -		if (type == TEP_EVENT_OP) {
> -			type = process_op(event, arg, &token);
> -			free_token(token);
> -			if (type == TEP_EVENT_ERROR) {
> -				*list = NULL;
> -				free_arg(arg);
> -				return -1;
> -			}
> -			list = &arg->next;
> -			continue;
> -		}
> -
> -		if (type == TEP_EVENT_DELIM && strcmp(token, ",") == 0) {
> -			free_token(token);
> -			*list = arg;
> -			list = &arg->next;
> -			continue;
> -		}
> -		break;
> -	} while (type != TEP_EVENT_NONE);
> -
> -	if (type != TEP_EVENT_NONE && type != TEP_EVENT_ERROR)
> -		free_token(token);
> -
> -	return args;
> -}
> -
> -static int event_read_print(struct tep_event *event)
> -{
> -	enum tep_event_type type;
> -	char *token;
> -	int ret;
> -
> -	if (read_expected_item(TEP_EVENT_ITEM, "print") < 0)
> -		return -1;
> -
> -	if (read_expected(TEP_EVENT_ITEM, "fmt") < 0)
> -		return -1;
> -
> -	if (read_expected(TEP_EVENT_OP, ":") < 0)
> -		return -1;
> -
> -	if (read_expect_type(TEP_EVENT_DQUOTE, &token) < 0)
> -		goto fail;
> -
> - concat:
> -	event->print_fmt.format = token;
> -	event->print_fmt.args = NULL;
> -
> -	/* ok to have no arg */
> -	type = read_token_item(&token);
> -
> -	if (type == TEP_EVENT_NONE)
> -		return 0;
> -
> -	/* Handle concatenation of print lines */
> -	if (type == TEP_EVENT_DQUOTE) {
> -		char *cat;
> -
> -		if (asprintf(&cat, "%s%s", event->print_fmt.format, token) < 0)
> -			goto fail;
> -		free_token(token);
> -		free_token(event->print_fmt.format);
> -		event->print_fmt.format = NULL;
> -		token = cat;
> -		goto concat;
> -	}
> -			     
> -	if (test_type_token(type, token, TEP_EVENT_DELIM, ","))
> -		goto fail;
> -
> -	free_token(token);
> -
> -	ret = event_read_print_args(event, &event->print_fmt.args);
> -	if (ret < 0)
> -		return -1;
> -
> -	return ret;
> -
> - fail:
> -	free_token(token);
> -	return -1;
> -}
> -
> -/**
> - * tep_find_common_field - return a common field by event
> - * @event: handle for the event
> - * @name: the name of the common field to return
> - *
> - * Returns a common field from the event by the given @name.
> - * This only searches the common fields and not all field.
> - */
> -struct tep_format_field *
> -tep_find_common_field(struct tep_event *event, const char *name)
> -{
> -	struct tep_format_field *format;
> -
> -	for (format = event->format.common_fields;
> -	     format; format = format->next) {
> -		if (strcmp(format->name, name) == 0)
> -			break;
> -	}
> -
> -	return format;
> -}
> -
> -/**
> - * tep_find_field - find a non-common field
> - * @event: handle for the event
> - * @name: the name of the non-common field
> - *
> - * Returns a non-common field by the given @name.
> - * This does not search common fields.
> - */
> -struct tep_format_field *
> -tep_find_field(struct tep_event *event, const char *name)
> -{
> -	struct tep_format_field *format;
> -
> -	for (format = event->format.fields;
> -	     format; format = format->next) {
> -		if (strcmp(format->name, name) == 0)
> -			break;
> -	}
> -
> -	return format;
> -}
> -
> -/**
> - * tep_find_any_field - find any field by name
> - * @event: handle for the event
> - * @name: the name of the field
> - *
> - * Returns a field by the given @name.
> - * This searches the common field names first, then
> - * the non-common ones if a common one was not found.
> - */
> -struct tep_format_field *
> -tep_find_any_field(struct tep_event *event, const char *name)
> -{
> -	struct tep_format_field *format;
> -
> -	format = tep_find_common_field(event, name);
> -	if (format)
> -		return format;
> -	return tep_find_field(event, name);
> -}
> -
> -/**
> - * tep_read_number - read a number from data
> - * @tep: a handle to the trace event parser context
> - * @ptr: the raw data
> - * @size: the size of the data that holds the number
> - *
> - * Returns the number (converted to host) from the
> - * raw data.
> - */
> -unsigned long long tep_read_number(struct tep_handle *tep,
> -				   const void *ptr, int size)
> -{
> -	unsigned long long val;
> -
> -	switch (size) {
> -	case 1:
> -		return *(unsigned char *)ptr;
> -	case 2:
> -		return data2host2(tep, *(unsigned short *)ptr);
> -	case 4:
> -		return data2host4(tep, *(unsigned int *)ptr);
> -	case 8:
> -		memcpy(&val, (ptr), sizeof(unsigned long long));
> -		return data2host8(tep, val);
> -	default:
> -		/* BUG! */
> -		return 0;
> -	}
> -}
> -
> -/**
> - * tep_read_number_field - read a number from data
> - * @field: a handle to the field
> - * @data: the raw data to read
> - * @value: the value to place the number in
> - *
> - * Reads raw data according to a field offset and size,
> - * and translates it into @value.
> - *
> - * Returns 0 on success, -1 otherwise.
> - */
> -int tep_read_number_field(struct tep_format_field *field, const void *data,
> -			  unsigned long long *value)
> -{
> -	if (!field)
> -		return -1;
> -	switch (field->size) {
> -	case 1:
> -	case 2:
> -	case 4:
> -	case 8:
> -		*value = tep_read_number(field->event->tep,
> -					 data + field->offset, field->size);
> -		return 0;
> -	default:
> -		return -1;
> -	}
> -}
> -
> -static int get_common_info(struct tep_handle *tep,
> -			   const char *type, int *offset, int *size)
> -{
> -	struct tep_event *event;
> -	struct tep_format_field *field;
> -
> -	/*
> -	 * All events should have the same common elements.
> -	 * Pick any event to find where the type is;
> -	 */
> -	if (!tep->events) {
> -		do_warning("no event_list!");
> -		return -1;
> -	}
> -
> -	event = tep->events[0];
> -	field = tep_find_common_field(event, type);
> -	if (!field)
> -		return -1;
> -
> -	*offset = field->offset;
> -	*size = field->size;
> -
> -	return 0;
> -}
> -
> -static int __parse_common(struct tep_handle *tep, void *data,
> -			  int *size, int *offset, const char *name)
> -{
> -	int ret;
> -
> -	if (!*size) {
> -		ret = get_common_info(tep, name, offset, size);
> -		if (ret < 0)
> -			return ret;
> -	}
> -	return tep_read_number(tep, data + *offset, *size);
> -}
> -
> -static int trace_parse_common_type(struct tep_handle *tep, void *data)
> -{
> -	return __parse_common(tep, data,
> -			      &tep->type_size, &tep->type_offset,
> -			      "common_type");
> -}
> -
> -static int parse_common_pid(struct tep_handle *tep, void *data)
> -{
> -	return __parse_common(tep, data,
> -			      &tep->pid_size, &tep->pid_offset,
> -			      "common_pid");
> -}
> -
> -static int parse_common_pc(struct tep_handle *tep, void *data)
> -{
> -	return __parse_common(tep, data,
> -			      &tep->pc_size, &tep->pc_offset,
> -			      "common_preempt_count");
> -}
> -
> -static int parse_common_flags(struct tep_handle *tep, void *data)
> -{
> -	return __parse_common(tep, data,
> -			      &tep->flags_size, &tep->flags_offset,
> -			      "common_flags");
> -}
> -
> -static int parse_common_lock_depth(struct tep_handle *tep, void *data)
> -{
> -	return __parse_common(tep, data,
> -			      &tep->ld_size, &tep->ld_offset,
> -			      "common_lock_depth");
> -}
> -
> -static int parse_common_migrate_disable(struct tep_handle *tep, void *data)
> -{
> -	return __parse_common(tep, data,
> -			      &tep->ld_size, &tep->ld_offset,
> -			      "common_migrate_disable");
> -}
> -
> -static int events_id_cmp(const void *a, const void *b);
> -
> -/**
> - * tep_find_event - find an event by given id
> - * @tep: a handle to the trace event parser context
> - * @id: the id of the event
> - *
> - * Returns an event that has a given @id.
> - */
> -struct tep_event *tep_find_event(struct tep_handle *tep, int id)
> -{
> -	struct tep_event **eventptr;
> -	struct tep_event key;
> -	struct tep_event *pkey = &key;
> -
> -	/* Check cache first */
> -	if (tep->last_event && tep->last_event->id == id)
> -		return tep->last_event;
> -
> -	key.id = id;
> -
> -	eventptr = bsearch(&pkey, tep->events, tep->nr_events,
> -			   sizeof(*tep->events), events_id_cmp);
> -
> -	if (eventptr) {
> -		tep->last_event = *eventptr;
> -		return *eventptr;
> -	}
> -
> -	return NULL;
> -}
> -
> -/**
> - * tep_find_event_by_name - find an event by given name
> - * @tep: a handle to the trace event parser context
> - * @sys: the system name to search for
> - * @name: the name of the event to search for
> - *
> - * This returns an event with a given @name and under the system
> - * @sys. If @sys is NULL the first event with @name is returned.
> - */
> -struct tep_event *
> -tep_find_event_by_name(struct tep_handle *tep,
> -		       const char *sys, const char *name)
> -{
> -	struct tep_event *event = NULL;
> -	int i;
> -
> -	if (tep->last_event &&
> -	    strcmp(tep->last_event->name, name) == 0 &&
> -	    (!sys || strcmp(tep->last_event->system, sys) == 0))
> -		return tep->last_event;
> -
> -	for (i = 0; i < tep->nr_events; i++) {
> -		event = tep->events[i];
> -		if (strcmp(event->name, name) == 0) {
> -			if (!sys)
> -				break;
> -			if (strcmp(event->system, sys) == 0)
> -				break;
> -		}
> -	}
> -	if (i == tep->nr_events)
> -		event = NULL;
> -
> -	tep->last_event = event;
> -	return event;
> -}
> -
> -static unsigned long long
> -eval_num_arg(void *data, int size, struct tep_event *event, struct tep_print_arg *arg)
> -{
> -	struct tep_handle *tep = event->tep;
> -	unsigned long long val = 0;
> -	unsigned long long left, right;
> -	struct tep_print_arg *typearg = NULL;
> -	struct tep_print_arg *larg;
> -	unsigned long offset;
> -	unsigned int field_size;
> -
> -	switch (arg->type) {
> -	case TEP_PRINT_NULL:
> -		/* ?? */
> -		return 0;
> -	case TEP_PRINT_ATOM:
> -		return strtoull(arg->atom.atom, NULL, 0);
> -	case TEP_PRINT_FIELD:
> -		if (!arg->field.field) {
> -			arg->field.field = tep_find_any_field(event, arg->field.name);
> -			if (!arg->field.field)
> -				goto out_warning_field;
> -			
> -		}
> -		/* must be a number */
> -		val = tep_read_number(tep, data + arg->field.field->offset,
> -				      arg->field.field->size);
> -		break;
> -	case TEP_PRINT_FLAGS:
> -	case TEP_PRINT_SYMBOL:
> -	case TEP_PRINT_INT_ARRAY:
> -	case TEP_PRINT_HEX:
> -	case TEP_PRINT_HEX_STR:
> -		break;
> -	case TEP_PRINT_TYPE:
> -		val = eval_num_arg(data, size, event, arg->typecast.item);
> -		return eval_type(val, arg, 0);
> -	case TEP_PRINT_STRING:
> -	case TEP_PRINT_BSTRING:
> -	case TEP_PRINT_BITMASK:
> -		return 0;
> -	case TEP_PRINT_FUNC: {
> -		struct trace_seq s;
> -		trace_seq_init(&s);
> -		val = process_defined_func(&s, data, size, event, arg);
> -		trace_seq_destroy(&s);
> -		return val;
> -	}
> -	case TEP_PRINT_OP:
> -		if (strcmp(arg->op.op, "[") == 0) {
> -			/*
> -			 * Arrays are special, since we don't want
> -			 * to read the arg as is.
> -			 */
> -			right = eval_num_arg(data, size, event, arg->op.right);
> -
> -			/* handle typecasts */
> -			larg = arg->op.left;
> -			while (larg->type == TEP_PRINT_TYPE) {
> -				if (!typearg)
> -					typearg = larg;
> -				larg = larg->typecast.item;
> -			}
> -
> -			/* Default to long size */
> -			field_size = tep->long_size;
> -
> -			switch (larg->type) {
> -			case TEP_PRINT_DYNAMIC_ARRAY:
> -				offset = tep_read_number(tep,
> -						   data + larg->dynarray.field->offset,
> -						   larg->dynarray.field->size);
> -				if (larg->dynarray.field->elementsize)
> -					field_size = larg->dynarray.field->elementsize;
> -				/*
> -				 * The actual length of the dynamic array is stored
> -				 * in the top half of the field, and the offset
> -				 * is in the bottom half of the 32 bit field.
> -				 */
> -				offset &= 0xffff;
> -				offset += right;
> -				break;
> -			case TEP_PRINT_FIELD:
> -				if (!larg->field.field) {
> -					larg->field.field =
> -						tep_find_any_field(event, larg->field.name);
> -					if (!larg->field.field) {
> -						arg = larg;
> -						goto out_warning_field;
> -					}
> -				}
> -				field_size = larg->field.field->elementsize;
> -				offset = larg->field.field->offset +
> -					right * larg->field.field->elementsize;
> -				break;
> -			default:
> -				goto default_op; /* oops, all bets off */
> -			}
> -			val = tep_read_number(tep,
> -					      data + offset, field_size);
> -			if (typearg)
> -				val = eval_type(val, typearg, 1);
> -			break;
> -		} else if (strcmp(arg->op.op, "?") == 0) {
> -			left = eval_num_arg(data, size, event, arg->op.left);
> -			arg = arg->op.right;
> -			if (left)
> -				val = eval_num_arg(data, size, event, arg->op.left);
> -			else
> -				val = eval_num_arg(data, size, event, arg->op.right);
> -			break;
> -		}
> - default_op:
> -		left = eval_num_arg(data, size, event, arg->op.left);
> -		right = eval_num_arg(data, size, event, arg->op.right);
> -		switch (arg->op.op[0]) {
> -		case '!':
> -			switch (arg->op.op[1]) {
> -			case 0:
> -				val = !right;
> -				break;
> -			case '=':
> -				val = left != right;
> -				break;
> -			default:
> -				goto out_warning_op;
> -			}
> -			break;
> -		case '~':
> -			val = ~right;
> -			break;
> -		case '|':
> -			if (arg->op.op[1])
> -				val = left || right;
> -			else
> -				val = left | right;
> -			break;
> -		case '&':
> -			if (arg->op.op[1])
> -				val = left && right;
> -			else
> -				val = left & right;
> -			break;
> -		case '<':
> -			switch (arg->op.op[1]) {
> -			case 0:
> -				val = left < right;
> -				break;
> -			case '<':
> -				val = left << right;
> -				break;
> -			case '=':
> -				val = left <= right;
> -				break;
> -			default:
> -				goto out_warning_op;
> -			}
> -			break;
> -		case '>':
> -			switch (arg->op.op[1]) {
> -			case 0:
> -				val = left > right;
> -				break;
> -			case '>':
> -				val = left >> right;
> -				break;
> -			case '=':
> -				val = left >= right;
> -				break;
> -			default:
> -				goto out_warning_op;
> -			}
> -			break;
> -		case '=':
> -			if (arg->op.op[1] != '=')
> -				goto out_warning_op;
> -
> -			val = left == right;
> -			break;
> -		case '-':
> -			val = left - right;
> -			break;
> -		case '+':
> -			val = left + right;
> -			break;
> -		case '/':
> -			val = left / right;
> -			break;
> -		case '%':
> -			val = left % right;
> -			break;
> -		case '*':
> -			val = left * right;
> -			break;
> -		default:
> -			goto out_warning_op;
> -		}
> -		break;
> -	case TEP_PRINT_DYNAMIC_ARRAY_LEN:
> -		offset = tep_read_number(tep,
> -					 data + arg->dynarray.field->offset,
> -					 arg->dynarray.field->size);
> -		/*
> -		 * The total allocated length of the dynamic array is
> -		 * stored in the top half of the field, and the offset
> -		 * is in the bottom half of the 32 bit field.
> -		 */
> -		val = (unsigned long long)(offset >> 16);
> -		break;
> -	case TEP_PRINT_DYNAMIC_ARRAY:
> -		/* Without [], we pass the address to the dynamic data */
> -		offset = tep_read_number(tep,
> -					 data + arg->dynarray.field->offset,
> -					 arg->dynarray.field->size);
> -		/*
> -		 * The total allocated length of the dynamic array is
> -		 * stored in the top half of the field, and the offset
> -		 * is in the bottom half of the 32 bit field.
> -		 */
> -		offset &= 0xffff;
> -		val = (unsigned long long)((unsigned long)data + offset);
> -		break;
> -	default: /* not sure what to do there */
> -		return 0;
> -	}
> -	return val;
> -
> -out_warning_op:
> -	do_warning_event(event, "%s: unknown op '%s'", __func__, arg->op.op);
> -	return 0;
> -
> -out_warning_field:
> -	do_warning_event(event, "%s: field %s not found",
> -			 __func__, arg->field.name);
> -	return 0;
> -}
> -
> -struct flag {
> -	const char *name;
> -	unsigned long long value;
> -};
> -
> -static const struct flag flags[] = {
> -	{ "HI_SOFTIRQ", 0 },
> -	{ "TIMER_SOFTIRQ", 1 },
> -	{ "NET_TX_SOFTIRQ", 2 },
> -	{ "NET_RX_SOFTIRQ", 3 },
> -	{ "BLOCK_SOFTIRQ", 4 },
> -	{ "IRQ_POLL_SOFTIRQ", 5 },
> -	{ "TASKLET_SOFTIRQ", 6 },
> -	{ "SCHED_SOFTIRQ", 7 },
> -	{ "HRTIMER_SOFTIRQ", 8 },
> -	{ "RCU_SOFTIRQ", 9 },
> -
> -	{ "HRTIMER_NORESTART", 0 },
> -	{ "HRTIMER_RESTART", 1 },
> -};
> -
> -static long long eval_flag(const char *flag)
> -{
> -	int i;
> -
> -	/*
> -	 * Some flags in the format files do not get converted.
> -	 * If the flag is not numeric, see if it is something that
> -	 * we already know about.
> -	 */
> -	if (isdigit(flag[0]))
> -		return strtoull(flag, NULL, 0);
> -
> -	for (i = 0; i < (int)(sizeof(flags)/sizeof(flags[0])); i++)
> -		if (strcmp(flags[i].name, flag) == 0)
> -			return flags[i].value;
> -
> -	return -1LL;
> -}
> -
> -static void print_str_to_seq(struct trace_seq *s, const char *format,
> -			     int len_arg, const char *str)
> -{
> -	if (len_arg >= 0)
> -		trace_seq_printf(s, format, len_arg, str);
> -	else
> -		trace_seq_printf(s, format, str);
> -}
> -
> -static void print_bitmask_to_seq(struct tep_handle *tep,
> -				 struct trace_seq *s, const char *format,
> -				 int len_arg, const void *data, int size)
> -{
> -	int nr_bits = size * 8;
> -	int str_size = (nr_bits + 3) / 4;
> -	int len = 0;
> -	char buf[3];
> -	char *str;
> -	int index;
> -	int i;
> -
> -	/*
> -	 * The kernel likes to put in commas every 32 bits, we
> -	 * can do the same.
> -	 */
> -	str_size += (nr_bits - 1) / 32;
> -
> -	str = malloc(str_size + 1);
> -	if (!str) {
> -		do_warning("%s: not enough memory!", __func__);
> -		return;
> -	}
> -	str[str_size] = 0;
> -
> -	/* Start out with -2 for the two chars per byte */
> -	for (i = str_size - 2; i >= 0; i -= 2) {
> -		/*
> -		 * data points to a bit mask of size bytes.
> -		 * In the kernel, this is an array of long words, thus
> -		 * endianness is very important.
> -		 */
> -		if (tep->file_bigendian)
> -			index = size - (len + 1);
> -		else
> -			index = len;
> -
> -		snprintf(buf, 3, "%02x", *((unsigned char *)data + index));
> -		memcpy(str + i, buf, 2);
> -		len++;
> -		if (!(len & 3) && i > 0) {
> -			i--;
> -			str[i] = ',';
> -		}
> -	}
> -
> -	if (len_arg >= 0)
> -		trace_seq_printf(s, format, len_arg, str);
> -	else
> -		trace_seq_printf(s, format, str);
> -
> -	free(str);
> -}
> -
> -static void print_str_arg(struct trace_seq *s, void *data, int size,
> -			  struct tep_event *event, const char *format,
> -			  int len_arg, struct tep_print_arg *arg)
> -{
> -	struct tep_handle *tep = event->tep;
> -	struct tep_print_flag_sym *flag;
> -	struct tep_format_field *field;
> -	struct printk_map *printk;
> -	long long val, fval;
> -	unsigned long long addr;
> -	char *str;
> -	unsigned char *hex;
> -	int print;
> -	int i, len;
> -
> -	switch (arg->type) {
> -	case TEP_PRINT_NULL:
> -		/* ?? */
> -		return;
> -	case TEP_PRINT_ATOM:
> -		print_str_to_seq(s, format, len_arg, arg->atom.atom);
> -		return;
> -	case TEP_PRINT_FIELD:
> -		field = arg->field.field;
> -		if (!field) {
> -			field = tep_find_any_field(event, arg->field.name);
> -			if (!field) {
> -				str = arg->field.name;
> -				goto out_warning_field;
> -			}
> -			arg->field.field = field;
> -		}
> -		/* Zero sized fields, mean the rest of the data */
> -		len = field->size ? : size - field->offset;
> -
> -		/*
> -		 * Some events pass in pointers. If this is not an array
> -		 * and the size is the same as long_size, assume that it
> -		 * is a pointer.
> -		 */
> -		if (!(field->flags & TEP_FIELD_IS_ARRAY) &&
> -		    field->size == tep->long_size) {
> -
> -			/* Handle heterogeneous recording and processing
> -			 * architectures
> -			 *
> -			 * CASE I:
> -			 * Traces recorded on 32-bit devices (32-bit
> -			 * addressing) and processed on 64-bit devices:
> -			 * In this case, only 32 bits should be read.
> -			 *
> -			 * CASE II:
> -			 * Traces recorded on 64 bit devices and processed
> -			 * on 32-bit devices:
> -			 * In this case, 64 bits must be read.
> -			 */
> -			addr = (tep->long_size == 8) ?
> -				*(unsigned long long *)(data + field->offset) :
> -				(unsigned long long)*(unsigned int *)(data + field->offset);
> -
> -			/* Check if it matches a print format */
> -			printk = find_printk(tep, addr);
> -			if (printk)
> -				trace_seq_puts(s, printk->printk);
> -			else
> -				trace_seq_printf(s, "%llx", addr);
> -			break;
> -		}
> -		str = malloc(len + 1);
> -		if (!str) {
> -			do_warning_event(event, "%s: not enough memory!",
> -					 __func__);
> -			return;
> -		}
> -		memcpy(str, data + field->offset, len);
> -		str[len] = 0;
> -		print_str_to_seq(s, format, len_arg, str);
> -		free(str);
> -		break;
> -	case TEP_PRINT_FLAGS:
> -		val = eval_num_arg(data, size, event, arg->flags.field);
> -		print = 0;
> -		for (flag = arg->flags.flags; flag; flag = flag->next) {
> -			fval = eval_flag(flag->value);
> -			if (!val && fval < 0) {
> -				print_str_to_seq(s, format, len_arg, flag->str);
> -				break;
> -			}
> -			if (fval > 0 && (val & fval) == fval) {
> -				if (print && arg->flags.delim)
> -					trace_seq_puts(s, arg->flags.delim);
> -				print_str_to_seq(s, format, len_arg, flag->str);
> -				print = 1;
> -				val &= ~fval;
> -			}
> -		}
> -		if (val) {
> -			if (print && arg->flags.delim)
> -				trace_seq_puts(s, arg->flags.delim);
> -			trace_seq_printf(s, "0x%llx", val);
> -		}
> -		break;
> -	case TEP_PRINT_SYMBOL:
> -		val = eval_num_arg(data, size, event, arg->symbol.field);
> -		for (flag = arg->symbol.symbols; flag; flag = flag->next) {
> -			fval = eval_flag(flag->value);
> -			if (val == fval) {
> -				print_str_to_seq(s, format, len_arg, flag->str);
> -				break;
> -			}
> -		}
> -		if (!flag)
> -			trace_seq_printf(s, "0x%llx", val);
> -		break;
> -	case TEP_PRINT_HEX:
> -	case TEP_PRINT_HEX_STR:
> -		if (arg->hex.field->type == TEP_PRINT_DYNAMIC_ARRAY) {
> -			unsigned long offset;
> -			offset = tep_read_number(tep,
> -				data + arg->hex.field->dynarray.field->offset,
> -				arg->hex.field->dynarray.field->size);
> -			hex = data + (offset & 0xffff);
> -		} else {
> -			field = arg->hex.field->field.field;
> -			if (!field) {
> -				str = arg->hex.field->field.name;
> -				field = tep_find_any_field(event, str);
> -				if (!field)
> -					goto out_warning_field;
> -				arg->hex.field->field.field = field;
> -			}
> -			hex = data + field->offset;
> -		}
> -		len = eval_num_arg(data, size, event, arg->hex.size);
> -		for (i = 0; i < len; i++) {
> -			if (i && arg->type == TEP_PRINT_HEX)
> -				trace_seq_putc(s, ' ');
> -			trace_seq_printf(s, "%02x", hex[i]);
> -		}
> -		break;
> -
> -	case TEP_PRINT_INT_ARRAY: {
> -		void *num;
> -		int el_size;
> -
> -		if (arg->int_array.field->type == TEP_PRINT_DYNAMIC_ARRAY) {
> -			unsigned long offset;
> -			struct tep_format_field *field =
> -				arg->int_array.field->dynarray.field;
> -			offset = tep_read_number(tep,
> -						 data + field->offset,
> -						 field->size);
> -			num = data + (offset & 0xffff);
> -		} else {
> -			field = arg->int_array.field->field.field;
> -			if (!field) {
> -				str = arg->int_array.field->field.name;
> -				field = tep_find_any_field(event, str);
> -				if (!field)
> -					goto out_warning_field;
> -				arg->int_array.field->field.field = field;
> -			}
> -			num = data + field->offset;
> -		}
> -		len = eval_num_arg(data, size, event, arg->int_array.count);
> -		el_size = eval_num_arg(data, size, event,
> -				       arg->int_array.el_size);
> -		for (i = 0; i < len; i++) {
> -			if (i)
> -				trace_seq_putc(s, ' ');
> -
> -			if (el_size == 1) {
> -				trace_seq_printf(s, "%u", *(uint8_t *)num);
> -			} else if (el_size == 2) {
> -				trace_seq_printf(s, "%u", *(uint16_t *)num);
> -			} else if (el_size == 4) {
> -				trace_seq_printf(s, "%u", *(uint32_t *)num);
> -			} else if (el_size == 8) {
> -				trace_seq_printf(s, "%"PRIu64, *(uint64_t *)num);
> -			} else {
> -				trace_seq_printf(s, "BAD SIZE:%d 0x%x",
> -						 el_size, *(uint8_t *)num);
> -				el_size = 1;
> -			}
> -
> -			num += el_size;
> -		}
> -		break;
> -	}
> -	case TEP_PRINT_TYPE:
> -		break;
> -	case TEP_PRINT_STRING: {
> -		int str_offset;
> -
> -		if (!arg->string.field)
> -			arg->string.field = tep_find_any_field(event, arg->string.string);
> -		if (!arg->string.field)
> -			break;
> -
> -		str_offset = data2host4(tep,
> -				*(unsigned int *)(data + arg->string.field->offset));
> -		str_offset &= 0xffff;
> -		if (arg->string.field->flags & TEP_FIELD_IS_RELATIVE)
> -			str_offset += arg->string.field->offset + arg->string.field->size;
> -		print_str_to_seq(s, format, len_arg, ((char *)data) + str_offset);
> -		break;
> -	}
> -	case TEP_PRINT_BSTRING:
> -		print_str_to_seq(s, format, len_arg, arg->string.string);
> -		break;
> -	case TEP_PRINT_BITMASK: {
> -		int bitmask_offset;
> -		int bitmask_size;
> -
> -		if (!arg->bitmask.field)
> -			arg->bitmask.field = tep_find_any_field(event, arg->bitmask.bitmask);
> -		if (!arg->bitmask.field)
> -			break;
> -		bitmask_offset = data2host4(tep,
> -				*(unsigned int *)(data + arg->bitmask.field->offset));
> -		bitmask_size = bitmask_offset >> 16;
> -		bitmask_offset &= 0xffff;
> -		if (arg->bitmask.field->flags & TEP_FIELD_IS_RELATIVE)
> -			bitmask_offset += arg->bitmask.field->offset + arg->bitmask.field->size;
> -		print_bitmask_to_seq(tep, s, format, len_arg,
> -				     data + bitmask_offset, bitmask_size);
> -		break;
> -	}
> -	case TEP_PRINT_OP:
> -		/*
> -		 * The only op for string should be ? :
> -		 */
> -		if (arg->op.op[0] != '?')
> -			return;
> -		val = eval_num_arg(data, size, event, arg->op.left);
> -		if (val)
> -			print_str_arg(s, data, size, event,
> -				      format, len_arg, arg->op.right->op.left);
> -		else
> -			print_str_arg(s, data, size, event,
> -				      format, len_arg, arg->op.right->op.right);
> -		break;
> -	case TEP_PRINT_FUNC:
> -		process_defined_func(s, data, size, event, arg);
> -		break;
> -	default:
> -		/* well... */
> -		break;
> -	}
> -
> -	return;
> -
> -out_warning_field:
> -	do_warning_event(event, "%s: field %s not found",
> -			 __func__, arg->field.name);
> -}
> -
> -static unsigned long long
> -process_defined_func(struct trace_seq *s, void *data, int size,
> -		     struct tep_event *event, struct tep_print_arg *arg)
> -{
> -	struct tep_function_handler *func_handle = arg->func.func;
> -	struct func_params *param;
> -	unsigned long long *args;
> -	unsigned long long ret;
> -	struct tep_print_arg *farg;
> -	struct trace_seq str;
> -	struct save_str {
> -		struct save_str *next;
> -		char *str;
> -	} *strings = NULL, *string;
> -	int i;
> -
> -	if (!func_handle->nr_args) {
> -		ret = (*func_handle->func)(s, NULL);
> -		goto out;
> -	}
> -
> -	farg = arg->func.args;
> -	param = func_handle->params;
> -
> -	ret = ULLONG_MAX;
> -	args = malloc(sizeof(*args) * func_handle->nr_args);
> -	if (!args)
> -		goto out;
> -
> -	for (i = 0; i < func_handle->nr_args; i++) {
> -		switch (param->type) {
> -		case TEP_FUNC_ARG_INT:
> -		case TEP_FUNC_ARG_LONG:
> -		case TEP_FUNC_ARG_PTR:
> -			args[i] = eval_num_arg(data, size, event, farg);
> -			break;
> -		case TEP_FUNC_ARG_STRING:
> -			trace_seq_init(&str);
> -			print_str_arg(&str, data, size, event, "%s", -1, farg);
> -			trace_seq_terminate(&str);
> -			string = malloc(sizeof(*string));
> -			if (!string) {
> -				do_warning_event(event, "%s(%d): malloc str",
> -						 __func__, __LINE__);
> -				goto out_free;
> -			}
> -			string->next = strings;
> -			string->str = strdup(str.buffer);
> -			if (!string->str) {
> -				free(string);
> -				do_warning_event(event, "%s(%d): malloc str",
> -						 __func__, __LINE__);
> -				goto out_free;
> -			}
> -			args[i] = (uintptr_t)string->str;
> -			strings = string;
> -			trace_seq_destroy(&str);
> -			break;
> -		default:
> -			/*
> -			 * Something went totally wrong, this is not
> -			 * an input error, something in this code broke.
> -			 */
> -			do_warning_event(event, "Unexpected end of arguments\n");
> -			goto out_free;
> -		}
> -		farg = farg->next;
> -		param = param->next;
> -	}
> -
> -	ret = (*func_handle->func)(s, args);
> -out_free:
> -	free(args);
> -	while (strings) {
> -		string = strings;
> -		strings = string->next;
> -		free(string->str);
> -		free(string);
> -	}
> -
> - out:
> -	/* TBD : handle return type here */
> -	return ret;
> -}
> -
> -static void free_args(struct tep_print_arg *args)
> -{
> -	struct tep_print_arg *next;
> -
> -	while (args) {
> -		next = args->next;
> -
> -		free_arg(args);
> -		args = next;
> -	}
> -}
> -
> -static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, struct tep_event *event)
> -{
> -	struct tep_handle *tep = event->tep;
> -	struct tep_format_field *field, *ip_field;
> -	struct tep_print_arg *args, *arg, **next;
> -	unsigned long long ip, val;
> -	char *ptr;
> -	void *bptr;
> -	int vsize = 0;
> -
> -	field = tep->bprint_buf_field;
> -	ip_field = tep->bprint_ip_field;
> -
> -	if (!field) {
> -		field = tep_find_field(event, "buf");
> -		if (!field) {
> -			do_warning_event(event, "can't find buffer field for binary printk");
> -			return NULL;
> -		}
> -		ip_field = tep_find_field(event, "ip");
> -		if (!ip_field) {
> -			do_warning_event(event, "can't find ip field for binary printk");
> -			return NULL;
> -		}
> -		tep->bprint_buf_field = field;
> -		tep->bprint_ip_field = ip_field;
> -	}
> -
> -	ip = tep_read_number(tep, data + ip_field->offset, ip_field->size);
> -
> -	/*
> -	 * The first arg is the IP pointer.
> -	 */
> -	args = alloc_arg();
> -	if (!args) {
> -		do_warning_event(event, "%s(%d): not enough memory!",
> -				 __func__, __LINE__);
> -		return NULL;
> -	}
> -	arg = args;
> -	arg->next = NULL;
> -	next = &arg->next;
> -
> -	arg->type = TEP_PRINT_ATOM;
> -		
> -	if (asprintf(&arg->atom.atom, "%lld", ip) < 0)
> -		goto out_free;
> -
> -	/* skip the first "%ps: " */
> -	for (ptr = fmt + 5, bptr = data + field->offset;
> -	     bptr < data + size && *ptr; ptr++) {
> -		int ls = 0;
> -
> -		if (*ptr == '%') {
> - process_again:
> -			ptr++;
> -			switch (*ptr) {
> -			case '%':
> -				break;
> -			case 'l':
> -				ls++;
> -				goto process_again;
> -			case 'L':
> -				ls = 2;
> -				goto process_again;
> -			case '0' ... '9':
> -				goto process_again;
> -			case '.':
> -				goto process_again;
> -			case 'z':
> -			case 'Z':
> -				ls = 1;
> -				goto process_again;
> -			case 'p':
> -				ls = 1;
> -				if (isalnum(ptr[1])) {
> -					ptr++;
> -					/* Check for special pointers */
> -					switch (*ptr) {
> -					case 's':
> -					case 'S':
> -					case 'x':
> -						break;
> -					case 'f':
> -					case 'F':
> -						/*
> -						 * Pre-5.5 kernels use %pf and
> -						 * %pF for printing symbols
> -						 * while kernels since 5.5 use
> -						 * %pfw for fwnodes. So check
> -						 * %p[fF] isn't followed by 'w'.
> -						 */
> -						if (ptr[1] != 'w')
> -							break;
> -						/* fall through */
> -					default:
> -						/*
> -						 * Older kernels do not process
> -						 * dereferenced pointers.
> -						 * Only process if the pointer
> -						 * value is a printable.
> -						 */
> -						if (isprint(*(char *)bptr))
> -							goto process_string;
> -					}
> -				}
> -				/* fall through */
> -			case 'd':
> -			case 'u':
> -			case 'i':
> -			case 'x':
> -			case 'X':
> -			case 'o':
> -				switch (ls) {
> -				case 0:
> -					vsize = 4;
> -					break;
> -				case 1:
> -					vsize = tep->long_size;
> -					break;
> -				case 2:
> -					vsize = 8;
> -					break;
> -				default:
> -					vsize = ls; /* ? */
> -					break;
> -				}
> -			/* fall through */
> -			case '*':
> -				if (*ptr == '*')
> -					vsize = 4;
> -
> -				/* the pointers are always 4 bytes aligned */
> -				bptr = (void *)(((unsigned long)bptr + 3) &
> -						~3);
> -				val = tep_read_number(tep, bptr, vsize);
> -				bptr += vsize;
> -				arg = alloc_arg();
> -				if (!arg) {
> -					do_warning_event(event, "%s(%d): not enough memory!",
> -						   __func__, __LINE__);
> -					goto out_free;
> -				}
> -				arg->next = NULL;
> -				arg->type = TEP_PRINT_ATOM;
> -				if (asprintf(&arg->atom.atom, "%lld", val) < 0) {
> -					free(arg);
> -					goto out_free;
> -				}
> -				*next = arg;
> -				next = &arg->next;
> -				/*
> -				 * The '*' case means that an arg is used as the length.
> -				 * We need to continue to figure out for what.
> -				 */
> -				if (*ptr == '*')
> -					goto process_again;
> -
> -				break;
> -			case 's':
> - process_string:
> -				arg = alloc_arg();
> -				if (!arg) {
> -					do_warning_event(event, "%s(%d): not enough memory!",
> -						   __func__, __LINE__);
> -					goto out_free;
> -				}
> -				arg->next = NULL;
> -				arg->type = TEP_PRINT_BSTRING;
> -				arg->string.string = strdup(bptr);
> -				if (!arg->string.string)
> -					goto out_free;
> -				bptr += strlen(bptr) + 1;
> -				*next = arg;
> -				next = &arg->next;
> -			default:
> -				break;
> -			}
> -		}
> -	}
> -
> -	return args;
> -
> -out_free:
> -	free_args(args);
> -	return NULL;
> -}
> -
> -static char *
> -get_bprint_format(void *data, int size __maybe_unused,
> -		  struct tep_event *event)
> -{
> -	struct tep_handle *tep = event->tep;
> -	unsigned long long addr;
> -	struct tep_format_field *field;
> -	struct printk_map *printk;
> -	char *format;
> -
> -	field = tep->bprint_fmt_field;
> -
> -	if (!field) {
> -		field = tep_find_field(event, "fmt");
> -		if (!field) {
> -			do_warning_event(event, "can't find format field for binary printk");
> -			return NULL;
> -		}
> -		tep->bprint_fmt_field = field;
> -	}
> -
> -	addr = tep_read_number(tep, data + field->offset, field->size);
> -
> -	printk = find_printk(tep, addr);
> -	if (!printk) {
> -		if (asprintf(&format, "%%ps: (NO FORMAT FOUND at %llx)\n", addr) < 0)
> -			return NULL;
> -		return format;
> -	}
> -
> -	if (asprintf(&format, "%s: %s", "%ps", printk->printk) < 0)
> -		return NULL;
> -
> -	return format;
> -}
> -
> -static int print_mac_arg(struct trace_seq *s, const char *format,
> -			 void *data, int size, struct tep_event *event,
> -			 struct tep_print_arg *arg)
> -{
> -	const char *fmt = "%.2x:%.2x:%.2x:%.2x:%.2x:%.2x";
> -	bool reverse = false;
> -	unsigned char *buf;
> -	int ret = 0;
> -
> -	if (arg->type == TEP_PRINT_FUNC) {
> -		process_defined_func(s, data, size, event, arg);
> -		return 0;
> -	}
> -
> -	if (arg->type != TEP_PRINT_FIELD) {
> -		trace_seq_printf(s, "ARG TYPE NOT FIELD BUT %d",
> -				 arg->type);
> -		return 0;
> -	}
> -
> -	if (format[0] == 'm') {
> -		fmt = "%.2x%.2x%.2x%.2x%.2x%.2x";
> -	} else if (format[0] == 'M' && format[1] == 'F') {
> -		fmt = "%.2x-%.2x-%.2x-%.2x-%.2x-%.2x";
> -		ret++;
> -	}
> -	if (format[1] == 'R') {
> -		reverse = true;
> -		ret++;
> -	}
> -
> -	if (!arg->field.field) {
> -		arg->field.field =
> -			tep_find_any_field(event, arg->field.name);
> -		if (!arg->field.field) {
> -			do_warning_event(event, "%s: field %s not found",
> -					 __func__, arg->field.name);
> -			return ret;
> -		}
> -	}
> -	if (arg->field.field->size != 6) {
> -		trace_seq_printf(s, "INVALIDMAC");
> -		return ret;
> -	}
> -
> -	buf = data + arg->field.field->offset;
> -	if (reverse)
> -		trace_seq_printf(s, fmt, buf[5], buf[4], buf[3], buf[2], buf[1], buf[0]);
> -	else
> -		trace_seq_printf(s, fmt, buf[0], buf[1], buf[2], buf[3], buf[4], buf[5]);
> -
> -	return ret;
> -}
> -
> -static int parse_ip4_print_args(struct tep_handle *tep,
> -				const char *ptr, bool *reverse)
> -{
> -	int ret = 0;
> -
> -	*reverse = false;
> -
> -	/* hnbl */
> -	switch (*ptr) {
> -	case 'h':
> -		if (tep->file_bigendian)
> -			*reverse = false;
> -		else
> -			*reverse = true;
> -		ret++;
> -		break;
> -	case 'l':
> -		*reverse = true;
> -		ret++;
> -		break;
> -	case 'n':
> -	case 'b':
> -		ret++;
> -		/* fall through */
> -	default:
> -		*reverse = false;
> -		break;
> -	}
> -
> -	return ret;
> -}
> -
> -static void print_ip4_addr(struct trace_seq *s, char i, bool reverse, unsigned char *buf)
> -{
> -	const char *fmt;
> -
> -	if (i == 'i')
> -		fmt = "%03d.%03d.%03d.%03d";
> -	else
> -		fmt = "%d.%d.%d.%d";
> -
> -	if (reverse)
> -		trace_seq_printf(s, fmt, buf[3], buf[2], buf[1], buf[0]);
> -	else
> -		trace_seq_printf(s, fmt, buf[0], buf[1], buf[2], buf[3]);
> -
> -}
> -
> -static inline bool ipv6_addr_v4mapped(const struct in6_addr *a)
> -{
> -	return ((unsigned long)(a->s6_addr32[0] | a->s6_addr32[1]) |
> -		(unsigned long)(a->s6_addr32[2] ^ htonl(0x0000ffff))) == 0UL;
> -}
> -
> -static inline bool ipv6_addr_is_isatap(const struct in6_addr *addr)
> -{
> -	return (addr->s6_addr32[2] | htonl(0x02000000)) == htonl(0x02005EFE);
> -}
> -
> -static void print_ip6c_addr(struct trace_seq *s, unsigned char *addr)
> -{
> -	int i, j, range;
> -	unsigned char zerolength[8];
> -	int longest = 1;
> -	int colonpos = -1;
> -	uint16_t word;
> -	uint8_t hi, lo;
> -	bool needcolon = false;
> -	bool useIPv4;
> -	struct in6_addr in6;
> -
> -	memcpy(&in6, addr, sizeof(struct in6_addr));
> -
> -	useIPv4 = ipv6_addr_v4mapped(&in6) || ipv6_addr_is_isatap(&in6);
> -
> -	memset(zerolength, 0, sizeof(zerolength));
> -
> -	if (useIPv4)
> -		range = 6;
> -	else
> -		range = 8;
> -
> -	/* find position of longest 0 run */
> -	for (i = 0; i < range; i++) {
> -		for (j = i; j < range; j++) {
> -			if (in6.s6_addr16[j] != 0)
> -				break;
> -			zerolength[i]++;
> -		}
> -	}
> -	for (i = 0; i < range; i++) {
> -		if (zerolength[i] > longest) {
> -			longest = zerolength[i];
> -			colonpos = i;
> -		}
> -	}
> -	if (longest == 1)		/* don't compress a single 0 */
> -		colonpos = -1;
> -
> -	/* emit address */
> -	for (i = 0; i < range; i++) {
> -		if (i == colonpos) {
> -			if (needcolon || i == 0)
> -				trace_seq_printf(s, ":");
> -			trace_seq_printf(s, ":");
> -			needcolon = false;
> -			i += longest - 1;
> -			continue;
> -		}
> -		if (needcolon) {
> -			trace_seq_printf(s, ":");
> -			needcolon = false;
> -		}
> -		/* hex u16 without leading 0s */
> -		word = ntohs(in6.s6_addr16[i]);
> -		hi = word >> 8;
> -		lo = word & 0xff;
> -		if (hi)
> -			trace_seq_printf(s, "%x%02x", hi, lo);
> -		else
> -			trace_seq_printf(s, "%x", lo);
> -
> -		needcolon = true;
> -	}
> -
> -	if (useIPv4) {
> -		if (needcolon)
> -			trace_seq_printf(s, ":");
> -		print_ip4_addr(s, 'I', false, &in6.s6_addr[12]);
> -	}
> -
> -	return;
> -}
> -
> -static void print_ip6_addr(struct trace_seq *s, char i, unsigned char *buf)
> -{
> -	int j;
> -
> -	for (j = 0; j < 16; j += 2) {
> -		trace_seq_printf(s, "%02x%02x", buf[j], buf[j+1]);
> -		if (i == 'I' && j < 14)
> -			trace_seq_printf(s, ":");
> -	}
> -}
> -
> -/*
> - * %pi4   print an IPv4 address with leading zeros
> - * %pI4   print an IPv4 address without leading zeros
> - * %pi6   print an IPv6 address without colons
> - * %pI6   print an IPv6 address with colons
> - * %pI6c  print an IPv6 address in compressed form with colons
> - * %pISpc print an IP address based on sockaddr; p adds port.
> - */
> -static int print_ipv4_arg(struct trace_seq *s, const char *ptr, char i,
> -			  void *data, int size, struct tep_event *event,
> -			  struct tep_print_arg *arg)
> -{
> -	bool reverse = false;
> -	unsigned char *buf;
> -	int ret;
> -
> -	ret = parse_ip4_print_args(event->tep, ptr, &reverse);
> -
> -	if (arg->type == TEP_PRINT_FUNC) {
> -		process_defined_func(s, data, size, event, arg);
> -		return ret;
> -	}
> -
> -	if (arg->type != TEP_PRINT_FIELD) {
> -		trace_seq_printf(s, "ARG TYPE NOT FIELD BUT %d", arg->type);
> -		return ret;
> -	}
> -
> -	if (!arg->field.field) {
> -		arg->field.field =
> -			tep_find_any_field(event, arg->field.name);
> -		if (!arg->field.field) {
> -			do_warning("%s: field %s not found",
> -				   __func__, arg->field.name);
> -			return ret;
> -		}
> -	}
> -
> -	buf = data + arg->field.field->offset;
> -
> -	if (arg->field.field->size != 4) {
> -		trace_seq_printf(s, "INVALIDIPv4");
> -		return ret;
> -	}
> -
> -	print_ip4_addr(s, i, reverse, buf);
> -	return ret;
> -
> -}
> -
> -static int print_ipv6_arg(struct trace_seq *s, const char *ptr, char i,
> -			  void *data, int size, struct tep_event *event,
> -			  struct tep_print_arg *arg)
> -{
> -	char have_c = 0;
> -	unsigned char *buf;
> -	int rc = 0;
> -
> -	/* pI6c */
> -	if (i == 'I' && *ptr == 'c') {
> -		have_c = 1;
> -		ptr++;
> -		rc++;
> -	}
> -
> -	if (arg->type == TEP_PRINT_FUNC) {
> -		process_defined_func(s, data, size, event, arg);
> -		return rc;
> -	}
> -
> -	if (arg->type != TEP_PRINT_FIELD) {
> -		trace_seq_printf(s, "ARG TYPE NOT FIELD BUT %d", arg->type);
> -		return rc;
> -	}
> -
> -	if (!arg->field.field) {
> -		arg->field.field =
> -			tep_find_any_field(event, arg->field.name);
> -		if (!arg->field.field) {
> -			do_warning("%s: field %s not found",
> -				   __func__, arg->field.name);
> -			return rc;
> -		}
> -	}
> -
> -	buf = data + arg->field.field->offset;
> -
> -	if (arg->field.field->size != 16) {
> -		trace_seq_printf(s, "INVALIDIPv6");
> -		return rc;
> -	}
> -
> -	if (have_c)
> -		print_ip6c_addr(s, buf);
> -	else
> -		print_ip6_addr(s, i, buf);
> -
> -	return rc;
> -}
> -
> -static int print_ipsa_arg(struct trace_seq *s, const char *ptr, char i,
> -			  void *data, int size, struct tep_event *event,
> -			  struct tep_print_arg *arg)
> -{
> -	char have_c = 0, have_p = 0;
> -	unsigned char *buf;
> -	struct sockaddr_storage *sa;
> -	bool reverse = false;
> -	int rc = 0;
> -	int ret;
> -
> -	/* pISpc */
> -	if (i == 'I') {
> -		if (*ptr == 'p') {
> -			have_p = 1;
> -			ptr++;
> -			rc++;
> -		}
> -		if (*ptr == 'c') {
> -			have_c = 1;
> -			ptr++;
> -			rc++;
> -		}
> -	}
> -	ret = parse_ip4_print_args(event->tep, ptr, &reverse);
> -	ptr += ret;
> -	rc += ret;
> -
> -	if (arg->type == TEP_PRINT_FUNC) {
> -		process_defined_func(s, data, size, event, arg);
> -		return rc;
> -	}
> -
> -	if (arg->type != TEP_PRINT_FIELD) {
> -		trace_seq_printf(s, "ARG TYPE NOT FIELD BUT %d", arg->type);
> -		return rc;
> -	}
> -
> -	if (!arg->field.field) {
> -		arg->field.field =
> -			tep_find_any_field(event, arg->field.name);
> -		if (!arg->field.field) {
> -			do_warning("%s: field %s not found",
> -				   __func__, arg->field.name);
> -			return rc;
> -		}
> -	}
> -
> -	sa = (struct sockaddr_storage *) (data + arg->field.field->offset);
> -
> -	if (sa->ss_family == AF_INET) {
> -		struct sockaddr_in *sa4 = (struct sockaddr_in *) sa;
> -
> -		if (arg->field.field->size < sizeof(struct sockaddr_in)) {
> -			trace_seq_printf(s, "INVALIDIPv4");
> -			return rc;
> -		}
> -
> -		print_ip4_addr(s, i, reverse, (unsigned char *) &sa4->sin_addr);
> -		if (have_p)
> -			trace_seq_printf(s, ":%d", ntohs(sa4->sin_port));
> -
> -
> -	} else if (sa->ss_family == AF_INET6) {
> -		struct sockaddr_in6 *sa6 = (struct sockaddr_in6 *) sa;
> -
> -		if (arg->field.field->size < sizeof(struct sockaddr_in6)) {
> -			trace_seq_printf(s, "INVALIDIPv6");
> -			return rc;
> -		}
> -
> -		if (have_p)
> -			trace_seq_printf(s, "[");
> -
> -		buf = (unsigned char *) &sa6->sin6_addr;
> -		if (have_c)
> -			print_ip6c_addr(s, buf);
> -		else
> -			print_ip6_addr(s, i, buf);
> -
> -		if (have_p)
> -			trace_seq_printf(s, "]:%d", ntohs(sa6->sin6_port));
> -	}
> -
> -	return rc;
> -}
> -
> -static int print_ip_arg(struct trace_seq *s, const char *ptr,
> -			void *data, int size, struct tep_event *event,
> -			struct tep_print_arg *arg)
> -{
> -	char i = *ptr;  /* 'i' or 'I' */
> -	int rc = 1;
> -
> -	/* IP version */
> -	ptr++;
> -
> -	switch (*ptr) {
> -	case '4':
> -		rc += print_ipv4_arg(s, ptr + 1, i, data, size, event, arg);
> -		break;
> -	case '6':
> -		rc += print_ipv6_arg(s, ptr + 1, i, data, size, event, arg);
> -		break;
> -	case 'S':
> -		rc += print_ipsa_arg(s, ptr + 1, i, data, size, event, arg);
> -		break;
> -	default:
> -		return 0;
> -	}
> -
> -	return rc;
> -}
> -
> -static const int guid_index[16] = {3, 2, 1, 0, 5, 4, 7, 6, 8, 9, 10, 11, 12, 13, 14, 15};
> -static const int uuid_index[16] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
> -
> -static int print_uuid_arg(struct trace_seq *s, const char *ptr,
> -			void *data, int size, struct tep_event *event,
> -			struct tep_print_arg *arg)
> -{
> -	const int *index = uuid_index;
> -	char *format = "%02x";
> -	int ret = 0;
> -	char *buf;
> -	int i;
> -
> -	switch (*(ptr + 1)) {
> -	case 'L':
> -		format = "%02X";
> -		/* fall through */
> -	case 'l':
> -		index = guid_index;
> -		ret++;
> -		break;
> -	case 'B':
> -		format = "%02X";
> -		/* fall through */
> -	case 'b':
> -		ret++;
> -		break;
> -	}
> -
> -	if (arg->type == TEP_PRINT_FUNC) {
> -		process_defined_func(s, data, size, event, arg);
> -		return ret;
> -	}
> -
> -	if (arg->type != TEP_PRINT_FIELD) {
> -		trace_seq_printf(s, "ARG TYPE NOT FIELD BUT %d", arg->type);
> -		return ret;
> -	}
> -
> -	if (!arg->field.field) {
> -		arg->field.field =
> -			tep_find_any_field(event, arg->field.name);
> -		if (!arg->field.field) {
> -			do_warning("%s: field %s not found",
> -				   __func__, arg->field.name);
> -			return ret;
> -		}
> -	}
> -
> -	if (arg->field.field->size != 16) {
> -		trace_seq_printf(s, "INVALIDUUID");
> -		return ret;
> -	}
> -
> -	buf = data + arg->field.field->offset;
> -
> -	for (i = 0; i < 16; i++) {
> -		trace_seq_printf(s, format, buf[index[i]] & 0xff);
> -		switch (i) {
> -		case 3:
> -		case 5:
> -		case 7:
> -		case 9:
> -			trace_seq_printf(s, "-");
> -			break;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
> -static int print_raw_buff_arg(struct trace_seq *s, const char *ptr,
> -			      void *data, int size, struct tep_event *event,
> -			      struct tep_print_arg *arg, int print_len)
> -{
> -	int plen = print_len;
> -	char *delim = " ";
> -	int ret = 0;
> -	char *buf;
> -	int i;
> -	unsigned long offset;
> -	int arr_len;
> -
> -	switch (*(ptr + 1)) {
> -	case 'C':
> -		delim = ":";
> -		ret++;
> -		break;
> -	case 'D':
> -		delim = "-";
> -		ret++;
> -		break;
> -	case 'N':
> -		delim = "";
> -		ret++;
> -		break;
> -	}
> -
> -	if (arg->type == TEP_PRINT_FUNC) {
> -		process_defined_func(s, data, size, event, arg);
> -		return ret;
> -	}
> -
> -	if (arg->type != TEP_PRINT_DYNAMIC_ARRAY) {
> -		trace_seq_printf(s, "ARG TYPE NOT FIELD BUT %d", arg->type);
> -		return ret;
> -	}
> -
> -	offset = tep_read_number(event->tep,
> -				 data + arg->dynarray.field->offset,
> -				 arg->dynarray.field->size);
> -	arr_len = (unsigned long long)(offset >> 16);
> -	buf = data + (offset & 0xffff);
> -
> -	if (arr_len < plen)
> -		plen = arr_len;
> -
> -	if (plen < 1)
> -		return ret;
> -
> -	trace_seq_printf(s, "%02x", buf[0] & 0xff);
> -	for (i = 1; i < plen; i++)
> -		trace_seq_printf(s, "%s%02x", delim, buf[i] & 0xff);
> -
> -	return ret;
> -}
> -
> -static int is_printable_array(char *p, unsigned int len)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < len && p[i]; i++)
> -		if (!isprint(p[i]) && !isspace(p[i]))
> -		    return 0;
> -	return 1;
> -}
> -
> -void tep_print_field(struct trace_seq *s, void *data,
> -		     struct tep_format_field *field)
> -{
> -	unsigned long long val;
> -	unsigned int offset, len, i;
> -	struct tep_handle *tep = field->event->tep;
> -
> -	if (field->flags & TEP_FIELD_IS_ARRAY) {
> -		offset = field->offset;
> -		len = field->size;
> -		if (field->flags & TEP_FIELD_IS_DYNAMIC) {
> -			val = tep_read_number(tep, data + offset, len);
> -			offset = val;
> -			len = offset >> 16;
> -			offset &= 0xffff;
> -			if (field->flags & TEP_FIELD_IS_RELATIVE)
> -				offset += field->offset + field->size;
> -		}
> -		if (field->flags & TEP_FIELD_IS_STRING &&
> -		    is_printable_array(data + offset, len)) {
> -			trace_seq_printf(s, "%s", (char *)data + offset);
> -		} else {
> -			trace_seq_puts(s, "ARRAY[");
> -			for (i = 0; i < len; i++) {
> -				if (i)
> -					trace_seq_puts(s, ", ");
> -				trace_seq_printf(s, "%02x",
> -						 *((unsigned char *)data + offset + i));
> -			}
> -			trace_seq_putc(s, ']');
> -			field->flags &= ~TEP_FIELD_IS_STRING;
> -		}
> -	} else {
> -		val = tep_read_number(tep, data + field->offset,
> -				      field->size);
> -		if (field->flags & TEP_FIELD_IS_POINTER) {
> -			trace_seq_printf(s, "0x%llx", val);
> -		} else if (field->flags & TEP_FIELD_IS_SIGNED) {
> -			switch (field->size) {
> -			case 4:
> -				/*
> -				 * If field is long then print it in hex.
> -				 * A long usually stores pointers.
> -				 */
> -				if (field->flags & TEP_FIELD_IS_LONG)
> -					trace_seq_printf(s, "0x%x", (int)val);
> -				else
> -					trace_seq_printf(s, "%d", (int)val);
> -				break;
> -			case 2:
> -				trace_seq_printf(s, "%2d", (short)val);
> -				break;
> -			case 1:
> -				trace_seq_printf(s, "%1d", (char)val);
> -				break;
> -			default:
> -				trace_seq_printf(s, "%lld", val);
> -			}
> -		} else {
> -			if (field->flags & TEP_FIELD_IS_LONG)
> -				trace_seq_printf(s, "0x%llx", val);
> -			else
> -				trace_seq_printf(s, "%llu", val);
> -		}
> -	}
> -}
> -
> -void tep_print_fields(struct trace_seq *s, void *data,
> -		      int size __maybe_unused, struct tep_event *event)
> -{
> -	struct tep_format_field *field;
> -
> -	field = event->format.fields;
> -	while (field) {
> -		trace_seq_printf(s, " %s=", field->name);
> -		tep_print_field(s, data, field);
> -		field = field->next;
> -	}
> -}
> -
> -static int print_function(struct trace_seq *s, const char *format,
> -			  void *data, int size, struct tep_event *event,
> -			  struct tep_print_arg *arg)
> -{
> -	struct func_map *func;
> -	unsigned long long val;
> -
> -	val = eval_num_arg(data, size, event, arg);
> -	func = find_func(event->tep, val);
> -	if (func) {
> -		trace_seq_puts(s, func->func);
> -		if (*format == 'F' || *format == 'S')
> -			trace_seq_printf(s, "+0x%llx", val - func->addr);
> -	} else {
> -		if (event->tep->long_size == 4)
> -			trace_seq_printf(s, "0x%lx", (long)val);
> -		else
> -			trace_seq_printf(s, "0x%llx", (long long)val);
> -	}
> -
> -	return 0;
> -}
> -
> -static int print_arg_pointer(struct trace_seq *s, const char *format, int plen,
> -			     void *data, int size,
> -			     struct tep_event *event, struct tep_print_arg *arg)
> -{
> -	unsigned long long val;
> -	int ret = 1;
> -
> -	if (arg->type == TEP_PRINT_BSTRING) {
> -		trace_seq_puts(s, arg->string.string);
> -		return 0;
> -	}
> -	while (*format) {
> -		if (*format == 'p') {
> -			format++;
> -			break;
> -		}
> -		format++;
> -	}
> -
> -	switch (*format) {
> -	case 'F':
> -	case 'f':
> -	case 'S':
> -	case 's':
> -		ret += print_function(s, format, data, size, event, arg);
> -		break;
> -	case 'M':
> -	case 'm':
> -		ret += print_mac_arg(s, format, data, size, event, arg);
> -		break;
> -	case 'I':
> -	case 'i':
> -		ret += print_ip_arg(s, format, data, size, event, arg);
> -		break;
> -	case 'U':
> -		ret += print_uuid_arg(s, format, data, size, event, arg);
> -		break;
> -	case 'h':
> -		ret += print_raw_buff_arg(s, format, data, size, event, arg, plen);
> -		break;
> -	default:
> -		ret = 0;
> -		val = eval_num_arg(data, size, event, arg);
> -		trace_seq_printf(s, "%p", (void *)(intptr_t)val);
> -		break;
> -	}
> -
> -	return ret;
> -
> -}
> -
> -static int print_arg_number(struct trace_seq *s, const char *format, int plen,
> -			    void *data, int size, int ls,
> -			    struct tep_event *event, struct tep_print_arg *arg)
> -{
> -	unsigned long long val;
> -
> -	val = eval_num_arg(data, size, event, arg);
> -
> -	switch (ls) {
> -	case -2:
> -		if (plen >= 0)
> -			trace_seq_printf(s, format, plen, (char)val);
> -		else
> -			trace_seq_printf(s, format, (char)val);
> -		break;
> -	case -1:
> -		if (plen >= 0)
> -			trace_seq_printf(s, format, plen, (short)val);
> -		else
> -			trace_seq_printf(s, format, (short)val);
> -		break;
> -	case 0:
> -		if (plen >= 0)
> -			trace_seq_printf(s, format, plen, (int)val);
> -		else
> -			trace_seq_printf(s, format, (int)val);
> -		break;
> -	case 1:
> -		if (plen >= 0)
> -			trace_seq_printf(s, format, plen, (long)val);
> -		else
> -			trace_seq_printf(s, format, (long)val);
> -		break;
> -	case 2:
> -		if (plen >= 0)
> -			trace_seq_printf(s, format, plen, (long long)val);
> -		else
> -			trace_seq_printf(s, format, (long long)val);
> -		break;
> -	default:
> -		do_warning_event(event, "bad count (%d)", ls);
> -		event->flags |= TEP_EVENT_FL_FAILED;
> -	}
> -	return 0;
> -}
> -
> -
> -static void print_arg_string(struct trace_seq *s, const char *format, int plen,
> -			     void *data, int size,
> -			     struct tep_event *event, struct tep_print_arg *arg)
> -{
> -	struct trace_seq p;
> -
> -	/* Use helper trace_seq */
> -	trace_seq_init(&p);
> -	print_str_arg(&p, data, size, event,
> -		      format, plen, arg);
> -	trace_seq_terminate(&p);
> -	trace_seq_puts(s, p.buffer);
> -	trace_seq_destroy(&p);
> -}
> -
> -static int parse_arg_format_pointer(const char *format)
> -{
> -	int ret = 0;
> -	int index;
> -	int loop;
> -
> -	switch (*format) {
> -	case 'F':
> -	case 'S':
> -	case 'f':
> -	case 's':
> -		ret++;
> -		break;
> -	case 'M':
> -	case 'm':
> -		/* [mM]R , [mM]F */
> -		switch (format[1]) {
> -		case 'R':
> -		case 'F':
> -			ret++;
> -			break;
> -		}
> -		ret++;
> -		break;
> -	case 'I':
> -	case 'i':
> -		index = 2;
> -		loop = 1;
> -		switch (format[1]) {
> -		case 'S':
> -			/*[S][pfs]*/
> -			while (loop) {
> -				switch (format[index]) {
> -				case 'p':
> -				case 'f':
> -				case 's':
> -					ret++;
> -					index++;
> -					break;
> -				default:
> -					loop = 0;
> -					break;
> -				}
> -			}
> -			/* fall through */
> -		case '4':
> -			/* [4S][hnbl] */
> -			switch (format[index]) {
> -			case 'h':
> -			case 'n':
> -			case 'l':
> -			case 'b':
> -				ret++;
> -				index++;
> -				break;
> -			}
> -			if (format[1] == '4') {
> -				ret++;
> -				break;
> -			}
> -			/* fall through */
> -		case '6':
> -			/* [6S]c */
> -			if (format[index] == 'c')
> -				ret++;
> -			ret++;
> -			break;
> -		}
> -		ret++;
> -		break;
> -	case 'U':
> -		switch (format[1]) {
> -		case 'L':
> -		case 'l':
> -		case 'B':
> -		case 'b':
> -			ret++;
> -			break;
> -		}
> -		ret++;
> -		break;
> -	case 'h':
> -		switch (format[1]) {
> -		case 'C':
> -		case 'D':
> -		case 'N':
> -			ret++;
> -			break;
> -		}
> -		ret++;
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	return ret;
> -}
> -
> -static void free_parse_args(struct tep_print_parse *arg)
> -{
> -	struct tep_print_parse *del;
> -
> -	while (arg) {
> -		del = arg;
> -		arg = del->next;
> -		free(del->format);
> -		free(del);
> -	}
> -}
> -
> -static int parse_arg_add(struct tep_print_parse **parse, char *format,
> -			 enum tep_print_parse_type type,
> -			 struct tep_print_arg *arg,
> -			 struct tep_print_arg *len_as_arg,
> -			 int ls)
> -{
> -	struct tep_print_parse *parg = NULL;
> -
> -	parg = calloc(1, sizeof(*parg));
> -	if (!parg)
> -		goto error;
> -	parg->format = strdup(format);
> -	if (!parg->format)
> -		goto error;
> -	parg->type = type;
> -	parg->arg = arg;
> -	parg->len_as_arg = len_as_arg;
> -	parg->ls = ls;
> -	*parse = parg;
> -	return 0;
> -error:
> -	if (parg) {
> -		free(parg->format);
> -		free(parg);
> -	}
> -	return -1;
> -}
> -
> -static int parse_arg_format(struct tep_print_parse **parse,
> -			    struct tep_event *event,
> -			    const char *format, struct tep_print_arg **arg)
> -{
> -	struct tep_print_arg *len_arg = NULL;
> -	char print_format[32];
> -	const char *start = format;
> -	int ret = 0;
> -	int ls = 0;
> -	int res;
> -	int len;
> -
> -	format++;
> -	ret++;
> -	for (; *format; format++) {
> -		switch (*format) {
> -		case '#':
> -			/* FIXME: need to handle properly */
> -			break;
> -		case 'h':
> -			ls--;
> -			break;
> -		case 'l':
> -			ls++;
> -			break;
> -		case 'L':
> -			ls = 2;
> -			break;
> -		case '.':
> -		case 'z':
> -		case 'Z':
> -		case '0' ... '9':
> -		case '-':
> -			break;
> -		case '*':
> -			/* The argument is the length. */
> -			if (!*arg) {
> -				do_warning_event(event, "no argument match");
> -				event->flags |= TEP_EVENT_FL_FAILED;
> -				goto out_failed;
> -			}
> -			if (len_arg) {
> -				do_warning_event(event, "argument already matched");
> -				event->flags |= TEP_EVENT_FL_FAILED;
> -				goto out_failed;
> -			}
> -			len_arg = *arg;
> -			*arg = (*arg)->next;
> -			break;
> -		case 'p':
> -			if (!*arg) {
> -				do_warning_event(event, "no argument match");
> -				event->flags |= TEP_EVENT_FL_FAILED;
> -				goto out_failed;
> -			}
> -			res = parse_arg_format_pointer(format + 1);
> -			if (res > 0) {
> -				format += res;
> -				ret += res;
> -			}
> -			len = ((unsigned long)format + 1) -
> -				(unsigned long)start;
> -			/* should never happen */
> -			if (len > 31) {
> -				do_warning_event(event, "bad format!");
> -				event->flags |= TEP_EVENT_FL_FAILED;
> -				len = 31;
> -			}
> -			memcpy(print_format, start, len);
> -			print_format[len] = 0;
> -
> -			parse_arg_add(parse, print_format,
> -				      PRINT_FMT_ARG_POINTER, *arg, len_arg, ls);
> -			*arg = (*arg)->next;
> -			ret++;
> -			return ret;
> -		case 'd':
> -		case 'u':
> -		case 'i':
> -		case 'x':
> -		case 'X':
> -		case 'o':
> -			if (!*arg) {
> -				do_warning_event(event, "no argument match");
> -				event->flags |= TEP_EVENT_FL_FAILED;
> -				goto out_failed;
> -			}
> -
> -			len = ((unsigned long)format + 1) -
> -				(unsigned long)start;
> -
> -			/* should never happen */
> -			if (len > 30) {
> -				do_warning_event(event, "bad format!");
> -				event->flags |= TEP_EVENT_FL_FAILED;
> -				len = 31;
> -			}
> -			memcpy(print_format, start, len);
> -			print_format[len] = 0;
> -
> -			if (event->tep->long_size == 8 && ls == 1 &&
> -			    sizeof(long) != 8) {
> -				char *p;
> -
> -				/* make %l into %ll */
> -				if (ls == 1 && (p = strchr(print_format, 'l')))
> -					memmove(p+1, p, strlen(p)+1);
> -				ls = 2;
> -			}
> -			if (ls < -2 || ls > 2) {
> -				do_warning_event(event, "bad count (%d)", ls);
> -				event->flags |= TEP_EVENT_FL_FAILED;
> -			}
> -			parse_arg_add(parse, print_format,
> -				      PRINT_FMT_ARG_DIGIT, *arg, len_arg, ls);
> -			*arg = (*arg)->next;
> -			ret++;
> -			return ret;
> -		case 's':
> -			if (!*arg) {
> -				do_warning_event(event, "no matching argument");
> -				event->flags |= TEP_EVENT_FL_FAILED;
> -				goto out_failed;
> -			}
> -
> -			len = ((unsigned long)format + 1) -
> -				(unsigned long)start;
> -
> -			/* should never happen */
> -			if (len > 31) {
> -				do_warning_event(event, "bad format!");
> -				event->flags |= TEP_EVENT_FL_FAILED;
> -				len = 31;
> -			}
> -
> -			memcpy(print_format, start, len);
> -			print_format[len] = 0;
> -
> -			parse_arg_add(parse, print_format,
> -					PRINT_FMT_ARG_STRING, *arg, len_arg, 0);
> -			*arg = (*arg)->next;
> -			ret++;
> -			return ret;
> -		default:
> -			snprintf(print_format, 32, ">%c<", *format);
> -			parse_arg_add(parse, print_format,
> -					PRINT_FMT_STRING, NULL, NULL, 0);
> -			ret++;
> -			return ret;
> -		}
> -		ret++;
> -	}
> -
> -out_failed:
> -	return ret;
> -
> -}
> -
> -static int parse_arg_string(struct tep_print_parse **parse, const char *format)
> -{
> -	struct trace_seq s;
> -	int ret = 0;
> -
> -	trace_seq_init(&s);
> -	for (; *format; format++) {
> -		if (*format == '\\') {
> -			format++;
> -			ret++;
> -			switch (*format) {
> -			case 'n':
> -				trace_seq_putc(&s, '\n');
> -				break;
> -			case 't':
> -				trace_seq_putc(&s, '\t');
> -				break;
> -			case 'r':
> -				trace_seq_putc(&s, '\r');
> -				break;
> -			case '\\':
> -				trace_seq_putc(&s, '\\');
> -				break;
> -			default:
> -				trace_seq_putc(&s, *format);
> -				break;
> -			}
> -		} else if (*format == '%') {
> -			if (*(format + 1) == '%') {
> -				trace_seq_putc(&s, '%');
> -				format++;
> -				ret++;
> -			} else
> -				break;
> -		} else
> -			trace_seq_putc(&s, *format);
> -
> -		ret++;
> -	}
> -	trace_seq_terminate(&s);
> -	parse_arg_add(parse, s.buffer, PRINT_FMT_STRING, NULL, NULL, 0);
> -	trace_seq_destroy(&s);
> -
> -	return ret;
> -}
> -
> -static struct tep_print_parse *
> -parse_args(struct tep_event *event, const char *format, struct tep_print_arg *arg)
> -{
> -	struct tep_print_parse *parse_ret = NULL;
> -	struct tep_print_parse **parse = NULL;
> -	int ret;
> -	int len;
> -
> -	len = strlen(format);
> -	while (*format) {
> -		if (!parse_ret)
> -			parse = &parse_ret;
> -		if (*format == '%' && *(format + 1) != '%')
> -			ret = parse_arg_format(parse, event, format, &arg);
> -		else
> -			ret = parse_arg_string(parse, format);
> -		if (*parse)
> -			parse = &((*parse)->next);
> -
> -		len -= ret;
> -		if (len > 0)
> -			format += ret;
> -		else
> -			break;
> -	}
> -	return parse_ret;
> -}
> -
> -static void print_event_cache(struct tep_print_parse *parse, struct trace_seq *s,
> -			      void *data, int size, struct tep_event *event)
> -{
> -	int len_arg;
> -
> -	while (parse) {
> -		if (parse->len_as_arg)
> -			len_arg = eval_num_arg(data, size, event, parse->len_as_arg);
> -		switch (parse->type) {
> -		case PRINT_FMT_ARG_DIGIT:
> -			print_arg_number(s, parse->format,
> -					parse->len_as_arg ? len_arg : -1, data,
> -					 size, parse->ls, event, parse->arg);
> -			break;
> -		case PRINT_FMT_ARG_POINTER:
> -			print_arg_pointer(s, parse->format,
> -					  parse->len_as_arg ? len_arg : 1,
> -					  data, size, event, parse->arg);
> -			break;
> -		case PRINT_FMT_ARG_STRING:
> -			print_arg_string(s, parse->format,
> -					 parse->len_as_arg ? len_arg : -1,
> -					 data, size, event, parse->arg);
> -			break;
> -		case PRINT_FMT_STRING:
> -		default:
> -			trace_seq_printf(s, "%s", parse->format);
> -			break;
> -		}
> -		parse = parse->next;
> -	}
> -}
> -
> -static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_event *event)
> -{
> -	struct tep_print_parse *parse = event->print_fmt.print_cache;
> -	struct tep_print_arg *args = NULL;
> -	char *bprint_fmt = NULL;
> -
> -	if (event->flags & TEP_EVENT_FL_FAILED) {
> -		trace_seq_printf(s, "[FAILED TO PARSE]");
> -		tep_print_fields(s, data, size, event);
> -		return;
> -	}
> -
> -	if (event->flags & TEP_EVENT_FL_ISBPRINT) {
> -		bprint_fmt = get_bprint_format(data, size, event);
> -		args = make_bprint_args(bprint_fmt, data, size, event);
> -		parse = parse_args(event, bprint_fmt, args);
> -	}
> -
> -	print_event_cache(parse, s, data, size, event);
> -
> -	if (event->flags & TEP_EVENT_FL_ISBPRINT) {
> -		free_parse_args(parse);
> -		free_args(args);
> -		free(bprint_fmt);
> -	}
> -}
> -
> -/*
> - * This parses out the Latency format (interrupts disabled,
> - * need rescheduling, in hard/soft interrupt, preempt count
> - * and lock depth) and places it into the trace_seq.
> - */
> -static void data_latency_format(struct tep_handle *tep, struct trace_seq *s,
> -				char *format, struct tep_record *record)
> -{
> -	static int check_lock_depth = 1;
> -	static int check_migrate_disable = 1;
> -	static int lock_depth_exists;
> -	static int migrate_disable_exists;
> -	unsigned int lat_flags;
> -	struct trace_seq sq;
> -	unsigned int pc;
> -	int lock_depth = 0;
> -	int migrate_disable = 0;
> -	int hardirq;
> -	int softirq;
> -	void *data = record->data;
> -
> -	trace_seq_init(&sq);
> -	lat_flags = parse_common_flags(tep, data);
> -	pc = parse_common_pc(tep, data);
> -	/* lock_depth may not always exist */
> -	if (lock_depth_exists)
> -		lock_depth = parse_common_lock_depth(tep, data);
> -	else if (check_lock_depth) {
> -		lock_depth = parse_common_lock_depth(tep, data);
> -		if (lock_depth < 0)
> -			check_lock_depth = 0;
> -		else
> -			lock_depth_exists = 1;
> -	}
> -
> -	/* migrate_disable may not always exist */
> -	if (migrate_disable_exists)
> -		migrate_disable = parse_common_migrate_disable(tep, data);
> -	else if (check_migrate_disable) {
> -		migrate_disable = parse_common_migrate_disable(tep, data);
> -		if (migrate_disable < 0)
> -			check_migrate_disable = 0;
> -		else
> -			migrate_disable_exists = 1;
> -	}
> -
> -	hardirq = lat_flags & TRACE_FLAG_HARDIRQ;
> -	softirq = lat_flags & TRACE_FLAG_SOFTIRQ;
> -
> -	trace_seq_printf(&sq, "%c%c%c",
> -	       (lat_flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
> -	       (lat_flags & TRACE_FLAG_IRQS_NOSUPPORT) ?
> -	       'X' : '.',
> -	       (lat_flags & TRACE_FLAG_NEED_RESCHED) ?
> -	       'N' : '.',
> -	       (hardirq && softirq) ? 'H' :
> -	       hardirq ? 'h' : softirq ? 's' : '.');
> -
> -	if (pc)
> -		trace_seq_printf(&sq, "%x", pc);
> -	else
> -		trace_seq_printf(&sq, ".");
> -
> -	if (migrate_disable_exists) {
> -		if (migrate_disable < 0)
> -			trace_seq_printf(&sq, ".");
> -		else
> -			trace_seq_printf(&sq, "%d", migrate_disable);
> -	}
> -
> -	if (lock_depth_exists) {
> -		if (lock_depth < 0)
> -			trace_seq_printf(&sq, ".");
> -		else
> -			trace_seq_printf(&sq, "%d", lock_depth);
> -	}
> -
> -	if (sq.state == TRACE_SEQ__MEM_ALLOC_FAILED) {
> -		s->state = TRACE_SEQ__MEM_ALLOC_FAILED;
> -		return;
> -	}
> -
> -	trace_seq_terminate(&sq);
> -	trace_seq_puts(s, sq.buffer);
> -	trace_seq_destroy(&sq);
> -	trace_seq_terminate(s);
> -}
> -
> -/**
> - * tep_data_type - parse out the given event type
> - * @tep: a handle to the trace event parser context
> - * @rec: the record to read from
> - *
> - * This returns the event id from the @rec.
> - */
> -int tep_data_type(struct tep_handle *tep, struct tep_record *rec)
> -{
> -	return trace_parse_common_type(tep, rec->data);
> -}
> -
> -/**
> - * tep_data_pid - parse the PID from record
> - * @tep: a handle to the trace event parser context
> - * @rec: the record to parse
> - *
> - * This returns the PID from a record.
> - */
> -int tep_data_pid(struct tep_handle *tep, struct tep_record *rec)
> -{
> -	return parse_common_pid(tep, rec->data);
> -}
> -
> -/**
> - * tep_data_preempt_count - parse the preempt count from the record
> - * @tep: a handle to the trace event parser context
> - * @rec: the record to parse
> - *
> - * This returns the preempt count from a record.
> - */
> -int tep_data_preempt_count(struct tep_handle *tep, struct tep_record *rec)
> -{
> -	return parse_common_pc(tep, rec->data);
> -}
> -
> -/**
> - * tep_data_flags - parse the latency flags from the record
> - * @tep: a handle to the trace event parser context
> - * @rec: the record to parse
> - *
> - * This returns the latency flags from a record.
> - *
> - *  Use trace_flag_type enum for the flags (see event-parse.h).
> - */
> -int tep_data_flags(struct tep_handle *tep, struct tep_record *rec)
> -{
> -	return parse_common_flags(tep, rec->data);
> -}
> -
> -/**
> - * tep_data_comm_from_pid - return the command line from PID
> - * @tep: a handle to the trace event parser context
> - * @pid: the PID of the task to search for
> - *
> - * This returns a pointer to the command line that has the given
> - * @pid.
> - */
> -const char *tep_data_comm_from_pid(struct tep_handle *tep, int pid)
> -{
> -	const char *comm;
> -
> -	comm = find_cmdline(tep, pid);
> -	return comm;
> -}
> -
> -static struct tep_cmdline *
> -pid_from_cmdlist(struct tep_handle *tep, const char *comm, struct tep_cmdline *next)
> -{
> -	struct cmdline_list *cmdlist = (struct cmdline_list *)next;
> -
> -	if (cmdlist)
> -		cmdlist = cmdlist->next;
> -	else
> -		cmdlist = tep->cmdlist;
> -
> -	while (cmdlist && strcmp(cmdlist->comm, comm) != 0)
> -		cmdlist = cmdlist->next;
> -
> -	return (struct tep_cmdline *)cmdlist;
> -}
> -
> -/**
> - * tep_data_pid_from_comm - return the pid from a given comm
> - * @tep: a handle to the trace event parser context
> - * @comm: the cmdline to find the pid from
> - * @next: the cmdline structure to find the next comm
> - *
> - * This returns the cmdline structure that holds a pid for a given
> - * comm, or NULL if none found. As there may be more than one pid for
> - * a given comm, the result of this call can be passed back into
> - * a recurring call in the @next parameter, and then it will find the
> - * next pid.
> - * Also, it does a linear search, so it may be slow.
> - */
> -struct tep_cmdline *tep_data_pid_from_comm(struct tep_handle *tep, const char *comm,
> -					   struct tep_cmdline *next)
> -{
> -	struct tep_cmdline *cmdline;
> -
> -	/*
> -	 * If the cmdlines have not been converted yet, then use
> -	 * the list.
> -	 */
> -	if (!tep->cmdlines)
> -		return pid_from_cmdlist(tep, comm, next);
> -
> -	if (next) {
> -		/*
> -		 * The next pointer could have been still from
> -		 * a previous call before cmdlines were created
> -		 */
> -		if (next < tep->cmdlines ||
> -		    next >= tep->cmdlines + tep->cmdline_count)
> -			next = NULL;
> -		else
> -			cmdline  = next++;
> -	}
> -
> -	if (!next)
> -		cmdline = tep->cmdlines;
> -
> -	while (cmdline < tep->cmdlines + tep->cmdline_count) {
> -		if (strcmp(cmdline->comm, comm) == 0)
> -			return cmdline;
> -		cmdline++;
> -	}
> -	return NULL;
> -}
> -
> -/**
> - * tep_cmdline_pid - return the pid associated to a given cmdline
> - * @tep: a handle to the trace event parser context
> - * @cmdline: The cmdline structure to get the pid from
> - *
> - * Returns the pid for a give cmdline. If @cmdline is NULL, then
> - * -1 is returned.
> - */
> -int tep_cmdline_pid(struct tep_handle *tep, struct tep_cmdline *cmdline)
> -{
> -	struct cmdline_list *cmdlist = (struct cmdline_list *)cmdline;
> -
> -	if (!cmdline)
> -		return -1;
> -
> -	/*
> -	 * If cmdlines have not been created yet, or cmdline is
> -	 * not part of the array, then treat it as a cmdlist instead.
> -	 */
> -	if (!tep->cmdlines ||
> -	    cmdline < tep->cmdlines ||
> -	    cmdline >= tep->cmdlines + tep->cmdline_count)
> -		return cmdlist->pid;
> -
> -	return cmdline->pid;
> -}
> -
> -/*
> - * This parses the raw @data using the given @event information and
> - * writes the print format into the trace_seq.
> - */
> -static void print_event_info(struct trace_seq *s, char *format, bool raw,
> -			     struct tep_event *event, struct tep_record *record)
> -{
> -	int print_pretty = 1;
> -
> -	if (raw || (event->flags & TEP_EVENT_FL_PRINTRAW))
> -		tep_print_fields(s, record->data, record->size, event);
> -	else {
> -
> -		if (event->handler && !(event->flags & TEP_EVENT_FL_NOHANDLE))
> -			print_pretty = event->handler(s, record, event,
> -						      event->context);
> -
> -		if (print_pretty)
> -			pretty_print(s, record->data, record->size, event);
> -	}
> -
> -	trace_seq_terminate(s);
> -}
> -
> -/**
> - * tep_find_event_by_record - return the event from a given record
> - * @tep: a handle to the trace event parser context
> - * @record: The record to get the event from
> - *
> - * Returns the associated event for a given record, or NULL if non is
> - * is found.
> - */
> -struct tep_event *
> -tep_find_event_by_record(struct tep_handle *tep, struct tep_record *record)
> -{
> -	int type;
> -
> -	if (record->size < 0) {
> -		do_warning("ug! negative record size %d", record->size);
> -		return NULL;
> -	}
> -
> -	type = trace_parse_common_type(tep, record->data);
> -
> -	return tep_find_event(tep, type);
> -}
> -
> -/*
> - * Writes the timestamp of the record into @s. Time divisor and precision can be
> - * specified as part of printf @format string. Example:
> - *	"%3.1000d" - divide the time by 1000 and print the first 3 digits
> - *	before the dot. Thus, the timestamp "123456000" will be printed as
> - *	"123.456"
> - */
> -static void print_event_time(struct tep_handle *tep, struct trace_seq *s,
> -				 char *format, struct tep_event *event,
> -				 struct tep_record *record)
> -{
> -	unsigned long long time;
> -	char *divstr;
> -	int prec = 0, pr;
> -	int div = 0;
> -	int p10 = 1;
> -
> -	if (isdigit(*(format + 1)))
> -		prec = atoi(format + 1);
> -	divstr = strchr(format, '.');
> -	if (divstr && isdigit(*(divstr + 1)))
> -		div = atoi(divstr + 1);
> -	time = record->ts;
> -	if (div) {
> -		time += div / 2;
> -		time /= div;
> -	}
> -	pr = prec;
> -	while (pr--)
> -		p10 *= 10;
> -
> -	if (p10 > 1 && p10 < time)
> -		trace_seq_printf(s, "%5llu.%0*llu", time / p10, prec, time % p10);
> -	else
> -		trace_seq_printf(s, "%12llu", time);
> -}
> -
> -struct print_event_type {
> -	enum {
> -		EVENT_TYPE_INT = 1,
> -		EVENT_TYPE_STRING,
> -		EVENT_TYPE_UNKNOWN,
> -	} type;
> -	char format[32];
> -};
> -
> -static void print_string(struct tep_handle *tep, struct trace_seq *s,
> -			 struct tep_record *record, struct tep_event *event,
> -			 const char *arg, struct print_event_type *type)
> -{
> -	const char *comm;
> -	int pid;
> -
> -	if (strncmp(arg, TEP_PRINT_LATENCY, strlen(TEP_PRINT_LATENCY)) == 0) {
> -		data_latency_format(tep, s, type->format, record);
> -	} else if (strncmp(arg, TEP_PRINT_COMM, strlen(TEP_PRINT_COMM)) == 0) {
> -		pid = parse_common_pid(tep, record->data);
> -		comm = find_cmdline(tep, pid);
> -		trace_seq_printf(s, type->format, comm);
> -	} else if (strncmp(arg, TEP_PRINT_INFO_RAW, strlen(TEP_PRINT_INFO_RAW)) == 0) {
> -		print_event_info(s, type->format, true, event, record);
> -	} else if (strncmp(arg, TEP_PRINT_INFO, strlen(TEP_PRINT_INFO)) == 0) {
> -		print_event_info(s, type->format, false, event, record);
> -	} else if  (strncmp(arg, TEP_PRINT_NAME, strlen(TEP_PRINT_NAME)) == 0) {
> -		trace_seq_printf(s, type->format, event->name);
> -	} else {
> -		trace_seq_printf(s, "[UNKNOWN TEP TYPE %s]", arg);
> -	}
> -
> -}
> -
> -static void print_int(struct tep_handle *tep, struct trace_seq *s,
> -		      struct tep_record *record, struct tep_event *event,
> -		      int arg, struct print_event_type *type)
> -{
> -	int param;
> -
> -	switch (arg) {
> -	case TEP_PRINT_CPU:
> -		param = record->cpu;
> -		break;
> -	case TEP_PRINT_PID:
> -		param = parse_common_pid(tep, record->data);
> -		break;
> -	case TEP_PRINT_TIME:
> -		return print_event_time(tep, s, type->format, event, record);
> -	default:
> -		return;
> -	}
> -	trace_seq_printf(s, type->format, param);
> -}
> -
> -static int tep_print_event_param_type(char *format,
> -				      struct print_event_type *type)
> -{
> -	char *str = format + 1;
> -	int i = 1;
> -
> -	type->type = EVENT_TYPE_UNKNOWN;
> -	while (*str) {
> -		switch (*str) {
> -		case 'd':
> -		case 'u':
> -		case 'i':
> -		case 'x':
> -		case 'X':
> -		case 'o':
> -			type->type = EVENT_TYPE_INT;
> -			break;
> -		case 's':
> -			type->type = EVENT_TYPE_STRING;
> -			break;
> -		}
> -		str++;
> -		i++;
> -		if (type->type != EVENT_TYPE_UNKNOWN)
> -			break;
> -	}
> -	memset(type->format, 0, 32);
> -	memcpy(type->format, format, i < 32 ? i : 31);
> -	return i;
> -}
> -
> -/**
> - * tep_print_event - Write various event information
> - * @tep: a handle to the trace event parser context
> - * @s: the trace_seq to write to
> - * @record: The record to get the event from
> - * @format: a printf format string. Supported event fileds:
> - *	TEP_PRINT_PID, "%d" - event PID
> - *	TEP_PRINT_CPU, "%d" - event CPU
> - *	TEP_PRINT_COMM, "%s" - event command string
> - *	TEP_PRINT_NAME, "%s" - event name
> - *	TEP_PRINT_LATENCY, "%s" - event latency
> - *	TEP_PRINT_TIME, %d - event time stamp. A divisor and precision
> - *			can be specified as part of this format string:
> - *			"%precision.divisord". Example:
> - *			"%3.1000d" - divide the time by 1000 and print the first
> - *			3 digits before the dot. Thus, the time stamp
> - *			"123456000" will be printed as "123.456"
> - *	TEP_PRINT_INFO, "%s" - event information. If any width is specified in
> - *			the format string, the event information will be printed
> - *			in raw format.
> - * Writes the specified event information into @s.
> - */
> -void tep_print_event(struct tep_handle *tep, struct trace_seq *s,
> -		     struct tep_record *record, const char *fmt, ...)
> -{
> -	struct print_event_type type;
> -	char *format = strdup(fmt);
> -	char *current = format;
> -	char *str = format;
> -	int offset;
> -	va_list args;
> -	struct tep_event *event;
> -
> -	if (!format)
> -		return;
> -
> -	event = tep_find_event_by_record(tep, record);
> -	va_start(args, fmt);
> -	while (*current) {
> -		current = strchr(str, '%');
> -		if (!current) {
> -			trace_seq_puts(s, str);
> -			break;
> -		}
> -		memset(&type, 0, sizeof(type));
> -		offset = tep_print_event_param_type(current, &type);
> -		*current = '\0';
> -		trace_seq_puts(s, str);
> -		current += offset;
> -		switch (type.type) {
> -		case EVENT_TYPE_STRING:
> -			print_string(tep, s, record, event,
> -				     va_arg(args, char*), &type);
> -			break;
> -		case EVENT_TYPE_INT:
> -			print_int(tep, s, record, event,
> -				  va_arg(args, int), &type);
> -			break;
> -		case EVENT_TYPE_UNKNOWN:
> -		default:
> -			trace_seq_printf(s, "[UNKNOWN TYPE]");
> -			break;
> -		}
> -		str = current;
> -
> -	}
> -	va_end(args);
> -	free(format);
> -}
> -
> -static int events_id_cmp(const void *a, const void *b)
> -{
> -	struct tep_event * const * ea = a;
> -	struct tep_event * const * eb = b;
> -
> -	if ((*ea)->id < (*eb)->id)
> -		return -1;
> -
> -	if ((*ea)->id > (*eb)->id)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static int events_name_cmp(const void *a, const void *b)
> -{
> -	struct tep_event * const * ea = a;
> -	struct tep_event * const * eb = b;
> -	int res;
> -
> -	res = strcmp((*ea)->name, (*eb)->name);
> -	if (res)
> -		return res;
> -
> -	res = strcmp((*ea)->system, (*eb)->system);
> -	if (res)
> -		return res;
> -
> -	return events_id_cmp(a, b);
> -}
> -
> -static int events_system_cmp(const void *a, const void *b)
> -{
> -	struct tep_event * const * ea = a;
> -	struct tep_event * const * eb = b;
> -	int res;
> -
> -	res = strcmp((*ea)->system, (*eb)->system);
> -	if (res)
> -		return res;
> -
> -	res = strcmp((*ea)->name, (*eb)->name);
> -	if (res)
> -		return res;
> -
> -	return events_id_cmp(a, b);
> -}
> -
> -static struct tep_event **list_events_copy(struct tep_handle *tep)
> -{
> -	struct tep_event **events;
> -
> -	if (!tep)
> -		return NULL;
> -
> -	events = malloc(sizeof(*events) * (tep->nr_events + 1));
> -	if (!events)
> -		return NULL;
> -
> -	memcpy(events, tep->events, sizeof(*events) * tep->nr_events);
> -	events[tep->nr_events] = NULL;
> -	return events;
> -}
> -
> -static void list_events_sort(struct tep_event **events, int nr_events,
> -			     enum tep_event_sort_type sort_type)
> -{
> -	int (*sort)(const void *a, const void *b);
> -
> -	switch (sort_type) {
> -	case TEP_EVENT_SORT_ID:
> -		sort = events_id_cmp;
> -		break;
> -	case TEP_EVENT_SORT_NAME:
> -		sort = events_name_cmp;
> -		break;
> -	case TEP_EVENT_SORT_SYSTEM:
> -		sort = events_system_cmp;
> -		break;
> -	default:
> -		sort = NULL;
> -	}
> -
> -	if (sort)
> -		qsort(events, nr_events, sizeof(*events), sort);
> -}
> -
> -/**
> - * tep_list_events - Get events, sorted by given criteria.
> - * @tep: a handle to the tep context
> - * @sort_type: desired sort order of the events in the array
> - *
> - * Returns an array of pointers to all events, sorted by the given
> - * @sort_type criteria. The last element of the array is NULL. The returned
> - * memory must not be freed, it is managed by the library.
> - * The function is not thread safe.
> - */
> -struct tep_event **tep_list_events(struct tep_handle *tep,
> -				   enum tep_event_sort_type sort_type)
> -{
> -	struct tep_event **events;
> -
> -	if (!tep)
> -		return NULL;
> -
> -	events = tep->sort_events;
> -	if (events && tep->last_type == sort_type)
> -		return events;
> -
> -	if (!events) {
> -		events = list_events_copy(tep);
> -		if (!events)
> -			return NULL;
> -
> -		tep->sort_events = events;
> -
> -		/* the internal events are sorted by id */
> -		if (sort_type == TEP_EVENT_SORT_ID) {
> -			tep->last_type = sort_type;
> -			return events;
> -		}
> -	}
> -
> -	list_events_sort(events, tep->nr_events, sort_type);
> -	tep->last_type = sort_type;
> -
> -	return events;
> -}
> -
> -
> -/**
> - * tep_list_events_copy - Thread safe version of tep_list_events()
> - * @tep: a handle to the tep context
> - * @sort_type: desired sort order of the events in the array
> - *
> - * Returns an array of pointers to all events, sorted by the given
> - * @sort_type criteria. The last element of the array is NULL. The returned
> - * array is newly allocated inside the function and must be freed by the caller
> - */
> -struct tep_event **tep_list_events_copy(struct tep_handle *tep,
> -					enum tep_event_sort_type sort_type)
> -{
> -	struct tep_event **events;
> -
> -	if (!tep)
> -		return NULL;
> -
> -	events = list_events_copy(tep);
> -	if (!events)
> -		return NULL;
> -
> -	/* the internal events are sorted by id */
> -	if (sort_type == TEP_EVENT_SORT_ID)
> -		return events;
> -
> -	list_events_sort(events, tep->nr_events, sort_type);
> -
> -	return events;
> -}
> -
> -static struct tep_format_field **
> -get_event_fields(const char *type, const char *name,
> -		 int count, struct tep_format_field *list)
> -{
> -	struct tep_format_field **fields;
> -	struct tep_format_field *field;
> -	int i = 0;
> -
> -	fields = malloc(sizeof(*fields) * (count + 1));
> -	if (!fields)
> -		return NULL;
> -
> -	for (field = list; field; field = field->next) {
> -		fields[i++] = field;
> -		if (i == count + 1) {
> -			do_warning("event %s has more %s fields than specified",
> -				name, type);
> -			i--;
> -			break;
> -		}
> -	}
> -
> -	if (i != count)
> -		do_warning("event %s has less %s fields than specified",
> -			name, type);
> -
> -	fields[i] = NULL;
> -
> -	return fields;
> -}
> -
> -/**
> - * tep_event_common_fields - return a list of common fields for an event
> - * @event: the event to return the common fields of.
> - *
> - * Returns an allocated array of fields. The last item in the array is NULL.
> - * The array must be freed with free().
> - */
> -struct tep_format_field **tep_event_common_fields(struct tep_event *event)
> -{
> -	return get_event_fields("common", event->name,
> -				event->format.nr_common,
> -				event->format.common_fields);
> -}
> -
> -/**
> - * tep_event_fields - return a list of event specific fields for an event
> - * @event: the event to return the fields of.
> - *
> - * Returns an allocated array of fields. The last item in the array is NULL.
> - * The array must be freed with free().
> - */
> -struct tep_format_field **tep_event_fields(struct tep_event *event)
> -{
> -	return get_event_fields("event", event->name,
> -				event->format.nr_fields,
> -				event->format.fields);
> -}
> -
> -static void print_fields(struct trace_seq *s, struct tep_print_flag_sym *field)
> -{
> -	trace_seq_printf(s, "{ %s, %s }", field->value, field->str);
> -	if (field->next) {
> -		trace_seq_puts(s, ", ");
> -		print_fields(s, field->next);
> -	}
> -}
> -
> -/* for debugging */
> -static void print_args(struct tep_print_arg *args)
> -{
> -	int print_paren = 1;
> -	struct trace_seq s;
> -
> -	switch (args->type) {
> -	case TEP_PRINT_NULL:
> -		printf("null");
> -		break;
> -	case TEP_PRINT_ATOM:
> -		printf("%s", args->atom.atom);
> -		break;
> -	case TEP_PRINT_FIELD:
> -		printf("REC->%s", args->field.name);
> -		break;
> -	case TEP_PRINT_FLAGS:
> -		printf("__print_flags(");
> -		print_args(args->flags.field);
> -		printf(", %s, ", args->flags.delim);
> -		trace_seq_init(&s);
> -		print_fields(&s, args->flags.flags);
> -		trace_seq_do_printf(&s);
> -		trace_seq_destroy(&s);
> -		printf(")");
> -		break;
> -	case TEP_PRINT_SYMBOL:
> -		printf("__print_symbolic(");
> -		print_args(args->symbol.field);
> -		printf(", ");
> -		trace_seq_init(&s);
> -		print_fields(&s, args->symbol.symbols);
> -		trace_seq_do_printf(&s);
> -		trace_seq_destroy(&s);
> -		printf(")");
> -		break;
> -	case TEP_PRINT_HEX:
> -		printf("__print_hex(");
> -		print_args(args->hex.field);
> -		printf(", ");
> -		print_args(args->hex.size);
> -		printf(")");
> -		break;
> -	case TEP_PRINT_HEX_STR:
> -		printf("__print_hex_str(");
> -		print_args(args->hex.field);
> -		printf(", ");
> -		print_args(args->hex.size);
> -		printf(")");
> -		break;
> -	case TEP_PRINT_INT_ARRAY:
> -		printf("__print_array(");
> -		print_args(args->int_array.field);
> -		printf(", ");
> -		print_args(args->int_array.count);
> -		printf(", ");
> -		print_args(args->int_array.el_size);
> -		printf(")");
> -		break;
> -	case TEP_PRINT_STRING:
> -	case TEP_PRINT_BSTRING:
> -		printf("__get_str(%s)", args->string.string);
> -		break;
> -	case TEP_PRINT_BITMASK:
> -		printf("__get_bitmask(%s)", args->bitmask.bitmask);
> -		break;
> -	case TEP_PRINT_TYPE:
> -		printf("(%s)", args->typecast.type);
> -		print_args(args->typecast.item);
> -		break;
> -	case TEP_PRINT_OP:
> -		if (strcmp(args->op.op, ":") == 0)
> -			print_paren = 0;
> -		if (print_paren)
> -			printf("(");
> -		print_args(args->op.left);
> -		printf(" %s ", args->op.op);
> -		print_args(args->op.right);
> -		if (print_paren)
> -			printf(")");
> -		break;
> -	default:
> -		/* we should warn... */
> -		return;
> -	}
> -	if (args->next) {
> -		printf("\n");
> -		print_args(args->next);
> -	}
> -}
> -
> -static void parse_header_field(const char *field,
> -			       int *offset, int *size, int mandatory)
> -{
> -	unsigned long long save_input_buf_ptr;
> -	unsigned long long save_input_buf_siz;
> -	char *token;
> -	int type;
> -
> -	save_input_buf_ptr = input_buf_ptr;
> -	save_input_buf_siz = input_buf_siz;
> -
> -	if (read_expected(TEP_EVENT_ITEM, "field") < 0)
> -		return;
> -	if (read_expected(TEP_EVENT_OP, ":") < 0)
> -		return;
> -
> -	/* type */
> -	if (read_expect_type(TEP_EVENT_ITEM, &token) < 0)
> -		goto fail;
> -	free_token(token);
> -
> -	/*
> -	 * If this is not a mandatory field, then test it first.
> -	 */
> -	if (mandatory) {
> -		if (read_expected(TEP_EVENT_ITEM, field) < 0)
> -			return;
> -	} else {
> -		if (read_expect_type(TEP_EVENT_ITEM, &token) < 0)
> -			goto fail;
> -		if (strcmp(token, field) != 0)
> -			goto discard;
> -		free_token(token);
> -	}
> -
> -	if (read_expected(TEP_EVENT_OP, ";") < 0)
> -		return;
> -	if (read_expected(TEP_EVENT_ITEM, "offset") < 0)
> -		return;
> -	if (read_expected(TEP_EVENT_OP, ":") < 0)
> -		return;
> -	if (read_expect_type(TEP_EVENT_ITEM, &token) < 0)
> -		goto fail;
> -	*offset = atoi(token);
> -	free_token(token);
> -	if (read_expected(TEP_EVENT_OP, ";") < 0)
> -		return;
> -	if (read_expected(TEP_EVENT_ITEM, "size") < 0)
> -		return;
> -	if (read_expected(TEP_EVENT_OP, ":") < 0)
> -		return;
> -	if (read_expect_type(TEP_EVENT_ITEM, &token) < 0)
> -		goto fail;
> -	*size = atoi(token);
> -	free_token(token);
> -	if (read_expected(TEP_EVENT_OP, ";") < 0)
> -		return;
> -	type = read_token(&token);
> -	if (type != TEP_EVENT_NEWLINE) {
> -		/* newer versions of the kernel have a "signed" type */
> -		if (type != TEP_EVENT_ITEM)
> -			goto fail;
> -
> -		if (strcmp(token, "signed") != 0)
> -			goto fail;
> -
> -		free_token(token);
> -
> -		if (read_expected(TEP_EVENT_OP, ":") < 0)
> -			return;
> -
> -		if (read_expect_type(TEP_EVENT_ITEM, &token))
> -			goto fail;
> -
> -		free_token(token);
> -		if (read_expected(TEP_EVENT_OP, ";") < 0)
> -			return;
> -
> -		if (read_expect_type(TEP_EVENT_NEWLINE, &token))
> -			goto fail;
> -	}
> - fail:
> -	free_token(token);
> -	return;
> -
> - discard:
> -	input_buf_ptr = save_input_buf_ptr;
> -	input_buf_siz = save_input_buf_siz;
> -	*offset = 0;
> -	*size = 0;
> -	free_token(token);
> -}
> -
> -/**
> - * tep_parse_header_page - parse the data stored in the header page
> - * @tep: a handle to the trace event parser context
> - * @buf: the buffer storing the header page format string
> - * @size: the size of @buf
> - * @long_size: the long size to use if there is no header
> - *
> - * This parses the header page format for information on the
> - * ring buffer used. The @buf should be copied from
> - *
> - * /sys/kernel/debug/tracing/events/header_page
> - */
> -int tep_parse_header_page(struct tep_handle *tep, char *buf, unsigned long size,
> -			  int long_size)
> -{
> -	int ignore;
> -
> -	if (!size) {
> -		/*
> -		 * Old kernels did not have header page info.
> -		 * Sorry but we just use what we find here in user space.
> -		 */
> -		tep->header_page_ts_size = sizeof(long long);
> -		tep->header_page_size_size = long_size;
> -		tep->header_page_data_offset = sizeof(long long) + long_size;
> -		tep->old_format = 1;
> -		return -1;
> -	}
> -	init_input_buf(buf, size);
> -
> -	parse_header_field("timestamp", &tep->header_page_ts_offset,
> -			   &tep->header_page_ts_size, 1);
> -	parse_header_field("commit", &tep->header_page_size_offset,
> -			   &tep->header_page_size_size, 1);
> -	parse_header_field("overwrite", &tep->header_page_overwrite,
> -			   &ignore, 0);
> -	parse_header_field("data", &tep->header_page_data_offset,
> -			   &tep->header_page_data_size, 1);
> -
> -	return 0;
> -}
> -
> -static int event_matches(struct tep_event *event,
> -			 int id, const char *sys_name,
> -			 const char *event_name)
> -{
> -	if (id >= 0 && id != event->id)
> -		return 0;
> -
> -	if (event_name && (strcmp(event_name, event->name) != 0))
> -		return 0;
> -
> -	if (sys_name && (strcmp(sys_name, event->system) != 0))
> -		return 0;
> -
> -	return 1;
> -}
> -
> -static void free_handler(struct event_handler *handle)
> -{
> -	free((void *)handle->sys_name);
> -	free((void *)handle->event_name);
> -	free(handle);
> -}
> -
> -static int find_event_handle(struct tep_handle *tep, struct tep_event *event)
> -{
> -	struct event_handler *handle, **next;
> -
> -	for (next = &tep->handlers; *next;
> -	     next = &(*next)->next) {
> -		handle = *next;
> -		if (event_matches(event, handle->id,
> -				  handle->sys_name,
> -				  handle->event_name))
> -			break;
> -	}
> -
> -	if (!(*next))
> -		return 0;
> -
> -	pr_stat("overriding event (%d) %s:%s with new print handler",
> -		event->id, event->system, event->name);
> -
> -	event->handler = handle->func;
> -	event->context = handle->context;
> -
> -	*next = handle->next;
> -	free_handler(handle);
> -
> -	return 1;
> -}
> -
> -/**
> - * parse_format - parse the event format
> - * @buf: the buffer storing the event format string
> - * @size: the size of @buf
> - * @sys: the system the event belongs to
> - *
> - * This parses the event format and creates an event structure
> - * to quickly parse raw data for a given event.
> - *
> - * These files currently come from:
> - *
> - * /sys/kernel/debug/tracing/events/.../.../format
> - */
> -static enum tep_errno parse_format(struct tep_event **eventp,
> -				   struct tep_handle *tep, const char *buf,
> -				   unsigned long size, const char *sys)
> -{
> -	struct tep_event *event;
> -	int ret;
> -
> -	init_input_buf(buf, size);
> -
> -	*eventp = event = alloc_event();
> -	if (!event)
> -		return TEP_ERRNO__MEM_ALLOC_FAILED;
> -
> -	event->name = event_read_name();
> -	if (!event->name) {
> -		/* Bad event? */
> -		ret = TEP_ERRNO__MEM_ALLOC_FAILED;
> -		goto event_alloc_failed;
> -	}
> -
> -	if (strcmp(sys, "ftrace") == 0) {
> -		event->flags |= TEP_EVENT_FL_ISFTRACE;
> -
> -		if (strcmp(event->name, "bprint") == 0)
> -			event->flags |= TEP_EVENT_FL_ISBPRINT;
> -	}
> -		
> -	event->id = event_read_id();
> -	if (event->id < 0) {
> -		ret = TEP_ERRNO__READ_ID_FAILED;
> -		/*
> -		 * This isn't an allocation error actually.
> -		 * But as the ID is critical, just bail out.
> -		 */
> -		goto event_alloc_failed;
> -	}
> -
> -	event->system = strdup(sys);
> -	if (!event->system) {
> -		ret = TEP_ERRNO__MEM_ALLOC_FAILED;
> -		goto event_alloc_failed;
> -	}
> -
> -	/* Add tep to event so that it can be referenced */
> -	event->tep = tep;
> -
> -	ret = event_read_format(event);
> -	if (ret < 0) {
> -		ret = TEP_ERRNO__READ_FORMAT_FAILED;
> -		goto event_parse_failed;
> -	}
> -
> -	/*
> -	 * If the event has an override, don't print warnings if the event
> -	 * print format fails to parse.
> -	 */
> -	if (tep && find_event_handle(tep, event))
> -		show_warning = 0;
> -
> -	ret = event_read_print(event);
> -	show_warning = 1;
> -
> -	if (ret < 0) {
> -		ret = TEP_ERRNO__READ_PRINT_FAILED;
> -		goto event_parse_failed;
> -	}
> -
> -	if (!ret && (event->flags & TEP_EVENT_FL_ISFTRACE)) {
> -		struct tep_format_field *field;
> -		struct tep_print_arg *arg, **list;
> -
> -		/* old ftrace had no args */
> -		list = &event->print_fmt.args;
> -		for (field = event->format.fields; field; field = field->next) {
> -			arg = alloc_arg();
> -			if (!arg) {
> -				event->flags |= TEP_EVENT_FL_FAILED;
> -				return TEP_ERRNO__OLD_FTRACE_ARG_FAILED;
> -			}
> -			arg->type = TEP_PRINT_FIELD;
> -			arg->field.name = strdup(field->name);
> -			if (!arg->field.name) {
> -				event->flags |= TEP_EVENT_FL_FAILED;
> -				free_arg(arg);
> -				return TEP_ERRNO__OLD_FTRACE_ARG_FAILED;
> -			}
> -			arg->field.field = field;
> -			*list = arg;
> -			list = &arg->next;
> -		}
> -	}
> -
> -	if (!(event->flags & TEP_EVENT_FL_ISBPRINT))
> -		event->print_fmt.print_cache = parse_args(event,
> -							  event->print_fmt.format,
> -							  event->print_fmt.args);
> -
> -	return 0;
> -
> - event_parse_failed:
> -	event->flags |= TEP_EVENT_FL_FAILED;
> -	return ret;
> -
> - event_alloc_failed:
> -	free(event->system);
> -	free(event->name);
> -	free(event);
> -	*eventp = NULL;
> -	return ret;
> -}
> -
> -static enum tep_errno
> -__parse_event(struct tep_handle *tep,
> -	      struct tep_event **eventp,
> -	      const char *buf, unsigned long size,
> -	      const char *sys)
> -{
> -	int ret = parse_format(eventp, tep, buf, size, sys);
> -	struct tep_event *event = *eventp;
> -
> -	if (event == NULL)
> -		return ret;
> -
> -	if (tep && add_event(tep, event)) {
> -		ret = TEP_ERRNO__MEM_ALLOC_FAILED;
> -		goto event_add_failed;
> -	}
> -
> -#define PRINT_ARGS 0
> -	if (PRINT_ARGS && event->print_fmt.args)
> -		print_args(event->print_fmt.args);
> -
> -	return 0;
> -
> -event_add_failed:
> -	free_tep_event(event);
> -	return ret;
> -}
> -
> -/**
> - * tep_parse_format - parse the event format
> - * @tep: a handle to the trace event parser context
> - * @eventp: returned format
> - * @buf: the buffer storing the event format string
> - * @size: the size of @buf
> - * @sys: the system the event belongs to
> - *
> - * This parses the event format and creates an event structure
> - * to quickly parse raw data for a given event.
> - *
> - * These files currently come from:
> - *
> - * /sys/kernel/debug/tracing/events/.../.../format
> - */
> -enum tep_errno tep_parse_format(struct tep_handle *tep,
> -				struct tep_event **eventp,
> -				const char *buf,
> -				unsigned long size, const char *sys)
> -{
> -	return __parse_event(tep, eventp, buf, size, sys);
> -}
> -
> -/**
> - * tep_parse_event - parse the event format
> - * @tep: a handle to the trace event parser context
> - * @buf: the buffer storing the event format string
> - * @size: the size of @buf
> - * @sys: the system the event belongs to
> - *
> - * This parses the event format and creates an event structure
> - * to quickly parse raw data for a given event.
> - *
> - * These files currently come from:
> - *
> - * /sys/kernel/debug/tracing/events/.../.../format
> - */
> -enum tep_errno tep_parse_event(struct tep_handle *tep, const char *buf,
> -			       unsigned long size, const char *sys)
> -{
> -	struct tep_event *event = NULL;
> -	return __parse_event(tep, &event, buf, size, sys);
> -}
> -
> -int get_field_val(struct trace_seq *s, struct tep_format_field *field,
> -		  const char *name, struct tep_record *record,
> -		  unsigned long long *val, int err)
> -{
> -	if (!field) {
> -		if (err)
> -			trace_seq_printf(s, "<CANT FIND FIELD %s>", name);
> -		return -1;
> -	}
> -
> -	if (tep_read_number_field(field, record->data, val)) {
> -		if (err)
> -			trace_seq_printf(s, " %s=INVALID", name);
> -		return -1;
> -	}
> -
> -	return 0;
> -}
> -
> -/**
> - * tep_get_field_raw - return the raw pointer into the data field
> - * @s: The seq to print to on error
> - * @event: the event that the field is for
> - * @name: The name of the field
> - * @record: The record with the field name.
> - * @len: place to store the field length.
> - * @err: print default error if failed.
> - *
> - * Returns a pointer into record->data of the field and places
> - * the length of the field in @len.
> - *
> - * On failure, it returns NULL.
> - */
> -void *tep_get_field_raw(struct trace_seq *s, struct tep_event *event,
> -			const char *name, struct tep_record *record,
> -			int *len, int err)
> -{
> -	struct tep_format_field *field;
> -	void *data = record->data;
> -	unsigned offset;
> -	int dummy;
> -
> -	if (!event)
> -		return NULL;
> -
> -	field = tep_find_field(event, name);
> -
> -	if (!field) {
> -		if (err)
> -			trace_seq_printf(s, "<CANT FIND FIELD %s>", name);
> -		return NULL;
> -	}
> -
> -	/* Allow @len to be NULL */
> -	if (!len)
> -		len = &dummy;
> -
> -	offset = field->offset;
> -	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
> -		offset = tep_read_number(event->tep,
> -					 data + offset, field->size);
> -		*len = offset >> 16;
> -		offset &= 0xffff;
> -		if (field->flags & TEP_FIELD_IS_RELATIVE)
> -			offset += field->offset + field->size;
> -	} else
> -		*len = field->size;
> -
> -	return data + offset;
> -}
> -
> -/**
> - * tep_get_field_val - find a field and return its value
> - * @s: The seq to print to on error
> - * @event: the event that the field is for
> - * @name: The name of the field
> - * @record: The record with the field name.
> - * @val: place to store the value of the field.
> - * @err: print default error if failed.
> - *
> - * Returns 0 on success -1 on field not found.
> - */
> -int tep_get_field_val(struct trace_seq *s, struct tep_event *event,
> -		      const char *name, struct tep_record *record,
> -		      unsigned long long *val, int err)
> -{
> -	struct tep_format_field *field;
> -
> -	if (!event)
> -		return -1;
> -
> -	field = tep_find_field(event, name);
> -
> -	return get_field_val(s, field, name, record, val, err);
> -}
> -
> -/**
> - * tep_get_common_field_val - find a common field and return its value
> - * @s: The seq to print to on error
> - * @event: the event that the field is for
> - * @name: The name of the field
> - * @record: The record with the field name.
> - * @val: place to store the value of the field.
> - * @err: print default error if failed.
> - *
> - * Returns 0 on success -1 on field not found.
> - */
> -int tep_get_common_field_val(struct trace_seq *s, struct tep_event *event,
> -			     const char *name, struct tep_record *record,
> -			     unsigned long long *val, int err)
> -{
> -	struct tep_format_field *field;
> -
> -	if (!event)
> -		return -1;
> -
> -	field = tep_find_common_field(event, name);
> -
> -	return get_field_val(s, field, name, record, val, err);
> -}
> -
> -/**
> - * tep_get_any_field_val - find a any field and return its value
> - * @s: The seq to print to on error
> - * @event: the event that the field is for
> - * @name: The name of the field
> - * @record: The record with the field name.
> - * @val: place to store the value of the field.
> - * @err: print default error if failed.
> - *
> - * Returns 0 on success -1 on field not found.
> - */
> -int tep_get_any_field_val(struct trace_seq *s, struct tep_event *event,
> -			  const char *name, struct tep_record *record,
> -			  unsigned long long *val, int err)
> -{
> -	struct tep_format_field *field;
> -
> -	if (!event)
> -		return -1;
> -
> -	field = tep_find_any_field(event, name);
> -
> -	return get_field_val(s, field, name, record, val, err);
> -}
> -
> -/**
> - * tep_print_num_field - print a field and a format
> - * @s: The seq to print to
> - * @fmt: The printf format to print the field with.
> - * @event: the event that the field is for
> - * @name: The name of the field
> - * @record: The record with the field name.
> - * @err: print default error if failed.
> - *
> - * Returns positive value on success, negative in case of an error,
> - * or 0 if buffer is full.
> - */
> -int tep_print_num_field(struct trace_seq *s, const char *fmt,
> -			struct tep_event *event, const char *name,
> -			struct tep_record *record, int err)
> -{
> -	struct tep_format_field *field = tep_find_field(event, name);
> -	unsigned long long val;
> -
> -	if (!field)
> -		goto failed;
> -
> -	if (tep_read_number_field(field, record->data, &val))
> -		goto failed;
> -
> -	return trace_seq_printf(s, fmt, val);
> -
> - failed:
> -	if (err)
> -		trace_seq_printf(s, "CAN'T FIND FIELD \"%s\"", name);
> -	return -1;
> -}
> -
> -/**
> - * tep_print_func_field - print a field and a format for function pointers
> - * @s: The seq to print to
> - * @fmt: The printf format to print the field with.
> - * @event: the event that the field is for
> - * @name: The name of the field
> - * @record: The record with the field name.
> - * @err: print default error if failed.
> - *
> - * Returns positive value on success, negative in case of an error,
> - * or 0 if buffer is full.
> - */
> -int tep_print_func_field(struct trace_seq *s, const char *fmt,
> -			 struct tep_event *event, const char *name,
> -			 struct tep_record *record, int err)
> -{
> -	struct tep_format_field *field = tep_find_field(event, name);
> -	struct tep_handle *tep = event->tep;
> -	unsigned long long val;
> -	struct func_map *func;
> -	char tmp[128];
> -
> -	if (!field)
> -		goto failed;
> -
> -	if (tep_read_number_field(field, record->data, &val))
> -		goto failed;
> -
> -	func = find_func(tep, val);
> -
> -	if (func)
> -		snprintf(tmp, 128, "%s/0x%llx", func->func, func->addr - val);
> -	else
> -		sprintf(tmp, "0x%08llx", val);
> -
> -	return trace_seq_printf(s, fmt, tmp);
> -
> - failed:
> -	if (err)
> -		trace_seq_printf(s, "CAN'T FIND FIELD \"%s\"", name);
> -	return -1;
> -}
> -
> -static void free_func_handle(struct tep_function_handler *func)
> -{
> -	struct func_params *params;
> -
> -	free(func->name);
> -
> -	while (func->params) {
> -		params = func->params;
> -		func->params = params->next;
> -		free(params);
> -	}
> -
> -	free(func);
> -}
> -
> -/**
> - * tep_register_print_function - register a helper function
> - * @tep: a handle to the trace event parser context
> - * @func: the function to process the helper function
> - * @ret_type: the return type of the helper function
> - * @name: the name of the helper function
> - * @parameters: A list of enum tep_func_arg_type
> - *
> - * Some events may have helper functions in the print format arguments.
> - * This allows a plugin to dynamically create a way to process one
> - * of these functions.
> - *
> - * The @parameters is a variable list of tep_func_arg_type enums that
> - * must end with TEP_FUNC_ARG_VOID.
> - */
> -int tep_register_print_function(struct tep_handle *tep,
> -				tep_func_handler func,
> -				enum tep_func_arg_type ret_type,
> -				char *name, ...)
> -{
> -	struct tep_function_handler *func_handle;
> -	struct func_params **next_param;
> -	struct func_params *param;
> -	enum tep_func_arg_type type;
> -	va_list ap;
> -	int ret;
> -
> -	func_handle = find_func_handler(tep, name);
> -	if (func_handle) {
> -		/*
> -		 * This is most like caused by the users own
> -		 * plugins updating the function. This overrides the
> -		 * system defaults.
> -		 */
> -		pr_stat("override of function helper '%s'", name);
> -		remove_func_handler(tep, name);
> -	}
> -
> -	func_handle = calloc(1, sizeof(*func_handle));
> -	if (!func_handle) {
> -		do_warning("Failed to allocate function handler");
> -		return TEP_ERRNO__MEM_ALLOC_FAILED;
> -	}
> -
> -	func_handle->ret_type = ret_type;
> -	func_handle->name = strdup(name);
> -	func_handle->func = func;
> -	if (!func_handle->name) {
> -		do_warning("Failed to allocate function name");
> -		free(func_handle);
> -		return TEP_ERRNO__MEM_ALLOC_FAILED;
> -	}
> -
> -	next_param = &(func_handle->params);
> -	va_start(ap, name);
> -	for (;;) {
> -		type = va_arg(ap, enum tep_func_arg_type);
> -		if (type == TEP_FUNC_ARG_VOID)
> -			break;
> -
> -		if (type >= TEP_FUNC_ARG_MAX_TYPES) {
> -			do_warning("Invalid argument type %d", type);
> -			ret = TEP_ERRNO__INVALID_ARG_TYPE;
> -			goto out_free;
> -		}
> -
> -		param = malloc(sizeof(*param));
> -		if (!param) {
> -			do_warning("Failed to allocate function param");
> -			ret = TEP_ERRNO__MEM_ALLOC_FAILED;
> -			goto out_free;
> -		}
> -		param->type = type;
> -		param->next = NULL;
> -
> -		*next_param = param;
> -		next_param = &(param->next);
> -
> -		func_handle->nr_args++;
> -	}
> -	va_end(ap);
> -
> -	func_handle->next = tep->func_handlers;
> -	tep->func_handlers = func_handle;
> -
> -	return 0;
> - out_free:
> -	va_end(ap);
> -	free_func_handle(func_handle);
> -	return ret;
> -}
> -
> -/**
> - * tep_unregister_print_function - unregister a helper function
> - * @tep: a handle to the trace event parser context
> - * @func: the function to process the helper function
> - * @name: the name of the helper function
> - *
> - * This function removes existing print handler for function @name.
> - *
> - * Returns 0 if the handler was removed successully, -1 otherwise.
> - */
> -int tep_unregister_print_function(struct tep_handle *tep,
> -				  tep_func_handler func, char *name)
> -{
> -	struct tep_function_handler *func_handle;
> -
> -	func_handle = find_func_handler(tep, name);
> -	if (func_handle && func_handle->func == func) {
> -		remove_func_handler(tep, name);
> -		return 0;
> -	}
> -	return -1;
> -}
> -
> -static struct tep_event *search_event(struct tep_handle *tep, int id,
> -				      const char *sys_name,
> -				      const char *event_name)
> -{
> -	struct tep_event *event;
> -
> -	if (id >= 0) {
> -		/* search by id */
> -		event = tep_find_event(tep, id);
> -		if (!event)
> -			return NULL;
> -		if (event_name && (strcmp(event_name, event->name) != 0))
> -			return NULL;
> -		if (sys_name && (strcmp(sys_name, event->system) != 0))
> -			return NULL;
> -	} else {
> -		event = tep_find_event_by_name(tep, sys_name, event_name);
> -		if (!event)
> -			return NULL;
> -	}
> -	return event;
> -}
> -
> -/**
> - * tep_register_event_handler - register a way to parse an event
> - * @tep: a handle to the trace event parser context
> - * @id: the id of the event to register
> - * @sys_name: the system name the event belongs to
> - * @event_name: the name of the event
> - * @func: the function to call to parse the event information
> - * @context: the data to be passed to @func
> - *
> - * This function allows a developer to override the parsing of
> - * a given event. If for some reason the default print format
> - * is not sufficient, this function will register a function
> - * for an event to be used to parse the data instead.
> - *
> - * If @id is >= 0, then it is used to find the event.
> - * else @sys_name and @event_name are used.
> - *
> - * Returns:
> - *  TEP_REGISTER_SUCCESS_OVERWRITE if an existing handler is overwritten
> - *  TEP_REGISTER_SUCCESS if a new handler is registered successfully
> - *  negative TEP_ERRNO_... in case of an error
> - *
> - */
> -int tep_register_event_handler(struct tep_handle *tep, int id,
> -			       const char *sys_name, const char *event_name,
> -			       tep_event_handler_func func, void *context)
> -{
> -	struct tep_event *event;
> -	struct event_handler *handle;
> -
> -	event = search_event(tep, id, sys_name, event_name);
> -	if (event == NULL)
> -		goto not_found;
> -
> -	pr_stat("overriding event (%d) %s:%s with new print handler",
> -		event->id, event->system, event->name);
> -
> -	event->handler = func;
> -	event->context = context;
> -	return TEP_REGISTER_SUCCESS_OVERWRITE;
> -
> - not_found:
> -	/* Save for later use. */
> -	handle = calloc(1, sizeof(*handle));
> -	if (!handle) {
> -		do_warning("Failed to allocate event handler");
> -		return TEP_ERRNO__MEM_ALLOC_FAILED;
> -	}
> -
> -	handle->id = id;
> -	if (event_name)
> -		handle->event_name = strdup(event_name);
> -	if (sys_name)
> -		handle->sys_name = strdup(sys_name);
> -
> -	if ((event_name && !handle->event_name) ||
> -	    (sys_name && !handle->sys_name)) {
> -		do_warning("Failed to allocate event/sys name");
> -		free((void *)handle->event_name);
> -		free((void *)handle->sys_name);
> -		free(handle);
> -		return TEP_ERRNO__MEM_ALLOC_FAILED;
> -	}
> -
> -	handle->func = func;
> -	handle->next = tep->handlers;
> -	tep->handlers = handle;
> -	handle->context = context;
> -
> -	return TEP_REGISTER_SUCCESS;
> -}
> -
> -static int handle_matches(struct event_handler *handler, int id,
> -			  const char *sys_name, const char *event_name,
> -			  tep_event_handler_func func, void *context)
> -{
> -	if (id >= 0 && id != handler->id)
> -		return 0;
> -
> -	if (event_name && (strcmp(event_name, handler->event_name) != 0))
> -		return 0;
> -
> -	if (sys_name && (strcmp(sys_name, handler->sys_name) != 0))
> -		return 0;
> -
> -	if (func != handler->func || context != handler->context)
> -		return 0;
> -
> -	return 1;
> -}
> -
> -/**
> - * tep_unregister_event_handler - unregister an existing event handler
> - * @tep: a handle to the trace event parser context
> - * @id: the id of the event to unregister
> - * @sys_name: the system name the handler belongs to
> - * @event_name: the name of the event handler
> - * @func: the function to call to parse the event information
> - * @context: the data to be passed to @func
> - *
> - * This function removes existing event handler (parser).
> - *
> - * If @id is >= 0, then it is used to find the event.
> - * else @sys_name and @event_name are used.
> - *
> - * Returns 0 if handler was removed successfully, -1 if event was not found.
> - */
> -int tep_unregister_event_handler(struct tep_handle *tep, int id,
> -				 const char *sys_name, const char *event_name,
> -				 tep_event_handler_func func, void *context)
> -{
> -	struct tep_event *event;
> -	struct event_handler *handle;
> -	struct event_handler **next;
> -
> -	event = search_event(tep, id, sys_name, event_name);
> -	if (event == NULL)
> -		goto not_found;
> -
> -	if (event->handler == func && event->context == context) {
> -		pr_stat("removing override handler for event (%d) %s:%s. Going back to default handler.",
> -			event->id, event->system, event->name);
> -
> -		event->handler = NULL;
> -		event->context = NULL;
> -		return 0;
> -	}
> -
> -not_found:
> -	for (next = &tep->handlers; *next; next = &(*next)->next) {
> -		handle = *next;
> -		if (handle_matches(handle, id, sys_name, event_name,
> -				   func, context))
> -			break;
> -	}
> -
> -	if (!(*next))
> -		return -1;
> -
> -	*next = handle->next;
> -	free_handler(handle);
> -
> -	return 0;
> -}
> -
> -/**
> - * tep_alloc - create a tep handle
> - */
> -struct tep_handle *tep_alloc(void)
> -{
> -	struct tep_handle *tep = calloc(1, sizeof(*tep));
> -
> -	if (tep) {
> -		tep->ref_count = 1;
> -		tep->host_bigendian = tep_is_bigendian();
> -	}
> -
> -	return tep;
> -}
> -
> -void tep_ref(struct tep_handle *tep)
> -{
> -	tep->ref_count++;
> -}
> -
> -int tep_get_ref(struct tep_handle *tep)
> -{
> -	if (tep)
> -		return tep->ref_count;
> -	return 0;
> -}
> -
> -__hidden void free_tep_format_field(struct tep_format_field *field)
> -{
> -	free(field->type);
> -	if (field->alias != field->name)
> -		free(field->alias);
> -	free(field->name);
> -	free(field);
> -}
> -
> -static void free_format_fields(struct tep_format_field *field)
> -{
> -	struct tep_format_field *next;
> -
> -	while (field) {
> -		next = field->next;
> -		free_tep_format_field(field);
> -		field = next;
> -	}
> -}
> -
> -static void free_formats(struct tep_format *format)
> -{
> -	free_format_fields(format->common_fields);
> -	free_format_fields(format->fields);
> -}
> -
> -__hidden void free_tep_event(struct tep_event *event)
> -{
> -	free(event->name);
> -	free(event->system);
> -
> -	free_formats(&event->format);
> -
> -	free(event->print_fmt.format);
> -	free_args(event->print_fmt.args);
> -	free_parse_args(event->print_fmt.print_cache);
> -	free(event);
> -}
> -
> -/**
> - * tep_free - free a tep handle
> - * @tep: the tep handle to free
> - */
> -void tep_free(struct tep_handle *tep)
> -{
> -	struct cmdline_list *cmdlist, *cmdnext;
> -	struct func_list *funclist, *funcnext;
> -	struct printk_list *printklist, *printknext;
> -	struct tep_function_handler *func_handler;
> -	struct event_handler *handle;
> -	int i;
> -
> -	if (!tep)
> -		return;
> -
> -	cmdlist = tep->cmdlist;
> -	funclist = tep->funclist;
> -	printklist = tep->printklist;
> -
> -	tep->ref_count--;
> -	if (tep->ref_count)
> -		return;
> -
> -	if (tep->cmdlines) {
> -		for (i = 0; i < tep->cmdline_count; i++)
> -			free(tep->cmdlines[i].comm);
> -		free(tep->cmdlines);
> -	}
> -
> -	while (cmdlist) {
> -		cmdnext = cmdlist->next;
> -		free(cmdlist->comm);
> -		free(cmdlist);
> -		cmdlist = cmdnext;
> -	}
> -
> -	if (tep->func_map) {
> -		for (i = 0; i < (int)tep->func_count; i++) {
> -			free(tep->func_map[i].func);
> -			free(tep->func_map[i].mod);
> -		}
> -		free(tep->func_map);
> -	}
> -
> -	while (funclist) {
> -		funcnext = funclist->next;
> -		free(funclist->func);
> -		free(funclist->mod);
> -		free(funclist);
> -		funclist = funcnext;
> -	}
> -
> -	while (tep->func_handlers) {
> -		func_handler = tep->func_handlers;
> -		tep->func_handlers = func_handler->next;
> -		free_func_handle(func_handler);
> -	}
> -
> -	if (tep->printk_map) {
> -		for (i = 0; i < (int)tep->printk_count; i++)
> -			free(tep->printk_map[i].printk);
> -		free(tep->printk_map);
> -	}
> -
> -	while (printklist) {
> -		printknext = printklist->next;
> -		free(printklist->printk);
> -		free(printklist);
> -		printklist = printknext;
> -	}
> -
> -	for (i = 0; i < tep->nr_events; i++)
> -		free_tep_event(tep->events[i]);
> -
> -	while (tep->handlers) {
> -		handle = tep->handlers;
> -		tep->handlers = handle->next;
> -		free_handler(handle);
> -	}
> -
> -	free(tep->events);
> -	free(tep->sort_events);
> -	free(tep->func_resolver);
> -	free_tep_plugin_paths(tep);
> -
> -	free(tep);
> -}
> -
> -void tep_unref(struct tep_handle *tep)
> -{
> -	tep_free(tep);
> -}
> diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
> deleted file mode 100644
> index 41d4f9f6a843..000000000000
> --- a/tools/lib/traceevent/event-parse.h
> +++ /dev/null
> @@ -1,750 +0,0 @@
> -/* SPDX-License-Identifier: LGPL-2.1 */
> -/*
> - * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - *
> - */
> -#ifndef _PARSE_EVENTS_H
> -#define _PARSE_EVENTS_H
> -
> -#include <stdbool.h>
> -#include <stdarg.h>
> -#include <stdio.h>
> -#include <regex.h>
> -#include <string.h>
> -
> -#include "trace-seq.h"
> -
> -#ifndef __maybe_unused
> -#define __maybe_unused __attribute__((unused))
> -#endif
> -
> -#ifndef DEBUG_RECORD
> -#define DEBUG_RECORD 0
> -#endif
> -
> -struct tep_record {
> -	unsigned long long	ts;
> -	unsigned long long	offset;
> -	long long		missed_events;	/* buffer dropped events before */
> -	int			record_size;	/* size of binary record */
> -	int			size;		/* size of data */
> -	void			*data;
> -	int			cpu;
> -	int			ref_count;
> -	int			locked;		/* Do not free, even if ref_count is zero */
> -	void			*priv;
> -#if DEBUG_RECORD
> -	struct tep_record	*prev;
> -	struct tep_record	*next;
> -	long			alloc_addr;
> -#endif
> -};
> -
> -/* ----------------------- tep ----------------------- */
> -
> -struct tep_handle;
> -struct tep_event;
> -
> -typedef int (*tep_event_handler_func)(struct trace_seq *s,
> -				      struct tep_record *record,
> -				      struct tep_event *event,
> -				      void *context);
> -
> -typedef int (*tep_plugin_load_func)(struct tep_handle *tep);
> -typedef int (*tep_plugin_unload_func)(struct tep_handle *tep);
> -
> -struct tep_plugin_option {
> -	struct tep_plugin_option	*next;
> -	void				*handle;
> -	char				*file;
> -	char				*name;
> -	char				*plugin_alias;
> -	char				*description;
> -	const char			*value;
> -	void				*priv;
> -	int				set;
> -};
> -
> -/*
> - * Plugin hooks that can be called:
> - *
> - * TEP_PLUGIN_LOADER:  (required)
> - *   The function name to initialized the plugin.
> - *
> - *   int TEP_PLUGIN_LOADER(struct tep_handle *tep)
> - *
> - * TEP_PLUGIN_UNLOADER:  (optional)
> - *   The function called just before unloading
> - *
> - *   int TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
> - *
> - * TEP_PLUGIN_OPTIONS:  (optional)
> - *   Plugin options that can be set before loading
> - *
> - *   struct tep_plugin_option TEP_PLUGIN_OPTIONS[] = {
> - *	{
> - *		.name = "option-name",
> - *		.plugin_alias = "override-file-name", (optional)
> - *		.description = "description of option to show users",
> - *	},
> - *	{
> - *		.name = NULL,
> - *	},
> - *   };
> - *
> - *   Array must end with .name = NULL;
> - *
> - *
> - *   .plugin_alias is used to give a shorter name to access
> - *   the vairable. Useful if a plugin handles more than one event.
> - *
> - *   If .value is not set, then it is considered a boolean and only
> - *   .set will be processed. If .value is defined, then it is considered
> - *   a string option and .set will be ignored.
> - *
> - * TEP_PLUGIN_ALIAS: (optional)
> - *   The name to use for finding options (uses filename if not defined)
> - */
> -#define TEP_PLUGIN_LOADER tep_plugin_loader
> -#define TEP_PLUGIN_UNLOADER tep_plugin_unloader
> -#define TEP_PLUGIN_OPTIONS tep_plugin_options
> -#define TEP_PLUGIN_ALIAS tep_plugin_alias
> -#define _MAKE_STR(x)	#x
> -#define MAKE_STR(x)	_MAKE_STR(x)
> -#define TEP_PLUGIN_LOADER_NAME MAKE_STR(TEP_PLUGIN_LOADER)
> -#define TEP_PLUGIN_UNLOADER_NAME MAKE_STR(TEP_PLUGIN_UNLOADER)
> -#define TEP_PLUGIN_OPTIONS_NAME MAKE_STR(TEP_PLUGIN_OPTIONS)
> -#define TEP_PLUGIN_ALIAS_NAME MAKE_STR(TEP_PLUGIN_ALIAS)
> -
> -enum tep_format_flags {
> -	TEP_FIELD_IS_ARRAY	= 1,
> -	TEP_FIELD_IS_POINTER	= 2,
> -	TEP_FIELD_IS_SIGNED	= 4,
> -	TEP_FIELD_IS_STRING	= 8,
> -	TEP_FIELD_IS_DYNAMIC	= 16,
> -	TEP_FIELD_IS_LONG	= 32,
> -	TEP_FIELD_IS_FLAG	= 64,
> -	TEP_FIELD_IS_SYMBOLIC	= 128,
> -	TEP_FIELD_IS_RELATIVE	= 256,
> -};
> -
> -struct tep_format_field {
> -	struct tep_format_field	*next;
> -	struct tep_event	*event;
> -	char			*type;
> -	char			*name;
> -	char			*alias;
> -	int			offset;
> -	int			size;
> -	unsigned int		arraylen;
> -	unsigned int		elementsize;
> -	unsigned long		flags;
> -};
> -
> -struct tep_format {
> -	int			nr_common;
> -	int			nr_fields;
> -	struct tep_format_field	*common_fields;
> -	struct tep_format_field	*fields;
> -};
> -
> -struct tep_print_arg_atom {
> -	char			*atom;
> -};
> -
> -struct tep_print_arg_string {
> -	char			*string;
> -	struct tep_format_field *field;
> -};
> -
> -struct tep_print_arg_bitmask {
> -	char			*bitmask;
> -	struct tep_format_field *field;
> -};
> -
> -struct tep_print_arg_field {
> -	char			*name;
> -	struct tep_format_field	*field;
> -};
> -
> -struct tep_print_flag_sym {
> -	struct tep_print_flag_sym	*next;
> -	char				*value;
> -	char				*str;
> -};
> -
> -struct tep_print_arg_typecast {
> -	char 			*type;
> -	struct tep_print_arg	*item;
> -};
> -
> -struct tep_print_arg_flags {
> -	struct tep_print_arg		*field;
> -	char				*delim;
> -	struct tep_print_flag_sym	*flags;
> -};
> -
> -struct tep_print_arg_symbol {
> -	struct tep_print_arg		*field;
> -	struct tep_print_flag_sym	*symbols;
> -};
> -
> -struct tep_print_arg_hex {
> -	struct tep_print_arg	*field;
> -	struct tep_print_arg	*size;
> -};
> -
> -struct tep_print_arg_int_array {
> -	struct tep_print_arg	*field;
> -	struct tep_print_arg	*count;
> -	struct tep_print_arg	*el_size;
> -};
> -
> -struct tep_print_arg_dynarray {
> -	struct tep_format_field	*field;
> -	struct tep_print_arg	*index;
> -};
> -
> -struct tep_print_arg;
> -
> -struct tep_print_arg_op {
> -	char			*op;
> -	int			prio;
> -	struct tep_print_arg	*left;
> -	struct tep_print_arg	*right;
> -};
> -
> -struct tep_function_handler;
> -
> -struct tep_print_arg_func {
> -	struct tep_function_handler	*func;
> -	struct tep_print_arg		*args;
> -};
> -
> -enum tep_print_arg_type {
> -	TEP_PRINT_NULL,
> -	TEP_PRINT_ATOM,
> -	TEP_PRINT_FIELD,
> -	TEP_PRINT_FLAGS,
> -	TEP_PRINT_SYMBOL,
> -	TEP_PRINT_HEX,
> -	TEP_PRINT_INT_ARRAY,
> -	TEP_PRINT_TYPE,
> -	TEP_PRINT_STRING,
> -	TEP_PRINT_BSTRING,
> -	TEP_PRINT_DYNAMIC_ARRAY,
> -	TEP_PRINT_OP,
> -	TEP_PRINT_FUNC,
> -	TEP_PRINT_BITMASK,
> -	TEP_PRINT_DYNAMIC_ARRAY_LEN,
> -	TEP_PRINT_HEX_STR,
> -};
> -
> -struct tep_print_arg {
> -	struct tep_print_arg		*next;
> -	enum tep_print_arg_type		type;
> -	union {
> -		struct tep_print_arg_atom	atom;
> -		struct tep_print_arg_field	field;
> -		struct tep_print_arg_typecast	typecast;
> -		struct tep_print_arg_flags	flags;
> -		struct tep_print_arg_symbol	symbol;
> -		struct tep_print_arg_hex	hex;
> -		struct tep_print_arg_int_array	int_array;
> -		struct tep_print_arg_func	func;
> -		struct tep_print_arg_string	string;
> -		struct tep_print_arg_bitmask	bitmask;
> -		struct tep_print_arg_op		op;
> -		struct tep_print_arg_dynarray	dynarray;
> -	};
> -};
> -
> -struct tep_print_parse;
> -
> -struct tep_print_fmt {
> -	char			*format;
> -	struct tep_print_arg	*args;
> -	struct tep_print_parse	*print_cache;
> -};
> -
> -struct tep_event {
> -	struct tep_handle	*tep;
> -	char			*name;
> -	int			id;
> -	int			flags;
> -	struct tep_format	format;
> -	struct tep_print_fmt	print_fmt;
> -	char			*system;
> -	tep_event_handler_func	handler;
> -	void			*context;
> -};
> -
> -enum {
> -	TEP_EVENT_FL_ISFTRACE	= 0x01,
> -	TEP_EVENT_FL_ISPRINT	= 0x02,
> -	TEP_EVENT_FL_ISBPRINT	= 0x04,
> -	TEP_EVENT_FL_ISFUNCENT	= 0x10,
> -	TEP_EVENT_FL_ISFUNCRET	= 0x20,
> -	TEP_EVENT_FL_NOHANDLE	= 0x40,
> -	TEP_EVENT_FL_PRINTRAW	= 0x80,
> -
> -	TEP_EVENT_FL_FAILED	= 0x80000000
> -};
> -
> -enum tep_event_sort_type {
> -	TEP_EVENT_SORT_ID,
> -	TEP_EVENT_SORT_NAME,
> -	TEP_EVENT_SORT_SYSTEM,
> -};
> -
> -enum tep_event_type {
> -	TEP_EVENT_ERROR,
> -	TEP_EVENT_NONE,
> -	TEP_EVENT_SPACE,
> -	TEP_EVENT_NEWLINE,
> -	TEP_EVENT_OP,
> -	TEP_EVENT_DELIM,
> -	TEP_EVENT_ITEM,
> -	TEP_EVENT_DQUOTE,
> -	TEP_EVENT_SQUOTE,
> -};
> -
> -typedef unsigned long long (*tep_func_handler)(struct trace_seq *s,
> -					       unsigned long long *args);
> -
> -enum tep_func_arg_type {
> -	TEP_FUNC_ARG_VOID,
> -	TEP_FUNC_ARG_INT,
> -	TEP_FUNC_ARG_LONG,
> -	TEP_FUNC_ARG_STRING,
> -	TEP_FUNC_ARG_PTR,
> -	TEP_FUNC_ARG_MAX_TYPES
> -};
> -
> -enum tep_flag {
> -	TEP_NSEC_OUTPUT		= 1,	/* output in NSECS */
> -	TEP_DISABLE_SYS_PLUGINS	= 1 << 1,
> -	TEP_DISABLE_PLUGINS	= 1 << 2,
> -};
> -
> -#define TEP_ERRORS 							      \
> -	_PE(MEM_ALLOC_FAILED,	"failed to allocate memory"),		      \
> -	_PE(PARSE_EVENT_FAILED,	"failed to parse event"),		      \
> -	_PE(READ_ID_FAILED,	"failed to read event id"),		      \
> -	_PE(READ_FORMAT_FAILED,	"failed to read event format"),		      \
> -	_PE(READ_PRINT_FAILED,	"failed to read event print fmt"), 	      \
> -	_PE(OLD_FTRACE_ARG_FAILED,"failed to allocate field name for ftrace"),\
> -	_PE(INVALID_ARG_TYPE,	"invalid argument type"),		      \
> -	_PE(INVALID_EXP_TYPE,	"invalid expression type"),		      \
> -	_PE(INVALID_OP_TYPE,	"invalid operator type"),		      \
> -	_PE(INVALID_EVENT_NAME,	"invalid event name"),			      \
> -	_PE(EVENT_NOT_FOUND,	"no event found"),			      \
> -	_PE(SYNTAX_ERROR,	"syntax error"),			      \
> -	_PE(ILLEGAL_RVALUE,	"illegal rvalue"),			      \
> -	_PE(ILLEGAL_LVALUE,	"illegal lvalue for string comparison"),      \
> -	_PE(INVALID_REGEX,	"regex did not compute"),		      \
> -	_PE(ILLEGAL_STRING_CMP,	"illegal comparison for string"), 	      \
> -	_PE(ILLEGAL_INTEGER_CMP,"illegal comparison for integer"), 	      \
> -	_PE(REPARENT_NOT_OP,	"cannot reparent other than OP"),	      \
> -	_PE(REPARENT_FAILED,	"failed to reparent filter OP"),	      \
> -	_PE(BAD_FILTER_ARG,	"bad arg in filter tree"),		      \
> -	_PE(UNEXPECTED_TYPE,	"unexpected type (not a value)"),	      \
> -	_PE(ILLEGAL_TOKEN,	"illegal token"),			      \
> -	_PE(INVALID_PAREN,	"open parenthesis cannot come here"), 	      \
> -	_PE(UNBALANCED_PAREN,	"unbalanced number of parenthesis"),	      \
> -	_PE(UNKNOWN_TOKEN,	"unknown token"),			      \
> -	_PE(FILTER_NOT_FOUND,	"no filter found"),			      \
> -	_PE(NOT_A_NUMBER,	"must have number field"),		      \
> -	_PE(NO_FILTER,		"no filters exists"),			      \
> -	_PE(FILTER_MISS,	"record does not match to filter")
> -
> -#undef _PE
> -#define _PE(__code, __str) TEP_ERRNO__ ## __code
> -enum tep_errno {
> -	TEP_ERRNO__SUCCESS			= 0,
> -	TEP_ERRNO__FILTER_MATCH			= TEP_ERRNO__SUCCESS,
> -
> -	/*
> -	 * Choose an arbitrary negative big number not to clash with standard
> -	 * errno since SUS requires the errno has distinct positive values.
> -	 * See 'Issue 6' in the link below.
> -	 *
> -	 * https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html
> -	 */
> -	__TEP_ERRNO__START			= -100000,
> -
> -	TEP_ERRORS,
> -
> -	__TEP_ERRNO__END,
> -};
> -#undef _PE
> -
> -struct tep_plugin_list;
> -
> -#define INVALID_PLUGIN_LIST_OPTION	((char **)((unsigned long)-1))
> -
> -enum tep_plugin_load_priority {
> -	TEP_PLUGIN_FIRST,
> -	TEP_PLUGIN_LAST,
> -};
> -
> -int tep_add_plugin_path(struct tep_handle *tep, char *path,
> -			enum tep_plugin_load_priority prio);
> -struct tep_plugin_list *tep_load_plugins(struct tep_handle *tep);
> -void tep_unload_plugins(struct tep_plugin_list *plugin_list,
> -			struct tep_handle *tep);
> -void tep_load_plugins_hook(struct tep_handle *tep, const char *suffix,
> -			   void (*load_plugin)(struct tep_handle *tep,
> -					       const char *path,
> -					       const char *name,
> -					       void *data),
> -			   void *data);
> -char **tep_plugin_list_options(void);
> -void tep_plugin_free_options_list(char **list);
> -int tep_plugin_add_options(const char *name,
> -			   struct tep_plugin_option *options);
> -int tep_plugin_add_option(const char *name, const char *val);
> -void tep_plugin_remove_options(struct tep_plugin_option *options);
> -void tep_plugin_print_options(struct trace_seq *s);
> -void tep_print_plugins(struct trace_seq *s,
> -			const char *prefix, const char *suffix,
> -			const struct tep_plugin_list *list);
> -
> -/* tep_handle */
> -typedef char *(tep_func_resolver_t)(void *priv,
> -				    unsigned long long *addrp, char **modp);
> -void tep_set_flag(struct tep_handle *tep, int flag);
> -void tep_clear_flag(struct tep_handle *tep, enum tep_flag flag);
> -bool tep_test_flag(struct tep_handle *tep, enum tep_flag flags);
> -
> -static inline int tep_is_bigendian(void)
> -{
> -	unsigned char str[] = { 0x1, 0x2, 0x3, 0x4 };
> -	unsigned int val;
> -
> -	memcpy(&val, str, 4);
> -	return val == 0x01020304;
> -}
> -
> -/* taken from kernel/trace/trace.h */
> -enum trace_flag_type {
> -	TRACE_FLAG_IRQS_OFF		= 0x01,
> -	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
> -	TRACE_FLAG_NEED_RESCHED		= 0x04,
> -	TRACE_FLAG_HARDIRQ		= 0x08,
> -	TRACE_FLAG_SOFTIRQ		= 0x10,
> -};
> -
> -int tep_set_function_resolver(struct tep_handle *tep,
> -			      tep_func_resolver_t *func, void *priv);
> -void tep_reset_function_resolver(struct tep_handle *tep);
> -int tep_register_comm(struct tep_handle *tep, const char *comm, int pid);
> -int tep_override_comm(struct tep_handle *tep, const char *comm, int pid);
> -int tep_register_function(struct tep_handle *tep, char *name,
> -			  unsigned long long addr, char *mod);
> -int tep_register_print_string(struct tep_handle *tep, const char *fmt,
> -			      unsigned long long addr);
> -bool tep_is_pid_registered(struct tep_handle *tep, int pid);
> -
> -struct tep_event *tep_get_event(struct tep_handle *tep, int index);
> -
> -#define TEP_PRINT_INFO		"INFO"
> -#define TEP_PRINT_INFO_RAW	"INFO_RAW"
> -#define TEP_PRINT_COMM		"COMM"
> -#define TEP_PRINT_LATENCY	"LATENCY"
> -#define TEP_PRINT_NAME		"NAME"
> -#define TEP_PRINT_PID		1U
> -#define TEP_PRINT_TIME		2U
> -#define TEP_PRINT_CPU		3U
> -
> -void tep_print_event(struct tep_handle *tep, struct trace_seq *s,
> -		     struct tep_record *record, const char *fmt, ...)
> -	__attribute__ ((format (printf, 4, 5)));
> -
> -int tep_parse_header_page(struct tep_handle *tep, char *buf, unsigned long size,
> -			  int long_size);
> -
> -enum tep_errno tep_parse_event(struct tep_handle *tep, const char *buf,
> -			       unsigned long size, const char *sys);
> -enum tep_errno tep_parse_format(struct tep_handle *tep,
> -				struct tep_event **eventp,
> -				const char *buf,
> -				unsigned long size, const char *sys);
> -
> -void *tep_get_field_raw(struct trace_seq *s, struct tep_event *event,
> -			const char *name, struct tep_record *record,
> -			int *len, int err);
> -
> -int tep_get_field_val(struct trace_seq *s, struct tep_event *event,
> -		      const char *name, struct tep_record *record,
> -		      unsigned long long *val, int err);
> -int tep_get_common_field_val(struct trace_seq *s, struct tep_event *event,
> -			     const char *name, struct tep_record *record,
> -			     unsigned long long *val, int err);
> -int tep_get_any_field_val(struct trace_seq *s, struct tep_event *event,
> -			  const char *name, struct tep_record *record,
> -			  unsigned long long *val, int err);
> -
> -int tep_print_num_field(struct trace_seq *s, const char *fmt,
> -			struct tep_event *event, const char *name,
> -			struct tep_record *record, int err);
> -
> -int tep_print_func_field(struct trace_seq *s, const char *fmt,
> -			 struct tep_event *event, const char *name,
> -			 struct tep_record *record, int err);
> -
> -enum tep_reg_handler {
> -	TEP_REGISTER_SUCCESS = 0,
> -	TEP_REGISTER_SUCCESS_OVERWRITE,
> -};
> -
> -int tep_register_event_handler(struct tep_handle *tep, int id,
> -			       const char *sys_name, const char *event_name,
> -			       tep_event_handler_func func, void *context);
> -int tep_unregister_event_handler(struct tep_handle *tep, int id,
> -				 const char *sys_name, const char *event_name,
> -				 tep_event_handler_func func, void *context);
> -int tep_register_print_function(struct tep_handle *tep,
> -				tep_func_handler func,
> -				enum tep_func_arg_type ret_type,
> -				char *name, ...);
> -int tep_unregister_print_function(struct tep_handle *tep,
> -				  tep_func_handler func, char *name);
> -
> -struct tep_format_field *tep_find_common_field(struct tep_event *event, const char *name);
> -struct tep_format_field *tep_find_field(struct tep_event *event, const char *name);
> -struct tep_format_field *tep_find_any_field(struct tep_event *event, const char *name);
> -
> -const char *tep_find_function(struct tep_handle *tep, unsigned long long addr);
> -unsigned long long
> -tep_find_function_address(struct tep_handle *tep, unsigned long long addr);
> -unsigned long long tep_read_number(struct tep_handle *tep, const void *ptr, int size);
> -int tep_read_number_field(struct tep_format_field *field, const void *data,
> -			  unsigned long long *value);
> -
> -struct tep_event *tep_get_first_event(struct tep_handle *tep);
> -int tep_get_events_count(struct tep_handle *tep);
> -struct tep_event *tep_find_event(struct tep_handle *tep, int id);
> -
> -struct tep_event *
> -tep_find_event_by_name(struct tep_handle *tep, const char *sys, const char *name);
> -struct tep_event *
> -tep_find_event_by_record(struct tep_handle *tep, struct tep_record *record);
> -
> -int tep_data_type(struct tep_handle *tep, struct tep_record *rec);
> -int tep_data_pid(struct tep_handle *tep, struct tep_record *rec);
> -int tep_data_preempt_count(struct tep_handle *tep, struct tep_record *rec);
> -int tep_data_flags(struct tep_handle *tep, struct tep_record *rec);
> -const char *tep_data_comm_from_pid(struct tep_handle *tep, int pid);
> -struct tep_cmdline;
> -struct tep_cmdline *tep_data_pid_from_comm(struct tep_handle *tep, const char *comm,
> -					   struct tep_cmdline *next);
> -int tep_cmdline_pid(struct tep_handle *tep, struct tep_cmdline *cmdline);
> -
> -void tep_print_field(struct trace_seq *s, void *data,
> -		     struct tep_format_field *field);
> -void tep_print_fields(struct trace_seq *s, void *data,
> -		      int size __maybe_unused, struct tep_event *event);
> -int tep_strerror(struct tep_handle *tep, enum tep_errno errnum,
> -		 char *buf, size_t buflen);
> -
> -struct tep_event **tep_list_events(struct tep_handle *tep, enum tep_event_sort_type);
> -struct tep_event **tep_list_events_copy(struct tep_handle *tep,
> -					enum tep_event_sort_type);
> -struct tep_format_field **tep_event_common_fields(struct tep_event *event);
> -struct tep_format_field **tep_event_fields(struct tep_event *event);
> -
> -enum tep_endian {
> -        TEP_LITTLE_ENDIAN = 0,
> -        TEP_BIG_ENDIAN
> -};
> -int tep_get_cpus(struct tep_handle *tep);
> -void tep_set_cpus(struct tep_handle *tep, int cpus);
> -int tep_get_long_size(struct tep_handle *tep);
> -void tep_set_long_size(struct tep_handle *tep, int long_size);
> -int tep_get_page_size(struct tep_handle *tep);
> -void tep_set_page_size(struct tep_handle *tep, int _page_size);
> -bool tep_is_file_bigendian(struct tep_handle *tep);
> -void tep_set_file_bigendian(struct tep_handle *tep, enum tep_endian endian);
> -bool tep_is_local_bigendian(struct tep_handle *tep);
> -void tep_set_local_bigendian(struct tep_handle *tep, enum tep_endian endian);
> -int tep_get_header_page_size(struct tep_handle *tep);
> -int tep_get_header_timestamp_size(struct tep_handle *tep);
> -bool tep_is_old_format(struct tep_handle *tep);
> -void tep_set_test_filters(struct tep_handle *tep, int test_filters);
> -
> -struct tep_handle *tep_alloc(void);
> -void tep_free(struct tep_handle *tep);
> -void tep_ref(struct tep_handle *tep);
> -void tep_unref(struct tep_handle *tep);
> -int tep_get_ref(struct tep_handle *tep);
> -
> -/* for debugging */
> -void tep_print_funcs(struct tep_handle *tep);
> -void tep_print_printk(struct tep_handle *tep);
> -
> -/* ----------------------- filtering ----------------------- */
> -
> -enum tep_filter_boolean_type {
> -	TEP_FILTER_FALSE,
> -	TEP_FILTER_TRUE,
> -};
> -
> -enum tep_filter_op_type {
> -	TEP_FILTER_OP_AND = 1,
> -	TEP_FILTER_OP_OR,
> -	TEP_FILTER_OP_NOT,
> -};
> -
> -enum tep_filter_cmp_type {
> -	TEP_FILTER_CMP_NONE,
> -	TEP_FILTER_CMP_EQ,
> -	TEP_FILTER_CMP_NE,
> -	TEP_FILTER_CMP_GT,
> -	TEP_FILTER_CMP_LT,
> -	TEP_FILTER_CMP_GE,
> -	TEP_FILTER_CMP_LE,
> -	TEP_FILTER_CMP_MATCH,
> -	TEP_FILTER_CMP_NOT_MATCH,
> -	TEP_FILTER_CMP_REGEX,
> -	TEP_FILTER_CMP_NOT_REGEX,
> -};
> -
> -enum tep_filter_exp_type {
> -	TEP_FILTER_EXP_NONE,
> -	TEP_FILTER_EXP_ADD,
> -	TEP_FILTER_EXP_SUB,
> -	TEP_FILTER_EXP_MUL,
> -	TEP_FILTER_EXP_DIV,
> -	TEP_FILTER_EXP_MOD,
> -	TEP_FILTER_EXP_RSHIFT,
> -	TEP_FILTER_EXP_LSHIFT,
> -	TEP_FILTER_EXP_AND,
> -	TEP_FILTER_EXP_OR,
> -	TEP_FILTER_EXP_XOR,
> -	TEP_FILTER_EXP_NOT,
> -};
> -
> -enum tep_filter_arg_type {
> -	TEP_FILTER_ARG_NONE,
> -	TEP_FILTER_ARG_BOOLEAN,
> -	TEP_FILTER_ARG_VALUE,
> -	TEP_FILTER_ARG_FIELD,
> -	TEP_FILTER_ARG_EXP,
> -	TEP_FILTER_ARG_OP,
> -	TEP_FILTER_ARG_NUM,
> -	TEP_FILTER_ARG_STR,
> -};
> -
> -enum tep_filter_value_type {
> -	TEP_FILTER_NUMBER,
> -	TEP_FILTER_STRING,
> -	TEP_FILTER_CHAR
> -};
> -
> -struct tep_filter_arg;
> -
> -struct tep_filter_arg_boolean {
> -	enum tep_filter_boolean_type	value;
> -};
> -
> -struct tep_filter_arg_field {
> -	struct tep_format_field		*field;
> -};
> -
> -struct tep_filter_arg_value {
> -	enum tep_filter_value_type	type;
> -	union {
> -		char			*str;
> -		unsigned long long	val;
> -	};
> -};
> -
> -struct tep_filter_arg_op {
> -	enum tep_filter_op_type		type;
> -	struct tep_filter_arg		*left;
> -	struct tep_filter_arg		*right;
> -};
> -
> -struct tep_filter_arg_exp {
> -	enum tep_filter_exp_type	type;
> -	struct tep_filter_arg		*left;
> -	struct tep_filter_arg		*right;
> -};
> -
> -struct tep_filter_arg_num {
> -	enum tep_filter_cmp_type	type;
> -	struct tep_filter_arg		*left;
> -	struct tep_filter_arg		*right;
> -};
> -
> -struct tep_filter_arg_str {
> -	enum tep_filter_cmp_type	type;
> -	struct tep_format_field		*field;
> -	char				*val;
> -	char				*buffer;
> -	regex_t				reg;
> -};
> -
> -struct tep_filter_arg {
> -	enum tep_filter_arg_type		type;
> -	union {
> -		struct tep_filter_arg_boolean	boolean;
> -		struct tep_filter_arg_field	field;
> -		struct tep_filter_arg_value	value;
> -		struct tep_filter_arg_op	op;
> -		struct tep_filter_arg_exp	exp;
> -		struct tep_filter_arg_num	num;
> -		struct tep_filter_arg_str	str;
> -	};
> -};
> -
> -struct tep_filter_type {
> -	int			event_id;
> -	struct tep_event	*event;
> -	struct tep_filter_arg	*filter;
> -};
> -
> -#define TEP_FILTER_ERROR_BUFSZ  1024
> -
> -struct tep_event_filter {
> -	struct tep_handle	*tep;
> -	int			filters;
> -	struct tep_filter_type	*event_filters;
> -	char			error_buffer[TEP_FILTER_ERROR_BUFSZ];
> -};
> -
> -struct tep_event_filter *tep_filter_alloc(struct tep_handle *tep);
> -
> -/* for backward compatibility */
> -#define FILTER_NONE		TEP_ERRNO__NO_FILTER
> -#define FILTER_NOEXIST		TEP_ERRNO__FILTER_NOT_FOUND
> -#define FILTER_MISS		TEP_ERRNO__FILTER_MISS
> -#define FILTER_MATCH		TEP_ERRNO__FILTER_MATCH
> -
> -enum tep_errno tep_filter_add_filter_str(struct tep_event_filter *filter,
> -					 const char *filter_str);
> -
> -enum tep_errno tep_filter_match(struct tep_event_filter *filter,
> -				struct tep_record *record);
> -
> -int tep_filter_strerror(struct tep_event_filter *filter, enum tep_errno err,
> -			char *buf, size_t buflen);
> -
> -int tep_event_filtered(struct tep_event_filter *filter,
> -		       int event_id);
> -
> -void tep_filter_reset(struct tep_event_filter *filter);
> -
> -void tep_filter_free(struct tep_event_filter *filter);
> -
> -char *tep_filter_make_string(struct tep_event_filter *filter, int event_id);
> -
> -int tep_filter_remove_event(struct tep_event_filter *filter,
> -			    int event_id);
> -
> -int tep_filter_copy(struct tep_event_filter *dest, struct tep_event_filter *source);
> -
> -int tep_filter_compare(struct tep_event_filter *filter1, struct tep_event_filter *filter2);
> -
> -#endif /* _PARSE_EVENTS_H */
> diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
> deleted file mode 100644
> index e7f93d5fe4fd..000000000000
> --- a/tools/lib/traceevent/event-plugin.c
> +++ /dev/null
> @@ -1,711 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - *
> - */
> -
> -#include <ctype.h>
> -#include <stdio.h>
> -#include <string.h>
> -#include <dlfcn.h>
> -#include <stdlib.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
> -#include <dirent.h>
> -#include <errno.h>
> -#include "event-parse.h"
> -#include "event-parse-local.h"
> -#include "event-utils.h"
> -#include "trace-seq.h"
> -
> -#define LOCAL_PLUGIN_DIR ".local/lib/traceevent/plugins/"
> -
> -static struct registered_plugin_options {
> -	struct registered_plugin_options	*next;
> -	struct tep_plugin_option		*options;
> -} *registered_options;
> -
> -static struct trace_plugin_options {
> -	struct trace_plugin_options	*next;
> -	char				*plugin;
> -	char				*option;
> -	char				*value;
> -} *trace_plugin_options;
> -
> -struct tep_plugin_list {
> -	struct tep_plugin_list	*next;
> -	char			*name;
> -	void			*handle;
> -};
> -
> -struct tep_plugins_dir {
> -	struct tep_plugins_dir		*next;
> -	char				*path;
> -	enum tep_plugin_load_priority	prio;
> -};
> -
> -static void lower_case(char *str)
> -{
> -	if (!str)
> -		return;
> -	for (; *str; str++)
> -		*str = tolower(*str);
> -}
> -
> -static int update_option_value(struct tep_plugin_option *op, const char *val)
> -{
> -	char *op_val;
> -
> -	if (!val) {
> -		/* toggle, only if option is boolean */
> -		if (op->value)
> -			/* Warn? */
> -			return 0;
> -		op->set ^= 1;
> -		return 0;
> -	}
> -
> -	/*
> -	 * If the option has a value then it takes a string
> -	 * otherwise the option is a boolean.
> -	 */
> -	if (op->value) {
> -		op->value = val;
> -		return 0;
> -	}
> -
> -	/* Option is boolean, must be either "1", "0", "true" or "false" */
> -
> -	op_val = strdup(val);
> -	if (!op_val)
> -		return -1;
> -	lower_case(op_val);
> -
> -	if (strcmp(val, "1") == 0 || strcmp(val, "true") == 0)
> -		op->set = 1;
> -	else if (strcmp(val, "0") == 0 || strcmp(val, "false") == 0)
> -		op->set = 0;
> -	free(op_val);
> -
> -	return 0;
> -}
> -
> -/**
> - * tep_plugin_list_options - get list of plugin options
> - *
> - * Returns an array of char strings that list the currently registered
> - * plugin options in the format of <plugin>:<option>. This list can be
> - * used by toggling the option.
> - *
> - * Returns NULL if there's no options registered. On error it returns
> - * INVALID_PLUGIN_LIST_OPTION
> - *
> - * Must be freed with tep_plugin_free_options_list().
> - */
> -char **tep_plugin_list_options(void)
> -{
> -	struct registered_plugin_options *reg;
> -	struct tep_plugin_option *op;
> -	char **list = NULL;
> -	char *name;
> -	int count = 0;
> -
> -	for (reg = registered_options; reg; reg = reg->next) {
> -		for (op = reg->options; op->name; op++) {
> -			char *alias = op->plugin_alias ? op->plugin_alias : op->file;
> -			char **temp = list;
> -			int ret;
> -
> -			ret = asprintf(&name, "%s:%s", alias, op->name);
> -			if (ret < 0)
> -				goto err;
> -
> -			list = realloc(list, count + 2);
> -			if (!list) {
> -				list = temp;
> -				free(name);
> -				goto err;
> -			}
> -			list[count++] = name;
> -			list[count] = NULL;
> -		}
> -	}
> -	return list;
> -
> - err:
> -	while (--count >= 0)
> -		free(list[count]);
> -	free(list);
> -
> -	return INVALID_PLUGIN_LIST_OPTION;
> -}
> -
> -void tep_plugin_free_options_list(char **list)
> -{
> -	int i;
> -
> -	if (!list)
> -		return;
> -
> -	if (list == INVALID_PLUGIN_LIST_OPTION)
> -		return;
> -
> -	for (i = 0; list[i]; i++)
> -		free(list[i]);
> -
> -	free(list);
> -}
> -
> -static int
> -update_option(const char *file, struct tep_plugin_option *option)
> -{
> -	struct trace_plugin_options *op;
> -	char *plugin;
> -	int ret = 0;
> -
> -	if (option->plugin_alias) {
> -		plugin = strdup(option->plugin_alias);
> -		if (!plugin)
> -			return -1;
> -	} else {
> -		char *p;
> -		plugin = strdup(file);
> -		if (!plugin)
> -			return -1;
> -		p = strstr(plugin, ".");
> -		if (p)
> -			*p = '\0';
> -	}
> -
> -	/* first look for named options */
> -	for (op = trace_plugin_options; op; op = op->next) {
> -		if (!op->plugin)
> -			continue;
> -		if (strcmp(op->plugin, plugin) != 0)
> -			continue;
> -		if (strcmp(op->option, option->name) != 0)
> -			continue;
> -
> -		ret = update_option_value(option, op->value);
> -		if (ret)
> -			goto out;
> -		break;
> -	}
> -
> -	/* first look for unnamed options */
> -	for (op = trace_plugin_options; op; op = op->next) {
> -		if (op->plugin)
> -			continue;
> -		if (strcmp(op->option, option->name) != 0)
> -			continue;
> -
> -		ret = update_option_value(option, op->value);
> -		break;
> -	}
> -
> - out:
> -	free(plugin);
> -	return ret;
> -}
> -
> -/**
> - * tep_plugin_add_options - Add a set of options by a plugin
> - * @name: The name of the plugin adding the options
> - * @options: The set of options being loaded
> - *
> - * Sets the options with the values that have been added by user.
> - */
> -int tep_plugin_add_options(const char *name,
> -			   struct tep_plugin_option *options)
> -{
> -	struct registered_plugin_options *reg;
> -
> -	reg = malloc(sizeof(*reg));
> -	if (!reg)
> -		return -1;
> -	reg->next = registered_options;
> -	reg->options = options;
> -	registered_options = reg;
> -
> -	while (options->name) {
> -		update_option(name, options);
> -		options++;
> -	}
> -	return 0;
> -}
> -
> -/**
> - * tep_plugin_remove_options - remove plugin options that were registered
> - * @options: Options to removed that were registered with tep_plugin_add_options
> - */
> -void tep_plugin_remove_options(struct tep_plugin_option *options)
> -{
> -	struct registered_plugin_options **last;
> -	struct registered_plugin_options *reg;
> -
> -	for (last = &registered_options; *last; last = &(*last)->next) {
> -		if ((*last)->options == options) {
> -			reg = *last;
> -			*last = reg->next;
> -			free(reg);
> -			return;
> -		}
> -	}
> -}
> -
> -static int parse_option_name(char **option, char **plugin)
> -{
> -	char *p;
> -
> -	*plugin = NULL;
> -
> -	if ((p = strstr(*option, ":"))) {
> -		*plugin = *option;
> -		*p = '\0';
> -		*option = strdup(p + 1);
> -		if (!*option)
> -			return -1;
> -	}
> -	return 0;
> -}
> -
> -static struct tep_plugin_option *
> -find_registered_option(const char *plugin, const char *option)
> -{
> -	struct registered_plugin_options *reg;
> -	struct tep_plugin_option *op;
> -	const char *op_plugin;
> -
> -	for (reg = registered_options; reg; reg = reg->next) {
> -		for (op = reg->options; op->name; op++) {
> -			if (op->plugin_alias)
> -				op_plugin = op->plugin_alias;
> -			else
> -				op_plugin = op->file;
> -
> -			if (plugin && strcmp(plugin, op_plugin) != 0)
> -				continue;
> -			if (strcmp(option, op->name) != 0)
> -				continue;
> -
> -			return op;
> -		}
> -	}
> -
> -	return NULL;
> -}
> -
> -static int process_option(const char *plugin, const char *option, const char *val)
> -{
> -	struct tep_plugin_option *op;
> -
> -	op = find_registered_option(plugin, option);
> -	if (!op)
> -		return 0;
> -
> -	return update_option_value(op, val);
> -}
> -
> -/**
> - * tep_plugin_add_option - add an option/val pair to set plugin options
> - * @name: The name of the option (format: <plugin>:<option> or just <option>)
> - * @val: (optional) the value for the option
> - *
> - * Modify a plugin option. If @val is given than the value of the option
> - * is set (note, some options just take a boolean, so @val must be either
> - * "1" or "0" or "true" or "false").
> - */
> -int tep_plugin_add_option(const char *name, const char *val)
> -{
> -	struct trace_plugin_options *op;
> -	char *option_str;
> -	char *plugin;
> -
> -	option_str = strdup(name);
> -	if (!option_str)
> -		return -ENOMEM;
> -
> -	if (parse_option_name(&option_str, &plugin) < 0)
> -		return -ENOMEM;
> -
> -	/* If the option exists, update the val */
> -	for (op = trace_plugin_options; op; op = op->next) {
> -		/* Both must be NULL or not NULL */
> -		if ((!plugin || !op->plugin) && plugin != op->plugin)
> -			continue;
> -		if (plugin && strcmp(plugin, op->plugin) != 0)
> -			continue;
> -		if (strcmp(op->option, option_str) != 0)
> -			continue;
> -
> -		/* update option */
> -		free(op->value);
> -		if (val) {
> -			op->value = strdup(val);
> -			if (!op->value)
> -				goto out_free;
> -		} else
> -			op->value = NULL;
> -
> -		/* plugin and option_str don't get freed at the end */
> -		free(plugin);
> -		free(option_str);
> -
> -		plugin = op->plugin;
> -		option_str = op->option;
> -		break;
> -	}
> -
> -	/* If not found, create */
> -	if (!op) {
> -		op = malloc(sizeof(*op));
> -		if (!op)
> -			goto out_free;
> -		memset(op, 0, sizeof(*op));
> -		op->plugin = plugin;
> -		op->option = option_str;
> -		if (val) {
> -			op->value = strdup(val);
> -			if (!op->value) {
> -				free(op);
> -				goto out_free;
> -			}
> -		}
> -		op->next = trace_plugin_options;
> -		trace_plugin_options = op;
> -	}
> -
> -	return process_option(plugin, option_str, val);
> -
> -out_free:
> -	free(plugin);
> -	free(option_str);
> -	return -ENOMEM;
> -}
> -
> -static void print_op_data(struct trace_seq *s, const char *name,
> -			  const char *op)
> -{
> -	if (op)
> -		trace_seq_printf(s, "%8s:\t%s\n", name, op);
> -}
> -
> -/**
> - * tep_plugin_print_options - print out the registered plugin options
> - * @s: The trace_seq descriptor to write the plugin options into
> - *
> - * Writes a list of options into trace_seq @s.
> - */
> -void tep_plugin_print_options(struct trace_seq *s)
> -{
> -	struct registered_plugin_options *reg;
> -	struct tep_plugin_option *op;
> -
> -	for (reg = registered_options; reg; reg = reg->next) {
> -		if (reg != registered_options)
> -			trace_seq_printf(s, "============\n");
> -		for (op = reg->options; op->name; op++) {
> -			if (op != reg->options)
> -				trace_seq_printf(s, "------------\n");
> -			print_op_data(s, "file", op->file);
> -			print_op_data(s, "plugin", op->plugin_alias);
> -			print_op_data(s, "option", op->name);
> -			print_op_data(s, "desc", op->description);
> -			print_op_data(s, "value", op->value);
> -			trace_seq_printf(s, "%8s:\t%d\n", "set", op->set);
> -		}
> -	}
> -}
> -
> -/**
> - * tep_print_plugins - print out the list of plugins loaded
> - * @s: the trace_seq descripter to write to
> - * @prefix: The prefix string to add before listing the option name
> - * @suffix: The suffix string ot append after the option name
> - * @list: The list of plugins (usually returned by tep_load_plugins()
> - *
> - * Writes to the trace_seq @s the list of plugins (files) that is
> - * returned by tep_load_plugins(). Use @prefix and @suffix for formating:
> - * @prefix = "  ", @suffix = "\n".
> - */
> -void tep_print_plugins(struct trace_seq *s,
> -		       const char *prefix, const char *suffix,
> -		       const struct tep_plugin_list *list)
> -{
> -	while (list) {
> -		trace_seq_printf(s, "%s%s%s", prefix, list->name, suffix);
> -		list = list->next;
> -	}
> -}
> -
> -static void
> -load_plugin(struct tep_handle *tep, const char *path,
> -	    const char *file, void *data)
> -{
> -	struct tep_plugin_list **plugin_list = data;
> -	struct tep_plugin_option *options;
> -	tep_plugin_load_func func;
> -	struct tep_plugin_list *list;
> -	const char *alias;
> -	char *plugin;
> -	void *handle;
> -	int ret;
> -
> -	ret = asprintf(&plugin, "%s/%s", path, file);
> -	if (ret < 0) {
> -		warning("could not allocate plugin memory\n");
> -		return;
> -	}
> -
> -	handle = dlopen(plugin, RTLD_NOW | RTLD_GLOBAL);
> -	if (!handle) {
> -		warning("could not load plugin '%s'\n%s\n",
> -			plugin, dlerror());
> -		goto out_free;
> -	}
> -
> -	alias = dlsym(handle, TEP_PLUGIN_ALIAS_NAME);
> -	if (!alias)
> -		alias = file;
> -
> -	options = dlsym(handle, TEP_PLUGIN_OPTIONS_NAME);
> -	if (options) {
> -		while (options->name) {
> -			ret = update_option(alias, options);
> -			if (ret < 0)
> -				goto out_free;
> -			options++;
> -		}
> -	}
> -
> -	func = dlsym(handle, TEP_PLUGIN_LOADER_NAME);
> -	if (!func) {
> -		warning("could not find func '%s' in plugin '%s'\n%s\n",
> -			TEP_PLUGIN_LOADER_NAME, plugin, dlerror());
> -		goto out_free;
> -	}
> -
> -	list = malloc(sizeof(*list));
> -	if (!list) {
> -		warning("could not allocate plugin memory\n");
> -		goto out_free;
> -	}
> -
> -	list->next = *plugin_list;
> -	list->handle = handle;
> -	list->name = plugin;
> -	*plugin_list = list;
> -
> -	pr_stat("registering plugin: %s", plugin);
> -	func(tep);
> -	return;
> -
> - out_free:
> -	free(plugin);
> -}
> -
> -static void
> -load_plugins_dir(struct tep_handle *tep, const char *suffix,
> -		 const char *path,
> -		 void (*load_plugin)(struct tep_handle *tep,
> -				     const char *path,
> -				     const char *name,
> -				     void *data),
> -		 void *data)
> -{
> -	struct dirent *dent;
> -	struct stat st;
> -	DIR *dir;
> -	int ret;
> -
> -	ret = stat(path, &st);
> -	if (ret < 0)
> -		return;
> -
> -	if (!S_ISDIR(st.st_mode))
> -		return;
> -
> -	dir = opendir(path);
> -	if (!dir)
> -		return;
> -
> -	while ((dent = readdir(dir))) {
> -		const char *name = dent->d_name;
> -
> -		if (strcmp(name, ".") == 0 ||
> -		    strcmp(name, "..") == 0)
> -			continue;
> -
> -		/* Only load plugins that end in suffix */
> -		if (strcmp(name + (strlen(name) - strlen(suffix)), suffix) != 0)
> -			continue;
> -
> -		load_plugin(tep, path, name, data);
> -	}
> -
> -	closedir(dir);
> -}
> -
> -/**
> - * tep_load_plugins_hook - call a user specified callback to load a plugin
> - * @tep: handler to traceevent context
> - * @suffix: filter only plugin files with given suffix
> - * @load_plugin: user specified callback, called for each plugin file
> - * @data: custom context, passed to @load_plugin
> - *
> - * Searches for traceevent plugin files and calls @load_plugin for each
> - * The order of plugins search is:
> - *  - Directories, specified in @tep->plugins_dir and priority TEP_PLUGIN_FIRST
> - *  - Directory, specified at compile time with PLUGIN_TRACEEVENT_DIR
> - *  - Directory, specified by environment variable TRACEEVENT_PLUGIN_DIR
> - *  - In user's home: ~/.local/lib/traceevent/plugins/
> - *  - Directories, specified in @tep->plugins_dir and priority TEP_PLUGIN_LAST
> - *
> - */
> -void tep_load_plugins_hook(struct tep_handle *tep, const char *suffix,
> -			   void (*load_plugin)(struct tep_handle *tep,
> -					       const char *path,
> -					       const char *name,
> -					       void *data),
> -			   void *data)
> -{
> -	struct tep_plugins_dir *dir = NULL;
> -	char *home;
> -	char *path;
> -	char *envdir;
> -	int ret;
> -
> -	if (tep && tep->flags & TEP_DISABLE_PLUGINS)
> -		return;
> -
> -	if (tep)
> -		dir = tep->plugins_dir;
> -	while (dir) {
> -		if (dir->prio == TEP_PLUGIN_FIRST)
> -			load_plugins_dir(tep, suffix, dir->path,
> -					 load_plugin, data);
> -		dir = dir->next;
> -	}
> -
> -	/*
> -	 * If a system plugin directory was defined,
> -	 * check that first.
> -	 */
> -#ifdef PLUGIN_DIR
> -	if (!tep || !(tep->flags & TEP_DISABLE_SYS_PLUGINS))
> -		load_plugins_dir(tep, suffix, PLUGIN_DIR,
> -				 load_plugin, data);
> -#endif
> -
> -	/*
> -	 * Next let the environment-set plugin directory
> -	 * override the system defaults.
> -	 */
> -	envdir = getenv("TRACEEVENT_PLUGIN_DIR");
> -	if (envdir)
> -		load_plugins_dir(tep, suffix, envdir, load_plugin, data);
> -
> -	/*
> -	 * Now let the home directory override the environment
> -	 * or system defaults.
> -	 */
> -	home = getenv("HOME");
> -	if (!home)
> -		return;
> -
> -	ret = asprintf(&path, "%s/%s", home, LOCAL_PLUGIN_DIR);
> -	if (ret < 0) {
> -		warning("could not allocate plugin memory\n");
> -		return;
> -	}
> -
> -	load_plugins_dir(tep, suffix, path, load_plugin, data);
> -
> -	if (tep)
> -		dir = tep->plugins_dir;
> -	while (dir) {
> -		if (dir->prio == TEP_PLUGIN_LAST)
> -			load_plugins_dir(tep, suffix, dir->path,
> -					 load_plugin, data);
> -		dir = dir->next;
> -	}
> -
> -	free(path);
> -}
> -
> -struct tep_plugin_list*
> -tep_load_plugins(struct tep_handle *tep)
> -{
> -	struct tep_plugin_list *list = NULL;
> -
> -	tep_load_plugins_hook(tep, ".so", load_plugin, &list);
> -	return list;
> -}
> -
> -/**
> - * tep_add_plugin_path - Add a new plugin directory.
> - * @tep: Trace event handler.
> - * @path: Path to a directory. All plugin files in that
> - *	  directory will be loaded.
> - *@prio: Load priority of the plugins in that directory.
> - *
> - * Returns -1 in case of an error, 0 otherwise.
> - */
> -int tep_add_plugin_path(struct tep_handle *tep, char *path,
> -			enum tep_plugin_load_priority prio)
> -{
> -	struct tep_plugins_dir *dir;
> -
> -	if (!tep || !path)
> -		return -1;
> -
> -	dir = calloc(1, sizeof(*dir));
> -	if (!dir)
> -		return -1;
> -
> -	dir->path = strdup(path);
> -	if (!dir->path) {
> -		free(dir);
> -		return -1;
> -	}
> -	dir->prio = prio;
> -	dir->next = tep->plugins_dir;
> -	tep->plugins_dir = dir;
> -
> -	return 0;
> -}
> -
> -__hidden void free_tep_plugin_paths(struct tep_handle *tep)
> -{
> -	struct tep_plugins_dir *dir;
> -
> -	if (!tep)
> -		return;
> -
> -	dir = tep->plugins_dir;
> -	while (dir) {
> -		tep->plugins_dir = tep->plugins_dir->next;
> -		free(dir->path);
> -		free(dir);
> -		dir = tep->plugins_dir;
> -	}
> -}
> -
> -void
> -tep_unload_plugins(struct tep_plugin_list *plugin_list, struct tep_handle *tep)
> -{
> -	tep_plugin_unload_func func;
> -	struct tep_plugin_list *list;
> -
> -	while (plugin_list) {
> -		list = plugin_list;
> -		plugin_list = list->next;
> -		func = dlsym(list->handle, TEP_PLUGIN_UNLOADER_NAME);
> -		if (func)
> -			func(tep);
> -		dlclose(list->handle);
> -		free(list->name);
> -		free(list);
> -	}
> -}
> diff --git a/tools/lib/traceevent/event-utils.h b/tools/lib/traceevent/event-utils.h
> deleted file mode 100644
> index 0560b96a31d1..000000000000
> --- a/tools/lib/traceevent/event-utils.h
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -/* SPDX-License-Identifier: LGPL-2.1 */
> -/*
> - * Copyright (C) 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - *
> - */
> -#ifndef __UTIL_H
> -#define __UTIL_H
> -
> -#include <ctype.h>
> -
> -/* Can be overridden */
> -void warning(const char *fmt, ...);
> -void pr_stat(const char *fmt, ...);
> -void vpr_stat(const char *fmt, va_list ap);
> -
> -/* Always available */
> -void __warning(const char *fmt, ...);
> -void __pr_stat(const char *fmt, ...);
> -
> -void __vwarning(const char *fmt, ...);
> -void __vpr_stat(const char *fmt, ...);
> -
> -#define min(x, y) ({				\
> -	typeof(x) _min1 = (x);			\
> -	typeof(y) _min2 = (y);			\
> -	(void) (&_min1 == &_min2);		\
> -	_min1 < _min2 ? _min1 : _min2; })
> -
> -static inline char *strim(char *string)
> -{
> -	char *ret;
> -
> -	if (!string)
> -		return NULL;
> -	while (*string) {
> -		if (!isspace(*string))
> -			break;
> -		string++;
> -	}
> -	ret = string;
> -
> -	string = ret + strlen(ret) - 1;
> -	while (string > ret) {
> -		if (!isspace(*string))
> -			break;
> -		string--;
> -	}
> -	string[1] = 0;
> -
> -	return ret;
> -}
> -
> -static inline int has_text(const char *text)
> -{
> -	if (!text)
> -		return 0;
> -
> -	while (*text) {
> -		if (!isspace(*text))
> -			return 1;
> -		text++;
> -	}
> -
> -	return 0;
> -}
> -
> -#endif
> diff --git a/tools/lib/traceevent/kbuffer-parse.c b/tools/lib/traceevent/kbuffer-parse.c
> deleted file mode 100644
> index f1640d651c8a..000000000000
> --- a/tools/lib/traceevent/kbuffer-parse.c
> +++ /dev/null
> @@ -1,809 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - *
> - */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -
> -#include "kbuffer.h"
> -
> -#define MISSING_EVENTS (1UL << 31)
> -#define MISSING_STORED (1UL << 30)
> -
> -#define COMMIT_MASK ((1 << 27) - 1)
> -
> -enum {
> -	KBUFFER_FL_HOST_BIG_ENDIAN	= (1<<0),
> -	KBUFFER_FL_BIG_ENDIAN		= (1<<1),
> -	KBUFFER_FL_LONG_8		= (1<<2),
> -	KBUFFER_FL_OLD_FORMAT		= (1<<3),
> -};
> -
> -#define ENDIAN_MASK (KBUFFER_FL_HOST_BIG_ENDIAN | KBUFFER_FL_BIG_ENDIAN)
> -
> -/** kbuffer
> - * @timestamp		- timestamp of current event
> - * @lost_events		- # of lost events between this subbuffer and previous
> - * @flags		- special flags of the kbuffer
> - * @subbuffer		- pointer to the sub-buffer page
> - * @data		- pointer to the start of data on the sub-buffer page
> - * @index		- index from @data to the @curr event data
> - * @curr		- offset from @data to the start of current event
> - *			   (includes metadata)
> - * @next		- offset from @data to the start of next event
> - * @size		- The size of data on @data
> - * @start		- The offset from @subbuffer where @data lives
> - *
> - * @read_4		- Function to read 4 raw bytes (may swap)
> - * @read_8		- Function to read 8 raw bytes (may swap)
> - * @read_long		- Function to read a long word (4 or 8 bytes with needed swap)
> - */
> -struct kbuffer {
> -	unsigned long long 	timestamp;
> -	long long		lost_events;
> -	unsigned long		flags;
> -	void			*subbuffer;
> -	void			*data;
> -	unsigned int		index;
> -	unsigned int		curr;
> -	unsigned int		next;
> -	unsigned int		size;
> -	unsigned int		start;
> -
> -	unsigned int (*read_4)(void *ptr);
> -	unsigned long long (*read_8)(void *ptr);
> -	unsigned long long (*read_long)(struct kbuffer *kbuf, void *ptr);
> -	int (*next_event)(struct kbuffer *kbuf);
> -};
> -
> -static void *zmalloc(size_t size)
> -{
> -	return calloc(1, size);
> -}
> -
> -static int host_is_bigendian(void)
> -{
> -	unsigned char str[] = { 0x1, 0x2, 0x3, 0x4 };
> -	unsigned int *ptr;
> -
> -	ptr = (unsigned int *)str;
> -	return *ptr == 0x01020304;
> -}
> -
> -static int do_swap(struct kbuffer *kbuf)
> -{
> -	return ((kbuf->flags & KBUFFER_FL_HOST_BIG_ENDIAN) + kbuf->flags) &
> -		ENDIAN_MASK;
> -}
> -
> -static unsigned long long __read_8(void *ptr)
> -{
> -	unsigned long long data = *(unsigned long long *)ptr;
> -
> -	return data;
> -}
> -
> -static unsigned long long __read_8_sw(void *ptr)
> -{
> -	unsigned long long data = *(unsigned long long *)ptr;
> -	unsigned long long swap;
> -
> -	swap = ((data & 0xffULL) << 56) |
> -		((data & (0xffULL << 8)) << 40) |
> -		((data & (0xffULL << 16)) << 24) |
> -		((data & (0xffULL << 24)) << 8) |
> -		((data & (0xffULL << 32)) >> 8) |
> -		((data & (0xffULL << 40)) >> 24) |
> -		((data & (0xffULL << 48)) >> 40) |
> -		((data & (0xffULL << 56)) >> 56);
> -
> -	return swap;
> -}
> -
> -static unsigned int __read_4(void *ptr)
> -{
> -	unsigned int data = *(unsigned int *)ptr;
> -
> -	return data;
> -}
> -
> -static unsigned int __read_4_sw(void *ptr)
> -{
> -	unsigned int data = *(unsigned int *)ptr;
> -	unsigned int swap;
> -
> -	swap = ((data & 0xffULL) << 24) |
> -		((data & (0xffULL << 8)) << 8) |
> -		((data & (0xffULL << 16)) >> 8) |
> -		((data & (0xffULL << 24)) >> 24);
> -
> -	return swap;
> -}
> -
> -static unsigned long long read_8(struct kbuffer *kbuf, void *ptr)
> -{
> -	return kbuf->read_8(ptr);
> -}
> -
> -static unsigned int read_4(struct kbuffer *kbuf, void *ptr)
> -{
> -	return kbuf->read_4(ptr);
> -}
> -
> -static unsigned long long __read_long_8(struct kbuffer *kbuf, void *ptr)
> -{
> -	return kbuf->read_8(ptr);
> -}
> -
> -static unsigned long long __read_long_4(struct kbuffer *kbuf, void *ptr)
> -{
> -	return kbuf->read_4(ptr);
> -}
> -
> -static unsigned long long read_long(struct kbuffer *kbuf, void *ptr)
> -{
> -	return kbuf->read_long(kbuf, ptr);
> -}
> -
> -static int calc_index(struct kbuffer *kbuf, void *ptr)
> -{
> -	return (unsigned long)ptr - (unsigned long)kbuf->data;
> -}
> -
> -static int __next_event(struct kbuffer *kbuf);
> -
> -/**
> - * kbuffer_alloc - allocat a new kbuffer
> - * @size;	enum to denote size of word
> - * @endian:	enum to denote endianness
> - *
> - * Allocates and returns a new kbuffer.
> - */
> -struct kbuffer *
> -kbuffer_alloc(enum kbuffer_long_size size, enum kbuffer_endian endian)
> -{
> -	struct kbuffer *kbuf;
> -	int flags = 0;
> -
> -	switch (size) {
> -	case KBUFFER_LSIZE_4:
> -		break;
> -	case KBUFFER_LSIZE_8:
> -		flags |= KBUFFER_FL_LONG_8;
> -		break;
> -	default:
> -		return NULL;
> -	}
> -
> -	switch (endian) {
> -	case KBUFFER_ENDIAN_LITTLE:
> -		break;
> -	case KBUFFER_ENDIAN_BIG:
> -		flags |= KBUFFER_FL_BIG_ENDIAN;
> -		break;
> -	default:
> -		return NULL;
> -	}
> -
> -	kbuf = zmalloc(sizeof(*kbuf));
> -	if (!kbuf)
> -		return NULL;
> -
> -	kbuf->flags = flags;
> -
> -	if (host_is_bigendian())
> -		kbuf->flags |= KBUFFER_FL_HOST_BIG_ENDIAN;
> -
> -	if (do_swap(kbuf)) {
> -		kbuf->read_8 = __read_8_sw;
> -		kbuf->read_4 = __read_4_sw;
> -	} else {
> -		kbuf->read_8 = __read_8;
> -		kbuf->read_4 = __read_4;
> -	}
> -
> -	if (kbuf->flags & KBUFFER_FL_LONG_8)
> -		kbuf->read_long = __read_long_8;
> -	else
> -		kbuf->read_long = __read_long_4;
> -
> -	/* May be changed by kbuffer_set_old_format() */
> -	kbuf->next_event = __next_event;
> -
> -	return kbuf;
> -}
> -
> -/** kbuffer_free - free an allocated kbuffer
> - * @kbuf:	The kbuffer to free
> - *
> - * Can take NULL as a parameter.
> - */
> -void kbuffer_free(struct kbuffer *kbuf)
> -{
> -	free(kbuf);
> -}
> -
> -static unsigned int type4host(struct kbuffer *kbuf,
> -			      unsigned int type_len_ts)
> -{
> -	if (kbuf->flags & KBUFFER_FL_BIG_ENDIAN)
> -		return (type_len_ts >> 29) & 3;
> -	else
> -		return type_len_ts & 3;
> -}
> -
> -static unsigned int len4host(struct kbuffer *kbuf,
> -			     unsigned int type_len_ts)
> -{
> -	if (kbuf->flags & KBUFFER_FL_BIG_ENDIAN)
> -		return (type_len_ts >> 27) & 7;
> -	else
> -		return (type_len_ts >> 2) & 7;
> -}
> -
> -static unsigned int type_len4host(struct kbuffer *kbuf,
> -				  unsigned int type_len_ts)
> -{
> -	if (kbuf->flags & KBUFFER_FL_BIG_ENDIAN)
> -		return (type_len_ts >> 27) & ((1 << 5) - 1);
> -	else
> -		return type_len_ts & ((1 << 5) - 1);
> -}
> -
> -static unsigned int ts4host(struct kbuffer *kbuf,
> -			    unsigned int type_len_ts)
> -{
> -	if (kbuf->flags & KBUFFER_FL_BIG_ENDIAN)
> -		return type_len_ts & ((1 << 27) - 1);
> -	else
> -		return type_len_ts >> 5;
> -}
> -
> -/*
> - * Linux 2.6.30 and earlier (not much ealier) had a different
> - * ring buffer format. It should be obsolete, but we handle it anyway.
> - */
> -enum old_ring_buffer_type {
> -	OLD_RINGBUF_TYPE_PADDING,
> -	OLD_RINGBUF_TYPE_TIME_EXTEND,
> -	OLD_RINGBUF_TYPE_TIME_STAMP,
> -	OLD_RINGBUF_TYPE_DATA,
> -};
> -
> -static unsigned int old_update_pointers(struct kbuffer *kbuf)
> -{
> -	unsigned long long extend;
> -	unsigned int type_len_ts;
> -	unsigned int type;
> -	unsigned int len;
> -	unsigned int delta;
> -	unsigned int length;
> -	void *ptr = kbuf->data + kbuf->curr;
> -
> -	type_len_ts = read_4(kbuf, ptr);
> -	ptr += 4;
> -
> -	type = type4host(kbuf, type_len_ts);
> -	len = len4host(kbuf, type_len_ts);
> -	delta = ts4host(kbuf, type_len_ts);
> -
> -	switch (type) {
> -	case OLD_RINGBUF_TYPE_PADDING:
> -		kbuf->next = kbuf->size;
> -		return 0;
> -
> -	case OLD_RINGBUF_TYPE_TIME_EXTEND:
> -		extend = read_4(kbuf, ptr);
> -		extend <<= TS_SHIFT;
> -		extend += delta;
> -		delta = extend;
> -		ptr += 4;
> -		length = 0;
> -		break;
> -
> -	case OLD_RINGBUF_TYPE_TIME_STAMP:
> -		/* should never happen! */
> -		kbuf->curr = kbuf->size;
> -		kbuf->next = kbuf->size;
> -		kbuf->index = kbuf->size;
> -		return -1;
> -	default:
> -		if (len)
> -			length = len * 4;
> -		else {
> -			length = read_4(kbuf, ptr);
> -			length -= 4;
> -			ptr += 4;
> -		}
> -		break;
> -	}
> -
> -	kbuf->timestamp += delta;
> -	kbuf->index = calc_index(kbuf, ptr);
> -	kbuf->next = kbuf->index + length;
> -
> -	return type;
> -}
> -
> -static int __old_next_event(struct kbuffer *kbuf)
> -{
> -	int type;
> -
> -	do {
> -		kbuf->curr = kbuf->next;
> -		if (kbuf->next >= kbuf->size)
> -			return -1;
> -		type = old_update_pointers(kbuf);
> -	} while (type == OLD_RINGBUF_TYPE_TIME_EXTEND || type == OLD_RINGBUF_TYPE_PADDING);
> -
> -	return 0;
> -}
> -
> -static unsigned int
> -translate_data(struct kbuffer *kbuf, void *data, void **rptr,
> -	       unsigned long long *delta, int *length)
> -{
> -	unsigned long long extend;
> -	unsigned int type_len_ts;
> -	unsigned int type_len;
> -
> -	type_len_ts = read_4(kbuf, data);
> -	data += 4;
> -
> -	type_len = type_len4host(kbuf, type_len_ts);
> -	*delta = ts4host(kbuf, type_len_ts);
> -
> -	switch (type_len) {
> -	case KBUFFER_TYPE_PADDING:
> -		*length = read_4(kbuf, data);
> -		break;
> -
> -	case KBUFFER_TYPE_TIME_EXTEND:
> -	case KBUFFER_TYPE_TIME_STAMP:
> -		extend = read_4(kbuf, data);
> -		data += 4;
> -		extend <<= TS_SHIFT;
> -		extend += *delta;
> -		*delta = extend;
> -		*length = 0;
> -		break;
> -
> -	case 0:
> -		*length = read_4(kbuf, data) - 4;
> -		*length = (*length + 3) & ~3;
> -		data += 4;
> -		break;
> -	default:
> -		*length = type_len * 4;
> -		break;
> -	}
> -
> -	*rptr = data;
> -
> -	return type_len;
> -}
> -
> -static unsigned int update_pointers(struct kbuffer *kbuf)
> -{
> -	unsigned long long delta;
> -	unsigned int type_len;
> -	int length;
> -	void *ptr = kbuf->data + kbuf->curr;
> -
> -	type_len = translate_data(kbuf, ptr, &ptr, &delta, &length);
> -
> -	if (type_len == KBUFFER_TYPE_TIME_STAMP)
> -		kbuf->timestamp = delta;
> -	else
> -		kbuf->timestamp += delta;
> -
> -	kbuf->index = calc_index(kbuf, ptr);
> -	kbuf->next = kbuf->index + length;
> -
> -	return type_len;
> -}
> -
> -/**
> - * kbuffer_translate_data - read raw data to get a record
> - * @swap:	Set to 1 if bytes in words need to be swapped when read
> - * @data:	The raw data to read
> - * @size:	Address to store the size of the event data.
> - *
> - * Returns a pointer to the event data. To determine the entire
> - * record size (record metadata + data) just add the difference between
> - * @data and the returned value to @size.
> - */
> -void *kbuffer_translate_data(int swap, void *data, unsigned int *size)
> -{
> -	unsigned long long delta;
> -	struct kbuffer kbuf;
> -	int type_len;
> -	int length;
> -	void *ptr;
> -
> -	if (swap) {
> -		kbuf.read_8 = __read_8_sw;
> -		kbuf.read_4 = __read_4_sw;
> -		kbuf.flags = host_is_bigendian() ? 0 : KBUFFER_FL_BIG_ENDIAN;
> -	} else {
> -		kbuf.read_8 = __read_8;
> -		kbuf.read_4 = __read_4;
> -		kbuf.flags = host_is_bigendian() ? KBUFFER_FL_BIG_ENDIAN: 0;
> -	}
> -
> -	type_len = translate_data(&kbuf, data, &ptr, &delta, &length);
> -	switch (type_len) {
> -	case KBUFFER_TYPE_PADDING:
> -	case KBUFFER_TYPE_TIME_EXTEND:
> -	case KBUFFER_TYPE_TIME_STAMP:
> -		return NULL;
> -	}
> -
> -	*size = length;
> -
> -	return ptr;
> -}
> -
> -static int __next_event(struct kbuffer *kbuf)
> -{
> -	int type;
> -
> -	do {
> -		kbuf->curr = kbuf->next;
> -		if (kbuf->next >= kbuf->size)
> -			return -1;
> -		type = update_pointers(kbuf);
> -	} while (type == KBUFFER_TYPE_TIME_EXTEND ||
> -		 type == KBUFFER_TYPE_TIME_STAMP ||
> -		 type == KBUFFER_TYPE_PADDING);
> -
> -	return 0;
> -}
> -
> -static int next_event(struct kbuffer *kbuf)
> -{
> -	return kbuf->next_event(kbuf);
> -}
> -
> -/**
> - * kbuffer_next_event - increment the current pointer
> - * @kbuf:	The kbuffer to read
> - * @ts:		Address to store the next record's timestamp (may be NULL to ignore)
> - *
> - * Increments the pointers into the subbuffer of the kbuffer to point to the
> - * next event so that the next kbuffer_read_event() will return a
> - * new event.
> - *
> - * Returns the data of the next event if a new event exists on the subbuffer,
> - * NULL otherwise.
> - */
> -void *kbuffer_next_event(struct kbuffer *kbuf, unsigned long long *ts)
> -{
> -	int ret;
> -
> -	if (!kbuf || !kbuf->subbuffer)
> -		return NULL;
> -
> -	ret = next_event(kbuf);
> -	if (ret < 0)
> -		return NULL;
> -
> -	if (ts)
> -		*ts = kbuf->timestamp;
> -
> -	return kbuf->data + kbuf->index;
> -}
> -
> -/**
> - * kbuffer_load_subbuffer - load a new subbuffer into the kbuffer
> - * @kbuf:	The kbuffer to load
> - * @subbuffer:	The subbuffer to load into @kbuf.
> - *
> - * Load a new subbuffer (page) into @kbuf. This will reset all
> - * the pointers and update the @kbuf timestamp. The next read will
> - * return the first event on @subbuffer.
> - *
> - * Returns 0 on succes, -1 otherwise.
> - */
> -int kbuffer_load_subbuffer(struct kbuffer *kbuf, void *subbuffer)
> -{
> -	unsigned long long flags;
> -	void *ptr = subbuffer;
> -
> -	if (!kbuf || !subbuffer)
> -		return -1;
> -
> -	kbuf->subbuffer = subbuffer;
> -
> -	kbuf->timestamp = read_8(kbuf, ptr);
> -	ptr += 8;
> -
> -	kbuf->curr = 0;
> -
> -	if (kbuf->flags & KBUFFER_FL_LONG_8)
> -		kbuf->start = 16;
> -	else
> -		kbuf->start = 12;
> -
> -	kbuf->data = subbuffer + kbuf->start;
> -
> -	flags = read_long(kbuf, ptr);
> -	kbuf->size = (unsigned int)flags & COMMIT_MASK;
> -
> -	if (flags & MISSING_EVENTS) {
> -		if (flags & MISSING_STORED) {
> -			ptr = kbuf->data + kbuf->size;
> -			kbuf->lost_events = read_long(kbuf, ptr);
> -		} else
> -			kbuf->lost_events = -1;
> -	} else
> -		kbuf->lost_events = 0;
> -
> -	kbuf->index = 0;
> -	kbuf->next = 0;
> -
> -	next_event(kbuf);
> -
> -	return 0;
> -}
> -
> -/**
> - * kbuffer_subbuf_timestamp - read the timestamp from a sub buffer
> - * @kbuf:      The kbuffer to load
> - * @subbuf:    The subbuffer to read from.
> - *
> - * Return the timestamp from a subbuffer.
> - */
> -unsigned long long kbuffer_subbuf_timestamp(struct kbuffer *kbuf, void *subbuf)
> -{
> -	return kbuf->read_8(subbuf);
> -}
> -
> -/**
> - * kbuffer_ptr_delta - read the delta field from a record
> - * @kbuf:      The kbuffer to load
> - * @ptr:       The record in the buffe.
> - *
> - * Return the timestamp delta from a record
> - */
> -unsigned int kbuffer_ptr_delta(struct kbuffer *kbuf, void *ptr)
> -{
> -	unsigned int type_len_ts;
> -
> -	type_len_ts = read_4(kbuf, ptr);
> -	return ts4host(kbuf, type_len_ts);
> -}
> -
> -
> -/**
> - * kbuffer_read_event - read the next event in the kbuffer subbuffer
> - * @kbuf:	The kbuffer to read from
> - * @ts:		The address to store the timestamp of the event (may be NULL to ignore)
> - *
> - * Returns a pointer to the data part of the current event.
> - * NULL if no event is left on the subbuffer.
> - */
> -void *kbuffer_read_event(struct kbuffer *kbuf, unsigned long long *ts)
> -{
> -	if (!kbuf || !kbuf->subbuffer)
> -		return NULL;
> -
> -	if (kbuf->curr >= kbuf->size)
> -		return NULL;
> -
> -	if (ts)
> -		*ts = kbuf->timestamp;
> -	return kbuf->data + kbuf->index;
> -}
> -
> -/**
> - * kbuffer_timestamp - Return the timestamp of the current event
> - * @kbuf:	The kbuffer to read from
> - *
> - * Returns the timestamp of the current (next) event.
> - */
> -unsigned long long kbuffer_timestamp(struct kbuffer *kbuf)
> -{
> -	return kbuf->timestamp;
> -}
> -
> -/**
> - * kbuffer_read_at_offset - read the event that is at offset
> - * @kbuf:	The kbuffer to read from
> - * @offset:	The offset into the subbuffer
> - * @ts:		The address to store the timestamp of the event (may be NULL to ignore)
> - *
> - * The @offset must be an index from the @kbuf subbuffer beginning.
> - * If @offset is bigger than the stored subbuffer, NULL will be returned.
> - *
> - * Returns the data of the record that is at @offset. Note, @offset does
> - * not need to be the start of the record, the offset just needs to be
> - * in the record (or beginning of it).
> - *
> - * Note, the kbuf timestamp and pointers are updated to the
> - * returned record. That is, kbuffer_read_event() will return the same
> - * data and timestamp, and kbuffer_next_event() will increment from
> - * this record.
> - */
> -void *kbuffer_read_at_offset(struct kbuffer *kbuf, int offset,
> -			     unsigned long long *ts)
> -{
> -	void *data;
> -
> -	if (offset < kbuf->start)
> -		offset = 0;
> -	else
> -		offset -= kbuf->start;
> -
> -	/* Reset the buffer */
> -	kbuffer_load_subbuffer(kbuf, kbuf->subbuffer);
> -	data = kbuffer_read_event(kbuf, ts);
> -
> -	while (kbuf->curr < offset) {
> -		data = kbuffer_next_event(kbuf, ts);
> -		if (!data)
> -			break;
> -	}
> -
> -	return data;
> -}
> -
> -/**
> - * kbuffer_subbuffer_size - the size of the loaded subbuffer
> - * @kbuf:	The kbuffer to read from
> - *
> - * Returns the size of the subbuffer. Note, this size is
> - * where the last event resides. The stored subbuffer may actually be
> - * bigger due to padding and such.
> - */
> -int kbuffer_subbuffer_size(struct kbuffer *kbuf)
> -{
> -	return kbuf->size;
> -}
> -
> -/**
> - * kbuffer_curr_index - Return the index of the record
> - * @kbuf:	The kbuffer to read from
> - *
> - * Returns the index from the start of the data part of
> - * the subbuffer to the current location. Note this is not
> - * from the start of the subbuffer. An index of zero will
> - * point to the first record. Use kbuffer_curr_offset() for
> - * the actually offset (that can be used by kbuffer_read_at_offset())
> - */
> -int kbuffer_curr_index(struct kbuffer *kbuf)
> -{
> -	return kbuf->curr;
> -}
> -
> -/**
> - * kbuffer_curr_offset - Return the offset of the record
> - * @kbuf:	The kbuffer to read from
> - *
> - * Returns the offset from the start of the subbuffer to the
> - * current location.
> - */
> -int kbuffer_curr_offset(struct kbuffer *kbuf)
> -{
> -	return kbuf->curr + kbuf->start;
> -}
> -
> -/**
> - * kbuffer_event_size - return the size of the event data
> - * @kbuf:	The kbuffer to read
> - *
> - * Returns the size of the event data (the payload not counting
> - * the meta data of the record) of the current event.
> - */
> -int kbuffer_event_size(struct kbuffer *kbuf)
> -{
> -	return kbuf->next - kbuf->index;
> -}
> -
> -/**
> - * kbuffer_curr_size - return the size of the entire record
> - * @kbuf:	The kbuffer to read
> - *
> - * Returns the size of the entire record (meta data and payload)
> - * of the current event.
> - */
> -int kbuffer_curr_size(struct kbuffer *kbuf)
> -{
> -	return kbuf->next - kbuf->curr;
> -}
> -
> -/**
> - * kbuffer_missed_events - return the # of missed events from last event.
> - * @kbuf: 	The kbuffer to read from
> - *
> - * Returns the # of missed events (if recorded) before the current
> - * event. Note, only events on the beginning of a subbuffer can
> - * have missed events, all other events within the buffer will be
> - * zero.
> - */
> -int kbuffer_missed_events(struct kbuffer *kbuf)
> -{
> -	/* Only the first event can have missed events */
> -	if (kbuf->curr)
> -		return 0;
> -
> -	return kbuf->lost_events;
> -}
> -
> -/**
> - * kbuffer_set_old_forma - set the kbuffer to use the old format parsing
> - * @kbuf:	The kbuffer to set
> - *
> - * This is obsolete (or should be). The first kernels to use the
> - * new ring buffer had a slightly different ring buffer format
> - * (2.6.30 and earlier). It is still somewhat supported by kbuffer,
> - * but should not be counted on in the future.
> - */
> -void kbuffer_set_old_format(struct kbuffer *kbuf)
> -{
> -	kbuf->flags |= KBUFFER_FL_OLD_FORMAT;
> -
> -	kbuf->next_event = __old_next_event;
> -}
> -
> -/**
> - * kbuffer_start_of_data - return offset of where data starts on subbuffer
> - * @kbuf:	The kbuffer
> - *
> - * Returns the location on the subbuffer where the data starts.
> - */
> -int kbuffer_start_of_data(struct kbuffer *kbuf)
> -{
> -	return kbuf->start;
> -}
> -
> -/**
> - * kbuffer_raw_get - get raw buffer info
> - * @kbuf:	The kbuffer
> - * @subbuf:	Start of mapped subbuffer
> - * @info:	Info descriptor to fill in
> - *
> - * For debugging. This can return internals of the ring buffer.
> - * Expects to have info->next set to what it will read.
> - * The type, length and timestamp delta will be filled in, and
> - * @info->next will be updated to the next element.
> - * The @subbuf is used to know if the info is passed the end of
> - * data and NULL will be returned if it is.
> - */
> -struct kbuffer_raw_info *
> -kbuffer_raw_get(struct kbuffer *kbuf, void *subbuf, struct kbuffer_raw_info *info)
> -{
> -	unsigned long long flags;
> -	unsigned long long delta;
> -	unsigned int type_len;
> -	unsigned int size;
> -	int start;
> -	int length;
> -	void *ptr = info->next;
> -
> -	if (!kbuf || !subbuf)
> -		return NULL;
> -
> -	if (kbuf->flags & KBUFFER_FL_LONG_8)
> -		start = 16;
> -	else
> -		start = 12;
> -
> -	flags = read_long(kbuf, subbuf + 8);
> -	size = (unsigned int)flags & COMMIT_MASK;
> -
> -	if (ptr < subbuf || ptr >= subbuf + start + size)
> -		return NULL;
> -
> -	type_len = translate_data(kbuf, ptr, &ptr, &delta, &length);
> -
> -	info->next = ptr + length;
> -
> -	info->type = type_len;
> -	info->delta = delta;
> -	info->length = length;
> -
> -	return info;
> -}
> diff --git a/tools/lib/traceevent/kbuffer.h b/tools/lib/traceevent/kbuffer.h
> deleted file mode 100644
> index a2b522093cfd..000000000000
> --- a/tools/lib/traceevent/kbuffer.h
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -/* SPDX-License-Identifier: LGPL-2.1 */
> -/*
> - * Copyright (C) 2012 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - *
> - */
> -#ifndef _KBUFFER_H
> -#define _KBUFFER_H
> -
> -#ifndef TS_SHIFT
> -#define TS_SHIFT		27
> -#endif
> -
> -enum kbuffer_endian {
> -	KBUFFER_ENDIAN_BIG,
> -	KBUFFER_ENDIAN_LITTLE,
> -};
> -
> -enum kbuffer_long_size {
> -	KBUFFER_LSIZE_4,
> -	KBUFFER_LSIZE_8,
> -};
> -
> -enum {
> -	KBUFFER_TYPE_PADDING		= 29,
> -	KBUFFER_TYPE_TIME_EXTEND	= 30,
> -	KBUFFER_TYPE_TIME_STAMP		= 31,
> -};
> -
> -struct kbuffer;
> -
> -struct kbuffer *kbuffer_alloc(enum kbuffer_long_size size, enum kbuffer_endian endian);
> -void kbuffer_free(struct kbuffer *kbuf);
> -int kbuffer_load_subbuffer(struct kbuffer *kbuf, void *subbuffer);
> -void *kbuffer_read_event(struct kbuffer *kbuf, unsigned long long *ts);
> -void *kbuffer_next_event(struct kbuffer *kbuf, unsigned long long *ts);
> -unsigned long long kbuffer_timestamp(struct kbuffer *kbuf);
> -unsigned long long kbuffer_subbuf_timestamp(struct kbuffer *kbuf, void *subbuf);
> -unsigned int kbuffer_ptr_delta(struct kbuffer *kbuf, void *ptr);
> -
> -void *kbuffer_translate_data(int swap, void *data, unsigned int *size);
> -
> -void *kbuffer_read_at_offset(struct kbuffer *kbuf, int offset, unsigned long long *ts);
> -
> -int kbuffer_curr_index(struct kbuffer *kbuf);
> -
> -int kbuffer_curr_offset(struct kbuffer *kbuf);
> -int kbuffer_curr_size(struct kbuffer *kbuf);
> -int kbuffer_event_size(struct kbuffer *kbuf);
> -int kbuffer_missed_events(struct kbuffer *kbuf);
> -int kbuffer_subbuffer_size(struct kbuffer *kbuf);
> -
> -void kbuffer_set_old_format(struct kbuffer *kbuf);
> -int kbuffer_start_of_data(struct kbuffer *kbuf);
> -
> -/* Debugging */
> -
> -struct kbuffer_raw_info {
> -	int			type;
> -	int			length;
> -	unsigned long long	delta;
> -	void			*next;
> -};
> -
> -/* Read raw data */
> -struct kbuffer_raw_info *kbuffer_raw_get(struct kbuffer *kbuf, void *subbuf,
> -					 struct kbuffer_raw_info *info);
> -
> -#endif /* _K_BUFFER_H */
> diff --git a/tools/lib/traceevent/libtraceevent.pc.template b/tools/lib/traceevent/libtraceevent.pc.template
> deleted file mode 100644
> index 86384fcd57f1..000000000000
> --- a/tools/lib/traceevent/libtraceevent.pc.template
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -prefix=INSTALL_PREFIX
> -libdir=LIB_DIR
> -includedir=HEADER_DIR
> -
> -Name: libtraceevent
> -URL: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> -Description: Linux kernel trace event library
> -Version: LIB_VERSION
> -Cflags: -I${includedir}
> -Libs: -L${libdir} -ltraceevent
> diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
> deleted file mode 100644
> index 5df177070d53..000000000000
> --- a/tools/lib/traceevent/parse-filter.c
> +++ /dev/null
> @@ -1,2281 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - *
> - */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <stdarg.h>
> -#include <errno.h>
> -#include <sys/types.h>
> -
> -#include "event-parse.h"
> -#include "event-parse-local.h"
> -#include "event-utils.h"
> -
> -#define COMM "COMM"
> -#define CPU "CPU"
> -
> -static struct tep_format_field comm = {
> -	.name = "COMM",
> -};
> -
> -static struct tep_format_field cpu = {
> -	.name = "CPU",
> -};
> -
> -struct event_list {
> -	struct event_list	*next;
> -	struct tep_event	*event;
> -};
> -
> -static void show_error(char *error_buf, const char *fmt, ...)
> -{
> -	unsigned long long index;
> -	const char *input;
> -	va_list ap;
> -	int len;
> -	int i;
> -
> -	input = get_input_buf();
> -	index = get_input_buf_ptr();
> -	len = input ? strlen(input) : 0;
> -
> -	if (len) {
> -		strcpy(error_buf, input);
> -		error_buf[len] = '\n';
> -		for (i = 1; i < len && i < index; i++)
> -			error_buf[len+i] = ' ';
> -		error_buf[len + i] = '^';
> -		error_buf[len + i + 1] = '\n';
> -		len += i+2;
> -	}
> -
> -	va_start(ap, fmt);
> -	vsnprintf(error_buf + len, TEP_FILTER_ERROR_BUFSZ - len, fmt, ap);
> -	va_end(ap);
> -}
> -
> -static enum tep_event_type filter_read_token(char **tok)
> -{
> -	enum tep_event_type type;
> -	char *token = NULL;
> -
> -	do {
> -		free_token(token);
> -		type = read_token(&token);
> -	} while (type == TEP_EVENT_NEWLINE || type == TEP_EVENT_SPACE);
> -
> -	/* If token is = or ! check to see if the next char is ~ */
> -	if (token &&
> -	    (strcmp(token, "=") == 0 || strcmp(token, "!") == 0) &&
> -	    peek_char() == '~') {
> -		/* append it */
> -		*tok = malloc(3);
> -		if (*tok == NULL) {
> -			free_token(token);
> -			return TEP_EVENT_ERROR;
> -		}
> -		sprintf(*tok, "%c%c", *token, '~');
> -		free_token(token);
> -		/* Now remove the '~' from the buffer */
> -		read_token(&token);
> -		free_token(token);
> -	} else
> -		*tok = token;
> -
> -	return type;
> -}
> -
> -static int filter_cmp(const void *a, const void *b)
> -{
> -	const struct tep_filter_type *ea = a;
> -	const struct tep_filter_type *eb = b;
> -
> -	if (ea->event_id < eb->event_id)
> -		return -1;
> -
> -	if (ea->event_id > eb->event_id)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static struct tep_filter_type *
> -find_filter_type(struct tep_event_filter *filter, int id)
> -{
> -	struct tep_filter_type *filter_type;
> -	struct tep_filter_type key;
> -
> -	key.event_id = id;
> -
> -	filter_type = bsearch(&key, filter->event_filters,
> -			      filter->filters,
> -			      sizeof(*filter->event_filters),
> -			      filter_cmp);
> -
> -	return filter_type;
> -}
> -
> -static struct tep_filter_type *
> -add_filter_type(struct tep_event_filter *filter, int id)
> -{
> -	struct tep_filter_type *filter_type;
> -	int i;
> -
> -	filter_type = find_filter_type(filter, id);
> -	if (filter_type)
> -		return filter_type;
> -
> -	filter_type = realloc(filter->event_filters,
> -			      sizeof(*filter->event_filters) *
> -			      (filter->filters + 1));
> -	if (!filter_type)
> -		return NULL;
> -
> -	filter->event_filters = filter_type;
> -
> -	for (i = 0; i < filter->filters; i++) {
> -		if (filter->event_filters[i].event_id > id)
> -			break;
> -	}
> -
> -	if (i < filter->filters)
> -		memmove(&filter->event_filters[i+1],
> -			&filter->event_filters[i],
> -			sizeof(*filter->event_filters) *
> -			(filter->filters - i));
> -
> -	filter_type = &filter->event_filters[i];
> -	filter_type->event_id = id;
> -	filter_type->event = tep_find_event(filter->tep, id);
> -	filter_type->filter = NULL;
> -
> -	filter->filters++;
> -
> -	return filter_type;
> -}
> -
> -/**
> - * tep_filter_alloc - create a new event filter
> - * @tep: The tep that this filter is associated with
> - */
> -struct tep_event_filter *tep_filter_alloc(struct tep_handle *tep)
> -{
> -	struct tep_event_filter *filter;
> -
> -	filter = malloc(sizeof(*filter));
> -	if (filter == NULL)
> -		return NULL;
> -
> -	memset(filter, 0, sizeof(*filter));
> -	filter->tep = tep;
> -	tep_ref(tep);
> -
> -	return filter;
> -}
> -
> -static struct tep_filter_arg *allocate_arg(void)
> -{
> -	return calloc(1, sizeof(struct tep_filter_arg));
> -}
> -
> -static void free_arg(struct tep_filter_arg *arg)
> -{
> -	if (!arg)
> -		return;
> -
> -	switch (arg->type) {
> -	case TEP_FILTER_ARG_NONE:
> -	case TEP_FILTER_ARG_BOOLEAN:
> -		break;
> -
> -	case TEP_FILTER_ARG_NUM:
> -		free_arg(arg->num.left);
> -		free_arg(arg->num.right);
> -		break;
> -
> -	case TEP_FILTER_ARG_EXP:
> -		free_arg(arg->exp.left);
> -		free_arg(arg->exp.right);
> -		break;
> -
> -	case TEP_FILTER_ARG_STR:
> -		free(arg->str.val);
> -		regfree(&arg->str.reg);
> -		free(arg->str.buffer);
> -		break;
> -
> -	case TEP_FILTER_ARG_VALUE:
> -		if (arg->value.type == TEP_FILTER_STRING ||
> -		    arg->value.type == TEP_FILTER_CHAR)
> -			free(arg->value.str);
> -		break;
> -
> -	case TEP_FILTER_ARG_OP:
> -		free_arg(arg->op.left);
> -		free_arg(arg->op.right);
> -	default:
> -		break;
> -	}
> -
> -	free(arg);
> -}
> -
> -static int add_event(struct event_list **events,
> -		     struct tep_event *event)
> -{
> -	struct event_list *list;
> -
> -	list = malloc(sizeof(*list));
> -	if (list == NULL)
> -		return -1;
> -
> -	list->next = *events;
> -	*events = list;
> -	list->event = event;
> -	return 0;
> -}
> -
> -static int event_match(struct tep_event *event,
> -		       regex_t *sreg, regex_t *ereg)
> -{
> -	if (sreg) {
> -		return !regexec(sreg, event->system, 0, NULL, 0) &&
> -			!regexec(ereg, event->name, 0, NULL, 0);
> -	}
> -
> -	return !regexec(ereg, event->system, 0, NULL, 0) ||
> -		!regexec(ereg, event->name, 0, NULL, 0);
> -}
> -
> -static enum tep_errno
> -find_event(struct tep_handle *tep, struct event_list **events,
> -	   char *sys_name, char *event_name)
> -{
> -	struct tep_event *event;
> -	regex_t ereg;
> -	regex_t sreg;
> -	int match = 0;
> -	int fail = 0;
> -	char *reg;
> -	int ret;
> -	int i;
> -
> -	if (!event_name) {
> -		/* if no name is given, then swap sys and name */
> -		event_name = sys_name;
> -		sys_name = NULL;
> -	}
> -
> -	ret = asprintf(&reg, "^%s$", event_name);
> -	if (ret < 0)
> -		return TEP_ERRNO__MEM_ALLOC_FAILED;
> -
> -	ret = regcomp(&ereg, reg, REG_ICASE|REG_NOSUB);
> -	free(reg);
> -
> -	if (ret)
> -		return TEP_ERRNO__INVALID_EVENT_NAME;
> -
> -	if (sys_name) {
> -		ret = asprintf(&reg, "^%s$", sys_name);
> -		if (ret < 0) {
> -			regfree(&ereg);
> -			return TEP_ERRNO__MEM_ALLOC_FAILED;
> -		}
> -
> -		ret = regcomp(&sreg, reg, REG_ICASE|REG_NOSUB);
> -		free(reg);
> -		if (ret) {
> -			regfree(&ereg);
> -			return TEP_ERRNO__INVALID_EVENT_NAME;
> -		}
> -	}
> -
> -	for (i = 0; i < tep->nr_events; i++) {
> -		event = tep->events[i];
> -		if (event_match(event, sys_name ? &sreg : NULL, &ereg)) {
> -			match = 1;
> -			if (add_event(events, event) < 0) {
> -				fail = 1;
> -				break;
> -			}
> -		}
> -	}
> -
> -	regfree(&ereg);
> -	if (sys_name)
> -		regfree(&sreg);
> -
> -	if (!match)
> -		return TEP_ERRNO__EVENT_NOT_FOUND;
> -	if (fail)
> -		return TEP_ERRNO__MEM_ALLOC_FAILED;
> -
> -	return 0;
> -}
> -
> -static void free_events(struct event_list *events)
> -{
> -	struct event_list *event;
> -
> -	while (events) {
> -		event = events;
> -		events = events->next;
> -		free(event);
> -	}
> -}
> -
> -static enum tep_errno
> -create_arg_item(struct tep_event *event, const char *token,
> -		enum tep_event_type type, struct tep_filter_arg **parg, char *error_str)
> -{
> -	struct tep_format_field *field;
> -	struct tep_filter_arg *arg;
> -
> -	arg = allocate_arg();
> -	if (arg == NULL) {
> -		show_error(error_str, "failed to allocate filter arg");
> -		return TEP_ERRNO__MEM_ALLOC_FAILED;
> -	}
> -
> -	switch (type) {
> -
> -	case TEP_EVENT_SQUOTE:
> -	case TEP_EVENT_DQUOTE:
> -		arg->type = TEP_FILTER_ARG_VALUE;
> -		arg->value.type =
> -			type == TEP_EVENT_DQUOTE ? TEP_FILTER_STRING : TEP_FILTER_CHAR;
> -		arg->value.str = strdup(token);
> -		if (!arg->value.str) {
> -			free_arg(arg);
> -			show_error(error_str, "failed to allocate string filter arg");
> -			return TEP_ERRNO__MEM_ALLOC_FAILED;
> -		}
> -		break;
> -	case TEP_EVENT_ITEM:
> -		/* if it is a number, then convert it */
> -		if (isdigit(token[0])) {
> -			arg->type = TEP_FILTER_ARG_VALUE;
> -			arg->value.type = TEP_FILTER_NUMBER;
> -			arg->value.val = strtoull(token, NULL, 0);
> -			break;
> -		}
> -		/* Consider this a field */
> -		field = tep_find_any_field(event, token);
> -		if (!field) {
> -			/* If token is 'COMM' or 'CPU' then it is special */
> -			if (strcmp(token, COMM) == 0) {
> -				field = &comm;
> -			} else if (strcmp(token, CPU) == 0) {
> -				field = &cpu;
> -			} else {
> -				/* not a field, Make it false */
> -				arg->type = TEP_FILTER_ARG_BOOLEAN;
> -				arg->boolean.value = TEP_FILTER_FALSE;
> -				break;
> -			}
> -		}
> -		arg->type = TEP_FILTER_ARG_FIELD;
> -		arg->field.field = field;
> -		break;
> -	default:
> -		free_arg(arg);
> -		show_error(error_str, "expected a value but found %s", token);
> -		return TEP_ERRNO__UNEXPECTED_TYPE;
> -	}
> -	*parg = arg;
> -	return 0;
> -}
> -
> -static struct tep_filter_arg *
> -create_arg_op(enum tep_filter_op_type btype)
> -{
> -	struct tep_filter_arg *arg;
> -
> -	arg = allocate_arg();
> -	if (!arg)
> -		return NULL;
> -
> -	arg->type = TEP_FILTER_ARG_OP;
> -	arg->op.type = btype;
> -
> -	return arg;
> -}
> -
> -static struct tep_filter_arg *
> -create_arg_exp(enum tep_filter_exp_type etype)
> -{
> -	struct tep_filter_arg *arg;
> -
> -	arg = allocate_arg();
> -	if (!arg)
> -		return NULL;
> -
> -	arg->type = TEP_FILTER_ARG_EXP;
> -	arg->exp.type = etype;
> -
> -	return arg;
> -}
> -
> -static struct tep_filter_arg *
> -create_arg_cmp(enum tep_filter_cmp_type ctype)
> -{
> -	struct tep_filter_arg *arg;
> -
> -	arg = allocate_arg();
> -	if (!arg)
> -		return NULL;
> -
> -	/* Use NUM and change if necessary */
> -	arg->type = TEP_FILTER_ARG_NUM;
> -	arg->num.type = ctype;
> -
> -	return arg;
> -}
> -
> -static enum tep_errno
> -add_right(struct tep_filter_arg *op, struct tep_filter_arg *arg, char *error_str)
> -{
> -	struct tep_filter_arg *left;
> -	char *str;
> -	int op_type;
> -	int ret;
> -
> -	switch (op->type) {
> -	case TEP_FILTER_ARG_EXP:
> -		if (op->exp.right)
> -			goto out_fail;
> -		op->exp.right = arg;
> -		break;
> -
> -	case TEP_FILTER_ARG_OP:
> -		if (op->op.right)
> -			goto out_fail;
> -		op->op.right = arg;
> -		break;
> -
> -	case TEP_FILTER_ARG_NUM:
> -		if (op->op.right)
> -			goto out_fail;
> -		/*
> -		 * The arg must be num, str, or field
> -		 */
> -		switch (arg->type) {
> -		case TEP_FILTER_ARG_VALUE:
> -		case TEP_FILTER_ARG_FIELD:
> -			break;
> -		default:
> -			show_error(error_str, "Illegal rvalue");
> -			return TEP_ERRNO__ILLEGAL_RVALUE;
> -		}
> -
> -		/*
> -		 * Depending on the type, we may need to
> -		 * convert this to a string or regex.
> -		 */
> -		switch (arg->value.type) {
> -		case TEP_FILTER_CHAR:
> -			/*
> -			 * A char should be converted to number if
> -			 * the string is 1 byte, and the compare
> -			 * is not a REGEX.
> -			 */
> -			if (strlen(arg->value.str) == 1 &&
> -			    op->num.type != TEP_FILTER_CMP_REGEX &&
> -			    op->num.type != TEP_FILTER_CMP_NOT_REGEX) {
> -				arg->value.type = TEP_FILTER_NUMBER;
> -				goto do_int;
> -			}
> -			/* fall through */
> -		case TEP_FILTER_STRING:
> -
> -			/* convert op to a string arg */
> -			op_type = op->num.type;
> -			left = op->num.left;
> -			str = arg->value.str;
> -
> -			/* reset the op for the new field */
> -			memset(op, 0, sizeof(*op));
> -
> -			/*
> -			 * If left arg was a field not found then
> -			 * NULL the entire op.
> -			 */
> -			if (left->type == TEP_FILTER_ARG_BOOLEAN) {
> -				free_arg(left);
> -				free_arg(arg);
> -				op->type = TEP_FILTER_ARG_BOOLEAN;
> -				op->boolean.value = TEP_FILTER_FALSE;
> -				break;
> -			}
> -
> -			/* Left arg must be a field */
> -			if (left->type != TEP_FILTER_ARG_FIELD) {
> -				show_error(error_str,
> -					   "Illegal lvalue for string comparison");
> -				return TEP_ERRNO__ILLEGAL_LVALUE;
> -			}
> -
> -			/* Make sure this is a valid string compare */
> -			switch (op_type) {
> -			case TEP_FILTER_CMP_EQ:
> -				op_type = TEP_FILTER_CMP_MATCH;
> -				break;
> -			case TEP_FILTER_CMP_NE:
> -				op_type = TEP_FILTER_CMP_NOT_MATCH;
> -				break;
> -
> -			case TEP_FILTER_CMP_REGEX:
> -			case TEP_FILTER_CMP_NOT_REGEX:
> -				ret = regcomp(&op->str.reg, str, REG_ICASE|REG_NOSUB);
> -				if (ret) {
> -					show_error(error_str,
> -						   "RegEx '%s' did not compute",
> -						   str);
> -					return TEP_ERRNO__INVALID_REGEX;
> -				}
> -				break;
> -			default:
> -				show_error(error_str,
> -					   "Illegal comparison for string");
> -				return TEP_ERRNO__ILLEGAL_STRING_CMP;
> -			}
> -
> -			op->type = TEP_FILTER_ARG_STR;
> -			op->str.type = op_type;
> -			op->str.field = left->field.field;
> -			op->str.val = strdup(str);
> -			if (!op->str.val) {
> -				show_error(error_str, "Failed to allocate string filter");
> -				return TEP_ERRNO__MEM_ALLOC_FAILED;
> -			}
> -			/*
> -			 * Need a buffer to copy data for tests
> -			 */
> -			op->str.buffer = malloc(op->str.field->size + 1);
> -			if (!op->str.buffer) {
> -				show_error(error_str, "Failed to allocate string filter");
> -				return TEP_ERRNO__MEM_ALLOC_FAILED;
> -			}
> -			/* Null terminate this buffer */
> -			op->str.buffer[op->str.field->size] = 0;
> -
> -			/* We no longer have left or right args */
> -			free_arg(arg);
> -			free_arg(left);
> -
> -			break;
> -
> -		case TEP_FILTER_NUMBER:
> -
> - do_int:
> -			switch (op->num.type) {
> -			case TEP_FILTER_CMP_REGEX:
> -			case TEP_FILTER_CMP_NOT_REGEX:
> -				show_error(error_str,
> -					   "Op not allowed with integers");
> -				return TEP_ERRNO__ILLEGAL_INTEGER_CMP;
> -
> -			default:
> -				break;
> -			}
> -
> -			/* numeric compare */
> -			op->num.right = arg;
> -			break;
> -		default:
> -			goto out_fail;
> -		}
> -		break;
> -	default:
> -		goto out_fail;
> -	}
> -
> -	return 0;
> -
> - out_fail:
> -	show_error(error_str, "Syntax error");
> -	return TEP_ERRNO__SYNTAX_ERROR;
> -}
> -
> -static struct tep_filter_arg *
> -rotate_op_right(struct tep_filter_arg *a, struct tep_filter_arg *b)
> -{
> -	struct tep_filter_arg *arg;
> -
> -	arg = a->op.right;
> -	a->op.right = b;
> -	return arg;
> -}
> -
> -static enum tep_errno add_left(struct tep_filter_arg *op, struct tep_filter_arg *arg)
> -{
> -	switch (op->type) {
> -	case TEP_FILTER_ARG_EXP:
> -		if (arg->type == TEP_FILTER_ARG_OP)
> -			arg = rotate_op_right(arg, op);
> -		op->exp.left = arg;
> -		break;
> -
> -	case TEP_FILTER_ARG_OP:
> -		op->op.left = arg;
> -		break;
> -	case TEP_FILTER_ARG_NUM:
> -		if (arg->type == TEP_FILTER_ARG_OP)
> -			arg = rotate_op_right(arg, op);
> -
> -		/* left arg of compares must be a field */
> -		if (arg->type != TEP_FILTER_ARG_FIELD &&
> -		    arg->type != TEP_FILTER_ARG_BOOLEAN)
> -			return TEP_ERRNO__INVALID_ARG_TYPE;
> -		op->num.left = arg;
> -		break;
> -	default:
> -		return TEP_ERRNO__INVALID_ARG_TYPE;
> -	}
> -	return 0;
> -}
> -
> -enum op_type {
> -	OP_NONE,
> -	OP_BOOL,
> -	OP_NOT,
> -	OP_EXP,
> -	OP_CMP,
> -};
> -
> -static enum op_type process_op(const char *token,
> -			       enum tep_filter_op_type *btype,
> -			       enum tep_filter_cmp_type *ctype,
> -			       enum tep_filter_exp_type *etype)
> -{
> -	*btype = TEP_FILTER_OP_NOT;
> -	*etype = TEP_FILTER_EXP_NONE;
> -	*ctype = TEP_FILTER_CMP_NONE;
> -
> -	if (strcmp(token, "&&") == 0)
> -		*btype = TEP_FILTER_OP_AND;
> -	else if (strcmp(token, "||") == 0)
> -		*btype = TEP_FILTER_OP_OR;
> -	else if (strcmp(token, "!") == 0)
> -		return OP_NOT;
> -
> -	if (*btype != TEP_FILTER_OP_NOT)
> -		return OP_BOOL;
> -
> -	/* Check for value expressions */
> -	if (strcmp(token, "+") == 0) {
> -		*etype = TEP_FILTER_EXP_ADD;
> -	} else if (strcmp(token, "-") == 0) {
> -		*etype = TEP_FILTER_EXP_SUB;
> -	} else if (strcmp(token, "*") == 0) {
> -		*etype = TEP_FILTER_EXP_MUL;
> -	} else if (strcmp(token, "/") == 0) {
> -		*etype = TEP_FILTER_EXP_DIV;
> -	} else if (strcmp(token, "%") == 0) {
> -		*etype = TEP_FILTER_EXP_MOD;
> -	} else if (strcmp(token, ">>") == 0) {
> -		*etype = TEP_FILTER_EXP_RSHIFT;
> -	} else if (strcmp(token, "<<") == 0) {
> -		*etype = TEP_FILTER_EXP_LSHIFT;
> -	} else if (strcmp(token, "&") == 0) {
> -		*etype = TEP_FILTER_EXP_AND;
> -	} else if (strcmp(token, "|") == 0) {
> -		*etype = TEP_FILTER_EXP_OR;
> -	} else if (strcmp(token, "^") == 0) {
> -		*etype = TEP_FILTER_EXP_XOR;
> -	} else if (strcmp(token, "~") == 0)
> -		*etype = TEP_FILTER_EXP_NOT;
> -
> -	if (*etype != TEP_FILTER_EXP_NONE)
> -		return OP_EXP;
> -
> -	/* Check for compares */
> -	if (strcmp(token, "==") == 0)
> -		*ctype = TEP_FILTER_CMP_EQ;
> -	else if (strcmp(token, "!=") == 0)
> -		*ctype = TEP_FILTER_CMP_NE;
> -	else if (strcmp(token, "<") == 0)
> -		*ctype = TEP_FILTER_CMP_LT;
> -	else if (strcmp(token, ">") == 0)
> -		*ctype = TEP_FILTER_CMP_GT;
> -	else if (strcmp(token, "<=") == 0)
> -		*ctype = TEP_FILTER_CMP_LE;
> -	else if (strcmp(token, ">=") == 0)
> -		*ctype = TEP_FILTER_CMP_GE;
> -	else if (strcmp(token, "=~") == 0)
> -		*ctype = TEP_FILTER_CMP_REGEX;
> -	else if (strcmp(token, "!~") == 0)
> -		*ctype = TEP_FILTER_CMP_NOT_REGEX;
> -	else
> -		return OP_NONE;
> -
> -	return OP_CMP;
> -}
> -
> -static int check_op_done(struct tep_filter_arg *arg)
> -{
> -	switch (arg->type) {
> -	case TEP_FILTER_ARG_EXP:
> -		return arg->exp.right != NULL;
> -
> -	case TEP_FILTER_ARG_OP:
> -		return arg->op.right != NULL;
> -
> -	case TEP_FILTER_ARG_NUM:
> -		return arg->num.right != NULL;
> -
> -	case TEP_FILTER_ARG_STR:
> -		/* A string conversion is always done */
> -		return 1;
> -
> -	case TEP_FILTER_ARG_BOOLEAN:
> -		/* field not found, is ok */
> -		return 1;
> -
> -	default:
> -		return 0;
> -	}
> -}
> -
> -enum filter_vals {
> -	FILTER_VAL_NORM,
> -	FILTER_VAL_FALSE,
> -	FILTER_VAL_TRUE,
> -};
> -
> -static enum tep_errno
> -reparent_op_arg(struct tep_filter_arg *parent, struct tep_filter_arg *old_child,
> -		struct tep_filter_arg *arg, char *error_str)
> -{
> -	struct tep_filter_arg *other_child;
> -	struct tep_filter_arg **ptr;
> -
> -	if (parent->type != TEP_FILTER_ARG_OP &&
> -	    arg->type != TEP_FILTER_ARG_OP) {
> -		show_error(error_str, "can not reparent other than OP");
> -		return TEP_ERRNO__REPARENT_NOT_OP;
> -	}
> -
> -	/* Get the sibling */
> -	if (old_child->op.right == arg) {
> -		ptr = &old_child->op.right;
> -		other_child = old_child->op.left;
> -	} else if (old_child->op.left == arg) {
> -		ptr = &old_child->op.left;
> -		other_child = old_child->op.right;
> -	} else {
> -		show_error(error_str, "Error in reparent op, find other child");
> -		return TEP_ERRNO__REPARENT_FAILED;
> -	}
> -
> -	/* Detach arg from old_child */
> -	*ptr = NULL;
> -
> -	/* Check for root */
> -	if (parent == old_child) {
> -		free_arg(other_child);
> -		*parent = *arg;
> -		/* Free arg without recussion */
> -		free(arg);
> -		return 0;
> -	}
> -
> -	if (parent->op.right == old_child)
> -		ptr = &parent->op.right;
> -	else if (parent->op.left == old_child)
> -		ptr = &parent->op.left;
> -	else {
> -		show_error(error_str, "Error in reparent op");
> -		return TEP_ERRNO__REPARENT_FAILED;
> -	}
> -
> -	*ptr = arg;
> -
> -	free_arg(old_child);
> -	return 0;
> -}
> -
> -/* Returns either filter_vals (success) or tep_errno (failfure) */
> -static int test_arg(struct tep_filter_arg *parent, struct tep_filter_arg *arg,
> -		    char *error_str)
> -{
> -	int lval, rval;
> -
> -	switch (arg->type) {
> -
> -		/* bad case */
> -	case TEP_FILTER_ARG_BOOLEAN:
> -		return FILTER_VAL_FALSE + arg->boolean.value;
> -
> -		/* good cases: */
> -	case TEP_FILTER_ARG_STR:
> -	case TEP_FILTER_ARG_VALUE:
> -	case TEP_FILTER_ARG_FIELD:
> -		return FILTER_VAL_NORM;
> -
> -	case TEP_FILTER_ARG_EXP:
> -		lval = test_arg(arg, arg->exp.left, error_str);
> -		if (lval != FILTER_VAL_NORM)
> -			return lval;
> -		rval = test_arg(arg, arg->exp.right, error_str);
> -		if (rval != FILTER_VAL_NORM)
> -			return rval;
> -		return FILTER_VAL_NORM;
> -
> -	case TEP_FILTER_ARG_NUM:
> -		lval = test_arg(arg, arg->num.left, error_str);
> -		if (lval != FILTER_VAL_NORM)
> -			return lval;
> -		rval = test_arg(arg, arg->num.right, error_str);
> -		if (rval != FILTER_VAL_NORM)
> -			return rval;
> -		return FILTER_VAL_NORM;
> -
> -	case TEP_FILTER_ARG_OP:
> -		if (arg->op.type != TEP_FILTER_OP_NOT) {
> -			lval = test_arg(arg, arg->op.left, error_str);
> -			switch (lval) {
> -			case FILTER_VAL_NORM:
> -				break;
> -			case FILTER_VAL_TRUE:
> -				if (arg->op.type == TEP_FILTER_OP_OR)
> -					return FILTER_VAL_TRUE;
> -				rval = test_arg(arg, arg->op.right, error_str);
> -				if (rval != FILTER_VAL_NORM)
> -					return rval;
> -
> -				return reparent_op_arg(parent, arg, arg->op.right,
> -						       error_str);
> -
> -			case FILTER_VAL_FALSE:
> -				if (arg->op.type == TEP_FILTER_OP_AND)
> -					return FILTER_VAL_FALSE;
> -				rval = test_arg(arg, arg->op.right, error_str);
> -				if (rval != FILTER_VAL_NORM)
> -					return rval;
> -
> -				return reparent_op_arg(parent, arg, arg->op.right,
> -						       error_str);
> -
> -			default:
> -				return lval;
> -			}
> -		}
> -
> -		rval = test_arg(arg, arg->op.right, error_str);
> -		switch (rval) {
> -		case FILTER_VAL_NORM:
> -		default:
> -			break;
> -
> -		case FILTER_VAL_TRUE:
> -			if (arg->op.type == TEP_FILTER_OP_OR)
> -				return FILTER_VAL_TRUE;
> -			if (arg->op.type == TEP_FILTER_OP_NOT)
> -				return FILTER_VAL_FALSE;
> -
> -			return reparent_op_arg(parent, arg, arg->op.left,
> -					       error_str);
> -
> -		case FILTER_VAL_FALSE:
> -			if (arg->op.type == TEP_FILTER_OP_AND)
> -				return FILTER_VAL_FALSE;
> -			if (arg->op.type == TEP_FILTER_OP_NOT)
> -				return FILTER_VAL_TRUE;
> -
> -			return reparent_op_arg(parent, arg, arg->op.left,
> -					       error_str);
> -		}
> -
> -		return rval;
> -	default:
> -		show_error(error_str, "bad arg in filter tree");
> -		return TEP_ERRNO__BAD_FILTER_ARG;
> -	}
> -	return FILTER_VAL_NORM;
> -}
> -
> -/* Remove any unknown event fields */
> -static int collapse_tree(struct tep_filter_arg *arg,
> -			 struct tep_filter_arg **arg_collapsed, char *error_str)
> -{
> -	int ret;
> -
> -	ret = test_arg(arg, arg, error_str);
> -	switch (ret) {
> -	case FILTER_VAL_NORM:
> -		break;
> -
> -	case FILTER_VAL_TRUE:
> -	case FILTER_VAL_FALSE:
> -		free_arg(arg);
> -		arg = allocate_arg();
> -		if (arg) {
> -			arg->type = TEP_FILTER_ARG_BOOLEAN;
> -			arg->boolean.value = ret == FILTER_VAL_TRUE;
> -		} else {
> -			show_error(error_str, "Failed to allocate filter arg");
> -			ret = TEP_ERRNO__MEM_ALLOC_FAILED;
> -		}
> -		break;
> -
> -	default:
> -		/* test_arg() already set the error_str */
> -		free_arg(arg);
> -		arg = NULL;
> -		break;
> -	}
> -
> -	*arg_collapsed = arg;
> -	return ret;
> -}
> -
> -static enum tep_errno
> -process_filter(struct tep_event *event, struct tep_filter_arg **parg,
> -	       char *error_str, int not)
> -{
> -	enum tep_event_type type;
> -	char *token = NULL;
> -	struct tep_filter_arg *current_op = NULL;
> -	struct tep_filter_arg *current_exp = NULL;
> -	struct tep_filter_arg *left_item = NULL;
> -	struct tep_filter_arg *arg = NULL;
> -	enum op_type op_type;
> -	enum tep_filter_op_type btype;
> -	enum tep_filter_exp_type etype;
> -	enum tep_filter_cmp_type ctype;
> -	enum tep_errno ret;
> -
> -	*parg = NULL;
> -
> -	do {
> -		free(token);
> -		type = filter_read_token(&token);
> -		switch (type) {
> -		case TEP_EVENT_SQUOTE:
> -		case TEP_EVENT_DQUOTE:
> -		case TEP_EVENT_ITEM:
> -			ret = create_arg_item(event, token, type, &arg, error_str);
> -			if (ret < 0)
> -				goto fail;
> -			if (!left_item)
> -				left_item = arg;
> -			else if (current_exp) {
> -				ret = add_right(current_exp, arg, error_str);
> -				if (ret < 0)
> -					goto fail;
> -				left_item = NULL;
> -				/* Not's only one one expression */
> -				if (not) {
> -					arg = NULL;
> -					if (current_op)
> -						goto fail_syntax;
> -					free(token);
> -					*parg = current_exp;
> -					return 0;
> -				}
> -			} else
> -				goto fail_syntax;
> -			arg = NULL;
> -			break;
> -
> -		case TEP_EVENT_DELIM:
> -			if (*token == ',') {
> -				show_error(error_str, "Illegal token ','");
> -				ret = TEP_ERRNO__ILLEGAL_TOKEN;
> -				goto fail;
> -			}
> -
> -			if (*token == '(') {
> -				if (left_item) {
> -					show_error(error_str,
> -						   "Open paren can not come after item");
> -					ret = TEP_ERRNO__INVALID_PAREN;
> -					goto fail;
> -				}
> -				if (current_exp) {
> -					show_error(error_str,
> -						   "Open paren can not come after expression");
> -					ret = TEP_ERRNO__INVALID_PAREN;
> -					goto fail;
> -				}
> -
> -				ret = process_filter(event, &arg, error_str, 0);
> -				if (ret != TEP_ERRNO__UNBALANCED_PAREN) {
> -					if (ret == 0) {
> -						show_error(error_str,
> -							   "Unbalanced number of '('");
> -						ret = TEP_ERRNO__UNBALANCED_PAREN;
> -					}
> -					goto fail;
> -				}
> -				ret = 0;
> -
> -				/* A not wants just one expression */
> -				if (not) {
> -					if (current_op)
> -						goto fail_syntax;
> -					*parg = arg;
> -					return 0;
> -				}
> -
> -				if (current_op)
> -					ret = add_right(current_op, arg, error_str);
> -				else
> -					current_exp = arg;
> -
> -				if (ret < 0)
> -					goto fail;
> -
> -			} else { /* ')' */
> -				if (!current_op && !current_exp)
> -					goto fail_syntax;
> -
> -				/* Make sure everything is finished at this level */
> -				if (current_exp && !check_op_done(current_exp))
> -					goto fail_syntax;
> -				if (current_op && !check_op_done(current_op))
> -					goto fail_syntax;
> -
> -				if (current_op)
> -					*parg = current_op;
> -				else
> -					*parg = current_exp;
> -				free(token);
> -				return TEP_ERRNO__UNBALANCED_PAREN;
> -			}
> -			break;
> -
> -		case TEP_EVENT_OP:
> -			op_type = process_op(token, &btype, &ctype, &etype);
> -
> -			/* All expect a left arg except for NOT */
> -			switch (op_type) {
> -			case OP_BOOL:
> -				/* Logic ops need a left expression */
> -				if (!current_exp && !current_op)
> -					goto fail_syntax;
> -				/* fall through */
> -			case OP_NOT:
> -				/* logic only processes ops and exp */
> -				if (left_item)
> -					goto fail_syntax;
> -				break;
> -			case OP_EXP:
> -			case OP_CMP:
> -				if (!left_item)
> -					goto fail_syntax;
> -				break;
> -			case OP_NONE:
> -				show_error(error_str,
> -					   "Unknown op token %s", token);
> -				ret = TEP_ERRNO__UNKNOWN_TOKEN;
> -				goto fail;
> -			}
> -
> -			ret = 0;
> -			switch (op_type) {
> -			case OP_BOOL:
> -				arg = create_arg_op(btype);
> -				if (arg == NULL)
> -					goto fail_alloc;
> -				if (current_op)
> -					ret = add_left(arg, current_op);
> -				else
> -					ret = add_left(arg, current_exp);
> -				current_op = arg;
> -				current_exp = NULL;
> -				break;
> -
> -			case OP_NOT:
> -				arg = create_arg_op(btype);
> -				if (arg == NULL)
> -					goto fail_alloc;
> -				if (current_op)
> -					ret = add_right(current_op, arg, error_str);
> -				if (ret < 0)
> -					goto fail;
> -				current_exp = arg;
> -				ret = process_filter(event, &arg, error_str, 1);
> -				if (ret < 0)
> -					goto fail;
> -				ret = add_right(current_exp, arg, error_str);
> -				if (ret < 0)
> -					goto fail;
> -				break;
> -
> -			case OP_EXP:
> -			case OP_CMP:
> -				if (op_type == OP_EXP)
> -					arg = create_arg_exp(etype);
> -				else
> -					arg = create_arg_cmp(ctype);
> -				if (arg == NULL)
> -					goto fail_alloc;
> -
> -				if (current_op)
> -					ret = add_right(current_op, arg, error_str);
> -				if (ret < 0)
> -					goto fail;
> -				ret = add_left(arg, left_item);
> -				if (ret < 0) {
> -					arg = NULL;
> -					goto fail_syntax;
> -				}
> -				current_exp = arg;
> -				break;
> -			default:
> -				break;
> -			}
> -			arg = NULL;
> -			if (ret < 0)
> -				goto fail_syntax;
> -			break;
> -		case TEP_EVENT_NONE:
> -			break;
> -		case TEP_EVENT_ERROR:
> -			goto fail_alloc;
> -		default:
> -			goto fail_syntax;
> -		}
> -	} while (type != TEP_EVENT_NONE);
> -
> -	if (!current_op && !current_exp)
> -		goto fail_syntax;
> -
> -	if (!current_op)
> -		current_op = current_exp;
> -
> -	ret = collapse_tree(current_op, parg, error_str);
> -	/* collapse_tree() may free current_op, and updates parg accordingly */
> -	current_op = NULL;
> -	if (ret < 0)
> -		goto fail;
> -
> -	free(token);
> -	return 0;
> -
> - fail_alloc:
> -	show_error(error_str, "failed to allocate filter arg");
> -	ret = TEP_ERRNO__MEM_ALLOC_FAILED;
> -	goto fail;
> - fail_syntax:
> -	show_error(error_str, "Syntax error");
> -	ret = TEP_ERRNO__SYNTAX_ERROR;
> - fail:
> -	free_arg(current_op);
> -	free_arg(current_exp);
> -	free_arg(arg);
> -	free(token);
> -	return ret;
> -}
> -
> -static enum tep_errno
> -process_event(struct tep_event *event, const char *filter_str,
> -	      struct tep_filter_arg **parg, char *error_str)
> -{
> -	int ret;
> -
> -	init_input_buf(filter_str, strlen(filter_str));
> -
> -	ret = process_filter(event, parg, error_str, 0);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* If parg is NULL, then make it into FALSE */
> -	if (!*parg) {
> -		*parg = allocate_arg();
> -		if (*parg == NULL)
> -			return TEP_ERRNO__MEM_ALLOC_FAILED;
> -
> -		(*parg)->type = TEP_FILTER_ARG_BOOLEAN;
> -		(*parg)->boolean.value = TEP_FILTER_FALSE;
> -	}
> -
> -	return 0;
> -}
> -
> -static enum tep_errno
> -filter_event(struct tep_event_filter *filter, struct tep_event *event,
> -	     const char *filter_str, char *error_str)
> -{
> -	struct tep_filter_type *filter_type;
> -	struct tep_filter_arg *arg;
> -	enum tep_errno ret;
> -
> -	if (filter_str) {
> -		ret = process_event(event, filter_str, &arg, error_str);
> -		if (ret < 0)
> -			return ret;
> -
> -	} else {
> -		/* just add a TRUE arg */
> -		arg = allocate_arg();
> -		if (arg == NULL)
> -			return TEP_ERRNO__MEM_ALLOC_FAILED;
> -
> -		arg->type = TEP_FILTER_ARG_BOOLEAN;
> -		arg->boolean.value = TEP_FILTER_TRUE;
> -	}
> -
> -	filter_type = add_filter_type(filter, event->id);
> -	if (filter_type == NULL) {
> -		free_arg(arg);
> -		return TEP_ERRNO__MEM_ALLOC_FAILED;
> -	}
> -
> -	if (filter_type->filter)
> -		free_arg(filter_type->filter);
> -	filter_type->filter = arg;
> -
> -	return 0;
> -}
> -
> -static void filter_init_error_buf(struct tep_event_filter *filter)
> -{
> -	/* clear buffer to reset show error */
> -	init_input_buf("", 0);
> -	filter->error_buffer[0] = '\0';
> -}
> -
> -/**
> - * tep_filter_add_filter_str - add a new filter
> - * @filter: the event filter to add to
> - * @filter_str: the filter string that contains the filter
> - *
> - * Returns 0 if the filter was successfully added or a
> - * negative error code.  Use tep_filter_strerror() to see
> - * actual error message in case of error.
> - */
> -enum tep_errno tep_filter_add_filter_str(struct tep_event_filter *filter,
> -					 const char *filter_str)
> -{
> -	struct tep_handle *tep = filter->tep;
> -	struct event_list *event;
> -	struct event_list *events = NULL;
> -	const char *filter_start;
> -	const char *next_event;
> -	char *this_event;
> -	char *event_name = NULL;
> -	char *sys_name = NULL;
> -	char *sp;
> -	enum tep_errno rtn = 0; /* TEP_ERRNO__SUCCESS */
> -	int len;
> -	int ret;
> -
> -	filter_init_error_buf(filter);
> -
> -	filter_start = strchr(filter_str, ':');
> -	if (filter_start)
> -		len = filter_start - filter_str;
> -	else
> -		len = strlen(filter_str);
> -
> -	do {
> -		next_event = strchr(filter_str, ',');
> -		if (next_event &&
> -		    (!filter_start || next_event < filter_start))
> -			len = next_event - filter_str;
> -		else if (filter_start)
> -			len = filter_start - filter_str;
> -		else
> -			len = strlen(filter_str);
> -
> -		this_event = malloc(len + 1);
> -		if (this_event == NULL) {
> -			/* This can only happen when events is NULL, but still */
> -			free_events(events);
> -			return TEP_ERRNO__MEM_ALLOC_FAILED;
> -		}
> -		memcpy(this_event, filter_str, len);
> -		this_event[len] = 0;
> -
> -		if (next_event)
> -			next_event++;
> -
> -		filter_str = next_event;
> -
> -		sys_name = strtok_r(this_event, "/", &sp);
> -		event_name = strtok_r(NULL, "/", &sp);
> -
> -		if (!sys_name) {
> -			/* This can only happen when events is NULL, but still */
> -			free_events(events);
> -			free(this_event);
> -			return TEP_ERRNO__FILTER_NOT_FOUND;
> -		}
> -
> -		/* Find this event */
> -		ret = find_event(tep, &events, strim(sys_name), strim(event_name));
> -		if (ret < 0) {
> -			free_events(events);
> -			free(this_event);
> -			return ret;
> -		}
> -		free(this_event);
> -	} while (filter_str);
> -
> -	/* Skip the ':' */
> -	if (filter_start)
> -		filter_start++;
> -
> -	/* filter starts here */
> -	for (event = events; event; event = event->next) {
> -		ret = filter_event(filter, event->event, filter_start,
> -				   filter->error_buffer);
> -		/* Failures are returned if a parse error happened */
> -		if (ret < 0)
> -			rtn = ret;
> -
> -		if (ret >= 0 && tep->test_filters) {
> -			char *test;
> -			test = tep_filter_make_string(filter, event->event->id);
> -			if (test) {
> -				printf(" '%s: %s'\n", event->event->name, test);
> -				free(test);
> -			}
> -		}
> -	}
> -
> -	free_events(events);
> -
> -	return rtn;
> -}
> -
> -static void free_filter_type(struct tep_filter_type *filter_type)
> -{
> -	free_arg(filter_type->filter);
> -}
> -
> -/**
> - * tep_filter_strerror - fill error message in a buffer
> - * @filter: the event filter contains error
> - * @err: the error code
> - * @buf: the buffer to be filled in
> - * @buflen: the size of the buffer
> - *
> - * Returns 0 if message was filled successfully, -1 if error
> - */
> -int tep_filter_strerror(struct tep_event_filter *filter, enum tep_errno err,
> -			char *buf, size_t buflen)
> -{
> -	if (err <= __TEP_ERRNO__START || err >= __TEP_ERRNO__END)
> -		return -1;
> -
> -	if (strlen(filter->error_buffer) > 0) {
> -		size_t len = snprintf(buf, buflen, "%s", filter->error_buffer);
> -
> -		if (len > buflen)
> -			return -1;
> -		return 0;
> -	}
> -
> -	return tep_strerror(filter->tep, err, buf, buflen);
> -}
> -
> -/**
> - * tep_filter_remove_event - remove a filter for an event
> - * @filter: the event filter to remove from
> - * @event_id: the event to remove a filter for
> - *
> - * Removes the filter saved for an event defined by @event_id
> - * from the @filter.
> - *
> - * Returns 1: if an event was removed
> - *   0: if the event was not found
> - */
> -int tep_filter_remove_event(struct tep_event_filter *filter,
> -			    int event_id)
> -{
> -	struct tep_filter_type *filter_type;
> -	unsigned long len;
> -
> -	if (!filter->filters)
> -		return 0;
> -
> -	filter_type = find_filter_type(filter, event_id);
> -
> -	if (!filter_type)
> -		return 0;
> -
> -	free_filter_type(filter_type);
> -
> -	/* The filter_type points into the event_filters array */
> -	len = (unsigned long)(filter->event_filters + filter->filters) -
> -		(unsigned long)(filter_type + 1);
> -
> -	memmove(filter_type, filter_type + 1, len);
> -	filter->filters--;
> -
> -	memset(&filter->event_filters[filter->filters], 0,
> -	       sizeof(*filter_type));
> -
> -	return 1;
> -}
> -
> -/**
> - * tep_filter_reset - clear all filters in a filter
> - * @filter: the event filter to reset
> - *
> - * Removes all filters from a filter and resets it.
> - */
> -void tep_filter_reset(struct tep_event_filter *filter)
> -{
> -	int i;
> -
> -	for (i = 0; i < filter->filters; i++)
> -		free_filter_type(&filter->event_filters[i]);
> -
> -	free(filter->event_filters);
> -	filter->filters = 0;
> -	filter->event_filters = NULL;
> -}
> -
> -void tep_filter_free(struct tep_event_filter *filter)
> -{
> -	tep_unref(filter->tep);
> -
> -	tep_filter_reset(filter);
> -
> -	free(filter);
> -}
> -
> -static char *arg_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg);
> -
> -static int copy_filter_type(struct tep_event_filter *filter,
> -			    struct tep_event_filter *source,
> -			    struct tep_filter_type *filter_type)
> -{
> -	struct tep_filter_arg *arg;
> -	struct tep_event *event;
> -	const char *sys;
> -	const char *name;
> -	char *str;
> -
> -	/* Can't assume that the tep's are the same */
> -	sys = filter_type->event->system;
> -	name = filter_type->event->name;
> -	event = tep_find_event_by_name(filter->tep, sys, name);
> -	if (!event)
> -		return -1;
> -
> -	str = arg_to_str(source, filter_type->filter);
> -	if (!str)
> -		return -1;
> -
> -	if (strcmp(str, "TRUE") == 0 || strcmp(str, "FALSE") == 0) {
> -		/* Add trivial event */
> -		arg = allocate_arg();
> -		if (arg == NULL) {
> -			free(str);
> -			return -1;
> -		}
> -
> -		arg->type = TEP_FILTER_ARG_BOOLEAN;
> -		if (strcmp(str, "TRUE") == 0)
> -			arg->boolean.value = 1;
> -		else
> -			arg->boolean.value = 0;
> -
> -		filter_type = add_filter_type(filter, event->id);
> -		if (filter_type == NULL) {
> -			free(str);
> -			free_arg(arg);
> -			return -1;
> -		}
> -
> -		filter_type->filter = arg;
> -
> -		free(str);
> -		return 0;
> -	}
> -
> -	filter_event(filter, event, str, NULL);
> -	free(str);
> -
> -	return 0;
> -}
> -
> -/**
> - * tep_filter_copy - copy a filter using another filter
> - * @dest - the filter to copy to
> - * @source - the filter to copy from
> - *
> - * Returns 0 on success and -1 if not all filters were copied
> - */
> -int tep_filter_copy(struct tep_event_filter *dest, struct tep_event_filter *source)
> -{
> -	int ret = 0;
> -	int i;
> -
> -	tep_filter_reset(dest);
> -
> -	for (i = 0; i < source->filters; i++) {
> -		if (copy_filter_type(dest, source, &source->event_filters[i]))
> -			ret = -1;
> -	}
> -	return ret;
> -}
> -
> -static int test_filter(struct tep_event *event, struct tep_filter_arg *arg,
> -		       struct tep_record *record, enum tep_errno *err);
> -
> -static const char *
> -get_comm(struct tep_event *event, struct tep_record *record)
> -{
> -	const char *comm;
> -	int pid;
> -
> -	pid = tep_data_pid(event->tep, record);
> -	comm = tep_data_comm_from_pid(event->tep, pid);
> -	return comm;
> -}
> -
> -static unsigned long long
> -get_value(struct tep_event *event,
> -	  struct tep_format_field *field, struct tep_record *record)
> -{
> -	unsigned long long val;
> -
> -	/* Handle our dummy "comm" field */
> -	if (field == &comm) {
> -		const char *name;
> -
> -		name = get_comm(event, record);
> -		return (unsigned long)name;
> -	}
> -
> -	/* Handle our dummy "cpu" field */
> -	if (field == &cpu)
> -		return record->cpu;
> -
> -	tep_read_number_field(field, record->data, &val);
> -
> -	if (!(field->flags & TEP_FIELD_IS_SIGNED))
> -		return val;
> -
> -	switch (field->size) {
> -	case 1:
> -		return (char)val;
> -	case 2:
> -		return (short)val;
> -	case 4:
> -		return (int)val;
> -	case 8:
> -		return (long long)val;
> -	}
> -	return val;
> -}
> -
> -static unsigned long long
> -get_arg_value(struct tep_event *event, struct tep_filter_arg *arg,
> -	      struct tep_record *record, enum tep_errno *err);
> -
> -static unsigned long long
> -get_exp_value(struct tep_event *event, struct tep_filter_arg *arg,
> -	      struct tep_record *record, enum tep_errno *err)
> -{
> -	unsigned long long lval, rval;
> -
> -	lval = get_arg_value(event, arg->exp.left, record, err);
> -	rval = get_arg_value(event, arg->exp.right, record, err);
> -
> -	if (*err) {
> -		/*
> -		 * There was an error, no need to process anymore.
> -		 */
> -		return 0;
> -	}
> -
> -	switch (arg->exp.type) {
> -	case TEP_FILTER_EXP_ADD:
> -		return lval + rval;
> -
> -	case TEP_FILTER_EXP_SUB:
> -		return lval - rval;
> -
> -	case TEP_FILTER_EXP_MUL:
> -		return lval * rval;
> -
> -	case TEP_FILTER_EXP_DIV:
> -		return lval / rval;
> -
> -	case TEP_FILTER_EXP_MOD:
> -		return lval % rval;
> -
> -	case TEP_FILTER_EXP_RSHIFT:
> -		return lval >> rval;
> -
> -	case TEP_FILTER_EXP_LSHIFT:
> -		return lval << rval;
> -
> -	case TEP_FILTER_EXP_AND:
> -		return lval & rval;
> -
> -	case TEP_FILTER_EXP_OR:
> -		return lval | rval;
> -
> -	case TEP_FILTER_EXP_XOR:
> -		return lval ^ rval;
> -
> -	case TEP_FILTER_EXP_NOT:
> -	default:
> -		if (!*err)
> -			*err = TEP_ERRNO__INVALID_EXP_TYPE;
> -	}
> -	return 0;
> -}
> -
> -static unsigned long long
> -get_arg_value(struct tep_event *event, struct tep_filter_arg *arg,
> -	      struct tep_record *record, enum tep_errno *err)
> -{
> -	switch (arg->type) {
> -	case TEP_FILTER_ARG_FIELD:
> -		return get_value(event, arg->field.field, record);
> -
> -	case TEP_FILTER_ARG_VALUE:
> -		if (arg->value.type != TEP_FILTER_NUMBER) {
> -			if (!*err)
> -				*err = TEP_ERRNO__NOT_A_NUMBER;
> -		}
> -		return arg->value.val;
> -
> -	case TEP_FILTER_ARG_EXP:
> -		return get_exp_value(event, arg, record, err);
> -
> -	default:
> -		if (!*err)
> -			*err = TEP_ERRNO__INVALID_ARG_TYPE;
> -	}
> -	return 0;
> -}
> -
> -static int test_num(struct tep_event *event, struct tep_filter_arg *arg,
> -		    struct tep_record *record, enum tep_errno *err)
> -{
> -	unsigned long long lval, rval;
> -
> -	lval = get_arg_value(event, arg->num.left, record, err);
> -	rval = get_arg_value(event, arg->num.right, record, err);
> -
> -	if (*err) {
> -		/*
> -		 * There was an error, no need to process anymore.
> -		 */
> -		return 0;
> -	}
> -
> -	switch (arg->num.type) {
> -	case TEP_FILTER_CMP_EQ:
> -		return lval == rval;
> -
> -	case TEP_FILTER_CMP_NE:
> -		return lval != rval;
> -
> -	case TEP_FILTER_CMP_GT:
> -		return lval > rval;
> -
> -	case TEP_FILTER_CMP_LT:
> -		return lval < rval;
> -
> -	case TEP_FILTER_CMP_GE:
> -		return lval >= rval;
> -
> -	case TEP_FILTER_CMP_LE:
> -		return lval <= rval;
> -
> -	default:
> -		if (!*err)
> -			*err = TEP_ERRNO__ILLEGAL_INTEGER_CMP;
> -		return 0;
> -	}
> -}
> -
> -static const char *get_field_str(struct tep_filter_arg *arg, struct tep_record *record)
> -{
> -	struct tep_event *event;
> -	struct tep_handle *tep;
> -	unsigned long long addr;
> -	const char *val = NULL;
> -	unsigned int size;
> -	char hex[64];
> -
> -	/* If the field is not a string convert it */
> -	if (arg->str.field->flags & TEP_FIELD_IS_STRING) {
> -		val = record->data + arg->str.field->offset;
> -		size = arg->str.field->size;
> -
> -		if (arg->str.field->flags & TEP_FIELD_IS_DYNAMIC) {
> -			addr = *(unsigned int *)val;
> -			size = addr >> 16;
> -			addr &= 0xffff;
> -			if (arg->str.field->flags & TEP_FIELD_IS_RELATIVE)
> -				addr += arg->str.field->offset + arg->str.field->size;
> -			val = record->data + addr;
> -		}
> -
> -		/*
> -		 * We need to copy the data since we can't be sure the field
> -		 * is null terminated.
> -		 */
> -		if (*(val + size - 1)) {
> -			/* copy it */
> -			memcpy(arg->str.buffer, val, arg->str.field->size);
> -			/* the buffer is already NULL terminated */
> -			val = arg->str.buffer;
> -		}
> -
> -	} else {
> -		event = arg->str.field->event;
> -		tep = event->tep;
> -		addr = get_value(event, arg->str.field, record);
> -
> -		if (arg->str.field->flags & (TEP_FIELD_IS_POINTER | TEP_FIELD_IS_LONG))
> -			/* convert to a kernel symbol */
> -			val = tep_find_function(tep, addr);
> -
> -		if (val == NULL) {
> -			/* just use the hex of the string name */
> -			snprintf(hex, 64, "0x%llx", addr);
> -			val = hex;
> -		}
> -	}
> -
> -	return val;
> -}
> -
> -static int test_str(struct tep_event *event, struct tep_filter_arg *arg,
> -		    struct tep_record *record, enum tep_errno *err)
> -{
> -	const char *val;
> -
> -	if (arg->str.field == &comm)
> -		val = get_comm(event, record);
> -	else
> -		val = get_field_str(arg, record);
> -
> -	switch (arg->str.type) {
> -	case TEP_FILTER_CMP_MATCH:
> -		return strcmp(val, arg->str.val) == 0;
> -
> -	case TEP_FILTER_CMP_NOT_MATCH:
> -		return strcmp(val, arg->str.val) != 0;
> -
> -	case TEP_FILTER_CMP_REGEX:
> -		/* Returns zero on match */
> -		return !regexec(&arg->str.reg, val, 0, NULL, 0);
> -
> -	case TEP_FILTER_CMP_NOT_REGEX:
> -		return regexec(&arg->str.reg, val, 0, NULL, 0);
> -
> -	default:
> -		if (!*err)
> -			*err = TEP_ERRNO__ILLEGAL_STRING_CMP;
> -		return 0;
> -	}
> -}
> -
> -static int test_op(struct tep_event *event, struct tep_filter_arg *arg,
> -		   struct tep_record *record, enum tep_errno *err)
> -{
> -	switch (arg->op.type) {
> -	case TEP_FILTER_OP_AND:
> -		return test_filter(event, arg->op.left, record, err) &&
> -			test_filter(event, arg->op.right, record, err);
> -
> -	case TEP_FILTER_OP_OR:
> -		return test_filter(event, arg->op.left, record, err) ||
> -			test_filter(event, arg->op.right, record, err);
> -
> -	case TEP_FILTER_OP_NOT:
> -		return !test_filter(event, arg->op.right, record, err);
> -
> -	default:
> -		if (!*err)
> -			*err = TEP_ERRNO__INVALID_OP_TYPE;
> -		return 0;
> -	}
> -}
> -
> -static int test_filter(struct tep_event *event, struct tep_filter_arg *arg,
> -		       struct tep_record *record, enum tep_errno *err)
> -{
> -	if (*err) {
> -		/*
> -		 * There was an error, no need to process anymore.
> -		 */
> -		return 0;
> -	}
> -
> -	switch (arg->type) {
> -	case TEP_FILTER_ARG_BOOLEAN:
> -		/* easy case */
> -		return arg->boolean.value;
> -
> -	case TEP_FILTER_ARG_OP:
> -		return test_op(event, arg, record, err);
> -
> -	case TEP_FILTER_ARG_NUM:
> -		return test_num(event, arg, record, err);
> -
> -	case TEP_FILTER_ARG_STR:
> -		return test_str(event, arg, record, err);
> -
> -	case TEP_FILTER_ARG_EXP:
> -	case TEP_FILTER_ARG_VALUE:
> -	case TEP_FILTER_ARG_FIELD:
> -		/*
> -		 * Expressions, fields and values evaluate
> -		 * to true if they return non zero
> -		 */
> -		return !!get_arg_value(event, arg, record, err);
> -
> -	default:
> -		if (!*err)
> -			*err = TEP_ERRNO__INVALID_ARG_TYPE;
> -		return 0;
> -	}
> -}
> -
> -/**
> - * tep_event_filtered - return true if event has filter
> - * @filter: filter struct with filter information
> - * @event_id: event id to test if filter exists
> - *
> - * Returns 1 if filter found for @event_id
> - *   otherwise 0;
> - */
> -int tep_event_filtered(struct tep_event_filter *filter, int event_id)
> -{
> -	struct tep_filter_type *filter_type;
> -
> -	if (!filter->filters)
> -		return 0;
> -
> -	filter_type = find_filter_type(filter, event_id);
> -
> -	return filter_type ? 1 : 0;
> -}
> -
> -/**
> - * tep_filter_match - test if a record matches a filter
> - * @filter: filter struct with filter information
> - * @record: the record to test against the filter
> - *
> - * Returns: match result or error code (prefixed with TEP_ERRNO__)
> - * FILTER_MATCH - filter found for event and @record matches
> - * FILTER_MISS  - filter found for event and @record does not match
> - * FILTER_NOT_FOUND - no filter found for @record's event
> - * NO_FILTER - if no filters exist
> - * otherwise - error occurred during test
> - */
> -enum tep_errno tep_filter_match(struct tep_event_filter *filter,
> -				struct tep_record *record)
> -{
> -	struct tep_handle *tep = filter->tep;
> -	struct tep_filter_type *filter_type;
> -	int event_id;
> -	int ret;
> -	enum tep_errno err = 0;
> -
> -	filter_init_error_buf(filter);
> -
> -	if (!filter->filters)
> -		return TEP_ERRNO__NO_FILTER;
> -
> -	event_id = tep_data_type(tep, record);
> -
> -	filter_type = find_filter_type(filter, event_id);
> -	if (!filter_type)
> -		return TEP_ERRNO__FILTER_NOT_FOUND;
> -
> -	ret = test_filter(filter_type->event, filter_type->filter, record, &err);
> -	if (err)
> -		return err;
> -
> -	return ret ? TEP_ERRNO__FILTER_MATCH : TEP_ERRNO__FILTER_MISS;
> -}
> -
> -static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
> -{
> -	char *str = NULL;
> -	char *left = NULL;
> -	char *right = NULL;
> -	char *op = NULL;
> -	int left_val = -1;
> -	int right_val = -1;
> -	int val;
> -
> -	switch (arg->op.type) {
> -	case TEP_FILTER_OP_AND:
> -		op = "&&";
> -		/* fall through */
> -	case TEP_FILTER_OP_OR:
> -		if (!op)
> -			op = "||";
> -
> -		left = arg_to_str(filter, arg->op.left);
> -		right = arg_to_str(filter, arg->op.right);
> -		if (!left || !right)
> -			break;
> -
> -		/* Try to consolidate boolean values */
> -		if (strcmp(left, "TRUE") == 0)
> -			left_val = 1;
> -		else if (strcmp(left, "FALSE") == 0)
> -			left_val = 0;
> -
> -		if (strcmp(right, "TRUE") == 0)
> -			right_val = 1;
> -		else if (strcmp(right, "FALSE") == 0)
> -			right_val = 0;
> -
> -		if (left_val >= 0) {
> -			if ((arg->op.type == TEP_FILTER_OP_AND && !left_val) ||
> -			    (arg->op.type == TEP_FILTER_OP_OR && left_val)) {
> -				/* Just return left value */
> -				str = left;
> -				left = NULL;
> -				break;
> -			}
> -			if (right_val >= 0) {
> -				/* just evaluate this. */
> -				val = 0;
> -				switch (arg->op.type) {
> -				case TEP_FILTER_OP_AND:
> -					val = left_val && right_val;
> -					break;
> -				case TEP_FILTER_OP_OR:
> -					val = left_val || right_val;
> -					break;
> -				default:
> -					break;
> -				}
> -				if (asprintf(&str, val ? "TRUE" : "FALSE") < 0)
> -					str = NULL;
> -				break;
> -			}
> -		}
> -		if (right_val >= 0) {
> -			if ((arg->op.type == TEP_FILTER_OP_AND && !right_val) ||
> -			    (arg->op.type == TEP_FILTER_OP_OR && right_val)) {
> -				/* Just return right value */
> -				str = right;
> -				right = NULL;
> -				break;
> -			}
> -			/* The right value is meaningless */
> -			str = left;
> -			left = NULL;
> -			break;
> -		}
> -
> -		if (asprintf(&str, "(%s) %s (%s)", left, op, right) < 0)
> -			str = NULL;
> -		break;
> -
> -	case TEP_FILTER_OP_NOT:
> -		op = "!";
> -		right = arg_to_str(filter, arg->op.right);
> -		if (!right)
> -			break;
> -
> -		/* See if we can consolidate */
> -		if (strcmp(right, "TRUE") == 0)
> -			right_val = 1;
> -		else if (strcmp(right, "FALSE") == 0)
> -			right_val = 0;
> -		if (right_val >= 0) {
> -			/* just return the opposite */
> -			if (asprintf(&str, right_val ? "FALSE" : "TRUE") < 0)
> -				str = NULL;
> -			break;
> -		}
> -		if (asprintf(&str, "%s(%s)", op, right) < 0)
> -			str = NULL;
> -		break;
> -
> -	default:
> -		/* ?? */
> -		break;
> -	}
> -	free(left);
> -	free(right);
> -	return str;
> -}
> -
> -static char *val_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
> -{
> -	char *str = NULL;
> -
> -	if (asprintf(&str, "%lld", arg->value.val) < 0)
> -		str = NULL;
> -
> -	return str;
> -}
> -
> -static char *field_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
> -{
> -	return strdup(arg->field.field->name);
> -}
> -
> -static char *exp_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
> -{
> -	char *lstr;
> -	char *rstr;
> -	char *op;
> -	char *str = NULL;
> -
> -	lstr = arg_to_str(filter, arg->exp.left);
> -	rstr = arg_to_str(filter, arg->exp.right);
> -	if (!lstr || !rstr)
> -		goto out;
> -
> -	switch (arg->exp.type) {
> -	case TEP_FILTER_EXP_ADD:
> -		op = "+";
> -		break;
> -	case TEP_FILTER_EXP_SUB:
> -		op = "-";
> -		break;
> -	case TEP_FILTER_EXP_MUL:
> -		op = "*";
> -		break;
> -	case TEP_FILTER_EXP_DIV:
> -		op = "/";
> -		break;
> -	case TEP_FILTER_EXP_MOD:
> -		op = "%";
> -		break;
> -	case TEP_FILTER_EXP_RSHIFT:
> -		op = ">>";
> -		break;
> -	case TEP_FILTER_EXP_LSHIFT:
> -		op = "<<";
> -		break;
> -	case TEP_FILTER_EXP_AND:
> -		op = "&";
> -		break;
> -	case TEP_FILTER_EXP_OR:
> -		op = "|";
> -		break;
> -	case TEP_FILTER_EXP_XOR:
> -		op = "^";
> -		break;
> -	default:
> -		op = "[ERROR IN EXPRESSION TYPE]";
> -		break;
> -	}
> -
> -	if (asprintf(&str, "%s %s %s", lstr, op, rstr) < 0)
> -		str = NULL;
> -out:
> -	free(lstr);
> -	free(rstr);
> -
> -	return str;
> -}
> -
> -static char *num_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
> -{
> -	char *lstr;
> -	char *rstr;
> -	char *str = NULL;
> -	char *op = NULL;
> -
> -	lstr = arg_to_str(filter, arg->num.left);
> -	rstr = arg_to_str(filter, arg->num.right);
> -	if (!lstr || !rstr)
> -		goto out;
> -
> -	switch (arg->num.type) {
> -	case TEP_FILTER_CMP_EQ:
> -		op = "==";
> -		/* fall through */
> -	case TEP_FILTER_CMP_NE:
> -		if (!op)
> -			op = "!=";
> -		/* fall through */
> -	case TEP_FILTER_CMP_GT:
> -		if (!op)
> -			op = ">";
> -		/* fall through */
> -	case TEP_FILTER_CMP_LT:
> -		if (!op)
> -			op = "<";
> -		/* fall through */
> -	case TEP_FILTER_CMP_GE:
> -		if (!op)
> -			op = ">=";
> -		/* fall through */
> -	case TEP_FILTER_CMP_LE:
> -		if (!op)
> -			op = "<=";
> -
> -		if (asprintf(&str, "%s %s %s", lstr, op, rstr) < 0)
> -			str = NULL;
> -		break;
> -
> -	default:
> -		/* ?? */
> -		break;
> -	}
> -
> -out:
> -	free(lstr);
> -	free(rstr);
> -	return str;
> -}
> -
> -static char *str_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
> -{
> -	char *str = NULL;
> -	char *op = NULL;
> -
> -	switch (arg->str.type) {
> -	case TEP_FILTER_CMP_MATCH:
> -		op = "==";
> -		/* fall through */
> -	case TEP_FILTER_CMP_NOT_MATCH:
> -		if (!op)
> -			op = "!=";
> -		/* fall through */
> -	case TEP_FILTER_CMP_REGEX:
> -		if (!op)
> -			op = "=~";
> -		/* fall through */
> -	case TEP_FILTER_CMP_NOT_REGEX:
> -		if (!op)
> -			op = "!~";
> -
> -		if (asprintf(&str, "%s %s \"%s\"",
> -			 arg->str.field->name, op, arg->str.val) < 0)
> -			str = NULL;
> -		break;
> -
> -	default:
> -		/* ?? */
> -		break;
> -	}
> -	return str;
> -}
> -
> -static char *arg_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
> -{
> -	char *str = NULL;
> -
> -	switch (arg->type) {
> -	case TEP_FILTER_ARG_BOOLEAN:
> -		if (asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE") < 0)
> -			str = NULL;
> -		return str;
> -
> -	case TEP_FILTER_ARG_OP:
> -		return op_to_str(filter, arg);
> -
> -	case TEP_FILTER_ARG_NUM:
> -		return num_to_str(filter, arg);
> -
> -	case TEP_FILTER_ARG_STR:
> -		return str_to_str(filter, arg);
> -
> -	case TEP_FILTER_ARG_VALUE:
> -		return val_to_str(filter, arg);
> -
> -	case TEP_FILTER_ARG_FIELD:
> -		return field_to_str(filter, arg);
> -
> -	case TEP_FILTER_ARG_EXP:
> -		return exp_to_str(filter, arg);
> -
> -	default:
> -		/* ?? */
> -		return NULL;
> -	}
> -
> -}
> -
> -/**
> - * tep_filter_make_string - return a string showing the filter
> - * @filter: filter struct with filter information
> - * @event_id: the event id to return the filter string with
> - *
> - * Returns a string that displays the filter contents.
> - *  This string must be freed with free(str).
> - *  NULL is returned if no filter is found or allocation failed.
> - */
> -char *
> -tep_filter_make_string(struct tep_event_filter *filter, int event_id)
> -{
> -	struct tep_filter_type *filter_type;
> -
> -	if (!filter->filters)
> -		return NULL;
> -
> -	filter_type = find_filter_type(filter, event_id);
> -
> -	if (!filter_type)
> -		return NULL;
> -
> -	return arg_to_str(filter, filter_type->filter);
> -}
> -
> -/**
> - * tep_filter_compare - compare two filters and return if they are the same
> - * @filter1: Filter to compare with @filter2
> - * @filter2: Filter to compare with @filter1
> - *
> - * Returns:
> - *  1 if the two filters hold the same content.
> - *  0 if they do not.
> - */
> -int tep_filter_compare(struct tep_event_filter *filter1, struct tep_event_filter *filter2)
> -{
> -	struct tep_filter_type *filter_type1;
> -	struct tep_filter_type *filter_type2;
> -	char *str1, *str2;
> -	int result;
> -	int i;
> -
> -	/* Do the easy checks first */
> -	if (filter1->filters != filter2->filters)
> -		return 0;
> -	if (!filter1->filters && !filter2->filters)
> -		return 1;
> -
> -	/*
> -	 * Now take a look at each of the events to see if they have the same
> -	 * filters to them.
> -	 */
> -	for (i = 0; i < filter1->filters; i++) {
> -		filter_type1 = &filter1->event_filters[i];
> -		filter_type2 = find_filter_type(filter2, filter_type1->event_id);
> -		if (!filter_type2)
> -			break;
> -		if (filter_type1->filter->type != filter_type2->filter->type)
> -			break;
> -		/* The best way to compare complex filters is with strings */
> -		str1 = arg_to_str(filter1, filter_type1->filter);
> -		str2 = arg_to_str(filter2, filter_type2->filter);
> -		if (str1 && str2)
> -			result = strcmp(str1, str2) != 0;
> -		else
> -			/* bail out if allocation fails */
> -			result = 1;
> -
> -		free(str1);
> -		free(str2);
> -		if (result)
> -			break;
> -	}
> -
> -	if (i < filter1->filters)
> -		return 0;
> -	return 1;
> -}
> -
> diff --git a/tools/lib/traceevent/parse-utils.c b/tools/lib/traceevent/parse-utils.c
> deleted file mode 100644
> index e99867111387..000000000000
> --- a/tools/lib/traceevent/parse-utils.c
> +++ /dev/null
> @@ -1,71 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - *
> - */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <stdarg.h>
> -#include <errno.h>
> -
> -#define __weak __attribute__((weak))
> -
> -void __vwarning(const char *fmt, va_list ap)
> -{
> -	if (errno)
> -		perror("libtraceevent");
> -	errno = 0;
> -
> -	fprintf(stderr, "  ");
> -	vfprintf(stderr, fmt, ap);
> -
> -	fprintf(stderr, "\n");
> -}
> -
> -void __warning(const char *fmt, ...)
> -{
> -	va_list ap;
> -
> -	va_start(ap, fmt);
> -	__vwarning(fmt, ap);
> -	va_end(ap);
> -}
> -
> -void __weak warning(const char *fmt, ...)
> -{
> -	va_list ap;
> -
> -	va_start(ap, fmt);
> -	__vwarning(fmt, ap);
> -	va_end(ap);
> -}
> -
> -void __vpr_stat(const char *fmt, va_list ap)
> -{
> -	vprintf(fmt, ap);
> -	printf("\n");
> -}
> -
> -void __pr_stat(const char *fmt, ...)
> -{
> -	va_list ap;
> -
> -	va_start(ap, fmt);
> -	__vpr_stat(fmt, ap);
> -	va_end(ap);
> -}
> -
> -void __weak vpr_stat(const char *fmt, va_list ap)
> -{
> -	__vpr_stat(fmt, ap);
> -}
> -
> -void __weak pr_stat(const char *fmt, ...)
> -{
> -	va_list ap;
> -
> -	va_start(ap, fmt);
> -	__vpr_stat(fmt, ap);
> -	va_end(ap);
> -}
> diff --git a/tools/lib/traceevent/plugins/Build b/tools/lib/traceevent/plugins/Build
> deleted file mode 100644
> index dd4da823c38f..000000000000
> --- a/tools/lib/traceevent/plugins/Build
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -plugin_jbd2-y         += plugin_jbd2.o
> -plugin_hrtimer-y      += plugin_hrtimer.o
> -plugin_kmem-y         += plugin_kmem.o
> -plugin_kvm-y          += plugin_kvm.o
> -plugin_mac80211-y     += plugin_mac80211.o
> -plugin_sched_switch-y += plugin_sched_switch.o
> -plugin_function-y     += plugin_function.o
> -plugin_futex-y        += plugin_futex.o
> -plugin_xen-y          += plugin_xen.o
> -plugin_scsi-y         += plugin_scsi.o
> -plugin_cfg80211-y     += plugin_cfg80211.o
> -plugin_tlb-y          += plugin_tlb.o
> \ No newline at end of file
> diff --git a/tools/lib/traceevent/plugins/Makefile b/tools/lib/traceevent/plugins/Makefile
> deleted file mode 100644
> index 47e802553250..000000000000
> --- a/tools/lib/traceevent/plugins/Makefile
> +++ /dev/null
> @@ -1,225 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -
> -#MAKEFLAGS += --no-print-directory
> -
> -
> -# Makefiles suck: This macro sets a default value of $(2) for the
> -# variable named by $(1), unless the variable has been set by
> -# environment or command line. This is necessary for CC and AR
> -# because make sets default values, so the simpler ?= approach
> -# won't work as expected.
> -define allow-override
> -  $(if $(or $(findstring environment,$(origin $(1))),\
> -            $(findstring command line,$(origin $(1)))),,\
> -    $(eval $(1) = $(2)))
> -endef
> -
> -# Allow setting CC and AR, or setting CROSS_COMPILE as a prefix.
> -$(call allow-override,CC,$(CROSS_COMPILE)gcc)
> -$(call allow-override,AR,$(CROSS_COMPILE)ar)
> -$(call allow-override,NM,$(CROSS_COMPILE)nm)
> -$(call allow-override,PKG_CONFIG,pkg-config)
> -
> -EXT = -std=gnu99
> -INSTALL = install
> -
> -# Use DESTDIR for installing into a different root directory.
> -# This is useful for building a package. The program will be
> -# installed in this directory as if it was the root directory.
> -# Then the build tool can move it later.
> -DESTDIR ?=
> -DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
> -
> -LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
> -ifeq ($(LP64), 1)
> -  libdir_relative_tmp = lib64
> -else
> -  libdir_relative_tmp = lib
> -endif
> -
> -libdir_relative ?= $(libdir_relative_tmp)
> -prefix ?= /usr/local
> -libdir = $(prefix)/$(libdir_relative)
> -
> -set_plugin_dir := 1
> -
> -# Set plugin_dir to preffered global plugin location
> -# If we install under $HOME directory we go under
> -# $(HOME)/.local/lib/traceevent/plugins
> -#
> -# We dont set PLUGIN_DIR in case we install under $HOME
> -# directory, because by default the code looks under:
> -# $(HOME)/.local/lib/traceevent/plugins by default.
> -#
> -ifeq ($(plugin_dir),)
> -ifeq ($(prefix),$(HOME))
> -override plugin_dir = $(HOME)/.local/lib/traceevent/plugins
> -set_plugin_dir := 0
> -else
> -override plugin_dir = $(libdir)/traceevent/plugins
> -endif
> -endif
> -
> -ifeq ($(set_plugin_dir),1)
> -PLUGIN_DIR = -DPLUGIN_DIR="$(plugin_dir)"
> -PLUGIN_DIR_SQ = '$(subst ','\'',$(PLUGIN_DIR))'
> -endif
> -
> -include ../../../scripts/Makefile.include
> -
> -# copy a bit from Linux kbuild
> -
> -ifeq ("$(origin V)", "command line")
> -  VERBOSE = $(V)
> -endif
> -ifndef VERBOSE
> -  VERBOSE = 0
> -endif
> -
> -ifeq ($(srctree),)
> -srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> -srctree := $(patsubst %/,%,$(dir $(srctree)))
> -srctree := $(patsubst %/,%,$(dir $(srctree)))
> -srctree := $(patsubst %/,%,$(dir $(srctree)))
> -#$(info Determined 'srctree' to be $(srctree))
> -endif
> -
> -export prefix libdir src obj
> -
> -# Shell quotes
> -plugin_dir_SQ = $(subst ','\'',$(plugin_dir))
> -
> -CONFIG_INCLUDES =
> -CONFIG_LIBS    =
> -CONFIG_FLAGS   =
> -
> -OBJ            = $@
> -N              =
> -
> -INCLUDES = -I. -I.. -I $(srctree)/tools/include $(CONFIG_INCLUDES)
> -
> -# Set compile option CFLAGS
> -ifdef EXTRA_CFLAGS
> -  CFLAGS := $(EXTRA_CFLAGS)
> -else
> -  CFLAGS := -g -Wall
> -endif
> -
> -# Append required CFLAGS
> -override CFLAGS += -fPIC
> -override CFLAGS += $(CONFIG_FLAGS) $(INCLUDES) $(PLUGIN_DIR_SQ)
> -override CFLAGS += $(udis86-flags) -D_GNU_SOURCE
> -
> -ifeq ($(VERBOSE),1)
> -  Q =
> -else
> -  Q = @
> -endif
> -
> -# Disable command line variables (CFLAGS) override from top
> -# level Makefile (perf), otherwise build Makefile will get
> -# the same command line setup.
> -MAKEOVERRIDES=
> -
> -export srctree OUTPUT CC LD CFLAGS V
> -
> -build := -f $(srctree)/tools/build/Makefile.build dir=. obj
> -
> -DYNAMIC_LIST_FILE := $(OUTPUT)libtraceevent-dynamic-list
> -
> -PLUGINS  = plugin_jbd2.so
> -PLUGINS += plugin_hrtimer.so
> -PLUGINS += plugin_kmem.so
> -PLUGINS += plugin_kvm.so
> -PLUGINS += plugin_mac80211.so
> -PLUGINS += plugin_sched_switch.so
> -PLUGINS += plugin_function.so
> -PLUGINS += plugin_futex.so
> -PLUGINS += plugin_xen.so
> -PLUGINS += plugin_scsi.so
> -PLUGINS += plugin_cfg80211.so
> -PLUGINS += plugin_tlb.so
> -
> -PLUGINS    := $(addprefix $(OUTPUT),$(PLUGINS))
> -PLUGINS_IN := $(PLUGINS:.so=-in.o)
> -
> -plugins: $(PLUGINS) $(DYNAMIC_LIST_FILE)
> -
> -__plugin_obj = $(notdir $@)
> -  plugin_obj = $(__plugin_obj:-in.o=)
> -
> -$(PLUGINS_IN): force
> -	$(Q)$(MAKE) $(build)=$(plugin_obj)
> -
> -$(OUTPUT)libtraceevent-dynamic-list: $(PLUGINS)
> -	$(QUIET_GEN)$(call do_generate_dynamic_list_file, $(PLUGINS), $@)
> -
> -$(OUTPUT)%.so: $(OUTPUT)%-in.o
> -	$(QUIET_LINK)$(CC) $(CFLAGS) -shared $(LDFLAGS) -nostartfiles -o $@ $^
> -
> -define update_dir
> -  (echo $1 > $@.tmp;                           \
> -   if [ -r $@ ] && cmp -s $@ $@.tmp; then      \
> -     rm -f $@.tmp;                             \
> -   else                                                \
> -     echo '  UPDATE                 $@';       \
> -     mv -f $@.tmp $@;                          \
> -   fi);
> -endef
> -
> -tags:	force
> -	$(RM) tags
> -	find . -name '*.[ch]' | xargs ctags --extra=+f --c-kinds=+px \
> -	--regex-c++='/_PE\(([^,)]*).*/TEP_ERRNO__\1/'
> -
> -TAGS:	force
> -	$(RM) TAGS
> -	find . -name '*.[ch]' | xargs etags \
> -	--regex='/_PE(\([^,)]*\).*/TEP_ERRNO__\1/'
> -
> -define do_install_mkdir
> -	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
> -		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
> -	fi
> -endef
> -
> -define do_install
> -	$(call do_install_mkdir,$2);                    \
> -	$(INSTALL) $(if $3,-m $3,) $1 '$(DESTDIR_SQ)$2'
> -endef
> -
> -define do_install_plugins
> -       for plugin in $1; do                            \
> -         $(call do_install,$$plugin,$(plugin_dir_SQ)); \
> -       done
> -endef
> -
> -define do_generate_dynamic_list_file
> -	symbol_type=`$(NM) -u -D $1 | awk 'NF>1 {print $$1}' | \
> -	xargs echo "U w W" | tr 'w ' 'W\n' | sort -u | xargs echo`;\
> -	if [ "$$symbol_type" = "U W" ];then				\
> -		(echo '{';                                              \
> -		$(NM) -u -D $1 | awk 'NF>1 {sub("@.*", "", $$2); print "\t"$$2";"}' | sort -u;\
> -		echo '};';                                              \
> -		) > $2;                                                 \
> -	else                                                            \
> -		(echo Either missing one of [$1] or bad version of $(NM)) 1>&2;\
> -		fi
> -endef
> -
> -install: $(PLUGINS)
> -	$(call QUIET_INSTALL, trace_plugins) \
> -	$(call do_install_plugins, $(PLUGINS))
> -
> -clean:
> -	$(call QUIET_CLEAN, trace_plugins) \
> -		$(RM) *.o *~ $(TARGETS) *.a *.so $(VERSION_FILES) .*.d .*.cmd; \
> -		$(RM) $(OUTPUT)libtraceevent-dynamic-list \
> -		$(RM) TRACEEVENT-CFLAGS tags TAGS;
> -
> -PHONY += force plugins
> -force:
> -
> -# Declare the contents of the .PHONY variable as phony.  We keep that
> -# information in a variable so we can use it in if_changed and friends.
> -.PHONY: $(PHONY)
> diff --git a/tools/lib/traceevent/plugins/plugin_cfg80211.c b/tools/lib/traceevent/plugins/plugin_cfg80211.c
> deleted file mode 100644
> index 3d43b56a6c98..000000000000
> --- a/tools/lib/traceevent/plugins/plugin_cfg80211.c
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <stdio.h>
> -#include <string.h>
> -#include <inttypes.h>
> -#include <endian.h>
> -#include "event-parse.h"
> -
> -/*
> - * From glibc endian.h, for older systems where it is not present, e.g.: RHEL5,
> - * Fedora6.
> - */
> -#ifndef le16toh
> -# if __BYTE_ORDER == __LITTLE_ENDIAN
> -#  define le16toh(x) (x)
> -# else
> -#  define le16toh(x) __bswap_16 (x)
> -# endif
> -#endif
> -
> -
> -static unsigned long long
> -process___le16_to_cpup(struct trace_seq *s, unsigned long long *args)
> -{
> -	uint16_t *val = (uint16_t *) (unsigned long) args[0];
> -	return val ? (long long) le16toh(*val) : 0;
> -}
> -
> -int TEP_PLUGIN_LOADER(struct tep_handle *tep)
> -{
> -	tep_register_print_function(tep,
> -				    process___le16_to_cpup,
> -				    TEP_FUNC_ARG_INT,
> -				    "__le16_to_cpup",
> -				    TEP_FUNC_ARG_PTR,
> -				    TEP_FUNC_ARG_VOID);
> -	return 0;
> -}
> -
> -void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
> -{
> -	tep_unregister_print_function(tep, process___le16_to_cpup,
> -				      "__le16_to_cpup");
> -}
> diff --git a/tools/lib/traceevent/plugins/plugin_function.c b/tools/lib/traceevent/plugins/plugin_function.c
> deleted file mode 100644
> index 807b16e1bf0f..000000000000
> --- a/tools/lib/traceevent/plugins/plugin_function.c
> +++ /dev/null
> @@ -1,282 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -
> -#include "event-parse.h"
> -#include "event-utils.h"
> -#include "trace-seq.h"
> -
> -static struct func_stack {
> -	int size;
> -	char **stack;
> -} *fstack;
> -
> -static int cpus = -1;
> -
> -#define STK_BLK 10
> -
> -struct tep_plugin_option plugin_options[] =
> -{
> -	{
> -		.name = "parent",
> -		.plugin_alias = "ftrace",
> -		.description =
> -		"Print parent of functions for function events",
> -	},
> -	{
> -		.name = "indent",
> -		.plugin_alias = "ftrace",
> -		.description =
> -		"Try to show function call indents, based on parents",
> -		.set = 1,
> -	},
> -	{
> -		.name = "offset",
> -		.plugin_alias = "ftrace",
> -		.description =
> -		"Show function names as well as their offsets",
> -		.set = 0,
> -	},
> -	{
> -		.name = NULL,
> -	}
> -};
> -
> -static struct tep_plugin_option *ftrace_parent = &plugin_options[0];
> -static struct tep_plugin_option *ftrace_indent = &plugin_options[1];
> -static struct tep_plugin_option *ftrace_offset = &plugin_options[2];
> -
> -static void add_child(struct func_stack *stack, const char *child, int pos)
> -{
> -	int i;
> -
> -	if (!child)
> -		return;
> -
> -	if (pos < stack->size)
> -		free(stack->stack[pos]);
> -	else {
> -		char **ptr;
> -
> -		ptr = realloc(stack->stack, sizeof(char *) *
> -			      (stack->size + STK_BLK));
> -		if (!ptr) {
> -			warning("could not allocate plugin memory\n");
> -			return;
> -		}
> -
> -		stack->stack = ptr;
> -
> -		for (i = stack->size; i < stack->size + STK_BLK; i++)
> -			stack->stack[i] = NULL;
> -		stack->size += STK_BLK;
> -	}
> -
> -	stack->stack[pos] = strdup(child);
> -}
> -
> -static int add_and_get_index(const char *parent, const char *child, int cpu)
> -{
> -	int i;
> -
> -	if (cpu < 0)
> -		return 0;
> -
> -	if (cpu > cpus) {
> -		struct func_stack *ptr;
> -
> -		ptr = realloc(fstack, sizeof(*fstack) * (cpu + 1));
> -		if (!ptr) {
> -			warning("could not allocate plugin memory\n");
> -			return 0;
> -		}
> -
> -		fstack = ptr;
> -
> -		/* Account for holes in the cpu count */
> -		for (i = cpus + 1; i <= cpu; i++)
> -			memset(&fstack[i], 0, sizeof(fstack[i]));
> -		cpus = cpu;
> -	}
> -
> -	for (i = 0; i < fstack[cpu].size && fstack[cpu].stack[i]; i++) {
> -		if (strcmp(parent, fstack[cpu].stack[i]) == 0) {
> -			add_child(&fstack[cpu], child, i+1);
> -			return i;
> -		}
> -	}
> -
> -	/* Not found */
> -	add_child(&fstack[cpu], parent, 0);
> -	add_child(&fstack[cpu], child, 1);
> -	return 0;
> -}
> -
> -static void show_function(struct trace_seq *s, struct tep_handle *tep,
> -			  const char *func, unsigned long long function)
> -{
> -	unsigned long long offset;
> -
> -	trace_seq_printf(s, "%s", func);
> -	if (ftrace_offset->set) {
> -		offset = tep_find_function_address(tep, function);
> -		trace_seq_printf(s, "+0x%x ", (int)(function - offset));
> -	}
> -}
> -
> -static int function_handler(struct trace_seq *s, struct tep_record *record,
> -			    struct tep_event *event, void *context)
> -{
> -	struct tep_handle *tep = event->tep;
> -	unsigned long long function;
> -	unsigned long long pfunction;
> -	const char *func;
> -	const char *parent;
> -	int index = 0;
> -
> -	if (tep_get_field_val(s, event, "ip", record, &function, 1))
> -		return trace_seq_putc(s, '!');
> -
> -	func = tep_find_function(tep, function);
> -
> -	if (tep_get_field_val(s, event, "parent_ip", record, &pfunction, 1))
> -		return trace_seq_putc(s, '!');
> -
> -	parent = tep_find_function(tep, pfunction);
> -
> -	if (parent && ftrace_indent->set)
> -		index = add_and_get_index(parent, func, record->cpu);
> -
> -	trace_seq_printf(s, "%*s", index*3, "");
> -
> -	if (func)
> -		show_function(s, tep, func, function);
> -	else
> -		trace_seq_printf(s, "0x%llx", function);
> -
> -	if (ftrace_parent->set) {
> -		trace_seq_printf(s, " <-- ");
> -		if (parent)
> -			show_function(s, tep, parent, pfunction);
> -		else
> -			trace_seq_printf(s, "0x%llx", pfunction);
> -	}
> -
> -	return 0;
> -}
> -
> -static int
> -trace_stack_handler(struct trace_seq *s, struct tep_record *record,
> -		    struct tep_event *event, void *context)
> -{
> -	struct tep_format_field *field;
> -	unsigned long long addr;
> -	const char *func;
> -	int long_size;
> -	void *data = record->data;
> -
> -	field = tep_find_any_field(event, "caller");
> -	if (!field) {
> -		trace_seq_printf(s, "<CANT FIND FIELD %s>", "caller");
> -		return 0;
> -	}
> -
> -	trace_seq_puts(s, "<stack trace >\n");
> -
> -	long_size = tep_get_long_size(event->tep);
> -
> -	for (data += field->offset; data < record->data + record->size;
> -	     data += long_size) {
> -		addr = tep_read_number(event->tep, data, long_size);
> -
> -		if ((long_size == 8 && addr == (unsigned long long)-1) ||
> -		    ((int)addr == -1))
> -			break;
> -
> -		func = tep_find_function(event->tep, addr);
> -		if (func)
> -			trace_seq_printf(s, "=> %s (%llx)\n", func, addr);
> -		else
> -			trace_seq_printf(s, "=> %llx\n", addr);
> -	}
> -
> -	return 0;
> -}
> -
> -static int
> -trace_raw_data_handler(struct trace_seq *s, struct tep_record *record,
> -		    struct tep_event *event, void *context)
> -{
> -	struct tep_format_field *field;
> -	unsigned long long id;
> -	int long_size;
> -	void *data = record->data;
> -
> -	if (tep_get_field_val(s, event, "id", record, &id, 1))
> -		return trace_seq_putc(s, '!');
> -
> -	trace_seq_printf(s, "# %llx", id);
> -
> -	field = tep_find_any_field(event, "buf");
> -	if (!field) {
> -		trace_seq_printf(s, "<CANT FIND FIELD %s>", "buf");
> -		return 0;
> -	}
> -
> -	long_size = tep_get_long_size(event->tep);
> -
> -	for (data += field->offset; data < record->data + record->size;
> -	     data += long_size) {
> -		int size = sizeof(long);
> -		int left = (record->data + record->size) - data;
> -		int i;
> -
> -		if (size > left)
> -			size = left;
> -
> -		for (i = 0; i < size; i++)
> -			trace_seq_printf(s, " %02x", *(unsigned char *)(data + i));
> -	}
> -
> -	return 0;
> -}
> -
> -int TEP_PLUGIN_LOADER(struct tep_handle *tep)
> -{
> -	tep_register_event_handler(tep, -1, "ftrace", "function",
> -				   function_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "ftrace", "kernel_stack",
> -				      trace_stack_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "ftrace", "raw_data",
> -				      trace_raw_data_handler, NULL);
> -
> -	tep_plugin_add_options("ftrace", plugin_options);
> -
> -	return 0;
> -}
> -
> -void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
> -{
> -	int i, x;
> -
> -	tep_unregister_event_handler(tep, -1, "ftrace", "function",
> -				     function_handler, NULL);
> -
> -	for (i = 0; i <= cpus; i++) {
> -		for (x = 0; x < fstack[i].size && fstack[i].stack[x]; x++)
> -			free(fstack[i].stack[x]);
> -		free(fstack[i].stack);
> -	}
> -
> -	tep_plugin_remove_options(plugin_options);
> -
> -	free(fstack);
> -	fstack = NULL;
> -	cpus = -1;
> -}
> diff --git a/tools/lib/traceevent/plugins/plugin_futex.c b/tools/lib/traceevent/plugins/plugin_futex.c
> deleted file mode 100644
> index eb7c9f8a850a..000000000000
> --- a/tools/lib/traceevent/plugins/plugin_futex.c
> +++ /dev/null
> @@ -1,123 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2017 National Instruments Corp.
> - *
> - * Author: Julia Cartwright <julia@ni.com>
> - *
> - */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <linux/futex.h>
> -
> -#include "event-parse.h"
> -
> -#define ARRAY_SIZE(_a) (sizeof(_a) / sizeof((_a)[0]))
> -
> -struct futex_args {
> -	unsigned long long	uaddr;
> -	unsigned long long	op;
> -	unsigned long long	val;
> -	unsigned long long	utime; /* or val2 */
> -	unsigned long long	uaddr2;
> -	unsigned long long	val3;
> -};
> -
> -struct futex_op {
> -	const char	*name;
> -	const char	*fmt_val;
> -	const char	*fmt_utime;
> -	const char	*fmt_uaddr2;
> -	const char	*fmt_val3;
> -};
> -
> -static const struct futex_op futex_op_tbl[] = {
> -	{            "FUTEX_WAIT", " val=0x%08llx", " utime=0x%08llx",               NULL,             NULL },
> -	{            "FUTEX_WAKE",     " val=%llu",              NULL,               NULL,             NULL },
> -	{              "FUTEX_FD",     " val=%llu",              NULL,               NULL,             NULL },
> -	{         "FUTEX_REQUEUE",     " val=%llu",      " val2=%llu", " uaddr2=0x%08llx",             NULL },
> -	{     "FUTEX_CMP_REQUEUE",     " val=%llu",      " val2=%llu", " uaddr2=0x%08llx", " val3=0x%08llx" },
> -	{         "FUTEX_WAKE_OP",     " val=%llu",      " val2=%llu", " uaddr2=0x%08llx", " val3=0x%08llx" },
> -	{         "FUTEX_LOCK_PI",            NULL, " utime=0x%08llx",               NULL,             NULL },
> -	{       "FUTEX_UNLOCK_PI",            NULL,              NULL,               NULL,             NULL },
> -	{      "FUTEX_TRYLOCK_PI",            NULL,              NULL,               NULL,             NULL },
> -	{     "FUTEX_WAIT_BITSET", " val=0x%08llx", " utime=0x%08llx",               NULL, " val3=0x%08llx" },
> -	{     "FUTEX_WAKE_BITSET",     " val=%llu",              NULL,               NULL, " val3=0x%08llx" },
> -	{ "FUTEX_WAIT_REQUEUE_PI", " val=0x%08llx", " utime=0x%08llx", " uaddr2=0x%08llx", " val3=0x%08llx" },
> -	{  "FUTEX_CMP_REQUEUE_PI",     " val=%llu",      " val2=%llu", " uaddr2=0x%08llx", " val3=0x%08llx" },
> -};
> -
> -
> -static void futex_print(struct trace_seq *s, const struct futex_args *args,
> -			const struct futex_op *fop)
> -{
> -	trace_seq_printf(s, " uaddr=0x%08llx", args->uaddr);
> -
> -	if (fop->fmt_val)
> -		trace_seq_printf(s, fop->fmt_val, args->val);
> -
> -	if (fop->fmt_utime)
> -		trace_seq_printf(s,fop->fmt_utime, args->utime);
> -
> -	if (fop->fmt_uaddr2)
> -		trace_seq_printf(s, fop->fmt_uaddr2, args->uaddr2);
> -
> -	if (fop->fmt_val3)
> -		trace_seq_printf(s, fop->fmt_val3, args->val3);
> -}
> -
> -static int futex_handler(struct trace_seq *s, struct tep_record *record,
> -			 struct tep_event *event, void *context)
> -{
> -	const struct futex_op *fop;
> -	struct futex_args args;
> -	unsigned long long cmd;
> -
> -	if (tep_get_field_val(s, event, "uaddr", record, &args.uaddr, 1))
> -		return 1;
> -
> -	if (tep_get_field_val(s, event, "op", record, &args.op, 1))
> -		return 1;
> -
> -	if (tep_get_field_val(s, event, "val", record, &args.val, 1))
> -		return 1;
> -
> -	if (tep_get_field_val(s, event, "utime", record, &args.utime, 1))
> -		return 1;
> -
> -	if (tep_get_field_val(s, event, "uaddr2", record, &args.uaddr2, 1))
> -		return 1;
> -
> -	if (tep_get_field_val(s, event, "val3", record, &args.val3, 1))
> -		return 1;
> -
> -	cmd = args.op & FUTEX_CMD_MASK;
> -	if (cmd >= ARRAY_SIZE(futex_op_tbl))
> -		return 1;
> -
> -	fop = &futex_op_tbl[cmd];
> -
> -	trace_seq_printf(s, "op=%s", fop->name);
> -
> -	if (args.op & FUTEX_PRIVATE_FLAG)
> -		trace_seq_puts(s, "|FUTEX_PRIVATE_FLAG");
> -
> -	if (args.op & FUTEX_CLOCK_REALTIME)
> -		trace_seq_puts(s, "|FUTEX_CLOCK_REALTIME");
> -
> -	futex_print(s, &args, fop);
> -	return 0;
> -}
> -
> -int TEP_PLUGIN_LOADER(struct tep_handle *tep)
> -{
> -	tep_register_event_handler(tep, -1, "syscalls", "sys_enter_futex",
> -				   futex_handler, NULL);
> -	return 0;
> -}
> -
> -void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
> -{
> -	tep_unregister_event_handler(tep, -1, "syscalls", "sys_enter_futex",
> -				     futex_handler, NULL);
> -}
> diff --git a/tools/lib/traceevent/plugins/plugin_hrtimer.c b/tools/lib/traceevent/plugins/plugin_hrtimer.c
> deleted file mode 100644
> index d98466788f14..000000000000
> --- a/tools/lib/traceevent/plugins/plugin_hrtimer.c
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2009 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - * Copyright (C) 2009 Johannes Berg <johannes@sipsolutions.net>
> - */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -
> -#include "event-parse.h"
> -#include "trace-seq.h"
> -
> -static int timer_expire_handler(struct trace_seq *s,
> -				struct tep_record *record,
> -				struct tep_event *event, void *context)
> -{
> -	trace_seq_printf(s, "hrtimer=");
> -
> -	if (tep_print_num_field(s, "0x%llx", event, "timer",
> -				record, 0) == -1)
> -		tep_print_num_field(s, "0x%llx", event, "hrtimer",
> -				    record, 1);
> -
> -	trace_seq_printf(s, " now=");
> -
> -	tep_print_num_field(s, "%llu", event, "now", record, 1);
> -
> -	tep_print_func_field(s, " function=%s", event, "function",
> -				record, 0);
> -	return 0;
> -}
> -
> -static int timer_start_handler(struct trace_seq *s,
> -			       struct tep_record *record,
> -			       struct tep_event *event, void *context)
> -{
> -	trace_seq_printf(s, "hrtimer=");
> -
> -	if (tep_print_num_field(s, "0x%llx", event, "timer",
> -				record, 0) == -1)
> -		tep_print_num_field(s, "0x%llx", event, "hrtimer",
> -				    record, 1);
> -
> -	tep_print_func_field(s, " function=%s", event, "function",
> -			     record, 0);
> -
> -	trace_seq_printf(s, " expires=");
> -	tep_print_num_field(s, "%llu", event, "expires", record, 1);
> -
> -	trace_seq_printf(s, " softexpires=");
> -	tep_print_num_field(s, "%llu", event, "softexpires", record, 1);
> -	return 0;
> -}
> -
> -int TEP_PLUGIN_LOADER(struct tep_handle *tep)
> -{
> -	tep_register_event_handler(tep, -1,
> -				   "timer", "hrtimer_expire_entry",
> -				   timer_expire_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "timer", "hrtimer_start",
> -				   timer_start_handler, NULL);
> -	return 0;
> -}
> -
> -void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
> -{
> -	tep_unregister_event_handler(tep, -1,
> -				     "timer", "hrtimer_expire_entry",
> -				     timer_expire_handler, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "timer", "hrtimer_start",
> -				     timer_start_handler, NULL);
> -}
> diff --git a/tools/lib/traceevent/plugins/plugin_jbd2.c b/tools/lib/traceevent/plugins/plugin_jbd2.c
> deleted file mode 100644
> index 69111a68d3cf..000000000000
> --- a/tools/lib/traceevent/plugins/plugin_jbd2.c
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -
> -#include "event-parse.h"
> -#include "trace-seq.h"
> -
> -#define MINORBITS	20
> -#define MINORMASK	((1U << MINORBITS) - 1)
> -
> -#define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
> -#define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
> -
> -static unsigned long long
> -process_jbd2_dev_to_name(struct trace_seq *s, unsigned long long *args)
> -{
> -	unsigned int dev = args[0];
> -
> -	trace_seq_printf(s, "%d:%d", MAJOR(dev), MINOR(dev));
> -	return 0;
> -}
> -
> -static unsigned long long
> -process_jiffies_to_msecs(struct trace_seq *s, unsigned long long *args)
> -{
> -	unsigned long long jiffies = args[0];
> -
> -	trace_seq_printf(s, "%lld", jiffies);
> -	return jiffies;
> -}
> -
> -int TEP_PLUGIN_LOADER(struct tep_handle *tep)
> -{
> -	tep_register_print_function(tep,
> -				    process_jbd2_dev_to_name,
> -				    TEP_FUNC_ARG_STRING,
> -				    "jbd2_dev_to_name",
> -				    TEP_FUNC_ARG_INT,
> -				    TEP_FUNC_ARG_VOID);
> -
> -	tep_register_print_function(tep,
> -				    process_jiffies_to_msecs,
> -				    TEP_FUNC_ARG_LONG,
> -				    "jiffies_to_msecs",
> -				    TEP_FUNC_ARG_LONG,
> -				    TEP_FUNC_ARG_VOID);
> -	return 0;
> -}
> -
> -void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
> -{
> -	tep_unregister_print_function(tep, process_jbd2_dev_to_name,
> -				      "jbd2_dev_to_name");
> -
> -	tep_unregister_print_function(tep, process_jiffies_to_msecs,
> -				      "jiffies_to_msecs");
> -}
> diff --git a/tools/lib/traceevent/plugins/plugin_kmem.c b/tools/lib/traceevent/plugins/plugin_kmem.c
> deleted file mode 100644
> index 4b4f7f9616e3..000000000000
> --- a/tools/lib/traceevent/plugins/plugin_kmem.c
> +++ /dev/null
> @@ -1,80 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2009 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -
> -#include "event-parse.h"
> -#include "trace-seq.h"
> -
> -static int call_site_handler(struct trace_seq *s, struct tep_record *record,
> -			     struct tep_event *event, void *context)
> -{
> -	struct tep_format_field *field;
> -	unsigned long long val, addr;
> -	void *data = record->data;
> -	const char *func;
> -
> -	field = tep_find_field(event, "call_site");
> -	if (!field)
> -		return 1;
> -
> -	if (tep_read_number_field(field, data, &val))
> -		return 1;
> -
> -	func = tep_find_function(event->tep, val);
> -	if (!func)
> -		return 1;
> -
> -	addr = tep_find_function_address(event->tep, val);
> -
> -	trace_seq_printf(s, "(%s+0x%x) ", func, (int)(val - addr));
> -	return 1;
> -}
> -
> -int TEP_PLUGIN_LOADER(struct tep_handle *tep)
> -{
> -	tep_register_event_handler(tep, -1, "kmem", "kfree",
> -				   call_site_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "kmem", "kmalloc",
> -				   call_site_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "kmem", "kmalloc_node",
> -				   call_site_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "kmem", "kmem_cache_alloc",
> -				   call_site_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "kmem",
> -				   "kmem_cache_alloc_node",
> -				   call_site_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "kmem", "kmem_cache_free",
> -				   call_site_handler, NULL);
> -	return 0;
> -}
> -
> -void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
> -{
> -	tep_unregister_event_handler(tep, -1, "kmem", "kfree",
> -				     call_site_handler, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "kmem", "kmalloc",
> -				     call_site_handler, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "kmem", "kmalloc_node",
> -				     call_site_handler, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "kmem", "kmem_cache_alloc",
> -				     call_site_handler, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "kmem",
> -				     "kmem_cache_alloc_node",
> -				     call_site_handler, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "kmem", "kmem_cache_free",
> -				     call_site_handler, NULL);
> -}
> diff --git a/tools/lib/traceevent/plugins/plugin_kvm.c b/tools/lib/traceevent/plugins/plugin_kvm.c
> deleted file mode 100644
> index 9ce7b4b68e3f..000000000000
> --- a/tools/lib/traceevent/plugins/plugin_kvm.c
> +++ /dev/null
> @@ -1,527 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2009 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <stdint.h>
> -
> -#include "event-parse.h"
> -#include "trace-seq.h"
> -
> -#ifdef HAVE_UDIS86
> -
> -#include <udis86.h>
> -
> -static ud_t ud;
> -
> -static void init_disassembler(void)
> -{
> -	ud_init(&ud);
> -	ud_set_syntax(&ud, UD_SYN_ATT);
> -}
> -
> -static const char *disassemble(unsigned char *insn, int len, uint64_t rip,
> -			       int cr0_pe, int eflags_vm,
> -			       int cs_d, int cs_l)
> -{
> -	int mode;
> -
> -	if (!cr0_pe)
> -		mode = 16;
> -	else if (eflags_vm)
> -		mode = 16;
> -	else if (cs_l)
> -		mode = 64;
> -	else if (cs_d)
> -		mode = 32;
> -	else
> -		mode = 16;
> -
> -	ud_set_pc(&ud, rip);
> -	ud_set_mode(&ud, mode);
> -	ud_set_input_buffer(&ud, insn, len);
> -	ud_disassemble(&ud);
> -	return ud_insn_asm(&ud);
> -}
> -
> -#else
> -
> -static void init_disassembler(void)
> -{
> -}
> -
> -static const char *disassemble(unsigned char *insn, int len, uint64_t rip,
> -			       int cr0_pe, int eflags_vm,
> -			       int cs_d, int cs_l)
> -{
> -	static char out[15*3+1];
> -	int i;
> -
> -	for (i = 0; i < len; ++i)
> -		sprintf(out + i * 3, "%02x ", insn[i]);
> -	out[len*3-1] = '\0';
> -	return out;
> -}
> -
> -#endif
> -
> -
> -#define VMX_EXIT_REASONS			\
> -	_ER(EXCEPTION_NMI,	 0)		\
> -	_ER(EXTERNAL_INTERRUPT,	 1)		\
> -	_ER(TRIPLE_FAULT,	 2)		\
> -	_ER(PENDING_INTERRUPT,	 7)		\
> -	_ER(NMI_WINDOW,		 8)		\
> -	_ER(TASK_SWITCH,	 9)		\
> -	_ER(CPUID,		 10)		\
> -	_ER(HLT,		 12)		\
> -	_ER(INVD,		 13)		\
> -	_ER(INVLPG,		 14)		\
> -	_ER(RDPMC,		 15)		\
> -	_ER(RDTSC,		 16)		\
> -	_ER(VMCALL,		 18)		\
> -	_ER(VMCLEAR,		 19)		\
> -	_ER(VMLAUNCH,		 20)		\
> -	_ER(VMPTRLD,		 21)		\
> -	_ER(VMPTRST,		 22)		\
> -	_ER(VMREAD,		 23)		\
> -	_ER(VMRESUME,		 24)		\
> -	_ER(VMWRITE,		 25)		\
> -	_ER(VMOFF,		 26)		\
> -	_ER(VMON,		 27)		\
> -	_ER(CR_ACCESS,		 28)		\
> -	_ER(DR_ACCESS,		 29)		\
> -	_ER(IO_INSTRUCTION,	 30)		\
> -	_ER(MSR_READ,		 31)		\
> -	_ER(MSR_WRITE,		 32)		\
> -	_ER(MWAIT_INSTRUCTION,	 36)		\
> -	_ER(MONITOR_INSTRUCTION, 39)		\
> -	_ER(PAUSE_INSTRUCTION,	 40)		\
> -	_ER(MCE_DURING_VMENTRY,	 41)		\
> -	_ER(TPR_BELOW_THRESHOLD, 43)		\
> -	_ER(APIC_ACCESS,	 44)		\
> -	_ER(EOI_INDUCED,	 45)		\
> -	_ER(EPT_VIOLATION,	 48)		\
> -	_ER(EPT_MISCONFIG,	 49)		\
> -	_ER(INVEPT,		 50)		\
> -	_ER(PREEMPTION_TIMER,	 52)		\
> -	_ER(WBINVD,		 54)		\
> -	_ER(XSETBV,		 55)		\
> -	_ER(APIC_WRITE,		 56)		\
> -	_ER(INVPCID,		 58)		\
> -	_ER(PML_FULL,		 62)		\
> -	_ER(XSAVES,		 63)		\
> -	_ER(XRSTORS,		 64)
> -
> -#define SVM_EXIT_REASONS \
> -	_ER(EXIT_READ_CR0,	0x000)		\
> -	_ER(EXIT_READ_CR3,	0x003)		\
> -	_ER(EXIT_READ_CR4,	0x004)		\
> -	_ER(EXIT_READ_CR8,	0x008)		\
> -	_ER(EXIT_WRITE_CR0,	0x010)		\
> -	_ER(EXIT_WRITE_CR3,	0x013)		\
> -	_ER(EXIT_WRITE_CR4,	0x014)		\
> -	_ER(EXIT_WRITE_CR8,	0x018)		\
> -	_ER(EXIT_READ_DR0,	0x020)		\
> -	_ER(EXIT_READ_DR1,	0x021)		\
> -	_ER(EXIT_READ_DR2,	0x022)		\
> -	_ER(EXIT_READ_DR3,	0x023)		\
> -	_ER(EXIT_READ_DR4,	0x024)		\
> -	_ER(EXIT_READ_DR5,	0x025)		\
> -	_ER(EXIT_READ_DR6,	0x026)		\
> -	_ER(EXIT_READ_DR7,	0x027)		\
> -	_ER(EXIT_WRITE_DR0,	0x030)		\
> -	_ER(EXIT_WRITE_DR1,	0x031)		\
> -	_ER(EXIT_WRITE_DR2,	0x032)		\
> -	_ER(EXIT_WRITE_DR3,	0x033)		\
> -	_ER(EXIT_WRITE_DR4,	0x034)		\
> -	_ER(EXIT_WRITE_DR5,	0x035)		\
> -	_ER(EXIT_WRITE_DR6,	0x036)		\
> -	_ER(EXIT_WRITE_DR7,	0x037)		\
> -	_ER(EXIT_EXCP_DE,	0x040)		\
> -	_ER(EXIT_EXCP_DB,	0x041)		\
> -	_ER(EXIT_EXCP_BP,	0x043)		\
> -	_ER(EXIT_EXCP_OF,	0x044)		\
> -	_ER(EXIT_EXCP_BR,	0x045)		\
> -	_ER(EXIT_EXCP_UD,	0x046)		\
> -	_ER(EXIT_EXCP_NM,	0x047)		\
> -	_ER(EXIT_EXCP_DF,	0x048)		\
> -	_ER(EXIT_EXCP_TS,	0x04a)		\
> -	_ER(EXIT_EXCP_NP,	0x04b)		\
> -	_ER(EXIT_EXCP_SS,	0x04c)		\
> -	_ER(EXIT_EXCP_GP,	0x04d)		\
> -	_ER(EXIT_EXCP_PF,	0x04e)		\
> -	_ER(EXIT_EXCP_MF,	0x050)		\
> -	_ER(EXIT_EXCP_AC,	0x051)		\
> -	_ER(EXIT_EXCP_MC,	0x052)		\
> -	_ER(EXIT_EXCP_XF,	0x053)		\
> -	_ER(EXIT_INTR,		0x060)		\
> -	_ER(EXIT_NMI,		0x061)		\
> -	_ER(EXIT_SMI,		0x062)		\
> -	_ER(EXIT_INIT,		0x063)		\
> -	_ER(EXIT_VINTR,		0x064)		\
> -	_ER(EXIT_CR0_SEL_WRITE,	0x065)		\
> -	_ER(EXIT_IDTR_READ,	0x066)		\
> -	_ER(EXIT_GDTR_READ,	0x067)		\
> -	_ER(EXIT_LDTR_READ,	0x068)		\
> -	_ER(EXIT_TR_READ,	0x069)		\
> -	_ER(EXIT_IDTR_WRITE,	0x06a)		\
> -	_ER(EXIT_GDTR_WRITE,	0x06b)		\
> -	_ER(EXIT_LDTR_WRITE,	0x06c)		\
> -	_ER(EXIT_TR_WRITE,	0x06d)		\
> -	_ER(EXIT_RDTSC,		0x06e)		\
> -	_ER(EXIT_RDPMC,		0x06f)		\
> -	_ER(EXIT_PUSHF,		0x070)		\
> -	_ER(EXIT_POPF,		0x071)		\
> -	_ER(EXIT_CPUID,		0x072)		\
> -	_ER(EXIT_RSM,		0x073)		\
> -	_ER(EXIT_IRET,		0x074)		\
> -	_ER(EXIT_SWINT,		0x075)		\
> -	_ER(EXIT_INVD,		0x076)		\
> -	_ER(EXIT_PAUSE,		0x077)		\
> -	_ER(EXIT_HLT,		0x078)		\
> -	_ER(EXIT_INVLPG,	0x079)		\
> -	_ER(EXIT_INVLPGA,	0x07a)		\
> -	_ER(EXIT_IOIO,		0x07b)		\
> -	_ER(EXIT_MSR,		0x07c)		\
> -	_ER(EXIT_TASK_SWITCH,	0x07d)		\
> -	_ER(EXIT_FERR_FREEZE,	0x07e)		\
> -	_ER(EXIT_SHUTDOWN,	0x07f)		\
> -	_ER(EXIT_VMRUN,		0x080)		\
> -	_ER(EXIT_VMMCALL,	0x081)		\
> -	_ER(EXIT_VMLOAD,	0x082)		\
> -	_ER(EXIT_VMSAVE,	0x083)		\
> -	_ER(EXIT_STGI,		0x084)		\
> -	_ER(EXIT_CLGI,		0x085)		\
> -	_ER(EXIT_SKINIT,	0x086)		\
> -	_ER(EXIT_RDTSCP,	0x087)		\
> -	_ER(EXIT_ICEBP,		0x088)		\
> -	_ER(EXIT_WBINVD,	0x089)		\
> -	_ER(EXIT_MONITOR,	0x08a)		\
> -	_ER(EXIT_MWAIT,		0x08b)		\
> -	_ER(EXIT_MWAIT_COND,	0x08c)		\
> -	_ER(EXIT_XSETBV,	0x08d)		\
> -	_ER(EXIT_NPF, 		0x400)		\
> -	_ER(EXIT_AVIC_INCOMPLETE_IPI,		0x401)	\
> -	_ER(EXIT_AVIC_UNACCELERATED_ACCESS,	0x402)	\
> -	_ER(EXIT_ERR,		-1)
> -
> -#define _ER(reason, val)	{ #reason, val },
> -struct str_values {
> -	const char	*str;
> -	int		val;
> -};
> -
> -static struct str_values vmx_exit_reasons[] = {
> -	VMX_EXIT_REASONS
> -	{ NULL, -1}
> -};
> -
> -static struct str_values svm_exit_reasons[] = {
> -	SVM_EXIT_REASONS
> -	{ NULL, -1}
> -};
> -
> -static struct isa_exit_reasons {
> -	unsigned isa;
> -	struct str_values *strings;
> -} isa_exit_reasons[] = {
> -	{ .isa = 1, .strings = vmx_exit_reasons },
> -	{ .isa = 2, .strings = svm_exit_reasons },
> -	{ }
> -};
> -
> -static const char *find_exit_reason(unsigned isa, int val)
> -{
> -	struct str_values *strings = NULL;
> -	int i;
> -
> -	for (i = 0; isa_exit_reasons[i].strings; ++i)
> -		if (isa_exit_reasons[i].isa == isa) {
> -			strings = isa_exit_reasons[i].strings;
> -			break;
> -		}
> -	if (!strings)
> -		return "UNKNOWN-ISA";
> -	for (i = 0; strings[i].str; i++)
> -		if (strings[i].val == val)
> -			break;
> -
> -	return strings[i].str;
> -}
> -
> -static int print_exit_reason(struct trace_seq *s, struct tep_record *record,
> -			     struct tep_event *event, const char *field)
> -{
> -	unsigned long long isa;
> -	unsigned long long val;
> -	const char *reason;
> -
> -	if (tep_get_field_val(s, event, field, record, &val, 1) < 0)
> -		return -1;
> -
> -	if (tep_get_field_val(s, event, "isa", record, &isa, 0) < 0)
> -		isa = 1;
> -
> -	reason = find_exit_reason(isa, val);
> -	if (reason)
> -		trace_seq_printf(s, "reason %s", reason);
> -	else
> -		trace_seq_printf(s, "reason UNKNOWN (%llu)", val);
> -	return 0;
> -}
> -
> -static int kvm_exit_handler(struct trace_seq *s, struct tep_record *record,
> -			    struct tep_event *event, void *context)
> -{
> -	unsigned long long info1 = 0, info2 = 0;
> -
> -	if (print_exit_reason(s, record, event, "exit_reason") < 0)
> -		return -1;
> -
> -	tep_print_num_field(s, " rip 0x%lx", event, "guest_rip", record, 1);
> -
> -	if (tep_get_field_val(s, event, "info1", record, &info1, 0) >= 0
> -	    && tep_get_field_val(s, event, "info2", record, &info2, 0) >= 0)
> -		trace_seq_printf(s, " info %llx %llx", info1, info2);
> -
> -	return 0;
> -}
> -
> -#define KVM_EMUL_INSN_F_CR0_PE (1 << 0)
> -#define KVM_EMUL_INSN_F_EFL_VM (1 << 1)
> -#define KVM_EMUL_INSN_F_CS_D   (1 << 2)
> -#define KVM_EMUL_INSN_F_CS_L   (1 << 3)
> -
> -static int kvm_emulate_insn_handler(struct trace_seq *s,
> -				    struct tep_record *record,
> -				    struct tep_event *event, void *context)
> -{
> -	unsigned long long rip, csbase, len, flags, failed;
> -	int llen;
> -	uint8_t *insn;
> -	const char *disasm;
> -
> -	if (tep_get_field_val(s, event, "rip", record, &rip, 1) < 0)
> -		return -1;
> -
> -	if (tep_get_field_val(s, event, "csbase", record, &csbase, 1) < 0)
> -		return -1;
> -
> -	if (tep_get_field_val(s, event, "len", record, &len, 1) < 0)
> -		return -1;
> -
> -	if (tep_get_field_val(s, event, "flags", record, &flags, 1) < 0)
> -		return -1;
> -
> -	if (tep_get_field_val(s, event, "failed", record, &failed, 1) < 0)
> -		return -1;
> -
> -	insn = tep_get_field_raw(s, event, "insn", record, &llen, 1);
> -	if (!insn)
> -		return -1;
> -
> -	disasm = disassemble(insn, len, rip,
> -			     flags & KVM_EMUL_INSN_F_CR0_PE,
> -			     flags & KVM_EMUL_INSN_F_EFL_VM,
> -			     flags & KVM_EMUL_INSN_F_CS_D,
> -			     flags & KVM_EMUL_INSN_F_CS_L);
> -
> -	trace_seq_printf(s, "%llx:%llx: %s%s", csbase, rip, disasm,
> -			 failed ? " FAIL" : "");
> -	return 0;
> -}
> -
> -
> -static int kvm_nested_vmexit_inject_handler(struct trace_seq *s, struct tep_record *record,
> -					    struct tep_event *event, void *context)
> -{
> -	if (print_exit_reason(s, record, event, "exit_code") < 0)
> -		return -1;
> -
> -	tep_print_num_field(s, " info1 %llx", event, "exit_info1", record, 1);
> -	tep_print_num_field(s, " info2 %llx", event, "exit_info2", record, 1);
> -	tep_print_num_field(s, " int_info %llx", event, "exit_int_info", record, 1);
> -	tep_print_num_field(s, " int_info_err %llx", event, "exit_int_info_err", record, 1);
> -
> -	return 0;
> -}
> -
> -static int kvm_nested_vmexit_handler(struct trace_seq *s, struct tep_record *record,
> -				     struct tep_event *event, void *context)
> -{
> -	tep_print_num_field(s, "rip %llx ", event, "rip", record, 1);
> -
> -	return kvm_nested_vmexit_inject_handler(s, record, event, context);
> -}
> -
> -union kvm_mmu_page_role {
> -	unsigned word;
> -	struct {
> -		unsigned level:4;
> -		unsigned cr4_pae:1;
> -		unsigned quadrant:2;
> -		unsigned direct:1;
> -		unsigned access:3;
> -		unsigned invalid:1;
> -		unsigned efer_nx:1;
> -		unsigned cr0_wp:1;
> -		unsigned smep_and_not_wp:1;
> -		unsigned smap_and_not_wp:1;
> -		unsigned pad_for_nice_hex_output:8;
> -		unsigned smm:8;
> -	};
> -};
> -
> -static int kvm_mmu_print_role(struct trace_seq *s, struct tep_record *record,
> -			      struct tep_event *event, void *context)
> -{
> -	unsigned long long val;
> -	static const char *access_str[] = {
> -		"---", "--x", "w--", "w-x", "-u-", "-ux", "wu-", "wux"
> -	};
> -	union kvm_mmu_page_role role;
> -
> -	if (tep_get_field_val(s, event, "role", record, &val, 1) < 0)
> -		return -1;
> -
> -	role.word = (int)val;
> -
> -	/*
> -	 * We can only use the structure if file is of the same
> -	 * endianness.
> -	 */
> -	if (tep_is_file_bigendian(event->tep) ==
> -	    tep_is_local_bigendian(event->tep)) {
> -
> -		trace_seq_printf(s, "%u q%u%s %s%s %spae %snxe %swp%s%s%s",
> -				 role.level,
> -				 role.quadrant,
> -				 role.direct ? " direct" : "",
> -				 access_str[role.access],
> -				 role.invalid ? " invalid" : "",
> -				 role.cr4_pae ? "" : "!",
> -				 role.efer_nx ? "" : "!",
> -				 role.cr0_wp ? "" : "!",
> -				 role.smep_and_not_wp ? " smep" : "",
> -				 role.smap_and_not_wp ? " smap" : "",
> -				 role.smm ? " smm" : "");
> -	} else
> -		trace_seq_printf(s, "WORD: %08x", role.word);
> -
> -	tep_print_num_field(s, " root %u ",  event,
> -			    "root_count", record, 1);
> -
> -	if (tep_get_field_val(s, event, "unsync", record, &val, 1) < 0)
> -		return -1;
> -
> -	trace_seq_printf(s, "%s%c",  val ? "unsync" : "sync", 0);
> -	return 0;
> -}
> -
> -static int kvm_mmu_get_page_handler(struct trace_seq *s,
> -				    struct tep_record *record,
> -				    struct tep_event *event, void *context)
> -{
> -	unsigned long long val;
> -
> -	if (tep_get_field_val(s, event, "created", record, &val, 1) < 0)
> -		return -1;
> -
> -	trace_seq_printf(s, "%s ", val ? "new" : "existing");
> -
> -	if (tep_get_field_val(s, event, "gfn", record, &val, 1) < 0)
> -		return -1;
> -
> -	trace_seq_printf(s, "sp gfn %llx ", val);
> -	return kvm_mmu_print_role(s, record, event, context);
> -}
> -
> -#define PT_WRITABLE_SHIFT 1
> -#define PT_WRITABLE_MASK (1ULL << PT_WRITABLE_SHIFT)
> -
> -static unsigned long long
> -process_is_writable_pte(struct trace_seq *s, unsigned long long *args)
> -{
> -	unsigned long pte = args[0];
> -	return pte & PT_WRITABLE_MASK;
> -}
> -
> -int TEP_PLUGIN_LOADER(struct tep_handle *tep)
> -{
> -	init_disassembler();
> -
> -	tep_register_event_handler(tep, -1, "kvm", "kvm_exit",
> -				   kvm_exit_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "kvm", "kvm_emulate_insn",
> -				   kvm_emulate_insn_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "kvm", "kvm_nested_vmexit",
> -				   kvm_nested_vmexit_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "kvm", "kvm_nested_vmexit_inject",
> -				   kvm_nested_vmexit_inject_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "kvmmmu", "kvm_mmu_get_page",
> -				   kvm_mmu_get_page_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "kvmmmu", "kvm_mmu_sync_page",
> -				   kvm_mmu_print_role, NULL);
> -
> -	tep_register_event_handler(tep, -1,
> -				   "kvmmmu", "kvm_mmu_unsync_page",
> -				   kvm_mmu_print_role, NULL);
> -
> -	tep_register_event_handler(tep, -1, "kvmmmu", "kvm_mmu_zap_page",
> -				   kvm_mmu_print_role, NULL);
> -
> -	tep_register_event_handler(tep, -1, "kvmmmu",
> -			"kvm_mmu_prepare_zap_page", kvm_mmu_print_role,
> -			NULL);
> -
> -	tep_register_print_function(tep,
> -				    process_is_writable_pte,
> -				    TEP_FUNC_ARG_INT,
> -				    "is_writable_pte",
> -				    TEP_FUNC_ARG_LONG,
> -				    TEP_FUNC_ARG_VOID);
> -	return 0;
> -}
> -
> -void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
> -{
> -	tep_unregister_event_handler(tep, -1, "kvm", "kvm_exit",
> -				     kvm_exit_handler, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "kvm", "kvm_emulate_insn",
> -				     kvm_emulate_insn_handler, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "kvm", "kvm_nested_vmexit",
> -				     kvm_nested_vmexit_handler, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "kvm", "kvm_nested_vmexit_inject",
> -				     kvm_nested_vmexit_inject_handler, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "kvmmmu", "kvm_mmu_get_page",
> -				     kvm_mmu_get_page_handler, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "kvmmmu", "kvm_mmu_sync_page",
> -				     kvm_mmu_print_role, NULL);
> -
> -	tep_unregister_event_handler(tep, -1,
> -				     "kvmmmu", "kvm_mmu_unsync_page",
> -				     kvm_mmu_print_role, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "kvmmmu", "kvm_mmu_zap_page",
> -				     kvm_mmu_print_role, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "kvmmmu",
> -			"kvm_mmu_prepare_zap_page", kvm_mmu_print_role,
> -			NULL);
> -
> -	tep_unregister_print_function(tep, process_is_writable_pte,
> -				      "is_writable_pte");
> -}
> diff --git a/tools/lib/traceevent/plugins/plugin_mac80211.c b/tools/lib/traceevent/plugins/plugin_mac80211.c
> deleted file mode 100644
> index f48071e3cfb8..000000000000
> --- a/tools/lib/traceevent/plugins/plugin_mac80211.c
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2009 Johannes Berg <johannes@sipsolutions.net>
> - */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -
> -#include "event-parse.h"
> -#include "trace-seq.h"
> -
> -#define INDENT 65
> -
> -static void print_string(struct trace_seq *s, struct tep_event *event,
> -			 const char *name, const void *data)
> -{
> -	struct tep_format_field *f = tep_find_field(event, name);
> -	int offset;
> -	int length;
> -
> -	if (!f) {
> -		trace_seq_printf(s, "NOTFOUND:%s", name);
> -		return;
> -	}
> -
> -	offset = f->offset;
> -	length = f->size;
> -
> -	if (!strncmp(f->type, "__data_loc", 10)) {
> -		unsigned long long v;
> -		if (tep_read_number_field(f, data, &v)) {
> -			trace_seq_printf(s, "invalid_data_loc");
> -			return;
> -		}
> -		offset = v & 0xffff;
> -		length = v >> 16;
> -	}
> -
> -	trace_seq_printf(s, "%.*s", length, (char *)data + offset);
> -}
> -
> -#define SF(fn)	tep_print_num_field(s, fn ":%d", event, fn, record, 0)
> -#define SFX(fn)	tep_print_num_field(s, fn ":%#x", event, fn, record, 0)
> -#define SP()	trace_seq_putc(s, ' ')
> -
> -static int drv_bss_info_changed(struct trace_seq *s,
> -				struct tep_record *record,
> -				struct tep_event *event, void *context)
> -{
> -	void *data = record->data;
> -
> -	print_string(s, event, "wiphy_name", data);
> -	trace_seq_printf(s, " vif:");
> -	print_string(s, event, "vif_name", data);
> -	tep_print_num_field(s, "(%d)", event, "vif_type", record, 1);
> -
> -	trace_seq_printf(s, "\n%*s", INDENT, "");
> -	SF("assoc"); SP();
> -	SF("aid"); SP();
> -	SF("cts"); SP();
> -	SF("shortpre"); SP();
> -	SF("shortslot"); SP();
> -	SF("dtimper"); SP();
> -	trace_seq_printf(s, "\n%*s", INDENT, "");
> -	SF("bcnint"); SP();
> -	SFX("assoc_cap"); SP();
> -	SFX("basic_rates"); SP();
> -	SF("enable_beacon");
> -	trace_seq_printf(s, "\n%*s", INDENT, "");
> -	SF("ht_operation_mode");
> -
> -	return 0;
> -}
> -
> -int TEP_PLUGIN_LOADER(struct tep_handle *tep)
> -{
> -	tep_register_event_handler(tep, -1, "mac80211",
> -				   "drv_bss_info_changed",
> -				   drv_bss_info_changed, NULL);
> -	return 0;
> -}
> -
> -void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
> -{
> -	tep_unregister_event_handler(tep, -1, "mac80211",
> -				     "drv_bss_info_changed",
> -				     drv_bss_info_changed, NULL);
> -}
> diff --git a/tools/lib/traceevent/plugins/plugin_sched_switch.c b/tools/lib/traceevent/plugins/plugin_sched_switch.c
> deleted file mode 100644
> index e12fa103820a..000000000000
> --- a/tools/lib/traceevent/plugins/plugin_sched_switch.c
> +++ /dev/null
> @@ -1,146 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -
> -#include "event-parse.h"
> -#include "trace-seq.h"
> -
> -static void write_state(struct trace_seq *s, int val)
> -{
> -	const char states[] = "SDTtZXxW";
> -	int found = 0;
> -	int i;
> -
> -	for (i = 0; i < (sizeof(states) - 1); i++) {
> -		if (!(val & (1 << i)))
> -			continue;
> -
> -		if (found)
> -			trace_seq_putc(s, '|');
> -
> -		found = 1;
> -		trace_seq_putc(s, states[i]);
> -	}
> -
> -	if (!found)
> -		trace_seq_putc(s, 'R');
> -}
> -
> -static void write_and_save_comm(struct tep_format_field *field,
> -				struct tep_record *record,
> -				struct trace_seq *s, int pid)
> -{
> -	const char *comm;
> -	int len;
> -
> -	comm = (char *)(record->data + field->offset);
> -	len = s->len;
> -	trace_seq_printf(s, "%.*s",
> -			 field->size, comm);
> -
> -	/* make sure the comm has a \0 at the end. */
> -	trace_seq_terminate(s);
> -	comm = &s->buffer[len];
> -
> -	/* Help out the comm to ids. This will handle dups */
> -	tep_register_comm(field->event->tep, comm, pid);
> -}
> -
> -static int sched_wakeup_handler(struct trace_seq *s,
> -				struct tep_record *record,
> -				struct tep_event *event, void *context)
> -{
> -	struct tep_format_field *field;
> -	unsigned long long val;
> -
> -	if (tep_get_field_val(s, event, "pid", record, &val, 1))
> -		return trace_seq_putc(s, '!');
> -
> -	field = tep_find_any_field(event, "comm");
> -	if (field) {
> -		write_and_save_comm(field, record, s, val);
> -		trace_seq_putc(s, ':');
> -	}
> -	trace_seq_printf(s, "%lld", val);
> -
> -	if (tep_get_field_val(s, event, "prio", record, &val, 0) == 0)
> -		trace_seq_printf(s, " [%lld]", val);
> -
> -	if (tep_get_field_val(s, event, "success", record, &val, 1) == 0)
> -		trace_seq_printf(s, " success=%lld", val);
> -
> -	if (tep_get_field_val(s, event, "target_cpu", record, &val, 0) == 0)
> -		trace_seq_printf(s, " CPU:%03llu", val);
> -
> -	return 0;
> -}
> -
> -static int sched_switch_handler(struct trace_seq *s,
> -				struct tep_record *record,
> -				struct tep_event *event, void *context)
> -{
> -	struct tep_format_field *field;
> -	unsigned long long val;
> -
> -	if (tep_get_field_val(s, event, "prev_pid", record, &val, 1))
> -		return trace_seq_putc(s, '!');
> -
> -	field = tep_find_any_field(event, "prev_comm");
> -	if (field) {
> -		write_and_save_comm(field, record, s, val);
> -		trace_seq_putc(s, ':');
> -	}
> -	trace_seq_printf(s, "%lld ", val);
> -
> -	if (tep_get_field_val(s, event, "prev_prio", record, &val, 0) == 0)
> -		trace_seq_printf(s, "[%d] ", (int) val);
> -
> -	if (tep_get_field_val(s,  event, "prev_state", record, &val, 0) == 0)
> -		write_state(s, val);
> -
> -	trace_seq_puts(s, " ==> ");
> -
> -	if (tep_get_field_val(s, event, "next_pid", record, &val, 1))
> -		return trace_seq_putc(s, '!');
> -
> -	field = tep_find_any_field(event, "next_comm");
> -	if (field) {
> -		write_and_save_comm(field, record, s, val);
> -		trace_seq_putc(s, ':');
> -	}
> -	trace_seq_printf(s, "%lld", val);
> -
> -	if (tep_get_field_val(s, event, "next_prio", record, &val, 0) == 0)
> -		trace_seq_printf(s, " [%d]", (int) val);
> -
> -	return 0;
> -}
> -
> -int TEP_PLUGIN_LOADER(struct tep_handle *tep)
> -{
> -	tep_register_event_handler(tep, -1, "sched", "sched_switch",
> -				   sched_switch_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "sched", "sched_wakeup",
> -				   sched_wakeup_handler, NULL);
> -
> -	tep_register_event_handler(tep, -1, "sched", "sched_wakeup_new",
> -				   sched_wakeup_handler, NULL);
> -	return 0;
> -}
> -
> -void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
> -{
> -	tep_unregister_event_handler(tep, -1, "sched", "sched_switch",
> -				     sched_switch_handler, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "sched", "sched_wakeup",
> -				     sched_wakeup_handler, NULL);
> -
> -	tep_unregister_event_handler(tep, -1, "sched", "sched_wakeup_new",
> -				     sched_wakeup_handler, NULL);
> -}
> diff --git a/tools/lib/traceevent/plugins/plugin_scsi.c b/tools/lib/traceevent/plugins/plugin_scsi.c
> deleted file mode 100644
> index 5d0387a4b65a..000000000000
> --- a/tools/lib/traceevent/plugins/plugin_scsi.c
> +++ /dev/null
> @@ -1,434 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <stdio.h>
> -#include <string.h>
> -#include <inttypes.h>
> -#include "event-parse.h"
> -#include "trace-seq.h"
> -
> -typedef unsigned long sector_t;
> -typedef uint64_t u64;
> -typedef unsigned int u32;
> -
> -/*
> - *      SCSI opcodes
> - */
> -#define TEST_UNIT_READY			0x00
> -#define REZERO_UNIT			0x01
> -#define REQUEST_SENSE			0x03
> -#define FORMAT_UNIT			0x04
> -#define READ_BLOCK_LIMITS		0x05
> -#define REASSIGN_BLOCKS			0x07
> -#define INITIALIZE_ELEMENT_STATUS	0x07
> -#define READ_6				0x08
> -#define WRITE_6				0x0a
> -#define SEEK_6				0x0b
> -#define READ_REVERSE			0x0f
> -#define WRITE_FILEMARKS			0x10
> -#define SPACE				0x11
> -#define INQUIRY				0x12
> -#define RECOVER_BUFFERED_DATA		0x14
> -#define MODE_SELECT			0x15
> -#define RESERVE				0x16
> -#define RELEASE				0x17
> -#define COPY				0x18
> -#define ERASE				0x19
> -#define MODE_SENSE			0x1a
> -#define START_STOP			0x1b
> -#define RECEIVE_DIAGNOSTIC		0x1c
> -#define SEND_DIAGNOSTIC			0x1d
> -#define ALLOW_MEDIUM_REMOVAL		0x1e
> -
> -#define READ_FORMAT_CAPACITIES		0x23
> -#define SET_WINDOW			0x24
> -#define READ_CAPACITY			0x25
> -#define READ_10				0x28
> -#define WRITE_10			0x2a
> -#define SEEK_10				0x2b
> -#define POSITION_TO_ELEMENT		0x2b
> -#define WRITE_VERIFY			0x2e
> -#define VERIFY				0x2f
> -#define SEARCH_HIGH			0x30
> -#define SEARCH_EQUAL			0x31
> -#define SEARCH_LOW			0x32
> -#define SET_LIMITS			0x33
> -#define PRE_FETCH			0x34
> -#define READ_POSITION			0x34
> -#define SYNCHRONIZE_CACHE		0x35
> -#define LOCK_UNLOCK_CACHE		0x36
> -#define READ_DEFECT_DATA		0x37
> -#define MEDIUM_SCAN			0x38
> -#define COMPARE				0x39
> -#define COPY_VERIFY			0x3a
> -#define WRITE_BUFFER			0x3b
> -#define READ_BUFFER			0x3c
> -#define UPDATE_BLOCK			0x3d
> -#define READ_LONG			0x3e
> -#define WRITE_LONG			0x3f
> -#define CHANGE_DEFINITION		0x40
> -#define WRITE_SAME			0x41
> -#define UNMAP				0x42
> -#define READ_TOC			0x43
> -#define READ_HEADER			0x44
> -#define GET_EVENT_STATUS_NOTIFICATION	0x4a
> -#define LOG_SELECT			0x4c
> -#define LOG_SENSE			0x4d
> -#define XDWRITEREAD_10			0x53
> -#define MODE_SELECT_10			0x55
> -#define RESERVE_10			0x56
> -#define RELEASE_10			0x57
> -#define MODE_SENSE_10			0x5a
> -#define PERSISTENT_RESERVE_IN		0x5e
> -#define PERSISTENT_RESERVE_OUT		0x5f
> -#define VARIABLE_LENGTH_CMD		0x7f
> -#define REPORT_LUNS			0xa0
> -#define SECURITY_PROTOCOL_IN		0xa2
> -#define MAINTENANCE_IN			0xa3
> -#define MAINTENANCE_OUT			0xa4
> -#define MOVE_MEDIUM			0xa5
> -#define EXCHANGE_MEDIUM			0xa6
> -#define READ_12				0xa8
> -#define SERVICE_ACTION_OUT_12		0xa9
> -#define WRITE_12			0xaa
> -#define SERVICE_ACTION_IN_12		0xab
> -#define WRITE_VERIFY_12			0xae
> -#define VERIFY_12			0xaf
> -#define SEARCH_HIGH_12			0xb0
> -#define SEARCH_EQUAL_12			0xb1
> -#define SEARCH_LOW_12			0xb2
> -#define SECURITY_PROTOCOL_OUT		0xb5
> -#define READ_ELEMENT_STATUS		0xb8
> -#define SEND_VOLUME_TAG			0xb6
> -#define WRITE_LONG_2			0xea
> -#define EXTENDED_COPY			0x83
> -#define RECEIVE_COPY_RESULTS		0x84
> -#define ACCESS_CONTROL_IN		0x86
> -#define ACCESS_CONTROL_OUT		0x87
> -#define READ_16				0x88
> -#define WRITE_16			0x8a
> -#define READ_ATTRIBUTE			0x8c
> -#define WRITE_ATTRIBUTE			0x8d
> -#define VERIFY_16			0x8f
> -#define SYNCHRONIZE_CACHE_16		0x91
> -#define WRITE_SAME_16			0x93
> -#define SERVICE_ACTION_BIDIRECTIONAL	0x9d
> -#define SERVICE_ACTION_IN_16		0x9e
> -#define SERVICE_ACTION_OUT_16		0x9f
> -/* values for service action in */
> -#define	SAI_READ_CAPACITY_16		0x10
> -#define SAI_GET_LBA_STATUS		0x12
> -/* values for VARIABLE_LENGTH_CMD service action codes
> - * see spc4r17 Section D.3.5, table D.7 and D.8 */
> -#define VLC_SA_RECEIVE_CREDENTIAL	0x1800
> -/* values for maintenance in */
> -#define MI_REPORT_IDENTIFYING_INFORMATION		0x05
> -#define MI_REPORT_TARGET_PGS				0x0a
> -#define MI_REPORT_ALIASES				0x0b
> -#define MI_REPORT_SUPPORTED_OPERATION_CODES		0x0c
> -#define MI_REPORT_SUPPORTED_TASK_MANAGEMENT_FUNCTIONS	0x0d
> -#define MI_REPORT_PRIORITY				0x0e
> -#define MI_REPORT_TIMESTAMP				0x0f
> -#define MI_MANAGEMENT_PROTOCOL_IN			0x10
> -/* value for MI_REPORT_TARGET_PGS ext header */
> -#define MI_EXT_HDR_PARAM_FMT		0x20
> -/* values for maintenance out */
> -#define MO_SET_IDENTIFYING_INFORMATION	0x06
> -#define MO_SET_TARGET_PGS		0x0a
> -#define MO_CHANGE_ALIASES		0x0b
> -#define MO_SET_PRIORITY			0x0e
> -#define MO_SET_TIMESTAMP		0x0f
> -#define MO_MANAGEMENT_PROTOCOL_OUT	0x10
> -/* values for variable length command */
> -#define XDREAD_32			0x03
> -#define XDWRITE_32			0x04
> -#define XPWRITE_32			0x06
> -#define XDWRITEREAD_32			0x07
> -#define READ_32				0x09
> -#define VERIFY_32			0x0a
> -#define WRITE_32			0x0b
> -#define WRITE_SAME_32			0x0d
> -
> -#define SERVICE_ACTION16(cdb) (cdb[1] & 0x1f)
> -#define SERVICE_ACTION32(cdb) ((cdb[8] << 8) | cdb[9])
> -
> -static const char *
> -scsi_trace_misc(struct trace_seq *, unsigned char *, int);
> -
> -static const char *
> -scsi_trace_rw6(struct trace_seq *p, unsigned char *cdb, int len)
> -{
> -	const char *ret = p->buffer + p->len;
> -	sector_t lba = 0, txlen = 0;
> -
> -	lba |= ((cdb[1] & 0x1F) << 16);
> -	lba |=  (cdb[2] << 8);
> -	lba |=   cdb[3];
> -	txlen = cdb[4];
> -
> -	trace_seq_printf(p, "lba=%llu txlen=%llu",
> -			 (unsigned long long)lba, (unsigned long long)txlen);
> -	trace_seq_putc(p, 0);
> -	return ret;
> -}
> -
> -static const char *
> -scsi_trace_rw10(struct trace_seq *p, unsigned char *cdb, int len)
> -{
> -	const char *ret = p->buffer + p->len;
> -	sector_t lba = 0, txlen = 0;
> -
> -	lba |= (cdb[2] << 24);
> -	lba |= (cdb[3] << 16);
> -	lba |= (cdb[4] << 8);
> -	lba |=  cdb[5];
> -	txlen |= (cdb[7] << 8);
> -	txlen |=  cdb[8];
> -
> -	trace_seq_printf(p, "lba=%llu txlen=%llu protect=%u",
> -			 (unsigned long long)lba, (unsigned long long)txlen,
> -			 cdb[1] >> 5);
> -
> -	if (cdb[0] == WRITE_SAME)
> -		trace_seq_printf(p, " unmap=%u", cdb[1] >> 3 & 1);
> -
> -	trace_seq_putc(p, 0);
> -	return ret;
> -}
> -
> -static const char *
> -scsi_trace_rw12(struct trace_seq *p, unsigned char *cdb, int len)
> -{
> -	const char *ret = p->buffer + p->len;
> -	sector_t lba = 0, txlen = 0;
> -
> -	lba |= (cdb[2] << 24);
> -	lba |= (cdb[3] << 16);
> -	lba |= (cdb[4] << 8);
> -	lba |=  cdb[5];
> -	txlen |= (cdb[6] << 24);
> -	txlen |= (cdb[7] << 16);
> -	txlen |= (cdb[8] << 8);
> -	txlen |=  cdb[9];
> -
> -	trace_seq_printf(p, "lba=%llu txlen=%llu protect=%u",
> -			 (unsigned long long)lba, (unsigned long long)txlen,
> -			 cdb[1] >> 5);
> -	trace_seq_putc(p, 0);
> -	return ret;
> -}
> -
> -static const char *
> -scsi_trace_rw16(struct trace_seq *p, unsigned char *cdb, int len)
> -{
> -	const char *ret = p->buffer + p->len;
> -	sector_t lba = 0, txlen = 0;
> -
> -	lba |= ((u64)cdb[2] << 56);
> -	lba |= ((u64)cdb[3] << 48);
> -	lba |= ((u64)cdb[4] << 40);
> -	lba |= ((u64)cdb[5] << 32);
> -	lba |= (cdb[6] << 24);
> -	lba |= (cdb[7] << 16);
> -	lba |= (cdb[8] << 8);
> -	lba |=  cdb[9];
> -	txlen |= (cdb[10] << 24);
> -	txlen |= (cdb[11] << 16);
> -	txlen |= (cdb[12] << 8);
> -	txlen |=  cdb[13];
> -
> -	trace_seq_printf(p, "lba=%llu txlen=%llu protect=%u",
> -			 (unsigned long long)lba, (unsigned long long)txlen,
> -			 cdb[1] >> 5);
> -
> -	if (cdb[0] == WRITE_SAME_16)
> -		trace_seq_printf(p, " unmap=%u", cdb[1] >> 3 & 1);
> -
> -	trace_seq_putc(p, 0);
> -	return ret;
> -}
> -
> -static const char *
> -scsi_trace_rw32(struct trace_seq *p, unsigned char *cdb, int len)
> -{
> -	const char *ret = p->buffer + p->len, *cmd;
> -	sector_t lba = 0, txlen = 0;
> -	u32 ei_lbrt = 0;
> -
> -	switch (SERVICE_ACTION32(cdb)) {
> -	case READ_32:
> -		cmd = "READ";
> -		break;
> -	case VERIFY_32:
> -		cmd = "VERIFY";
> -		break;
> -	case WRITE_32:
> -		cmd = "WRITE";
> -		break;
> -	case WRITE_SAME_32:
> -		cmd = "WRITE_SAME";
> -		break;
> -	default:
> -		trace_seq_printf(p, "UNKNOWN");
> -		goto out;
> -	}
> -
> -	lba |= ((u64)cdb[12] << 56);
> -	lba |= ((u64)cdb[13] << 48);
> -	lba |= ((u64)cdb[14] << 40);
> -	lba |= ((u64)cdb[15] << 32);
> -	lba |= (cdb[16] << 24);
> -	lba |= (cdb[17] << 16);
> -	lba |= (cdb[18] << 8);
> -	lba |=  cdb[19];
> -	ei_lbrt |= (cdb[20] << 24);
> -	ei_lbrt |= (cdb[21] << 16);
> -	ei_lbrt |= (cdb[22] << 8);
> -	ei_lbrt |=  cdb[23];
> -	txlen |= (cdb[28] << 24);
> -	txlen |= (cdb[29] << 16);
> -	txlen |= (cdb[30] << 8);
> -	txlen |=  cdb[31];
> -
> -	trace_seq_printf(p, "%s_32 lba=%llu txlen=%llu protect=%u ei_lbrt=%u",
> -			 cmd, (unsigned long long)lba,
> -			 (unsigned long long)txlen, cdb[10] >> 5, ei_lbrt);
> -
> -	if (SERVICE_ACTION32(cdb) == WRITE_SAME_32)
> -		trace_seq_printf(p, " unmap=%u", cdb[10] >> 3 & 1);
> -
> -out:
> -	trace_seq_putc(p, 0);
> -	return ret;
> -}
> -
> -static const char *
> -scsi_trace_unmap(struct trace_seq *p, unsigned char *cdb, int len)
> -{
> -	const char *ret = p->buffer + p->len;
> -	unsigned int regions = cdb[7] << 8 | cdb[8];
> -
> -	trace_seq_printf(p, "regions=%u", (regions - 8) / 16);
> -	trace_seq_putc(p, 0);
> -	return ret;
> -}
> -
> -static const char *
> -scsi_trace_service_action_in(struct trace_seq *p, unsigned char *cdb, int len)
> -{
> -	const char *ret = p->buffer + p->len, *cmd;
> -	sector_t lba = 0;
> -	u32 alloc_len = 0;
> -
> -	switch (SERVICE_ACTION16(cdb)) {
> -	case SAI_READ_CAPACITY_16:
> -		cmd = "READ_CAPACITY_16";
> -		break;
> -	case SAI_GET_LBA_STATUS:
> -		cmd = "GET_LBA_STATUS";
> -		break;
> -	default:
> -		trace_seq_printf(p, "UNKNOWN");
> -		goto out;
> -	}
> -
> -	lba |= ((u64)cdb[2] << 56);
> -	lba |= ((u64)cdb[3] << 48);
> -	lba |= ((u64)cdb[4] << 40);
> -	lba |= ((u64)cdb[5] << 32);
> -	lba |= (cdb[6] << 24);
> -	lba |= (cdb[7] << 16);
> -	lba |= (cdb[8] << 8);
> -	lba |=  cdb[9];
> -	alloc_len |= (cdb[10] << 24);
> -	alloc_len |= (cdb[11] << 16);
> -	alloc_len |= (cdb[12] << 8);
> -	alloc_len |=  cdb[13];
> -
> -	trace_seq_printf(p, "%s lba=%llu alloc_len=%u", cmd,
> -			 (unsigned long long)lba, alloc_len);
> -
> -out:
> -	trace_seq_putc(p, 0);
> -	return ret;
> -}
> -
> -static const char *
> -scsi_trace_varlen(struct trace_seq *p, unsigned char *cdb, int len)
> -{
> -	switch (SERVICE_ACTION32(cdb)) {
> -	case READ_32:
> -	case VERIFY_32:
> -	case WRITE_32:
> -	case WRITE_SAME_32:
> -		return scsi_trace_rw32(p, cdb, len);
> -	default:
> -		return scsi_trace_misc(p, cdb, len);
> -	}
> -}
> -
> -static const char *
> -scsi_trace_misc(struct trace_seq *p, unsigned char *cdb, int len)
> -{
> -	const char *ret = p->buffer + p->len;
> -
> -	trace_seq_printf(p, "-");
> -	trace_seq_putc(p, 0);
> -	return ret;
> -}
> -
> -const char *
> -scsi_trace_parse_cdb(struct trace_seq *p, unsigned char *cdb, int len)
> -{
> -	switch (cdb[0]) {
> -	case READ_6:
> -	case WRITE_6:
> -		return scsi_trace_rw6(p, cdb, len);
> -	case READ_10:
> -	case VERIFY:
> -	case WRITE_10:
> -	case WRITE_SAME:
> -		return scsi_trace_rw10(p, cdb, len);
> -	case READ_12:
> -	case VERIFY_12:
> -	case WRITE_12:
> -		return scsi_trace_rw12(p, cdb, len);
> -	case READ_16:
> -	case VERIFY_16:
> -	case WRITE_16:
> -	case WRITE_SAME_16:
> -		return scsi_trace_rw16(p, cdb, len);
> -	case UNMAP:
> -		return scsi_trace_unmap(p, cdb, len);
> -	case SERVICE_ACTION_IN_16:
> -		return scsi_trace_service_action_in(p, cdb, len);
> -	case VARIABLE_LENGTH_CMD:
> -		return scsi_trace_varlen(p, cdb, len);
> -	default:
> -		return scsi_trace_misc(p, cdb, len);
> -	}
> -}
> -
> -unsigned long long process_scsi_trace_parse_cdb(struct trace_seq *s,
> -						unsigned long long *args)
> -{
> -	scsi_trace_parse_cdb(s, (unsigned char *) (unsigned long) args[1], args[2]);
> -	return 0;
> -}
> -
> -int TEP_PLUGIN_LOADER(struct tep_handle *tep)
> -{
> -	tep_register_print_function(tep,
> -				    process_scsi_trace_parse_cdb,
> -				    TEP_FUNC_ARG_STRING,
> -				    "scsi_trace_parse_cdb",
> -				    TEP_FUNC_ARG_PTR,
> -				    TEP_FUNC_ARG_PTR,
> -				    TEP_FUNC_ARG_INT,
> -				    TEP_FUNC_ARG_VOID);
> -	return 0;
> -}
> -
> -void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
> -{
> -	tep_unregister_print_function(tep, process_scsi_trace_parse_cdb,
> -				      "scsi_trace_parse_cdb");
> -}
> diff --git a/tools/lib/traceevent/plugins/plugin_tlb.c b/tools/lib/traceevent/plugins/plugin_tlb.c
> deleted file mode 100644
> index 43657fb60504..000000000000
> --- a/tools/lib/traceevent/plugins/plugin_tlb.c
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2015 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -
> -#include "event-parse.h"
> -
> -enum tlb_flush_reason {
> -	TLB_FLUSH_ON_TASK_SWITCH,
> -	TLB_REMOTE_SHOOTDOWN,
> -	TLB_LOCAL_SHOOTDOWN,
> -	TLB_LOCAL_MM_SHOOTDOWN,
> -	NR_TLB_FLUSH_REASONS,
> -};
> -
> -static int tlb_flush_handler(struct trace_seq *s, struct tep_record *record,
> -			     struct tep_event *event, void *context)
> -{
> -	unsigned long long val;
> -
> -	trace_seq_printf(s, "pages=");
> -
> -	tep_print_num_field(s, "%ld", event, "pages", record, 1);
> -
> -	if (tep_get_field_val(s, event, "reason", record, &val, 1) < 0)
> -		return -1;
> -
> -	trace_seq_puts(s, " reason=");
> -
> -	switch (val) {
> -	case TLB_FLUSH_ON_TASK_SWITCH:
> -		trace_seq_puts(s, "flush on task switch");
> -		break;
> -	case TLB_REMOTE_SHOOTDOWN:
> -		trace_seq_puts(s, "remote shootdown");
> -		break;
> -	case TLB_LOCAL_SHOOTDOWN:
> -		trace_seq_puts(s, "local shootdown");
> -		break;
> -	case TLB_LOCAL_MM_SHOOTDOWN:
> -		trace_seq_puts(s, "local mm shootdown");
> -		break;
> -	}
> -
> -	trace_seq_printf(s, " (%lld)", val);
> -
> -	return 0;
> -}
> -
> -int TEP_PLUGIN_LOADER(struct tep_handle *tep)
> -{
> -	tep_register_event_handler(tep, -1, "tlb", "tlb_flush",
> -				   tlb_flush_handler, NULL);
> -
> -	return 0;
> -}
> -
> -void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
> -{
> -	tep_unregister_event_handler(tep, -1,
> -				     "tlb", "tlb_flush",
> -				     tlb_flush_handler, NULL);
> -}
> diff --git a/tools/lib/traceevent/plugins/plugin_xen.c b/tools/lib/traceevent/plugins/plugin_xen.c
> deleted file mode 100644
> index 993b208d0323..000000000000
> --- a/tools/lib/traceevent/plugins/plugin_xen.c
> +++ /dev/null
> @@ -1,138 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include "event-parse.h"
> -#include "trace-seq.h"
> -
> -#define __HYPERVISOR_set_trap_table			0
> -#define __HYPERVISOR_mmu_update				1
> -#define __HYPERVISOR_set_gdt				2
> -#define __HYPERVISOR_stack_switch			3
> -#define __HYPERVISOR_set_callbacks			4
> -#define __HYPERVISOR_fpu_taskswitch			5
> -#define __HYPERVISOR_sched_op_compat			6
> -#define __HYPERVISOR_dom0_op				7
> -#define __HYPERVISOR_set_debugreg			8
> -#define __HYPERVISOR_get_debugreg			9
> -#define __HYPERVISOR_update_descriptor			10
> -#define __HYPERVISOR_memory_op				12
> -#define __HYPERVISOR_multicall				13
> -#define __HYPERVISOR_update_va_mapping			14
> -#define __HYPERVISOR_set_timer_op			15
> -#define __HYPERVISOR_event_channel_op_compat		16
> -#define __HYPERVISOR_xen_version			17
> -#define __HYPERVISOR_console_io				18
> -#define __HYPERVISOR_physdev_op_compat			19
> -#define __HYPERVISOR_grant_table_op			20
> -#define __HYPERVISOR_vm_assist				21
> -#define __HYPERVISOR_update_va_mapping_otherdomain	22
> -#define __HYPERVISOR_iret				23 /* x86 only */
> -#define __HYPERVISOR_vcpu_op				24
> -#define __HYPERVISOR_set_segment_base			25 /* x86/64 only */
> -#define __HYPERVISOR_mmuext_op				26
> -#define __HYPERVISOR_acm_op				27
> -#define __HYPERVISOR_nmi_op				28
> -#define __HYPERVISOR_sched_op				29
> -#define __HYPERVISOR_callback_op			30
> -#define __HYPERVISOR_xenoprof_op			31
> -#define __HYPERVISOR_event_channel_op			32
> -#define __HYPERVISOR_physdev_op				33
> -#define __HYPERVISOR_hvm_op				34
> -#define __HYPERVISOR_tmem_op				38
> -
> -/* Architecture-specific hypercall definitions. */
> -#define __HYPERVISOR_arch_0				48
> -#define __HYPERVISOR_arch_1				49
> -#define __HYPERVISOR_arch_2				50
> -#define __HYPERVISOR_arch_3				51
> -#define __HYPERVISOR_arch_4				52
> -#define __HYPERVISOR_arch_5				53
> -#define __HYPERVISOR_arch_6				54
> -#define __HYPERVISOR_arch_7				55
> -
> -#define N(x)	[__HYPERVISOR_##x] = "("#x")"
> -static const char *xen_hypercall_names[] = {
> -	N(set_trap_table),
> -	N(mmu_update),
> -	N(set_gdt),
> -	N(stack_switch),
> -	N(set_callbacks),
> -	N(fpu_taskswitch),
> -	N(sched_op_compat),
> -	N(dom0_op),
> -	N(set_debugreg),
> -	N(get_debugreg),
> -	N(update_descriptor),
> -	N(memory_op),
> -	N(multicall),
> -	N(update_va_mapping),
> -	N(set_timer_op),
> -	N(event_channel_op_compat),
> -	N(xen_version),
> -	N(console_io),
> -	N(physdev_op_compat),
> -	N(grant_table_op),
> -	N(vm_assist),
> -	N(update_va_mapping_otherdomain),
> -	N(iret),
> -	N(vcpu_op),
> -	N(set_segment_base),
> -	N(mmuext_op),
> -	N(acm_op),
> -	N(nmi_op),
> -	N(sched_op),
> -	N(callback_op),
> -	N(xenoprof_op),
> -	N(event_channel_op),
> -	N(physdev_op),
> -	N(hvm_op),
> -
> -/* Architecture-specific hypercall definitions. */
> -	N(arch_0),
> -	N(arch_1),
> -	N(arch_2),
> -	N(arch_3),
> -	N(arch_4),
> -	N(arch_5),
> -	N(arch_6),
> -	N(arch_7),
> -};
> -#undef N
> -
> -#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> -
> -static const char *xen_hypercall_name(unsigned op)
> -{
> -	if (op < ARRAY_SIZE(xen_hypercall_names) &&
> -	    xen_hypercall_names[op] != NULL)
> -		return xen_hypercall_names[op];
> -
> -	return "";
> -}
> -
> -unsigned long long process_xen_hypercall_name(struct trace_seq *s,
> -					      unsigned long long *args)
> -{
> -	unsigned int op = args[0];
> -
> -	trace_seq_printf(s, "%s", xen_hypercall_name(op));
> -	return 0;
> -}
> -
> -int TEP_PLUGIN_LOADER(struct tep_handle *tep)
> -{
> -	tep_register_print_function(tep,
> -				    process_xen_hypercall_name,
> -				    TEP_FUNC_ARG_STRING,
> -				    "xen_hypercall_name",
> -				    TEP_FUNC_ARG_INT,
> -				    TEP_FUNC_ARG_VOID);
> -	return 0;
> -}
> -
> -void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
> -{
> -	tep_unregister_print_function(tep, process_xen_hypercall_name,
> -				      "xen_hypercall_name");
> -}
> diff --git a/tools/lib/traceevent/tep_strerror.c b/tools/lib/traceevent/tep_strerror.c
> deleted file mode 100644
> index 4ac26445b2f6..000000000000
> --- a/tools/lib/traceevent/tep_strerror.c
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -#undef _GNU_SOURCE
> -#include <string.h>
> -#include <stdio.h>
> -
> -#include "event-parse.h"
> -
> -#undef _PE
> -#define _PE(code, str) str
> -static const char * const tep_error_str[] = {
> -	TEP_ERRORS
> -};
> -#undef _PE
> -
> -/*
> - * The tools so far have been using the strerror_r() GNU variant, that returns
> - * a string, be it the buffer passed or something else.
> - *
> - * But that, besides being tricky in cases where we expect that the function
> - * using strerror_r() returns the error formatted in a provided buffer (we have
> - * to check if it returned something else and copy that instead), breaks the
> - * build on systems not using glibc, like Alpine Linux, where musl libc is
> - * used.
> - *
> - * So, introduce yet another wrapper, str_error_r(), that has the GNU
> - * interface, but uses the portable XSI variant of strerror_r(), so that users
> - * rest asured that the provided buffer is used and it is what is returned.
> - */
> -int tep_strerror(struct tep_handle *tep __maybe_unused,
> -		 enum tep_errno errnum, char *buf, size_t buflen)
> -{
> -	const char *msg;
> -	int idx;
> -
> -	if (!buflen)
> -		return 0;
> -
> -	if (errnum >= 0) {
> -		int err = strerror_r(errnum, buf, buflen);
> -		buf[buflen - 1] = 0;
> -		return err;
> -	}
> -
> -	if (errnum <= __TEP_ERRNO__START ||
> -	    errnum >= __TEP_ERRNO__END)
> -		return -1;
> -
> -	idx = errnum - __TEP_ERRNO__START - 1;
> -	msg = tep_error_str[idx];
> -	snprintf(buf, buflen, "%s", msg);
> -
> -	return 0;
> -}
> diff --git a/tools/lib/traceevent/trace-seq.c b/tools/lib/traceevent/trace-seq.c
> deleted file mode 100644
> index 8d5ecd2bf877..000000000000
> --- a/tools/lib/traceevent/trace-seq.c
> +++ /dev/null
> @@ -1,249 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2009 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - *
> - */
> -#include "trace-seq.h"
> -
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <stdarg.h>
> -
> -#include <asm/bug.h>
> -#include "event-parse.h"
> -#include "event-utils.h"
> -
> -/*
> - * The TRACE_SEQ_POISON is to catch the use of using
> - * a trace_seq structure after it was destroyed.
> - */
> -#define TRACE_SEQ_POISON	((void *)0xdeadbeef)
> -#define TRACE_SEQ_CHECK(s)						\
> -do {									\
> -	if (WARN_ONCE((s)->buffer == TRACE_SEQ_POISON,			\
> -		      "Usage of trace_seq after it was destroyed"))	\
> -		(s)->state = TRACE_SEQ__BUFFER_POISONED;		\
> -} while (0)
> -
> -#define TRACE_SEQ_CHECK_RET_N(s, n)		\
> -do {						\
> -	TRACE_SEQ_CHECK(s);			\
> -	if ((s)->state != TRACE_SEQ__GOOD)	\
> -		return n; 			\
> -} while (0)
> -
> -#define TRACE_SEQ_CHECK_RET(s)   TRACE_SEQ_CHECK_RET_N(s, )
> -#define TRACE_SEQ_CHECK_RET0(s)  TRACE_SEQ_CHECK_RET_N(s, 0)
> -
> -/**
> - * trace_seq_init - initialize the trace_seq structure
> - * @s: a pointer to the trace_seq structure to initialize
> - */
> -void trace_seq_init(struct trace_seq *s)
> -{
> -	s->len = 0;
> -	s->readpos = 0;
> -	s->buffer_size = TRACE_SEQ_BUF_SIZE;
> -	s->buffer = malloc(s->buffer_size);
> -	if (s->buffer != NULL)
> -		s->state = TRACE_SEQ__GOOD;
> -	else
> -		s->state = TRACE_SEQ__MEM_ALLOC_FAILED;
> -}
> -
> -/**
> - * trace_seq_reset - re-initialize the trace_seq structure
> - * @s: a pointer to the trace_seq structure to reset
> - */
> -void trace_seq_reset(struct trace_seq *s)
> -{
> -	if (!s)
> -		return;
> -	TRACE_SEQ_CHECK(s);
> -	s->len = 0;
> -	s->readpos = 0;
> -}
> -
> -/**
> - * trace_seq_destroy - free up memory of a trace_seq
> - * @s: a pointer to the trace_seq to free the buffer
> - *
> - * Only frees the buffer, not the trace_seq struct itself.
> - */
> -void trace_seq_destroy(struct trace_seq *s)
> -{
> -	if (!s)
> -		return;
> -	TRACE_SEQ_CHECK_RET(s);
> -	free(s->buffer);
> -	s->buffer = TRACE_SEQ_POISON;
> -}
> -
> -static void expand_buffer(struct trace_seq *s)
> -{
> -	char *buf;
> -
> -	buf = realloc(s->buffer, s->buffer_size + TRACE_SEQ_BUF_SIZE);
> -	if (WARN_ONCE(!buf, "Can't allocate trace_seq buffer memory")) {
> -		s->state = TRACE_SEQ__MEM_ALLOC_FAILED;
> -		return;
> -	}
> -
> -	s->buffer = buf;
> -	s->buffer_size += TRACE_SEQ_BUF_SIZE;
> -}
> -
> -/**
> - * trace_seq_printf - sequence printing of trace information
> - * @s: trace sequence descriptor
> - * @fmt: printf format string
> - *
> - * It returns 0 if the trace oversizes the buffer's free
> - * space, the number of characters printed, or a negative
> - * value in case of an error.
> - *
> - * The tracer may use either sequence operations or its own
> - * copy to user routines. To simplify formating of a trace
> - * trace_seq_printf is used to store strings into a special
> - * buffer (@s). Then the output may be either used by
> - * the sequencer or pulled into another buffer.
> - */
> -int
> -trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
> -{
> -	va_list ap;
> -	int len;
> -	int ret;
> -
> - try_again:
> -	TRACE_SEQ_CHECK_RET0(s);
> -
> -	len = (s->buffer_size - 1) - s->len;
> -
> -	va_start(ap, fmt);
> -	ret = vsnprintf(s->buffer + s->len, len, fmt, ap);
> -	va_end(ap);
> -
> -	if (ret >= len) {
> -		expand_buffer(s);
> -		goto try_again;
> -	}
> -
> -	if (ret > 0)
> -		s->len += ret;
> -
> -	return ret;
> -}
> -
> -/**
> - * trace_seq_vprintf - sequence printing of trace information
> - * @s: trace sequence descriptor
> - * @fmt: printf format string
> - *
> - * It returns 0 if the trace oversizes the buffer's free
> - * space, the number of characters printed, or a negative
> - * value in case of an error.
> - * *
> - * The tracer may use either sequence operations or its own
> - * copy to user routines. To simplify formating of a trace
> - * trace_seq_printf is used to store strings into a special
> - * buffer (@s). Then the output may be either used by
> - * the sequencer or pulled into another buffer.
> - */
> -int
> -trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args)
> -{
> -	int len;
> -	int ret;
> -
> - try_again:
> -	TRACE_SEQ_CHECK_RET0(s);
> -
> -	len = (s->buffer_size - 1) - s->len;
> -
> -	ret = vsnprintf(s->buffer + s->len, len, fmt, args);
> -
> -	if (ret >= len) {
> -		expand_buffer(s);
> -		goto try_again;
> -	}
> -
> -	if (ret > 0)
> -		s->len += ret;
> -
> -	return ret;
> -}
> -
> -/**
> - * trace_seq_puts - trace sequence printing of simple string
> - * @s: trace sequence descriptor
> - * @str: simple string to record
> - *
> - * The tracer may use either the sequence operations or its own
> - * copy to user routines. This function records a simple string
> - * into a special buffer (@s) for later retrieval by a sequencer
> - * or other mechanism.
> - */
> -int trace_seq_puts(struct trace_seq *s, const char *str)
> -{
> -	int len;
> -
> -	TRACE_SEQ_CHECK_RET0(s);
> -
> -	len = strlen(str);
> -
> -	while (len > ((s->buffer_size - 1) - s->len))
> -		expand_buffer(s);
> -
> -	TRACE_SEQ_CHECK_RET0(s);
> -
> -	memcpy(s->buffer + s->len, str, len);
> -	s->len += len;
> -
> -	return len;
> -}
> -
> -int trace_seq_putc(struct trace_seq *s, unsigned char c)
> -{
> -	TRACE_SEQ_CHECK_RET0(s);
> -
> -	while (s->len >= (s->buffer_size - 1))
> -		expand_buffer(s);
> -
> -	TRACE_SEQ_CHECK_RET0(s);
> -
> -	s->buffer[s->len++] = c;
> -
> -	return 1;
> -}
> -
> -void trace_seq_terminate(struct trace_seq *s)
> -{
> -	TRACE_SEQ_CHECK_RET(s);
> -
> -	/* There's always one character left on the buffer */
> -	s->buffer[s->len] = 0;
> -}
> -
> -int trace_seq_do_fprintf(struct trace_seq *s, FILE *fp)
> -{
> -	TRACE_SEQ_CHECK(s);
> -
> -	switch (s->state) {
> -	case TRACE_SEQ__GOOD:
> -		return fprintf(fp, "%.*s", s->len, s->buffer);
> -	case TRACE_SEQ__BUFFER_POISONED:
> -		fprintf(fp, "%s\n", "Usage of trace_seq after it was destroyed");
> -		break;
> -	case TRACE_SEQ__MEM_ALLOC_FAILED:
> -		fprintf(fp, "%s\n", "Can't allocate trace_seq buffer memory");
> -		break;
> -	}
> -	return -1;
> -}
> -
> -int trace_seq_do_printf(struct trace_seq *s)
> -{
> -	return trace_seq_do_fprintf(s, stdout);
> -}
> diff --git a/tools/lib/traceevent/trace-seq.h b/tools/lib/traceevent/trace-seq.h
> deleted file mode 100644
> index d68ec69f8d1a..000000000000
> --- a/tools/lib/traceevent/trace-seq.h
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
> - *
> - */
> -
> -#ifndef _TRACE_SEQ_H
> -#define _TRACE_SEQ_H
> -
> -#include <stdarg.h>
> -#include <stdio.h>
> -
> -/* ----------------------- trace_seq ----------------------- */
> -
> -#ifndef TRACE_SEQ_BUF_SIZE
> -#define TRACE_SEQ_BUF_SIZE 4096
> -#endif
> -
> -enum trace_seq_fail {
> -	TRACE_SEQ__GOOD,
> -	TRACE_SEQ__BUFFER_POISONED,
> -	TRACE_SEQ__MEM_ALLOC_FAILED,
> -};
> -
> -/*
> - * Trace sequences are used to allow a function to call several other functions
> - * to create a string of data to use (up to a max of PAGE_SIZE).
> - */
> -
> -struct trace_seq {
> -	char			*buffer;
> -	unsigned int		buffer_size;
> -	unsigned int		len;
> -	unsigned int		readpos;
> -	enum trace_seq_fail	state;
> -};
> -
> -void trace_seq_init(struct trace_seq *s);
> -void trace_seq_reset(struct trace_seq *s);
> -void trace_seq_destroy(struct trace_seq *s);
> -
> -extern int trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
> -	__attribute__ ((format (printf, 2, 3)));
> -extern int trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args)
> -	__attribute__ ((format (printf, 2, 0)));
> -
> -extern int trace_seq_puts(struct trace_seq *s, const char *str);
> -extern int trace_seq_putc(struct trace_seq *s, unsigned char c);
> -
> -extern void trace_seq_terminate(struct trace_seq *s);
> -
> -extern int trace_seq_do_fprintf(struct trace_seq *s, FILE *fp);
> -extern int trace_seq_do_printf(struct trace_seq *s);
> -
> -#endif /* _TRACE_SEQ_H */
> -- 
> 2.38.1.584.g0f3c55d4c2-goog

-- 

- Arnaldo
