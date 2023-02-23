Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE086A0480
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjBWJJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjBWJJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:09:15 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA94C9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:09:14 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 866FB5C0170;
        Thu, 23 Feb 2023 04:09:13 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 23 Feb 2023 04:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677143353; x=1677229753; bh=UZMlt3Yn1d
        T1N9aFSwEfF8fW+mdVsGDaArzqHOHWJe4=; b=jdYWgvnlz1Ly3DPdfqn0wBSleP
        0li2neTOy/p9FOJ8ekSZuyKNFe0pHLF1yFJ+5y0ITs3Du0fWjiEprjBkp9u2OtJE
        7HQ1+R6L0x2XZMUi6Xo4u2xdCAtaQCXUSVLYYrYbxFZt3HwRYuuDTSfiS8gCbMJ5
        bzfH1796x3yl1QwvYXPqZLBZTV66Dd22FGdG/6Sn9Vl/hMNBaGrFqXMzxsokg7dj
        o0qr/w53/8tzC9ilxN2BM1Ag88s+W26HAx6V0ZaIfRKurt+dTJNMO8scDCC8xb/h
        plUF+6K+xaGvEi5kiwKr33XXERQu9uj8aOWlBs5OAeL2TY1DEbuKOWkWgMeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677143353; x=1677229753; bh=UZMlt3Yn1dT1N9aFSwEfF8fW+mdV
        sGDaArzqHOHWJe4=; b=azRIl7dKqtZYpVNn3EgTEg5wVkE2wtjNAJ5Y3B+MDhxR
        Qps9Xg/uddCdE1S3xC6+wQQmFtDLFTF2YlDgeJHcbvRfkFuoEt4Di2jNAxX0tUH1
        MYuL8+RZU0Gy3qf8QwHymx9WwgTjipl7SncaNA0Yf9cTbdSNkIQVRll6nA8K0dPC
        GcKCanCgBB9rljCfFfiBOF4os0CQmzutoicb8H2jqBTu834S2b/9ZafFkjMY2JZ+
        o2TWhXKJU9blUHwiJXS3qAz4be03R9vBR94Jc5JK4HQl8fpV6HdkxNJlPGKVoQ0w
        rWT8I2WMHSDwA0X+2uMXirqfNvsElkIT0EnJ3NnhPQ==
X-ME-Sender: <xms:OS33Y2ZBRRAMlrSVSgKSXRsM-iI3HjIkjiw98syU5Q7lb7W6AAQSKg>
    <xme:OS33Y5aYPCzBUk9UWPNkBja4AifI62oMXo0XZwbqsdaGMAoMHCrPUdsVFvc0KPU0N
    wakWNqquQo9zURuoXY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekudcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeetffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggv
X-ME-Proxy: <xmx:OS33Yw8UjPzy1tZuPu3HGnjlvz5Hxr8VQMSKXZ60pzvsuOtAfNuN0g>
    <xmx:OS33Y4pwYSaySKUugjDJSQVL43uGWlKSjUXdRGOgOu2aMhUmPgBXUQ>
    <xmx:OS33YxqrFIrhJJqUKO-qh4iAxQpZN_7PiQTe9PSbxF5BlJEiRCY2WA>
    <xmx:OS33Yyl2ZqrhdNyKdrxuX22abZckegHWM8ETl3vlMalOR6--8JJKIQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2814DB60089; Thu, 23 Feb 2023 04:09:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <35a235c2-fed7-49d1-8f64-21924d7eb6ff@app.fastmail.com>
In-Reply-To: <Y/U+3PZsbLw++SnG@google.com>
References: <Y/U+3PZsbLw++SnG@google.com>
Date:   Thu, 23 Feb 2023 10:09:15 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>
Cc:     "Russell King" <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: spitz: include header defining input event codes
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023, at 22:59, Dmitry Torokhov wrote:
> The board file for Sharp SL-Cxx00 Series of PDAs uses various KEY_*
> defines, but does not include the relevant header directly and instead
> relies on other headers to include it indirectly. With the upcoming
> cleanup of matrix_keypad.h this indirection is now broken and we should
> include the relevant header directly.
>
> Reported: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> If there are no objections to this patch I would like to get it through
> my tree. Thanks!

Yes, that's fine,

Acked-by: Arnd Bergmann <arnd@arndb.de>
