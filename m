Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8256FB371
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjEHPIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjEHPIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:08:15 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2436D2108;
        Mon,  8 May 2023 08:08:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 78FD55C01AB;
        Mon,  8 May 2023 11:08:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 08 May 2023 11:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683558491; x=1683644891; bh=cv
        5LmLlxQ/Ec9lm2EbwBEEFSvNmUdeMiEO/+fdGXWi0=; b=O70J1buFqq/BiyYgEW
        s3WDJZDi3oSrXKUICGjd5baF4B6pzIRbobtossDCS7gT6FyOuC8gYYwmd8axFbwr
        d8FGarsoCpn3aMcJummqZ4dh7cAB+JpDKJt17tWI3nqke1NMD0dt4enbI6f9Iohg
        r+1dV++2mJG7gi5wElrqFy9bha4Tdv8SudM9ItpWwj0U6pvIhD1V3c04emguRpuo
        wTmBoRRDdRK5MWlodgkaQVHGBPJZe/3zdRbzrYQdw6AQinB7NLFi0f6YTXqevzav
        gLyszKz4KG5ouSA1vSJ+PssKDJu+ogEt+6KWyI17xtiXhgprRfaYgR0k4sF8WP1Z
        gl9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683558491; x=1683644891; bh=cv5LmLlxQ/Ec9
        lm2EbwBEEFSvNmUdeMiEO/+fdGXWi0=; b=OTA3dzqwjslM1twh3wp61IGFSN501
        RZWskN/43ZMoUxvDsmtah4qXOXCreYUMcELkpBhh8SMnoC6HmmCS2rkGl87Om2b7
        rr2yBiqkmQjkISjHkKCbQ6uJG/c1xkLvGDGnx3ky2Wr+bI8jOPAnuZD8jx6+rlRw
        Pt6NayVuTRI57Qr2fvaubIwThSwfA75vkSaCXjKONcORwo9Lz3DXtDE3SDrwWE45
        pyP2rxDavdeXz4LgptBvyZ28edPdcfFpKGM7lTV1T0lE9a5314HP6n8WHTh6J70I
        Q1ZnhDZ3SQM6t9XtmM9k792ORl6dz6vqt9Ly0+sJU4oZCxabYQSX+nsLQ==
X-ME-Sender: <xms:WxBZZPZlN4zZs5JCh5pT9xpe-e_dUVPVSFsnjFluy1hgPznhq_S0lA>
    <xme:WxBZZOaJ7xPQnsWrrqi5WV6w9WompWfV44J2g0uDcUTxPcfWTsrDH4V7cWUgmZ9pn
    bskSQTSgHka0yAbhAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefkedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:WxBZZB-zSj4h2nGUXv2oSuaEg47f21Uf0nma-6IxB-8Nek89jZJ7zw>
    <xmx:WxBZZFqKM-ouFdSGBprbH3Q3u7XoWffpc7WyU3fWNsAafuQpAym98A>
    <xmx:WxBZZKqIetlfT9w-Sv13XdGnCV_S-AlsKmkwvm8xqzfaIzZxNPJo4g>
    <xmx:WxBZZPDG6zMd8hXIw8fi-_16F0c6_eD24tKyJsZaZBPn3f7Cx1Nwhg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2181EB60086; Mon,  8 May 2023 11:08:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <c7f88295-2e22-4100-b9c8-feb380b64359@app.fastmail.com>
In-Reply-To: <87mt2eoopo.fsf@kernel.org>
References: <20230417205447.1800912-1-arnd@kernel.org>
 <87ttwnnrer.fsf@kernel.org>
 <504c5a7d-0bfd-4b1e-a7f0-65d072657e0a@app.fastmail.com>
 <87mt2eoopo.fsf@kernel.org>
Date:   Mon, 08 May 2023 17:07:49 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kalle Valo" <kvalo@kernel.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>, Netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireless: ath: work around false-positive stringop-overread
 warning
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023, at 16:57, Kalle Valo wrote:
> "Arnd Bergmann" <arnd@arndb.de> writes:
>>
>> I uploaded gcc-13.1.0 binaries last week, but still need to
>> update the html page, so it's not yet linked. You can navigate
>> the directories from the gcc-12 builds.
>
> Thanks! I was able to find the build[1] but having an issue:
>
> $ ./x86_64-linux-gcc -v
> ./x86_64-linux-gcc: /lib/x86_64-linux-gnu/libc.so.6: version 
> `GLIBC_2.35' not found (required by ./x86_64-linux-gcc)
> ./x86_64-linux-gcc: /lib/x86_64-linux-gnu/libc.so.6: version 
> `GLIBC_2.32' not found (required by ./x86_64-linux-gcc)
> ./x86_64-linux-gcc: /lib/x86_64-linux-gnu/libc.so.6: version 
> `GLIBC_2.33' not found (required by ./x86_64-linux-gcc)
> ./x86_64-linux-gcc: /lib/x86_64-linux-gnu/libc.so.6: version 
> `GLIBC_2.36' not found (required by ./x86_64-linux-gcc)
> ./x86_64-linux-gcc: /lib/x86_64-linux-gnu/libc.so.6: version 
> `GLIBC_2.34' not found (required by ./x86_64-linux-gcc)
>
> With older GCC versions from your page I don't have this problem. I'm
> using Debian 10 still so so is my libc too old?

(dropping most Cc)

Indeed, thanks for the report, I forgot about that issue. I used
to build the cross toolchains in an old Ubuntu 16.04 chroot to avoid
that issue, and I linked all other dependencies statically.

The gcc-13.1.0 builds are the first ones I did on an arm64 machine,
so I had to create a new build environment and started out with
just my normal Debian testing rootfs, which caused me enough issues
to figure out first.

I had previously experimented with linking statically against
musl to avoid all other dependencies, but that ended up with
slower binaries because the default memory allocator in musl
doesn't work that well for gcc, and I never quite figured out
how to pick a different memory allocator, or which one to use.

I should probably just pick an older Debian release that is new
enough to contain cross compilers for arm64 and x86 and then
set up the same kind of chroot I had in before.

      Arnd
