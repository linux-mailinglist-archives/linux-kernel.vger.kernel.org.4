Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060985E7864
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiIWKbL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Sep 2022 06:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiIWKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:30:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7241162C8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:30:35 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYpFn2gDVzMpSb;
        Fri, 23 Sep 2022 18:25:49 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 18:30:32 +0800
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 kwepemm600008.china.huawei.com (7.193.23.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 18:30:31 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2375.031;
 Fri, 23 Sep 2022 11:30:29 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     liulongfang <liulongfang@huawei.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [PATCH v2 3/5] hisi_acc_vfio_pci: Remove useless function
 parameter
Thread-Topic: [PATCH v2 3/5] hisi_acc_vfio_pci: Remove useless function
 parameter
Thread-Index: AQHYzl9vC4QMKuAtPkCh8aPTV+fA4a3s0YDg
Date:   Fri, 23 Sep 2022 10:30:29 +0000
Message-ID: <d98867217f4047709de00d610ad2e8b8@huawei.com>
References: <20220922083928.58797-1-liulongfang@huawei.com>
 <20220922083928.58797-4-liulongfang@huawei.com>
In-Reply-To: <20220922083928.58797-4-liulongfang@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: liulongfang
> Sent: 22 September 2022 09:39
> To: alex.williamson@redhat.com; jgg@nvidia.com; Shameerali Kolothum
> Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: cohuck@redhat.com; linux-kernel@vger.kernel.org;
> linuxarm@openeuler.org; liulongfang <liulongfang@huawei.com>
> Subject: [PATCH v2 3/5] hisi_acc_vfio_pci: Remove useless function
> parameter
> 
> Remove unused function parameters for vf_qm_fun_reset() and
> ensure the device is enabled before the reset operation
> is performed.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>

Hi Longfang,

This one seems to have a merge conflict on top of vfio/next branch.
May be better to rebase and send a v3 picking up Jason's R-by as well?

Thanks,
Shameer

> ---
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 0638a8a6b0c1..24c03ff41502 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -345,8 +345,7 @@ static struct hisi_acc_vf_core_device
> *hssi_acc_drvdata(struct pci_dev *pdev)
>  			    core_device);
>  }
> 
> -static void vf_qm_fun_reset(struct hisi_acc_vf_core_device *hisi_acc_vdev,
> -			    struct hisi_qm *qm)
> +static void vf_qm_fun_reset(struct hisi_qm *qm)
>  {
>  	int i;
> 
> @@ -662,7 +661,10 @@ static void hisi_acc_vf_start_device(struct
> hisi_acc_vf_core_device *hisi_acc_vd
>  	if (hisi_acc_vdev->vf_qm_state != QM_READY)
>  		return;
> 
> -	vf_qm_fun_reset(hisi_acc_vdev, vf_qm);
> +	/* Make sure the device is enabled */
> +	qm_dev_cmd_init(vf_qm);
> +
> +	vf_qm_fun_reset(vf_qm);
>  }
> 
>  static int hisi_acc_vf_load_state(struct hisi_acc_vf_core_device
> *hisi_acc_vdev)
> --
> 2.33.0

