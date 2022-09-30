Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FCF5F0CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiI3OCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiI3OCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:02:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3769912937E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:02:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A4585C015C;
        Fri, 30 Sep 2022 10:01:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 30 Sep 2022 10:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664546517; x=1664632917; bh=dZbVw+XtAY
        MvxpeF93s1NO6jK2H5lrZu0Gxe9fS40fE=; b=4iHITf977Z4hO274vgsHrsWLiv
        fwmfordyIBWSDjYUou2Xkj+2u6QAp4Btf2VHRHKJBZtDCPo6J2Tic2OOydUuJSEK
        xVNiDGSZ/CxWcXFsWURJ1vLiIii458cZG1H1xOBm9qTx4nw5KxMQP42npPPf2dzZ
        cmCtDS3sFU+lPlTh9CGoc01Wh7MKYceyevLbAlKaHC1HSSKyCgUPXnxOJIng+MMo
        LNwxtrAnktsKbUyAjcCDA7YpHKQdqfJng/G/9u9OS3GYV3tCRo7sc60WLDboh1nA
        N/Q1jQJ8sKxPCGQMGXClVtwqQOsB77kkdsT0AGAjgeERg+PNeomDKzIC3EVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664546517; x=1664632917; bh=dZbVw+XtAYMvxpeF93s1NO6jK2H5
        lrZu0Gxe9fS40fE=; b=KHlt+LfZGwAIqX8qZ2D1Eurmkutbb8t7lmOSdYXl9gTJ
        YUWkIR+/Umbd4wnfUMS86KPSyKryMSp2lm3sUYcYdhah2h9ryRKx+WHTzuDmmcx7
        0tQk1T2T0R5R6XWqfdQ2FGupENfduhKzn7edUulLtFgIamUBNW7RBGw50ikjhBVp
        RHpEJvbhu1B1XayH1rfYKsQ6mN5CHCFYIohuQEezyEc/0IVElxJ4JLz21ZZyaqDh
        mAo/wuQvXuNaK50EUZr2+7KH144IWyqHWg1XwD9FZD0jqLsPcI0hurg28nwPy6dA
        bjCb+DWKEqJsIWpvq1ux0wV8NxgtsRc+/DA1bKvckA==
X-ME-Sender: <xms:1PY2Yx4yEwq8jROCteR1IAAUQDT1L9tpfbPkED_XGYY0gSFLf64nqA>
    <xme:1PY2Y-5m0QgB_ANdboIO7Cjm0ALkbuOLRpWwdTIncl6dFrVhyREPgG2XtTiLhELmF
    w7cb8OI5D4LX5gxsLU>
X-ME-Received: <xmr:1PY2Y4f_aiIP_8O5DgCdk40HP3mdpGTLIJaSpehqKyR_uCyV3FT_WjI8Vdv1QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:1PY2Y6KCebAgnnMM3O-KHtdbg0fU8_VKzAFuO3StEcGZw5fA7Pw7AA>
    <xmx:1PY2Y1LvtXShaqvjXpoQWn5Orf-AGM3li7TyExSSrXJ1bg6ZjqprqQ>
    <xmx:1PY2Yzwu-WK8qXdHAzLrH5P016wMAIME_rZbMvZdeU2ucoRt-GaH4w>
    <xmx:1fY2Y12fKl7cWlZQA8X_8r2N0pjDnyAirfKzwUawgDfq6OGPZOMcZA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Sep 2022 10:01:55 -0400 (EDT)
Date:   Fri, 30 Sep 2022 08:01:53 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] fuse: In fuse_flush only wait if someone wants the
 return code
Message-ID: <Yzb20Y4wHrqUZ93Z@tycho.pizza>
References: <CAJfpegswSAeUdxHR1Z8jC_nQtUm7_mD=ZZC_LyQczaoJWTPe3g@mail.gmail.com>
 <20220929163944.195913-1-tycho@tycho.pizza>
 <CAJfpegtcHW8AwjfjDSm8Y7OXbesrw=ZpX-CMujJ=1Zz_Ly2FdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtcHW8AwjfjDSm8Y7OXbesrw=ZpX-CMujJ=1Zz_Ly2FdQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 03:35:16PM +0200, Miklos Szeredi wrote:
> On Thu, 29 Sept 2022 at 18:40, Tycho Andersen <tycho@tycho.pizza> wrote:
> >
> > If a fuse filesystem is mounted inside a container, there is a problem
> > during pid namespace destruction. The scenario is:
> >
> > 1. task (a thread in the fuse server, with a fuse file open) starts
> >    exiting, does exit_signals(), goes into fuse_flush() -> wait
> 
> Can't the same happen through
> 
>   fuse_flush -> fuse_sync_writes -> fuse_set_nowrite -> wait
> 
> ?

Looks like yes, though I haven't seen this in the wild, I guess
because there aren't multiple writers most of the time the user code
that causes this.

I'm not exactly sure how to fix this. Reading through 3be5a52b30aa
("fuse: support writable mmap"), we don't want to allow multiple
writes since that may do allocations, which could cause deadlocks. But
in this case we have no reliable way to wait (besides a busy loop, I
suppose).

Maybe just a check for PF_EXITING and a pr_warn() with "echo 1 >
/sys/fs/fuse/connections/$N/abort" or something?

> > +       /*
> > +        * In memory i_blocks is not maintained by fuse, if writeback cache is
> > +        * enabled, i_blocks from cached attr may not be accurate.
> > +        */
> > +       if (!err && fm->fc->writeback_cache)
> > +               fuse_invalidate_attr_mask(fa->inode, STATX_BLOCKS);
> 
> This is still duplicating code, can you please create a helper?

Yep, will do, pending the outcome of the above discussion.

Tycho
