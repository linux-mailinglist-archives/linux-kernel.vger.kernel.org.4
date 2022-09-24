Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4125E870A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 03:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiIXBtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 21:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiIXBtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 21:49:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D9F29CAA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 18:49:49 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MZBfQ5b42zHtcg;
        Sat, 24 Sep 2022 09:45:02 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 09:49:46 +0800
Received: from [10.67.102.118] (10.67.102.118) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 09:49:46 +0800
Subject: Re: [PATCH v2 3/5] hisi_acc_vfio_pci: Remove useless function
 parameter
From:   liulongfang <liulongfang@huawei.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
References: <20220922083928.58797-1-liulongfang@huawei.com>
 <20220922083928.58797-4-liulongfang@huawei.com>
 <d98867217f4047709de00d610ad2e8b8@huawei.com>
 <5f6c62a5-9ccf-c130-7285-aa8cedbf65c9@huawei.com>
Message-ID: <2d2bdf4d-344a-0c21-ad5e-cebadac19be8@huawei.com>
Date:   Sat, 24 Sep 2022 09:49:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5f6c62a5-9ccf-c130-7285-aa8cedbf65c9@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/24 9:45, liulongfang Wrote:
> On 2022/9/23 18:30, Shameerali Kolothum Thodi wrote:
>>
>>
>>> -----Original Message-----
>>> From: liulongfang
>>> Sent: 22 September 2022 09:39
>>> To: alex.williamson@redhat.com; jgg@nvidia.com; Shameerali Kolothum
>>> Thodi <shameerali.kolothum.thodi@huawei.com>
>>> Cc: cohuck@redhat.com; linux-kernel@vger.kernel.org;
>>> linuxarm@openeuler.org; liulongfang <liulongfang@huawei.com>
>>> Subject: [PATCH v2 3/5] hisi_acc_vfio_pci: Remove useless function
>>> parameter
>>>
>>> Remove unused function parameters for vf_qm_fun_reset() and
>>> ensure the device is enabled before the reset operation
>>> is performed.
>>>
>>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>>
>> Hi Longfang,
>>
>> This one seems to have a merge conflict on top of vfio/next branch.
>> May be better to rebase and send a v3 picking up Jason's R-by as well?
>>
> 
> I merged this patchset to the latest tag version vfio-v6.0-rc5 of the
> vfio/next branch, and there is no merge conflict.
> 
> Which patchset do you refer to as "Jason's R-by"? Can you provide the
> title of this patchset?
> 

I saw Jason's reply, and I reposted a v3 version with Jason's R-by.

>> Thanks,
>> Shameer
>>
Thansk,
Longfang
>>> ---
>>>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 8 +++++---
>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>>> b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>>> index 0638a8a6b0c1..24c03ff41502 100644
>>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>>> @@ -345,8 +345,7 @@ static struct hisi_acc_vf_core_device
>>> *hssi_acc_drvdata(struct pci_dev *pdev)
>>>  			    core_device);
>>>  }
>>>
>>> -static void vf_qm_fun_reset(struct hisi_acc_vf_core_device *hisi_acc_vdev,
>>> -			    struct hisi_qm *qm)
>>> +static void vf_qm_fun_reset(struct hisi_qm *qm)
>>>  {
>>>  	int i;
>>>
>>> @@ -662,7 +661,10 @@ static void hisi_acc_vf_start_device(struct
>>> hisi_acc_vf_core_device *hisi_acc_vd
>>>  	if (hisi_acc_vdev->vf_qm_state != QM_READY)
>>>  		return;
>>>
>>> -	vf_qm_fun_reset(hisi_acc_vdev, vf_qm);
>>> +	/* Make sure the device is enabled */
>>> +	qm_dev_cmd_init(vf_qm);
>>> +
>>> +	vf_qm_fun_reset(vf_qm);
>>>  }
>>>
>>>  static int hisi_acc_vf_load_state(struct hisi_acc_vf_core_device
>>> *hisi_acc_vdev)
>>> --
>>> 2.33.0
>>
>> .
>>
