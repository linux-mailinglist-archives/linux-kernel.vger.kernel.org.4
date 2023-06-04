Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5722E72198F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 21:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjFDTeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 15:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDTeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 15:34:23 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5054B0
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 12:34:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7BF8B5C0131;
        Sun,  4 Jun 2023 15:34:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 04 Jun 2023 15:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1685907253; x=1685993653; bh=1f89o71I0/MozIPoCuTdNbjZdnj+C1fPZsZ
        zWXqu5bc=; b=23i4yDo0GQJdS9p5vgMLl2wd3r45VBfdkTaS60vRhQE8aFceVSW
        UlpUZziPAKnUpOWGNcXq6RoDL8AAfOwBr1X5jcqIDyyC75xNFDkf5h7ZAT5TKlck
        W99k8lI+3LmgV0iY2gvqIlnLV8PYERg/lAtGAbe6vpkWd76tsmZV190UOeB/PPH7
        UqMl5tWX4oqeJcGjwH9UXIV59bjuoUiimC2QR7SpgfefVvSDy6/X8NqWT37q/NhJ
        NPk3KuGyLEFpZ20yKDXdprxJrb/T33ukxq+yEYN1Z8krcRzoC1aHeQpK4hEafz05
        qJeV3yn2orEEOWiWN0f1s4uHpK4pHGPxYYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685907253; x=1685993653; bh=1f89o71I0/MozIPoCuTdNbjZdnj+C1fPZsZ
        zWXqu5bc=; b=PMbP6i8jkIqd2Jm4pQk3Z7X+5tDfHa4kiRkXBOJM8mcNgqYM6QC
        ZLvrxErE2u3B3l4UfbHrRZfSMTXvRzWdYY3Pvo0KViuXCzOodN6Va1IxAfCvaaWx
        CqEmLkctob6yFFL5GqnXPaZx9u8pxxF97BHJR9jpfxsgmM0uXr7XdNhXtvRmj60U
        PiDmCZ55K3ZZrKXWX/T27RTeC33CrRuiSzSls5AzDn4IIkbRkrv+sVJpS+0l6JRA
        7xwolww6AeyhWT4RLcUEnmj5EwjgUVrZYSlzwnnYEAv3IDxK8lGmkiXxVQPxDPhi
        XLVUGFz614Js6L4lI1AX+lkHtk7pAb0h8pQ==
X-ME-Sender: <xms:NOd8ZMI7hbV-KjN9mPLtUFPnZP4xylz-c1IkIMEz6V5yv_8MDn9fOQ>
    <xme:NOd8ZMLZOJjOzLFZryHCSLo9p-Z3u_nrMCOQ5Oad9rJpVUD23pkqmVHvtr53X0-9h
    vzQViG2aZ4SqBntEvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeljedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:NOd8ZMtbEdayahbHxK9AgDng4vBdGgLpziBakBtKP_AukEa5DLy7WQ>
    <xmx:NOd8ZJbj46vRoTwBU-Lv530A_aYTJDmgUYJCXUugfYBpunOPP9GYLw>
    <xmx:NOd8ZDZvDA20Kcy-IwRypGZRcBchAIusnnbjNXr4I3utgZ9vI6b2lA>
    <xmx:Ned8ZIMVoaC63ojlxy7d67mLYtG_HC-QcfwMx4TkAjsa66SyIjfJzw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B1C31B60086; Sun,  4 Jun 2023 15:34:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <e7960f41-3d72-4037-9f9c-ff43fedd10e2@app.fastmail.com>
In-Reply-To: <CAHp75VcJ7bvGMQkVpnP2g_FXxQYapf0mXSZ9ETXj2P=cH9N17Q@mail.gmail.com>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-10-nikita.shubin@maquefel.me>
 <ZHudRkB1YcMD_DaQ@surfacebook>
 <44c969a1-8dda-425b-acf3-9a80dfa60e79@app.fastmail.com>
 <CAHp75VcJ7bvGMQkVpnP2g_FXxQYapf0mXSZ9ETXj2P=cH9N17Q@mail.gmail.com>
Date:   Sun, 04 Jun 2023 21:33:52 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     "Nikita Shubin" <nikita.shubin@maquefel.me>,
        "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Michael Peters" <mpeters@embeddedts.com>,
        "Kris Bahnsen" <kris@embeddedts.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/43] clocksource: ep93xx: Add driver for Cirrus Logic EP93xx
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 4, 2023, at 21:24, Andy Shevchenko wrote:
> On Sun, Jun 4, 2023 at 8:19=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>> On Sat, Jun 3, 2023, at 22:06, andy.shevchenko@gmail.com wrote:
>> > Thu, Jun 01, 2023 at 08:34:00AM +0300, Nikita Shubin kirjoitti:
>
>> As long as the platform selects it, this is the normal
>> way to add a clocksource driver.
>
> Shall we now require this format of COMPILE_TEST for all new code
> (which is selectable)?

It's somewhat subsystem specific. For irqchip and clocksource drivers,
I think it's already done this way, but these are the ones that expect
a platform Kconfig option to select the drivers, which is usually
not done for other subsystems.

If the driver is not selected by the platform, you usually have

config FOO
      tristate "description"
      depends on ${PLATFORM} || COMPILE_TEST
      default ${PLATFORM}

which makes it possible to still disable it, or (optionally)
hide the option by adding "if COMPILE_TEST && !${PLATFORM}"
which I personally find a little too complicated but is
appropriate for some drivers that are required for booting.

   Arnd
