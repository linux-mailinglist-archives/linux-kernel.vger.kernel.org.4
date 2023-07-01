Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16076744BA8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 00:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGAWxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 18:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAWxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 18:53:40 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A78B10DC;
        Sat,  1 Jul 2023 15:53:38 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E0E035C011A;
        Sat,  1 Jul 2023 18:53:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 01 Jul 2023 18:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688252014; x=1688338414; bh=9gVEP9d6+EePr
        8PbKRKG0QcFNdRRUpleSuiZLlsIZic=; b=gMpqwRueNBRwKjmboqn0TjWMtR5Jl
        OuUbp+zvBbOUYj8elbJVxbSmES8w0tGB1Cn1ClQGaWgov7UDnMufZtXs2UPJsBSm
        Jjo6sHe4ciobfDY9cuTcc5IJhaDI3RgY8XMxbzjyv38nu2o4XG8mA5lfLM4Yj9Ow
        +92g+e0Z4qIXxB26dKt39lPT6QguP0CE2dLAqhcEbZc5Urtgs8fvwnHLZ2RPCFM1
        kJnHdM0fPbdt37iVhVzOiGwRreGLv0iV2vPN+qYC1yhZUXoEGCeQK3QQpv3qsbH6
        WjZFqPyZIM1zflPM8X1bfgmD6bPrGAFCkH/01opV1W8sWW58nfhX4Oz0Q==
X-ME-Sender: <xms:bq6gZHgd-xHPsb9ennrEhPCWggtMT7fnO5EiJspt4hDPKu-EcI_y4w>
    <xme:bq6gZEB4-8Zu4Na1Nzya7KwMXSBwQm26FWP1_72jcuqhpvfjbTbEm14aFSwm2KxrR
    B2sQehOk4Y4fQ7T_bM>
X-ME-Received: <xmr:bq6gZHELfPl_kdfL29g_I_QTweCJVMwlloPOe6EXtXaMRwgTfgwyVX0zExZihgn0TLKSlfQXRmzt_IX9nEZV23celVxynMtr5iE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueeh
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:bq6gZETRJ3tO2Jb8Dc8YdvAqyJJsJX2VrTMozcc3obD3SjncMRlO4Q>
    <xmx:bq6gZEz26lRHQTvp47tNZKN-QllF3tq8P_M9CNnZL8RXrw03PP6NuQ>
    <xmx:bq6gZK7CSbjlS8oQnHTx08D4LTN5jCyi4lN-nLvEG-_JQRNe23G5Fw>
    <xmx:bq6gZP8ACmugftOr3TI724gYJiPi_0bNApbTf4x3ecgOCci3IHEZ5A>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Jul 2023 18:53:31 -0400 (EDT)
Date:   Sun, 2 Jul 2023 08:54:28 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        tech-board-discuss@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [Tech-board-discuss] Measurement, was Re: [PATCH] Documentation:
 Linux Contribution Maturity Model and the wider community
In-Reply-To: <2023070113-trimming-undecided-4923@gregkh>
Message-ID: <2b3c665e-331e-3262-5874-a2e6755f6b0e@linux-m68k.org>
References: <20230620212502.GI286961@mit.edu> <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org> <20230621100845.12588f48@gandalf.local.home> <1f5b0227-dbf6-4294-8532-525b3e405dc2@linux-m68k.org> <2023070113-trimming-undecided-4923@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jul 2023, Greg Kroah-Hartman wrote:

> On Sat, Jul 01, 2023 at 11:46:18AM +1000, Finn Thain wrote:
> > BTW. I assume that 'Fixes' tags are already being used to train AI 
> > models to locate bugs in existing code. If this could be used to 
> > evaluate new patches when posted, it might make the code review 
> > process more efficient.
> 
> That has been happening for many many years now with papers being 
> published about it and many conference presentations.  It shouldn't be a 
> secret it's been happening and directly helping with stable kernel 
> maintenance for a long time.
> 

Many years ago it struck me that the deficiencies of checkpatch.pl could 
be addressed with coccinelle but I still don't see this happening on the 
lists I read.

I see reviewers being spared from having to examine many flawed patches 
because the zero-day bot intercepted them and fed them to static 
analyzers. But I still don't see coccinelle being used to the same end 
i.e. to reduce the burden on reviewers and maintainers.

Has no-one tried it, or did it not work out?
