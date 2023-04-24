Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD66EC844
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjDXJDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjDXJDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:03:46 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2046.outbound.protection.outlook.com [40.92.107.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A685E70;
        Mon, 24 Apr 2023 02:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjwiOOcSckvPuHaTkjH+DrVP5xEhJSRdil4Gv1A7hNBs9wQj2xts4GAIsSGP7eF6cbAEBoo3DrwzUAzmg4NQhene0NBbDPeIZjYlZfFW1lyuCsBCKpryH7w4KPbaoANwGhEvCZYcq14flRY8YOYuw9uAYImk5TBXD4IkSN15Z0kRBpsN5IpIcNqZYoKx++PJ+bUsos/ND3kSNw9EZu8Q/zvTCtRpeH9OqLEg4bn0BdlIMQhMaAMssipnuHwS7o0IOlWsxf7F2XvBmbTVpCwC2psNoC6PCUGCnndfJj0Uwn9dUfAuNt623DyDBzWzhXUrksYmI+C5xBn05KJW8koOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V5YkCq07Eoap8IF14JiOBdf6jMJm/tRF8zPYKV9N5s=;
 b=auGD5XtY1hVCDcZFciMyCyw+KccTE+dJ7PQGsEgeIbDebuaVqBBbgMXa4HI0uaw2jeCpCauxNczVJ1yZsWKRYUZylWG+7vglS0CtwedQh77qip17EmTEpneQnPszGU/QRbCEaQyoB6n/LQRy6ocfTYakE5G54WDN+TbLA4JZUL4lcNm63q+QvJo4+9/Za7pQV88OJ+lFyoSdY5gqwKt/0ImabZyLMz3GQE8+14q++WwcOjXPA77CV11G9G0Dc9y9egVNKzErqtMWcZXzQ1IkHyrsQ/9V+Kg1xJ64OOS2y1zDdGFQJDtJMgkWbnak8iJcE5EFUFKt0rpRxg5jxIWfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V5YkCq07Eoap8IF14JiOBdf6jMJm/tRF8zPYKV9N5s=;
 b=kSxB9aDFt4E+ArXsUrkZU/658ub1i1NoX8OINwk8B03nLd2mb1lhZ8295zxf2+MpZ3kaho67JLyIg4g1oMw3kp0ys7faLSNnr+50eqKXuF2KfFEfuKRFFByGKIW8mbT+KrnH0yEk5Mgyaq11pSvOEulzocaUsoCu9O0OvUhWutW8Oa2kAwglgxA4xcUF2xpYHOBv7UWsAVCI4EJ56Whi4nVQ5PDIxKhDYJ7ISE/aWLoxNX12Iesrv9Ker9JcNKcY1lzq+wmB009PS2CiejcV43IXbeMacvS5cLt/SvMUWF7nNxqXtMTJYCeo697u4aNqL1OegSOmVlOVYtMus9SUKA==
Received: from TY0PR01MB5444.apcprd01.prod.exchangelabs.com
 (2603:1096:400:32b::13) by SI2PR01MB4298.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1ad::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.18; Mon, 24 Apr
 2023 09:03:39 +0000
Received: from TY0PR01MB5444.apcprd01.prod.exchangelabs.com
 ([fe80::148b:e407:c208:c84c]) by TY0PR01MB5444.apcprd01.prod.exchangelabs.com
 ([fe80::148b:e407:c208:c84c%3]) with mapi id 15.20.6340.019; Mon, 24 Apr 2023
 09:03:39 +0000
Message-ID: <TY0PR01MB5444D02ECB86488FDB9C6B6AE6679@TY0PR01MB5444.apcprd01.prod.exchangelabs.com>
Date:   Mon, 24 Apr 2023 17:03:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] gpio: mmio: restroe get multiple gpio mask
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     brgl@bgdev.pl, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <KL1PR01MB544800D7E51C9209A9BD998BE6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
 <CACRpkdZ8CVWb6=-sgK3BdW-ssivY1oz4cc_mYoXmyrBMLxsX=A@mail.gmail.com>
From:   Yan Wang <rk.code@outlook.com>
In-Reply-To: <CACRpkdZ8CVWb6=-sgK3BdW-ssivY1oz4cc_mYoXmyrBMLxsX=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [LrBPOAST73hlVsQqBSjWzKM0WpcIPtZqugFKzUMg0LA=]
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To TY0PR01MB5444.apcprd01.prod.exchangelabs.com
 (2603:1096:400:32b::13)
