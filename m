Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69515F0F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiI3QKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiI3QKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:10:11 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DBB7969B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:10:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BC9045C013C;
        Fri, 30 Sep 2022 12:10:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 30 Sep 2022 12:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664554200; x=1664640600; bh=F4O4h+VOdz
        H126wyw/ep2Ha1ckfcYasTdafRdCqfFzk=; b=0G0OhHqOzl9Y0IsrfLNCTyydHW
        ltUZMccBq7Vz1WhIK1eAj6XURlL/GqKrky+I0pibesDtrceic5i1zZGFZrLFTcin
        6+8nK30JNw93myCmLTHALFLK1/znYIrP/3q8k7o5ThtQp9OGtTUfV2yx89vE3LAt
        4oSYPoqHHOz+QuZHVFR92Seh3UcjgTYAXTiZgNVs/JbBd/HeCLEDNGzo1EnTZlQj
        d+pQOfUhpeXjZ+u3Pr5ZO3VRkrd70NvCi/ojTJGhFrRtLTfzTFkg1B66GWd2pXF0
        qUr+WNUSlQ6E+HKe2wYUm7RfbKvBu+xA2T+gJy/Vl5NXfYZQy5EtaShwS60A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664554200; x=1664640600; bh=F4O4h+VOdzH126wyw/ep2Ha1ckfc
        YasTdafRdCqfFzk=; b=ZxlcOhFYMcoLfSgxalfhEAvs4yPcEdLbJRMZRAXJ+bUQ
        7lx7jnnZJMP877F1OGs1zgFm+KwUnGWXS10OKlBYhg0Ml3or+OA1UQmRzmj8C0S6
        OtEPjTsq7ax5Ba+fBSPeeuhchZybtUdRMU+dmEV7CukDsxZNQwu0FhI6X9Y7f1nE
        YvYsINhp0L87W/fUZhiJw5t1wpfvXJTGbzuS4cgXgD0iwOgJ1x5W4jydpW4vep90
        w4tOXJnB6Bg1AMjs8Cy76q7ae7B+SheNc+ZIRDGokamy3PiRzm1AchD4ejNBGvsZ
        OV8/w/M0fSNLfQVnDTXUJuS/Cf44297z0m+euoiyTg==
X-ME-Sender: <xms:2BQ3YwQwt7bpVqeb6AmzcY_zEDSDZi5Kac7-AXQw_nA4bbSHcW0mWQ>
    <xme:2BQ3Y9wlyWSNiW34d3Hx67x-c0kbAOAZCu5BHFwEdFD09mUYLwE9RimbPkMoHRIRz
    CmZ6K8ZsWTKNGDFZ6o>
X-ME-Received: <xmr:2BQ3Y90e2Uc5OuVBQWFgp1XXaF8ApUGEHqiRj6mCN8hZfh0Dh7UCawR9aTczoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehvddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:2BQ3Y0AezAeRc_LcxUKm03ZIR3B6Rt3dIASXW61emgFJfiJ0pYrf6g>
    <xmx:2BQ3Y5glWlRhEKkyfNaue-PEB-DvIl9HHhWl2i6cgXTOfdnF0_duLw>
    <xmx:2BQ3YwouL-F80-T-amZ2beQF1Q4gJdNoo2nw6UHFmZUbipxyxbMsRQ>
    <xmx:2BQ3Y-uKxxewA63Gj9L0G5Z_HNJ92O74ud9GRB2z3h85scDY593loQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Sep 2022 12:09:59 -0400 (EDT)
Date:   Fri, 30 Sep 2022 10:09:56 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] fuse: In fuse_flush only wait if someone wants the
 return code
Message-ID: <YzcU1IhHEa2oV0vo@tycho.pizza>
References: <CAJfpegswSAeUdxHR1Z8jC_nQtUm7_mD=ZZC_LyQczaoJWTPe3g@mail.gmail.com>
 <20220929163944.195913-1-tycho@tycho.pizza>
 <CAJfpegtcHW8AwjfjDSm8Y7OXbesrw=ZpX-CMujJ=1Zz_Ly2FdQ@mail.gmail.com>
 <Yzb20Y4wHrqUZ93Z@tycho.pizza>
 <CAJfpegsZk+R2wmXo_358J6YrxLaWN7=VAUEUaGjF1Jveb+qKJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsZk+R2wmXo_358J6YrxLaWN7=VAUEUaGjF1Jveb+qKJQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 04:41:37PM +0200, Miklos Szeredi wrote:
> On Fri, 30 Sept 2022 at 16:01, Tycho Andersen <tycho@tycho.pizza> wrote:
> >
> > On Fri, Sep 30, 2022 at 03:35:16PM +0200, Miklos Szeredi wrote:
> > > On Thu, 29 Sept 2022 at 18:40, Tycho Andersen <tycho@tycho.pizza> wrote:
> > > >
> > > > If a fuse filesystem is mounted inside a container, there is a problem
> > > > during pid namespace destruction. The scenario is:
> > > >
> > > > 1. task (a thread in the fuse server, with a fuse file open) starts
> > > >    exiting, does exit_signals(), goes into fuse_flush() -> wait
> > >
> > > Can't the same happen through
> > >
> > >   fuse_flush -> fuse_sync_writes -> fuse_set_nowrite -> wait
> > >
> > > ?
> >
> > Looks like yes, though I haven't seen this in the wild, I guess
> > because there aren't multiple writers most of the time the user code
> > that causes this.
> >
> > I'm not exactly sure how to fix this. Reading through 3be5a52b30aa
> > ("fuse: support writable mmap"), we don't want to allow multiple
> > writes since that may do allocations, which could cause deadlocks. But
> > in this case we have no reliable way to wait (besides a busy loop, I
> > suppose).
> >
> > Maybe just a check for PF_EXITING and a pr_warn() with "echo 1 >
> > /sys/fs/fuse/connections/$N/abort" or something?
> 
> AFAICS it should be perfectly normal (and trivial to trigger) for an
> exiting process to have its dirty pages flushed through fuse_flush().

Agreed.

> We could do that asynchronously as well, generally there are no
> promises about dirty pages being synced as part of the process exiting
> .  But ordering between dirty page flushing and sending the FUSE_FLUSH
> request should be kept.  Which needs more complexity, unfortunately.

How can we wait in fuse_set_nowrite()? Or are you suggesting we just
do a fuse_flush_writepages() in the async part and hope for the best?

Thanks,

Tycho
