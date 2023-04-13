Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5433B6E0C37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjDMLNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjDMLNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:13:47 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375B483D7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:13:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C6505C00F7;
        Thu, 13 Apr 2023 07:13:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 13 Apr 2023 07:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1681384423; x=1681470823; bh=zeroeZOOVpqtBj9B1iKAD7YMA040rEXp2Uv
        DToyEcRs=; b=cgd57rmExIugb8pOS7Vb6I2xoVv0Z3epteeB4cXrmNN5dyabgqt
        8oF7OWJTFPm9sow9o5y1i3RGwh1onk/o81IFOXYdxIhzFw6MdbTHOnUF39gCJnNG
        sAjKR2br2QO39WofE87SGel4GufV+t+6O+tPJRYlsbthrF/Kcp1X/jZWrFW1jHwa
        UzxAoBP4prXtv4GNxYp6qqBm/09Pt9uYtdyXBOJScDqqrCkqxJVmUiBosPUJ2/xt
        4TLlNh/ts0nVgyn18FSAEetdHTMmBNjUXKqaFuk983V1xXWv/PpnLC9UC776A9JT
        l1vst9dBfxQboJcLIZMXTF36aqx0+xJllxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681384423; x=1681470823; bh=zeroeZOOVpqtBj9B1iKAD7YMA040rEXp2Uv
        DToyEcRs=; b=Dcfwyo8wsCSRDmbch7A229o65YSGohgygS4m0z1jg8qa3QarPMg
        s7ez4/7iUtXOItr9XF7SwMr57wQa/Pv3Vda9S/zL310K6O5NgRLVyFt7x1Z0T5WY
        vgw4jDeIrm/P9/8hdZxtoHXsXBvrgFgnSJ14TlL7chfGDKHecXyAky0zV0kekkI4
        OGzgYb/0d6pypWz35yfvPoskcTSHXA7cHoPzVf8w18W4HjX6jJ9NQLjEhlKf01vM
        UhS8CjLIn7EMs/W+ofsDQ7Ez8LpyNIeiqPLhVHQAOqdelc0n/e6xMO8DZhdJaSQa
        77rcIHGyI29d3cDOd7HYRvrsmNqmRW4vmCw==
X-ME-Sender: <xms:5eM3ZJF1sR_x35RX_8XzHCqY0nZMrZWqJfJjyjK9zNurAXZWc_Vwpw>
    <xme:5eM3ZOVw0VWivPqI-TVuPML_MVCw0XZ96Ee_jxiMxxwnVeep4vRE02VSt_lxB5Z-D
    fyxYuqqT2mxucQDbSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:5eM3ZLInF1bpvh29Ir3DjulvCAKPkfNf5MULksKHq9shW057yqXSbQ>
    <xmx:5eM3ZPE-ga4ruufpl7j45Nk560sOG21UYFS_WocYkHQfpwlBcgQtZw>
    <xmx:5eM3ZPUWBKwFmG-fIuiNIQCFGesRsANa8_H2trHEUaoOnroyhiWLTw>
    <xmx:5-M3ZAuZXiglAS6o6pWz0ImVBNIWZbqxYh0UzPKPDtx-DGMCBaOklA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B90C9B60086; Thu, 13 Apr 2023 07:13:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <ecf9f34c-1f1f-47af-a470-0a6ae7773724@app.fastmail.com>
In-Reply-To: <9ae523ae-aad4-40b1-8b6b-d5e18bf8b92a@app.fastmail.com>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
 <9ae523ae-aad4-40b1-8b6b-d5e18bf8b92a@app.fastmail.com>
Date:   Thu, 13 Apr 2023 13:13:21 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Nick Terrell" <terrelln@fb.com>,
        "Tony Lindgren" <tony@atomide.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Sebastian Reichel" <sebastian.reichel@collabora.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Xin Li" <xin3.li@intel.com>,
        "Seung-Woo Kim" <sw0312.kim@samsung.com>,
        "Paul Bolle" <pebolle@tiscali.nl>,
        "Bart Van Assche" <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM ZSTD boot compression
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023, at 23:33, Arnd Bergmann wrote:
> On Wed, Apr 12, 2023, at 23:21, Jonathan Neusch=C3=A4fer wrote:
>> This patchset enables ZSTD kernel (de)compression on 32-bit ARM.
>> Unfortunately, it is much slower than I hoped (tested on ARM926EJ-S):
>>
>>  - LZO:  7.2 MiB,  6 seconds
>>  - ZSTD: 5.6 MiB, 60 seconds
>
> That seems unexpected, as the usual numbers say it's about 25%
> slower than LZO. Do  you have an idea why it is so much slower
> here? How long does it take to decompress the
> generated arch/arm/boot/Image file in user space on the same
> hardware using lzop and zstd?

I looked through this a bit more and found two interesting points:

- zstd uses a lot more unaligned loads and stores while
  decompressing. On armv5 those turn into individual byte
  accesses, while the others can likely use word-aligned
  accesses. This could make a huge difference if caches are
  disabled during the decompression.

- The sliding window on zstd is much larger, with the kernel
  using an 8MB window (zstd=3D23), compared to the normal 32kb
  for deflate (couldn't find the default for lzo), so on
  machines with no L2 cache, it is much likely to thrash a
  small L1 dcache that are used on most arm9.

      Arnd
