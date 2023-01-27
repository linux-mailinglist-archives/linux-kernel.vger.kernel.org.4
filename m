Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08FD67DE6E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjA0HVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjA0HV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:21:29 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351EE113F8;
        Thu, 26 Jan 2023 23:21:28 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E16793200916;
        Fri, 27 Jan 2023 02:21:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 27 Jan 2023 02:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674804086; x=1674890486; bh=GPiR4nUTID
        8b/LHPhOShXaRG4bCx24v2pEaiqflvWM8=; b=KfJ0FaGS1szhtqYMIB94Teb0pk
        AZ9lyq9OwsPfBAHAJVFNCwweIeaRYH5Ic2Fmy69tfuNExB72WY6r4QQx2Wawg8R8
        YglgzKm8PrqP/5oi0sQgWogGqPAuXDyjHZxsCZzvReHK9sVRUFlV6CixMrpGXiMe
        ze5o4bXG6Z33QWCm/P52cJwr4rH024BGs0eFyRdlUpMuwBQ4DEp6NF+EV/kO+mFw
        UHkC5lzxgX4h5WCSlZCsWFQmh0DAI9w2lZgfnYuRVLacqY7bK7a26icBGULTsvqJ
        qzwADhmAgCZz7L77B6t0TWU37SkNOMPFPq7N+AgYp5q27/HJXBX5HcQvzleQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674804086; x=1674890486; bh=GPiR4nUTID8b/LHPhOShXaRG4bCx
        24v2pEaiqflvWM8=; b=JJeLrVSBvjsjB2N62FBtE2LlKwv3qwr4p5aVpKofkY1i
        FtNpe01a3/aljgjmhFBszT0zRA0YRnU7tfW06GpyuaPfbGUPEG33vUkMKf1X5ju6
        t50UU7q89DAJa1nzBQRj1HaOb3twXuiQ7aj26JWaNg3hbXUNZAK3zbIXX3aTq5b4
        0jHyQK9UP91SwsPtJRTxys+KR8fHqhcJzTWvQc1udgpGARB6bcsYHWEaZTcqg2LW
        2ClEwAHmCMlDKJiaLezx6CZ2k7OY4aX2A/n3Lj11LL629q2uk4rLBem5aqOHL1m+
        ma2K3UGDcTq9F7y02178EU69bfG7J/sJQscD0OgGvQ==
X-ME-Sender: <xms:dnvTY5YgUbzsfDdhT-TPS0-Eds6zRb8Y9Mxfj76xjGQ8bJWZ70mrYg>
    <xme:dnvTYwbAD3jxUWV3NDYfXRDFcLLA23OUKZ0GrTMsK5fkltKj5UTbtX_WxtljP-H4n
    Bbba8lzjZxn4w>
X-ME-Received: <xmr:dnvTY79-InaQAQFhn23xBxbbIz3TW8MrB3dn2mLywvlBA4RVTH25c1ZRfcxVlV2aG6q5sM8ly9tDdyTH3_CGZ47N6Epbnp6X5MACzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvhedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:dnvTY3r9hglfPFQiCEmRZUTuCalzohTnU1R1qv4I0XP5ifCuSF_QCg>
    <xmx:dnvTY0pN8Qo4IUuqYJ-UciJLhLe09AWZvC6i6_FLIY-pZL8SgPdLQA>
    <xmx:dnvTY9QATWESsblgbwzECzKkUcgUslvGpZTqVqekHQyowD9a3DE3Kg>
    <xmx:dnvTYweV-omgs4rz8EvCiyGXatMZyP0o0QYFyjyqHvNIGsJENiOH7Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jan 2023 02:21:25 -0500 (EST)
Date:   Fri, 27 Jan 2023 08:21:18 +0100
From:   Greg KH <greg@kroah.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the kspp tree with the tty tree
Message-ID: <Y9N7bl6ioz5OvKmf@kroah.com>
References: <20230127155753.1f9b9517@canb.auug.org.au>
 <Y9N3GNBKzOKuSOMJ@kroah.com>
 <82cfbb3e-cb2c-199c-8833-35498ce894e2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82cfbb3e-cb2c-199c-8833-35498ce894e2@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 08:12:46AM +0100, Jiri Slaby wrote:
> On 27. 01. 23, 8:02, Greg KH wrote:
> > On Fri, Jan 27, 2023 at 03:57:53PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the kspp tree got a conflict in:
> > > 
> > >    drivers/tty/vt/vt.c
> > > 
> > > between commit:
> > > 
> > >    feb36abbedea ("tty: vt: remove struct uni_screen")
> > > 
> > > from the tty tree and commit:
> > > 
> > >    19c30ead3938 ("vt: Replace 0-length array with flexible array")
> > > 
> > > from the kspp tree.
> > 
> > Kees, I was waiting for a new version of your 0-length patch before
> > applying it as I thought there were review comments on it.  So you
> > should probably drop it from your tree or resend it so I can merge it
> > into the tty tree if it's acceptable.
> 
> feb36abbedea removes the array completely, so obsoletes 19c30ead3938.

Ah, nevermind then :)
