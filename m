Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D09696AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjBNRBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjBNRA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:00:26 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241DC2BEFD;
        Tue, 14 Feb 2023 08:59:58 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 78CFD5C01E0;
        Tue, 14 Feb 2023 11:59:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 14 Feb 2023 11:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676393994; x=1676480394; bh=itiioYCmHP
        T8YbkX40p6dVrOELRD6qyPUbf/4SXvrbM=; b=oNRSaCOA4ItdRjYLsKmpF2SgaM
        j0z6EpxHi+BVF4s9SvfX6gdaHXErwxKMsUCZ+mKdZK1zrOajeZ80qebKWeMBGno2
        S66UESOr2lfeQoJcmS0dIjKCo1WV2mvb7hAsy+iA9TqbOF3sLLv7+rd5DWjYwJ/4
        DarN89Ha/QzgnNCHOvwnxTNuUFf8Tb1FL4goqTLJ+II7zgr1g8ZvKcM8sDC79TD+
        +8gMQdtZ1HoQ6otc5xfpb+bZcRc0BDo8fh3kA3oqllM2CLlnCn6To4/6+b0t36t6
        F1hiDl3bOFl7N+zjb+hNiaOKIsy0IeZPnhUXebudpj9e5b1/mUDIIrK2TzQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676393994; x=1676480394; bh=itiioYCmHPT8YbkX40p6dVrOELRD
        6qyPUbf/4SXvrbM=; b=P3m1Qy+Qis2uohPsSIDpsxVLXT/fDbpDD5EIrMyi8QSK
        MsW9YBgDXglZQme0WfP4+Tu9mr/p7bkWQ99oTDGKUKb9vV8lLSA6ON6rznauu0CM
        1Jq4z/Io2CP9NDq+dKops2Anp05aG5OaPNebibrOXRBWyPmH5jmjSpfvP2R0v3L7
        LM6+8s4HagwmyDdWYiD+6lkG9aW68B1X/qZgqNG6/Gfmy4zpmsu7uHnD4Y6GFZbl
        +OszX0+pAtuJ2hxS7RSW5VbAnjYcm7TKEeY+WgIkpJEjvnqINnaKIahz6IV/GjK8
        jFt1TKutfE2uzIRSsV4CF/yd4skrN1HfrPNjxxegnA==
X-ME-Sender: <xms:Cb7rY083WXpsYPisC2W8ZaWTP9839EERR9dTHJl7W9t_aRU_n28n4A>
    <xme:Cb7rY8uidwamo1IRj--IsJzi5d8c6vR5l8MvHc8bwsoXhOiedtTLi3e5z3MhdKBjU
    -rVoR46h9lA0Q>
X-ME-Received: <xmr:Cb7rY6AKt1GVfseb5r1cQL0IdGk4fsvWIpX9rLr9X4T6-U3EQvgDGlKvW3YSwSl0CNzAT55_wJ4zDw12tglS6_ZobJxk3EGfM0gD9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeifedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:Cb7rY0ey3g7NQf7LemxVdh5BXzP3B9JOjwKjUBervIpLCCB_GpE5-A>
    <xmx:Cb7rY5N2tZBEkcX0gFgJDLGIgc_v9wzTq-oQZ5L3OBu8WtFDwCSyJA>
    <xmx:Cb7rY-kqNvBUpOIrMdwoiz1R0eXG3WXuc10EdrykIRA4SjK6qxy_7Q>
    <xmx:Cr7rYyjbvTX0IQUho4Cyl8roekojJwGG8aWAEQxqoW8LxCzoNMKVCQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Feb 2023 11:59:53 -0500 (EST)
Date:   Tue, 14 Feb 2023 17:59:51 +0100
From:   Greg KH <greg@kroah.com>
To:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the driver-core tree
Message-ID: <Y+u+B/yi51JB26If@kroah.com>
References: <20230214125700.606a89d7@canb.auug.org.au>
 <Y+suRQBtzCWx+mjo@kroah.com>
 <eade11f9-22a2-1e7b-93da-d52b63cf9a5f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eade11f9-22a2-1e7b-93da-d52b63cf9a5f@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 05:47:16PM +0100, Wysocki, Rafael J wrote:
> 
> On 2/14/2023 7:46 AM, Greg KH wrote:
> > On Tue, Feb 14, 2023 at 12:57:00PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > The following commit is also in the pm tree as a different commit (but
> > > the same patch):
> > > 
> > >    a0bc3f78d0ff ("kernel/power/energy_model.c: fix memory leak with using debugfs_lookup()")
> > > 
> > > This is commit
> > > 
> > >    a0e8c13ccd6a ("PM: EM: fix memory leak with using debugfs_lookup()")
> > > 
> > > in the pm tree.
> > That will be fine, thanks for the warning.
> 
> I can drop the EM change, though, if you are going to carry it.

When one branch adds it, and another adds and then removes it, and then
the two branches are merged, what is the result?  The patch added, or
removed?

It's safer to just leave this as a duplicate, I know git can handle that
just fine.

thanks,

greg k-h
