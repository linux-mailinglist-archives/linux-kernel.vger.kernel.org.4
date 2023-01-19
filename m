Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE816731FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjASGy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjASGyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:54:25 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B883FF38;
        Wed, 18 Jan 2023 22:54:23 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2426832008C0;
        Thu, 19 Jan 2023 01:54:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 19 Jan 2023 01:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674111258; x=1674197658; bh=RND47AUAnf
        ov5Ie3MGERZHLzzuZ2xGXZlackKv+kGqk=; b=kBSHRTAMJOq5d3VvsYvJM8GKzH
        gmtqCnGLnjHoRZjkU1FZ2okflQ4Uz9M7HA+z6+uXmq6ZdejwWm7cUGzwJsBz9VLq
        oN2sLsPWwY241L3djmsPAmYp5RxxaFG4e8PHE1Qg62jfVHmBlBkzsTAy+AH4qbPB
        uyhGi+jQnDghO74dqsgaix6M72Gd5gMzD+sfocbnNdsl7EVF1Imc1mE1SVMz3Kax
        NqejDe2a+1I7l+RpyGDiKdHC57niSd9Uq6dFbNecdWaPPfYZ5Ys7xJ8BbUlYbfDa
        DprRrEErgJ6SRneuu7vsO4eKdDUVb+TVZb+Hi47Ob4PcnMNutO5PML02OWLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674111258; x=1674197658; bh=RND47AUAnfov5Ie3MGERZHLzzuZ2
        xGXZlackKv+kGqk=; b=olQ0fdelMp3AQGY3wn+O9cgnNtFQM9yrqbvQVI/wTPMn
        VvVjCLIKeJ1mVyZGrLw/z9sSaeiPVFtd53K5keC/Zk0yYWSpbv0DtZHmnbBpdDTb
        4MNfB62gOJDU6+BzIeP77C0epqKl2VPuhz0TqQSp4Myf3JKO+6+mgXQUjYtBSkkg
        PGpbxwK+sJTvFFrlonIdLX5xx552IjCPMP7V5NOQwY7ctSBs/GCLy6XmOUcyOrTm
        lCWzmCSQFdEmJytgr2W91eGFHGNwpAJMYk2VXduTWlNNX/QYsUFwczpHX1riXCUX
        suw5ig4Cz4YqrPy8Npmxg0xSeH/la16Xcirg7JKzMA==
X-ME-Sender: <xms:GunIY5NgfvT1vdxFL9_Wv5aG3O0KZpsPa8mxkbOMoUZGOLaYP4K8WQ>
    <xme:GunIY79MDW5gNPQXijZZ82iD9ACJCJTpZUlNNex2rVUuZr6ZfFTrq6fcznhyh6YP-
    5vW56JWRg2dtw>
X-ME-Received: <xmr:GunIY4SfESi5-cIUsvs9PlHypunRoBuj6J4Eu_N6qbG90K0H6f6DeuNXd8EhgDtyRRk9X-4hmVd2H3jIT1eXsNfQFwgNR0CHeBpaVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtledguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:GunIY1vvZK93y_tG3sR8iZvk37ToHDboSkQZcoV1XeEg3xUQKkZaVQ>
    <xmx:GunIYxdwLStWkl8Yi8rscDnqe5tV9qU0nslg_Q4l7KY5kL_b0fmepw>
    <xmx:GunIYx0AKP15mah1j9PWYPkbypY0xCvCLZ3hqiS20LkoN6-OOmfY9A>
    <xmx:GunIY832pcOxLgVl3ZBrjAw1VBdSF9VQ1SVSedrGxR6V-zu4to5aLQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 01:54:17 -0500 (EST)
Date:   Thu, 19 Jan 2023 07:54:15 +0100
From:   Greg KH <greg@kroah.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the phy-next tree
Message-ID: <Y8jpFw5mfvyRLX/C@kroah.com>
References: <20230119153145.598885cf@canb.auug.org.au>
 <Y8jfW2TTnHd3J7R1@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8jfW2TTnHd3J7R1@matsya>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:42:43AM +0530, Vinod Koul wrote:
> On 19-01-23, 15:31, Stephen Rothwell wrote:
> > Hi all,
> > 
> > The following commits are also in the usb tree as different commits
> > (but the same patches):
> > 
> >   5c7f94f8bad8 ("phy: tegra: xusb: Add Tegra234 support")
> >   e5f9124404d0 ("phy: tegra: xusb: Disable trk clk when not in use")
> > 
> > they are commits
> > 
> >   d8163a32ca95 ("phy: tegra: xusb: Add Tegra234 support")
> >   71d9e899584e ("phy: tegra: xusb: Disable trk clk when not in use")
> 
> Ah, ideally these should go thru phy tree!

Yeah, but they were submitted as a larger set of patches with USB
changes to me, so I took the whole series (it's hard to pick and choose
from a series).

I can revert them from the USB tree, but what harm are they causing now
as duplicates?

thanks,

greg k-h
