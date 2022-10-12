Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC39E5FBECE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 03:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJLBI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 21:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLBIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 21:08:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01296796BA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 18:08:21 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MnDtT56YHzlXZ1;
        Wed, 12 Oct 2022 09:03:45 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 09:08:20 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 12 Oct
 2022 09:08:18 +0800
Subject: Re: [PATCH 00/20] rcu/context-tracking: Merge RCU eqs-dynticks
 counter to context tracking v5
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Phil Auld" <pauld@redhat.com>, Alex Belits <abelits@marvell.com>,
        "Nicolas Saenz Julienne" <nsaenz@kernel.org>,
        Marco Elver <elver@google.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Nicolas Saenz Julienne" <nsaenzju@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Yu Liao" <liaoyu15@huawei.com>, Boqun Feng <boqun.feng@gmail.com>,
        "Marcelo Tosatti" <mtosatti@redhat.com>,
        kernel test robot <lkp@intel.com>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
References: <20220628131619.2109651-1-frederic@kernel.org>
 <43a38198-d80f-2135-646c-db7e7990a401@huawei.com>
 <20221011191203.GA1051279@lothringen>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <38a2a38e-c04e-7820-b923-69211898ba56@huawei.com>
Date:   Wed, 12 Oct 2022 09:08:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20221011191203.GA1051279@lothringen>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frederic

On 2022/10/12 3:12, Frederic Weisbecker wrote:
> On Tue, Oct 11, 2022 at 07:37:48PM +0800, Xiongfeng Wang wrote:
>> Hi, Frederic
>>
>> Thanks for push RCU dynticks counters to upstream. It is very useful. After it
>> is done, do we have plan to revive the sys-idle feature and use it to shutdown
>> the tick on the last housekeeping when the whole system is idle. I'm very glad
>> to help test it if you have some demo patches on your personal repo.
> 
> There is no plan yet but some other people seem to be interested. Would you
> like to try to revive it yourself? Otherwise I may do it someday but I 

Thanks for your reply ! I would like to give it a try. But I'm not sure if I can
make it because I'm not so familiar with the RCU subsystem.

Thanks,
Xiongfeng

> have quite some work to complete first (ie: making CPU isolation tunable through
> cpusets).
> 
> Thanks.
> .
> 
