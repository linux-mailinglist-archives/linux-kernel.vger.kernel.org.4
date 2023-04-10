Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F416DC2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDJC6R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Apr 2023 22:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDJC6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:58:16 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A698730DD;
        Sun,  9 Apr 2023 19:58:14 -0700 (PDT)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PvtqN3skxz17MGW;
        Mon, 10 Apr 2023 10:54:40 +0800 (CST)
Received: from huawei.com (10.174.179.93) by kwepemi500007.china.huawei.com
 (7.221.188.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Apr
 2023 10:58:10 +0800
From:   Hangliang Lai <laihangliang1@huawei.com>
To:     <namhyung@kernel.org>
CC:     <acme@kernel.org>, <adrian.hunter@intel.com>,
        <alexander.shishkin@linux.intel.com>, <brauner@kernel.org>,
        <hewenliang4@huawei.com>, <irogers@google.com>, <jolsa@kernel.org>,
        <laihangliang1@huawei.com>, <linfeilong@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <liuwenyu7@huawei.com>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <yeyunfeng@huawei.com>
Subject: Re: [PATCH v2] perf top: expand the range of multithreaded phase
Date:   Mon, 10 Apr 2023 10:58:08 +0800
Message-ID: <20230410025808.2008-1-laihangliang1@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <CAM9d7cgK-P5KuDy7hkAR4j7oB4ydE6Mw3KexqgwPPhJF6MKtXQ@mail.gmail.com>
References: <CAM9d7cgK-P5KuDy7hkAR4j7oB4ydE6Mw3KexqgwPPhJF6MKtXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.174.179.93]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500007.china.huawei.com (7.221.188.207)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply Kim ,

On 2023-04-07 21:21   you  wrote:

>  Not always, the synthesis can run in a single thread.

But I think in machine__synthesize_threads, there are thread_nr threads will be created to do synthesize_threads_worker(tools/perf/util/synthetic-events.c:970)

It’s not a single thread part. So we're supposed to call perf_set_multithreaded() before synthesize?

Thanks,
Hangliang Lai

