Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966935E9D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiIZJXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiIZJWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:22:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D689E19006
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:20:41 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mbcbt1fTNzpVd6;
        Mon, 26 Sep 2022 17:17:46 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:20:40 +0800
Received: from [10.67.102.118] (10.67.102.118) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:20:39 +0800
Subject: Re: [PATCH v3 0/5] Fix some bugs and clean code issues
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
References: <20220924022049.12022-1-liulongfang@huawei.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <30df011d-7895-b532-a62f-a53f9c4cecc1@huawei.com>
Date:   Mon, 26 Sep 2022 17:20:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220924022049.12022-1-liulongfang@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/24 10:20, Longfang Liu wrote:
> Modify two code bugs inside the driver, update the format of the
> driver's log and comments, and delete an unused macro definition.
> 
> Changes in v3:
> - Remake patchset based on latest branch.
> - Add new reviewer.
> 
> Changes in v2:
> - Remove a wrong patch.
> - Remove some unnecessary changes.
> 
> Longfang Liu (5):
>   hisi_acc_vfio_pci: Fixes error return code issue
>   hisi_acc_vfio_pci: Fix device data address combination problem
>   hisi_acc_vfio_pci: Remove useless function parameter
>   hisi_acc_vfio_pci: Remove useless macro definitions
>   hisi_acc_vfio_pci: Update some log and comment formats
> 
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 36 ++++++++++---------
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  7 ++--
>  2 files changed, 22 insertions(+), 21 deletions(-)
> 
Hi all, this patchset needs to be updated based on the
vfio/next branch, please ignore it.
