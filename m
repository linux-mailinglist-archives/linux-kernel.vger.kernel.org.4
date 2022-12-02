Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D73D640E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiLBTdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiLBTdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:33:47 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351DBC3587
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:33:46 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id bx10so9384710wrb.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 11:33:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36dyP/Hp7gDWJu2fbsWS7nRy4NhDoJI+Udz0IKr/yuA=;
        b=ufuJidr6hc3SoGpxND0qTY2LTDpB39zsfIv1NUARoTApLYWA/lUjSFG/o8WlgXKJPk
         hkZ0TPd6b8kr2vzv8AuGjRjqZNFHxX3ICoP2xY2r1ZZL0wVweWswhCqOE80MFnRuCJUi
         IcHpTzPPO69lmQ9wVWsWgwcJ1cN5/AAd4EGXAjASsEafSOhfsqWcE4U00BBhGFN/CBEU
         gq6RytbhksU7SVtKFyp7wPZKqUij19GsmLknTPM0sZeFwgEG1YJJjECRr8p+IwqEQVMW
         2+ecPl9T+6v5/ySzUwklX0D8bU5jZV6k5x+esKWwh/omqnFSNIq69qDPaADShklmPyQt
         4dkg==
X-Gm-Message-State: ANoB5pnQ2tBSWTwsLXmKm9Oe/v9DCURcpA+ZE+CHoNhhaHL0qj/S8Gag
        EiVJ+KQcRAGeNLb3SceIX++TIdNsx3HBZd6wXV7cFeuYW1Q=
X-Google-Smtp-Source: AA0mqf5HTS7NZPS6y2uBqJWsbSDBay2NAjeVGMF1Y8GRpDPiwXNxvsmOjDOugsnS9Obs3Z6mAy5nNFNqcyF/xNeSmS4=
X-Received: by 2002:a5d:4b45:0:b0:242:1ade:1145 with SMTP id
 w5-20020a5d4b45000000b002421ade1145mr15361558wrs.483.1670009624571; Fri, 02
 Dec 2022 11:33:44 -0800 (PST)
MIME-Version: 1.0
References: <Y4pN9MbSuANbn68W@kernel.org>
In-Reply-To: <Y4pN9MbSuANbn68W@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 2 Dec 2022 11:33:32 -0800
Message-ID: <CAM9d7ch7EkOhQGSXZDzbhdGTP_4L243Kyt3FrT6Nv3Rgx-xKtg@mail.gmail.com>
Subject: Re: tmp.perf/core segfaulting on metrics test
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Fri, Dec 2, 2022 at 11:11 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> While trying to get back at processing patches for Linux 6.2, what I
> have at tmp.perf/core branch is failing like below, can someone try to
> help in diagnosing this?

I think you missed this

  https://lore.kernel.org/r/20221130111521.334152-2-james.clark@arm.com

>
> People really should try to run 'perf test' before pushing things
> upstream, but maybe this is related to a recent merge with
> torvalds/master, I'll check, but as a heads up and if someone wants to
> help...

Right, but the metric test is special since it contains hardware-
specific metrics.  But I'll double check with perf test before sending
patches.

Thanks,
Namhyung


>
> [root@quaco ~]# perf test 99
>  99: perf all metricgroups test                                      : FAILED!
> [root@quaco ~]# perf test -v 99
>  99: perf all metricgroups test                                      :
> --- start ---
> test child forked, pid 1494614
> Testing Backend
>
>  Performance counter stats for 'system wide':
>
>          9,978,757      CPU_CLK_UNHALTED.THREAD_ANY      #     56.7 %  tma_core_bound
> /home/acme/libexec/perf-core/tests/shell/stat_all_metricgroups.sh: line 7: 1494617 Segmentation fault      (core dumped) perf stat -M "$m" -a true
> test child finished with -1
> ---- end ----
> perf all metricgroups test: FAILED!
> [root@quaco ~]#
>
>
> --
>
> - Arnaldo
