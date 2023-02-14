Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A84B696E69
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBNUVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBNUVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:21:41 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B4D1F4BD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:21:40 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-501c3a414acso222585587b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sA6RgxJd/Nei3HJdXl3D2Wds6bjv1goSzoxUHfeRXTE=;
        b=GtbYmWfqy9KMTcCnYYdDJQqxtFwe2PUtQVNBqGQyn6w3bWZGyobmWFF8std/Gqe3tb
         CE+SxEmgh/j+rQ8pATqp95FW5yWcIBz6iSL3Zf6h5NEd0euJn1gEdIZMHgKb7KJ501bE
         Zh1XhZuls5AtSDmoXivMpPIhFYMhYSyIffTGZHzkQqirswvtd1KiWam792ObkwQlZhCw
         B8m26U+VPlKjxLpfECeQ2sSdLdQaKli19NrW70nvRxlNLaukGFfqGiT5cA8kdtHvLnmj
         JeNJUXdLMZsdVZ+XuATnnGUuMr9cmjCUnMrEeCl1KpuiXiuCQKyuS8mkqsVY6+KdchYc
         UmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sA6RgxJd/Nei3HJdXl3D2Wds6bjv1goSzoxUHfeRXTE=;
        b=b24VuN8L5bhjddFPkxt0kcsObqW1Yr9ySPgTPm1JT62Fiz5auxEcQQiqQHkE0mqSEn
         gFZq24rwhMhR05VKRhsTHcacepp//I7r/qR5ykAqtg0lrLFeYTksFvpA08vaOwQF2pz1
         Ur3NmyRR1r/JCJLxrKCOrBshtPZz0+r9ZR99lbU5NEI3e2w3yQOaNyMRym0QUBOgyGp0
         e67JAZCiZqWFW7e4TXyZ2WZc4KcPnnuFvyq7Mcf8q38wTGbXhUwUznxyqpyyaXV6G9kx
         CqxxrDmfs6yokl1bRWd2NIlwMM91TL/WIzCCGTIeqDk6ionofnB0ktoDYup+lEv0JnX7
         Y9gA==
X-Gm-Message-State: AO0yUKUJNx/RMT4pcXtr8dYj3TVwpavAGY5oVUHPbISy5HqZcPEnkLcr
        Zb0bBXSOWo2alXKBPL+RJF0djDnSdonYmQBKRgQ6
X-Google-Smtp-Source: AK7set/mOhmRsOdf6tSIhWL3ObeS7JKaSKsUA8RMHz3Y01gb47Vp4cffohI2T6NkfEBTFPNDOQG0ljFgkPdGrLPSFUY=
X-Received: by 2002:a81:830c:0:b0:52e:d52e:97d0 with SMTP id
 t12-20020a81830c000000b0052ed52e97d0mr435163ywf.117.1676406099262; Tue, 14
 Feb 2023 12:21:39 -0800 (PST)
MIME-Version: 1.0
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com> <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com> <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <Y+tl1ZJiWuMeKCnB@hirez.programming.kicks-ass.net> <8dc13cf0-42f4-9ef1-1e22-de58ff743a0d@linux.intel.com>
 <CANDhNCrLTBB6UaSxUhivGKv+ugnMYtCqDSDiz7o-DnE2MkC8jA@mail.gmail.com> <5dc37d95-493b-cb2a-1cc7-4ea80dc22740@linux.intel.com>
In-Reply-To: <5dc37d95-493b-cb2a-1cc7-4ea80dc22740@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 14 Feb 2023 12:21:28 -0800
Message-ID: <CANDhNCoj6SseKe=7La9YqRzvBdhO5zetfDKzOqpue4J0MtyVaA@mail.gmail.com>
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Feb 14, 2023 at 12:09 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> On 2023-02-14 2:37 p.m., John Stultz wrote:
> > On Tue, Feb 14, 2023 at 9:46 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >> If I understand correctly, the TSC calibration is done in the kernel.
> >> The kernel keeps updating the mul/shift. We dump the mul/shift into the
> >> perf mmap page for the user tools.
> >
> > Where is that done in the perf mmap? I wasn't aware.
>
> The updating of the mul/shift for sched_clock should be done in the
> set_cyc2ns_scale() in tsc.c

Thanks for the pointer!

> The perf user space tool mmap a page to retrieve the enabling
> time/running time from the kernel. On X86 and Arm, the conversion
> information from HW time (TSC) to sched_clock/perf_time is also stored
> in the page. Please see the arch_perf_update_userpage(). In the perf
> mmap, it only retrieve the current mul/shift information and write them
> into the page for the user space tool.
>
> This V2 patch series try to do the same thing for the monotonic raw
> conversion. So the kernel internal mul/shift information has to be exposed.

Ugh. Well, I think perf may have made a bad API choice here, so I'm
still going to push back on exposting timekeeping internals to
userland.

But I do suspect that with ways to provide paired TSC/CLOCK_MONOTONIC
values, you should be able to get the same functionality in userland
as if the underlying data was shared.

thanks
-john
