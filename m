Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D4961512A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKAR6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKAR6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:58:06 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8358E1CB1C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:58:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E2BE45C00B4;
        Tue,  1 Nov 2022 13:58:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 01 Nov 2022 13:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667325482; x=1667411882; bh=A6U+kzuhbp
        V6DCjZ72Q29RzpIC4msYQyaXKxULxy43U=; b=W3KaahBKJDAuy2s0T2smBIL3Nu
        GvmDbAq4YfNCHkrw+Ip1+Fl+PAtBrCCxfeG4r04mSf/CZkGFUy6LR5Q87Xq66bCs
        HuDa24osi284FkwXY7BL8NQP6dsP6FZN7c7Yc6GSOV+COwh6ETsAnrNMlmwPc/xX
        V14ktLMuIv+a6HuWNVk2QdDK4Z+sbJGo07eXaVc833sLm6007TWwasTC4s3QKGlh
        QDuG5dnvf7zs/Z+bYjM5DQc1uwd92ugVUHPsZLhPLlJ9sjM2ApKap8RdJGpqPtDc
        qTI8z6WjFc+IW0d6GxshXevVDkuid8XyV0fKxmADq+eKhd3DHwneqlYQGQ5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667325482; x=1667411882; bh=A6U+kzuhbpV6DCjZ72Q29RzpIC4m
        sYQyaXKxULxy43U=; b=iBluY6SWgQPVXkscw3wzEGGWcm8DF+WVvYc/15WWEl98
        BMYyLD3tR4OOUeriug/EQZerM5E4Xf3L5Io+Ai04PSuVstCk05bEy69dasGRvfzd
        Ufv3QygqVQwM1HF/5bAZnfdphKJUuHWBlCrz6gNlppQqU4fy4vf3vuU1eQDwnRLn
        g121mj4UwFzfJaf9WGNDiBiSkZYmYRcr3jwlleJa8PTMYtgl1qahhT0fyU6g07BC
        AAVKVgZFbWwUXoQ811zHrbHKLuQmwZTUKbz42oiWCSF49db7/ggIi+f0fZGfkjXV
        YU4l1Q6S9o3HYIZXkACIpG0w5ebUPC4HqleZj0P/eA==
X-ME-Sender: <xms:Kl5hY_VDe3uaPLi7pOKM0Ret98m75-NL-RaB4gGUEmQU745JT_SWMw>
    <xme:Kl5hY3kpXLaVdzt_reFDEm_z2F4RayIegmQpMCtEhyzliuk8WDzIBHvDdrumEqJah
    bPpo7Mmh618FY1wtkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudehgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Kl5hY7a2bJMrPxXec3XEuqPjKxNSAKaM0yhvFLQalltPPrzeUyGjhw>
    <xmx:Kl5hY6W7HPrWRR0jtD4XP1yOWtZlqXRCfXTsd7ov78_LXQGnZUdxQQ>
    <xmx:Kl5hY5nnMZ2Emv6mHv3KGUICZNSVXxilucQaJKjC37uyy_moDN0tOg>
    <xmx:Kl5hY_jLMkpzxSvCq69bkV4gvyArNSva1EayyJcbxc5HfR4PlEJKTg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1DD5CB60086; Tue,  1 Nov 2022 13:58:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <29d07648-29a9-432a-a666-f9c9e55c32f6@app.fastmail.com>
In-Reply-To: <CAHk-=wi+5sRXL9fTHQRiR9zVEFDPhQceWACBG3QQ=9xoRVmR8g@mail.gmail.com>
References: <CAHk-=wgJVNe4mUxGJE5B-_GMg0oOgxkZz3UxehVRiCT3QvoZ0w@mail.gmail.com>
 <20221101170015.GA1314742@roeck-us.net>
 <CAHk-=wi+5sRXL9fTHQRiR9zVEFDPhQceWACBG3QQ=9xoRVmR8g@mail.gmail.com>
Date:   Tue, 01 Nov 2022 18:57:41 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        "Masahiro Yamada" <masahiroy@kernel.org>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Miguel Ojeda" <ojeda@kernel.org>
Subject: Re: Linux 6.1-rc3
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

On Tue, Nov 1, 2022, at 18:29, Linus Torvalds wrote:

> IOW, I expect it is - once again - some random linker-generated stub
> that ends up causing problems, where the re-link stage ends up being
> unstable because of some subtle alignment issue or other. I think
> zero-sized symbols have often been involved.

Linker-generated symbols are usually the cause, but those tend to
be fixed with the extra pass, and Guenter said that doing an extra
pass does not avoid the issue here.

I have not tried to understand what the 73bbb94466fd patch actually does,
but as the description explains that it uses either 1-byte or
2-byte encodings for some symbols, I suspect this is related to
the new problem here, possibly it gets into an oscillating state
where making the symbol table shorter causes a symbol to use the
longer representation in the next round, which in turn makes the
table longer again.

What I've done in the past to debug this was to change
scripts/link-vmlinux.sh to use a larger number of steps,
mainly to see if it eventually converges, grows indefinitely
or oscillates. After that I would compare the temporary files
from the last two different steps to see which symbols are
actually different. Unfortunately, there is no built-in
debugging mode in kallsyms, so this is a rather manual process.

       Arnd
