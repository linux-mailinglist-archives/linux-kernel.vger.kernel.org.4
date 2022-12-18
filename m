Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA86964FE83
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 12:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiLRLAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 06:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiLRLAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 06:00:38 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EB7A444
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 03:00:36 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C274A32007CF;
        Sun, 18 Dec 2022 06:00:32 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 18 Dec 2022 06:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671361232; x=1671447632; bh=CTcjQagkOe
        Sa4wcIniJx2lfHjoYHcejOy4bVh6qCaDw=; b=FwI4rYy8XnVjMnL2uAAbtTiCW7
        4bw+Cn6o3BaQMRFwo4GmDG6eSopP08OaYroIfhUEaxBrWwSaKkPhodB2x4vfx5m7
        qJlpPDDaHR0lEyCPbQZQ7VHDI6TbYoGlZDZgkkbP624xPStes84BOPWrS0koQMyP
        X8YP75f1uogpJtDwczYTR+AVr7FU5tzAAWe9lR2JLIkZCHhNzwOstiAB+83jDxTA
        zp791Z2C27K1J7XnKQpBqIDTiULzzJx8wIxRbvy36cTtu1JoTZeZC9kPwxlJxtRo
        XC7/Mvx6N3ODUN7TSZsBKfp+zk+mORWJkG3hb4Bg8KJMtf8EkbrpM4c+AJZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671361232; x=1671447632; bh=CTcjQagkOeSa4wcIniJx2lfHjoYH
        cejOy4bVh6qCaDw=; b=CdBByvMP3+1RE1OMXB3vBRUEXpnudYUEiwL8lzlWPR5z
        zm4ziLsk0PLej2Q1vAgasi8sAsasxtipMpz51+YwKFn53CwL34EozI0Qdvnbe1ac
        8j6MGIOoU6O337RR22VYrm7Jq6yHTiTQ1GD+NEjWW59TNjiyMLgcOD9uEyxT6gWG
        x1W9YWBnjSPT16Z6SeCV9kS5IeXQsbRvbl/5m5AxJZjGILgJ9plkWTguuXKBqjNr
        WQQ/OqjxYzaFaalXXOF6b3s4XooP/cPMsbMQzOVsyvZXcoVSqKsf+ocNMuO8M3PU
        c7pBH7UskgWnDzD1ewkC/Ej27nbUc3DETwpRcbnS4w==
X-ME-Sender: <xms:z_KeY_KGduKnm3e2bikGvJ3ussGSEBp52ugTB4-6-T7UusEBRRLZLw>
    <xme:z_KeYzL9wnTzyStnN9CWmKFWv0WKxBRhvKxqJWzMLGxymoSKcqo4rh77gaVdmK2Nb
    -9J_rV53hyW1AnUBiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedugddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpedvudfhvdevleehveffueevueejieejudfgffetiedvhfefkeefuddvkeegvdfh
    ueenucffohhmrghinheprghrmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:z_KeY3sS-aMSC__eVRx3WUS5tDvE7R7VLLLCqZmB_0U3LPF88Y2C6A>
    <xmx:z_KeY4bM7o9IpHAtMQSxkqu0qMOlPSA0309NHwacD9CuAsaVxc5BYg>
    <xmx:z_KeY2Y9OdD4r3DU7o0I2c6Ym8lREpKdHvEsyV97ba99uSTVLHWfKw>
    <xmx:0PKeY8kaCHN5mwRC3rONu_trKfBLyxcGDH9691mi2ql7ONzZmdBe3A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BEB05B60086; Sun, 18 Dec 2022 06:00:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <9a4d34d4-f78b-49f0-a57a-b80432ad652b@app.fastmail.com>
In-Reply-To: <m21qoxiw9t.fsf@free.fr>
References: <20221215160747.2173998-1-arnd@kernel.org>
 <m21qoxiw9t.fsf@free.fr>
Date:   Sun, 18 Dec 2022 12:00:00 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>, soc@kernel.org,
        "Russell King" <linux@armlinux.org.uk>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ARM: pxa: fix building with clang
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022, at 21:45, Robert Jarzmik wrote:
> Arnd Bergmann <arnd@kernel.org> writes:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The integrated assembler in clang does not understand the xscale
>> specific mra/mar instructions:
>>
>> arch/arm/mach-pxa/pxa27x.c:136:15: error: unsupported 
>> architectural extension: xscale
>>         asm volatile(".arch_extension xscale\n\t"
>> arch/arm/mach-pxa/pxa27x.c:136:40: error: invalid instruction, 
>> did you mean: mcr, mla, mrc, mrs, msr?
>>         mra r2, r3, acc0
>>
>> Since these are coprocessor features, the same can be expressed 
>> using
>> mrrc/mcrr, so use that for builds with IAS.
> Ok Arnd, but "mrrc" is an ARMv6 instruction if I'm not mistaken.
> Yet PXA27X is an ARMv5 XScale instruction set IP.
>
> Is that patch correct therefore, or is it just to make clang happy 
> even if it's not correct ?

According to

https://developer.arm.com/documentation/dui0231/b/arm-instruction-reference/coprocessor-instructions/mrrc-and-mrrc2?lang=en

"MRRC is available in ARMv6 and above, and E variants of ARMv5
excluding xP variants". I'm not entire sure what "xP variants"
means, but we do build for ARMv5E, so I think this is actually
correct.

    Arnd
