Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D06736159
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjFTCB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjFTCB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:01:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F287118;
        Mon, 19 Jun 2023 19:01:54 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QlVHb1Zffz1HBdR;
        Tue, 20 Jun 2023 10:01:47 +0800 (CST)
Received: from localhost.huawei.com (10.137.16.203) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 20 Jun 2023 10:01:51 +0800
From:   renmingshuai <renmingshuai@huawei.com>
To:     <shaozhengchao@huawei.com>
CC:     <caowangbao@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <jhs@mojatatu.com>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <liaichun@huawei.com>,
        <linux-kernel@vger.kernel.org>, <liubo335@huawei.com>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <pctammela@mojatatu.com>, <renmingshuai@huawei.com>,
        <vladbu@nvidia.com>, <xiyou.wangcong@gmail.com>, <yanan@huawei.com>
Subject: Re: [PATCH] selftests: tc-testing: add one test for flushing explicitly created chain
Date:   Tue, 20 Jun 2023 10:01:13 +0800
Message-ID: <20230620020113.2040080-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <961f4d1a-6756-0a09-f578-5bf5791a1a64@huawei.com>
References: <961f4d1a-6756-0a09-f578-5bf5791a1a64@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.137.16.203]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi renmingshuai:
>On 2023/6/17 11:20, renmingshuai wrote:
>> Add the test for additional reference to chains that are explicitly created
>>   by RTM_NEWCHAIN message
>> 
>> commit c9a82bec02c3 ("net/sched: cls_api: Fix lockup on flushing explicitly
>>   created chain")
>> Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
>> ---
>>   .../tc-testing/tc-tests/infra/filter.json     | 25 +++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>   create mode 100644 tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
>> 
>> diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json b/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
>> new file mode 100644
>> index 000000000000..c4c778e83da2
>> --- /dev/null
>> +++ b/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
>> @@ -0,0 +1,25 @@
>> +[
>> +    {
>> +        "id": "c2b4",
>> +        "name": "soft lockup alarm will be not generated after delete the prio 0 filter of the chain",
>	 "Delete the prio 0 filter of chain" looks better. And adding
>  test result in comment also will be better.
>
>Zhengchao Shao
Thanks for your advice, and I have add the test result in comment.
https://lore.kernel.org/netdev/20230620014939.2034054-1-renmingshuai@huawei.com/T/#u
The original name can describe the purpose of adding the test case, which would be better.
