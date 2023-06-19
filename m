Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5B1734CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjFSHtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFSHtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:49:40 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 087B0C0;
        Mon, 19 Jun 2023 00:49:37 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.22])
        by gateway (Coremail) with SMTP id _____8DxAOmQCJBkr8gGAA--.12251S3;
        Mon, 19 Jun 2023 15:49:36 +0800 (CST)
Received: from [10.180.13.22] (unknown [10.180.13.22])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax6OSPCJBk5P8fAA--.24411S3;
        Mon, 19 Jun 2023 15:49:35 +0800 (CST)
Message-ID: <ae880c97-e38d-0f01-f349-a427ab4afd41@loongson.cn>
Date:   Mon, 19 Jun 2023 15:49:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/3] ASoC: Add support for Loongson I2S controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Dan Carpenter <error27@gmail.com>,
        kernel-janitors@vger.kernel.org
References: <20230615122718.3412942-1-mengyingkun@loongson.cn>
 <cf2f3bc9-3141-8d7b-b57d-73eac70a21d2@oracle.com>
 <6901166d-387f-24de-6ffd-1c8eea724718@oracle.com>
 <325dd825-6fa5-0ebc-4b7e-7acf2d2840e4@loongson.cn>
 <bd4da934-72b7-67f3-0c9c-c18d3af16e7d@linaro.org>
Content-Language: en-US
From:   Yingkun Meng <mengyingkun@loongson.cn>
In-Reply-To: <bd4da934-72b7-67f3-0c9c-c18d3af16e7d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax6OSPCJBk5P8fAA--.24411S3
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQAHDGSO9AIDRgAHsU
X-Coremail-Antispam: 1Uk129KBj9xXoW7JrW5Ww15CrWUJF13Ar1rZrc_yoWkGFg_Xw
        4q9wn8XFyUJay5Jrs7Kr9FvFyDXr13trn8Jw4rZF1UXwnrJF95Wr15Gwn3JrZrGrWUGr1U
        Xrn8Wa43u3WUWosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUU
        UU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/19 15:00, Krzysztof Kozlowski wrote:
> On 19/06/2023 03:45, Yingkun Meng wrote:
>>>>> +    tx_data->irq = fwnode_irq_get_byname(fwnode, "tx");
>>>> Smatch detects that tx_data->irq and rx_data->irq are of type
>>>> u32(unsigned) so they can never be negative.
>>>>
>>>>> +    if (tx_data->irq < 0) {
>>>>               ^^^^^^^^ This can never be true.
>>>>
>>>> Should irq be of type 'int' instead?
>>>>
>>>>> +        dev_err(&pdev->dev, "dma tx irq invalid\n");
>>>>> +        return tx_data->irq;
>>>>> +    }
>>>>> +
>>>>> +    rx_data->irq = fwnode_irq_get_byname(fwnode, "rx");
>>>>> +    if (rx_data->irq < 0) {
>>>>               ^^^ Same problem here.
>>>>
>>>> Should irq
>>> Should 'irq' be of type int instead?
>>>
>>> As fwnode_irq_get_byname() returns a integer.
>>>
>> Yes, you are right. I will add a patch to fix the type of 'irq' to int.
> Run smatch and sparse on your code before posting. It would find such
> trivial mistakes.

Thanks, got it.

Thanks,
Yingkun

>
> Best regards,
> Krzysztof

