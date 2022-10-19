Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA660375F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 03:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJSBGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 21:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJSBGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 21:06:21 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3925CDED38;
        Tue, 18 Oct 2022 18:06:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MsXYm4Xsrzl66p;
        Wed, 19 Oct 2022 09:04:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAXCzKETU9jlvBPAA--.9090S3;
        Wed, 19 Oct 2022 09:06:13 +0800 (CST)
Subject: Re: [PATCH v4 4/6] blk-wbt: don't show valid wbt_lat_usec in sysfs
 while wbt is disabled
To:     Christoph Hellwig <hch@infradead.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, ebiggers@kernel.org, paolo.valente@linaro.org,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220930031906.4164306-1-yukuai1@huaweicloud.com>
 <20220930031906.4164306-5-yukuai1@huaweicloud.com>
 <Y07LCnJN5q8ueV7X@infradead.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <63e04cac-974a-3235-275d-64499cbd5863@huaweicloud.com>
Date:   Wed, 19 Oct 2022 09:06:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y07LCnJN5q8ueV7X@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXCzKETU9jlvBPAA--.9090S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF13ArW7XFy7CFyrKF15Arb_yoWxCFXE9a
        4jqF12kr45WF1vyF1DG3s7Wr93JF9rX3Wqgrs5J3WfCwn5WrWDAr18Wana93yIqr1DtFyx
        G3sxAF9Fqw1jgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
        04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2022/10/18 23:49, Christoph Hellwig Ð´µÀ:
>>   static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
>>   {
>> +	u64 lat;
>> +
>>   	if (!wbt_rq_qos(q))
>>   		return -EINVAL;
>>   
>> -	return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
>> +	lat = wbt_disabled(q) ? 0 : div_u64(wbt_get_min_lat(q), 1000);
>> +
>> +	return sprintf(page, "%llu\n", lat);
> 
> 	if (wbt_disabled(q))
> 		return sprintf(page, "0\n");
> 	return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
> 
> but otherwise the patch looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> .
> 

Thanks for the review, I'll send a new version.

Kuai

