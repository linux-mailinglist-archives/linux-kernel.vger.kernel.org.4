Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC56A6E44
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCAOUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCAOTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:19:35 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06BD32E66;
        Wed,  1 Mar 2023 06:18:26 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 875B45C0163;
        Wed,  1 Mar 2023 09:18:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 01 Mar 2023 09:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677680305; x=
        1677766705; bh=IU/BrE3ixZGyLbVgFOOh2R6wZHPN5yx1P6eJFhscw+U=; b=A
        yJkYHBaTE99CfV0zEVGrqCLHzthiENTPQupgFPss0vM4CUrpWrkivXAApij0gYsT
        +xPD3Rpc/++PsYBQvrW9hn/hGp5z1kJoDTKu8esHfTpzxYVj9sjk/5h3FzsALxOv
        +quyZGu6DFBwv/POff8XjUz23+OiS94YV8ZMnxMa30GHbjgA0qdpfeDWzdFegUTF
        JjgiC69It8pIoz8XTrMim7wSiJQMJF1b4cUGUEECraqzCDqEeaP20zLliPVFQSXu
        TFPADhCVuhmaN0vJCDGwg+YI7rNie7XSDZJJWMWzxl32RfaTabum+2CLoI+WuKF2
        vmkG+p5H/Nx0Wcq/maTew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677680305; x=
        1677766705; bh=IU/BrE3ixZGyLbVgFOOh2R6wZHPN5yx1P6eJFhscw+U=; b=O
        2DMRQr+RXddOPya6ZL9/CwAlS0f67jYqs3r1/Tlci3ZUhBGuFRNTySolg0fc7Thx
        Qwacb6833WSWgprw759VX997Y1jW+3qR/bkZkoKW2rIWeamlDTJeiURTx2UoPtON
        37KjaIaMAuuf+VuEQlHeQ1/zcmzg/xbOlgtcyA1S2Prbx6J+UQJM25m5oczStOf/
        DSdt8RYBPeIGDB9mZQShW0pkEPhqjglEsNSLbjsPcIa1rQSzYHphHvExC+MV1uel
        Gl7rmQYC6i2Q33m6SdZ8SQbk9LXGoK4Cda7mixuoDB6nOELcKMRoGgJ56iG6GTQT
        WCXy1cmw5jPXa4B4W3r9g==
X-ME-Sender: <xms:r17_Y-tUFo2LL8eR0fi-GokoMXitP2n_JUf-XIy5nnStsSe6FJRj2g>
    <xme:r17_YzdmZ32m1yaGJBQRp-URupP-6PBTv_L6UVtboHOI4DESaWNr17PvtrpLA_r8d
    Yf3Wwzo8la7sbRUHjs>
X-ME-Received: <xmr:r17_Y5xH8C7zLFMosNSu7Rk8dva1PbIKD44Fj8-pO12vIfF3EwUQ2C7l9wT2zjo29ZAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelhedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:r17_Y5MRWG36jqqYcsG4mbJe5qRD3FWZkO-uj5TIkFXI7jBOennvjw>
    <xmx:r17_Y-9REZjCJ_ziFlN4x3EGZMLQymJqqL1O5OR4K6IL99QYuA_3vA>
    <xmx:r17_YxU5N5rhCyqTaH1Kivq2jpad5SoUB9zVRzgaSZZg74d7WWBPiA>
    <xmx:sV7_Y_09vA_UNMGlZu7NoezTW3ovu03S-v6NaeYyYQxNqODnkQ-mww>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Mar 2023 09:18:22 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v2 5/5] of: address: Always use dma_default_coherent for
 default coherency
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230301130613.GC467@lst.de>
Date:   Wed, 1 Mar 2023 14:18:10 +0000
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>, m.szyprowski@samsung.com,
        robin.murphy@arm.com, linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B43602D1-89D4-465F-83B1-CD106E07CB29@flygoat.com>
References: <20230223113644.23356-1-jiaxun.yang@flygoat.com>
 <20230223113644.23356-6-jiaxun.yang@flygoat.com>
 <20230301130613.GC467@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B43=E6=9C=881=E6=97=A5 13:06=EF=BC=8CChristoph Hellwig =
<hch@lst.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>> - select OF_DMA_DEFAULT_COHERENT if !NOT_COHERENT_CACHE
>=20
> Doesn't powerpc need to select CONFIG_ARCH_DMA_DEFAULT_COHERENT now,
> or even better should be doing that in the patch adding that
> symbol?

If I read the code correctly for powerpc OF_DMA_DEFAULT_COHERENT is only =
selected
with !NOT_COHERENT_CACHE, which means non-coherent dma support is =
disabled=E2=80=A6.

>=20
> In fact I wonder if adding CONFIG_ARCH_DMA_DEFAULT_COHERENT and =
removing
> OF_DMA_DEFAULT_COHERENT should be one patch, as that seems to bring
> over the intent a little better I'd say.

