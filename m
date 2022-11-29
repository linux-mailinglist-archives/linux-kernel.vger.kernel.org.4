Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2646763BB8D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiK2I32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiK2I2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:28:55 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592F22D4;
        Tue, 29 Nov 2022 00:28:12 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C1A7F5C013F;
        Tue, 29 Nov 2022 03:28:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 29 Nov 2022 03:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669710489; x=1669796889; bh=oJL+vWNc8V
        oEVmSHLNBSd0VMgyTgBe9/oE+igmrFcKM=; b=UciQKjoac7RQ7y0jT76YjelVZd
        Wg7lOP1uLFHu8vWGye1FPnYNX3eklj0g0viHLo3DzBha3C0WZ5zUo1PbAQoIt+dR
        ndzMfCZY0Ci4cyzFh/YJlolkQKws4HOBwQKE9Fuuao5oDhE2OWSV9Zjhc03ezcPT
        rbKrg31+X2AaIfDRekVczGLbRhqnmzQlpav9cIo8qQq46VP/+E9dqZwxcFgEqaVI
        OFY0qVVqJC9EvaPwKe8l4IWV137Bj69jj/kiY7x5LorAKF2kLS2tKQty80YX0ohp
        AuVsnROFm/fPYQ+EHtAQwgqD/FbdmgieJxhR3Ln2J3yri6AorxG/+wgVQv/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669710489; x=1669796889; bh=oJL+vWNc8VoEVmSHLNBSd0VMgyTg
        Be9/oE+igmrFcKM=; b=TkUUIZh9MTpyv4uVgmRcXSDUJrJGwAEU6xN8Wd0vaVVP
        TKFYc2NMjsNpVpl2DNFzuA9rHjkG1ThhS5bYzmJsQ0RMC88+yHUfkmDDiE/hLAqW
        fzbru+D+saF+bo6zzA3Gl0wx9UWTNdnGbLuQX7TVmVKyJefZVJDNCt1GuT557vnQ
        zoXdKQ1Pi9vF+33C+07be2t+C8dFCGGtfaczknF12hG6F/EJ5Dd0g6EBXjOMRdgw
        ZYUSWnVBi3MpzjBGFSXGGF+/TO7sX3k8qW5DVGA60NebQf5+2FaEheRbde52g8y/
        Tkr8xOhSQMJxUDHB5DDRQpz2xwy08yKikqCopvDgbQ==
X-ME-Sender: <xms:mcKFY8hUTxOqcRe0oMDhjKi-k-4jYcYf-ssywbD05JoKUEe6wL3NQA>
    <xme:mcKFY1DlSF9XcTr8cijlT0JH6FZXnpV2u-J2Usu1ycRC_S3KYXo2-6eXriIT43dN_
    9oy6545PEas7w>
X-ME-Received: <xmr:mcKFY0HbL83eouHfJO2XS9sY10jZfZkrGppdRsJ0nY4TBdyUbxDm0aNB3yZ2Bms5-c9ogq0sBhpRkZxcnqowgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjeefgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:mcKFY9QsLB-yqoycY16ripkRIeVdk_8-f3WxVdby0JIZr27FxtdqGA>
    <xmx:mcKFY5xSyV2MDFYYBAxL4Cmeq1eDObbvYmHf9t-XPZvzEEfz2CE52Q>
    <xmx:mcKFY77wpr-4dz8QbV1ZGTY-OFde7KDIQLz5qhkq9eKpOZgOH0LNFg>
    <xmx:mcKFY7s2iC50O1RV_URyLB_h5K81MxzWf761qqCEN9WkBaZ5BzxA5g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Nov 2022 03:28:08 -0500 (EST)
Date:   Tue, 29 Nov 2022 09:28:05 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <Y4XClZLzBoRZm/7Y@kroah.com>
References: <20221128133600.14ce44bf@canb.auug.org.au>
 <Y4Sga+ONeDe9Q7yz@kroah.com>
 <20221128234408.7a4dec34@canb.auug.org.au>
 <Y4TgXLb4EweoJb0k@kroah.com>
 <20221129064605.1aadc0e6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129064605.1aadc0e6@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 06:46:05AM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Mon, 28 Nov 2022 17:22:52 +0100 Greg KH <greg@kroah.com> wrote:
> >
> > Odd, why is 0-day not triggering on any of these in my tree?   Anyway,
> > I'll go fix it up, thanks...
> 
> Does 0-day do powerpc builds?

I thought it did, based on other problems I have had reported.  I'll go
queue this fix up now.

thanks,

greg k-h
