Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D55F6E0A48
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDMJak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDMJae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:30:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0336C4C3C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:30:29 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PxvPf6b7LzKyD5;
        Thu, 13 Apr 2023 17:27:50 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 17:30:26 +0800
Message-ID: <5d8ea8a7-c35d-85ae-273a-2807af9517b6@huawei.com>
Date:   Thu, 13 Apr 2023 17:30:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] mm: ksm: Support hwpoison for ksm page
Content-Language: en-US
To:     Longlong Xia <xialonglong1@huawei.com>,
        <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linmiaohe@huawei.com>, <sunnanyong@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230330074501.205092-1-xialonglong1@huawei.com>
 <20230330074501.205092-3-xialonglong1@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230330074501.205092-3-xialonglong1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/30 15:45, Longlong Xia wrote:
> hwpoison_user_mappings() is updated to support ksm pages, and add
> collect_procs_ksm() to collect processes when the error hit an ksm
> page. The difference from collect_procs_anon() is that it also needs
> to traverse the rmap-item list on the stable node of the ksm page.
> At the same time, add_to_kill_ksm() is added to handle ksm pages. And
> task_in_to_kill_list() is added to avoid duplicate addition of tsk to
> the to_kill list. This is because when scanning the list, if the pages
> that make up the ksm page all come from the same process, they may be
> added repeatedly.
> 
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
