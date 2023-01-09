Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699E966347F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbjAIW5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbjAIW5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:57:47 -0500
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511B71CB12;
        Mon,  9 Jan 2023 14:57:42 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id v65so1044485ioe.4;
        Mon, 09 Jan 2023 14:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49JNs8oeXDdPVY+UK8w83HcBqSgWDBTT9wuFlozxsJw=;
        b=vzvH5TojVkEwBCN4neb0gAeuSF0nw8Aa+I05awA1gHZA4DUjkeoqR8uUXzeXhi3JDW
         r+s64jeZ7i6mYmZW/EBalVtzQNgxT9OIdbr9wD0yqGWlaZ936hr23xmWnKjDikwxKtqb
         opzMxrD+wzdiezuM569KQ65JPJ3nXbB36YpwyGZFB1Cz9neP+QZkKpht9D7nW0C6DeCi
         gGlNYFMNVu2LkQiOS5p4X4VuNxNnd9XcYm/7FZDRm9IyYT+OmFU5o/hIPhgMaPNsBtdn
         BcB9mC42zUrPwvpuLGAw5vBg6P6ZS1umukHfZWOkjarlfe+ICwKRq4BO12VK0MG7Z5Jh
         SLJg==
X-Gm-Message-State: AFqh2ko/Iizk4fo+L8xOuGCUce+HV+DITiL7QFkiUCLpezaaeEawUOju
        hBPDR3JKVx4uUdoNmqJ/G5voS8ZVKUZ/ciTbfzY=
X-Google-Smtp-Source: AMrXdXu7LAbK4XXOCapvf/IZ/MiFBVjYePLTRSLVGhKnaD1y0a9MZJ26c2fIhsz4+dxCkoook+aFNnDURWX0JjCVEXs=
X-Received: by 2002:a5e:c00c:0:b0:6a2:8015:afef with SMTP id
 u12-20020a5ec00c000000b006a28015afefmr6068571iol.149.1673305061518; Mon, 09
 Jan 2023 14:57:41 -0800 (PST)
MIME-Version: 1.0
References: <20230109223110.1201541-1-irogers@google.com>
In-Reply-To: <20230109223110.1201541-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 9 Jan 2023 14:57:29 -0800
Message-ID: <CAM9d7cgGq=+MC+qwRNxO=0Bn_ZMOucEzh_WWH95Lq8fsYHMb4A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf tools: Remove HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Mon, Jan 9, 2023 at 2:31 PM Ian Rogers <irogers@google.com> wrote:
>
> Switch HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE to be a version number
> test on libtraceevent being >= to version 1.5.0. This also corrects a
> greater-than test to be greater-than-or-equal.
>
> Discussed here:
> https://lore.kernel.org/lkml/20221205225940.3079667-3-irogers@google.com/
>
> Fixes: b9a49f8cb02f ("perf tools: Check if libtracevent has TEP_FIELD_IS_RELATIVE")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config                             | 4 ----
>  tools/perf/builtin-trace.c                             | 2 +-
>  tools/perf/util/data-convert-bt.c                      | 2 +-
>  tools/perf/util/evsel.c                                | 2 +-
>  tools/perf/util/python.c                               | 2 +-
>  tools/perf/util/scripting-engines/trace-event-perl.c   | 2 +-
>  tools/perf/util/scripting-engines/trace-event-python.c | 2 +-
>  tools/perf/util/sort.c                                 | 3 ++-
>  tools/perf/util/trace-event.h                          | 3 +++
>  9 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index c2504c39bdcb..f67ba8060162 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1204,10 +1204,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>      LIBTRACEEVENT_VERSION_CPP := $(shell expr $(LIBTRACEEVENT_VERSION_1) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VERSION_3))
>      CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
>      $(call detected,CONFIG_LIBTRACEEVENT)
> -    LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE := $(shell expr 1 \* 255 \* 255 + 5 \* 255 + 0) # 1.5.0
> -    ifeq ($(shell test $(LIBTRACEEVENT_VERSION_CPP) -gt $(LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE); echo $$?),0)
> -      CFLAGS += -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> -    endif
>    else
>      dummy := $(warning Warning: libtraceevent is missing limiting functionality, please install libtraceevent-dev/libtraceevent-devel)
>    endif
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 86e06f136f40..927622ecc42e 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2729,7 +2729,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
>                                 offset = format_field__intval(field, sample, evsel->needs_swap);
>                                 syscall_arg.len = offset >> 16;
>                                 offset &= 0xffff;
> -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>                                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                                         offset += field->offset + field->size;
>  #endif
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> index b842273458b8..98454f7a820c 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -322,7 +322,7 @@ static int add_tracepoint_field_value(struct ctf_writer *cw,
>                 offset = tmp_val;
>                 len = offset >> 16;
>                 offset &= 0xffff;
> -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>                 if (flags & TEP_FIELD_IS_RELATIVE)
>                         offset += fmtf->offset + fmtf->size;
>  #endif
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 999dd1700502..296292fa2c04 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2784,7 +2784,7 @@ void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char
>         if (field->flags & TEP_FIELD_IS_DYNAMIC) {
>                 offset = *(int *)(sample->raw_data + field->offset);
>                 offset &= 0xffff;
> -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                         offset += field->offset + field->size;
>  #endif
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 212031b97910..25a276710dfb 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -442,7 +442,7 @@ tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
>                         offset  = val;
>                         len     = offset >> 16;
>                         offset &= 0xffff;
> -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>                         if (field->flags & TEP_FIELD_IS_RELATIVE)
>                                 offset += field->offset + field->size;
>  #endif
> diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
> index c097b7934fd4..5bcec514f697 100644
> --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> @@ -393,7 +393,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
>                         if (field->flags & TEP_FIELD_IS_DYNAMIC) {
>                                 offset = *(int *)(data + field->offset);
>                                 offset &= 0xffff;
> -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>                                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                                         offset += field->offset + field->size;
>  #endif
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index e930f5f1f36d..759ed6eafa3c 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -994,7 +994,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
>                                 offset  = val;
>                                 len     = offset >> 16;
>                                 offset &= 0xffff;
> -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>                                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                                         offset += field->offset + field->size;
>  #endif
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index e188f74698dd..cfcc253239f0 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -28,6 +28,7 @@
>  #include "time-utils.h"
>  #include "cgroup.h"
>  #include "machine.h"
> +#include "trace-event.h"
>  #include <linux/kernel.h>
>  #include <linux/string.h>
>
> @@ -2667,7 +2668,7 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
>                 tep_read_number_field(field, a->raw_data, &dyn);
>                 offset = dyn & 0xffff;
>                 size = (dyn >> 16) & 0xffff;
> -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                         offset += field->offset + field->size;

Maybe I missed the previous discussion.

As it's only used in the bit test, can we have something like this
in the header file?

#if LIBTRACE_EVENT_VERSION < ...(1, 5, 0)
# define TEP_FIELD_IS_RELATIVE  0
#endif

Thanks,
Namhyung


>  #endif
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> index add6c5d9531c..1a1a2e6b24fb 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -20,6 +20,9 @@ struct trace_event {
>         struct tep_plugin_list  *plugin_list;
>  };
>
> +/* Computes a version number comparable with LIBTRACEEVENT_VERSION from Makefile.config. */
> +#define MAKE_LIBTRACEEVENT_VERSION(a, b, c) ((a)*255*255+(b)*255+(c))
> +
>  typedef char *(tep_func_resolver_t)(void *priv,
>                                     unsigned long long *addrp, char **modp);
>
> --
> 2.39.0.314.g84b9a713c41-goog
>
