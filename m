Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A29169E8A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjBUT47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjBUT4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:56:54 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAA327D7A;
        Tue, 21 Feb 2023 11:56:49 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A00E832003D3;
        Tue, 21 Feb 2023 14:56:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 21 Feb 2023 14:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677009408; x=
        1677095808; bh=D+EAqyaE5zMgnzYA22Liuhdo1IF89BVfK/4WPFLbppM=; b=Z
        KHU2jsFQm9uexFxGI2Z0OApDsfCJka+xspJpAdL3TWoL8cE2WNPu/uT9aua0Ube9
        1PAKNVg8rzNEcerNuphXwp65VeuTG6NhE/11Pr5Iy6Pl8J1iF/WVxGijK1KzgTqM
        q6X35pNTzcKFpPMMfFKLjbqsE/YC4PIWrXe10zdp/KwGMDxZesXdpiICmcNO/+w8
        CSXOnynQFfVYa4u4CZGvoYbm1896GCgeVKB19huqFBWxmXLTG/LwpZXvV2i28cn5
        rDBlJZ0OAnTO4xuPpEe4Pmg1yhZe4KstDaduXMC26GKfSWpSCjr0uU6BtQH/NtTN
        NJZs7agVX7/Bm4ikoOH0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677009408; x=
        1677095808; bh=D+EAqyaE5zMgnzYA22Liuhdo1IF89BVfK/4WPFLbppM=; b=f
        T03xCXKULVVNzINoj98uLvUUmzqrJbs+s+SatZ0FQKZhNsRqC1F1kBZrm+oESy60
        zCjT7HWnFW6Jmrj4wrcxZwH1ML4Nmb3Cm576z5bxqCMTLq24BZpPFiWIfKDKjBhC
        p5suVLHM2AZ38bV6CLqNDrN4w2AcwZks/tSyAR7DJR2ba30dAr5sEfKo2agIvY6n
        0+18ksXk97NHAf9xJrmarqV2Uc3i1Se8VoFevUYwI7cPFF8Lx+v50qAGDHCwaHXc
        8Oc8/hbVG1r5eYIJ9A95Z/EYn6F3pSYO/otapB6CnSCOiq7Z4UH1T+KX1Raq7Fdd
        HvYX8nhMuvz/k00fR4dTw==
X-ME-Sender: <xms:_yH1Y6Mm5bX8o4LsHLrP1H7ku64UBiqJRJOIuaKaoMA81IeYF-CnJQ>
    <xme:_yH1Y48BgpO3Lv-VRASKyUyVdLSvlJHXR8DmbqTtFhZGQuvNHgRtFiyEFWr6P-pkk
    dc3n1EeJqRr9WdrAOY>
X-ME-Received: <xmr:_yH1YxR89QQj2qCmVevICBInTVzGNdosiJY4FsmJFT0B-H2VlZub2HHillAg2fhE5gj8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedutdejffetteefkeejieehfeeuieeguedtveeijeeviefh
    ffelvdfgudeihfdvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:_yH1Y6s4U6lOcPu9bf69CRkcyBUCHz8IMZ5yVgr_CIVjmIh_ea45oQ>
    <xmx:_yH1YyeHQKG7wXRremnfOwVFaMzpow-2NnyJJlSnXtDCe0RYGPfGmQ>
    <xmx:_yH1Y-0xwYxMWDtbzo6tsf4WYmc64cvUV-i9XmQpk5kOLVNhMJWDAw>
    <xmx:ACL1Yy7aI4-8-RSwAenubNvUnV-4K-FdfoTlGUcRlSA1d8v-XqopOQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 14:56:46 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH 4/7] dma-mapping: Always provide dma_default_coherent
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230221175813.GC15247@lst.de>
Date:   Tue, 21 Feb 2023 19:56:35 +0000
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>, m.szyprowski@samsung.com,
        robin.murphy@arm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <11934581-71FC-4D5F-B293-1E7213CD284B@flygoat.com>
References: <20230221124613.2859-1-jiaxun.yang@flygoat.com>
 <20230221124613.2859-5-jiaxun.yang@flygoat.com>
 <20230221175813.GC15247@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B42=E6=9C=8821=E6=97=A5 17:58=EF=BC=8CChristoph Hellwig =
<hch@lst.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Feb 21, 2023 at 12:46:10PM +0000, Jiaxun Yang wrote:
>> dma_default_coherent can be useful for determine default coherency
>> even on arches without noncoherent support.
>=20
> How?

I just want to make this symbol always available so OF code can =
reference it on all arches.=
