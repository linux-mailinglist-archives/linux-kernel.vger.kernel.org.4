Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940CE62321E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiKISPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKISP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:15:29 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DED610B55;
        Wed,  9 Nov 2022 10:15:28 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-13be3ef361dso20493873fac.12;
        Wed, 09 Nov 2022 10:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boHIOzdbezf2BQcC57pQ2ZTCZGFD8AJvBKKorhnN5Yw=;
        b=oRxsUnUMYYTu7ccQ8ve3UpOCwfXxPQQ/Bs8PsNL0EB/COTrpytzCJiCinE5GRhNPJX
         3y8Kk1lVr4p+MJmhXukeDDNH20zxlOgYaGh5oWtrXAtwBSJceySi6tTjbdJLvVVdp6Vn
         TCPTEOiYEi+T/r7S8nReggh3qRsQ6XOmBLOrrMS8REppImox1cRriuiAo1QR8eZD1q4+
         g9tkkA7/rIi9tsifxZk9EQj/wE1S8HQWe1la93KstFQrejlFdBUUiTLBUuXSgOByKFuZ
         dzkaN0gniN+OwwKdq4MP/Wi2Kcp4IQs+wyX8J/sWhyu2Q0i9ewjUc/NwKQW9UE3who0z
         gUzQ==
X-Gm-Message-State: ACrzQf0U9kfey1IBaWJNpzEOpaMCH7JdOTUW0TyWJmagsXqDflhW95PM
        nyWVtAhGU1UY7zLAk/dXyr6w5BNhq9MuvEaQem95c0Fu
X-Google-Smtp-Source: AMsMyM5yDqY5KhSDdeMhpy/0I26DsUZ0bTY5dr9qCprppdYhxWBYS0fqf4EaynISnAHKsW8sTYPNEC6HT86FOKXF9S8=
X-Received: by 2002:a05:6870:9a27:b0:140:6f4c:f532 with SMTP id
 fo39-20020a0568709a2700b001406f4cf532mr16480170oab.209.1668017727719; Wed, 09
 Nov 2022 10:15:27 -0800 (PST)
MIME-Version: 1.0
References: <1667982547-22331-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1667982547-22331-1-git-send-email-yangtiezhu@loongson.cn>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Nov 2022 10:15:16 -0800
Message-ID: <CAM9d7ciVpT05OCSzB9t9v71Yb7pfhSat3XpK3cTwn-z+DVkJqQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] perf: Add more syscalls to benchmark
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 9, 2022 at 12:29 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> Tiezhu Yang (4):
>   tools x86: Keep list sorted by number in unistd_{32,64}.h
>   perf bench syscall: Introduce bench_syscall_common()
>   perf bench syscall: Add getpgrp syscall benchmark
>   perf bench syscall: Add execve syscall benchmark

Have you tested it on non-x86 too?  It seems you only added the syscall
numbers to x86.

Thanks,
Namhyung


>
>  tools/arch/x86/include/uapi/asm/unistd_32.h | 23 ++++++---
>  tools/arch/x86/include/uapi/asm/unistd_64.h | 23 ++++++---
>  tools/perf/bench/bench.h                    |  2 +
>  tools/perf/bench/syscall.c                  | 76 +++++++++++++++++++++++++++--
>  tools/perf/builtin-bench.c                  |  2 +
>  5 files changed, 108 insertions(+), 18 deletions(-)
>
> --
> 2.1.0
>
