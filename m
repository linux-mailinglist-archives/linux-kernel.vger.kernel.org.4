Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7526742060
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 08:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjF2G04 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 02:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjF2G01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 02:26:27 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5FA30C5;
        Wed, 28 Jun 2023 23:26:20 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-c14476f8401so323926276.3;
        Wed, 28 Jun 2023 23:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688019979; x=1690611979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfLTbjgoIsSKWwNycBDFQAmVln5oxCfW2uQIjevEO0Q=;
        b=XsKrwfcPgYsJ3ILFRX7CJ8rq9Dx+sDCYsgRhJ7y7PtbacvLzQL6D4mBPp5mx4Ib0e/
         FtiI8paUgY/iAzm00i1XJDQBJNg0dvmPZ3GzjyNWyJavSFkqBu+yRGpxutijgc2++hvB
         sUrww9rzu51b8BGsdBdrDI5BS4MvTy+fcD/HU8xlIgOnexgURuUay9aQ28j+i3CiSMRr
         0upkak4DqwbdZgvkyGPJ+84kBM5RTW+XA8RiXov2oRLN9P/qPSnl0e18/i+q2r9rNE6V
         iqh4+lIpuVnpsUCFj5eg+mytkQI8t1j3FcfCmUFWoildSQO2xj8Uwwzptn/dfYpV9yLA
         yXsQ==
X-Gm-Message-State: AC+VfDxZmWZFCppYJLUZPyl5Suog6dxoOGsji8W0BMq6sEYd8Pd+NMww
        dH4ejwQUpSoMl6Fx0TgsttlZOopDswIxxnU4Qyc=
X-Google-Smtp-Source: ACHHUZ686BJK5GLXUVLpMrxPzUvmVNafwU2xx1cinYaV1jwVxxqvItD9C/+eScUzT8eZ2aDpXxFGKxy5rBZQOyUt7aQ=
X-Received: by 2002:a25:37d7:0:b0:c0b:7483:5cf0 with SMTP id
 e206-20020a2537d7000000b00c0b74835cf0mr16305934yba.65.1688019979572; Wed, 28
 Jun 2023 23:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <ZG5kjDN63HqqMuJJ@yoga> <CAM9d7ciUsJM1kZhGbhQUfdxq1rsvLig2C-mAki13a92EjW37kw@mail.gmail.com>
 <CAP-5=fVekEnC1s=xUG-jFeL20qM=EPNkPO8aw8bcg4cVM=m5wg@mail.gmail.com>
 <ZHENW4HOIo0F6FnN@yoga> <ZHkEWse0NVZhwKR7@yoga> <ZH5YBBWW5ANckoMp@yoga>
 <CAP-5=fU7ukrQSh_8OwH9C+a-EwCamCrMaZxjqDhE9f+bFJwQBQ@mail.gmail.com>
 <ZIHPXV5/ZopqcSSc@yoga> <ZIofrGKElc3nkNk0@yoga> <CAP-5=fV9tXNpYHH9DW0cVbRoFLGvG9SNn-MUhuyKuVBRuDqjoA@mail.gmail.com>
 <ZJyT8bt0LFLw6hKV@yoga>
In-Reply-To: <ZJyT8bt0LFLw6hKV@yoga>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 28 Jun 2023 23:26:08 -0700
Message-ID: <CAM9d7ch7TdagV+dzj6MCp4fY15Vc4oGJjKAoQDyc=BXqy7qi+A@mail.gmail.com>
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
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

Hi Anup,

On Wed, Jun 28, 2023 at 1:11 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
>
> On Wed, Jun 14, 2023 at 01:17:52PM -0700, Ian Rogers wrote:
> > On Wed, Jun 14, 2023 at 1:14 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> > >
> > > On Thu, Jun 08, 2023 at 06:23:49PM +0530, Anup Sharma wrote:
> > > I wanted to take a moment to provide you with an update on the progress
> > > of our Firefox Gecko converter work. While I must emphasize that the code
> > > I'm sharing is not the final version, I wanted to share the advancements
> > > I have made thus far.
> > >
> > > This script can generate a JSON format from the output of the "perf script" command.
> > > I attempted to load this JSON file into profile.firefox.com, and although it
> > > successfully loaded, the call tree are not visible. I'm certain this issue
> > > is related to the format of the JSON file or if there is another underlying
> > > cause. I will continue investigating to determine the cause of this problem.
> >
> > Great Anup, progress can be frustrating slow at first but it is a good
> > milestone to be generating output and having firefox profiler consume
> > it. You can open up the JavaScript console for the firefox profiler
> > and it will give some debug output. This should hopefully help you
> > make progress.
>
> This week I tried playing with perf-script-python, the first challenge was
> figuring out how to parse the data coming from the process_events.
> Understanding the structure and extracting the necessary information
> proved to be more complex than anticipated. This required me to spend
> a significant amount of time researching and experimenting with different
> parsing techniques.

I'm not sure what kind of parsing you meant.  IIRC the sample data is
in a dict and all the information should be available there.  Maybe we
missed some new sample data types though.

>
> The second challenge revolved around the usage of event hooks provided with the perf script
> python event handlers. I found myself deliberating between two approaches. The first
> approach involved creating custom functions that would be called using the event
> handlers. These functions would then save the data in an organized format within
> globally created data structures. The alternative approach was to write the entire
> logic inside the event handlers themselves.
>
> Additionally, I contemplated whether it would be more suitable to handle the creation of
> a Gecko format for JSON and the profile format within the same script or to separate
> them into different scripts.
>
> I will discuss this points during tomorrow's office hour.
>
> However, I have gained a deeper understanding of the problem at hand and will use this
> knowledge to make more informed decisions and progress more effectively in the coming weeks.

Sounds like you did a good amount of research on how perf script
works.  We can talk about the details in the meeting.

Thanks,
Namhyung
