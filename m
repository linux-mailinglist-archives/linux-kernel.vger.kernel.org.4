Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19C264C1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 02:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbiLNBSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 20:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbiLNBST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 20:18:19 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388D9BD3;
        Tue, 13 Dec 2022 17:18:19 -0800 (PST)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NWy7D1Z8XzqT49;
        Wed, 14 Dec 2022 09:14:00 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 14 Dec 2022 09:18:16 +0800
Subject: Re: [PATCH] scsi: scsi_debug: Delete unreachable code in
 inquiry_vpd_b0()
To:     John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <dgilbert@interlog.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221213142122.1011886-1-john.g.garry@oracle.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <c1ce375c-0c40-0636-e448-b324467816ef@huawei.com>
Date:   Wed, 14 Dec 2022 09:18:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221213142122.1011886-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/13 22:21, John Garry wrote:
> The 2nd return statement in inquiry_vpd_b0() is unreachable, so delete it.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index b8a76b89f85a..6f637501539c 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -1511,8 +1511,6 @@ static int inquiry_vpd_b0(unsigned char *arr)
>   	put_unaligned_be64(sdebug_write_same_length, &arr[32]);
>   
>   	return 0x3c; /* Mandatory page length for Logical Block Provisioning */
> -
> -	return sizeof(vpdb0_data);
>   }
>   
>   /* Block device characteristics VPD page (SBC-3) */
> 

Looks good,
Reviewed-by: Jason Yan <yanaijie@huawei.com>
