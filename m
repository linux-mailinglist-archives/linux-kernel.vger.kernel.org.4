Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE26F6A6A14
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCAJxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCAJxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:53:09 -0500
X-Greylist: delayed 846 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Mar 2023 01:53:07 PST
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DE63C01
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 01:53:07 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.108.16.78])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 760CB243F90;
        Wed,  1 Mar 2023 09:29:20 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 1 Mar
 2023 10:29:19 +0100
Message-ID: <e335b715-471c-8e25-8eea-95ca1f64d17c@traphandler.com>
Date:   Wed, 1 Mar 2023 10:29:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] of: property: Add missing of_node_get() in
 parse_interrupt()
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>
CC:     <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>
References: <20230228174019.4004581-1-jjhiblot@traphandler.com>
 <CAGETcx-w4A3fz_DPqJG+9P6ETGAPv547DcnsO52gqTO1_vijsw@mail.gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAGETcx-w4A3fz_DPqJG+9P6ETGAPv547DcnsO52gqTO1_vijsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG4EX2.emp2.local (172.16.2.32) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 1941051441226463616
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudelgedguddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpedvfeekudegkeeuuedvueeuveejffdtvdethfelkefhfefftdetteffiefgvddtieenucfkphepuddvjedrtddrtddruddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmpdhrohgshhdoughtsehkvghrnhgvlhdrohhrghdpfhhrohifrghnugdrlhhishhtsehgmhgrihhlrdgtohhmpdhgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdpuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgriieskhgvrh
 hnvghlrdhorhhgpdfovfetjfhoshhtpehmoheftddtgedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/02/2023 20:07, Saravana Kannan wrote:
> On Tue, Feb 28, 2023 at 9:40 AM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>> From: Jean Jacques Hiblot <jjhiblot@traphandler.com>
>>
>> As all the other parsers do, parse_interrupt() must increase the refcount
>> of the device_node. Otherwise the refcount is decremented every time
>> parse_interrupt() is called on this node, leading to a potential
>> use-after-free.
>>
>> This is a regression introduced by commit f265f06af194 ("of: property:
>> Fix fw_devlink handling of interrupts/interrupts-extended"). The reason is
>> that of_irq_parse_one() does not increase the refcount while the previously
>> used of_irq_find_parent() does.
> Thanks for catching the issue Jean!
>
> This feels like a bug in of_irq_parse_one() to me. It's returning a
> reference to a node without doing a of_node_get() on it.
>
> Rob, Marc, Do you agree?

Sarvana,

it looks like you're right. The bug seems to be in of_irq_parse_one().

It doesn't behave in the same way for "interrupts-extended" where it 
does a get() and 'interrupts" where it doesn't.

So please ignore this patch.

Thanks

>
> Jean,
>
> If they agree, can you please fix of_irq_parse_one() and add a
> of_node_put() to existing callers (if they aren't already doing a
> put()).
>
> Thanks,
> Saravana
>
>> Fixes: f265f06af194 ("of: property: Fix fw_devlink handling of interrupts/interrupts-extended")
>> Signed-off-by: Jean Jacques Hiblot <jjhiblot@traphandler.com>
>> ---
>>   drivers/of/property.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/property.c b/drivers/of/property.c
>> index 134cfc980b70b..1f23bcb765c4e 100644
>> --- a/drivers/of/property.c
>> +++ b/drivers/of/property.c
>> @@ -1380,7 +1380,10 @@ static struct device_node *parse_interrupts(struct device_node *np,
>>              strcmp(prop_name, "interrupts-extended"))
>>                  return NULL;
>>
>> -       return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.np;
>> +       if (of_irq_parse_one(np, index, &sup_args))
>> +               return NULL;
>> +
>> +       return of_node_get(sup_args.np);
>>   }
>>
>>   static const struct supplier_bindings of_supplier_bindings[] = {
>> --
>> 2.25.1
>>
