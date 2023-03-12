Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670EA6B639B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 08:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCLHHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 03:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCLHHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 03:07:37 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6310D39CD6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 23:07:36 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id AFE813200918;
        Sun, 12 Mar 2023 03:07:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 12 Mar 2023 03:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1678604853; x=
        1678691253; bh=UMczy/27U9NVi3oceygL+rUC/esO2p8l3FHM0K2IMrU=; b=l
        S6d8ZsGh+1qowJIPGFvg1qa+rXyBv7tomNiuywwV5A8/Ya5B+1a87y3RWdBtnHA8
        CutEhD+j6Fup3sEx43Mx+0T0pyjL4txx8dmF8RHbS4CxldiEWV7rzneJiaJJk8NI
        xSn9L9wIrxBC+LB+DyGdVeR9dqUHKuCCPw7rz/HZJTAUIV4nJ7fh5891Olguq6w3
        DViOCbZXii6RTCfIJ9hDayFVh+lMeo5JSavlaO3j8Z875ZlCyksXhHHr9eCANdyX
        IvaSfirSNydB/JI7dKxr0KbZWULatz1Sbl4VmSBMRnADu3eBrUbEZB5H+jT/uFDw
        wuc9BSyMzlkrWTy4cNlZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678604853; x=1678691253; bh=UMczy/27U9NVi
        3oceygL+rUC/esO2p8l3FHM0K2IMrU=; b=KCrNijciHoJHkz8ZQmAvSXhd1MCJw
        LCD7K+jSrwgfEuesuUflXIjHRCvpTCwqe1SYtK9+DO7gwQOTfO5Z37iy/DErXK1q
        DVdDYt2DSV0xSIwlpaC5fW39cT+Xc3BOii2gF+ONPKxnMxa5k4k2MrskEimZ3Iel
        ut2A+9yRXBTJYnxAlyTdPDd4qN/32MSpsIlEUo1dEnLSQlfcx/YR1IwP1oqC8AGC
        q0YPrq87Z0ny4wOEizkFyXtH3oAfRqw4f5NAl+uoNVPsMAOtfuhA4c/rxZKG+wHI
        w+4Epeq9QJX4Rrdx6v9Pbag6KVhKM2IOQSjLf5LoTt9Eu+47i8mxCBXQg==
X-ME-Sender: <xms:NHoNZIYMUUZbWcM-3rbWwCcldhdz-PGOKyvPQp9yV7M5b6bgHmqKPA>
    <xme:NHoNZDbVQMniHyazKLfnZ4mBJwF4jPkIAS4hgbRUTMZmtxViUuZwFi5n1uFCiwQZl
    D0SMNbca-LJj9DquJo>
X-ME-Received: <xmr:NHoNZC-kUUmWvaK38ccfWcCqwwNQRb9qWc8pZjrEUBiTV6xuYo3SDcpeB6Av85UK7fs_zCU0p2YbP3I_9QmRdJTsWGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghk
    rghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhih
    drjhhpqeenucggtffrrghtthgvrhhnpeetieevtdevvdejhedtffefvdeivefhtdeffedv
    fffhhfffffeiffeufeduueekleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhffh
    hmphgvghdrohhrghdpfhhrvggvuggvshhkthhophdrohhrghdpvhhiuggvohhlrghnrdho
    rhhgpdhmhihthhhtvhdrohhrghdpfhhfrgguohdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghm
    ohgttghhihdrjhhp
X-ME-Proxy: <xmx:NHoNZCqOfPNn67whPfE7WWqCliD6e0S5QGiLKePvgqAVFqkjdQ2BXQ>
    <xmx:NHoNZDoIvkptoxgz3AOzcTaKjr6M6uLXHngKqn1REOm9ULGzC-xgtw>
    <xmx:NHoNZAQ5rPCmksL_deTtYHMhthks_imU-9TDllbOrkMFF_gE4giUmg>
    <xmx:NXoNZCU72ZzPWptoiT5ZkHcJWGgLM9vNcnMMRTkvs0uoT_yaxhKqaA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Mar 2023 03:07:30 -0400 (EDT)
