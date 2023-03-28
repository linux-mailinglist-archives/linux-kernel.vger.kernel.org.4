Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42466CC7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjC1QWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC1QWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:22:02 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C64DBEE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:22:01 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3e0965f70ecso135891cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680020520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oxn8nTbQaOTMetn/sNIvHJIXX3TzoHjySwpSLICeOg=;
        b=nfF+dU3tfEyt04fh1/XwDi2B2Edck4nMMhV2zkib5BiB9kekOWz4/Jeq6D1cW8YziA
         dE6JcI7mVUBxHO+1YpIXZn8AtWc+c6pOxXJhV9pvpTwg3ZZQzSsiTT5M/7m82FjZbzV1
         N+fPFV7Cfb/S1AQFTBkK3/GxefvAkGbj6HQv4CaKOS+oJ79PDnYDvDu3oayGUixW7enB
         bHOOdMXZg2SJ73wlWridRt5zinA9l24/I/lBwHUTwkeIxX1gNcorqhsfne8baCBYTwOj
         a3JKIkyECZlD247/owu28BlfL+qOQTYpSCVYUF5I+nE6YkvoBLQlR01pVKbXP4H9Wt8I
         Eecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680020520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oxn8nTbQaOTMetn/sNIvHJIXX3TzoHjySwpSLICeOg=;
        b=TWmZF1CKO0oGu4nCSmk1Mc99YHPW2P4Z4VsG/m+dISlVlSpQvtq5WmkQYQm0YJ5ROE
         yYzevJt3H8CsRoc3tmZVDhBTujtP83/eHy1ffIUsa3zY5ABiG2gfTd5BzMfbwUz11qSZ
         E/WAiW70S4W6/kh5M2bYlYoMfJhOyBhzy06j1BaZouq4XjcxvdRGHUZDcOOu9NcmwTO2
         G1X3LsfFKV2IHhvfi71e0EfE+MMuDR3Js2CNm8aXb2rZW9Ry0mQgaRr5GeVY6qRQvG8R
         lSE9bxpoHDiZnmDM2HwhyNbfj/1H8ImtqGJvPqQ4Jjlxdb1sxuxPwBPTE4a8YlEMdpiD
         e2iw==
X-Gm-Message-State: AAQBX9d5zJAidTU/f0s5/BSNKGQkv611f75SuCVdmhZZtmHp26QC99L4
        TIMLbhlOXFZo32eMuNBUrVuWB6XaD4p651QbNjlvvw==
X-Google-Smtp-Source: AKy350YyPtOQtBrbD3l/8Mh9YVfhMzfhYutuWTipioNOMVSceICp/9VY1tIWWQ6nvLUjxjm9X+9CPRKrRArLStwP74Q=
X-Received: by 2002:ac8:58ca:0:b0:3db:1c01:9d95 with SMTP id
 u10-20020ac858ca000000b003db1c019d95mr536602qta.4.1680020520530; Tue, 28 Mar
 2023 09:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230328112908.113158-1-kjain@linux.ibm.com>
In-Reply-To: <20230328112908.113158-1-kjain@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Mar 2023 09:21:49 -0700
Message-ID: <CAP-5=fXU4F=LvE883EVjq0bWHKJ-LT12pTr827jqwGfH1RTXdw@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events power9: Remove UTF-8 characters from
 json files
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, sukadev@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, disgoel@linux.ibm.com,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 4:30=E2=80=AFAM Kajol Jain <kjain@linux.ibm.com> wr=
ote:
>
> Commit 3c22ba524304 ("perf vendor events powerpc: Update POWER9 events")
> added and updated power9 pmu json events. However some of the json
> events which are part of other.json and pipeline.json files,
> contains UTF-8 characters in their brief description.
> Having UTF-8 character could brakes the perf build on some distros.

nit: s/bakes/break/

