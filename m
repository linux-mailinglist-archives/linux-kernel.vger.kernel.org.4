Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCC773C6C8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 06:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjFXEfT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 24 Jun 2023 00:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFXEfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 00:35:15 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5947136;
        Fri, 23 Jun 2023 21:35:14 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-bff89873d34so1030687276.2;
        Fri, 23 Jun 2023 21:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687581314; x=1690173314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWcltbx43ICJ2omQWXgRLpaOtwzfz2d8GhcvQRYoRw4=;
        b=ZLm3kFuvos5KFLwy0y83LjOP+55KK+RhvsgeWOYCn/QnDkYy1dOLWQ9XEmGjQ4pmsN
         5epwV+WwDVjA3bXL3GOsW325LDpYYzDs0MetKdZkhZFWard2jWqAREC9j+zO2S5vl/YJ
         o0NxJtp2yBAqsC2jUE+c+Brt5jcxOsuG5rZONFG4knKU8wy77Z9mVoKGnvQ1YlXiVvYt
         rFdTA/jSR2HnHubRhetO4+b4RIWNzukF6sPGnln+r/zoBQoGgoNBOpzid2IRDHDULUaO
         3TJ0pXaqVYGTsaOjOlWr6WZzO+l3nxooCDfG9rOMDK7rKSj0gr07sfdmEWVOBHhAYiux
         6IOA==
X-Gm-Message-State: AC+VfDx3wap5sHET/vMvCEPe5DRbM69EmLk6yJrx5Fnddbv5pJwd77gz
        U6pA4FOlouNfpOgx221BusLF5DZUhGDEzREqcQQ=
X-Google-Smtp-Source: ACHHUZ6aH2HiFvjmsQFESquZw2UsfjeA55T4h3ZnLxQNGGjoqwnVBOQjqtjxRLsSzXFiYBwkvd4755iGIU0zeNYEbvk=
X-Received: by 2002:a25:e70b:0:b0:bc7:f963:eb48 with SMTP id
 e11-20020a25e70b000000b00bc7f963eb48mr17036891ybh.32.1687581314012; Fri, 23
 Jun 2023 21:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cjtisDVPijfU=iEGxc0YF=RnAt+r18Jg+8Av-+RAO=jeg@mail.gmail.com>
 <IA1PR20MB49536C0DA47122E9E3CB7CBBBB20A@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB49536C0DA47122E9E3CB7CBBBB20A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 21:35:01 -0700
Message-ID: <CAM9d7cis-rb0fozK+T6R8MCEcT0ZF=RRNpv1qAWsLkMfsG6KxA@mail.gmail.com>
Subject: Re: [PATCH V3] perf vendor events riscv: add T-HEAD C9xx JSON file
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 23, 2023 at 6:33 PM Inochi Amaoto <inochiama@outlook.com> wrote:
>
> Hi, Namhyung
>
> Since there is a fault in T-HEAD documentation, I am not sure whether
> the perf events are correct. As a result, I suggest temporarily suppressing
> this patch until I extract the correct events from its vendor perf driver.
> I will prepare a new V4 patch once it is finished.

Sure, thanks for letting me know.

>
> As for c9xx wildcard, the T-HEAD provides a `MCPUID` vendor CSR to allow
> its CKLINK to get the detail CPU info. The format of this CSR are:
>
> ------------------------------------------------
> |31   28|27  26|25    22|21   18|17    8|7    0|
> | index | WLRL | family | class | model | WLRL |
> ------------------------------------------------
>
> And for C9xx series (only index 0000 is vaild for us, as `MCPUID` also
> provides other index).
>
> | 0000 | xx | 0100 | class | xxxxxxxxxx | xxxxxxxx |
>
> The class codes are:
>
> C910: 0011
> c906: 0100
>
> The CSR is a M-mode only CSR, so now I'm exploring a clean way to
> integrate this CSR into the kernel. Any advice?

I don't know about the details.  Is this CSR available from user space?
If not, you could add it somewhere in the sysfs.

Thanks,
Namhyung


> > Hello,
> >
> > On Thu, May 18, 2023 at 2:50 AM Inochi Amaoto <inochiama@outlook.com> wrote:
> > >
> > >> licheerv # perf record
> > >> [  432.015618] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
> > >> [perf:117]
> > >> [  460.015617] watchdog: BUG: soft lockup - CPU#0 stuck for 52s!
> > >> [perf:117]
> > >> [  488.015616] watchdog: BUG: soft lockup - CPU#0 stuck for 78s!
> > >> [perf:117]
> > >> [  516.015617] watchdog: BUG: soft lockup - CPU#0 stuck for 104s!
> > >> [perf:117]
> > >>
> > >> But that's not related to your patch anyway.
> > >
> > > Same issue on c920, but it did not always occur.
> > > Like a sbi issue for T-HEAD cpus.
> > >
> > >> I am strongly against using "c9xx" wildcard, i would prefer declaring
> > >> them separate (especially taking in mind that c920 is c910 with vector
> > >> - AFAIK), but that's up to Arnaldo to decide.
> > >
> > > AFAIK, there is no reliable way to distinguish c906 and c910 cores. And
> > > the events of c910 and c920 are the same (according to the draft document
> > > of the c920).
> > >
> > > Anyway, I agree to let Arnaldo decide.
> > >
> > >> Tested-by: Nikita Shubin <n.shubin@yadro.com>
> >
> > I'm collecting patches on behalf of Arnaldo this time.
> > It seems this patch was not picked up for a long time.
> >
> > I think we can make changes for the c9xx wildcard later
> > if needed.  I'll process it in the current form.
> >
> > Thanks,
> > Namhyung
> >
