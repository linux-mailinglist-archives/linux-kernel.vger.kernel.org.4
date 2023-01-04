Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98EE65DC86
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjADTG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjADTG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:06:28 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B9B19C3E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:06:24 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j17so28671036wrr.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ef48NZZOyLTJmvsKcxl0j1f+YUFvaKmNOdYNZPwUkM=;
        b=jIoUoHMTIDUZ27HZuHgFt9n3wmtwVI2W7i2diaYIMRDPXIdC2vH0px3/nu8LWvQo94
         lCkCXh/sOyFaqeS/gtyGPr+QsKpA4t/rogw9pfhkgjSWiClA6UqsPcMW8LRe0BLYbjic
         mFVvrEs0LCt7/7YsicrciPu6ZIphx0Orl9Tn5V89IcFaUMMrmudm+6XDVYUFxsdNRi/i
         x9SMdxxlPIQTQr8GnQW7j49NooBye3XKTYTsIBNDKuoK0NHnkCZwyGk2SglO1RyWjHKw
         UoM9xihM3zPcn3iW0BSqRla6r/U/gmcxyHpf/aYG+5ciUqDmyxAFLoh9+WzQUMGLtsL1
         hL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ef48NZZOyLTJmvsKcxl0j1f+YUFvaKmNOdYNZPwUkM=;
        b=EIEAOOgl+cYS11Io+daJLssh04Jr5ji9nMEffbDFm24h8KHjI3mIYO24Ym7cuBkhHq
         Y2BbP6GAH4JYQpTIeBoBa7f5j2qOIz+RYqqWhEoOuEaVV1f13J//buePODzgDcCZPpU4
         DgpPjqyVJLQuggQ3nlQwjHGRrhyjQl0rSf6FDqKS5lCji3JWobKdmbnOqtQsWhc7rugd
         tYfgGH0/NEjs5BaO6u4e2bvMeWX7gHcRKjAEYQJTSPewwO/7gLk4jesz4wLJeIoX6Z5L
         nDEraqW/HD8U8fSJnHZplPTzNjKsShZVWqLh7GT4Mox8534dhyBMygDYFzXLcQdogvRY
         Invw==
X-Gm-Message-State: AFqh2krg7QJpWv4tK+RxGI6NMi8QRh7WJZLC1GSDtIsp+YkbfMonzO1a
        h6JqhdFH/rMl0+SrnoULonyj2yXSQdbFrtCtDgOgAw==
X-Google-Smtp-Source: AMrXdXvPv7suAgyrm/H1f+8JYayP5Zkx1Al06mcHdumDSAp525Q8vihSgAxL7evHufTaU0062/2UQ2XguyJEUj9UU+s=
X-Received: by 2002:a5d:4590:0:b0:27e:cf2e:ca4e with SMTP id
 p16-20020a5d4590000000b0027ecf2eca4emr711540wrq.343.1672859183174; Wed, 04
 Jan 2023 11:06:23 -0800 (PST)
MIME-Version: 1.0
References: <20230104182313.3164736-1-jesussanp@google.com>
In-Reply-To: <20230104182313.3164736-1-jesussanp@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 4 Jan 2023 11:06:11 -0800
Message-ID: <CAP-5=fWXsuh84WN_4dC_ydZCfmXgJrns+OKG+f_D6YqWiioDCA@mail.gmail.com>
Subject: Re: [PATCH] perf: Add missing sys/types.h include
To:     Jesus Sanchez-Palencia <jesussanp@google.com>
Cc:     linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
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

On Wed, Jan 4, 2023 at 10:23 AM Jesus Sanchez-Palencia
<jesussanp@google.com> wrote:
>
> Not all libc implementations define ssize_t as part of stdio.h like
> glibc does since the standard only requires this type to be defined by
> unistd.h and sys/types.h. For this reason the perf build is currently
> broken for toolchains based on uClibc, for instance.
>
> Include sys/types.h explicitly to fix that. This is a follow up to
> commit 378ef0f5d9d7 ("perf build: Use libtraceevent from the system").
>
> Signed-off-by: Jesus Sanchez-Palencia <jesussanp@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/trace-event.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> index add6c5d9531c..9b3cd79cca12 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -4,6 +4,7 @@
>
>  #include <stdbool.h>
>  #include <stdio.h>
> +#include <sys/types.h>
>  #include <linux/types.h>
>
>  struct evlist;
> --
> 2.39.0.314.g84b9a713c41-goog
>
