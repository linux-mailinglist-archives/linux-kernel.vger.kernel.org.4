Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF58698333
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjBOSWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBOSWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:22:50 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA55011B;
        Wed, 15 Feb 2023 10:22:47 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1A9E63200918;
        Wed, 15 Feb 2023 13:22:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 15 Feb 2023 13:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1676485363; x=
        1676571763; bh=ZRLk0sIoJitWI4IcgROuMQOwv0KwZO5d0pce1OVSuJ0=; b=E
        y4A4PJy0716osh+rJplzhQRipm9VeeGrS5BKOSUm5w/g/IxyRe4s5obJEuijPFoT
        oCZI8k1d2SfRpJkOBJkQi5mnDGwsBPt2t2gumJ1ycx81LeHCVUdO+X4uhBDe+h5E
        kPd7bYoHmco9W2jHdkHXzh1HtKTdU+jGs3KC2qR1tQwWb42vDQMdwGjbVey0xqPq
        L1v/CwLyva3GXymdXaxmuJNhoaOt8IOCygKhp/w9de0+eeqwCLjGNHvI+xUGGBdX
        AcJZQuB90bUdw8BQgnk/X25yS56MmyHE6dSmW8xt0MvRZ+kCGFCZm3IOE/d2fxuL
        3AiNZyzJEwse8jeo57D9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676485363; x=
        1676571763; bh=ZRLk0sIoJitWI4IcgROuMQOwv0KwZO5d0pce1OVSuJ0=; b=i
        89zCemRZ9924zfrY/BEKnRwRYmpPGuxv2wWL8Fp9B4JZaxyzOt/WFgcoqZeDWB9P
        DUfLQirYJ+URiRiaz8eShaUGUmejuRjMBOoad/cwWPNgP1avXzH0M51n6LdV8XKE
        yGpGcTpzwaaVmfeNvJJ1RyI+1UDxFdmcerH9/lPBFdENw+QCzrMRYI2O4O5bZtKl
        u9ZBnVwyBtWxhuJXO1wKWMfrF4FwxvctjUMbhDG+dyZkAKrddVuxHaGwDcBZbcYI
        LhOaMMDOliAJ0lAzkjmGesLMtHpZMFTl3djFUq4olazSXhGtxdeXdamr/LVJaDAk
        NcFPfc+ntGMg1GGoyrzMA==
X-ME-Sender: <xms:8iLtYyGzaAIaBFaiNhwNLzF3Usi9jW9qqNAv6hfL4v_1jm4OOXWkOg>
    <xme:8iLtYzUH5h8P9vcZRF2OdbiFH52yB5DIQCM5YSTB0v_u0B3d-U6U1VpAg9dYoZh-u
    LygEU8EybKv-XoE7ik>
X-ME-Received: <xmr:8iLtY8IHp9GyCyoXATZpiPFAB2UTWN1Ldyn3sSHN_hBrndEH1WYnrNwPL1AHW3lC3iVD_qPdyt1qet0WnS_nMjmCOC61WWD2AFBA_83L3VerETurxCqs1H4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurheptgfghfggufffkfhfvegjvffose
    htqhhmtdhhtdejnecuhfhrohhmpefuvhgvnhcurfgvthgvrhcuoehsvhgvnhesshhvvghn
    phgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnhepvdfhtdduuddvueejueffgfduke
    dvfeevgfeuieeivdeltdehgeeivefftdetkedunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:8iLtY8EF0vzfCaCNJB49AvV6Kb_PBQA-fWKTokag73oSkXIslBsilg>
    <xmx:8iLtY4Wdxz5nUump1OUwuGSTKIx0HrNtK7mWR0cUofNUjNpO0MIMvw>
    <xmx:8iLtY_MrBiCO8J6Gitc1aQPBeuomNy8yrMginb5wTNADbYiwbyHr1w>
    <xmx:8yLtYxOblFB1HnHIahFXzz2WSEjFw6KWM-ipajtn7ACUCO5jXtDrUg>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Feb 2023 13:22:42 -0500 (EST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Sven Peter <sven@svenpeter.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 3/5] arm64: dts: apple: t8103: Add PWM controller
Date:   Wed, 15 Feb 2023 19:22:30 +0100
Message-Id: <C8BAB390-592D-4337-83A3-80C9CB2A7B2C@svenpeter.dev>
References: <CAMT+MTQLOZUids4N8Eba5SYOShPGJWqMSaCyF=cmh2KvBE3CaA@mail.gmail.com>
Cc:     =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAMT+MTQLOZUids4N8Eba5SYOShPGJWqMSaCyF=cmh2KvBE3CaA@mail.gmail.com>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: iPhone Mail (20D47)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


>=20
> On 15. Feb 2023, at 19:19, Sasha Finkelstein <fnkl.kernel@gmail.com> wrote=
:
>=20
> =EF=BB=BFOn Wed, 15 Feb 2023 at 19:04, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
>> I'm not the one who will apply this patch, so I cannot say. Having said
>> that, I wonder who will apply. Will this go via the arm tree, or via
>> pwm?
>=20
> That is a good question: The pwm driver should probably go via the
> pwm tree, but the device tree changes would be better via asahi-soc.
> That leaves the bindings as the, "no idea which one".
> I wouldn't mind hearing from marcan or Krzysztof as to what their
> thoughts are on how to send it properly.

The usual process is to take the dt-binding changes and the driver through t=
he subsystem tree (I guess pwm in this case) and the changes to the device t=
rees themselves through our asahi-soc and then through Arnd=E2=80=99s soc tr=
ee.

Sven


