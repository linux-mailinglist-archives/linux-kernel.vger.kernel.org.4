Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9136D8FD7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjDFGzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjDFGzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:55:37 -0400
Received: from 3.mo562.mail-out.ovh.net (3.mo562.mail-out.ovh.net [46.105.33.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1156AD22
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:54:46 -0700 (PDT)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [51.68.80.175])
        by mo562.mail-out.ovh.net (Postfix) with ESMTPS id E3AFC2459D;
        Thu,  6 Apr 2023 06:54:39 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <sven.schwermer@disruptive-technologies.com>; Thu,  6 Apr 2023 06:54:39 +0000 (UTC)
Received: from pro2.mail.ovh.net (unknown [10.109.143.62])
        by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 80CDD201A40;
        Thu,  6 Apr 2023 06:54:39 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Apr
 2023 08:54:38 +0200
Message-ID: <a8a22af2-3d11-bda8-5453-768e2174dc08@traphandler.com>
Date:   Thu, 6 Apr 2023 08:54:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 6/6] leds: Add a multicolor LED driver to group
 monochromatic LEDs
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <lee.jones@linaro.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <johan+linaro@kernel.org>,
        <marijn.suijten@somainline.org>, <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230328161541.599463-1-jjhiblot@traphandler.com>
 <20230328161541.599463-7-jjhiblot@traphandler.com>
 <CAHp75Vca0SKPkyPM_14Zny+Vn0a=hKWRfYW9qzTpN8AVZ_R_YQ@mail.gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAHp75Vca0SKPkyPM_14Zny+Vn0a=hKWRfYW9qzTpN8AVZ_R_YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG1EX2.emp2.local (172.16.2.2) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 7831478280874768859
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejvddgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpedvfeekudegkeeuuedvueeuveejffdtvdethfelkefhfefftdetteffiefgvddtieenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepughirhgvtghtohhruddruggvrhhprdhmrghilhdqohhuthdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqlhgvughssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedv
X-Spam-Status: No, score=-1.4 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/03/2023 19:20, Andy Shevchenko wrote:
> On Tue, Mar 28, 2023 at 7:15 PM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>>
>> Grouping multiple monochrome LEDs into a multicolor LED device has a few
>> benefits over handling the group in user-space:
>> - The state of the LEDs relative to each other is consistent. In other
>>    words, if 2 threads competes to set the LED to green and red, the
>>    end-result cannot be black or yellow.
>> - The multicolor LED as a whole can be driven through the sysfs LED
>>    interface.
> 
> ...
> 
>> +config LEDS_GROUP_MULTICOLOR
>> +       tristate "LEDs group multi-color support"
>> +       depends on OF || COMPILE_TEST
> 
> Why is OF a dependency?
> Can't we make it a firmware provider agnostic solution from day 1?
That would be possible, unfortunately I have no way of testing the ACPI 
stuff. That's why I prefer sticking to OF.

> 
>> +       help
>> +         This option enables support for monochrome LEDs that are
>> +         grouped into multicolor LEDs.
>> +         This useful in the case where LEDs of different colors are
> 
> This is
> 
>> +         physically grouped in a single multi-color LED and driven
>> +         by a controller that doesn't have multi-color support.
>> +
>> +         To compile this driver as a module, choose M here: the module
>> +         will be called leds-group-multicolor.
> 
> ...
> 
>> +               led_cdev = devm_of_led_get_optional(dev, count);
> 
> I don't see how this is OF specific to this driver. Maybe it needs to
> be patched first, so we will have something non-OF specific?
> 
>> +               if (IS_ERR(led_cdev))
>> +                       return dev_err_probe(dev, PTR_ERR(led_cdev), "Unable to get LED #%d",
>> +                                            count);
> 
> At least we need to have a FIXME or so here.
> 
