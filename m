Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A3715E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjE3Lz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjE3Lzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:55:52 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21D6B0;
        Tue, 30 May 2023 04:55:16 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1CE5632002F9;
        Tue, 30 May 2023 07:55:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 30 May 2023 07:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685447701; x=1685534101; bh=2tvvKDbF1hK6YbztPVPIPE2ZY0lY840KyG/
        h2NOWuoo=; b=lkluiL6H+vITqeODD7XEF20W3kCNsR/E7ufYbbIIuAAuDMW2OD/
        4/EIG6JSPsrzaB6KmB7A5oZDyc/axoLOjNyvcmuPQgYZql/Suw+kYiia/VmIJ5XH
        1bmU5G1Z9eOG0eteBnaECL6tSKzypBe3cppxmjzcWLEHIZQDMwhFCmdLmEBdOefV
        gOBB6IvIaLfLrb0Wx084SvMlEPMpoVtoX/O1Ko3L/ozWVb4nEvKs2ak+C+4ZAitR
        +YHk6Ep9+UHD6LAGcdCUj9QpUyQJSxqQXT+s+7En0oM4hwMcrtWkg2ff1qs4R8EJ
        +CQOhzE9YFSav4EhIOyyWw5sEc1bz4/FUNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685447701; x=1685534101; bh=2tvvKDbF1hK6YbztPVPIPE2ZY0lY840KyG/
        h2NOWuoo=; b=C3Row8K9n+zp6VYbQ3HDJeeBsatAtoC351VOzcJEZizfnfqHnfN
        ayJUZ+YaUt/WRluCT9qAiXl/B1GWI0BBDElgNTh7usVsyTMlTrsPWCB/P80ZhGTF
        KPsO2dge+EGb/0IwCzMga8BfKl7eGMifxwRVVI1sfnaAliEgndQx2U+0b+LgsUN+
        BWbvH1PBeBxEaXMNm/zbGCsVSrX5SyKtAncwqaAb/aikTiYkKM+mEShBrG0eeV0q
        PeDaZI8bh9YQd0llMS9OB/ok22Ri9Ggkyiub1xh2Gd+yRRB0+Bd6aQwOe6j3d/sH
        1ImaUt7SDJS5kUPhmKNLMUouS7NvbdPxn1g==
X-ME-Sender: <xms:FeR1ZJhLt7L0ASsnrXF0viTA75Jbuu4EsGT-bTG5PUbi7zMaNd6Low>
    <xme:FeR1ZODbC468OBQs5_eEwTAWMTynOg9gysM1TuPWa4zrGkC19xkLPj2FallaSBsrN
    jtsm8dzctjUXYBiAX0>
X-ME-Received: <xmr:FeR1ZJE2eAzfR0xUjkZ8an_d5LlH7o-mZ0qW-WiCP3QlNgsZHyZuLrlTOuj4vKyKfcXL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:FeR1ZOTtxKDA1nmYhfxnhpaZFoEdmFzbO5TCqYPx1x6ungZhd6SEbg>
    <xmx:FeR1ZGzmB6QQlY-YqGVAdWHT7duh6ekXod3ToXhT6_oEK9Cjm4vFMA>
    <xmx:FeR1ZE7A2ISZxdIt8wYsaw3fi5VZX_BYrbZvzD8PnvYSzL_oquwRug>
    <xmx:FeR1ZK-hT-Krg6j2DPeVFrQwTDcy7Nauivk_jkL7UE09TaYrnTpmig>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 07:55:00 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 1/2] MIPS: Allow MIPS32R2 kernel to run on P5600 and M5150
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <alpine.DEB.2.21.2305301152080.42601@angie.orcam.me.uk>
Date:   Tue, 30 May 2023 12:54:49 +0100
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BCECE3BF-7A4D-43BF-8AA8-2232D974CD71@flygoat.com>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
 <alpine.DEB.2.21.2305300321520.25569@angie.orcam.me.uk>
 <684C1A48-C743-4045-AF12-B0846FCE8EBE@flygoat.com>
 <alpine.DEB.2.21.2305301152080.42601@angie.orcam.me.uk>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B45=E6=9C=8830=E6=97=A5 12:07=EF=BC=8CMaciej W. Rozycki =
<macro@orcam.me.uk> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, 30 May 2023, Jiaxun Yang wrote:
>=20
>>>> M5150 and P5600 are two MIPS32R5 kernels, however as MIPS32R5 is
>>>> backward compatible with MIPS32R2 there is no reason to forbid
>>>> M5150 and P5600 on MIPS32R2 kernel.
>>>=20
>>> What problem are you trying to solve?  The CONFIG_SYS_HAS_CPU_* =
settings=20
>>> denote overall platform's support for the given CPU and have nothing =
to do=20
>>> with what architecture level a given kernel has been configured for. =
 You=20
>>> do need to get the settings right for your platform, just as you do =
in=20
>>> 2/2, but this 1/2 part looks wrong to me.
>>=20
>> Well the universal target is to allow R2 generic kernel to run on R5 =
CPUs.
>> As R5 is backward compatible we can just have one universal kernel =
binary.
>=20
> Sure, but this change is not needed for it.  You just need to declare=20=

> which ISA revisions your platform supports and leave `__get_cpu_type'=20=

> alone.  It has worked like that for a decade now.

I=E2=80=99m afraid it won=E2=80=99t work as you expected.

Actually I ran into a problem that `case CPU_P5600` in c-r4k.c is =
optimised out
by compiler, because the codepath is marked as unreachable.

Thanks
- Jiaxun

>=20
> Back in the day I used to run R1 kernels on R2 hardware myself.  And=20=

> maybe MIPS IV on R1 even, as we had MIPS Malta CPU modules with both =
MIPS=20
> IV devices (QED RM5261/RM7061) and MIPS64r1 devices (MIPS =
5Kc/20Kc/25Kf)=20
> and switching the kernel when swapping modules was a nuisance.  The =
Malta=20
> config still supports these devices although some may not exist =
anymore.
>=20
>  Maciej

