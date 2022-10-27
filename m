Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7742C60F33A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiJ0JJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbiJ0JJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:09:35 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924D9FEE;
        Thu, 27 Oct 2022 02:09:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 620FF5C0138;
        Thu, 27 Oct 2022 05:09:31 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 27 Oct 2022 05:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666861771; x=1666948171; bh=u2xJJZS73/
        d/o0CIY2bxlyBu06Lupq5Y1/URzXoJcZI=; b=rUKXcm/ZhA8H39d7Mex+vFksm2
        Qmi6KcNPjWQvRWB12gV8FTf66HPVHIIA3nYIek0C31gN+JN5Ak1sDL7DM2mLRfVs
        RRCRnZ4q9ByYglAPDZDcXb6P/ICiQYtL44cdpumyX3jIexaSuM8Kcj0H20+eaZfy
        sfFqsByd37G0970SHeKG/pbBAKPNChWG61mB6DzOMkKCSXTFYrEzXOEgzSWO9N/I
        tPDXvnIxRMLa9EAbW0ieaMW45agQW6DqvolCY3qc/quOEV7qb5UL4ANB2KWjeP3R
        Xvee8PU9sHJZaDkiPxLB73yJi0h1g2p2TV3c4uj6imLbCJVzolZzAAgacAUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666861771; x=1666948171; bh=u2xJJZS73/d/o0CIY2bxlyBu06Lu
        pq5Y1/URzXoJcZI=; b=SdiOIhdIJ8srI2G1QM70siY4nnlcIEMsHF0g+Lil2Rd2
        kAyh8Nhsrgu6iyT89NTTAAAyvaE4Z0B8SeXYyI4GeKuq+Y33p9D3cVC9yBi5tCpK
        FL30Acjm208Dkl2yl+PyKSPq8xKMs+eb+hg39HUISIdVDkttQxsjS6eyusj6Klqs
        Xlnk0VFqhU1eTOLybznPzWfbKgfLJLGasSlfCUBzs646X3Q5ev1AmKKnUiA1GUOm
        y8olD3ck/4/NMjMivWcs2/j0NF4zrTC1+KhxlgWaHtIb3rVkizCCBE8bW061WD+3
        2jh4AdSgPcRBt1m0t6N02o6pHkwE5U0sU94GYCWuNQ==
X-ME-Sender: <xms:ykpaY0KWaotJ45JC5ZtlrW6LfAJDZgJlDBi_8IKWod2VHL4uNJ9khQ>
    <xme:ykpaY0JiLyiWR0aGDXKRIbpXHPlk7D59WCk4jGnM9WB7pgelEpzV93GVZSj_WCHLi
    LW6drCasIWZs7TEZpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ykpaY0t6rHaBzO-MUiy4m4ByeJtxXyIoWktJqjfaEIqRfy1rnC_5Pg>
    <xmx:ykpaYxbgVok8mkEjSt4JuyEVPwIutPHGRIKM5wENuAsMfmLDuezsoA>
    <xmx:ykpaY7bx3GuB4uFZWbCuELJxeklHf0ZBaBK9AFreCoD8ekn9mJqP9A>
    <xmx:y0paY5OLajxl7OmgsdR88wMXGeN1HKW-byrpc7FgDG5_-b-k5QYZ9Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 88ADEB60089; Thu, 27 Oct 2022 05:09:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <83c93b5e-c589-4ca9-8bc0-ad3571f7f54d@app.fastmail.com>
In-Reply-To: <CA+G9fYvvtyO8fsYQb25L+bLXUnHJ5LoFToD+cYbKCcE6JUk5FQ@mail.gmail.com>
References: <CA+G9fYvvtyO8fsYQb25L+bLXUnHJ5LoFToD+cYbKCcE6JUk5FQ@mail.gmail.com>
Date:   Thu, 27 Oct 2022 11:09:10 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        patches@opensource.cirrus.com,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Linux Samsung SOC" <linux-samsung-soc@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Cc:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: Re: s3c6400_defconfig: arch/arm/mach-s3c/mach-crag6410.c:183:12: error: use of
 undeclared identifier 'KEY_VOLUMEUP'
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022, at 09:29, Naresh Kamboju wrote:
> Following build warnings / errors noticed while building arm s3c6400_defconfig
> with clang tool chain.

Do you mean this is a clang specific issue? 

> arch/arm/mach-s3c/mach-crag6410.c:183:12: error: use of undeclared
> identifier 'KEY_VOLUMEUP'
>         KEY(0, 0, KEY_VOLUMEUP),
>                   ^

I can see that KEY_VOLUMEUP is defined in <linux/input-event-codes.h>,
which is included by a couple of files in the kernel, but not
from this specific board file, so I don't see how it works with gcc.

Isn't this just a regression from commit 1810e248b2dc ("Input:
matrix_keypad - replace header inclusions by forward declarations")?

If that is the problem, I would expect to see the same thing in
all of these files, regardless of the compiler:

$ git grep -wl '\(linux/input/matrix_keypad.h\|linux/mfd/twl.h\|linux/platform_data/keyboard-spear.h\|linux/platform_data/keypad-nomadik-ske.h\|linux/platform_data/keypad-omap.h\|linux/platform_data/keypad-pxa27x.h\|linux/input/samsung-keypad.h\|\"keypad.h\"\)'  | xargs grep -l \\\<KEY_ | xargs grep -L '\(linux/input-events-code.h\|linux/input.h\)' | grep '\.c$'

arch/arm/mach-pxa/corgi.c
arch/arm/mach-pxa/littleton.c
arch/arm/mach-pxa/spitz.c
arch/arm/mach-pxa/tavorevb.c
arch/arm/mach-pxa/z2.c
arch/arm/mach-pxa/zylonite.c
arch/arm/mach-s3c/mach-crag6410.c

   Arnd
