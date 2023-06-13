Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44A072E346
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242080AbjFMMqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbjFMMqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:46:09 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A94DE7A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:46:07 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.22])
        by gateway (Coremail) with SMTP id _____8Bx7eoOZYhkB6UEAA--.9985S3;
        Tue, 13 Jun 2023 20:46:06 +0800 (CST)
Received: from [10.180.13.22] (unknown [10.180.13.22])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax6OQNZYhkhyoZAA--.6327S3;
        Tue, 13 Jun 2023 20:46:05 +0800 (CST)
Message-ID: <de2b71d8-9204-a8cc-2e82-9a9e2c04ee9e@loongson.cn>
Date:   Tue, 13 Jun 2023 20:45:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [ PATCH v2 0/3] Add Loongson I2S controller support
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
References: <20230612085048.3039471-1-mengyingkun@loongson.cn>
 <31bd1de1-feb7-4544-aca6-cfb983722057@sirena.org.uk>
From:   Yingkun Meng <mengyingkun@loongson.cn>
In-Reply-To: <31bd1de1-feb7-4544-aca6-cfb983722057@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Ax6OQNZYhkhyoZAA--.6327S3
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQABDGSIXIIAvwACsD
X-Coremail-Antispam: 1Uk129KBj9xXoWrKF4rWw18ZFWxJr1UKF4rWFX_yoWfZFXE9r
        ya9Fn5ZrykArykZ395trW5XF9I9a4jv34UK345tF1vqasYgryFgrWqkrZI9a4rGF4DK3Zx
        Xr4DGr4jy347GosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
        WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUU
        U==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/13 03:07, Mark Brown wrote:
> On Mon, Jun 12, 2023 at 04:50:48PM +0800, YingKun Meng wrote:
>> Hi all,
>>
>> This patchset adds support for Loongson I2S controller, and
>> introduce a ASoC machine driver for loongson platform.
>>
>> The Loongson I2S controller is available on Loongson
>> 7a2000/2k2000 chips, works as a PCI device. It has two
>> private DMA controllers used to playback and capture.
>> Each DMA controller has one channel.
>>
>> The ASoC machine driver adds support for audio device which
>> using loongson I2S controller to tranfser the audio data.
>> The audio device uses "PRP0001" as its ACPI device ID, which
>> provides a means to use the existing DT-compatible device
>> identification in ACPI.
> The code here all looks broadly good - I did have a few review comments
> that I sent in reply to the individual patches but they're more
> stylistic than anything too substantial.


Thanks