X-Microsoft-Original-Message-ID: <3489c2a7-402c-e59c-97b4-3fd111da96de@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR01MB5444:EE_|SI2PR01MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b1d78a-2044-493e-e5ce-08db44a2cb82
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTvKnZU+UWpjob+cOPFG9jWzSRMz1Qz7Uo6Yr9A8k1ks3uVx56h6Ohx1/MIG+8K1VK7PFcNRqdODaAm0v2z50ZYEgIKfpkEYoxxdJKbbbuuzIQKrrf9Jsn8DVETKop3AUowB2yHnOxydLHsx1wcy880yH6otoy9j7mec3o3QJsrqb09Ipm1XNA0+POz6l0fe4yQSOmzdLc9+ASSwodquWuiRTc6RNDDVl+3vfUFHx8ZDBJagRI+3Pm5KTp6XbFrzkVeaDNgu42Tuwk6zT3J8y6fTY2dkYcKLnfKN2JmRz1TbnfIB3HpZuQi+F/HABDwC2gueuOc0fXKXM1P9r3dMg5owpPmF1NHcvdIgZ/PYyc/irSsE9GYZ0NLz6cl8EX37RusWv8vUwF/9HtNIZOh2lWcy7hKcrWE5jmU6+C/NFOnHo5lUaTnRJJHXqmCDrnEXJI+oAT2WEvQiE8oRBsl/+OvhGki8hSL1SUsk9Q85tYopHwvGGOiHgSRu5zs6ygjfn32tfeqcaAk7ka2XTVoTSZ6whqUAqJ+oxoVmv3JTBwX0A+0CjC4ZfZQIUStLYLEoJly2ETXS1yc8A18GzlWrJDRxI+pzqtn/aoe0ktnD1LY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTUwTHZ6ZTJscC9xdWV3cXFjZ2ViTTJLVnVjTm9CRWZEb3pKQjVDNGdMNzN2?=
 =?utf-8?B?ZFgwNEgvQmdzTGhEdm5md2o5bzlVdG56bG52b1A2SGFZWXJPVzQwU1RZaXB6?=
 =?utf-8?B?NmNSbUlhbmx2QWI2Y2VCQnhscGsxYkxQOHYxYTVCMXlFbWZCd1JZNE9VNjZ2?=
 =?utf-8?B?cXk2T3F5M2xwd3pyTWprY01JNDFTaEdkb25sclVhZnYzUG5KaUtRL2FWRHVE?=
 =?utf-8?B?TjVSR0F4WXZoNkNWU2YyYThmeitRdld0cTJKTGlabWR2aHhwR2M1MFpGa09y?=
 =?utf-8?B?NVdsN1FyNG5naWdCS0ZFdWN0MXRaaURWN0w4MkN5MjRPMHJ1T05RK1FaNGd6?=
 =?utf-8?B?eVU3ZDNiMmhYTUxiZTVNa3lBSmhqaGY2WjdsaWxZSWtpSC9RaTZqbnNCOFdR?=
 =?utf-8?B?bnBKbWlXNTU3MmpoVmNUdjY5ZS9Mc0UwUGZWQ2dLbVluL1UxRDRmcGZsSVVl?=
 =?utf-8?B?eld1cU1lejZLVUdhTVcyc0U5ZkxTeGp5V2pFWlBMSHRtVWZMZENveXUxV1Mz?=
 =?utf-8?B?L0dVVTNVRGdaOFIvS1U0MUZKVlM1eTRKSHBpcFFmSkRYSnpjSXVlcm1GRjZQ?=
 =?utf-8?B?R1o1Z0RzVWFZeCtsdVBYK0tleGN3b3JmRkxCbVczb2lrRUlYZzVrTWNvZjdJ?=
 =?utf-8?B?TVRhbjUvU1JEL3JpZUlrQmhPOHZHdzJkV3E5OUJVV1U4WXdBTThBTGhMZDZv?=
 =?utf-8?B?MnRaMyt6NEtnNlBkVFlhUVRDU0RmRlY4aXU1ZWd5UW5BNitUSmxia21idDcx?=
 =?utf-8?B?UmRiTDV0NlRkVGQvaXByNytURE9oZW16QzBmNHRyYmlweWd2UmdEOEFjUCs3?=
 =?utf-8?B?MXdud3JvRlhxMWNOTWVCekhobzdCbktoTFJJeUVlRUxqTWorUTJPa1hReTFH?=
 =?utf-8?B?cmcxUWVDTlJDUXUxMEIraUJuN0tCNjhNRVdpZ2VBZzZHeStvaXBjMnUySkVV?=
 =?utf-8?B?QjBNUzZhNHJhU3lXMFNGTTZYVFcyNGh5dlJLZmlDN0RSdUJyMSswblZ5cGtY?=
 =?utf-8?B?RytodzMrRVdZOVFTWnpmeCs2Z0hZL2FMdWQ2SWo1ZmMvTi9BK0h3UWExTzdu?=
 =?utf-8?B?c2szVFpPRjVUaUZpNWlPam04RmpuQ0o5VHpHZ3ZXai9qRS81MWxTSlF0RE9T?=
 =?utf-8?B?WmJzejJUdkZLNXpzcTJ6c1U5QzhGMzRwZ0xvSlMxQ2hZem5URjlrNkkxUHpu?=
 =?utf-8?B?a2JQZnVTSUtKNEtUdnVPY0JqT21tTGkwZEtFT0diTmVYdFg2bER2cHBTaUZl?=
 =?utf-8?B?YW42bm9NdmZ1VndIT0krc1FIb3FZcDhBZ1cxbGdtdzhJM1BsRnMzcDRwcEdG?=
 =?utf-8?B?VFNuREZZdGZrd3QzVjd4R3lMaFMxaUYwVEVHQTQrbEhyZnVKMHNJUW13RGVM?=
 =?utf-8?B?SnhQanBraXRXQ043MTRJWG84cGt1ZGxpTzhocTQ4YUlDM3g4NzhjNW9IU05l?=
 =?utf-8?B?ek5jb3BsRUFiNG1IZi9YZmRXM3I0cThUVlBJSXNBWEN5R2UwamFIcUFyUjhQ?=
 =?utf-8?B?SXRYbjl2cXZhM2FRYUYrbjJFZXlNOWt4Ly9wSGJoSFBFUTZqQ05ubGRzNHFQ?=
 =?utf-8?B?M1dsNzNEb0NqR2RkK1VUV2FIR0JJOFVGNm9yYVVrMjY3cXFEZmRmdC9hK0Rw?=
 =?utf-8?B?ZS94ZEdYQ3JtMVFxKzFFVUN3RGlpcHc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b1d78a-2044-493e-e5ce-08db44a2cb82
