Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1D26EBF9B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDWMye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDWMyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:54:33 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A36E10D0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 05:54:31 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q47VN5l6BzKsxn;
        Sun, 23 Apr 2023 20:53:32 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 20:54:27 +0800
Message-ID: <c6185f05-bbc6-355f-6061-73e81a8a0070@huawei.com>
Date:   Sun, 23 Apr 2023 20:54:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/5] ubi: Enhanced fault injection capability for the UBI
 driver
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        yi zhang <yi.zhang@huawei.com>
References: <20230318015621.1408243-1-wangzhaolong1@huawei.com>
 <1751647898.236371.1682111895850.JavaMail.zimbra@nod.at>
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
In-Reply-To: <1751647898.236371.1682111895850.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.209]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for replying to my email. I agree with you.

I'll tweak my patch in the next few weeks, try to keep the old interface and
be compatible with the new interface.

Best Regards
ZhaoLong Wang

在 2023/4/22 5:18, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "ZhaoLong Wang" <wangzhaolong1@huawei.com>
>> The existing fault injection capability of UBI is too simple.
>> It uses hard-coded fault probability values and lacks other
>> configurable options. As a result, these interfaces are difficult
>> to use when digging defects in the abnormal path of code and
>> reproducing some problems.
>>
>> The kernel provides a powerful fault injection framework, which
>> provides rich configurable fault injection attributes during runtime.
>> So it can be used to improve the fault injection capability of the
>> UBI driver.
>>
>> This series of patches refactor the existing fault injection interface
>> and add some fault injection types to help testers and developers
>> find potential problems in the code.
> In general I like having some new and advanced way to test UBI.
> But your patches seem to remove the old interface from debugfs,
> this will cause breakage of existing test scripts.
>
> So please keep the old interface too.
>
> Thanks,
> //richard
>
