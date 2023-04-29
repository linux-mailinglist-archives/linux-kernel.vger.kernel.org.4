Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFE86F21B3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 02:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347172AbjD2Ai3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 20:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjD2Ai1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:38:27 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F8A40C8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:38:26 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 946D95C00A5;
        Fri, 28 Apr 2023 20:38:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 28 Apr 2023 20:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1682728705; x=1682815105; bh=MxLCpu5U79qjWhiQ3WAhq0F12
        mE7kqiiiVKbZ6XzXP4=; b=b3m3xs1GsrzbB08awngro455npFaWrUXuKNT76qnX
        j0N1vVqw6eRL+9syf8ugb0/C3uZUWT9bhh/UF6ysY1uKvJHB+s1gZtTfUFCevrwt
        uFevjoouoBKfTrshXQFsiI+YglucZDVdiBE4uz+jHKOqb4Ne+Vd1vbhIRdSq0rDc
        xwgrRYdtdbl4gnApFwM04WR8eEyOhzxFRuYTxrLtWQthziDYIPYOraQs5HVriV+p
        G2WXpCiOkXP0PEyNt9XdrI403j//zFg0SR7MTu5uIhe05HDfQBYwsFBdOVsPW3nt
        cV+eKNge9Q/9MkAatLaID0mHtDqDw+EdLKWCBy7Q5jwDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682728705; x=1682815105; bh=MxLCpu5U79qjWhiQ3WAhq0F12mE7kqiiiVK
        bZ6XzXP4=; b=e4/dDau+8HBuq9FUrZnVgprjDStrPDbKgqDfFzyx6KC21Nv2SMq
        vcS4Gd+j57fUKYCrkPd6TwLy/vgejpKzd6gL1Ga42E/49ro6tC2DHD8BhWpv9UmB
        4UbkBZRzPm9nMcyVABd1rmdBhGdIK8/TiToyKk0IpdAj99LO+uoOFJ+iUdsmJNDf
        ZRBOhzfSykIKljksQQMc6a1TbjqyplOsqnL1AjmdfP1nQnjkYKz/K9DZ6KBCmAi5
        QNF0CfW/KO6OOAWR7kajygd75OmZQ4JpDEvSKxm5GcI0CvPXrgEPm3TBParwOFMs
        QBkqF5O/nCXi5GRFxW/2QR/b7Y+FdPokNRQ==
X-ME-Sender: <xms:AWdMZAO78AI2X_TxH2aN4AjdkHHCwbw5VD9noUdSzXXqvthl8b_8Pw>
    <xme:AWdMZG9uPtGZKsCUpLJ07llraKP4HupGVFCIo9-VsAwc3yIoPJvB9lHgOafW6Zd0X
    Lp-gXc-ezioqOevu4Q>
X-ME-Received: <xmr:AWdMZHQXgTaX-gObcjNhaPZ0X0MTAPxw8RoFGX8EPGOS_fWFruwGeKc9C9wolsr5oXCC9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkedttddttdejnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepgfejieekffeffeevudfgtdekvdfhtddtieef
    vedtheeggfejffellefggffgvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:AWdMZIug3Kvk49ARS8HoG5CZ5riyrH9aweOODKQ3B9OOMSNTqrBTcw>
    <xmx:AWdMZIcBlSsBEsvaxO6C-Bjj6E0YC1Lf3GHJppCAb3CrShlwMooftg>
    <xmx:AWdMZM2MK2l1KoRh_ANI06xVtfZ8cA8IT1i5kqp1P8S7rXTKYNnXoQ>
    <xmx:AWdMZH4sJqudXacC-wL-tiJa9TfmH4hpfd8RuoWsp8famJ7w-wg7Jw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Apr 2023 20:38:24 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E07F51041AE; Sat, 29 Apr 2023 03:38:22 +0300 (+03)
Date:   Sat, 29 Apr 2023 03:38:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] x86/mm for 6.4
Message-ID: <20230429003822.n3mglslg666j3npp@box.shutemov.name>
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
 <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 01:15:33PM -0700, Linus Torvalds wrote:
> On Fri, Apr 28, 2023 at 1:07 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So here's my suggested change on top of the current tree. Comments?
> 
> Oh, and I wanted to particularly mention that
> 
>     We could probably just do that "check only starting address" for any
>     arbitrary range size: realistically all kernel accesses to user space
>     will be done starting at the low address.  But let's leave that kind of
>     optimization for later.  As it is, this already allows us to generate
>     simpler code and not worry about any tag bits in the address.
> 
> part of the commit log.
> 
> Right now that patch only simplifies the range check for when the
> compiler statically knows that the range is small (which does happen,
> but not very often, because 'copy_to/from_user()' isn't inlined on
> x86-64, so the compiler doesn't actually see the constant size case
> that is very common there).

BTW, I think the static check can be relaxed. Checking size against
PAGE_SIZE is rather conservative: there's 8 TB (or 4 PB for 5-level
paging) guard hole at the begging of kernel address space.

> However, that "check the end of the range" is sometimes actually
> fairly complicated code, and it would be nice to drop that entirely.
> 
> See for example the fs/readdir.c case, where the length of the access
> is kind of annoying:
> 
>         if (!user_write_access_begin(dirent,
>                         (unsigned long)(dirent->d_name + namlen + 1) -
>                                 (unsigned long)dirent))
>                 goto efault;
> 
> and there really isn't any actual reason to check the end of the
> access on x86: if the beginning address has the low bit clear, it
> doesn't really matter what the end is, because we'll either have a
> good area, or we'll fault in the non-canonical area even if the sign
> changes.
> 
> So being careful about the range is kind of annoying, when we don't
> really need it.

Hm. Is there anybody who access high to low after the check (glibc
memcpy() bug flashbacks)? Or not in any particular order?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
