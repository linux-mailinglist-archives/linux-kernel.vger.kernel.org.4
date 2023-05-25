Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2A27102BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbjEYCP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjEYCPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:15:24 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC0CE4B;
        Wed, 24 May 2023 19:14:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7A8463200C74;
        Wed, 24 May 2023 22:13:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 24 May 2023 22:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684980823; x=1685067223; bh=cCCWDiGBHNH/1
        3JSmnh5Q5sUosrLOySbAC+m9QUmDV4=; b=SoiaSR/lHyn8YlOGNvmlUKSK5ABhj
        WvyfcAQtlXujwXqam0dUdFo++bThKQz2VJ0jIZF2SIPOOt1jUO2Kq+SNaDeeMhKy
        XE7L3kkG7VtJviJ7IKCsK/54QOwjUPpizCM743Pr+zfgjQLFDQf/afy+wFXFIMGL
        I0m1KX6CrPG/Wy0dUzI2L0M5YuA1Q2EqIhIlU5ReTfSSniU0HEItcoBZXkmttYlN
        hUV6En9JyJTbX0TdOLpS8/XSDmseJo6RimWO7XccimpMd49Ak9kYwvvVg0Fxba+l
        rqBVZhHFBQAQEhTxmHfwlZ+QVDMtQcmXv3MH20zidvG+L0U/SJYsL/gJQ==
X-ME-Sender: <xms:VsRuZDX5LQnF7AcKlts6u7mcixpjRZUO4j9X1iLhOOVrscSS6x936A>
    <xme:VsRuZLnVSjE0Dl1hDKrIeCaNJ2FWVTTal2ZIySNfyILTxi_eSwk66C85xA0QQPIn-
    48p2JXcylwuOKTYUuE>
X-ME-Received: <xmr:VsRuZPaNzaS_lZWPwauTyIOxF3MB4Kwmew9PfjR4F6jaD2DFpAynx9kjahk5dRsO8-WldaxrQJ7-WSGTkSsw-bC0Rnk1WBoQKis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejiedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeigefgjefgvdfgjeefveethfeguddukeetudejteejieegleevgfevudek
    keffgfenucffohhmrghinhepuggvsghirghnrdhorhhgpdhunhhigidrrhhspdhsihhgnh
    grlhhsrdhinhgtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:VsRuZOXhu1D7NFkCmH7mNOhMcpSZefjrWjIyBvRJ54ajY2gSmkDdMw>
    <xmx:VsRuZNmwUj7wM--ySqJD8iwhOIOeHqmEjMyq2QUsYFPDUmNOIVnlBw>
    <xmx:VsRuZLfeCovWomzNnKlalq_uc3jCDvISqkyMbPIszx83ceRlEJN3_Q>
    <xmx:V8RuZDjE1WtQ0A_3N0T_fjx4_bH-RW4Wc2hZ5EMK44lEzgwKgFck-g>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 May 2023 22:13:39 -0400 (EDT)
Date:   Thu, 25 May 2023 12:13:46 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>, stable@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] m68k: Move signal frame following exception on
 68020/030
In-Reply-To: <CAMuHMdX_0F0hSZKqBBCN3876BmfwbQb1_+N3h-V8xs5ouRXF=A@mail.gmail.com>
Message-ID: <74df27ea-ad17-e869-695b-a7e8b042289c@linux-m68k.org>
References: <cover.1683365892.git.fthain@linux-m68k.org> <9e66262a754fcba50208aa424188896cc52a1dd1.1683365892.git.fthain@linux-m68k.org> <CAMuHMdX_0F0hSZKqBBCN3876BmfwbQb1_+N3h-V8xs5ouRXF=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023, Geert Uytterhoeven wrote:

> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> i.e. will queue as a fix in the m68k for-v6.4 branch.
> 

Thanks Geert!

> I plan to send this upstream later this week, so any additional
> testing would be appreciated.
> 

If there is a userland program that needs all of its sigaltstack space, 
and cannot accomodate a 256 byte margin, it will be hard to find that 
program. Often these signal stacks are used for handling (would-be) fatal 
signals that may not happen in regression testing.

If we fix the kernel and a failure eventually does show up in a userland 
program, we may be able to patch that program. Looking through Debian's 
codebase, which is easily searchable, I found lots of different ways to 
determine the signal stack size. But it's not clear to me which programs 
calculate it correctly.

Many programs take the architecture's SIGSTKSZ or MINSIGSTKSZ or 
getauxval(AT_MINSIGSTKSZ) or sysconf(_SC_SIGSTKSZ), or some combination, 
and then apply an arbitrary safety factor. Some add a constant or apply a 
lower bound that may reflect the actual requirements of the signal 
handler. Some just use page_size().

https://sources.debian.org/src/rust-generator/0.7.1-1/src/stack/unix.rs/?hl=85#L84
https://sources.debian.org/src/ocaml/4.13.1-4/runtime/signals_nat.c/?hl=293#L289
https://sources.debian.org/src/ruby3.1/3.1.2-7/signal.c/?hl=538#L531
https://sources.debian.org/src/python3.11/3.11.2-6/Modules/faulthandler.c/?hl=1385#L1368
https://sources.debian.org/src/llvm-toolchain-9/1:9.0.1-20/llvm/lib/Support/Unix/Signals.inc/?hl=259#L250
https://sources.debian.org/src/musl/1.2.3-1/src/aio/aio.c/?hl=98#L83
https://sources.debian.org/src/libreoffice/4:7.4.5-2/external/breakpad/SIGSTKSZ.patch/?hl=4#L4
https://sources.debian.org/src/libuv1/1.44.2-1/src/unix/thread.c/?hl=168#L165
https://sources.debian.org/src/stress-ng/0.15.08-1/core-helper.c/?hl=3290#L3276
https://sources.debian.org/src/cysignals/1.11.2+ds-2/src/cysignals/implementation.c/?hl=446#L442
https://sources.debian.org/src/vim/2:9.0.1378-2/src/os_unix.c/?hl=828#L811
https://sources.debian.org/src/m4/1.4.19-3/m4/sigaltstack.m4/?hl=88#L72
https://sources.debian.org/src/varnish/7.1.1-1.1/bin/varnishd/cache/cache_main.c/?hl=342#L330
https://sources.debian.org/src/sfxr-qt/1.5.0+ds-2/debian/patches/catch2-patch/?hl=3223#L3121
