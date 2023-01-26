Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D2C67CED7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjAZOvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAZOvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:51:43 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B840E3C3D;
        Thu, 26 Jan 2023 06:51:42 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B5A933200927;
        Thu, 26 Jan 2023 09:51:41 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 09:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674744701; x=1674831101; bh=fp8XG8ujSp
        BTUo0gvG07eg1nSLzR3qG3Vf+yqNSrM64=; b=u8ZXKGwFIV3GRy5HcDIrBBe5uo
        qxngDC3z5EOMah3s3OQb8h+tQET1qM9+ti6sdsFrLGVE50O6/izze0AE4raPxq5n
        hU6A5li03/xI15nfSBMHevkLIrw4AaoQzhvnk1f+7YDqZqjDQCcI79wodqOrdzVm
        McV1W3uKA2UMj4zDFEHkvhCbJFP901RaGLmAmlc9TSb5unfJ4OukWgKsOgtVPYvj
        eah3Dz16Tj6wkgGvPpxpvgVDrwX9lNVzrt9QrtoiAndhw3vj9/jYhYpcu5xvLQTg
        nyP7ql0/PLTUlsXlf7NkmFg2MSpliBV4OMDHSbgJjzsf7a0ecRD+ODCXpMRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674744701; x=1674831101; bh=fp8XG8ujSpBTUo0gvG07eg1nSLzR
        3qG3Vf+yqNSrM64=; b=hLHGwF2HWE1qc3yhSfawZyB6Fgrz0L+l0iSURq2wEg8H
        x32mjaiUoCQiT35Y3NFl+XzmJjg3ICV/m9yKcPhhY7/ezAu17Q+pfsCJPxJLzT85
        dZX6MwJef4UNUVWodUMdGQXQrshzg8dYtDJmuNaS1qTk/KCcr27RtLgU3UDaQ0SI
        8sCJZ0k5RN7qO3G+6kteTU8guA7PRmoiMI2MJjjH7Bz3vbuG/9wIOKGE5B8aslxn
        afTSHNlx5Y872Y3jPSjbHW/1hUkzirkSFg2yusv2B4bergdHQX4qyb8g+DVs+URq
        2Ze4Ezs+4YrpazzALXXUc1BoYSTMI2SaITj++xuoFQ==
X-ME-Sender: <xms:fZPSY4h8SfK1gkKAFPI5nbjn5ZT9BwF3YeyPIjQcoH57kiBmBUZ8Xg>
    <xme:fZPSYxBSgjSjJRFLWrKiC2RYAj3Tz3Fo2uw_ONaqc7nlnTqSaJlp0Komdoi8Pp7ul
    eSk0Fl-meTg7W3jweQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:fZPSYwGpV-_Pu-WrrOR_ghfIkPzBg0qJOCq0-saytHP7gL_lJw7BSQ>
    <xmx:fZPSY5RH-ZlxFbBcmxeMzWA4gXKZ3yoZDEuEX1Tp7Ap8XRRt30uiDw>
    <xmx:fZPSY1w2Jha4WVanZJnBfv7buoul5XTtJOfTlGRnXB0rPezkcmx2hg>
    <xmx:fZPSY4pk1gQHybv4IdQGcsIsXStWDyNVLBPVJuu1EoN5wmsY_X_MZg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 004F0B60086; Thu, 26 Jan 2023 09:51:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <ba57a2f1-f14a-4f92-b6f2-22f92c8d3de5@app.fastmail.com>
In-Reply-To: <Y9KIeXq866C+VKV+@smile.fi.intel.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-7-arnd@kernel.org>
 <Y9KIeXq866C+VKV+@smile.fi.intel.com>
Date:   Thu, 26 Jan 2023 15:51:21 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] gpiolib: split linux/gpio/driver.h out of linux/gpio.h
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023, at 15:04, Andy Shevchenko wrote:
> On Thu, Jan 26, 2023 at 02:27:59PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Almost all gpio drivers include linux/gpio/driver.h, and other
>> files should not rely on includes from this header.
>> 
>> Remove the indirect include from here and include the correct
>> headers directly from where they are used.
>
> Some minor nit-picks below, otherwise
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
>> +#include <linux/of.h>
>
> Taking the limited context into account, I think this makes more sense to be
> placed before platform_device.h as to keep longer _sorted_ chain.
>
>>  #include <linux/gpio/gpio-reg.h>
>>  #include <linux/gpio/machine.h>
>> +#include <linux/gpio/driver.h>
>
> Similar. Keep it more sorted.
>

>> +#include <linux/gpio/driver.h>
>>  #include <linux/gpio.h>
>
> Here is the opposite ordering to the above similar cases. Swap?

Changed all as suggested, thanks!

     Arnd
