Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD477602C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiJRNMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJRNMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:12:14 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B6836406;
        Tue, 18 Oct 2022 06:12:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MsDjs21Przl6V4;
        Tue, 18 Oct 2022 21:10:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3PS4opk5jpJ03AA--.4670S3;
        Tue, 18 Oct 2022 21:12:10 +0800 (CST)
Subject: Re: [PATCH RFC 1/2] kobject: add return value for kobject_put()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hch@lst.de, axboe@kernel.dk, willy@infradead.org,
        martin.petersen@oracle.com, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221018131432.434167-1-yukuai3@huawei.com>
 <20221018131432.434167-2-yukuai3@huawei.com> <Y06je6LiDicUfzto@kroah.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2f962069-8fd9-08df-aa00-062b94569c36@huaweicloud.com>
Date:   Tue, 18 Oct 2022 21:12:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y06je6LiDicUfzto@kroah.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3PS4opk5jpJ03AA--.4670S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw48CryxAryxXr48tFWrXwb_yoWDJwc_Cr
        WfAFZrCw4fWw1Ik3W8twn8GrW7trZF9a4jqrZFqr17Xa48WanxJrWUG34F9Fs7CrWktF1D
        Cr9Yy343Ww12vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2022/10/18 21:00, Greg KH Ð´µÀ:
> On Tue, Oct 18, 2022 at 09:14:31PM +0800, Yu Kuai wrote:
>> The return value will be used in later patch to fix uaf for slave_dir
>> and bd_holder_dir in block layer.
> 
> Then the user will be incorrect, this is not ok, you should never care
> if you are the last "put" on an object at all.  Hint, what happens right
> after you call this and get the result?
> 

I tried to reset the pointer to NULL in patch 2 to prevent uaf. And the
whole kobject_put() and pointer reset is protected by a mutex, the mutex
will be used on the reader side before kobject_get as well. So, in fact,
I'm protecting them by the mutex...

I can bypass it by using another reference anyway. But let's see if
anyone has suggestions on the other patch.

> sorry, but NAK.

I know the best way is too refactor the lifecycle of the problematic
bd_holder_dir/slave_dir, however, I gave that up because this seems
quite complicated and influence is very huge...

Thanks,
Kuai
> 
> greg k-h
> .
> 

