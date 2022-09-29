Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EAC5EF2DF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiI2J6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbiI2J6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:58:42 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0E0312CC85
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:58:40 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx32tGbDVjybojAA--.61626S3;
        Thu, 29 Sep 2022 17:58:31 +0800 (CST)
Subject: Re: [PATCH] entry: Remove has_signal comment of
 arch_do_signal_or_restart() prototype
To:     Kees Cook <keescook@chromium.org>
References: <1662090106-5545-1-git-send-email-yangtiezhu@loongson.cn>
 <202209021610.80DCFC7A@keescook>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <c9f6ab17-153e-23a7-a55a-37bd3d71b399@loongson.cn>
Date:   Thu, 29 Sep 2022 17:58:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <202209021610.80DCFC7A@keescook>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Bx32tGbDVjybojAA--.61626S3
X-Coremail-Antispam: 1UD129KBjvdXoWrWryDZw4xZF43Jr13CF4rZrb_yoWxXwbEkF
        4I9rZYgw15Jrs7C3WYkw13WrWxK3s5KFWkJF90qFWUC3WFy3yUGF4DCrs5GryfWayUuF17
        ZFs0qwsIkr10kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbI8YjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
        02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUxxpnDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2022 07:10 AM, Kees Cook wrote:
> On Fri, Sep 02, 2022 at 11:41:46AM +0800, Tiezhu Yang wrote:
>> The argument has_signal of arch_do_signal_or_restart() has been removed
>> in commit 8ba62d37949e ("task_work: Call tracehook_notify_signal from
>> get_signal on all architectures"), let us remove the related comment.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> Fixes: 8ba62d37949e ("task_work: Call tracehook_notify_signal from get_signal on all architectures")
> Reviewed-by: Kees Cook <keescook@chromium.org>
>

Hi all,

Do you know which tree this patch will go through?

Thanks,
Tiezhu

