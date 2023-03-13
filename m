Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF06D6B6D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 02:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCMB7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 21:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCMB7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 21:59:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5945D234D3;
        Sun, 12 Mar 2023 18:59:00 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PZfrh1gk4z17KS6;
        Mon, 13 Mar 2023 09:56:04 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 13 Mar
 2023 09:58:28 +0800
Date:   Mon, 13 Mar 2023 09:58:11 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Changbin Du <changbin.du@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>
Subject: Re: [PATCH v2 0/3] perf : fix counting when initial delay configured
Message-ID: <20230313015811.2nivivoiyh674lzj@M910t>
References: <20230302031146.2801588-1-changbin.du@huawei.com>
 <CAM9d7cigZ=TRoH8-MNbovUETzsjf+OuX7ykXA9rSyhsOY48dRg@mail.gmail.com>
 <ZAEJsMYGo1HC5CRk@kernel.org>
 <20230310023714.gqmenjlunlcm3bju@M910t>
 <ZAtHQuhWz+q//pE2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAtHQuhWz+q//pE2@kernel.org>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 12:05:38PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 10, 2023 at 10:37:14AM +0800, Changbin Du escreveu:
> > On Thu, Mar 02, 2023 at 05:40:16PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Mar 02, 2023 at 11:22:37AM -0800, Namhyung Kim escreveu:
> > > > Hello,
> > > > 
> > > > On Wed, Mar 1, 2023 at 7:12 PM Changbin Du <changbin.du@huawei.com> wrote:
> > > > >
> > > > > The first one fixes the problem that counters are never enabled  when initial
> > > > > delay configured.
> > > > > The remaining two reuse the common field target::initial_delay for
> > > > > record/ftrace/trace subcommands.
> > > > >
> > > > > v2:
> > > > >  - introduce common filed target::initial_delay
> > > > >
> > > > > Changbin Du (3):
> > > > >   perf stat: fix counting when initial delay configured
> > > > >   perf record: reuse target::initial_delay
> > > > >   perf: ftrace: reuse target::initial_delay
> > > > 
> > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > 
> > > Thanks, applying the first to perf-tools (old perf/urgent) and the rest
> > > to perf-tools-next (old perf/core).
> > > 
> > > - Arnaldo
> > > 
> > Hi Arnaldo, it seems only the first one is applied. The remaining two patches
> > are missed in your tree.
> >  - perf record: reuse target::initial_delay
> >  - perf: ftrace: reuse target::initial_delay
> 
> Those are not fixes, right? I mentioned that I would apply it after the
> first is merged.
>
Sorry, I misunderstood your previous reply :)

> - Arnaldo

-- 
Cheers,
Changbin Du
