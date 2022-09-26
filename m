Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAEC5EAB1F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiIZPcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbiIZPa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:30:58 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD4C8C029
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:17:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 52E6C5C00C8;
        Mon, 26 Sep 2022 10:17:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 26 Sep 2022 10:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664201834; x=1664288234; bh=f5+FdqEZwx
        8YdaGyA7IVf1i0jed+7nRL4Cs8BKtPAUM=; b=BdwApm28HnR9EIDAqOIHOSmAsR
        MFGFrKkPtfF+/f6T/zhtmTDZ+yhzeGq5bfYoPJMlm+zuQ/nbbsHU1yMaEXQO/DNv
        49dCAhHqqraVV++lrQQCJm4+aMaaysif9YfnmYpWEp3jQLWVT0ijCrlQUaU+u7KT
        XLYBtMiDiAO5yqD9LfkDhCFLVbah6JH4z26CmgsMxD6Bg2U/KwzRK9fhC0QBSnwn
        UuCr9aa8zTIX5N8Lm0mtcqXM0ak4TOioeMFsz2DgpCjTw6c0dh3JRcRnhbc/MCRA
        cMjtaUKPwPfM4gMwIvcS5fas8FzTV8HBFu4L1M6E/RPBI0dHITqWj7NpAy3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664201834; x=1664288234; bh=f5+FdqEZwx8YdaGyA7IVf1i0jed+
        7nRL4Cs8BKtPAUM=; b=gn5gWVjwYWM8oLKtBeXg+vbUUU1oRRj0AuoVwittNG17
        eRYk6BXwWAPctjYluu5H+jSrIgsa8z/uJBPeiNaYPEO9BOnQ/glIYn6j5i69zJCZ
        7T26J/xJ07aG1AXfx7y44ZUJUUghTPOUxGXBZW44FYL5EPFBA01HkFiyQJPSP1+Q
        OBAKJpRODKu3Rd1BXhj7qlq1Ex8bczEgiJ6CgkWY5WodcnfGtAPOlnXuK3KbJyHK
        VrnbM+SbhgeMLvzzD7M0Sp/PFZU0y7Cceq+p/nH6TvRpconOLmtJ8i8Mcn40a51B
        yh5Kwo2oLdPAhl7V/cXr/KE+IXn+Bce/pR9/Eb6S3Q==
X-ME-Sender: <xms:abQxYzrw0oZCOc4NLN1syL9Ir8UV2q778V_2nIYDi6d151oaeBAfDA>
    <xme:abQxY9qAEvUdcJZLW96tHyHP3HwViPgdmnWBPghFsskaLdbMTbieT0RnfHxbjPfVD
    xyygQiJRZ0HLmpMHxM>
X-ME-Received: <xmr:abQxYwMR_cSRgBfvM-vFbyT2FMSPZdwpzdvGX47LgN5L3gPek9KowoMVNgLeXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegvddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:abQxY25csMp3SC8PuMdydQJrtngpfRdZ0ph58sEMXo_NbgDcFj_CvQ>
    <xmx:abQxYy7zzZUblY9GeS-I_b1rdWFGCOZadH4V4Im1sodigx77MmZG5g>
    <xmx:abQxY-h6emRQ2bRgTXJcVXk7Daq4DVuLSHN_HckKUxGda7fUrJf2zw>
    <xmx:arQxY4lVUMdQ7B7phJDxnnIbasOt06Zt1UFnCJ5g6xlN5ta5gYah1w>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Sep 2022 10:17:12 -0400 (EDT)
Date:   Mon, 26 Sep 2022 08:17:10 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] fuse: In fuse_flush only wait if someone wants the
 return code
Message-ID: <YzG0ZpRuN5VPnKRM@tycho.pizza>
References: <YvpRLJ79GRWYjLdf@tycho.pizza>
 <20220901140647.1125079-1-tycho@tycho.pizza>
 <YyiEzbTDZ+g9iAas@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyiEzbTDZ+g9iAas@tycho.pizza>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 19, 2022 at 09:03:47AM -0600, Tycho Andersen wrote:
> Hi Miklos,
> 
> On Thu, Sep 01, 2022 at 08:06:47AM -0600, Tycho Andersen wrote:
> > From: "Eric W. Biederman" <ebiederm@xmission.com>
> > 
> > In my very light testing this resolves a hang where a thread of the
> > fuse server was accessing the fuse filesystem (the fuse server is
> > serving up), when the fuse server is killed.
> > 
> > The practical problem is that the fuse server file descriptor was
> > being closed after the file descriptor into the fuse filesystem so
> > that the fuse filesystem operations were being blocked for instead of
> > being aborted.  Simply skipping the unnecessary wait resolves this
> > issue.
> > 
> > This is just a proof of concept and someone should look to see if the
> > fuse max_background limit could cause a problem with this approach.
> > 
> > Additionally testing PF_EXITING is a very crude way to tell if someone
> > wants the return code from the vfs flush operation.  As such in the
> > long run it probably makes sense to get some direct vfs support for
> > knowing if flush needs to block until all of the flushing is complete
> > and a status/return code can be returned.
> > 
> > Unless I have missed something this is a generic optimization that can
> > apply to many network filesystems.
> > 
> > Al, vfs folks? (igrab/iput sorted so as not to be distractions).
> > 
> > Perhaps a .flush_async method without a return code and a
> > filp_close_async function without a return code to take advantage of
> > this in the general sense.
> > 
> > Waiting potentially indefinitely for user space in do_exit seems like a
> > bad idea.  Especially when all that the wait is for is to get a return
> > code that will never be examined.
> > 
> > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > [tycho: small fixups for releasing fuse file + nocred flag]
> > Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
> > Reported-by: Tycho Andersen <tycho@tycho.pizza>
> > Tested-by: "Serge E. Hallyn" <serge@hallyn.com>
> 
> Any chance you're willing to take this patch? We're still seeing this
> a lot and it would be great to get it fixed.

Another ping here, can someone take this? Miklos?

Thanks,

Tycho