> Fix this issue by removing the UTF-8 characters from other.json and
> pipeline.json files.
>
> Result without the fix patch:
> [command]# file -i pmu-events/arch/powerpc/power9/*
> pmu-events/arch/powerpc/power9/cache.json:          application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/floating-point.json: application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/frontend.json:       application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/marked.json:         application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/memory.json:         application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/metrics.json:        application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/nest_metrics.json:   application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/other.json:          application/json; cha=
rset=3Dutf-8
> pmu-events/arch/powerpc/power9/pipeline.json:       application/json; cha=
rset=3Dutf-8
> pmu-events/arch/powerpc/power9/pmc.json:            application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/translation.json:    application/json; cha=
rset=3Dus-ascii
>
> Result with the fix patch:
>
> [command]# file -i pmu-events/arch/powerpc/power9/*
> pmu-events/arch/powerpc/power9/cache.json:          application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/floating-point.json: application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/frontend.json:       application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/marked.json:         application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/memory.json:         application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/metrics.json:        application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/nest_metrics.json:   application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/other.json:          application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/pipeline.json:       application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/pmc.json:            application/json; cha=
rset=3Dus-ascii
> pmu-events/arch/powerpc/power9/translation.json:    application/json; cha=
rset=3Dus-ascii
>
> Fixes: 3c22ba524304 ("perf vendor events powerpc: Update POWER9 events")
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.com>
> Link: https://lore.kernel.org/lkml/ZBxP77deq7ikTxwG@kernel.org/
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/powerpc/power9/other.json    | 4 ++--
>  tools/perf/pmu-events/arch/powerpc/power9/pipeline.json | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools=
/perf/pmu-events/arch/powerpc/power9/other.json
> index 3f69422c21f9..f10bd554521a 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
> @@ -1417,7 +1417,7 @@
>    {
>      "EventCode": "0x45054",
>      "EventName": "PM_FMA_CMPL",
> -    "BriefDescription": "two flops operation completed (fmadd, fnmadd, f=
msub, fnmsub) Scalar instructions only. "
> +    "BriefDescription": "two flops operation completed (fmadd, fnmadd, f=
msub, fnmsub) Scalar instructions only."
>    },
>    {
>      "EventCode": "0x201E8",
> @@ -2017,7 +2017,7 @@
>    {
>      "EventCode": "0xC0BC",
>      "EventName": "PM_LSU_FLUSH_OTHER",
> -    "BriefDescription": "Other LSU flushes including: Sync (sync ack fro=
m L2 caused search of LRQ for oldest snooped load, This will either signal =
a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid =
Flush Next (several cases of this, one example is store and reload are line=
d up such that a store-hit-reload scenario exists and the CDF has already l=
aunched and has gotten bad/stale data); Bad Data Valid Flush Next (might be=
 a few cases of this, one example is a larxa (D$ hit) return data and dval =
but can't allocate to LMQ (LMQ full or other reason). Already gave dval but=
 can't watch it for snoop_hit_larx. Need to take the =E2=80=9Cbad dval=E2=
=80=9D back and flush all younger ops)"
> +    "BriefDescription": "Other LSU flushes including: Sync (sync ack fro=
m L2 caused search of LRQ for oldest snooped load, This will either signal =
a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid =
Flush Next (several cases of this, one example is store and reload are line=
d up such that a store-hit-reload scenario exists and the CDF has already l=
aunched and has gotten bad/stale data); Bad Data Valid Flush Next (might be=
 a few cases of this, one example is a larxa (D$ hit) return data and dval =
but can't allocate to LMQ (LMQ full or other reason). Already gave dval but=
 can't watch it for snoop_hit_larx. Need to take the 'bad dval' back and fl=
ush all younger ops)"
>    },
>    {
>      "EventCode": "0x5094",
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json b/to=
ols/perf/pmu-events/arch/powerpc/power9/pipeline.json
> index d0265f255de2..723bffa41c44 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
> @@ -442,7 +442,7 @@
>    {
>      "EventCode": "0x4D052",
>      "EventName": "PM_2FLOP_CMPL",
> -    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fa=
bs, fnabs, fres ,fsqrte, fneg "
> +    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fa=
bs, fnabs, fres ,fsqrte, fneg"
>    },
>    {
>      "EventCode": "0x1F142",
> --
> 2.39.1
>
