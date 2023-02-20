Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4A769C903
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjBTKuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjBTKuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:50:50 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD5C16305;
        Mon, 20 Feb 2023 02:50:49 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 59F833200A94;
        Mon, 20 Feb 2023 05:50:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 20 Feb 2023 05:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676890244; x=1676976644; bh=nwwHLFcCSi
        lvLeymfa6ND58guxpD6ODnAJKVRbTIP2M=; b=bqCJ5Z4HwdWmhMVoU4a9cytWnW
        aZisjnHYyb4JLyGyORqcGfBYtYCO7kNVrExa7hWh+Mv1pYRtHwDcwfKFiXuuL5qh
        jYKknkqxU1jTxbwyfFKBhsucydmodivCjTAc79WoPPvcGr8JC/fnhwwg9/zgHeAn
        3rvtma7nl71PifnQuTjtwKZKbwFBfQC2yHpkhzhucrf3v0MyPRtdQgCp2tpk4S1y
        9Yq4/droh4AEKGMUFyGe1oReGpOMZPzJxj+pseHmrMkXmbiRTqZ3LcNGBAyuvFDs
        3rTbWTolm7gk3+coATsryN/gN38lJ1ixoL/givkt77L5bDsKmVlSc9sE8BKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676890244; x=1676976644; bh=nwwHLFcCSilvLeymfa6ND58guxpD
        6ODnAJKVRbTIP2M=; b=CLetfM5Njy0RJsYJYXzrMgk9X+65tJAvwcaMSQjy3JZY
        ot8cHWNrOAp2ZIGeYCKBazW6+8Ii8uP39M5ixE1V3GCxVvhkNJP21HhA2DTUdiX8
        Bdu8y2Pbzx+EfF0jTMYEdLyIwhJkM9uxEw/qQs/4+j/D8KQZ9GZp4zQ7Q9uUs2G2
        3HKG/WkCXK/0lm9PFB8/ZYlDzSJ4NhWY86AutnPBZSLfQUTnITCyrDtBh5Z1Nzjr
        q5c5zd8qSx/EOZMM4zm9q2WuTQW+c5DuiwqTOf3TBDQ3vGgEgtR8FYsNTOk3G407
        FKcHkfzp9EUsqWgfkySV1zXEbII08hGQBELVZNMyUg==
X-ME-Sender: <xms:hFDzY2pvQLu5M2iGuCn4Rhrz5_9BxvcIXBrAa_mgRvGTwrEyb3LFAg>
    <xme:hFDzY0rINoj1_7U53DZYFUzyoKJt7cmKYKuDQLccStJfILub8sJY9XF-9INWpbS-c
    gWrx1HqZUc65A>
X-ME-Received: <xmr:hFDzY7Mb3v6Gg4ATuJXxU2mXzhZ_qWY59YiX3FYF07ClCwZzHN9k8wqNaC9PyYMQ8NSJKmDud-BEwEUNUA2-HYSRKwqp0IbTEa20UA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejhedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:hFDzY14JXBnp8_FbIuwJx6ZAhivCDdMpTlLCrStr-hbg1M_mHqbklQ>
    <xmx:hFDzY141ht-Nx2pOdKpeo7tioCAyKY92a4CDrkO1r9FSvugnLoNAiA>
    <xmx:hFDzY1jJpfdipnBI-sbD03_2C4ulLdsLz4lS3KurP21JjDrZmwycVg>
    <xmx:hFDzY_tWZ1cnFECF-XXYgh0i87uBp2WMt5MUJSDUIMnHNALROKtrQg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Feb 2023 05:50:43 -0500 (EST)
Date:   Mon, 20 Feb 2023 11:50:40 +0100
From:   Greg KH <greg@kroah.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the driver-core tree
Message-ID: <Y/NQgAXYVDAd20cg@kroah.com>
References: <20230220163133.481e43d8@canb.auug.org.au>
 <896c1146-21bb-35bb-dc25-a12014eb5ccd@bytedance.com>
 <Y/Mh7uA61KMvMHAt@kroah.com>
 <Y/NCPC3rjOT7dJtE@debian.me>
 <3a449abe-b5c8-cee3-6c2e-bfb79eb51f73@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a449abe-b5c8-cee3-6c2e-bfb79eb51f73@bytedance.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 06:15:33PM +0800, Qi Zheng wrote:
> 
> 
> On 2023/2/20 17:49, Bagas Sanjaya wrote:
> > On Mon, Feb 20, 2023 at 08:31:58AM +0100, Greg KH wrote:
> > > On Mon, Feb 20, 2023 at 03:26:41PM +0800, Qi Zheng wrote:
> > > > 
> > > > 
> > > > On 2023/2/20 13:31, Stephen Rothwell wrote:
> > > > > Hi all,
> > > > > 
> > > > > After merging the driver-core tree, today's linux-next build
> > > > > (htmldocs) produced this warning:
> > > > > 
> > > > > Documentation/filesystems/api-summary:146: fs/debugfs/inode.c:804: WARNING: Inline literal start-string without end-string.
> > > > > 
> > > > > Introduced by commit
> > > > > 
> > > > >     d3002468cb5d ("debugfs: update comment of debugfs_rename()")
> > > > 
> > > > This is just a comment modification. Didn't see where my modification
> > > > caused this WARNING. :(
> > > 
> > > Yeah, I don't understand either, here's the diff, what's wrong with it?
> > > 
> > > 
> > > --- a/fs/debugfs/inode.c
> > > +++ b/fs/debugfs/inode.c
> > > @@ -802,8 +802,8 @@ EXPORT_SYMBOL_GPL(debugfs_lookup_and_remove);
> > >    * exist for rename to succeed.
> > >    *
> > >    * This function will return a pointer to old_dentry (which is updated to
> > > - * reflect renaming) if it succeeds. If an error occurs, %NULL will be
> > > - * returned.
> > > + * reflect renaming) if it succeeds. If an error occurs, %ERR_PTR(-ERROR)
> > > + * will be returned.
> > >    *
> > >    * If debugfs is not enabled in the kernel, the value -%ENODEV will be
> > >    * returned.
> > 
> > Hi Greg and Qi,
> > 
> > The simple fix is to drop the percent (which is an inline code variant):
> > 
> > ---- >8 ----
> > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > index 58a35afb7c5d89..a7a6a0821605a8 100644
> > --- a/fs/debugfs/inode.c
> > +++ b/fs/debugfs/inode.c
> > @@ -802,7 +802,7 @@ EXPORT_SYMBOL_GPL(debugfs_lookup_and_remove);
> >    * exist for rename to succeed.
> >    *
> >    * This function will return a pointer to old_dentry (which is updated to
> > - * reflect renaming) if it succeeds. If an error occurs, %ERR_PTR(-ERROR)
> > + * reflect renaming) if it succeeds. If an error occurs, ERR_PTR(-ERROR)
> >    * will be returned.
> >    *
> >    * If debugfs is not enabled in the kernel, the value -%ENODEV will be
> 
> LGTM, do I need to resend the patch with this fix?

Bagas needs to send it as a real fix so that I can apply it.

thanks,

greg k-h
