Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB14374E3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGKCG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGKCG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:06:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B84290;
        Mon, 10 Jul 2023 19:06:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R0PP80QK5z1FDgN;
        Tue, 11 Jul 2023 10:06:20 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 10:06:52 +0800
Subject: Re: linux-next: build warning after merge of the cgroup tree
To:     Tejun Heo <tj@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230711111509.1045f32e@canb.auug.org.au>
 <ZKyuwkDWB85Zs9R0@slm.duckdns.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9031f42f-6ff3-3e60-049b-fc1917915da9@huawei.com>
Date:   Tue, 11 Jul 2023 10:06:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZKyuwkDWB85Zs9R0@slm.duckdns.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/11 9:22, Tejun Heo wrote:
> On Tue, Jul 11, 2023 at 11:15:09AM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the cgroup tree, today's linux-next build (arm
>> multi_v7_defconfig) produced this warning:
>>
>> kernel/cgroup/cgroup.c:503:36: warning: 'cgroup_tryget_css' defined but not used [-Wunused-function]
>>   503 | static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
>>       |                                    ^~~~~~~~~~~~~~~~~
>>
>> Introduced by commit
>>
>>   1299eb2b0ad5 ("cgroup: minor cleanup for cgroup_extra_stat_show()")
> 
> Miaohe, can you send a patch to either add __maybe_unused to
> cgroup_tryget_css() or also put it inside CONFIG_CGROUP_SCHED?

Will do. Sorry for my mistake.

Thanks.

