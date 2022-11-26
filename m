Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50D9639566
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 11:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiKZKkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 05:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKZKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 05:39:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFF16583;
        Sat, 26 Nov 2022 02:39:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8109DB811A3;
        Sat, 26 Nov 2022 10:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2539C433D6;
        Sat, 26 Nov 2022 10:39:53 +0000 (UTC)
Message-ID: <e583b75d-feeb-bb33-1567-e7dde4f04ed7@xs4all.nl>
Date:   Sat, 26 Nov 2022 11:39:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 4/4] media: i2c: s5c73m3: switch to using gpiod API
Content-Language: en-US
From:   Hans Verkuil <hverkuil@xs4all.nl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
 <20221115221145.2550572-4-dmitry.torokhov@gmail.com>
 <CACRpkdbARhDuqSiOZM6GZynHsQWau8JhsEa2zcpsPZSLuD07Kg@mail.gmail.com>
 <e4609919-d9be-33c4-1488-352443523b14@xs4all.nl>
In-Reply-To: <e4609919-d9be-33c4-1488-352443523b14@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2022 11:34, Hans Verkuil wrote:
> Hi Linus,
> 
> On 17/11/2022 10:06, Linus Walleij wrote:
>> On Tue, Nov 15, 2022 at 11:11 PM Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>
>>> This patch switches the driver away from legacy gpio/of_gpio API to
>>> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
>>> make private to gpiolib.
>>>
>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> There are now two patches that do this switch to using the gpiod API:
> this one, and one from you:
> 
> https://patchwork.linuxtv.org/project/linux-media/patch/20221108100604.1500909-1-linus.walleij@linaro.org/

And a third one as well:

https://patchwork.linuxtv.org/project/linux-media/patch/20221116194307.164543-1-mairacanal@riseup.net/

> 
> Any preference?
> 
> Regards,
> 
> 	Hans

