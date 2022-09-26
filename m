Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C125EA19B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbiIZKxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiIZKu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:50:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED1158B5A;
        Mon, 26 Sep 2022 03:27:21 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mbf6k5v0Hz688XS;
        Mon, 26 Sep 2022 18:26:06 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 12:27:17 +0200
Received: from [10.48.156.245] (10.48.156.245) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:27:17 +0100
Message-ID: <0b9ce76d-4c0d-615d-3345-5803fb29db45@huawei.com>
Date:   Mon, 26 Sep 2022 11:27:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 0/7] libsas and drivers: NCQ error handling
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <jejb@linux.ibm.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <yangxingui@huawei.com>
References: <1663840018-50161-1-git-send-email-john.garry@huawei.com>
 <yq1a66npc3b.fsf@ca-mkp.ca.oracle.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <yq1a66npc3b.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.156.245]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On 25/09/2022 19:02, Martin K. Petersen wrote:

Hi Martin,

>> Based on mkp-scsi @ 6.1/scsi-staging 7f615c1b5986 ("scsi:
>> scsi_transport_fc: Use %u for dev_loss_tmo")
> Can you please rebase on top of the latest staging? There are a couple
> of pm8001 conflicts.

Sorry about that, I did test that it applied ok but I did not test 
building it again. Anyway, this is the only issue I saw:

drivers/scsi/pm8001/pm8001_hwi.c: In function ‘pm8001_mpi_task_abort_resp’:
drivers/scsi/pm8001/pm8001_hwi.c:3520:15: error: ‘pm8001_dev’ undeclared 
(first use in this function); did you mean ‘pm8001_dbg’?
  3520 |   atomic_dec(&pm8001_dev->running_req);
       |               ^~~~~~~~~~
       |               pm8001_dbg

Was there another issue?

Thanks,
John
