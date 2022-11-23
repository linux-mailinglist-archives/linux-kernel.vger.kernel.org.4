Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0681E636E67
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKWXbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKWXbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:31:12 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEF549B5D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:31:11 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 83-20020a1c0256000000b003d03017c6efso2017718wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Gh9adVajP218Ts3ApPAosWBBtQBdYWaRz2QA1+khtY=;
        b=HqThi0RtqIKtE7Hjk/pvTU/Ly6yW/y6qWaDK+myj+xWWLcupKPL+72uQbpAGYGwF9P
         YYPNGeYWJttf7vNQIAEfyzJCUpFC9BHm0OdJfpYeoUOVeXTOsTNB2+iiGVCgY4q3sFEd
         16j5SGUB8AcKs1BvDUMprlQCAS2FBkLF9j2tRMXtB3E4ApfDrEvz3HLzCUrzLhtNZXxR
         RuO/2i3wb7nFSRqp8TmeqbJsjy/wdnx4S3asMkDb30Uu6lxTy5qdQ55bFuGiIfTu7Vss
         dmaKTUqMgNdoDuVQzk5QA0KddC2ob8WAzen4fuq4x76bftwqG8zDw18c7yjWEjYj6FZQ
         Kgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Gh9adVajP218Ts3ApPAosWBBtQBdYWaRz2QA1+khtY=;
        b=eXQMa1eUeUxAz5ZjtY6/u9/QJQBOITWX4nc4dNtGwpSiQpX/TLSojZVy+xCy3wz/p3
         Kxg5kNbVGmaT9V+CC/fLfn7I4D7FSb1Crq6U3oMv6rfunoyIsXIK3KlH+MEd2RfOED3E
         knGUQ/z1bc2tLLAZqY9zYDFflQTdU4R4zskEATPLwV0Ix2HrOcRAPAeQ3jkLjCZTMYMW
         b9P8tOfc7SCtcApO8tCVI0aDMJUq02mIs/jMSnV7fiEQQ6wm65GvTO3Vyt9Lv9JK7KtI
         NGOINrRPoamB4v8cBTVEdwNbERLZv51iDeZNVZlTxA8r8gNJqrOKZgex3qFkSCXsHACm
         8XJw==
X-Gm-Message-State: ANoB5pkCiYif+KnyYzx8/d8nQUCPhyl0ZevRm1A6O50gHoxzGH3r5J+4
        GVXwWxUYLUujmz/merLsAR6BaXvj7nYHlx6HFbu45A==
X-Google-Smtp-Source: AA0mqf5HIHYQdZbYDp1s7lpv3EqNoj/9DctXzBPhAZrbRXn+ZcvGKoBv9/gW+rlKWpQtQYcH3rcWnFdpf9C8juK6kM4=
X-Received: by 2002:a1c:7318:0:b0:3cf:cb16:f24a with SMTP id
 d24-20020a1c7318000000b003cfcb16f24amr24822853wmb.182.1669246269491; Wed, 23
 Nov 2022 15:31:09 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-15-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-15-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:30:56 -0800
Message-ID: <CAP-5=fVJjPXk2hmWc6xqDxe06Arq-nOB51CwihAuuVFAoaKJ4g@mail.gmail.com>
Subject: Re: [PATCH 14/15] perf stat: Rename "aggregate-number" to "cpu-count"
 in JSON
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> As the JSON output has been broken for a little while, I guess there are
> not many users.  Let's rename the field to more intuitive one. :)

I'm not sure cpu-count is accurate. For example, an uncore counter in
a dual socket machine may have a CPU mask of "0, 36", ie one event per
socket. The aggregate-number in this case I believe is 2.

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 43640115454c..7a39a1a7261d 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -281,19 +281,19 @@ static void print_aggr_id_json(struct perf_stat_config *config,
>
>         switch (config->aggr_mode) {
>         case AGGR_CORE:
> -               fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
> +               fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"cpu-count\" : %d, ",
>                         id.socket, id.die, id.core, nr);
>                 break;
>         case AGGR_DIE:
> -               fprintf(output, "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d, ",
> +               fprintf(output, "\"die\" : \"S%d-D%d\", \"cpu-count\" : %d, ",
>                         id.socket, id.die, nr);
>                 break;
>         case AGGR_SOCKET:
> -               fprintf(output, "\"socket\" : \"S%d\", \"aggregate-number\" : %d, ",
> +               fprintf(output, "\"socket\" : \"S%d\", \"cpu-count\" : %d, ",
>                         id.socket, nr);
>                 break;
>         case AGGR_NODE:
> -               fprintf(output, "\"node\" : \"N%d\", \"aggregate-number\" : %d, ",
> +               fprintf(output, "\"node\" : \"N%d\", \"cpu-count\" : %d, ",
>                         id.node, nr);
>                 break;
>         case AGGR_NONE:
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
