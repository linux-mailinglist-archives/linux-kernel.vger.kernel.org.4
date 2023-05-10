Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C106FD443
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjEJD1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjEJD1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:27:04 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BB110EC;
        Tue,  9 May 2023 20:24:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QGL4Q56JCz4f3l8M;
        Wed, 10 May 2023 11:24:54 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgBH9CGHDltkLdqYIQ--.29139S3;
        Wed, 10 May 2023 11:24:56 +0800 (CST)
Subject: Re: Situation of CONFIG_BLK_WBT_MQ after commit b11d31ae01e6
 ("blk-wbt: remove unnecessary check in wbt_enable_default()")
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <CAKXUXMzfKq_J9nKHGyr5P5rvUETY4B-fxoQD4sO+NYjFOfVtZA@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8a86ba08-cde4-97a4-d7e2-dc340609381c@huaweicloud.com>
Date:   Wed, 10 May 2023 11:24:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMzfKq_J9nKHGyr5P5rvUETY4B-fxoQD4sO+NYjFOfVtZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBH9CGHDltkLdqYIQ--.29139S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1fAr1rAF4fWryDCFyrXrb_yoW8Crykp3
        4UJr17t3WvgFs7Kr4xZ34UKayFyFZ7K347Gryruw1UXrn8Aw4xZr4F9F1avFyqvr4vqw43
        t3ySqr9akry5Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/08 12:37, Lukas Bulwahn 写道:
> Dear Yu Kuai, dear Christoph, dear Jens,
> 
> 
> The commit b11d31ae01e6 ("blk-wbt: remove unnecessary check in
> wbt_enable_default()") removes the only reference to the config
> BLK_WBT_MQ in the kernel tree.
> 
> The commit comes with the statement "If CONFIG_BLK_WBT_MQ is disabled,
> wbt_init() won't do anything.". The statement "If CONFIG_BLK_WBT is
> disabled, wbt_init() won't do anything." (note: CONFIG_BLK_WBT vs.
> CONFIG_BLK_WBT_MQ) is certainly true, but I do not see that "If
> CONFIG_BLK_WBT_MQ is disabled, wbt_init() won't do anything.", but I
> believe it would simply do what wbt_init() does with CONFIG_BLK_WBT
> being enabled.
> 
> Now, it seems that with this commit applied, the intended switch of
> the config BLK_WBT_MQ is gone, and the config really now has no effect
> at all.
> 
> So, I am a bit puzzled:
> 
> 1. Either the config BLK_WBT_MQ does have an effect somewhere, but one
> cannot find its reference with 'git grep -i "BLK_WBT_MQ" .' --- so, my
> investigation is just incomplete or wrong, or
> 
> 2. We really do not need this further build config BLK_WBT_MQ beyond
> the other configs already there --- then this config should just be
> removed, or
> 
> 3. the commit unintentionally broke the purpose of the config
> BLK_WBT_MQ --- then this commit above should be reverted.

Thanks for the report, it's the above case and it's my mistake.
I will fix this.

Kuai
> 
> I would be happy if you could provide some guidance on what is the
> situation with config BLK_WBT_MQ.
> 
> Currently, I am guessing it is option 2 and the config BLK_WBT_MQ
> simply can be deleted, but I am really unsure. Probably, this build
> option is not used by many people and its effect is hardly noticed, if
> one does not specifically check for that in the running system.
> 
> 
> Best regards,
> 
> Lukas
> .
> 

