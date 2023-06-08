Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F534727BB1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjFHJnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjFHJni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:43:38 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58E5226AF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:43:35 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Bxa+rFooFkT3sAAA--.1850S3;
        Thu, 08 Jun 2023 17:43:33 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx+OTEooFkYS0HAA--.23186S3;
        Thu, 08 Jun 2023 17:43:33 +0800 (CST)
Message-ID: <6d5b5538-6ef3-a409-4a8f-bb9b54eb478c@loongson.cn>
Date:   Thu, 8 Jun 2023 17:43:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/logicvc: Kconfig: select REGMAP and REGMAP_MMIO
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230608024207.581401-1-suijingfeng@loongson.cn>
 <ZIGAEZTJvq1GqFVD@aptenodytes>
 <aff664c7-b692-4fcf-ad61-8030cc648501@loongson.cn>
 <ZIGf6mKwX9RIm5a5@ashyti-mobl2.lan>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <ZIGf6mKwX9RIm5a5@ashyti-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx+OTEooFkYS0HAA--.23186S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Xr13KFyrtw1DXF47GFy5KFX_yoW8JrWrpF
        W8Ka4qyFs2vrWYkrn2yr12qFyYqr1rKrWaqr1q9rnrAFn0vr1Dtrs7ZrWUWr13WwnrKr4Y
        vanrKay3Ga17C3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07jYSoJUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  thanks for your reply and help.

On 2023/6/8 17:31, Andi Shyti wrote:
> Hi Jingfeng,
>
> On Thu, Jun 08, 2023 at 03:24:54PM +0800, Sui Jingfeng wrote:
>> Hi,
>>
>> thanks a lot
>>
>> On 2023/6/8 15:15, Paul Kocialkowski wrote:
>>> Hi,
>>>
>>> On Thu 08 Jun 23, 10:42, Sui Jingfeng wrote:
>>>> drm/logicvc driver is depend on REGMAP and REGMAP_MMIO, should select this
>>>> two kconfig option, otherwise the driver failed to compile on platform
>>>> without REGMAP_MMIO selected:
>>>>
>>>> ERROR: modpost: "__devm_regmap_init_mmio_clk" [drivers/gpu/drm/logicvc/logicvc-drm.ko] undefined!
>>>> make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
>>>> make: *** [Makefile:1978: modpost] Error 2
>>>>
>>>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>>> Thanks for the fix, looks good to me!
>>>
>>> Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>> After received this Acked-by, do a need append this tag to the patch, and
>> resend this again?
>>
>> I don't know about this.
>>
>> I don't need to do anythings ales, you will push it to your repository,
>> right?
> no need... someone will pick it up and add the needed tags.
Thanks a lot. Happy coding! :-)
> Andi

-- 
Jingfeng

