Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2FE73DADE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjFZJKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjFZJKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:10:10 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B3F1732;
        Mon, 26 Jun 2023 02:08:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id AF2285C00DC;
        Mon, 26 Jun 2023 05:08:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 26 Jun 2023 05:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687770504; x=1687856904; bh=35
        5YQJONktLCrEPHxI6uipTk6KD3tOthTHGVo8zIK+Y=; b=WBRzBfDbuGMrLDxbiU
        /H2KesGvN1lBBt9CFBXDazpq+0lQkGjxliI0+SEXBH5w4bUoFs7RXRiJWRsFe1yZ
        +Ej+mjiVzx+zTtj7GpnbTxENWQ5UqoumEdFFTi214NjSStW+22IOF4fVNcz9au+P
        io3xzAdlnW+hIyEmzzh6GDGmwTTLHHUFszkT0Ve4UNkn6stXU8eTQcO2PY9yg8AB
        xw12CSSgYojAqLmLo9K5IULtR9ADck7F++4gI3CrEwndUZOh+yUUZj8tcY+w4CwV
        q18opacS0US5ej7nqkaaGmWOGJH1iiqhaTfuuXO+FzXMNyL3PDFvelhyuHvW6Uyg
        v11g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687770504; x=1687856904; bh=355YQJONktLCr
        EPHxI6uipTk6KD3tOthTHGVo8zIK+Y=; b=XLQ+q71C3SVFkDtVqnshaBixICMhR
        FI+dwA0tR999BmRP8U186t0KYt6ISBw1jeIsTNKRv9mmQ/O+VcV/FusIGBf8kGcR
        IBcL1G5GNRwqYv5Dtr3rksW28DT63gR04iYLDow+sm+R3QFMvyCzBiefxzK4sFgX
        1fPpVfw18BIe+jVBJKErpLliRnXzlnLopZvQpm/MMhOZWyQ1Ts+3yyK0C5Wltq5S
        w+UvNqr5drEjImbpngyjnvO2lDEA6f3WPzky1mFidZRpcgRQRAwsBbl44mvpXZm2
        t3yoqt+Ju6EdOQwbC8i0u8RQCUk+pOPo7R+rxJW8POCU7d9uPswzYLYDw==
X-ME-Sender: <xms:iFWZZEA2JIanA2IDHPxxCz6Fi_XCUAgMhBHk1gTVvjmu-83nkTZwlg>
    <xme:iFWZZGi1HnGroSD797SyQWDFo9O0z6Lu3dB27ZpeCT5VXZ0oIuRbbu8u1Qq3CNZZ7
    d-HyVPVVTiJFg>
X-ME-Received: <xmr:iFWZZHkFTyTQmBGXHFYYeXXizTVaEuoV_XlfikGwZoNLOoEut1WdUyPWfzorB0ZQKs037Ag0pvUDn6vZNq8l2kn_uyO1Bz_3aVQFtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehfedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:iFWZZKx2_7IuDOGSOH-5vj75nYmHutKHP9lMfLotlOy_MsIeWJynuQ>
    <xmx:iFWZZJTTN4YvBMf_SogjbB80806deYWyr0cdvvVfJgCUKIYzeypmIg>
    <xmx:iFWZZFaqMjPN6yDIp9tOjPQmrfu-8T2zp5Y1_YpZlKZ1SroB0Xya3A>
    <xmx:iFWZZOJySnMVHtsK_PuKh1jD3QqXXHwseKo6RxMfj9JJeu4a6UjMYQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 05:08:24 -0400 (EDT)
Date:   Mon, 26 Jun 2023 11:08:22 +0200
From:   Greg KH <greg@kroah.com>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/mm: Avoid using set_pgd() outside of real
 PGD pages
Message-ID: <2023062651-random-enjoyment-8838@gregkh>
References: <168694160067.404.13343792487331756749.tip-bot2@tip-bot2>
 <20230626085450.GA1344014@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626085450.GA1344014@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 09:54:50AM +0100, Lee Jones wrote:
> Dear Stable,
> 
> On Fri, 16 Jun 2023, tip-bot2 for Lee Jones wrote:
> 
> > The following commit has been merged into the x86/urgent branch of tip:
> > 
> > Commit-ID:     d082d48737c75d2b3cc1f972b8c8674c25131534
> > Gitweb:        https://git.kernel.org/tip/d082d48737c75d2b3cc1f972b8c8674c25131534
> > Author:        Lee Jones <lee@kernel.org>
> > AuthorDate:    Wed, 14 Jun 2023 17:38:54 +01:00
> > Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> > CommitterDate: Fri, 16 Jun 2023 11:46:42 -07:00
> > 
> > x86/mm: Avoid using set_pgd() outside of real PGD pages
> > 
> > KPTI keeps around two PGDs: one for userspace and another for the
> > kernel. Among other things, set_pgd() contains infrastructure to
> > ensure that updates to the kernel PGD are reflected in the user PGD
> > as well.
> > 
> > One side-effect of this is that set_pgd() expects to be passed whole
> > pages.  Unfortunately, init_trampoline_kaslr() passes in a single entry:
> > 'trampoline_pgd_entry'.
> > 
> > When KPTI is on, set_pgd() will update 'trampoline_pgd_entry' (an
> > 8-Byte globally stored [.bss] variable) and will then proceed to
> > replicate that value into the non-existent neighboring user page
> > (located +4k away), leading to the corruption of other global [.bss]
> > stored variables.
> > 
> > Fix it by directly assigning 'trampoline_pgd_entry' and avoiding
> > set_pgd().
> > 
> > [ dhansen: tweak subject and changelog ]
> > 
> > Fixes: 0925dda5962e ("x86/mm/KASLR: Use only one PUD entry for real mode trampoline")
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: <stable@vger.kernel.org>
> > Link: https://lore.kernel.org/all/20230614163859.924309-1-lee@kernel.org/g
> > ---
> >  arch/x86/mm/kaslr.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > index 557f0fe..37db264 100644
> > --- a/arch/x86/mm/kaslr.c
> > +++ b/arch/x86/mm/kaslr.c
> > @@ -172,10 +172,10 @@ void __meminit init_trampoline_kaslr(void)
> >  		set_p4d(p4d_tramp,
> >  			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
> >  
> > -		set_pgd(&trampoline_pgd_entry,
> > -			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
> > +		trampoline_pgd_entry =
> > +			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp));
> >  	} else {
> > -		set_pgd(&trampoline_pgd_entry,
> > -			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
> > +		trampoline_pgd_entry =
> > +			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
> >  	}
> >  }
> 
> Could we have this expedited please?  There are users waiting for it.
> 
> Upstream commit is:
> 
>   d082d48737c75 ("x86/mm: Avoid using set_pgd() outside of real PGD pages")

Please look through your emails you got this weekend, it's already
queued up in the following stable trees:
	queue-5.4 queue-5.10 queue-5.15 queue-6.1 queue-6.3

greg k-h
