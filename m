Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0EE650646
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 03:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiLSCTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 21:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLSCTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 21:19:48 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58738636B;
        Sun, 18 Dec 2022 18:19:47 -0800 (PST)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nb3KX1R3WzmWmj;
        Mon, 19 Dec 2022 10:18:40 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 10:19:44 +0800
Subject: Re: [PATCH V2] scsi: libsas: Directly kick-off EH when ATA device
 fell off
To:     Xingui Yang <yangxingui@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <john.g.garry@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>
References: <20221216100327.7386-1-yangxingui@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <baf759c8-a738-903d-4ff1-a98ce20d9f43@huawei.com>
Date:   Mon, 19 Dec 2022 10:19:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221216100327.7386-1-yangxingui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/16 18:03, Xingui Yang wrote:
> If the ATA device fell off, call sas_ata_device_link_abort() directly and
> mark all outstanding QCs as failed and kick-off EH Immediately. This avoids
> having to wait for block layer timeouts.
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
> Changes to v1:
> - Use dev_is_sata() to check ATA device type
>   drivers/scsi/libsas/sas_discover.c | 3 +++
>   1 file changed, 3 insertions(+)

Looks good,
Reviewed-by: Jason Yan <yanaijie@huawei.com>
