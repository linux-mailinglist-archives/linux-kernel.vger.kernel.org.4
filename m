Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1958706495
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjEQJvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEQJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:51:49 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8124F1BF8;
        Wed, 17 May 2023 02:51:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 635E05C00E3;
        Wed, 17 May 2023 05:51:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 17 May 2023 05:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1684317104; x=1684403504; bh=V3xsILHICgJLZkK2B+bruOp3fFAhB06OWCO
        PN9kuRmo=; b=mWqI5wtYr3Fr0/W0KfPiRryajdbIiJMvuhB6FawPWn8fZbh3y9d
        zbPHSga41RW2CnQQTRvPYzEAKjjD/o3GCJ7U/1dtad41EdkqwYsiDhDWD4YB/mma
        rxMEU6CXgYI/AxUiiKcEIfPbbkpWlNTujasf7EuccEU0Wfn3sQfby8kOEuZKC80d
        dCQX1/OgD5citKbfrQhMywCYUjezGbrnlaE1FiqYkv+C2iyMLDRk84jFF94sb7Rk
        b5VW3h5548nfx9aY3tTM0/XSyX2GKdFdNk6z5lPUTIeTpB61slRbj5JR+qttfO89
        LZGKo6X9DSMqdDlh93GD0hcIlNdGIR09p8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684317104; x=1684403504; bh=V3xsILHICgJLZkK2B+bruOp3fFAhB06OWCO
        PN9kuRmo=; b=rtKjnAURDnI/lG2lOecTJGeLUc1xlML8p9RcznY5ArlQNO+semU
        N0B+UIq/T+uPwvT6QdkyAQNA5hrjaPNI4rdRDJOofeSalu5wlk5D78/4LBSQAiLW
        M9AxTuW1X3Wzmkv54QaeeIHkxoIUnz75OMRLWo/rv0x2xGuh53ZVNuyqYj2wiTl1
        hVio1J50OoRtIyt5Ka8qEWwuNyZshJYjJAZSRdO82qrnS3hHtXPzC9ixYL1yRKnw
        MtOvVU4zzvy2q5cAMK+70y+SI90wnQdLSEMBZS2UlbBGVel2Z2kAZsjVmn8E7F8P
        788EvRYAd9bxxQNTfb6UiiT6o/XkNV9q9hw==
X-ME-Sender: <xms:sKNkZO9YeNUkY-1agj9p1cWGfD5-JM3EPv01SX4qS5_ECTZwnxsdug>
    <xme:sKNkZOuzbopH_DC7NeKSkQrflz0BsiRZKPAJAMH7b9HJ6lbg4E_U2bDeuvd-AwWbi
    BC0F_j-6WQSmvJprK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:sKNkZEAVzATeNX4ng_FUgG2ly-efk7TUjJjSGY5wEc8AI2ynvRdK3w>
    <xmx:sKNkZGf438EPn-Ue1OCJIGY_MpdMkZJq7bPSrZt_WrnKm--qzoBphg>
    <xmx:sKNkZDMSwVJlBIP8qAIxegFp6KCzOItmkUjp79hr0ooV12an_glI3Q>
    <xmx:sKNkZMYSW6CPcicKyKyDh5337P8qblJgsNu693rwMKtDgP9yl0PDPg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0EE08B60086; Wed, 17 May 2023 05:51:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <9d350346-c45e-470c-bfe5-0a98d549f29a@app.fastmail.com>
In-Reply-To: <CAMRc=Mdic_d3KaxFXrz7aVUcLyK8fBBHPgRGYP8nQvxN-ZwJXQ@mail.gmail.com>
References: <20230516201642.557733-1-arnd@kernel.org>
 <CAMRc=Mdic_d3KaxFXrz7aVUcLyK8fBBHPgRGYP8nQvxN-ZwJXQ@mail.gmail.com>
Date:   Wed, 17 May 2023 11:51:23 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Linus Walleij" <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: sa1100: include <mach/generic.h>
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023, at 11:33, Bartosz Golaszewski wrote:
> On Tue, May 16, 2023 at 10:16=E2=80=AFPM Arnd Bergmann <arnd@kernel.or=
g> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> sa1100_init_gpio() is declared in a machine specific header so it
>> can be called from platform code, but the definition is in the device
>> driver, which causes a warning:
>>
>> drivers/gpio/gpio-sa1100.c:310:13: error: no previous prototype for '=
sa1100_init_gpio' [-Werror=3Dmissing-prototypes]
>>
>> It's already possible to include mach/generic.h from drivers, so add
>> this one here as well.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/gpio/gpio-sa1100.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
>> index 342a59ea489a..3b1cc8462fcb 100644
>> --- a/drivers/gpio/gpio-sa1100.c
>> +++ b/drivers/gpio/gpio-sa1100.c
>> @@ -13,6 +13,7 @@
>>  #include <mach/hardware.h>
>>  #include <mach/regs-gpio.h>
>
> This doesn't apply on top of my branch (neither on next) because of
> this line. I can't see where this was added. Any hint?

My mistake, my working tree had some experimental patches in it.

I'll send a v2.

    Arnd
