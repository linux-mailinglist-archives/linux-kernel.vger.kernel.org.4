Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC84A60B50E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiJXSMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiJXSMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:12:02 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4B626C44E;
        Mon, 24 Oct 2022 09:53:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 382C32B066F1;
        Mon, 24 Oct 2022 10:27:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 24 Oct 2022 10:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1666621673; x=
        1666628873; bh=j5Xmm1hIOnDXfjVvOH1nBH2jD1dezyQFcZOvqExQy/Q=; b=R
        FOCrFIiTxT4VVyc9mEDQdkEn+wGl6bgl85vYTnOHs9SmkuBXihbN449jNzacB8jI
        rTTZjSbMHEkOE6lva8OK7H+tWMs7X8EpOfrjmtb6/oVOGDu9QbZ0yoFBmwCcqV/f
        OY2S9hiS5k+xnEniFrSzWv69cVnlbB0lhSbJ9CqHWVp9ya8AIfEqbYesbuFRq9Qd
        PSVVASHWixWTm4BTrueGRqrr2qoyHEcyvUm2O9mtgTacw1X/e4TGUOI7spwRF4k8
        NrLH6dKrsa3XnjqeccrXYuGDRxoUwvp7+h9Ls1LReoWuxJMTQSMuUwY2jFO3D+Jm
        dHiTM/iSZCKnRNoHbTlJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666621673; x=
        1666628873; bh=j5Xmm1hIOnDXfjVvOH1nBH2jD1dezyQFcZOvqExQy/Q=; b=j
        bQ9YG0M5QUfhAMC5KcxlBfNv3OPZ3dcPqvAHDAkHJFJBtkG/oKiHEgB/CGkfd5D4
        4WXIXCvh3vM6V7jLlWzrMUTV4Fpaa7SNUDAMOjP9/s26EtfpqJpXHuJvjncEf/Hb
        l2A1rrOSEilHAzFog8P4c885b26rzqZmcbf/q5PoNykrPcDsbeuOwk+rlSf/XLVe
        pO9o+yifsE2IWF0Wd9xtiS41jAXVVz31C3ZyF1314cL/e+AOiNL9MtukAPZEZ2j8
        gZbNNP84mt+QmazljsROIuA11JsXMnAQOzsIvfqse5ElLjsQWYAznhJvSftlDiy8
        UDnTIRgLvHwK0iMEY12aQ==
X-ME-Sender: <xms:6KBWY_gwmdA9MhV8F7kI-IAT6RjoV8UyoY8vJd_im8nzMhPr-w5SEg>
    <xme:6KBWY8DFzu_H1NXJNLoNcdftX0Fccg83xmP1gZ_Oo0PjdmKShBDqthVvsAPur-jjx
    nKKucVvJWn2dHOfBYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:6KBWY_EKFaUSxfmbFq4u45xHq3kzkmlHX7APZxOrmpX4NKAPPIVhLw>
    <xmx:6KBWY8Sa2YoRcKoTYZV4cAVrgo3XWvtPHJE_rauldYzUHnGUJcpV8g>
    <xmx:6KBWY8zBpoCDaeX7eS6StOnrb6kSgFjb8QNDCQkjBv4w_fjHvPPK9g>
    <xmx:6aBWY7iVKZZZeLJhXB65ARrCr06Q6ReuiHPabu10swOp_0SKXFR2BwSFrZk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F38B1B60086; Mon, 24 Oct 2022 10:27:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <8d6ddb0d-98be-4c4d-9523-f024c339c8d0@app.fastmail.com>
In-Reply-To: <2204103.iZASKD2KPV@diego>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-1-arnd@kernel.org> <2204103.iZASKD2KPV@diego>
Date:   Mon, 24 Oct 2022 16:27:31 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "Ben Dooks" <ben-linux@fluff.org>,
        "Simtec Linux Team" <linux@simtec.co.uk>,
        "Arnaud Patard" <arnaud.patard@rtp-net.org>,
        "Christer Weinigel" <christer@weinigel.se>,
        "Guillaume GOURAT" <guillaume.gourat@nexvision.tv>,
        openmoko-kernel@lists.openmoko.org,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Olof Johansson" <olof@lixom.net>, soc@kernel.org,
        "Rob Herring" <robh+dt@kernel.org>,
        "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
        "Tomasz Figa" <tomasz.figa@gmail.com>,
        "Chanwoo Choi" <cw00.choi@samsung.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>, linux-doc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org
Subject: Re: [PATCH 01/21] ARM: s3c: remove all s3c24xx support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022, at 22:56, Heiko St=C3=BCbner wrote:
> Am Freitag, 21. Oktober 2022, 22:27:34 CEST schrieb Arnd Bergmann:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> The platform was deprecated in commit 6a5e69c7ddea ("ARM: s3c: mark
>> as deprecated and schedule removal") and can be removed. This includes
>> all files that are exclusively for s3c24xx and not shared with s3c64x=
x,
>> as well as the glue logic in Kconfig and the maintainer file entries.
>>=20
>> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Cc: Christer Weinigel <christer@weinigel.se>
>> Cc: Guillaume GOURAT <guillaume.gourat@nexvision.tv>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Simtec Linux Team <linux@simtec.co.uk>
>> Cc: openmoko-kernel@lists.openmoko.org
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> So many memories of me starting out in the kernel on s3c24xx.
> But it's no use trying to keep stuff around that nobody will likely
> ever use again. So with a sad face
>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
>
>
> though you might want to also include
> 	drivers/dma/s3c24xx-dma.c

This was in a separate patch that removes the driver:

https://lore.kernel.org/linux-arm-kernel/20221021203329.4143397-14-arnd@=
kernel.org/

In the first patch, I only include references to removed
Kconfig symbols that would not make sense to split out into
separate patches.

    Arnd