Date:   Sun, 12 Mar 2023 16:07:28 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, tiwai@suse.de,
        broonie@kernel.org
Subject: Re: [PATCH] MAINTAINERS: replace maintainer of FireWire subsystem
Message-ID: <20230312070728.GA421475@workstation>
Mail-Followup-To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
        tiwai@suse.de, broonie@kernel.org
References: <20230306035814.78455-1-o-takashi@sakamocchi.jp>
 <20230310210356.561dbe63@kant>
 <20230311080343.GA378828@workstation>
 <20230311101554.14c211d4@kant>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311101554.14c211d4@kant>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 11, 2023 at 10:15:54AM +0100, Stefan Richter wrote:
> On Mar 11 Takashi Sakamoto wrote:
> > I'm glad to see you again in the list ;)
> > 
> > I really appreciate your long effort for the subsystem. I guess that your
> > life became swamped recently against your work in the subsystem, while I
> > feel that soft-landing of the project is still preferable for users.
> 
> Thank you. I need to apologize that I neglected to (at least) drop my
> maintainership title myself. I should have done so when I started to
> realize that I am not able to fulfill this role anymore.
> 
> > Below items are in my plan for the subsystem until being closed. I'm
> > pleased if getting your help in any time.
> > 
> > * 2023, 2024, 2025, 2026
> >   * take over the subsystem maintainer
> >     * set up repositories in `<https://git.kernel.org/>`_
> 
> Do you plan to re-use the existing (but neglected, by me) repos at
> kernel.org? 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
> 	https://git.kernel.org/pub/scm/libs/ieee1394/libraw1394.git
> 	https://git.kernel.org/pub/scm/libs/ieee1394/libiec61883.git
> 
> If so, is there something which I can do to transfer access to you?
> (Although if yes, before that I need to enable myself to send encrypted
> e-mails again, after both of the mail user agents which I use dropped gpg
> support. Maybe the kernel.org admins can assist you quicker with repo
> access than I might.)

In the last week after posting the patch, I sent a request to system
administrator of kernel.org for the purpose. I think it will be done
within a few days so nothing left to us.

> >   * refresh web site and update information
> >   * take over the administration of communication channels
> >   * adding the list archive of linux1394-devel to
> >     `lore.kernel.org <https://korg.docs.kernel.org/lore.html>`_
> >   * fix issues of subsystem
> >     * modernize 1394 OHCI driver
> >     * Pull requests to Linus
> >   * get help from Linux Foundation to place documents for specification
> >     defined by 1394 Trade Association
> >     * If no problems, upload the documents to the new web site
> >   * invite repositories of external librararies (``libavc1394``, ``libdc1394``)
> >     * Announcement to distribution package maintainers about the upstream shift
> > * 2027, 2028
> >   * Close announcement to below applications
> >     * `FFMPEG <https://ffmpeg.org/>`_
> >     * `GStreamer <https://gstreamer.freedesktop.org/>`_
> >     * `VLC <https://www.videolan.org/vlc/index.ja.html>`_
> >     * `MythTV <https://www.mythtv.org/>`_
> >     * `FFADO <http://ffado.org/>`_
> > * 2029
> >   * Close the project
> >   * Close the communication channels
> >   * Archive repositories
> >   * Resign the subsystem maintainer
> 
> It's good to see you being active in the kernel and related userland
> development/ maintainership, and that you have a plan for the next years.

At the moment, I have a problem about the list archive.

As you know, kernel development process heavily relies on mail. Recently
many developers use lore.kernel.org to store blasted message as
persistent storage. I would like to follow to it.

According to the documentation[1], the list archive should be prepared
including sent messages as much as possible. However I subscribed it Feb
2011 and sometimes lost messages.

I think you have the stock of enough amount of messages in your mail
box. If you have enough free time, I would ask you to create list
archive for the purpose.

[1] https://korg.docs.kernel.org/lore.html


Regards

Takashi Sakamoto