X-MS-Exchange-CrossTenant-AuthSource: TY0PR01MB5444.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 09:03:39.4649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4298
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/2023 2:56 PM, Linus Walleij wrote:
> Hi Yan,
>
> thanks for your patch!
>
> On Sun, Apr 23, 2023 at 11:07 AM Yan Wang <rk.code@outlook.com> wrote:
>
>> Simplify the code,should not modify its logic.
> I don't see how it simplifies the code, it seems to me that it is
> making it more complex?
yes ,it is .
The description is wrong.
>> Fixes: 761b5c30c206 ("gpio: mmio: replace open-coded for_each_set_bit()")
>> Signed-off-by: Yan Wang <rk.code@outlook.com>
>> ---
>>   drivers/gpio/gpio-mmio.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
>> index d9dff3dc92ae..c2347ef3a4df 100644
>> --- a/drivers/gpio/gpio-mmio.c
>> +++ b/drivers/gpio/gpio-mmio.c
>> @@ -271,10 +271,14 @@ static void bgpio_multiple_get_masks(struct gpio_chip *gc,
>>          *clear_mask = 0;
>>
>>          for_each_set_bit(i, mask, gc->bgpio_bits) {
>> -               if (test_bit(i, bits))
>> -                       *set_mask |= bgpio_line2mask(gc, i);
>> -               else
>> -                       *clear_mask |= bgpio_line2mask(gc, i);
>> +               if (*mask == 0)
>> +                       break;
>> +               if (__test_and_clear_bit(i, mask)) {
>> +                       if (test_bit(i, bits))
>> +                               *set_mask |= bgpio_line2mask(gc, i);
>> +                       else
>> +                               *clear_mask |= bgpio_line2mask(gc, i);
>> +               }
> The intention of the change seems to be to break out of the loop
> when all set bits are handled, by successively masking off one
> bit at a time from mask. So this is intended as an optimization,
> not a simplification.
Because my description is wrong and there is a difference in 
understanding between us.
I think using for_each_set_bit() , but the __test_and_clear_bit() should 
not remove.
> I think for_each_set_bit() is already skipping over every bit
> that is zero, see include/linux/find.h.
>
> So this optimization gains us nothing.
this a patch that only restores to original logic.the 
__test_and_clear_bit() clear mask
then get a new set_mask. this logic can affect functions of 
gpiod_set_raw_array_value ().

The effect of this patch is as follows:
gpiod_set_raw_array_value->
     gpiod_set_array_value_complex->
{
     ..
     if (array_info && array_info->desc == desc_array &&
         array_size <= array_info->size &&
         (void *)array_info == desc_array + array_info->size) {
         if (!can_sleep)
             WARN_ON(array_info->chip->can_sleep);

         if (!raw && !bitmap_empty(array_info->invert_mask, array_size))
             bitmap_xor(value_bitmap, value_bitmap,
                    array_info->invert_mask, array_size);

         gpio_chip_set_multiple(array_info->chip, array_info->set_mask,
                        value_bitmap);

         i = find_first_zero_bit(array_info->set_mask, array_size);
         if (i == array_size)
             return 0;
     } else {
         array_info = NULL;
     }

    -> while (i < array_size) {
         struct gpio_chip *gc = desc_array[i]->gdev->chip;
         DECLARE_BITMAP(fastpath_mask, FASTPATH_NGPIO);
         DECLARE_BITMAP(fastpath_bits, FASTPATH_NGPIO);
         unsigned long *mask, *bits;
         int count = 0;

          ..............
         if (count != 0)
             gpio_chip_set_multiple(gc, mask, bits);

         ..............
     }
     return 0;
}

Due to __test_and_clear_bit() clear array_info->set_mask,the i < 
array_size condition holds.
then calculate a new mask based on the GPIO number of the hardware.

I reconfirmed it,Although it works, it should not be modified in the place.
I think have a wrong of gpiod_get_array() and not 
bgpio_multiple_get_masks().

Link: 
https://lore.kernel.org/linux-gpio/KL1PR01MB5448327326B6EDA8001AF714E6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com/

this is a new patch. can you take a look ?

Thank you.
> Yours,
> Linus Walleij

