Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7965369E8A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjBUTzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjBUTzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:55:44 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144B630E8A;
        Tue, 21 Feb 2023 11:55:23 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 08A23320039A;
        Tue, 21 Feb 2023 14:55:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 21 Feb 2023 14:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677009318; x=
        1677095718; bh=y16mUyYY2SPoAJ9bLdflgrytvoVfCX/ep0VQgXN5o5A=; b=m
        IM2d1Srzk3jwEXOtZsU0KtjDQC7KYclazQ/9X11OUF9uqhwl7hg3htlpSLNUPeF8
        fKRLP4nJ68xh+/Sm+1iOGyuleT35dp3i/2Uzkf0ldCc40StoG+t/FawpzAuwsIGQ
        zEexqCT/MMT4QNTJ4IixHg8+AxJy7v6Yb9tGJa8tnC1usbSxpTWxUTnGwO6EPs8s
        BfUKBzde4RUxxSMOfgB0UXciHueqRPij9DZT1t6HAoIxreCkhyzmc3aZAF2suh++
        aOGhUcDodJ0vCE6nJSGwrxI3nFuUaROb1ncls0ovoUQv6CD3aMEcYVy00cMtUNub
        P4iTjGYTaDpfOjUg0rC0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677009318; x=
        1677095718; bh=y16mUyYY2SPoAJ9bLdflgrytvoVfCX/ep0VQgXN5o5A=; b=X
        RowmVbE5gWK9sma5PPmAPczS/CY4vUALCT9yG/TTg5/6YTXJYYt7xXvUngHhWs/T
        pMOXlzLHVcl/MR2Mr7YJ5AASX6sXx+IdBrAvrlOcO6azxjro3Y6mnNwAn6ZPjJKF
        0Z1ZuroOmO7oE43YoCJw4gdsS54EhczHaRoKbVfvQezPgr6pP9EL2IUnpIuw0ffB
        cpau4NcvuZig8/A5iO3zisGShRZe5HEKBbQ8GALwCWIXVWJAO7TFKpMNU+/NGmMR
        LS89fWBEOIPdhhybnYYM7bMRw1c84CrKupRFynbdmpD5+zsy2yRRQ9qm/sww0Z3Y
        MDErqk3Xmp6Hj0VqXwbKw==
X-ME-Sender: <xms:pSH1Yy5rfz2qINRajm2z9_YewJ9Q9YDLpKBVxfaicG75io5ihzi73A>
    <xme:pSH1Y74S6qP1DGlBu6p3bn5f2OYwjDzx4UuRoOw1nBuRZLyhrZEKaFklHRJnvtv6A
    a9bVok57rTxVF6gWzM>
X-ME-Received: <xmr:pSH1YxcHCRpQJwCABE79MLRLdvrYpvAg20pAsQzP1lV00LX-UvBXf46gkGlV1zvfv6ET>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedutdejffetteefkeejieehfeeuieeguedtveeijeeviefh
    ffelvdfgudeihfdvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:pSH1Y_IaTvKu817HkRx4BUY6TtRM4SPQQBgb4Sr1Vh7pLCKHWQtWyw>
    <xmx:pSH1Y2Kp0kZTLSaQcZvJu-VI9X200qzPUKJujJ5QdNb1_hKIZagW9g>
    <xmx:pSH1YwzHHg_LKHOIJSqLIsP3taZf0Or0UkGEytMI-kY-_rov4eys-w>
    <xmx:piH1YzXcxzQeyYk5RvVeorpluWte_iVN60Z3b2TLH04us1Iaq_MbEw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 14:55:16 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH 0/7] MIPS DMA coherence fixes
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <ed2d7750-786d-82a1-5e79-1f216a682b20@arm.com>
Date:   Tue, 21 Feb 2023 19:55:05 +0000
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>, m.szyprowski@samsung.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <34578218-DC7A-4C8B-A01A-AD64831CCB43@flygoat.com>
References: <20230221124613.2859-1-jiaxun.yang@flygoat.com>
 <20230221175423.GA15247@lst.de>
 <A8AC22A0-E883-4D9B-A629-5A3721B976C5@flygoat.com>
 <ed2d7750-786d-82a1-5e79-1f216a682b20@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B42=E6=9C=8821=E6=97=A5 19:46=EF=BC=8CRobin Murphy =
<robin.murphy@arm.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 2023-02-21 18:15, Jiaxun Yang wrote:
>>> 2023=E5=B9=B42=E6=9C=8821=E6=97=A5 17:54=EF=BC=8CChristoph Hellwig =
<hch@lst.de> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> Can you explain the motivation here?  Also why riscv patches are at
>>> the end of a mips f=D1=96xes series?
>> Ah sorry for any confusion.
>> So the main purpose of this patch is to fix MIPS=E2=80=99s broken =
per-device coherency.
>> To be more precise, we want to be able to control the default =
coherency for all devices probed from
>> devicetree in early boot code.
>=20
> Including the patch which actually does that would be helpful. As it =
is, patches 4-7 here just appear to be moving an option around for no =
practical effect.

Well the affect is default coherency of devicetree probed devices are =
now following dma_default_coherent
instead of a static Kconfig option. For MIPS platform, =
dma_default_coherent will be determined by boot code.

Thanks
- Jiaxun

