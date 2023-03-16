Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FC76BC234
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjCPALI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjCPALH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:11:07 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE919211FF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:11:05 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h5so100197ile.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678925465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVg8puv66jGd+hApYY1B98Eb7Bqi3npwzUgU/tYwEM8=;
        b=Dw9sCBNPxc4p/8di6jhADwwLgalt1PC8vuL4oNBfHM/HUaJyelvTyMBnqayAEhPjyS
         Yvdqto5eEiQylnfmmfnENseJOMwZ+JuYv6mMOGqpdfl3L8R7VdEVkFQSucStw8sHHVN2
         h0xwfiCA2F53bNafzgIhnoJBKj32zxgpMOjVt+5AXm2feACv8RAdvMja2YKmX5sTl/qR
         RD1ZHkkOEslDIjQKl4N8Pm47Dmh1c4VXQsgi/pgKmOfVJo8DKQRxKPnaCB7nddjkTR0D
         7jOGSiA8yDGNq1vqHe6oBUlXczoLtD+B6Va2Rg3QswQkAQirqR+gaAVgo1b6IdH/NKgU
         os4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678925465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVg8puv66jGd+hApYY1B98Eb7Bqi3npwzUgU/tYwEM8=;
        b=gJAF0XvienyFcpWjc2A/D2MGImbLxJAwE6VPwIXM6bH6cwsbSI2i6rYgL1yDn7FuQ+
         ctGwyY/EBMDNAJC4KWlUDyWJM1nXNqXq7y3LUuFPcoSkm7VLQ1rw1h/xbDrDIS5i8ir3
         28Nyw65haFLTqxizMWh+Zstrb/IZULy6gi9yGAsgVbgi+gH9xMgFJnjk4GtEe04rmxAR
         gzCnwq1C3850TIMZFoI08KUmr1qDanfR9gpoH+e7867yZ4HAfg5qp6X9abk0PTTZmyqa
         EeSxA0gKWtba7o+l7r8uPtjcj8fm3xHV3kW1nE02dOkVHYtJFpjlyDaIVR+OqJpl2IdR
         ZTQw==
X-Gm-Message-State: AO0yUKXsbKG6j8zO3+bHBbf8GYNyUbcg64vvh0cGH4TFd0C7el3kuYad
        1zkWuNEKnYSpeuAhiI3mJfASPw39mV0zG07gM4I6ag==
X-Google-Smtp-Source: AK7set/1sggPdf6voOBqpQ/wTr+l3VWcyNDQluJg3H+0I5rG1R6OKagrHvEFNpG+YGrKmtEuVUmor2y2aTZbfM9KL54=
X-Received: by 2002:a05:6e02:168a:b0:315:5477:2b40 with SMTP id
 f10-20020a056e02168a00b0031554772b40mr73091ila.6.1678925464711; Wed, 15 Mar
 2023 17:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <ZBIro7uDO/Mii3xF@yoga>
In-Reply-To: <ZBIro7uDO/Mii3xF@yoga>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Mar 2023 17:10:52 -0700
Message-ID: <CAP-5=fX8xyd4qby2w15s+fEC4EeZt=2J2C6gz-stgtKTk2tkuA@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix indentation errors by removing extra spaces
To:     Anup Sharma <anupnewsmail@gmail.com>, acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, leo.yan@linaro.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 1:33=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> Cleaning up tabstop related warning reported by checkpatch.pl script
>
> WARNING: Statements should start on a tabstop
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>

Thanks Anup,

Arnaldo, what's the policy on whitespace cleanup? Obviously new
patches should try to avoid it, but patches like this are sometimes
frowned upon due to losing blame history.

Anup, when I run checkpatch.pl on this I see other warnings in the same cod=
e:

```
$ b4 am ZBIro7uDO/Mii3xF@yoga
Grabbing thread from lore.kernel.org/all/ZBIro7uDO%2FMii3xF%40yoga/t.mbox.g=
z
Analyzing 1 messages in the thread
Checking attestation on all messages, may take a moment...
---
 =E2=9C=93 [PATCH] perf: Fix indentation errors by removing extra spaces
 ---
 =E2=9C=93 Signed: DKIM/gmail.com
---
Total patches: 1
---
Link: https://lore.kernel.org/r/ZBIro7uDO/Mii3xF@yoga
Base: not specified
      git am ./20230316_anupnewsmail_perf_fix_indentation_errors_by_removin=
g_extra_spaces.mbx
$ scripts/checkpatch.pl
./20230316_anupnewsmail_perf_fix_indentation_errors_by_removing_extra_space=
s.mbx
WARNING: braces {} are not necessary for single statement blocks
#78: FILE: tools/perf/jvmti/libjvmti.c:315:
+               if (line_file_names[nr_lines - 1]) {
+                       free(line_file_names[nr_lines - 1]);
+               }

WARNING: Missing a blank line after declarations
#96: FILE: tools/perf/ui/browser.c:44:
+       int color =3D ui_browser__percent_color(browser, percent, current);
+       ui_browser__set_color(browser, color);
```

These should probably be fixed at the same time.

Thanks,
Ian

