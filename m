Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE35637139
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiKXDpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKXDpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:45:22 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388DCD1;
        Wed, 23 Nov 2022 19:45:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NHkQz486yz4f3lGb;
        Thu, 24 Nov 2022 11:45:15 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgC329jM6H5jbEk5BA--.7917S3;
        Thu, 24 Nov 2022 11:45:18 +0800 (CST)
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Subject: Why is MEGASAS_SAS_QD set to 256?
Message-ID: <1c4d66ca-fe1a-3d1a-d7f9-4981d2fc9eb1@huaweicloud.com>
Date:   Thu, 24 Nov 2022 11:45:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgC329jM6H5jbEk5BA--.7917S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4DGF13KF1fXr18KF1DGFg_yoWkGFcEgr
        43G3s2qw4FkrsaqrW7Kr1Yyr4jyF4jvayDCr1qgry7ursrZr13GryDur1UXF43tayv9FsI
        g3s8ur1ruwn3ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While upgrading kernel from 4.19 to 5.10, I found that fio 1 thread 4k
sequential io performance is dropped(160Mib -> 100 Mib), root cause is
that queue_depth is changed from 64 to 256.

commit 6e73550670ed1c07779706bb6cf61b99c871fc42
scsi: megaraid_sas: Update optimal queue depth for SAS and NVMe devices

diff --git a/drivers/scsi/megaraid/megaraid_sas.h 
b/drivers/scsi/megaraid/megaraid_sas.h
index bd8184072bed..ddfbe6f6667a 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2233,9 +2233,9 @@ enum MR_PD_TYPE {

  /* JBOD Queue depth definitions */
  #define MEGASAS_SATA_QD        32
-#define MEGASAS_SAS_QD 64
+#define MEGASAS_SAS_QD 256
  #define MEGASAS_DEFAULT_PD_QD  64
-#define MEGASAS_NVME_QD                32
+#define MEGASAS_NVME_QD        64


And with the default nr_requests 256, 256 queue_depth will make the
elevator has no effect, specifically io can't be merged in this test
case. Hence it doesn't make sense to me to set default queue_depth to
256.

Is there any reason why MEGASAS_SAS_QD is changed to 64?

Thanks,
Kuai

