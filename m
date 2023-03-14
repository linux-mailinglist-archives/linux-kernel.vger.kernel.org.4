Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262BF6B904A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCNKhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCNKh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:37:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04259DE31
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:36:24 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PbVKg36HrzKmfT;
        Tue, 14 Mar 2023 18:35:35 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 18:35:48 +0800
Subject: Re: [PATCH v8 3/5] hisi_acc_vfio_pci: register debugfs for hisilicon
 migration driver
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <alex.williamson@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230217084831.35783-1-liulongfang@huawei.com>
 <20230217084831.35783-4-liulongfang@huawei.com> <ZAtnaFHucAe9ntKW@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <1e2b9f0f-e99e-babb-7531-6083673d399d@huawei.com>
Date:   Tue, 14 Mar 2023 18:35:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZAtnaFHucAe9ntKW@nvidia.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2023/3/11 1:22, Jason Gunthorpe wrote:
> On Fri, Feb 17, 2023 at 04:48:29PM +0800, Longfang Liu wrote:
> 
>> +static int hisi_acc_vfio_debug_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>> +{
>> +	struct vfio_device *vdev = &hisi_acc_vdev->core_device.vdev;
>> +	struct device *dev = vdev->dev;
>> +	void *migf = NULL;
>> +
>> +	if (!debugfs_initialized())
>> +		return 0;
>> +
>> +	vfio_vf_debugfs_init(vdev);
> 
> This is weirdly named with _vf_, this is just
> vfio_device_debufs_init()
> 
OK,

Thanks,
Longfang.
> Jason
> .
> 
