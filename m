Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25757748879
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjGEPx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjGEPx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:53:27 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153BC1980;
        Wed,  5 Jul 2023 08:53:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E88C5C0085;
        Wed,  5 Jul 2023 11:53:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 05 Jul 2023 11:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688572404; x=1688658804; bh=Tg
        Vor6ohcB+NOGucTa0+/H0UrCZfx0RkXCTaJQ6Ou3Y=; b=jnPp5p89NBHK7KnbTT
        KCD5uMT3OH9YAbg8CcvnjhhOQ3DDNOcwZbNdy6iJDhIfX2MUuUAJwIjFl0ZtGmmS
        F/KagCO3GySfM/UKrTTdVACTPl9VIEkChwZ459eDhzYj6dIp0USHADbE33fbDdZf
        AM53xeTqG1aU4XgZdtttNLy8bjpOUzhSAbNUmBVfWI7bH6TbzfuY21qkZ4v2NAVt
        HqIailq2xyLjm5YFK/a1PmZ1ivOleMiALb3htug6lZ+h4ZXUHH59Hkhru7PwC1jy
        VBN2ULxKFP/uP6vqyjmxNOUeXG24vMIYq4M32U+ZlPhTxnrY0M9prGamVJPFPC4Z
        emvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688572404; x=1688658804; bh=TgVor6ohcB+NO
        GucTa0+/H0UrCZfx0RkXCTaJQ6Ou3Y=; b=AhtDVmNY1Ohvt1QL3I9COfXsLvHwM
        N9lCRZQ9a0aLFbj3dcPYQHQBHAI6FRDfGQOyLBVaWRCSguys90OjFJ+cVNBo6zEE
        83G1EoOg+Uq8O92o/+kUoHJ4ajhcKFbnQw0G5w96myLpeg0f0QaW9MdW7stb9SzG
        p/o75HEkd9SWL0lr4ySDKIaM0DxfPxOe146CEipbJriIQhm8LjjNHku/rzDtgffI
        1gHRYQNVtffFt/c22KRIlDS16fEmmzK2kRrn7m3OveKdG7nyBkKXpkOAaoykNim/
        tjr6m7OSrdz5K3nEmmzYBAckS2ukv4q69sJRt7bNyrbIPN01zYQCvOngA==
X-ME-Sender: <xms:8pGlZFTbeLzV79DGdrh7qevPM0i0fJmNmHL6YRqS9x1I_T4WgtPj7A>
    <xme:8pGlZOz26CW_ULz05628KUdDEJ48LVr6AzBkERmWlEN-H6moFQx2fDkkjiUFZ6kqN
    cLo5iowOC_udRk7VJI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:8pGlZK2C-bJD4SanTz1LyR4QS85MQ2pDQ-sEUrVztRcRe_kG7Mx3ZA>
    <xmx:8pGlZNB9AyLkbjbdKcozJrDdcqR4k2DEbftZTwyY6I3J98Qog8p6Dw>
    <xmx:8pGlZOg1iTaDF8HMGK-OsBcAb8Bi_seJSDKv8ahyiQPYl6F54koHGw>
    <xmx:9JGlZJWt5EMLAiSMbW31Z-v5-mfO2jMfnvnhNcJ87yOqAX3KFbNeWw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 97530B60086; Wed,  5 Jul 2023 11:53:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <622eee1a-4bf3-4a17-9c2e-e32f0f405fd5@app.fastmail.com>
In-Reply-To: <6ac04399-9c17-b036-5b14-92eadb65522b@oracle.com>
References: <20230705142004.3605799-1-eric.devolder@oracle.com>
 <20230705142004.3605799-4-eric.devolder@oracle.com>
 <09f70de6-9409-4fa4-b9ea-831078d914e7@app.fastmail.com>
 <6ac04399-9c17-b036-5b14-92eadb65522b@oracle.com>
Date:   Wed, 05 Jul 2023 17:53:02 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Eric DeVolder" <eric.devolder@oracle.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Cc:     "WANG Xuerui" <kernel@xen0n.name>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Heiko Carstens" <hca@linux.ibm.com>, gor@linux.ibm.com,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, "Sven Schnelle" <svens@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        "Juerg Haefliger" <juerg.haefliger@canonical.com>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Sebastian Reichel" <sebastian.reichel@collabora.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Zi Yan" <ziy@nvidia.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Zhen Lei" <thunder.leizhen@huawei.com>,
        "Xin Li" <xin3.li@intel.com>, "Tejun Heo" <tj@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, tsi@tuyoix.net,
        "Baoquan He" <bhe@redhat.com>, hbathini@linux.ibm.com,
        sourabhjain@linux.ibm.com,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Subject: Re: [PATCH v4 03/13] arm/kexec: refactor for kernel/Kconfig.kexec
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023, at 17:22, Eric DeVolder wrote:
> On 7/5/23 10:05, Arnd Bergmann wrote:
>> On Wed, Jul 5, 2023, at 16:19, Eric DeVolder wrote:
>> 
>> I see this is now in linux-next, and it caused a few randconfig
>> build issues, these never happened in the past:
>
> Arnd,
> Thanks for looking at this!
>
> I received randconfig errors from Andrew Morton's machinery. When 
> investigating I
> found that randconfig was able to specify CRASH_DUMP without KEXEC, and 
> that lead
> to problems. I believe this situation existed prior to this series as 
> well.

On Arm, there was definitely a bug because one could enable CRASH_DUMP
without enabling KEXEC, but that had no effect at all. I only noticed
the problem testing linux-next because it turned from silently broken
into a build failure

> Specifically CRASH_DUMP does not have a dependency on KEXEC, or select 
> (only s390
> has this hole closed).
>
> For CRASH_DUMP, this series now selects KEXEC to close this gap, which is what a
> sane config would have (ie both CRASH_DUMP and KEXEC).

Right, that is the easier way out here.

> Do you think the changes outlined below are still needed?

I think only the first one still applies on arm, you need to ensure
that ARCH_SUPPORTS_CRASH_DUMP has the same dependency as
ARCH_SUPPORTS_KEXEC, or it just depends on ARCH_SUPPORTS_KEXEC.

    Arnd
