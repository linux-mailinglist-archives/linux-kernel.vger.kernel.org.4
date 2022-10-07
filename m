Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E398B5F77D2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJGMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 08:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJGMDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:03:41 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785A3D0CDF;
        Fri,  7 Oct 2022 05:03:40 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.16.207])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id DE4DA243ABA;
        Fri,  7 Oct 2022 12:03:38 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 7 Oct
 2022 14:03:38 +0200
Message-ID: <60fcb1ba-f5d4-deaf-d251-7d8c127c353b@traphandler.com>
Date:   Fri, 7 Oct 2022 14:03:37 +0200
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
 <6d3d2dfd-4d44-c91a-2145-bae624926259@traphandler.com>
 <CAHp75VePiAs_qz2fxAheoGbq4wk39x5uoVUKZdbN254RDevgsQ@mail.gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAHp75VePiAs_qz2fxAheoGbq4wk39x5uoVUKZdbN254RDevgsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG2EX2.emp2.local (172.16.2.12) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 1556838100135524631
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeijedggeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepieejfedukeevudfghfetudevhffhhfekjeeiudegtdehueevgfdvgeeivdeifedvnecukfhppedtrddtrddtrddtpdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehshhgrsehpvghnghhuthhrohhnihigrdguvgdpoffvtefjohhsthepmhhofedttdeg
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/10/2022 10:53, Andy Shevchenko wrote:
> On Fri, Oct 7, 2022 at 9:34 AM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>> On 17/09/2022 10:37, Andy Shevchenko wrote:
>>> On Sat, Sep 17, 2022 at 11:14 AM Jean-Jacques Hiblot
>>> <jjhiblot@traphandler.com> wrote:
> ...
>
>>>> +               led_cdev = devm_of_led_get(dev, count);
>>> Why _of_ variant? Please, make this OF independent since it's
>>> pretending to cover not only OF-based systems.
>> This is not OF independent. It could be, but that will wait until
>> someone needs it. I don't know much about ACPI and have no hardware to
>> test it on.
>>
>> I'll add the missing  dependency on OF in the Kconfig.
> No, please consider getting rid of OF-centric API usage.

The trouble is that the OF-agnostic API for leds doesn't exist yet and I 
don't really want to add it without any way to test it.

>
> ...
>
> I'm not sure why you left a lot of context in the reply without
> commenting or replying to it.
>
