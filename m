Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0271D6B3B97
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCJKBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjCJKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:01:40 -0500
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368DC10974F;
        Fri, 10 Mar 2023 02:01:39 -0800 (PST)
Received: from [IPV6:2001:250:4000:5122:1445:2b8c:756a:57dd] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32AA0q3B020092-32AA0q3C020092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 10 Mar 2023 18:00:54 +0800
Message-ID: <2c5bac7f-737e-cfcf-a34c-21b2b4ba651b@hust.edu.cn>
Date:   Fri, 10 Mar 2023 17:58:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drivers: iio: remove dead code in at91_adc_probe
Content-Language: en-US
To:     Claudiu.Beznea@microchip.com
Cc:     chengziqiu@hust.edu.cn, eugen.hristev@collabora.com,
        jic23@kernel.org, lars@metafoo.de, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230309150502.400312-1-chengziqiu@hust.edu.cn>
 <cc97cfe5-e90a-d901-147a-2bb829a4409d@microchip.com>
 <774cfa3a.25898.186cae584b7.Coremail.dzm91@hust.edu.cn>
 <9b4ff6bf-3ba3-10bd-f766-c1e8cb34a111@microchip.com>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <9b4ff6bf-3ba3-10bd-f766-c1e8cb34a111@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/23 17:55, Claudiu.Beznea@microchip.com wrote:
> On 10.03.2023 11:41, 慕冬亮 wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>>> -----原始邮件-----
>>> 发件人: Claudiu.Beznea@microchip.com
>>> 发送时间: 2023-03-10 17:14:56 (星期五)
>>> 收件人: chengziqiu@hust.edu.cn, eugen.hristev@collabora.com, jic23@kernel.org, lars@metafoo.de, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com
>>> 抄送: dzm91@hust.edu.cn, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
>>> 主题: Re: [PATCH] drivers: iio: remove dead code in at91_adc_probe
>>>
>>> On 09.03.2023 17:05, Cheng Ziqiu wrote:
>>>> >From the comment of platform_get_irq, it only returns non-zero IRQ
>>>> number and negative error number, other than zero.
>>>>
>>>> Fix this by removing the if condition.
>>>>
>>>> Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
>>>
>>> I see From and 1st SoB matches but
>>>
>>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>>>
>>> this SoB seems extra. What is the contribution of Dongliang Mu to this patch?
>>
>> I reviewed this patch locally since this student is the first time to submit patch to the kernel mailing list.
> 
> Then please use "Reviewed-by" tag.

Sure. I will ask him to send a v2 patch.

> 
>>
>> In my lab, I encourage all students to fix kernel issues. However, their patches should be reviewed by me first before sending the mailing list.
>>
>>>
>>>> ---
>>>>   drivers/iio/adc/at91-sama5d2_adc.c | 6 +-----
>>>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
>>>> index 50d02e5fc6fc..168399092590 100644
>>>> --- a/drivers/iio/adc/at91-sama5d2_adc.c
>>>> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
>>>> @@ -2400,12 +2400,8 @@ static int at91_adc_probe(struct platform_device *pdev)
>>>>          st->dma_st.phys_addr = res->start;
>>>>
>>>>          st->irq = platform_get_irq(pdev, 0);
>>>> -       if (st->irq <= 0) {
>>>> -               if (!st->irq)
>>>> -                       st->irq = -ENXIO;
>>>> -
>>>> +       if (st->irq < 0)
>>>>                  return st->irq;
>>>> -       }
>>>>
>>>>          st->per_clk = devm_clk_get(&pdev->dev, "adc_clk");
>>>>          if (IS_ERR(st->per_clk))
>>>> --
>>>> 2.34.1
>>>>
>>>
>>
>>
>> --
>> Best regards,
>> Dongliang Mu
> 
