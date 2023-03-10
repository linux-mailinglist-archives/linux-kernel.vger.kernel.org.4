Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55E86B3451
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCJChk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCJChg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:37:36 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9728FF16B4;
        Thu,  9 Mar 2023 18:37:34 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PXqrd44KJznWkw;
        Fri, 10 Mar 2023 10:34:41 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 10 Mar
 2023 10:37:31 +0800
Date:   Fri, 10 Mar 2023 10:37:14 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Namhyung Kim <namhyung@kernel.org>,
        Changbin Du <changbin.du@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>
Subject: Re: [PATCH v2 0/3] perf : fix counting when initial delay configured
Message-ID: <20230310023714.gqmenjlunlcm3bju@M910t>
References: <20230302031146.2801588-1-changbin.du@huawei.com>
 <CAM9d7cigZ=TRoH8-MNbovUETzsjf+OuX7ykXA9rSyhsOY48dRg@mail.gmail.com>
 <ZAEJsMYGo1HC5CRk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAEJsMYGo1HC5CRk@kernel.org>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 05:40:16PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 02, 2023 at 11:22:37AM -0800, Namhyung Kim escreveu:
> > Hello,
> > 
> > On Wed, Mar 1, 2023 at 7:12 PM Changbin Du <changbin.du@huawei.com> wrote:
> > >
> > > The first one fixes the problem that counters are never enabled  when initial
> > > delay configured.
> > > The remaining two reuse the common field target::initial_delay for
> > > record/ftrace/trace subcommands.
> > >
> > > v2:
> > >  - introduce common filed target::initial_delay
> > >
> > > Changbin Du (3):
> > >   perf stat: fix counting when initial delay configured
> > >   perf record: reuse target::initial_delay
> > >   perf: ftrace: reuse target::initial_delay
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks, applying the first to perf-tools (old perf/urgent) and the rest
> to perf-tools-next (old perf/core).
> 
> - Arnaldo
> 
Hi Arnaldo, it seems only the first one is applied. The remaining two patches
are missed in your tree.
 - perf record: reuse target::initial_delay
 - perf: ftrace: reuse target::initial_delay

-- 
Cheers,
Changbin Du
