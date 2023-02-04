Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0261B68A985
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 11:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjBDKjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 05:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjBDKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:39:04 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AA85B91;
        Sat,  4 Feb 2023 02:39:02 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A0B0F5C012C;
        Sat,  4 Feb 2023 05:39:00 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 04 Feb 2023 05:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675507140; x=1675593540; bh=FcE/plgwiH
        cAVpfmlr0FqbcFN9q3FpSWErJCt2r3sUY=; b=mZybz0G+RrfYZ3Z6AksMIRtsQF
        jHF9hTvJOiefPZpxELDGYMJ6tAUmQIWljfR3T0AZNPEjTcmoKU8lI3UkBtJxU/Tw
        355PM+QEo/6YQ+Lt9CJt/B10S0Kz1yYC7zhEwbf/yS+pJUQ9xO05HEab2UOKNU3g
        rmLE1KvDR/0PZbG3BMov/T29D6+SFN4lPbpCJNUjPQGXYdBGoyVCJsHWzyDsre6M
        bU6qNoiKqhh2ZbTDwmbg2I/3QNrQsysSY/3Y/LVT6PoiQAUfmBoeRNhxKbhbu7Wz
        qwTar1LUOnfTCA38AWuN/WqaZLZQpFk5LGDhFjHbAXC+jDyo/Mlbh+riMQ0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675507140; x=1675593540; bh=FcE/plgwiHcAVpfmlr0FqbcFN9q3
        FpSWErJCt2r3sUY=; b=rcAdinM44pfyqTxPSfGahV4qzjI/uAtbtis9Ywvj6yS3
        eowG1IkKQHNxby/somsvjLSR5DcXGtUR2qAQAlS2mnQz6vWvZh46MkyI3U5RdKqc
        ujXvDcSEiL6xIItuEXE1uFrDiO+7AJFj4dKSpvNIwUpSieA792RtWSFxFkT8bdm/
        3voGoLaLBxNpcmz9F2Uo63hoIvINeGTblbNHPsYF5ZuOzGePg7JvEAleq/HXcrlJ
        iuHueQcPKbRGBazaJMZ0Lku2hIPaP1EKobXZALvrASJWRFskRr5vWZ2VJ2kfuWj2
        Lb/p28ItiAY8yZZXckajGloBwXGSSQ/2muK0/cET2g==
X-ME-Sender: <xms:xDXeY-5BUxCZzO_xBtKPXzCdGckBnJKl5QtDUKpg_gC1AJAN_C8wiQ>
    <xme:xDXeY34CDTSmZPI-QenjF4D2RPZEPOBNXCoKersdWEiRSmPbymyoVVsp110fK3Jww
    tCB9UOVcXZkZprYpCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xDXeY9ebT2H0UOKDzayXg18SrXyhhl-vHRWfDi2kf8DQtIUO63ibog>
    <xmx:xDXeY7Lw_1V8cVzXCosLPAF5KjZIahUxpUhyEPQX-InMl3Drxw_vxw>
    <xmx:xDXeYyIslQwCWkHriQRTNEi0kGMKQmEMYWGGSgO-CLbOh97_0ZLhCw>
    <xmx:xDXeY6_-7JaDKQ5aHV-_eYxlShm_hrPQVAKVYXDnQREJuv7ORKI1mg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1522EB60086; Sat,  4 Feb 2023 05:38:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <e2c5a0db-aa25-496c-9a5e-4e996d908dc9@app.fastmail.com>
In-Reply-To: <46dafb64-81d2-c084-97c5-8d01e8b9785b@infradead.org>
References: <20230130130453.379749-1-arnd@kernel.org>
 <46dafb64-81d2-c084-97c5-8d01e8b9785b@infradead.org>
Date:   Sat, 04 Feb 2023 11:38:41 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        "Arnd Bergmann" <arnd@kernel.org>, "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        sparclinux <sparclinux@vger.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: sunxi: select CONFIG_PM
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 4, 2023, at 08:47, Randy Dunlap wrote:
> On 1/30/23 05:04, Arnd Bergmann wrote:
>
> Apparently sparc32 does not support PM (arch/sparc/Kconfig):
>
> if SPARC64
> source "kernel/power/Kconfig"
> endif
>
> so I think that SUN20I_PPU should also depend on !SPARC32.
> Does that make sense?

I would suggest working around this in arch/sparc/ instead
of every driver that uses 'select PM', perhaps something like

--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -283,7 +283,7 @@ config ARCH_FORCE_MAX_ORDER
          This config option is actually maximum order plus one. For example,
          a value of 13 means that the largest free memory block is 2^12 pages.
 
-if SPARC64
+if SPARC64 || COMPILE_TEST
 source "kernel/power/Kconfig"
 endif
 
The issue does not happen anywhere else, as it's fine if
kernel/power/Kconfig is not included at all. I'm also not too
worried about random sparc32 configs since it's pretty much impossible
to build a sparc32 allmodconfig or randconfig, with all the other
bugs that runs into.

     Arnd
