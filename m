Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65CD689128
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjBCHnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjBCHn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:43:29 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1E1B449;
        Thu,  2 Feb 2023 23:43:27 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id cr22so4624018qtb.10;
        Thu, 02 Feb 2023 23:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFf9KYeQPAcUoBOf/mOzVaePC0gDGny8p7rFF3Zsr2g=;
        b=pXigfP4rXkLLFuB8HyAn7teR52dw/IXzeQAqr2kDRPKVxbAGDlIBy4mnnEBEo3ew7c
         UURLHoFH9pMI6jJLTpK41RMTN64erE6mvRbxJ0KvZyNAxlZlsqozC6YefqtD7kEiTfnv
         p2zvNigTdXQwcDtxblEyCCbE4EyzfP/e+C6xgOi4pt3/JF9ZD2odO4hMwBeArjoyi3hQ
         zdjK+PLLQS0hPP1mFhfHObr4Y1aUUHD/O5yN2rlWsc6SDgZ6YHAEXTWwg1amSK6j/f30
         j6z66KkRscFtO9wDh6L+9xIUGGSd0oMh/fgVBkaK0W6wmOC2C0Dc4J+ltygqwcAffUI0
         cvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFf9KYeQPAcUoBOf/mOzVaePC0gDGny8p7rFF3Zsr2g=;
        b=yXOYrfkjKd8Yze1oM4Z0tRK6iS68jluGeLFdxcoKYZqDRuvJ2qFspRiqPr0HbIyuJ6
         r6Wz5Kpvoc2I9lWetOfYG4UuA5CX4cdzFXZLJpaUBqolMKgbFt8oqTtOJf3idn5bBInT
         WFqdfMN+ThpdWXm3lMjxfxIKyNxnt1nMfr+d7Zya5BzoqayFwYcSJneTI1NZ+bkqgf6g
         6rFq/qo91LHOy+100LfD3KAN9JU22BRkSkzJmE+af8wkAAar4zgzlNpjomFZsikEmlrX
         WlOGZ3xci+Nq+Fh4z8KPqT+iMKyWkUkdC/RImyud1Wem3laVKna6a1sDFEBZuKqNZmN6
         +V/g==
X-Gm-Message-State: AO0yUKVyiP9uUyJnwj8d1K8Fwo+dXXItGFWL4VSET1uJqC5OwrMfZ6P4
        3zhqZrwS0+OOYE+N8wEQY5o=
X-Google-Smtp-Source: AK7set8Lnh4m4u9mvYRGiuMz5HH4jWhWZM5oIcLdp6MGPmhHVv4IfvylZOY/1apoK5yOLAYa+dVnYg==
X-Received: by 2002:ac8:5e4f:0:b0:3b9:a4c4:ca09 with SMTP id i15-20020ac85e4f000000b003b9a4c4ca09mr18692642qtx.10.1675410206950;
        Thu, 02 Feb 2023 23:43:26 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d136-20020a37688e000000b006fa4ac86bfbsm1342844qkc.55.2023.02.02.23.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:43:26 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id D5F6C27C0054;
        Fri,  3 Feb 2023 02:43:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 03 Feb 2023 02:43:25 -0500
X-ME-Sender: <xms:HbvcY6KIUTgbpxCudYR-RJsUIEW9ISjcefBdpEGepILXrEi0Wujg8g>
    <xme:HbvcYyLVxvTI9lmjPBUfKdtel0x2UMj8ppyNDoam6--fdEBIeoAgM1ScqfRmBGP28
    2dObwureuVBs1yHyA>
X-ME-Received: <xmr:HbvcY6uj3cowUOr9_XfnCGGJMdV7RNzJQSmosYIuMQ7lnf9lS70_QJWTGG1Ypz20rvvoJBkvFt8z8kCZ3iSbf6IQR2QIjd7ggwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:HbvcY_a98fGY-ufHEzwzX_Zf7AL6ZIhFo5Q0OCS0DE4a1nGf9d6Slw>
    <xmx:HbvcYxaqpOOuP6xleHcFxffjnjOLIT4WUWX9xjJBfqtS4boFjB4myA>
    <xmx:HbvcY7DLGj_061Ecw2L6OYHX3ozu4asNapu4-12NPLTxxKk5AjMokQ>
    <xmx:HbvcY1Q13IC8bajg5Szu-YtK-3-ZqW6vSj8e5986DlostHq81BziOw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Feb 2023 02:43:25 -0500 (EST)
Date:   Thu, 2 Feb 2023 23:43:23 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Peter Zijlstra <peterz@infradead.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
Message-ID: <Y9y7G4AY8MPy5E3r@Boquns-Mac-mini.local>
References: <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
 <20230202142153.352ba479.gary@garyguo.net>
 <Y9vZu08L2WaLNJIc@kroah.com>
 <Y9vga90K0aVfGUwW@boqun-archlinux>
 <Y9viM2POUsSnbKUh@kroah.com>
 <Y9vqJ1h2nkaFRpOY@boqun-archlinux>
 <CANiq72kMZ9XQvte41Mzu4oXX=ujGRCrGDZDiYUBVD3=JTGG57g@mail.gmail.com>
 <Y9yaBybest8JBu8A@kroah.com>
 <Y9y21JyuPF1nCCzr@Boquns-Mac-mini.local>
 <Y9y58cy1GKZLdyjb@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9y58cy1GKZLdyjb@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 08:38:25AM +0100, Greg KH wrote:
> On Thu, Feb 02, 2023 at 11:25:08PM -0800, Boqun Feng wrote:
> > On Fri, Feb 03, 2023 at 06:22:15AM +0100, Greg KH wrote:
> > > On Thu, Feb 02, 2023 at 10:47:12PM +0100, Miguel Ojeda wrote:
> > > > On Thu, Feb 2, 2023 at 5:52 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > > >
> > > > > As I said, I'm open to remove the printing of the refcount, and if you
> > > > > and Peter think maybe it's OK to do that after the explanation above,
> > > > 
> > > > Perhaps part of the confusion came from the overloaded "safe" term.
> > > > 
> > > > When Gary and Boqun used the term "safe", they meant it in the Rust
> > > > sense, i.e. calling the method will not allow to introduce undefined
> > > > behavior. While I think Peter and Greg are using the term to mean
> > > > something different.
> > > 
> > > Yes, I mean it in a "this is not giving you the value you think you are
> > > getting and you can not rely on it for anything at all as it is going to
> > > be incorrect" meaning.
> > > 
> > > Which in kernel code means "this is not something you should do".
> > > 
> > 
> > Now what really confuses me is why kref_read() is safe..
> 
> It isn't, and I hate it and it should be removed from the kernel
> entirely.  But the scsi and drm developers seem to insist that "their
> locking model ensures it will be safe to use" and I lost that argument
> :(
> 
> > or how this is different than kref_read().
> 
> It isn't, but again, I don't like that and do not agree it should be
> used as it is almost always a sign that the logic in the code is
> incorrect.
> 
> > Needless to say that ArcInner::count() can guarantee not reading 0
> 
> How?  Because you have an implicit reference on it already?  If so, then
> why does reading from it matter at all, as if you have a reference, you
> know it isn't 0, and that's all that you can really care about.  You
> don't care about any number other than 0 for a reference count, as by
> definition, that's what a reference count does :)
> 

Fair enough!

> > (because of the type invariants) but kref_read() cannot..
> 
> I totally agree with you.  Let's not mirror bad decisions of legacy
> subsystems in the kernel written in C with new designs in Rust please.
> 

Roger that, will remove this in the next version ;-)

Regards,
Boqun

> thanks,
> 
> greg k-h
