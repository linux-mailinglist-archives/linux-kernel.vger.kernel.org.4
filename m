Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD6C5F7444
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJGGfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGGfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:35:38 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD31A7A99;
        Thu,  6 Oct 2022 23:35:37 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.143.204])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 9E07624355F;
        Fri,  7 Oct 2022 06:29:50 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 7 Oct
 2022 08:29:50 +0200
Message-ID: <8da42ae5-2fc4-0a63-56d2-6e09dcb669a9@traphandler.com>
Date:   Fri, 7 Oct 2022 08:29:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: Re: [RESEND PATCH v3 2/4] leds: class: store the color index in
 struct led_classdev
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <johan+linaro@kernel.org>,
        <marijn.suijten@somainline.org>, <bjorn.andersson@linaro.org>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sha@pengutronix.de>
References: <20220917081339.3354075-1-jjhiblot@traphandler.com>
 <20220917081339.3354075-3-jjhiblot@traphandler.com>
 <CAHp75VdpizVEuWeOpzgizbYRy74b2c7Egx7Qwna=by6rW5Zo1Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHp75VdpizVEuWeOpzgizbYRy74b2c7Egx7Qwna=by6rW5Zo1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG8EX2.emp2.local (172.16.2.82) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 14366201339191703831
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiiedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfhuffvvehfjggtgfhisehtjeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeeiuddufeelvdevudeghfejueegudffueeliedvkedthfevjeegheduieeuudffkeenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshhhrgesphgvnhhguhhtrhhonhhigidruggvpdfovfetjfhoshhtpehmoheftddtge
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/09/2022 10:40, Andy Shevchenko wrote:
> On Sat, Sep 17, 2022 at 11:14 AM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>> This information might be useful for more than only deriving the led's
> ...
>
>> +                       if (fwnode_property_present(init_data->fwnode, "color"))
>> +                               fwnode_property_read_u32(init_data->fwnode, "color",
>> +                                                        &led_cdev->color);
> Is it already described in the schema?

Hello Andy,


thanks for the reviews on the patch, and sorry for the delay in my 
responses.

Yes. This is already part of the schema.
> ...
>
>>          unsigned int brightness;
>>          unsigned int max_brightness;
>> +       unsigned int color;
> The above two are exposed via sysfs, do you need to expose a new one
> as well? (Just a question, I am not taking any side here, want to hear
> explanation of the either choice)

I didn't really think about it because I didn't need it.

It probably doesn't hurt to expose t in the sysfs. I'll add this in the 
next round.

>
