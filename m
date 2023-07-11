Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5B74F51F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjGKQ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjGKQ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:26:40 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EC6DD;
        Tue, 11 Jul 2023 09:26:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D4BB5C00DE;
        Tue, 11 Jul 2023 12:26:38 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Tue, 11 Jul 2023 12:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689092798; x=1689179198; bh=W5
        R3dRJEuDedU4mfmE2aIPLz0te1yZv4ob1QkUmzMKM=; b=ODbLFxMV5mwHkhiuHu
        8y59t2aO2M11yWSHec1S1N+Tp6IFvOKHClzlg+U848vHZFecknqfAciJTZ3jLeIB
        fD6V6Q5ow1Smr20ur+LFpqZwBINrmTUvnNZsiVh/Y0YWNtYxenQp8zE/pLbpg80z
        ninH5I1YWvHickc/XUbLcXNFu65A/CUBO0j39o5KLFZw5L5woc4vjGNllJsF8iLy
        JKToX960nkwne8mujYhw5PG3fV1/Zkpr/FHN77eaet7FXA9x2JORMQ0E+pIggAz9
        aB8jzB5q9bBBevc3z+DbT3ltAcgPkgF/3YBFaaAJiNO5ypzY2ZGl9sfiJI7VnyBU
        0Gcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1689092798; x=1689179198; bh=W5R3dRJEuDedU
        4mfmE2aIPLz0te1yZv4ob1QkUmzMKM=; b=L4keh8DpXJJ7c686XwDTafCd5Xoej
        ZIIO+4gouATQ6mRad2021iqSClCxCaLwgVsKzMgMnwZ6bKhUwQLXz8xy7EFGYXlw
        pbN/VDJmrKTcBxxxuloD6UNM6DK7Vi+lshUrtUQZ9PuoUK1GjrEOtjFBZUuqIR8d
        YH8atg0ARD20qKAZNb5UwhVcvZo9GGR0DWtoHtKhEKARANny0ACXpeSgeey57Sbg
        X5bUZT5GkxA9sJsGMCfQQs3mu6xawiXRdZbqowNEuL2GMnYz/qSRYZeDH766Y7ZJ
        GZEmvFc9+gCVu/tPaDrIVDSOLexdEpAWfpHXNSLh/zFz8p+9xvzSx5Z6Q==
X-ME-Sender: <xms:vYKtZCZrOO206uZQnBLnw6Pzd8s2LG5LJYdLLwT0ZLRpxQeZRT_iLQ>
    <xme:vYKtZFbfR7QXzcyM-Jbvm_VOr-y41p-qepX7Qi3sCOX6qThZwQapG0LxacIu45E6y
    xOqXyS2HTH7tGJZGVk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:voKtZM-z6cPt4LX676_QKmMEL3FC9Nbc_wfhpx-TUWLi5fsRPzeOyg>
    <xmx:voKtZEr1xOtzYXuXwgB_dRsyLrMMOiFVPUC2ogGjOljw8dgQazlo4Q>
    <xmx:voKtZNqwuN9Pb7uMw3mBTIkWmWSNpZhGZYMjmAo9oZk56CJSGcc6nw>
    <xmx:voKtZGCExvlOjQjyuIxzA6wUIHYxacY7u7DMuS8LSM2bmqs1FjT-UA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CE2AA1700090; Tue, 11 Jul 2023 12:26:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <8d8cef73-1733-4e0b-bede-034895a820bd@app.fastmail.com>
In-Reply-To: <a677d521f048e4ca439e7080a5328f21eb8e960e.1689092120.git.legion@kernel.org>
References: <cover.1689074739.git.legion@kernel.org>
 <cover.1689092120.git.legion@kernel.org>
 <a677d521f048e4ca439e7080a5328f21eb8e960e.1689092120.git.legion@kernel.org>
Date:   Tue, 11 Jul 2023 18:26:17 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexey Gladkov" <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Alexander Viro" <viro@zeniv.linux.org.uk>
Cc:     "Palmer Dabbelt" <palmer@sifive.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Catalin Marinas" <catalin.marinas@arm.com>, christian@brauner.io,
        "Rich Felker" <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Deepa Dinamani" <deepa.kernel@gmail.com>,
        "Helge Deller" <deller@gmx.de>,
        "David Howells" <dhowells@redhat.com>, fenghua.yu@intel.com,
        "Florian Weimer" <fweimer@redhat.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>, glebfm@altlinux.org,
        gor@linux.ibm.com, hare@suse.com, "H. Peter Anvin" <hpa@zytor.com>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>, jhogan@kernel.org,
        "Kim Phillips" <kim.phillips@arm.com>, ldv@altlinux.org,
        linux-alpha@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        "Russell King" <linux@armlinux.org.uk>,
        linuxppc-dev@lists.ozlabs.org, "Andy Lutomirski" <luto@kernel.org>,
        "Matt Turner" <mattst88@gmail.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Michal Simek" <monstr@monstr.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Paul Mackerras" <paulus@samba.org>,
        "Peter Zijlstra" <peterz@infradead.org>, ralf@linux-mips.org,
        sparclinux@vger.kernel.org, stefan@agner.ch,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tony Luck" <tony.luck@intel.com>, tycho@tycho.ws,
        "Will Deacon" <will@kernel.org>, x86@kernel.org,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v4 3/5] arch: Register fchmodat2, usually as syscall 452
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023, at 18:16, Alexey Gladkov wrote:
> From: Palmer Dabbelt <palmer@sifive.com>
>
> This registers the new fchmodat2 syscall in most places as nuber 452,
> with alpha being the exception where it's 562.  I found all these sites
> by grepping for fspick, which I assume has found me everything.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
