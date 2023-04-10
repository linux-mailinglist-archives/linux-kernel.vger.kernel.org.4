Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EBA6DC391
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 08:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDJGe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 02:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjDJGey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 02:34:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4F040FF;
        Sun,  9 Apr 2023 23:34:52 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PvzdL5GXrznbZT;
        Mon, 10 Apr 2023 14:31:18 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Apr
 2023 14:34:49 +0800
Date:   Mon, 10 Apr 2023 14:34:34 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Changbin Du <changbin.du@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>
Subject: Re: [PATCH v2 2/2] perf: script: add new output field 'dsoff' to
 print dso offset
Message-ID: <20230410063434.t5m6gttzukbymvb7@M910t>
References: <20230407055212.2701635-1-changbin.du@huawei.com>
 <20230407055212.2701635-3-changbin.du@huawei.com>
 <CAM9d7cgQF5n1umb6P3-KtYcmzF+gg0SR2JFjGXK3nR=Qr_bJbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgQF5n1umb6P3-KtYcmzF+gg0SR2JFjGXK3nR=Qr_bJbQ@mail.gmail.com>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 02:24:48PM -0700, Namhyung Kim wrote:
> Hello Changbin,
> 
> On Thu, Apr 6, 2023 at 10:53 PM Changbin Du <changbin.du@huawei.com> wrote:
[snip]
> > @@ -574,6 +576,9 @@ static void set_print_ip_opts(struct perf_event_attr *attr)
> >         if (PRINT_FIELD(DSO))
> >                 output[type].print_ip_opts |= EVSEL__PRINT_DSO;
> >
> > +       if (PRINT_FIELD(DSOFF))
> > +               output[type].print_ip_opts |= EVSEL__PRINT_DSOFF;
> 
> What if the user gives 'dsoff' without 'dso'.  Better to set the
> EVSEL__PRINT_DSO as well?
>
It will be dropped currently. I will make 'dsoff' implicitly add 'dso' field
later.

> Thanks,
> Namhyung
> 
 

-- 
Cheers,
Changbin Du
