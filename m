Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0681E5ED6FA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiI1H7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiI1H6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:58:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8EBF370A;
        Wed, 28 Sep 2022 00:58:53 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4McpkT3r1Sz6H75t;
        Wed, 28 Sep 2022 15:57:37 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 28 Sep 2022 09:58:50 +0200
Received: from [10.126.175.219] (10.126.175.219) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 08:58:50 +0100
Message-ID: <2b9a216c-dd91-d843-4a84-ac7ec78db853@huawei.com>
Date:   Wed, 28 Sep 2022 08:58:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 5/8] scsi: hisi_sas: use sas_find_attathed_phy_id()
 instead of open coded
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>,
        Jack Wang <jinpu.wang@ionos.com>
References: <20220928070130.3657183-1-yanaijie@huawei.com>
 <20220928070130.3657183-6-yanaijie@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220928070130.3657183-6-yanaijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.219]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 08:01, Jason Yan wrote:
> The attached phy finding is open coded. Now we can replace it with
> sas_find_attached_phy_id(). To keep consistent, the return value of
> hisi_sas_dev_found() is also changed to -ENODEV after calling
> sas_find_attathed_phy_id() failed.
> 
> Signed-off-by: Jason Yan<yanaijie@huawei.com>
> Reviewed-by: Jack Wang<jinpu.wang@ionos.com>
> Reviewed-by: Damien Le Moal<damien.lemoal@opensource.wdc.com>
> ---

Acked-by: John Garry <john.garry@huawei.com>
