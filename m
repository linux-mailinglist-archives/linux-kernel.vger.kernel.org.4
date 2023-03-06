Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D1C6ACBBA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjCFR6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjCFR6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:58:39 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548DACA1E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:57:55 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id t1so2937742iln.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 09:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678125429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UjJFmFcrzQyLkDoqQJKES4jLI+n1bV1G4vm/c96RzY=;
        b=Myk0oDqIVJYkJZsD+URPYyVnIwGWdsfib1FzJqrS0ScuHzqfArIByvxFQV8dKQRz05
         Rc2dkCTQQ1lrC8IyvfRJoeaA80WwzUvHcSy75gHW9Y5QxLq7rtW8DxGfDJimhgpsJXlD
         GpskPBnIYk+2or+SIrzyKR8iUGKfyg8mD3n+0ewwS5SzIHSQKBdwSwAIxPl7ZSZgFcb4
         lNVWqc0g8XV8/zGI7mCwTrQueeXW6f2vVgA00mZqIOXNXrzlYD4jZEj+zL5OsNmd6p6u
         Ufsj84r5QFS6WX+UsmdPuyttakeAizk+8JmAuUJWi4RaBABx3grUF2oUFMnIg93KaACT
         xq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678125429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UjJFmFcrzQyLkDoqQJKES4jLI+n1bV1G4vm/c96RzY=;
        b=vuPEVa0b4k5BFg1WNmOFEd6Fez2lUxR93edPU5vHf2j+8jSD95l9xBvkmQeYlqVIa+
         KWtocWNn3+raPRWAme7ZwYbG4+79RwcFICHRT8cSnHN73Af5y7Grt6rBhcz9/VH1z3Qm
         2rmCsSxO4Fuejel1E71gIAyDkzZ5jWMMfm3cuWtth0YuaNjLgx1hYxIOLEHJ/U+VKXEs
         fl7Mhmet+ne/nhkG2uMfK7SynBR7jmE04GJy2ebOAGnr7q4h+Yu0d7Msk1XbdS68oKec
         s5keZ3V4LlCj5byPKz2lc7HLjW5TJjwrd0bBS7BYRx3MajucQQE+0XBgR+0iEKh5fEeq
         20tw==
X-Gm-Message-State: AO0yUKUJQ4vk/e3X64W5LDgCHuMhICjfy1y49gbY2QvxMfpJPjXjgMwE
        yGx4TYDqayw0U0nPfaqk9NNN9+8yL+YsGftfCRrsvA==
X-Google-Smtp-Source: AK7set/dggptUzbzVNmGuH4ZT/0EJp/q5uVroS2DJKLJFxznKY98XqROSAIo6IwznVpeVjo+iXKTBmUSLw240q9hGVw=
X-Received: by 2002:a92:c20e:0:b0:314:24e2:5189 with SMTP id
 j14-20020a92c20e000000b0031424e25189mr5576533ilo.0.1678125429485; Mon, 06 Mar
 2023 09:57:09 -0800 (PST)
MIME-Version: 1.0
References: <ZAYosCjlzO9plAYO@kernel.org>
In-Reply-To: <ZAYosCjlzO9plAYO@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 6 Mar 2023 09:56:58 -0800
Message-ID: <CAP-5=fXrweSNi95D-3JS98xf5-tXfDrFqidnZFM6dCEFyL5Rrg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tools: Add Adrian Hunter to MAINTAINERS as a reviewer
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Mar 6, 2023 at 9:53=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Please ack :-)
>
> --
>
> Adrian is the main author of the Intel PT codebase and has been
> reviewing perf tooling patches consistently for a long time, so lets
> reflect that in the MAINTAINERS file so that contributors add him to the
> CC list in patch submissions.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66b5d5a51d5b1110..8e46fa10a631e4d6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16425,6 +16425,7 @@ R:      Alexander Shishkin <alexander.shishkin@li=
nux.intel.com>
>  R:     Jiri Olsa <jolsa@kernel.org>
>  R:     Namhyung Kim <namhyung@kernel.org>
>  R:     Ian Rogers <irogers@google.com>
> +R:     Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

>  L:     linux-perf-users@vger.kernel.org
>  L:     linux-kernel@vger.kernel.org
>  S:     Supported
> --
> 2.39.2
>
