Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984F6606C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJTXsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJTXsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:48:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AC722B3AC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:48:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bv10so2113419wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DAo+j/Kx/eYwkjkxQHVaiOLaYikKqvSkEAXHJj4lh6c=;
        b=NsYqMoxLwvopRdWRaz57CxiyjPCONM7AggCSYYVz3fNxuCFZ9Ml7/5d/1i1hvwFVP4
         UDlP4J+ZcbymbpRsDFklzyPYP3rdMRCQBRy288+JZMNtmKOt+cYfiWUNIfMxengcX3aX
         b+LiD3GxZnRtGmrVISPvNWghArkpCLT66eErLrd7f+Na7u0xJVMKRkbbWoU3Yautym0J
         bRbpFkngu+Z/5oDb3Fva1OPgxF0fTm4TuGw5yZEfk1uAGD1mm4yNKh6pwZZulrwS4mzy
         qeB+BsjenWrwnEdU5zqYRLQ8dO5v4SfCepiYZ7VCd355OQ4ryhkOjlMcMI82YQhcrYF4
         bORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAo+j/Kx/eYwkjkxQHVaiOLaYikKqvSkEAXHJj4lh6c=;
        b=e3FAkKLQ2b8p2XJR+hLHk4C/BvRoc7mhNBFz7vOpbZj79JtsQQOWOx1qhpOdVVWSRg
         SD5MrM9t9J1b0bWSSZ72k+9QayTGx/dP7+wCpkyXoevZjWgBotZJ0feB91rGXehnvhIu
         CMWrXDF4r9TyrrR4ZmNZ/Zg+9PJSc3zz8HlexCGVJXIbYq5xMlXR5Li6IFWSaowv4OoQ
         r9W3KS3KGWLlda2/r2LkRk7tefg0Lw597YdNbCxClZ3Mu4qhXR1Tr91+cHOUte08TS5I
         KvpI6Pv4RwXxpAWeXswzdoVfqEYZD22fzAOQ4ViaeYLdHMrdv/Ch6G8vsAtxOZy8NAfj
         Nz3g==
X-Gm-Message-State: ACrzQf0ek9vAVoo7OfVehnteOCy/UZlRWOyptfQ2e8Vj9Yn/2oZr5D9C
        f0zq6yWKvT/SRd7FGem4zZkMljYq0kTuukFay7CyjQ==
X-Google-Smtp-Source: AMsMyM47IZ0+emCPVKcSR45YOrL8IcCmIAd4EzDAz37FOOqEp2+gEQR1BkSi1POdVLl2xE9553s8EzpP0OJMS+jtDwA=
X-Received: by 2002:a5d:4c92:0:b0:236:4b97:6828 with SMTP id
 z18-20020a5d4c92000000b002364b976828mr2234355wrs.300.1666309693365; Thu, 20
 Oct 2022 16:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221020172643.3458767-1-namhyung@kernel.org> <20221020172643.3458767-3-namhyung@kernel.org>
In-Reply-To: <20221020172643.3458767-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Oct 2022 16:48:01 -0700
Message-ID: <CAP-5=fVdoCUq9RrmPZhzA-4MaRMWGeFEzFk6R2uR=5xGugTXeg@mail.gmail.com>
Subject: Re: [PATCH 2/8] perf test: Fix shellcheck issues in the record test
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:26 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Basically there are 3 issues:
>
>  1. quote shell expansion
>  2. do not use egrep
>  3. use upper case letters for signal names
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 747c33a1ec45..464071462809 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -8,16 +8,16 @@ err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>
>  cleanup() {
> -  rm -f ${perfdata}
> -  rm -f ${perfdata}.old
> -  trap - exit term int
> +  rm -f "${perfdata}"
> +  rm -f "${perfdata}".old
> +  trap - EXIT TERM INT
>  }
>
>  trap_cleanup() {
>    cleanup
>    exit 1
>  }
> -trap trap_cleanup exit term int
> +trap trap_cleanup EXIT TERM INT
>
>  test_per_thread() {
>    echo "Basic --per-thread mode test"
> @@ -30,13 +30,13 @@ test_per_thread() {
>      fi
>      return
>    fi
> -  if ! perf record --per-thread -o ${perfdata} true 2> /dev/null
> +  if ! perf record --per-thread -o "${perfdata}" true 2> /dev/null
>    then
>      echo "Per-thread record [Failed record]"
>      err=1
>      return
>    fi
> -  if ! perf report -i ${perfdata} -q | egrep -q true
> +  if ! perf report -i "${perfdata}" -q | grep -q true
>    then
>      echo "Per-thread record [Failed missing output]"
>      err=1
> @@ -47,7 +47,7 @@ test_per_thread() {
>
>  test_register_capture() {
>    echo "Register capture test"
> -  if ! perf list | egrep -q 'br_inst_retired.near_call'
> +  if ! perf list | grep -q 'br_inst_retired.near_call'
>    then
>      echo "Register capture test [Skipped missing event]"
>      if [ $err -ne 1 ]
> @@ -56,7 +56,7 @@ test_register_capture() {
>      fi
>      return
>    fi
> -  if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
> +  if ! perf record --intr-regs=\? 2>&1 | grep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
>    then
>      echo "Register capture test [Skipped missing registers]"
>      return
> @@ -64,7 +64,7 @@ test_register_capture() {
>    if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
>      -c 1000 --per-thread true 2> /dev/null \
>      | perf script -F ip,sym,iregs -i - 2> /dev/null \
> -    | egrep -q "DI:"
> +    | grep -q "DI:"
>    then
>      echo "Register capture test [Failed missing output]"
>      err=1
> --
> 2.38.0.135.g90850a2211-goog
>
