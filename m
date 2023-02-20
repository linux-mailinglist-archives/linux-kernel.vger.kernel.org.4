Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FEF69D5C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 22:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjBTV2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 16:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjBTV2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:28:36 -0500
X-Greylist: delayed 602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 13:28:32 PST
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E9AA25E;
        Mon, 20 Feb 2023 13:28:32 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.109.146.39])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4E0F4222A0;
        Mon, 20 Feb 2023 21:10:21 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 20 Feb
 2023 22:10:20 +0100
Message-ID: <4994ad51-7820-538a-723d-97cb17362b34@traphandler.com>
Date:   Mon, 20 Feb 2023 22:10:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 0/6] Add a multicolor LED driver for groups of
 monochromatic LEDs
To:     Lee Jones <lee@kernel.org>
CC:     <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <johan+linaro@kernel.org>,
        <marijn.suijten@somainline.org>, <andy.shevchenko@gmail.com>,
        <jacek.anaszewski@gmail.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230102081021.138648-1-jjhiblot@traphandler.com>
 <Y7xMogUbXCFktH65@google.com>
Content-Language: en-US
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <Y7xMogUbXCFktH65@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG8EX2.emp2.local (172.16.2.82) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 16266157430938679771
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudejhedgudegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthekredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepvdefkedugeekueeuvdeuueevjefftddvtefhleekhfefffdtteetffeigfdvtdeinecukfhppeduvdejrddtrddtrddupdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdpphgrvhgvlhesuhgtfidrtgiipdhrohgshhdoughtsehkvghrnhgvlhdrohhrghdpshhvvghnrdhstghhfigvrhhmvghrseguihhsrhhuphhtihhvvgdqthgvtghhnhholhhoghhivghsrdgtohhmpdhkrhiihihsiihtohhfrdhkohiilhhofihskhhiodgutheslhhinhgrrhhordhorhhgpdhjohhhrghnodhlihhnrghroheskhgvrhhnvghlrdhorhhgpdhmrghrihhjnhdrshhuihhjthgvnhesshhomhgrihhnlhhinh
 gvrdhorhhgpdgrnhguhidrshhhvghvtghhvghnkhhosehgmhgrihhlrdgtohhmpdhjrggtvghkrdgrnhgrshiivgifshhkihesghhmrghilhdrtghomhdplhhinhhugidqlhgvughssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehvdekpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Would you be kind enough and have a look at this series ? It may not be 
the prettiest series of all,  but the feature make senses as it provides 
an atomic way of handling color leds from user space.

Any feedback would be appreciated.

Thanks,

Jean-Jacques


On 09/01/2023 18:19, Lee Jones wrote:
> On Mon, 02 Jan 2023, Jean-Jacques Hiblot wrote:
>> Some HW design implement multicolor LEDs with several monochromatic LEDs.
>> Grouping the monochromatic LEDs allows to configure them in sync and use
>> the triggers.
>> The PWM multicolor LED driver implements such grouping but only for
>> PWM-based LEDs. As this feature is also desirable for the other types of
>> LEDs, this series implements it for any kind of LED device.
> Another for Pavel.
>   
>> changes v6->v7:
>>   - in led_mcg_probe() increment the counter at the end of the loop for
>>     clarity.
>>
>> changes v5->v6:
>>   - restore sysfs access to the leds when the device is removed
>>
>> changes v4->v5:
>>   - Use "depends on COMPILE_TEST || OF" in Kconfig to indicate that OF
>>     is a functional requirement, not just a requirement for the
>>     compilation.
>>   - in led_mcg_probe() check if devm_of_led_get_optional() returns an
>>     error before testing for the end of the list.
>>   - use sysfs_emit() instead of sprintf() in color_show().
>>   - some grammar fixes in the comments and the commit logs.
>>
>> changes v2->v3, only minor changes:
>>   - rephrased the Kconfig descritpion
>>   - make the sysfs interface of underlying LEDs read-only only if the probe
>>     is successful.
>>   - sanitize the header files
>>   - removed the useless call to dev_set_drvdata()
>>   - use dev_fwnode() to get the fwnode to the device.
>>
>> changes v1->v2:
>>   - Followed Rob Herrings's suggestion to make the dt binding much simpler.
>>   - Added a patch to store the color property of a LED in its class
>>     structure (struct led_classdev).
>>
>>
>> Jean-Jacques Hiblot (6):
>>    devres: provide devm_krealloc_array()
>>    leds: class: simplify the implementation of devm_of_led_get()
>>    leds: provide devm_of_led_get_optional()
>>    leds: class: store the color index in struct led_classdev
>>    dt-bindings: leds: Add binding for a multicolor group of LEDs
>>    leds: Add a multicolor LED driver to group monochromatic LEDs
>>
>>   Documentation/ABI/testing/sysfs-class-led     |   9 +
>>   .../bindings/leds/leds-group-multicolor.yaml  |  64 +++++++
>>   drivers/leds/led-class.c                      |  65 +++++--
>>   drivers/leds/rgb/Kconfig                      |  10 ++
>>   drivers/leds/rgb/Makefile                     |   1 +
>>   drivers/leds/rgb/leds-group-multicolor.c      | 166 ++++++++++++++++++
>>   include/linux/device.h                        |  13 ++
>>   include/linux/leds.h                          |   3 +
>>   8 files changed, 317 insertions(+), 14 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
>>   create mode 100644 drivers/leds/rgb/leds-group-multicolor.c
>>
>> -- 
>> 2.25.1
>>
