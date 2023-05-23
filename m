Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D69D70DDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbjEWNqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjEWNqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:46:31 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A3CCA;
        Tue, 23 May 2023 06:46:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QQbFX1Z0xz4f3kjM;
        Tue, 23 May 2023 21:46:24 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgAXvuuww2xkCSPIJw--.31377S3;
        Tue, 23 May 2023 21:46:26 +0800 (CST)
Subject: Re: [PATCH] md/raid5: Convert stripe_head's "dev" to flexible array
 member
To:     Christoph Hellwig <hch@infradead.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20230517233313.never.130-kees@kernel.org>
 <ZGWpLClY7vz+xl5A@infradead.org>
 <229ac866-9710-5dbe-80c4-61498f807662@huaweicloud.com>
 <ZGxU/zSGkqGhGWmF@infradead.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <33c61f2b-2391-1199-d760-b438aff2cebe@huaweicloud.com>
Date:   Tue, 23 May 2023 21:46:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZGxU/zSGkqGhGWmF@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXvuuww2xkCSPIJw--.31377S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZFW3Xr1UXF4rurykuFy3Arb_yoWxCwc_Za
        1akF47Gr17AFyvvF47twn8WrWv93W8WFZxAry0gFs2q3s8Zas3Cr4kAwnavF98t3Wftr4Y
        9F90qF15JFs7KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/23 13:54, Christoph Hellwig 写道:
> On Mon, May 22, 2023 at 07:49:38PM +0800, Yu Kuai wrote:
>> Hi, Christoph
>>
>> 在 2023/05/18 12:27, Christoph Hellwig 写道:
>>
>> It's not related to this patch, just I think I found a problem while
>> reviewing raid5 code, commit e82ed3a4fbb5 ("md/raid6: refactor
>> raid5_read_one_chunk") changes the caculation of 'end_sector',
>> 'end_sector' is compared to 'rdev->recovery_offset', so it should be
>> offset to rdev, but this commit change it to offset to the array.
>>
>> Perhaps following change will make sense:
> 
> Yes, I think it does.  Can you send a patch?
> .
> 

Of course, thanks for your response.

Kuai