> ---
>  tools/perf/builtin-lock.c      |  2 +-
>  tools/perf/builtin-trace.c     |  6 +++---
>  tools/perf/jvmti/libjvmti.c    |  8 ++++----
>  tools/perf/ui/browser.c        |  4 ++--
>  tools/perf/ui/browsers/hists.c | 10 +++++-----
>  tools/perf/util/symbol-elf.c   |  2 +-
>  6 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 054997edd98b..4a1d5a08c8d6 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2094,7 +2094,7 @@ static int parse_lock_type(const struct option *opt=
 __maybe_unused, const char *
>                         char buf[32];
>
>                         if (strchr(tok, ':'))
> -                           continue;
> +                               continue;
>
>                         /* try :R and :W suffixes for rwlock, rwsem, ... =
*/
>                         scnprintf(buf, sizeof(buf), "%s:R", tok);
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 610fb60b1c0d..155abfd07286 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1942,7 +1942,7 @@ static __maybe_unused bool trace__syscall_enabled(s=
truct trace *trace, int id)
>                                   trace->ev_qualifier_ids.nr, sizeof(int)=
, intcmp) !=3D NULL;
>
>         if (in_ev_qualifier)
> -              return !trace->not_ev_qualifier;
> +               return !trace->not_ev_qualifier;
>
>         return trace->not_ev_qualifier;
>  }
> @@ -3363,10 +3363,10 @@ static struct bpf_program *trace__find_usable_bpf=
_prog_entry(struct trace *trace
>                              candidate_is_pointer =3D candidate_field->fl=
ags & TEP_FIELD_IS_POINTER;
>
>                         if (is_pointer) {
> -                              if (!candidate_is_pointer) {
> +                               if (!candidate_is_pointer) {
>                                         // The candidate just doesn't cop=
ies our pointer arg, might copy other pointers we want.
>                                         continue;
> -                              }
> +                               }
>                         } else {
>                                 if (candidate_is_pointer) {
>                                         // The candidate might copy a poi=
nter we don't have, skip it.
> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> index fcca275e5bf9..faf5925f7433 100644
> --- a/tools/perf/jvmti/libjvmti.c
> +++ b/tools/perf/jvmti/libjvmti.c
> @@ -312,10 +312,10 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
>         (*jvmti)->Deallocate(jvmti, (unsigned char *)class_sign);
>         free(line_tab);
>         while (line_file_names && (nr_lines > 0)) {
> -           if (line_file_names[nr_lines - 1]) {
> -               free(line_file_names[nr_lines - 1]);
> -           }
> -           nr_lines -=3D 1;
> +               if (line_file_names[nr_lines - 1]) {
> +                       free(line_file_names[nr_lines - 1]);
> +               }
> +               nr_lines -=3D 1;
>         }
>         free(line_file_names);
>  }
> diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> index 78fb01d6ad63..ba725ed5c86d 100644
> --- a/tools/perf/ui/browser.c
> +++ b/tools/perf/ui/browser.c
> @@ -40,8 +40,8 @@ int ui_browser__set_color(struct ui_browser *browser, i=
nt color)
>  void ui_browser__set_percent_color(struct ui_browser *browser,
>                                    double percent, bool current)
>  {
> -        int color =3D ui_browser__percent_color(browser, percent, curren=
t);
> -        ui_browser__set_color(browser, color);
> +       int color =3D ui_browser__percent_color(browser, percent, current=
);
> +       ui_browser__set_color(browser, color);
>  }
>
>  void ui_browser__gotorc_title(struct ui_browser *browser, int y, int x)
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index b72ee6822222..947f8023a140 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -402,7 +402,7 @@ static bool hist_browser__selection_has_children(stru=
ct hist_browser *browser)
>                 return false;
>
>         if (ms =3D=3D &he->ms)
> -              return he->has_children;
> +               return he->has_children;
>
>         return container_of(ms, struct callchain_list, ms)->has_children;
>  }
> @@ -421,7 +421,7 @@ static bool hist_browser__selection_unfolded(struct h=
ist_browser *browser)
>                 return false;
>
>         if (ms =3D=3D &he->ms)
> -              return he->unfolded;
> +               return he->unfolded;
>
>         return container_of(ms, struct callchain_list, ms)->unfolded;
>  }
> @@ -436,8 +436,8 @@ static char *hist_browser__selection_sym_name(struct =
hist_browser *browser, char
>                 return NULL;
>
>         if (ms =3D=3D &he->ms) {
> -              hist_entry__sym_snprintf(he, bf, size, 0);
> -              return bf + 4; // skip the level, e.g. '[k] '
> +               hist_entry__sym_snprintf(he, bf, size, 0);
> +               return bf + 4; // skip the level, e.g. '[k] '
>         }
>
>         callchain_entry =3D container_of(ms, struct callchain_list, ms);
> @@ -3599,7 +3599,7 @@ static bool evlist__single_entry(struct evlist *evl=
ist)
>         int nr_entries =3D evlist->core.nr_entries;
>
>         if (nr_entries =3D=3D 1)
> -              return true;
> +               return true;
>
>         if (nr_entries =3D=3D 2) {
>                 struct evsel *last =3D evlist__last(evlist);
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 41882ae8452e..32bd70d7b712 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -304,7 +304,7 @@ static char *demangle_sym(struct dso *dso, int kmodul=
e, const char *elf_name)
>          * to it...
>          */
>         if (!want_demangle(dso->kernel || kmodule))
> -           return demangled;
> +               return demangled;
>
>         demangled =3D bfd_demangle(NULL, elf_name, demangle_flags);
>         if (demangled =3D=3D NULL) {
> --
> 2.34.1
>
