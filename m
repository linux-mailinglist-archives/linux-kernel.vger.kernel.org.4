Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FDC5FC230
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJLIot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJLIoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:44:39 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C751010;
        Wed, 12 Oct 2022 01:44:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D346A3200B1D;
        Wed, 12 Oct 2022 04:44:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 12 Oct 2022 04:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1665564275; x=
        1665650675; bh=0o82D+Vbr1Qqh8x9aEShWRywyoLoGwve0G5fih60HmI=; b=Z
        XYDKeC5/DveUPpoOMVoz4/DdJeyl3m9weqgTrXfyQqwWvzYaAalORZR0wMUfauVm
        USKsoTbCslmUlBAf5XKvoSkIhrqkHUKn9gKekULLRrxID3DBS5ccxKFFDBILr1et
        dX5NHk+inqoJHJpifN0CzWqPwftdqF9THcmcBEFYYcBnl1S5cJZEO8NLlmtP1+lk
        ZeYN5va3qjZCDyPWKhr21ftBm/DHvqFaoH2X/Rd/UrgduswGAGyUKAdJ0Vc+9qs1
        kc+x2L+4b30Y/RPRDl5DlAjlLT7N0m77LIBehKY6hugHfbqONfqHtsJi2bwH47ey
        KoPOeGtLHUPVqb+GfWezg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665564275; x=
        1665650675; bh=0o82D+Vbr1Qqh8x9aEShWRywyoLoGwve0G5fih60HmI=; b=I
        fd6FpfmZQJ/ksNwvJQyxRNn6SC59iUAGrEXcNKYMClJKz7W1Z+mxFscdTkhJjlFT
        MF0MBsvtxu2XA4kTEI1px5oZKSKueQtGs6tQ1LyRrdaGm7uxuPfJbqinecpjy8WG
        2enjQVu2xOxybglwpvpV5yIcnnUmIluzjctMSiofN1bH9pYoMfWQWYb3IcH6r6iM
        5jSErtaiKUZAO6AiH7GLRAtrK3hyExTY5v5joHPfi2kekxejuZUY2d/P/25n6Qxz
        UJwO/nNHaZRDd7o8XgWcLbmKEQ0pShU7Bz+n3Err89Sj3xMY/DRbC4ZcsyiVUAD4
        xjNGrtQum+JtiemLcFvhQ==
X-ME-Sender: <xms:cn5GYwiS-Lu3wZlU07-So25sNnbspw80O20Rpqhkwb-BUEKGjIWPhg>
    <xme:cn5GY5B5XzOgMcTZoI-5Sf7PCFtaihj6jUBBILKZBPrNUhXzeEfnI-iH3CH61ldck
    sselZSWuf-Mg303vF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejkedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cn5GY4F6_o7WHad7WyUmypGGKpD_vD0KkfNIBdvEFDLW02hBxmxJJw>
    <xmx:cn5GYxR7OZYcUuleHSsy1KxWC8O2IELM0B8vwjg077WUkbEyySyKhQ>
    <xmx:cn5GY9wjwaVU9py0PKfgtkocDW9kcvxaSGy4lQKfkVEB0mreU8mmVg>
    <xmx:c35GYwrdS9nADqpBxus3AqE0rdPeKImSwUA7AKKztmYEwewsiQPD9Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E64ADB60086; Wed, 12 Oct 2022 04:44:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <970b59a5-9fcb-494c-a07e-1443bdd5072c@app.fastmail.com>
In-Reply-To: <695a13341db63965a22799dd78698751ed95448c.camel@icenowy.me>
References: <20221012055602.1544944-1-uwu@icenowy.me>
 <20221012055602.1544944-2-uwu@icenowy.me>
 <60a2cb70-bde4-4423-9a54-7abc1ba466f8@app.fastmail.com>
 <695a13341db63965a22799dd78698751ed95448c.camel@icenowy.me>
Date:   Wed, 12 Oct 2022 10:44:14 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Icenowy Zheng" <uwu@icenowy.me>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Andre Przywara" <andre.przywara@arm.com>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 01/10] mailmap: update Icenowy Zheng's mail address
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022, at 10:35 AM, Icenowy Zheng wrote:
> =E5=9C=A8 2022-10-12=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 10:31 +0200=EF=
=BC=8CArnd Bergmann=E5=86=99=E9=81=93=EF=BC=9A
>> On Wed, Oct 12, 2022, at 7:55 AM, Icenowy Zheng wrote:
>>=20
>> I don't see a patch for updating the MAINTAINERS file here, if you
>> haven't already sent that another way, you should probably change
>> both at the same time.
>
> Good point. If this patchset is going to have a v3, I will contain it
> there; otherwise I will independently send it.

Ok. If you make a separate patch for the maintainers file, feel
free to send this to me at soc@kernel.org, I can then put it into
the fixes branch so it makes it into 6.1, otherwise I assume this
gets picked up through the normal path along with the rest of the
series.

>> As a driver maintainer, you can also apply for a kernel.org account
>> [https://korg.docs.kernel.org/accounts.html] and use that for
>> sending patches and forwarding to another address.
>
> Well I am in China now and not so easy to get my PGP key signed...

Right, that can be a problem. In an urgent case, you could probably
do a video meeting with someone you've previously met that is already
on the kernel keyring, but that is perhaps not worth the hassle
if your current setup otherwise works fine.

     Arnd
