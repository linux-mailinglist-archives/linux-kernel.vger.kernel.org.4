Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15989704B11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjEPKvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjEPKvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:51:03 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3641FE6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:51:01 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QLCfq0mVWzLmKC;
        Tue, 16 May 2023 18:49:39 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 18:50:58 +0800
Subject: Re: [PATCH v10 3/5] hisi_acc_vfio_pci: register debugfs for hisilicon
 migration driver
From:   liulongfang <liulongfang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <alex.williamson@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230408074224.62608-1-liulongfang@huawei.com>
 <20230408074224.62608-4-liulongfang@huawei.com> <ZDlGC8SUXqKNmfSe@nvidia.com>
 <ca592d60-9a5b-dec3-9565-76cd5c0740e0@huawei.com>
 <81e11acf-0ede-d515-bb5a-3964c302f384@huawei.com>
 <ZEKeUBiLyWWW7E+V@nvidia.com>
 <fa3d47a1-0af5-f8ba-d14c-8d9a756e2c23@huawei.com>
Message-ID: <16eee6cd-64c5-bfac-5217-d6f167a2a5c5@huawei.com>
Date:   Tue, 16 May 2023 18:50:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fa3d47a1-0af5-f8ba-d14c-8d9a756e2c23@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/16 17:40, liulongfang wrote:
> On 2023/4/21 22:31, Jason Gunthorpe wrote:
>> On Fri, Apr 21, 2023 at 11:32:47AM +0800, liulongfang wrote:
>>
>>> Thank you for your suggestion, but the current debugfs method can already
>>> meet the functional requirements of verification testing and
>>> problem location.
>>
>> To be clear, I'm against adding selftest code in this manner. We have
>> many frameworks for kernel teesting, please pick one and integrate
>> with it.
>>
> 
> Hi, Jason:
> The purpose of this hisi_acc_vf_debug_restore function is to obtain the
> migration status data of the migration device. It is a debug operation.
> Just to obtain this status data, user need to complete the few steps> of live migration.
> Therefore, it is a debug function here, not a self-test function.
>
Here it should be:
In order to test whether the current state of the device is normal,
perform a recovery test through the data saved during the previous live migration.
It is matched with the previous save.
If you still insist that it is a self-test.
How about I delete this recovery debugfs?

Thanks,
Longfang.
> Thanks,
> Longfang.
>> Jason
>> .
>>
