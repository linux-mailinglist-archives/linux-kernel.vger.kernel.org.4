Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3821716127
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjE3NKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjE3NKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:10:19 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F01592;
        Tue, 30 May 2023 06:10:18 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CE2BB5C0054;
        Tue, 30 May 2023 09:10:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 30 May 2023 09:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685452217; x=1685538617; bh=fF7F3pQCLKgh++twE6/HupDMBWeYuGMm2mt
        CqL1NK0Y=; b=bNem6wJOMlUc8Jo2udzJnu3vKBZ8kjDwfNm3tN1dFuCYB2ISHjv
        0omYGm5lXiVTSEoy4NkroP9jg5UY1OyuYsfEAQwnbeiqjoKZgj/Yn6FhfTJPqdp4
        1jW1iZV+rpRCBHMtqavfKDbgZV2REMOZ0m1qMneadNcAn0Ws5lBhLCqHgHeYmAv/
        ltA8m1D0alGcGMOSULbZ6WD+nw76Gjnq+MmEcgc930MgG1/lFsUBl81W1Mda4WH8
        7dSPOLLjYqhGJ3nJGiUlU0/GTwpUf5HRoE6LOTQrFItEqSaZlvUeeq/s5s17x9Ad
        5zPFrSxfV8r5axR/mRknt0D20vq9uBX4GOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685452217; x=1685538617; bh=fF7F3pQCLKgh++twE6/HupDMBWeYuGMm2mt
        CqL1NK0Y=; b=nXGQ1fyN3UEGjtaqubkgg5c3n6txMf8fB5PvMSiHTCx/m1tmuvj
        X7PEBQWITj4llijyVgof5wQMn1CBEVuTtOuDJ6wj76skE8h509omabtydy13P/r4
        ur7uuITNprj5ptxofOK0KiK/87JCMrIZN4rqgdXhuWPts0YFV5w990k7DXPK0Fal
        Ze37WrJTQ8ttSzPOXrJY8vtwHBsqg+xs0JpAUF6955Ur1mOjsW2YIqv8X0MkYdUg
        YsAoGZgamEnHznZfDGUmpb0+E87VnruJ6vhZCG6FdZ3Elkbi48kn+aiPQWzE1xbs
        za3M4SgxVqJkg7NnCuwe8YP68fewGtXTEqw==
X-ME-Sender: <xms:uPV1ZMFX-27NO00pGbKyTAtaS2QvJg0iHJTHS2gscAGNadQLoj5Gjg>
    <xme:uPV1ZFXfvZ3VujrfWfPrjDg9MY6VB8jv5lUSFgQCITYDiYajO-HblVTH1MagYuI-p
    05rgJJgdQrcvwhR7io>
X-ME-Received: <xmr:uPV1ZGLNOlCXJwaVX_BmOhMhrvpWU6vty3I15vj-wR0_Nz2Cf8s36UDqg_5v2gtPE09j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:uPV1ZOHqypQGBSzwwZG2CdCAlGXakSkjcHaWEZ-yQrmaoeRvfIW1kg>
    <xmx:uPV1ZCXsG4sPv8jFEZNRIy6tNZi71Wu00TaiQhcvXwIgEx4fXdLJ9A>
    <xmx:uPV1ZBNmD5pNVjVaNfEjBl3B71QNyoezRE6cjfa6wlXyGe7FYx_ICg>
    <xmx:ufV1ZBRbyd_xdQZRxG56TUKZ8PSG8KOrJ655B87mrvfyqKUaTkAnaw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 09:10:15 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 1/2] MIPS: Allow MIPS32R2 kernel to run on P5600 and M5150
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <alpine.DEB.2.21.2305301315120.42601@angie.orcam.me.uk>
Date:   Tue, 30 May 2023 14:10:04 +0100
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CC33034-4AF3-4522-9942-8BCCEF1086AE@flygoat.com>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
 <alpine.DEB.2.21.2305300321520.25569@angie.orcam.me.uk>
 <684C1A48-C743-4045-AF12-B0846FCE8EBE@flygoat.com>
 <alpine.DEB.2.21.2305301152080.42601@angie.orcam.me.uk>
 <BCECE3BF-7A4D-43BF-8AA8-2232D974CD71@flygoat.com>
 <alpine.DEB.2.21.2305301315120.42601@angie.orcam.me.uk>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B45=E6=9C=8830=E6=97=A5 13:16=EF=BC=8CMaciej W. Rozycki =
<macro@orcam.me.uk> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, 30 May 2023, Jiaxun Yang wrote:
>=20
>>> Sure, but this change is not needed for it.  You just need to =
declare=20
>>> which ISA revisions your platform supports and leave =
`__get_cpu_type'=20
>>> alone.  It has worked like that for a decade now.
>>=20
>> I=E2=80=99m afraid it won=E2=80=99t work as you expected.
>>=20
>> Actually I ran into a problem that `case CPU_P5600` in c-r4k.c is =
optimised out
>> by compiler, because the codepath is marked as unreachable.
>=20
> Maybe there's a bug elsewhere then.  Send me your .config and I'll try =
to=20
> reproduce it.

Ok I see the problem, after applying patch 2 the issue is gone.
So actually only patch 2 is necessary.

The unreachable mark here leads gcc to generate some confusing code
and I misread it.

Sorry for the noise.

Thanks
- Jiaxun

>=20
>  Maciej

