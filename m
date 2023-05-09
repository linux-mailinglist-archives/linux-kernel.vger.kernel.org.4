Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626186FC1C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjEII2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjEII2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:28:44 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2B11FC9
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:28:43 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E3BDD320094E;
        Tue,  9 May 2023 04:28:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 09 May 2023 04:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683620921; x=1683707321; bh=wi
        uGvxE6dVHzHMA6mJjjOb0RCkGJ66mXirS+WyQ3Xrw=; b=EmPeF89AaY76/nJ7Oa
        ohf+Xbqupbycybi5aJBelN8UIAf/BTqO2Su6Igbwq6agHToAG7Ds7LCOD7G+2yVK
        PBQV5KOBQGRTIbz6F9p23KnDCsXyXbkjKK6k4t04YSKaU+fcl54ecrTZNyLbstKy
        8WNVthv1Wk3omY5msYMqfCUpgjUO04sh4CfUQ5kIgswNs6nTlhet7jYm+J3IUSOy
        MBPMctYCt/1c8dU/RhtR+nLunZZYc3OiEASfJhBPVZkUVKAAK9Ceu8bBQElhwg9/
        6W/s1hJu+JZaUshYGp+0PC4MxZX2+pew5lNuT78qoME07LLtGqXRDw0XEKPdkb92
        Vh4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683620921; x=1683707321; bh=wiuGvxE6dVHzH
        MA6mJjjOb0RCkGJ66mXirS+WyQ3Xrw=; b=kkYHwE8yb7JNRqdmvpnHgBaNaF9od
        WeZDXobnOTjYSAtMxDEIWgRd0n8qkialq+KfOcDs50AXXJ1zC+z97NJLjR40rvza
        BjJUPoy1+aG10N80UVRZnyam5JjpjsmJJBn/eLHM5zyxvc9zkccaHNhmChnGCfuR
        6BnGr//MpQvyDI5V8eivyKDQ/TaLsrhzVxZtkQgIUh5z2lOKFdgayiUbES+GL0Zk
        m4VfICgX+1zbJ8UFLDIFAQTlYbO7A5VJ5Vwxkjrapywc5iCdBxfIICcRpdulORXD
        9Ce6RkQZK5y7H2jW81jFCba6o9rr8BLiory3qhdTyZZGGPswl+RH5SbwQ==
X-ME-Sender: <xms:OARaZAgVMaoZw1Z-8in7VRTdRwT9jiEnFfktqjheKx2aTyvwdxg5zQ>
    <xme:OARaZJBAISv88zkNyy0NFQmR_gs7dNQHVa-2fgfT7-Dp08i1mngaR1016GrwLkdjY
    I6QI5eOu_FA9jgd_zI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:OARaZIE1Spknq2_s7IPd1RXiIvAl-e-xc6Mts2RfBmLVCk88YqgRnw>
    <xmx:OARaZBQaemZUFhlt_a_3ewbVo1Y2nDTEUSmr-LiC2kgrrobE1ulgHg>
    <xmx:OARaZNzWHvTAv_hvdkK2h1Nj_xMyCzGuVK5kkJDKJe7vBAdWlAOCgw>
    <xmx:OQRaZNjjyuJnHobIP0RJIDp5q4iTS5VhPoa4iCih81kggz6WA2J8MQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3F768B60086; Tue,  9 May 2023 04:28:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <63dc3d1b-ba17-48ee-a02e-83b2903e360a@app.fastmail.com>
In-Reply-To: <de6432db-0da0-b535-1f44-04541116be8b@ti.com>
References: <20230509063431.1203367-1-a-verma1@ti.com>
 <46b0dbd4-5695-1a2d-8d06-0a60a7c3a151@linaro.org>
 <de6432db-0da0-b535-1f44-04541116be8b@ti.com>
Date:   Tue, 09 May 2023 10:28:19 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Achal Verma" <a-verma1@ti.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, "Mark Brown" <broonie@kernel.org>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        "Nishanth Menon" <nm@ti.com>, "Milind Parab" <mparab@cadence.com>,
        "Swapnil Kashinath Jakhade" <sjakhade@cadence.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable PCIe controller on TI platforms
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023, at 10:08, Vignesh Raghavendra wrote:

> Also, see [0] for history. We really want these to be 
> modules unless its necessary for bootup.
>
> You may want to revive [1] and get it to mainline
>
> [0] 
> https://lore.kernel.org/linux-arm-kernel/CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com/
> [1] 
> https://lore.kernel.org/linux-arm-kernel/20230110153805.GA1505901@bhelgaas/

Agreed, that seems simple enough. Ideally these should even
be removable modules, not just single-load but unremovable.

Doing that may require changes to the cadence PCIe host
code if that does not support unloading yet (I have not
checked), but should not require any changes to the core
PCIe host code that supports loadable/removable modules.

     Arnd
