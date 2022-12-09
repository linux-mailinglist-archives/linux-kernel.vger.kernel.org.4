Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668D4647CF2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 05:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiLIEiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 23:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIEiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 23:38:04 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 177B81DDF0;
        Thu,  8 Dec 2022 20:38:01 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.32])
        by gateway (Coremail) with SMTP id _____8Axjuuou5Jj_FQEAA--.10160S3;
        Fri, 09 Dec 2022 12:38:00 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxtuOnu5Jj2ukoAA--.34901S3;
        Fri, 09 Dec 2022 12:37:59 +0800 (CST)
Subject: Re: [PATCH] dt-bindings: interrupt-controller: loongarch: Fix
 mismathed compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liu Peibao <liupeibao@loongson.cn>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221208030208.10841-1-liupeibao@loongson.cn>
 <6604d25f-f5f9-332d-bd2d-08706380c935@linaro.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <53bd2d8d-75f6-80b4-f9a7-73165ee637d6@loongson.cn>
Date:   Fri, 9 Dec 2022 12:37:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6604d25f-f5f9-332d-bd2d-08706380c935@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxtuOnu5Jj2ukoAA--.34901S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCr13Kr4xGFy8KF13ArykAFb_yoW5XFyfpF
        W3Gwn0y3ykJr43tr4Ika4IvryIy398Ar9xGrn5G34kZr4DX3W3tFySkay5ua4UZws3Way2
        qr40ga1vkF4DZFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/8 下午4:42, Krzysztof Kozlowski wrote:
> On 08/12/2022 04:02, Liu Peibao wrote:
>> The "compatible" doesn't match what the kernel is using. Fix it as
>> kernel using.
>>
>> Fixes: 855d4ca4bdb3 ("irqchip: loongarch-cpu: add DT support")
> 
> Really? You just added these patches...
> 
> 1.  In the same time Loongson people keep pinging for accepting these:
> https://lore.kernel.org/all/e3bf1f8a-e37e-46e3-f9b3-20a9031d49e2@loongson.cn/
> https://lore.kernel.org/all/f5d0f796-0147-8789-5bed-edf38b28229e@loongson.cn/
> 
> All the time - several pings, every week.
> 
> 2. In the last weeks, two of your engineers sent the same driver
> (Loongson I2C) in the same time, with different names! For the same
> hardware.
> 
> 3. Several other patches from Loongson, when posted on mailing lists,
> have multiple compile warnings. This suggests they were not really
> compiled properly (with different test configs, with W=1, smatch,
> sparse, coccinelle). There were so many compiler warnings, that I assume
> your patches should wait on mailing list for two weeks before starting
> any review. Otherwise it's a bit waste of reviewer's effort.
> 
> Patches are welcomed but all this points on poor quality of submissions
> and sending anything, hoping it will get merged upstream, regardless of
> quality.
> 
> I appreciate fixing the patch fast, it's a good sign, but maybe Loongson
> could a bit improve internal processes of review before sending and
> pinging on mailing list?
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Hi, Krzysztof

As for me privately, I must say that I'm very appreciate patient helps 
and guides to us (some of us are new comers include me without more 
experience) from each maintainer and reviewer, thanks very much!
 From some patch series(include my patches), it literally seems that 
some low quality problem (e.g. since some reasons such as not familiar 
with rules of community patch, building warning by test robot checking 
and no internal review process) just as noise that bothered reviewers 
and consumed more time (back and forth), which is definitely due to our 
poor work in my opinion (though I'm not sure how others think about it). 
Have Loongson folks (especially new comers like me) put more efforts 
into patch work and learn about experience from reviewing process, the 
patch quality would be improved better.

Again, thanks for pointing out some problems you mentioned above(e.g. 
same patch with different name from different Loongson people, 
frequently pinging and patch quality), I think I can feed back them to 
company to pay more attention and take steps to improve community work.

Thanks!
Jianmin Lv

