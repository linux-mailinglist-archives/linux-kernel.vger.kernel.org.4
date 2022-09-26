Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A70A5EA7E1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiIZOEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiIZOEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:04:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E9E4DB76;
        Mon, 26 Sep 2022 05:16:37 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MbhVz3l9nzHqJf;
        Mon, 26 Sep 2022 20:13:47 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 20:16:02 +0800
Subject: Re: [PATCH v2 5/8] scsi: libsas: introduce sas address comparation
 helpers
To:     John Garry <john.garry@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <jinpu.wang@cloud.ionos.com>
References: <20220924073455.2186805-1-yanaijie@huawei.com>
 <20220924073455.2186805-6-yanaijie@huawei.com>
 <41f4fee1-d05c-94cf-480e-4e9f6cf873bb@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <f7a9c9a7-edf7-0d0f-73dc-42935ac0b004@huawei.com>
Date:   Mon, 26 Sep 2022 20:16:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <41f4fee1-d05c-94cf-480e-4e9f6cf873bb@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/26 19:44, John Garry wrote:
> On 24/09/2022 08:34, Jason Yan wrote:
>> +static inline bool sas_phy_match_dev_addr(struct domain_device *dev,
>> +                     struct ex_phy *phy)
>> +{
>> +    return SAS_ADDR(dev->sas_addr) == SAS_ADDR(phy->attached_sas_addr);
>> +}
>> +
>> +static inline bool sas_phy_match_port_addr(struct asd_sas_port *port,
>> +                       struct ex_phy *phy)
>> +{
>> +    return SAS_ADDR(port->sas_addr) == SAS_ADDR(phy->attached_sas_addr);
>> +}
>> +
>> +static inline bool sas_phy_addr_same(struct ex_phy *p1, struct ex_phy 
>> *p2)
> 
> nit: please use "match" or "same" consistently in the naming. My 
> preference was for "match" to be used.
> 

OK.

Thanks,
Jason

> Thanks,
> John
> 
>> +{
>> +    return  SAS_ADDR(p1->attached_sas_addr) == 
>> SAS_ADDR(p2->attached_sas_addr);
>> +}
>> +
> 
> .
