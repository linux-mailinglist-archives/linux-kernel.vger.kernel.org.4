Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2223869F515
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjBVNFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjBVNFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:05:04 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3B9367CB;
        Wed, 22 Feb 2023 05:05:03 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 81EDD5C007A;
        Wed, 22 Feb 2023 08:05:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 22 Feb 2023 08:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677071101; x=
        1677157501; bh=zTBhSHg2Z1fhQW2zMWScuLvC8roK+JvNcm0QshCfxFI=; b=s
        6pXHfROnOELLc+Cn5s7R2d0Nrk8bJ25Klu/V07fr30hYpaie61vExlYSQ0G7zgfN
        OMUzIiFHAf2PzVWgmnCnGaHgxNUBlvJzTt/k2TJ+ThmhLNhNCghqt/C9WEMlzdTI
        ji3cgkZYTMebvOEvim3ODU0qKu8DRPzGG+qsR7cJMLL5Fclbs1RiMr8dkfaGzn9Z
        t/sC66teOmxX0KnAEPYg/jjsStKHKcW0SkVEwc8eRptpVfYBmOncXay/kaz6hVK2
        mumMkRYzc2BpdkweCLZ1HMo9d1E4RV40N2HJweayMAupo4w1R5j9be8ISI3I4/Bc
        ykQp0uk/soMnRzkKOCB7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677071101; x=
        1677157501; bh=zTBhSHg2Z1fhQW2zMWScuLvC8roK+JvNcm0QshCfxFI=; b=C
        UUs1Zuoz5XkoMOm4gnwKBSRt3KrYWEX4vIDIx6LibNfmjODvs4M8QKVlRQpJCRgY
        xGwWZvtZS7MDrWjJtx31I7n3pFOjbaECr/6aWcgxK28zyzppWUxC2diDCQwOqt1q
        UQlviLT3yyKXlVGVIrxkCj4JlZGG3fk0yWnqbLxeqqrkWHELEKWsBxDeTTr07P7x
        XCD3jgq9SyFt4h61XIydzgEVDKmfG5nNwHYuMq+rEedrrQg3Ibz8OJsX/vMor3vR
        Nyqzwoq4Rq5+6fLyqO3wiJm1sSGzFiL4skYcVr5WEgM/oLg6EJcj4PRJaRnnuH/L
        NhZxxvybMJ4WinSrceEzw==
X-ME-Sender: <xms:_BL2Y4cbTKB3egLQG9iHK2kjKujrBo7PlmPiR36iD6h0BrdMvZ5c5A>
    <xme:_BL2Y6MejVu9vjLYcIrPSX28rBjftuHQt16e5GfJavGQPB4a3MqLzNOW9EzOVtCDc
    sVnu71PI2iXT7FTI4w>
X-ME-Received: <xmr:_BL2Y5jVQFSR8RddGDPikwmRIua3y3P8Hu1zuH9h00Rw3vW_IM5fJyhGVPZFb50580Ac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:_BL2Y9_thBwi4MQagwUStSLBWX_AC_ElTF8lVZRH4KmWWQZDiXdnig>
    <xmx:_BL2Y0tmJ3pnRQOAXcIoTOFFdHZi7yqurNnwqE12koyJWErZbMILBA>
    <xmx:_BL2Y0GMuEDjSm8mG6yenGtEMs0GwVVpheQihqGnW9on60eMSQeC5w>
    <xmx:_RL2Y2JEvc1HdaC_4PRfTWKAkQ07C6sj79I2FVKEVyb5KlvpTe5yrg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 08:04:58 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH 0/7] MIPS DMA coherence fixes
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <a46e1840-89be-de8f-6a91-3e4a16fa17c2@arm.com>
Date:   Wed, 22 Feb 2023 13:04:47 +0000
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>, m.szyprowski@samsung.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBE3717B-E49A-4BAA-9CD0-FFD2462B9CE0@flygoat.com>
References: <20230221124613.2859-1-jiaxun.yang@flygoat.com>
 <20230221175423.GA15247@lst.de>
 <A8AC22A0-E883-4D9B-A629-5A3721B976C5@flygoat.com>
 <ed2d7750-786d-82a1-5e79-1f216a682b20@arm.com>
 <34578218-DC7A-4C8B-A01A-AD64831CCB43@flygoat.com>
 <a46e1840-89be-de8f-6a91-3e4a16fa17c2@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B42=E6=9C=8822=E6=97=A5 12:55=EF=BC=8CRobin Murphy =
<robin.murphy@arm.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 2023-02-21 19:55, Jiaxun Yang wrote:
>>> 2023=E5=B9=B42=E6=9C=8821=E6=97=A5 19:46=EF=BC=8CRobin Murphy =
<robin.murphy@arm.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On 2023-02-21 18:15, Jiaxun Yang wrote:
>>>>> 2023=E5=B9=B42=E6=9C=8821=E6=97=A5 17:54=EF=BC=8CChristoph Hellwig =
<hch@lst.de> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>=20
>>>>> Can you explain the motivation here?  Also why riscv patches are =
at
>>>>> the end of a mips f=D1=96xes series?
>>>> Ah sorry for any confusion.
>>>> So the main purpose of this patch is to fix MIPS=E2=80=99s broken =
per-device coherency.
>>>> To be more precise, we want to be able to control the default =
coherency for all devices probed from
>>>> devicetree in early boot code.
>>>=20
>>> Including the patch which actually does that would be helpful. As it =
is, patches 4-7 here just appear to be moving an option around for no =
practical effect.
>> Well the affect is default coherency of devicetree probed devices are =
now following dma_default_coherent
>> instead of a static Kconfig option. For MIPS platform, =
dma_default_coherent will be determined by boot code.
>=20
> "Will be" is the issue I'm getting at. We can't review some future =
promise of a patch, we can only review actual patches. And it's hard to =
meaningfully review preparatory patches for some change without the full =
context of that change.

Actually this already present in current MIPS platform code.

arch/mips/mti-malta is setting dma_default_coherent on boot, and it=E2=80=99=
s devicetree does not explicitly specify coherency.


Thanks
- Jiaxun



>=20
> Thanks,
> Robin.


