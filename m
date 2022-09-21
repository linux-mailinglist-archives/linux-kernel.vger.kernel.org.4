Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23B75BFAAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiIUJTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiIUJTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:19:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41D6901B6;
        Wed, 21 Sep 2022 02:18:28 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MXXq16XT9z67M3B;
        Wed, 21 Sep 2022 17:16:45 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 21 Sep 2022 11:17:49 +0200
Received: from [10.195.245.235] (10.195.245.235) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 10:17:49 +0100
Message-ID: <7d271ce3-b289-4ecb-3555-c31dfa6091de@huawei.com>
Date:   Wed, 21 Sep 2022 10:17:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC 3/6] scsi: core: Add scsi_get_dev()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hare@suse.de>,
        <hch@lst.de>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <brking@us.ibm.com>
References: <1663669630-21333-1-git-send-email-john.garry@huawei.com>
 <1663669630-21333-4-git-send-email-john.garry@huawei.com>
 <c444fad0-7e7f-0940-84ce-a6fdaa99c493@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <c444fad0-7e7f-0940-84ce-a6fdaa99c493@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.245.235]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 22:58, Damien Le Moal wrote:
>> +extern struct scsi_device *scsi_get_dev(struct device *parent, int 
>> channel, uint id, u64 lun);
> 
> You should not need extern here, and long line...
> 
>> +
>>   /*
>> +
> 
> white line change.
> 
>>    * DIF defines the exchange of protection information between
>>    * initiator and SBC block device. 

ok, I'll tidy them.

Thanks,
John
