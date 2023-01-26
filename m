Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD7767D0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjAZQCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjAZQCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:02:41 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2916950C;
        Thu, 26 Jan 2023 08:02:34 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id AF51A32009FF;
        Thu, 26 Jan 2023 11:02:33 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 11:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1674748953; x=
        1674835353; bh=Z/OMzGMz3ivcz8MhruP9c10cSZyjpHW40knT7R98MBE=; b=t
        TMFoONWPPQBE1cMmZrGWOIAxNf/NG4UOw1H12Z2dIWw9DrMhHT+eoCOm7s/cKdqE
        2RsdPBdON2R2CAE0AMtmTen0AYvcsf+lXg8cIjTH3Ekf2BcZK/Qhs6t6vYdHQ5AG
        DNK4K/ExpoG4p0y+t7DKgt0/oi2Q0+m29mGa/tS4AL+k3m3TBQaPNr7kwc+GdTQL
        OfN4bU7VVB3hQ3YLucqB/62yGF3X4fmaOJ00yjc5//TMw3oJpzZIHv6xr5IrZW0Y
        JPsW/oWIPQDNJdjASXaI/E2jKVvxPdZPyEycyR5sicp7R3kJh5XP/ShLYrM0uav/
        0VH1wX8FB0Wj6A3/lZgUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674748953; x=
        1674835353; bh=Z/OMzGMz3ivcz8MhruP9c10cSZyjpHW40knT7R98MBE=; b=J
        zdrYYJ7NTNBRcp+2F71Fb3As3Uw24lvWGGIqJ8sS9kyCgjJ8HkTSaUr5j5YCVWyx
        uk0Fr9sfu+uVjOvdayxS6mm/sAQqhAipigO1gNHtweagI9Sr9VtcU+xhFUWyMdvZ
        V3RvXe6p8L1vio4827g104PATqDiOQjuhpBnn6KkwC/KhtF1agc0u8hklRcptW2b
        XHIKSzsuG2uaQFiMbdkVYgRsHfyd9OKoOmQtQn1iZDUxpfJcFXqB4bvl5dkZfVBw
        OcHIYHBJTAj+mvdYnKbr4y3EUDO2UVdakRKmL8Z8rs3XP3N0xzGuyv0l2kKOWuzv
        /VuP8mRIMZgpN9zh/6uyw==
X-ME-Sender: <xms:F6TSY01YFGNH9WkOEYov4WuP4deodrOgmqiSsI0jazEtn-BDuDWVpg>
    <xme:F6TSY_Hi8OsFYPoOImLQW9NganrWvA0VIDmHg7xsovlCcq9SZ5Q4CJ_sa-AxkgkOG
    bs27OH4YaS19zT3V1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:GKTSY85-AQ1QKcFmxeqTfEwu7L-8x6dJF8e95IQ3v-2__mUWoJcqdw>
    <xmx:GKTSY919W7A6Z3xfe-K13YYd-RP5rKe3ZP9xqpKO-FiKrZsb9wD_DA>
    <xmx:GKTSY3HpCDRxunsOYMwVXOSjRVNdiI-UEWYBRXprAfkiwUUmim9hkg>
    <xmx:GaTSY4MYtvHVuDAxC1FaxYlccD2nyvW642sXinrn6EuRUN8goRUP0w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AAB9CB60086; Thu, 26 Jan 2023 11:02:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <f7aeabe9-59df-4903-af8e-46766af3f64a@app.fastmail.com>
In-Reply-To: <Y9KHcPYPUIjiP3zQ@smile.fi.intel.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-6-arnd@kernel.org>
 <Y9KHcPYPUIjiP3zQ@smile.fi.intel.com>
Date:   Thu, 26 Jan 2023 17:02:13 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] gpiolib: remove legacy gpio_export
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023, at 15:00, Andy Shevchenko wrote:
> On Thu, Jan 26, 2023 at 02:27:58PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> There are only a handful of users of gpio_export() and
>> related functions.
>>=20
>> As these are just wrappers around the modern gpiod_export()
>> helper, remove the wrappers and open-code the gpio_to_desc
>> in all callers to shrink the legacy API.
>
>
> A couple of comments below, after addressing:
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>

Thanks!

>
>> -API=E5=8F=82=E8=80=83
>
> Mistakenly removed?

Fixed now.

>> =20
>>  	desc =3D gpio_to_desc(gpio);
>> -	/* reject bogus commands (gpio_unexport ignores them) */
>> +	/* reject bogus commands (gpiod_unexport ignores them) */
>
> While at it,
>
> 	/* reject bogus commands (gpiod_unexport() ignores them) */

Done,

    Arnd
