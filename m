Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E77A70CB75
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjEVUq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjEVUqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:46:21 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0245793;
        Mon, 22 May 2023 13:46:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 70F2A5C01A6;
        Mon, 22 May 2023 16:46:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 22 May 2023 16:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684788380; x=1684874780; bh=+L0icm8PcJhuI13aRSH2Ao5/O3h9y8NRZXY
        eIScQ4y8=; b=t5hDG+T+q4+N+pi2RIe8l6lky8dAwg0ymcZjms+fECVpeDGxLLD
        Id82YtnBeKWx1AR3n37tdVkvx9iEX5scRf/GR/a5hpJavVAyCfhYkiAjgVfEQuZA
        Gufp1U2+pwZcXMWsLZJltAwaJObV1VJ8+s5jAYe3+GxO+w+tuN00NPwC2WFHfFto
        fxlLoUXWic4BAnlNgjHgAptvOMQJgmP6iP+x74IB7Xl2lZN2qCzF5Pq3BDiXCSeo
        Cj34bZMhZjesbWSVIp/w3xzlyIl8ZaObgJPH6LzWJchVwVrFEjZYohmL7ILXYJ2u
        ZbkBinIiej2Qe3yL334QM/zwyeoujLJoDIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684788380; x=1684874780; bh=+L0icm8PcJhuI13aRSH2Ao5/O3h9y8NRZXY
        eIScQ4y8=; b=tzPnmQu1M9KXKAYcVjNuG4zajI8IUzNOve45nD/9XZUUxJy0Xfu
        k2m5dO3Na7i6so3frJ/dzY5r41k2Y4YuNXf3iAlamxv3MtmwbCp8vcYJwcJdgcZ4
        Vi8MSvGddxcwOCVD1lrCUMlZK4iRzXOLSaXOATaxD6lp47Avm5/d4/lFbjTpVvja
        fikPC90T8L6GqO4nAmXMVbmpE3h2wXNoHgzAcSRgPlSz68joOpKtsjJ+IGlkg909
        ZBJ5UqSnDVuHvVR465hEdHmdHrnvEMjdqWHvW3PGkWrSgevrIuWRAIK/d8iebA2H
        P4xW8DYeA51kd4kbIXjopXpW2myzKkjiRlg==
X-ME-Sender: <xms:m9RrZCgi6ef8jCuMhvPHfiCGX77EiB0FhYZg0ch8J6OAkrotUnzHSg>
    <xme:m9RrZDCXyadmlX8_pUOEgkS9NEoUCXv8mG1yjZK9S-wprXOunzn9Jb_-zIk2UG2ax
    V2XMR0qIwZAJwaBN8o>
X-ME-Received: <xmr:m9RrZKHXSoZ2Q3p645T2aJO1hU94GLeoLB0r3L5oIig91vKIEzh3KcYY_q9CJKYy_wRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejuddgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedutdejffetteefkeejieehfeeuieeguedtveeijeeviefh
    ffelvdfgudeihfdvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:m9RrZLTh5xY8K2OVPbxp8hWr_MJHR424VfzEIaHgPmv3W7W1oZUQAw>
    <xmx:m9RrZPyVtntBojPtp-IQq7wSRJhB03N5C9cVyWIy0Bn4ItTTwhyAXg>
    <xmx:m9RrZJ7gtARiONt5AMlKd-DgzchBtAt6oEREfdcQqHtlYbcJALxe3w>
    <xmx:nNRrZK_m50czInslGqZjYVK1jjecOZBF0Nyt6JlrLV2KA5NN4VIWXw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 May 2023 16:46:18 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 1/3] MIPS: Introduce WAR_4KC_LLSC config option
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <alpine.DEB.2.21.2305192342180.27887@angie.orcam.me.uk>
Date:   Mon, 22 May 2023 21:46:07 +0100
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB4BAB41-0BE0-4897-AE1E-9A98A6851FEF@flygoat.com>
References: <20230519164753.72065-1-jiaxun.yang@flygoat.com>
 <20230519164753.72065-2-jiaxun.yang@flygoat.com>
 <alpine.DEB.2.21.2305192117230.50034@angie.orcam.me.uk>
 <53043C18-7C75-4D5F-A15E-86D981D19CA8@flygoat.com>
 <alpine.DEB.2.21.2305192342180.27887@angie.orcam.me.uk>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B45=E6=9C=8819=E6=97=A5 23:51=EF=BC=8CMaciej W. Rozycki =
<macro@orcam.me.uk> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, 19 May 2023, Jiaxun Yang wrote:
>=20
>>> Given the circumstances I think this should be `panic'.  You don't =
want=20
>>> to continue with a system that can randomly lock up.
>>=20
>> I just checked how other architectures handle such situation, it =
seems like
>> TAINT_CPU_OUT_OF_SPEC is a better option.
>=20
> That can be easily missed, just as a random message in the kernel log,=20=

> even at a high priority, and LOGLEVEL_ERR is not particularly high =
even. =20
> For a system configuration that qualifies as not usable for any =
practical=20
> purpose I find this approach leaving something to desire.

Just found another reason that not to panic in such situation when I=E2=80=
=99m playing
around QEMU.

Emulation software like QEMU, mipssim, OVPSim, IASIM tends use base PRID
of a core. It can be more than annoying for people to find kernel =
suddenly won=E2=80=99t
boot on their simulator.

>=20
>> Panic in cpu_probe can be frustrating for users as it is earlier than =
initialisation
>> of consoles so the panic message can never be read by users.
>=20
> Is there no early console support for the systems affected?

For routers it=E2=80=99s very common that serial port available to user =
is not the same one
as we hooked for earlyprintk.

For QEMU users potentially using graphic interface, initialisation of =
DRM/FBDEV
comes very later.

Thanks
- Jiaxun

>=20
>  Maciej

