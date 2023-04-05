Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81D86D86A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjDETSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDETSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:18:32 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E104C12;
        Wed,  5 Apr 2023 12:18:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0E3615C00E4;
        Wed,  5 Apr 2023 15:18:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Apr 2023 15:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680722311; x=1680808711; bh=bE+E0Y1C9R+WPWsn9rc36pOCMKER1kFL5t/
        J3nXSkvM=; b=BukNnHfAZxYDsFASjrk9opQ9o7F8nOt76VeWt7zjvRLfegXY6ld
        3WRzgQnlAy678Lp5XjA8asAjwATG7PaCQh1ctXdEVZMta3WtsyjV7DzP3F6ZGWr4
        t0D5DUJ2vdEoMp34xllFcuG9XFTYWtn7vrUz9PKL8m0L7bTnRndWdg/OG1+7LitK
        rLW1mNU0hYSLCcRTM3RI1cJxIRbRMRvRxJB2Usr0QOgvXxng2kByDwZtaEz5jIw0
        9l34gvWpIbcn08L8JBTVTvfbov5wkyhiu8s/tbbb60qPDWSE3uoPVsuvygcwQTs4
        zz/2Hd8vMBfjW8XRGuY48WHOpS0D3rDy5UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680722311; x=1680808711; bh=bE+E0Y1C9R+WPWsn9rc36pOCMKER1kFL5t/
        J3nXSkvM=; b=mBzRuwmi/mH5BXBc0hxzJWMuNCjioL5desU9eaU//+9f3/YEoTX
        6jt7qmS/umdvEWj2swpa5t1wgWyWLe1G0fuKZSDFM7db/dQc9+uIe3EFQnHTFlPZ
        55AEAnsYagt9/09dvaTUGxLmkc/5000PhXWWn2OZLL8oAGQYAODLFJAiOaNOlqs3
        Gtakgb1Sl53iaP/R6m1JilDgcVQ0imDp4aKrui1X4GDFSWbYZOD9RuZ7XNpjd7NV
        uv89qdNSq8YDXVYmBNC6NLUemElP4e7WTuWjK7NjF0mEhuBDFZd50jtY2DwIYCJ0
        aJX1VZ+p4j7w/Cfb/GVJl3rYYdZyVC3SsCw==
X-ME-Sender: <xms:hsktZC4SbR8plVQVShy3o1Sw8eIabxCPNdZFadRGi6Lyx3DhDnEFzw>
    <xme:hsktZL4tJE5UKk5M68Uz4SneFr13WBW9gn5Dv_cCkte1xUREh2PQG4tT95cbcn0eQ
    WzmTUOhtpQP5m9X4_U>
X-ME-Received: <xmr:hsktZBeGCK0aiqj9pZD5nzzUONLXAvHANBMioWf7ikPO_ITFCoib0cZToA_IX6pWtpqh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedutdejffetteefkeejieehfeeuieeguedtveeijeeviefh
    ffelvdfgudeihfdvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:hsktZPItMSlLhkAx8zfEIkAOM4OycdRprb_u-hIk4rembOsm1O-pEg>
    <xmx:hsktZGLAkyzq2cH3bveUkLo6b-LhCbT_UsXFGlEBLiIu3u0GJzndDA>
    <xmx:hsktZAyS_5Dw4xeNnYkRO2KxsQ9rVPVc-Bu3Kg3Vgkd7L3AdUuEyjw>
    <xmx:h8ktZDWvlYa1Dun4724lVv4zwURsR0r5YKOM5PUzyetJk6g_rKFtPg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 15:18:28 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH] MIPS: Remove deprecated CONFIG_MIPS_CMP
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230405185128.15237-1-tsbogend@alpha.franken.de>
Date:   Wed, 5 Apr 2023 20:18:17 +0100
Cc:     John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2559C525-E9DC-43AA-ADBD-B2C2262DA760@flygoat.com>
References: <20230405185128.15237-1-tsbogend@alpha.franken.de>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B44=E6=9C=885=E6=97=A5 19:51=EF=BC=8CThomas Bogendoerfer =
<tsbogend@alpha.franken.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Commit 5cac93b35c14 ("MIPS: Deprecate CONFIG_MIPS_CMP") deprecated
> CONFIG_MIPS_CMP and after 9 years it's time to remove it.
>=20
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> =E2=80=94

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks
- Jiaxun=
