Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6061074A870
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjGGB0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGGB0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:26:42 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13FE113;
        Thu,  6 Jul 2023 18:26:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qxwj91lxDz4f3jq2;
        Fri,  7 Jul 2023 09:26:37 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7PNaadkfGaHNQ--.3435S3;
        Fri, 07 Jul 2023 09:26:37 +0800 (CST)
Subject: Re: [PATCH -next 2/3] md/dm-raid: cleanup multiple equivalent goto
 tags from raid_ctr()
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, heinzm@redhat.com, neilb@suse.de,
        jbrassow@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230706071622.563073-1-yukuai1@huaweicloud.com>
 <20230706071622.563073-3-yukuai1@huaweicloud.com>
 <37c7a3f7-f769-a313-3279-e8e415369ba4@molgen.mpg.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c42524a9-6854-673b-d54e-392995483cca@huaweicloud.com>
Date:   Fri, 7 Jul 2023 09:26:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <37c7a3f7-f769-a313-3279-e8e415369ba4@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7PNaadkfGaHNQ--.3435S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZr1xAw43ZrW8Cr45trWkZwb_yoWfCwb_Ca
        s2yasrGr1SqanxW3W5Gr4F9r90k398GrnrAFyIv3yjva4fXrsYkF4kCrZ0qr45WFWFyryr
        Jr1UXrWrAry7KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1U
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUp6wZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/07/06 21:01, Paul Menzel 写道:
> Dear Yu,
> 
> 
> Thank you for your patch. Some minor nits, if you are interested.
> 
> Am 06.07.23 um 09:16 schrieb Yu Kuai:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> There are four equivalent goto tags in raid_ctr(), clean them up to use
>> just one, there are no functional change and prepare to fix that
> 
> Maybe:
> 
> There *is* no functional change, and is a preparation to fix an 
> unprotected `md_stop()`.
> 
>> md_stop() is not protected.
> 
> In the commit message summary/title, I’d spell the verb with a space:
> 
>      Clean up four equivalent goto tags in raid_ctr()
> 

Thanks for the suggestions, I'll update them in the next version.

Thanks,
Kuai
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/dm-raid.c | 27 +++++++++------------------
>>   1 file changed, 9 insertions(+), 18 deletions(-)
> 
> […]
> 
> 
> Kind regards,
> 
> Paul
> 
> .
> 

