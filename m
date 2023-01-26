Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259E567D086
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjAZPoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjAZPn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:43:58 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E698C1BC4;
        Thu, 26 Jan 2023 07:43:56 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DB5533200034;
        Thu, 26 Jan 2023 10:43:55 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 10:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674747835; x=1674834235; bh=I/B5dP9013
        /K6fiR+pC7UB5Kl3NMJOpwta5npDBU8Nw=; b=Fu91i5eJPMXWw69oHqyv7MxBY8
        FywQeNBBn7zl7TY07AmorifK7QrhgOL4D7iKY0KLATdIaZuEMamQEcVgK+VUlscH
        2U+pHfxKh3p4pyhyyidwHgZLRNDZXkHb6Vqy3gzMuxMXleoVn6aFF9gcc3FTUWi1
        RnlEOdE5SdLahH9rjyg3PDWNbK3a0bLC5wcTF3BonpV+n3QU//zmU1iIN/Lo3VXB
        OP1e/CZn/gtz6szquA9tI9jDSgwiAhoE+mBjyY/o7f7zsf9g78K2p8D/WTE29W4t
        ZprbGkCD6ofpkxAEQnf7g7Shhgfk9w/YHLv/wdVrdUkxp3874XLCkJkOgiHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674747835; x=1674834235; bh=I/B5dP9013/K6fiR+pC7UB5Kl3NM
        JOpwta5npDBU8Nw=; b=AD++yNlDt6U8pXJY2V0WSEldxaGITObIFXsHmqeFEq6b
        S2K3P8vPrep7LyoqF4bG4lMDK3nS63hao48yjaNmPJ3J1vmVxpIMk94rCZ4Oo/No
        BvvQnbYrowEp7FEIAtRR/lEzZNZG5CG9aBw4fQlSDL5MhLC2S+ZbMHn0dOC86fRC
        7I1P2o+jq/bNoar4H4TWFRJrQZm1d2ZszMfbO0KVmDEoqaq5qPWOLZuzojHHVZGu
        k2VGbzCvxXqwdXW5vDX6/HIvfm72Z6J5quLQYr8yPQz9LbSpnsaNMjxyKkTXPtBy
        iRk8n4ty3Stikp/7z7e+hKOUbQgY6w2WQIngX1avSw==
X-ME-Sender: <xms:u5_SY8crqJnPXrXkXob4DqwDguF9TttzarwztdlEZd_xP4ZBLTS3ng>
    <xme:u5_SY-OJWbk-E3qNpwK-eR4THKxxytRaCoQ-_c7PfHaa3Vt3aS1j8EPhMF6TT3esh
    4eELPiUv4U_aY9GU2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:u5_SY9j_pUtZvjigBiMgRfvJlmduhxX-okmJXBtIZsMBdMxx1fGHNg>
    <xmx:u5_SYx9rjckvmqvd8AnTpI6ZWBYqH4OIpEcsbgC4V5_9cLKyPFXiyw>
    <xmx:u5_SY4s6TL6jN1_o9lvXAd_Zw6O9w05PMo92P-0-YVPPb1hLWlpE6Q>
    <xmx:u5_SYyUieqvTjWjWFotxvIGG5jj7n_oUQfsM2dVfzkGz78fW_Fn0Qg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 51987B60086; Thu, 26 Jan 2023 10:43:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <a717fec9-db2b-47fb-813d-e734e26e51c0@app.fastmail.com>
In-Reply-To: <Y9KELwugMhV1TCiK@smile.fi.intel.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-4-arnd@kernel.org>
 <Y9KELwugMhV1TCiK@smile.fi.intel.com>
Date:   Thu, 26 Jan 2023 16:43:35 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] gpiolib: remove asm-generic/gpio.h
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023, at 14:46, Andy Shevchenko wrote:
> On Thu, Jan 26, 2023 at 02:27:56PM +0100, Arnd Bergmann wrote:

>> --- a/drivers/gpio/gpio-davinci.c
>> +++ b/drivers/gpio/gpio-davinci.c
>> @@ -7,6 +7,7 @@
>>   */
>
>>  #include <linux/gpio/driver.h>
>
>
>> +#include <linux/gpio.h>
>
> I believe the driver does not need this.
>
> I have briefly checked all gpio_ places in it and found nothing that requires
> this inclusion to be done.

ok
  
>>  #ifdef CONFIG_GPIOLIB
>>  #include "../gpio/gpiolib.h"
>> -#include <asm-generic/gpio.h>
>> +#include <linux/gpio.h>
>
> Can we actually swap them?
>
> #include <linux/gpio.h>
> #include "../gpio/gpiolib.h"
>
> But hold on, why do we even need gpio.h here?!
>
>>  #endif
>>  
>>  #include "core.h"
>
> ...

I probably did all the above in response to build regressions,
but I'll try to change them based on your suggestion and see
what happens.

>> --- a/include/linux/gpio.h
>> +++ b/include/linux/gpio.h
>> @@ -54,26 +54,101 @@ struct gpio {
>>  };
>>  
>>  #ifdef CONFIG_GPIOLIB
>> -#include <asm-generic/gpio.h>
>> +#include <linux/compiler.h>
>
>> +#include <linux/gpio/driver.h>
>> +#include <linux/gpio/consumer.h>
>
> #include <linux/gpio/consumer.h>
> #include <linux/gpio/driver.h>
>

Done

>> +/*
>> + * "valid" GPIO numbers are nonnegative and may be passed to
>> + * setup routines like gpio_request().  only some valid numbers
>
> While at it, '.  only' --> '. Only'.

Done

>> + * can successfully be requested and used.
>> + *
>> + * Invalid GPIO numbers are useful for indicating no-such-GPIO in
>> + * platform data and other tables.
>> + */
>
> ...
>
>> +extern int gpio_request(unsigned gpio, const char *label);
>> +extern void gpio_free(unsigned gpio);
>
> While at it, s/extern//.

>> +extern int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
>> +extern int gpio_request_array(const struct gpio *array, size_t num);
>> +extern void gpio_free_array(const struct gpio *array, size_t num);

Done

Thanks for the review,

       Arnd
