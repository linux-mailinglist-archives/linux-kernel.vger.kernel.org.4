Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D779C5F7441
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJGGeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGGe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:34:27 -0400
X-Greylist: delayed 272 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Oct 2022 23:34:26 PDT
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28997112A95;
        Thu,  6 Oct 2022 23:34:25 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.16.48])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 939F12430FC;
        Fri,  7 Oct 2022 06:34:24 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 7 Oct
 2022 08:34:24 +0200
Message-ID: <6d3d2dfd-4d44-c91a-2145-bae624926259@traphandler.com>
Date:   Fri, 7 Oct 2022 08:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v3 4/4] leds: Add a multicolor LED driver to group
 monochromatic LEDs
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <johan+linaro@kernel.org>,
        <marijn.suijten@somainline.org>, <bjorn.andersson@linaro.org>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sha@pengutronix.de>
References: <20220917081339.3354075-1-jjhiblot@traphandler.com>
 <20220917081339.3354075-5-jjhiblot@traphandler.com>
 <CAHp75VeAnJQt7kS8UE+OKcqnScYnmHnVvL+QNW6jR=yF0=oMAA@mail.gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAHp75VeAnJQt7kS8UE+OKcqnScYnmHnVvL+QNW6jR=yF0=oMAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG8EX2.emp2.local (172.16.2.82) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 14443044004980013335
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiiedguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpedvfeekudegkeeuuedvueeuveejffdtvdethfelkefhfefftdetteffiefgvddtieenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshhhrgesphgvnhhguhhtrhhonhhigidruggvpdfovfetjfhoshhtpehmoheftddtge
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/09/2022 10:37, Andy Shevchenko wrote:
> On Sat, Sep 17, 2022 at 11:14 AM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>> By allowing to group multiple monochrome LED into multicolor LEDs,
>> all involved LEDs can be controlled in-sync. This enables using effects
>> using triggers, etc.
> ...
>
>> +config LEDS_GRP_MULTICOLOR
>> +       tristate "Multi-color LED grouping support"
>> +       help
>> +         This option enables support for monochrome LEDs that are
>> +         grouped into multicolor LEDs.
> What will be the module name in case of "m" choice?
>
> ...
>
>> +       struct led_mcg_priv *priv =
>> +               container_of(mc_cdev, struct led_mcg_priv, mc_cdev);
> One line?
>
> ...
>
>> +               /*
>> +                * Scale the intensity according the max brightness of the
>> +                * monochromatic LED
> Usually we put a grammar period at the end of sentences in multi-line comments.
>
>> +                */
> ...
>
>> +               actual_led_brightness = DIV_ROUND_CLOSEST(
>> +                       mono->max_brightness * mc_cdev->subled_info[i].brightness,
>> +                       mc_cdev->led_cdev.max_brightness);
> Can you fix an indentation, so it won't leave the line ending by open
> parenthesis? I believe with the help of a temporary variable it can be
> easily achieved.
Could be done but I have no good name for the variable and I think it 
would just make things harder to understand. In that form I think it is 
clear that this is a cross-multiplication.
>
> ...
>
>> +       for (;;) {
>> +               struct led_classdev *led_cdev;
>> +               led_cdev = devm_of_led_get(dev, count);
> Why _of_ variant? Please, make this OF independent since it's
> pretending to cover not only OF-based systems.

This is not OF independent. It could be, but that will wait until 
someone needs it. I don't know much about ACPI and have no hardware to 
test it on.

I'll add the missing  dependency on OF in the Kconfig.

>
>
>> +               if (IS_ERR(led_cdev)) {
>> +                       /* Reached the end of the list ? */
>> +                       if (PTR_ERR(led_cdev) == -ENOENT)
>> +                               break;
> Looks like the above needs an _optional() variant
>
>> +                       return dev_err_probe(dev, PTR_ERR(led_cdev),
>> +                                            "Unable to get led #%d", count);
>> +               }
> ...
>
>> +               priv->monochromatics = devm_krealloc(dev, priv->monochromatics,
>> +                                       count * sizeof(*priv->monochromatics),
>> +                                       GFP_KERNEL);
> This needs at minimum to use one of the helpers from overflow.h,
> ideally you may implement devm_krealloc_array() as a suitable wrapper
> for that.
>
>> +               if (!priv->monochromatics)
>> +                       return -ENOMEM;
> ...
>
>> +       subled = devm_kzalloc(dev, count * sizeof(*subled), GFP_KERNEL);
> NIH devm_kcalloc()
>
>> +       if (!subled)
>> +               return -ENOMEM;
> --
> With Best Regards,
> Andy Shevchenko
