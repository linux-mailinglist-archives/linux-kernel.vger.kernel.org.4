Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFDB73862E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjFUOG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjFUOGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:06:16 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B09E1FC8;
        Wed, 21 Jun 2023 07:05:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6B8C85C0161;
        Wed, 21 Jun 2023 10:05:33 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 21 Jun 2023 10:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687356333; x=1687442733; bh=kG
        p8XyRu/KYD5zBQe0JYjzgMhXlw+OzPinPrPvQp4K8=; b=3ftKYwvqUa94wIL7wM
        /PrrFZkVHfuXjasjIe8LNN8bcmlSIHHYW+CYC95xCTCb+PBBXjPSkitwJbVDyWlX
        oRfowUD6ewKxKc2FcmNYBTmQ6E9zf1iGnueuANX8v3FKenXR5RXdC1KkHWOkAbbo
        FUgzOdKE7rijSWQzVyKNxcYI3oLKPQ+ZflGlB16o19btbCq1khZNLjgX8X9ybcG4
        /tC8hov3gcZeJM4iMWHdrylonjFMnoch13B27zXW2umIkFqtbOXFpRoCUGNBDwoG
        L3AJPlyT7AoPefZzJmN+e8nAio0oT0pJs/hbWGaupluTMDTqst0dLuPg4AtwLXsr
        eZXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687356333; x=1687442733; bh=kGp8XyRu/KYD5
        zBQe0JYjzgMhXlw+OzPinPrPvQp4K8=; b=DyHdsTxSgJMAfjtxl0q9+gMh7MFEe
        ktKE0ToaG9mBPy8OaGPE4pF2QbXu1hRNECN3k1BUx7MIXsaVrpeHXzGDd5mukxS+
        mO3dBVcoyDxHajD2rrY4vNJbS9pZVI2kiGmhHrmjn3F4VGcmBchCPaQW1Kc20862
        8R1ck7kZv3gykDH1Cyl22z1Z0mjWxLnp1JhWcsDe+5QagT8xgkBwMoPN7dWyoSzF
        5kCgTH3ZCSEBBo5tyjNUbO/tamritw39WIHiRbThuceY0dHaeDghCDJcXP9wH4Za
        mCKKF8bRWnM/0RrRdGzqHQ0vuyK7zaQTy8thpiG+UaYazHHyA/3Alae7g==
X-ME-Sender: <xms:qwOTZIt_wyTQA2J9egOYKfsoQTPf8AZuOohOv4TV8phrXYpV5nZUKg>
    <xme:qwOTZFdM7rGEjo7iAnDEaFq-VAa0xHIBfHTpx1rePWEL-SaOZHFJKMPjQziScQAEk
    pozRT6aUhmp0TYajiE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefkedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:rAOTZDwDoaS8-mUPmA7DrTzW_XnSWAqbn52dMI3nN8lFFBKaw74b5Q>
    <xmx:rAOTZLO0qQnrHc7YjCq5T3BA3YhEJ5dn-_alwcEV5FrhOCkGxjiYiQ>
    <xmx:rAOTZI-G4qBYC6aiag0Wn_-8h18buOGvAY8SmMAXSKnnSTnh_xZ-Uw>
    <xmx:rQOTZMbNlAIfAzPVPzsEq9h3gIrtS8EPg7RH5DER50GRI-XVn94jsg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DEF3CB60086; Wed, 21 Jun 2023 10:05:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <64319e0b-c12e-4144-bee0-534ae9cdc128@app.fastmail.com>
In-Reply-To: <7cddcd24-c26c-43e3-8da5-88bd12e27709@roeck-us.net>
References: <20230516194000.548487-1-arnd@kernel.org>
 <7cddcd24-c26c-43e3-8da5-88bd12e27709@roeck-us.net>
Date:   Wed, 21 Jun 2023 16:05:11 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mips: provide unxlate_dev_mem_ptr() in asm/io.h
Content-Type: text/plain
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

On Wed, Jun 21, 2023, at 15:52, Guenter Roeck wrote:
> On Tue, May 16, 2023 at 09:39:42PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The unxlate_dev_mem_ptr() function has no prototype on the mips
>> architecture, which does not include asm-generic/io.h, so gcc warns
>> about the __weak definition:
>> 
>> drivers/char/mem.c:94:29: error: no previous prototype for 'unxlate_dev_mem_ptr' [-Werror=missing-prototypes]
>> 
>> Since everyone else already gets the generic definition or has a custom
>> one, there is not really much point in having a __weak version as well.
>> 
>> Remove this one, and instead add a trivial macro to the mips header.
>> Once we convert mips to use the asm-generic header, this can go away
>> again.
>> 
>
> This results in build failures when trying to build sh4 images.
>
> drivers/char/mem.c: In function 'read_mem':
> drivers/char/mem.c:164:25: error: implicit declaration of function 
> 'unxlate_dev_mem_ptr'

Odd, it looks like arch/sh/ is also missing an #include
<asm-generic/io.h> in its asm/io.h, I was sure that mips was the
only one to still not have that.

There are already patches on the list to convert both, so I think
we'll be fine on sh after this one gets merged:
https://lore.kernel.org/all/20230609075528.9390-12-bhe@redhat.com/

    Arnd
