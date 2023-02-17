Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CD469AABD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBQLty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBQLtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:49:53 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB85B5BD86
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:49:51 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PJ98p6Tgjz4f3pFX
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 19:49:46 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgDHeq7Zae9j2+YrDw--.64647S2;
        Fri, 17 Feb 2023 19:49:48 +0800 (CST)
Subject: Re: [dm-devel] [PATCH] dm: remove unnecessary check when using
 dm_get_mdptr()
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>
References: <20221216042353.3132139-1-houtao@huaweicloud.com>
 <e7fcd9fd-a882-2a97-a072-faf09441efbe@huawei.com>
 <5d93f5fc-05fa-906e-b2e9-0e9abcdf16f6@huaweicloud.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <fff0529b-435c-ebea-9e18-c9df74591b55@huaweicloud.com>
Date:   Fri, 17 Feb 2023 19:49:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5d93f5fc-05fa-906e-b2e9-0e9abcdf16f6@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgDHeq7Zae9j2+YrDw--.64647S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr13CF1DAF15JF4xJw13Jwb_yoW8uFWDpr
        1FgFWa9r4kJFsF9r42vanI9Fyjkw1YkrWUGr1xKayj93Wq9w18GayUGFWxWFyrAFyxAF4Y
        gr1Ig3y5CFWDA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ? Any comments on this clean up patch ?

On 1/31/2023 9:44 AM, Hou Tao wrote:
> ping ? Any comments on this clean up patch ?
>
> On 1/18/2023 9:16 PM, Hou Tao wrote:
>> ping ?
>>
>> On 12/16/2022 12:23 PM, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> __hash_remove() removes hash_cell with _hash_lock locked, so acquiring
>>> _hash_lock can guarantee no-NULL hc returned from dm_get_mdptr() must
>>> have not been removed and hc->md must still be md.
>>>
>>> __hash_remove() also acquires dm_hash_cells_mutex before setting mdptr
>>> as NULL, so in dm_copy_name_and_uuid() after acquiring
>>> dm_hash_cells_mutex and ensuring returned hc is not NULL, the returned
>>> hc must still be alive and hc->md must still be md.
>>>
>>> So removing these unnecessary hc->md != md checks when using
>>> dm_get_mdptr() with _hash_lock or dm_hash_cells_mutex acquired.
>>>
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>> ---
>>>  drivers/md/dm-ioctl.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
>>> index 3bfc1583c20a..2a86524661d1 100644
>>> --- a/drivers/md/dm-ioctl.c
>>> +++ b/drivers/md/dm-ioctl.c
>>> @@ -772,7 +772,7 @@ static struct dm_table *dm_get_inactive_table(struct mapped_device *md, int *src
>>>  
>>>  	down_read(&_hash_lock);
>>>  	hc = dm_get_mdptr(md);
>>> -	if (!hc || hc->md != md) {
>>> +	if (!hc) {
>>>  		DMERR("device has been removed from the dev hash table.");
>>>  		goto out;
>>>  	}
>>> @@ -1476,7 +1476,7 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
>>>  	/* stage inactive table */
>>>  	down_write(&_hash_lock);
>>>  	hc = dm_get_mdptr(md);
>>> -	if (!hc || hc->md != md) {
>>> +	if (!hc) {
>>>  		DMERR("device has been removed from the dev hash table.");
>>>  		up_write(&_hash_lock);
>>>  		r = -ENXIO;
>>> @@ -2128,7 +2128,7 @@ int dm_copy_name_and_uuid(struct mapped_device *md, char *name, char *uuid)
>>>  
>>>  	mutex_lock(&dm_hash_cells_mutex);
>>>  	hc = dm_get_mdptr(md);
>>> -	if (!hc || hc->md != md) {
>>> +	if (!hc) {
>>>  		r = -ENXIO;
>>>  		goto out;
>>>  	}
> .

