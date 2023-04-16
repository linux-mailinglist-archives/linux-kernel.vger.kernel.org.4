Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5659E6E3808
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjDPMf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjDPMf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:35:26 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D44F2127;
        Sun, 16 Apr 2023 05:35:23 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.153])
        by gateway (Coremail) with SMTP id _____8BxYU+K6ztkIHkdAA--.45982S3;
        Sun, 16 Apr 2023 20:35:22 +0800 (CST)
Received: from [10.20.42.153] (unknown [10.20.42.153])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx+72H6ztk1VApAA--.48745S3;
        Sun, 16 Apr 2023 20:35:20 +0800 (CST)
Subject: Re: [regression] Bug 217069 - Wake on Lan is broken on r8169 since
 6.2
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bob Moore <robert.moore@intel.com>,
        acpica-devel@lists.linuxfoundation.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
References: <e6aaddb9-afec-e77d-be33-570f9f10a9c2@leemhuis.info>
 <53e8b4db-e8dd-4dfa-f873-7dcbeac09149@leemhuis.info>
 <13aea525-108a-e018-987d-2447ff1d42df@leemhuis.info>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <754225a2-95a9-2c36-1886-7da1a78308c2@loongson.cn>
Date:   Sun, 16 Apr 2023 20:35:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <13aea525-108a-e018-987d-2447ff1d42df@leemhuis.info>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx+72H6ztk1VApAA--.48745S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJr4fZr4rAryUWw4rtFWkJFb_yoW8tFWfpF
        W5Kws8Xw4DGr18tan7Gw4v9ayj9wn8JF90kr9rXr4rXa45XasYvFyIgr43WFyUCr92ka13
        ta13ZryFgr9rAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUUU
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From the feedbacks, the WOL issue has been fixed, and I have submitted 
a fixed patch to ACPICA, which has been reviewing in last week (Rafael 
also looked into the fixed patch).

There are two kinds of issues in the bug, one is WOL failed in kexec 
reboot, another is WOL failed in cold reboot. The former one still exist 
after reverted patch(5c62d5aab8752e5ee7bfbe75ed6060db1c787f98),
so this issue is not caused by the reverted patch. The second is caused 
by the reverted patch, and has been fixed with my provided patch.

Please see:
https://bugzilla.kernel.org/show_bug.cgi?id=217069#c54
https://bugzilla.kernel.org/show_bug.cgi?id=217069#c59

Thanks.


On 2023/4/14 下午8:48, Thorsten Leemhuis wrote:
> On 19.03.23 08:20, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 22.02.23 08:57, Thorsten Leemhuis wrote:
>>>
>>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>>> kernel developer don't keep an eye on it, I decided to forward it by
>>> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217069 :
>>
>> An issue that looked like a network bug was now bisected and it turns
>> out it's cause by 5c62d5aab875 ("ACPICA: Events: Support fixed PCIe wake
>> event") which Huacai Chen provided. Could you take a look at the ticket
>> linked above?
> 
> Jianmin did get close to a proper fix a while ago
> (https://bugzilla.kernel.org/show_bug.cgi?id=217069#c46 ), but it
> appears there wasn't any progress to fix this during the last week. Or
> did I miss it?
> 
> This is kinda unsatisfying, as the culprit is now known for nearly four
> weeks; especially as this is a issue that is present in 6.2 since it was
> released and would have been possible to fix there and in mainline with
> a simple revert. We even got close to one two weeks ago already
> (https://bugzilla.kernel.org/show_bug.cgi?id=217069#c49 ).
> 
> #sigh
> 
> I'd say we should revert this. Rafael, what's your opinion here?
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke
> 

