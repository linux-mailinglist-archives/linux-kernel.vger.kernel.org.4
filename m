Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683F36AA919
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 11:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjCDKSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 05:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjCDKSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 05:18:22 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7CAE3B2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 02:18:21 -0800 (PST)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PTLQH4gg6z1dy2C;
        Sat,  4 Mar 2023 18:18:15 +0800 (CST)
Received: from [10.67.109.57] (10.67.109.57) by kwepemm600012.china.huawei.com
 (7.193.23.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Sat, 4 Mar
 2023 18:18:18 +0800
Subject: Re: [PATCH v3] sched: pick_next_rt_entity(): check list_entry
References: <8f5c938f-5c31-655b-fd8d-415fa192d705@huawei.com>
 <d3af2533-2990-e884-eb9a-20cbbfedde23@huawei.com>
To:     <borrello@diag.uniroma1.it>
Reply-To: <20230128-list-entry-null-check-sched-v3-1-b1a71bd1ac6b@diag.uniroma1.it>
CC:     <bristot@redhat.com>, <c.giuffrida@vu.nl>,
        <dietmar.eggemann@arm.com>, <dmitry.adamushko@gmail.com>,
        <h.j.bos@vu.nl>, <jkl820.git@gmail.com>, <juri.lelli@redhat.com>,
        <mgorman@suse.de>, <mingo@elte.hu>, <mingo@redhat.com>,
        <pauld@redhat.com>, <peterz@infradead.org>, <rostedt@goodmis.org>,
        <vincent.guittot@linaro.org>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
From:   "guanjing (D)" <guanjing6@huawei.com>
Message-ID: <f55d7d68-737b-48fb-1857-95e1504d9fe0@huawei.com>
Date:   Sat, 4 Mar 2023 18:18:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <d3af2533-2990-e884-eb9a-20cbbfedde23@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.57]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, borrello:

I wonder why you send this patch? Did you meet such a problem in a 
real-world scenario, or it is a static warning style?

Thanks,
Guanjin.

