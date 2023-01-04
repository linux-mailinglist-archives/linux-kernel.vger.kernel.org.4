Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CB565CC1D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 04:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjADDUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 22:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjADDUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 22:20:14 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF0B10FDC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 19:20:13 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NmvvN4CXlzRqk7;
        Wed,  4 Jan 2023 11:18:40 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 11:20:11 +0800
Subject: Re: [PATCH v5 3/5] hisi_acc_vfio_pci: register debugfs for hisilicon
 migration driver
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <alex.williamson@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20221217063248.6735-1-liulongfang@huawei.com>
 <20221217063248.6735-4-liulongfang@huawei.com> <Y7REyEY2ngkHT6z+@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <ae912559-43a9-73f2-711a-db832b042656@huawei.com>
Date:   Wed, 4 Jan 2023 11:20:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y7REyEY2ngkHT6z+@nvidia.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/3 23:07, Jason Gunthorpe Wrote:
> On Sat, Dec 17, 2022 at 02:32:46PM +0800, Longfang Liu wrote:
>> On the debugfs framework of VFIO, register the debug function
>> for the live migration driver of the hisilicon accelerator device.
>>
>> On the basis of the original public debug function, a private debug
>> function is added:
>>
>> mig_data file: used to get the migration data of the live migration device
>> mig_attr file: used to get device attributes of the live migration device
>> debug file: used to test for acquiring and writing device state data
>> for VF device.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 276 ++++++++++++++++++
>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  11 +
>>  2 files changed, 287 insertions(+)
> 
> You should put this all in its own file and not compile it when
> debugfs is turned off as well.
> 

Here use this macro #ifdef CONFIG_DEBUG_FS to wrap the creation part of debugfs.
Do you think it can be handled like this?

> Jason
> .
> 
Thanks,
Longfang.
