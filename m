Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F3E6C8A01
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjCYBjk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 21:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCYBjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:39:39 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE74C1ABCB;
        Fri, 24 Mar 2023 18:39:37 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id m22so1529097ioy.4;
        Fri, 24 Mar 2023 18:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679708377; x=1682300377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybmP8zFCYOKLUkKvZGEXOX0B0e1wfkcwTmJp+zX8qM8=;
        b=ug3dEvNPQc31l1O9Sv4q2YYcaL5AA7qXpV9PDvxvRqVCj6JSDrlQJmUyx+dcpDVksq
         iMIfuSO2De2N+tPqv9WOmOb1oo6rWd4jEdu0z5vKlLaZMvO/7BWqH9OSZ5tXES0x8gXA
         HVVFTxyP+2/36o6ZTjWa9LcgWDKWlYND60rVe9+LyrWRMGAsL1QhO2WmDRtDqkpqyWND
         0rzdj+uAsiuT2nAWGXIj8w5p/zMFKSZju3C1UNQHjKRLBnsUq3cL5hIreMW2P2HaT/4F
         HDcVQUafUOIxiO6P7770hdvvmxuxfN4PBxR/hxqGJ+kaSh4eS8Y3ZLgPuecbZ1prJBBY
         Ks4w==
X-Gm-Message-State: AO0yUKWQo7cvP8Y6lHsiV6teblUT94kimmYIM3KZzVrVogC7u4YALCTP
        b4Tp2T91lJt/7zYVHSR/vDeD9wCJ8MqvfEe36KEh0vAE
X-Google-Smtp-Source: AK7set+7H4W86MOalG0+vU2zk//Qpwcui/nAxWzxThdWA7ydFF4O7OJOWIJRclYMvCqo5zh+0t1HwJFqsJt0fU3XbVM=
X-Received: by 2002:a6b:5b17:0:b0:74d:1318:618c with SMTP id
 v23-20020a6b5b17000000b0074d1318618cmr3621323ioh.10.1679708377033; Fri, 24
 Mar 2023 18:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230324032702.109964-1-yangjihong1@huawei.com>
In-Reply-To: <20230324032702.109964-1-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 24 Mar 2023 18:39:25 -0700
Message-ID: <CAM9d7ciGy2Mycm6etHDrt6tu331i-7DphHgBzde0_1=w67mvHg@mail.gmail.com>
Subject: Re: [PATCH] perf ftrace: Make system wide the default target for
 latency subcommand
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Mar 23, 2023 at 8:29 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> If no target is specified for 'latency' subcommand, the execution fails
> because - 1 (invalid value) is written to set_ftrace_pid tracefs file.
> Make system wide the default target, which is the same as the default
> behavior of 'trace' subcommand.

I followed the convention to use -a for system-wide profiling.
Not sure if it's ok to make it default, but I don't object. :)

Thanks,
Namhyung

>
> Before the fix:
>
>   # perf ftrace latency -T schedule
>   failed to set ftrace pid
>
> After the fix:
>
>   # perf ftrace latency -T schedule
>   ^C#   DURATION     |      COUNT | GRAPH                                          |
>        0 - 1    us |          0 |                                                |
>        1 - 2    us |          0 |                                                |
>        2 - 4    us |          0 |                                                |
>        4 - 8    us |       2828 | ####                                           |
>        8 - 16   us |      23953 | ########################################       |
>       16 - 32   us |        408 |                                                |
>       32 - 64   us |        318 |                                                |
>       64 - 128  us |          4 |                                                |
>      128 - 256  us |          3 |                                                |
>      256 - 512  us |          0 |                                                |
>      512 - 1024 us |          1 |                                                |
>        1 - 2    ms |          4 |                                                |
>        2 - 4    ms |          0 |                                                |
>        4 - 8    ms |          0 |                                                |
>        8 - 16   ms |          0 |                                                |
>       16 - 32   ms |          0 |                                                |
>       32 - 64   ms |          0 |                                                |
>       64 - 128  ms |          0 |                                                |
>      128 - 256  ms |          4 |                                                |
>      256 - 512  ms |          2 |                                                |
>      512 - 1024 ms |          0 |                                                |
>        1 - ...   s |          0 |                                                |
>
> Fixes: 53be50282269 ("perf ftrace: Add 'latency' subcommand")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/builtin-ftrace.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index d7fe00f66b83..fb1b66ef2e16 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -1228,10 +1228,12 @@ int cmd_ftrace(int argc, const char **argv)
>                 goto out_delete_filters;
>         }
>
> +       /* Make system wide (-a) the default target. */
> +       if (!argc && target__none(&ftrace.target))
> +               ftrace.target.system_wide = true;
> +
>         switch (subcmd) {
>         case PERF_FTRACE_TRACE:
> -               if (!argc && target__none(&ftrace.target))
> -                       ftrace.target.system_wide = true;
>                 cmd_func = __cmd_ftrace;
>                 break;
>         case PERF_FTRACE_LATENCY:
> --
> 2.30.GIT
>
