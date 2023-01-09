Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEAE66309A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbjAITlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbjAITkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:40:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86877D1A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:40:44 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso4910284wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o93RGUSe+ygfsACOiKR79noLA/HJS4wxmrTmGVyWD9c=;
        b=K2ZY16K/q8V/OQ5/nhKP+F6QxZmA66JgfLoNOjIGiMgj8eYnIYc367mu5hGa3JQ/kQ
         WyOo86YWyfRnZCI8MWqaYLlyaRrM3VIf84LROoz3XJgCP/fEqoG/f/DueUpWspCfDWFu
         ECICRkkdsXYvb7kj6cUTG9xJ5ma0+M/QFT0ZUaOlqrQ1CaIf8SSbLBT8hllbtr8XXWZw
         m2n9tXVgqIU0oABhnhTtNJOOnmQeyPuxZTk/kPfq5P2LDbRQXEsl60m+1oUx0UosfzJ+
         6HD6YaqDifw27U9PB9anWyzHK3RobDD3VWbPfmAUzsOYnXSNUISSgfIPi0SjDmsG+z4h
         9tYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o93RGUSe+ygfsACOiKR79noLA/HJS4wxmrTmGVyWD9c=;
        b=xJMwmNJRki28W6bCKqk55lXiUr+gBmbNRMK+kh3+QpyI7Sm0PhKaXf6MG8rPYX2t5r
         gqrJJn/97XroERfo5xw8/wbMA3XHLLxUfxdKbDaAJaqXyam7D25CWb44txdSNTexNvB1
         lzgJaEhj4YtLZ+5hEKYpO6KusWFcDhJLGRh4nUS617hH9Pg6ZhA6/YvuyDuSdDaV4DDp
         mbP1G69aJRXPQWeTY2pJxY7J5k6N2NTaFVax+zy8QOJHHuj0xthvQTT/MCxx02Sb5BvZ
         1X8JZ9xLkDEkWLkE9mZrm7m5JgND0RuPYz1EWKJOAkouKeTMXtS5jhiGV3S77FDooQ0z
         YGuQ==
X-Gm-Message-State: AFqh2kpf7wyQVvtGDDhSoqCyK4DYaZVJ082NPAoN5VGTeF9tKgq5/VAz
        1dXvoN+jUqgxaU37q+ln6aJQt+jNFMrVD9oDyicdlA==
X-Google-Smtp-Source: AMrXdXusViWQjcqDzOLejRAyUcdIr65857dE+IhEjEhRmFv45VYDSd1fgiojh1X8rnq2Hd+ZaNwTff7nOt0hEyF8UeQ=
X-Received: by 2002:a05:600c:5d5:b0:3cf:6a4c:af8b with SMTP id
 p21-20020a05600c05d500b003cf6a4caf8bmr4873036wmd.115.1673293242667; Mon, 09
 Jan 2023 11:40:42 -0800 (PST)
MIME-Version: 1.0
References: <Y7xXz+TSpiCbQGjw@kernel.org>
In-Reply-To: <Y7xXz+TSpiCbQGjw@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 Jan 2023 11:40:30 -0800
Message-ID: <CAP-5=fVr9nuKH=su5rxWer=o3KML4bk5oEzfUp_gtJBWoF0rgw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tools: Don't install libtraceevent plugins as
 its not anymore in the kernel sources
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jan 9, 2023 at 10:07 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> While doing 'make -C tools/perf build-test' one can notice error
> messages while trying to install libtraceevent plugins, stop doing that
> as libtraceevent isn't anymore a homie.
>
> These are the warnings dealt with:
>
>    make_install_prefix_slash_O: make install prefix=/tmp/krava/
>     failed to find: /tmp/krava/etc/bash_completion.d/perf
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_cfg80211.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_scsi.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_xen.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_function.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_sched_switch.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_mac80211.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_kvm.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_kmem.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_hrtimer.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_jbd2.so
>
> Fixes: 4171925aa9f3f7bf ("tools lib traceevent: Remove libtraceevent")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Link: http://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.config |  8 --------
>  tools/perf/tests/make      | 12 ------------
>  2 files changed, 20 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index c2504c39bdcb8992..156440ea019143f8 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1314,14 +1314,6 @@ tip_instdir_SQ = $(subst ','\'',$(tip_instdir))
>
>  export perfexec_instdir_SQ
>
> -# If we install to $(HOME) we keep the traceevent default:
> -# $(HOME)/.traceevent/plugins
> -# Otherwise we install plugins into the global $(libdir).
> -ifdef DESTDIR
> -plugindir=$(libdir)/traceevent/plugins
> -plugindir_SQ= $(subst ','\'',$(plugindir))
> -endif
> -
>  print_var = $(eval $(print_var_code)) $(info $(MSG))
>  define print_var_code
>      MSG = $(shell printf '...%40s: %s' $(1) $($(1)))
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 05e818a8bbad11a4..009d6efb673ce828 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -222,19 +222,7 @@ installed_files_bin := bin/perf
>  installed_files_bin += etc/bash_completion.d/perf
>  installed_files_bin += libexec/perf-core/perf-archive
>
> -installed_files_plugins := $(lib)/traceevent/plugins/plugin_cfg80211.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_scsi.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_xen.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_function.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_sched_switch.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_mac80211.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_kvm.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_kmem.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_hrtimer.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_jbd2.so
> -
>  installed_files_all := $(installed_files_bin)
> -installed_files_all += $(installed_files_plugins)
>
>  test_make_install       := $(call test_dest_files,$(installed_files_all))
>  test_make_install_O     := $(call test_dest_files,$(installed_files_all))
> --
> 2.39.0
>
