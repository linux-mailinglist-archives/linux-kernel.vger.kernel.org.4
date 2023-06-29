Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088C47427C5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjF2N4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF2N4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:56:19 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5BE3588;
        Thu, 29 Jun 2023 06:56:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QsKjm6dh5z4f3mLl;
        Thu, 29 Jun 2023 21:56:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgA30JN7jZ1kNf48Mw--.38969S3;
        Thu, 29 Jun 2023 21:56:12 +0800 (CST)
Subject: Re: mainline build failure due to 8295efbe68c0 ("md/raid1-10: factor
 out a helper to submit normal write")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
References: <ZJ2H5FWuo9oDMgPm@debian>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <be9320b5-7613-be0f-ffcd-4b3041ea5836@huaweicloud.com>
Date:   Thu, 29 Jun 2023 21:56:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZJ2H5FWuo9oDMgPm@debian>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA30JN7jZ1kNf48Mw--.38969S3
X-Coremail-Antispam: 1UD129KBjvdXoW7WryUJFy3tr4fXF1Utw4Utwb_yoWDAFgEvF
        4q9rWrKr1jyr10yw1SkF4S93s8tayUKFn3Xw4FqF18ur98Za15ur45ua4rG3WxJr9YgFnF
        yryxG3s5tr1jgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
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

ÔÚ 2023/06/29 21:32, Sudip Mukherjee (Codethink) Ð´µÀ:
> Hi All,
> 
> The latest mainline kernel branch fails to build x86_64, arm64 and arm allmodconfig

Thanks for the testing, which branch are you testing?

This problem is already fixed in latest mainline kernel:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b5a99602b74bbfa655be509c615181dd95b0719e

Kuai
> with clang (version 16.0.1), and the error is:
> 
> In file included from drivers/md/raid1.c:52:
> drivers/md/raid1-10.c:119:25: error: casting from randomized structure pointer type 'struct block_device *' to 'struct md_rdev *'
>          struct md_rdev *rdev = (struct md_rdev *)bio->bi_bdev;
>                                 ^
> 
> git bisect pointed to 8295efbe68c0 ("md/raid1-10: factor out a helper to submit normal write").
> 
> Reverting the commit has fixed the build failure.
> 
> I will be happy to test any patch or provide any extra log if needed.
> 
> #regzbot introduced: 8295efbe68c080047e98d9c0eb5cb933b238a8cb
> 

