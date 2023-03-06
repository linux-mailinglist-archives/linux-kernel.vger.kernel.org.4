Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED886ACE26
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCFTcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCFTcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:32:51 -0500
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090E174A4F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:32:46 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-536bf92b55cso202589287b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678131165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noP6UwKhLWLHomQKBF+UKfRQwkT1yJ6YdM49kAOoKvU=;
        b=flmbnz8uT+c3QoP8KF3S6d/CCyhUDJp4UefjHTBtxAe6zB6tO2hRQz+AwAIwqhPauj
         l0mj0oeL/9M6RjvO9Bfw8TFq53F3wl/87fq56y11q3T9cpAe5x9gabPWJWGmZjiKbf1f
         prajuvay1t3HZm49PYesO9aSXlRSnhMfvoBgCUvxFI0hkQqGs5iAMgWDel4MaQSMiusm
         PUVJogOStACIfEazFR5bmHHtu9zL40bjsYFmFQpIB0K4Mg11itoEwlC5lEsgRQINik6e
         jNZp39YDdYCZDJvO4r0NoC8fD8Pb3TCLO71AiGS5YenrVc7Y3D/1xPGK7+GGkQf23pXQ
         LzdQ==
X-Gm-Message-State: AO0yUKUT4bRaBPyi+qTrBySQvodHslWa98SqnEwWPIU3vnoThWJSFGa9
        4g7nhSGjNFwgLGTQXIMuMVd9VwM328KDNPC54j4=
X-Google-Smtp-Source: AK7set/lEba+eM3hKTpehKHA+Qnbj6bwLAwjjP+ZjB2fC3abi1U3msvzH3QXvcXTucoBFUL9prHstxfx8ypdjaRKh44=
X-Received: by 2002:a81:b604:0:b0:52f:2695:5d05 with SMTP id
 u4-20020a81b604000000b0052f26955d05mr6160437ywh.3.1678131165155; Mon, 06 Mar
 2023 11:32:45 -0800 (PST)
MIME-Version: 1.0
References: <ZAYosCjlzO9plAYO@kernel.org>
In-Reply-To: <ZAYosCjlzO9plAYO@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 6 Mar 2023 11:32:34 -0800
Message-ID: <CAM9d7cj7HV1GjNXagw5LEYihjAWZ2-skoHXxxSCF-YU4AuBF_g@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tools: Add Adrian Hunter to MAINTAINERS as a reviewer
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 9:53 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
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

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66b5d5a51d5b1110..8e46fa10a631e4d6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16425,6 +16425,7 @@ R:      Alexander Shishkin <alexander.shishkin@linux.intel.com>
>  R:     Jiri Olsa <jolsa@kernel.org>
>  R:     Namhyung Kim <namhyung@kernel.org>
>  R:     Ian Rogers <irogers@google.com>
> +R:     Adrian Hunter <adrian.hunter@intel.com>
>  L:     linux-perf-users@vger.kernel.org
>  L:     linux-kernel@vger.kernel.org
>  S:     Supported
> --
> 2.39.2
>
