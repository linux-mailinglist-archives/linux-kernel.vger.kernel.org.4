Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578B66B5966
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 09:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCKIDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 03:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCKIDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 03:03:52 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C48BBB3B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 00:03:49 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5F4DC3200302;
        Sat, 11 Mar 2023 03:03:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 11 Mar 2023 03:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1678521827; x=
        1678608227; bh=LPUiO5ihZribBMR36kf9I/dPoJm6f/6L0pCKVHMrlOI=; b=m
        iG77Zxh9fyCVghA1eoVlx3ZX0AmyAd4vDs/MAZt8PLqTR/UXQ39woNwe+Y6C6RVE
        QLNGYsV/LEiTqR31RKGLgjxwC5xXJFdzVrBf+VRdndLggI/p/Mjrg8V5qEUnpKfb
        HxJXyPUWE4C3b+vSCAFsus+C58v2g8WGsnFg3quJa7JZ5NFD2sxMWsGRpWWEoiRE
        JK8WE41Px/0MSCN8afId4e/hoLSLTv0zxVnOKtIWyKnMeOpRwgaQmco3TI58M3nS
        GMtBhPfAegyXwrRde5DBHiFw7vXcgAoYWqw0YmyoAn9UNFmY/AVeYLro5UA0TxdK
        VSe7CqrsYrIOZQMQ3SZ3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678521827; x=1678608227; bh=LPUiO5ihZribB
        MR36kf9I/dPoJm6f/6L0pCKVHMrlOI=; b=RZa0sWw6TuaBjswgd0TRQH2mVbD+g
        83WdyBKHvRLKfAm2zB3qXJYYihDhXRa2KRPKQdkGbkCFisYOgihOYZZVESRZeNC0
        PyDSKrDTWelRwwzjVJYjXgEso134W+Gt8VORH7qRGf6ipVwRhPHBbC9/hgEED/SA
        vuKaFeu3Gm0GmyZP4VViS9I0sXJukxrjIBuEbYusexDTFtg6RovAkV7aGcREafN1
        c2jrB/xEng0SKgA8T0jot4Rt/8gjQSnnzqjUfE/wRng+aVoBdYAfh9KOUWZjUKt3
        b2wljMrg3/AIw8l44agMxzOnZBKkPaMnGz4JmO/m70MoRey2OTasruOcQ==
X-ME-Sender: <xms:4zUMZAkylETHO_pZr2zqXKEuEsMugnhbHmq19ZkOzaEuERBUzoJEjQ>
    <xme:4zUMZP1_T47mtYQLFR0mkkOmUChLece4Jdlsw-QTC6-oSKB4q_xETcRhvc_1lMLHh
    G_XmFW8hjeN7ERggHY>
X-ME-Received: <xmr:4zUMZOokc18IRGc5_VW2u67OIlMAa7cmMTfQICa2vydVRNYMpnD3GJSgVd7iG5CEeN-OwPqrz7MF8cXNabBuuB8P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduledguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghk
    rghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhih
    drjhhpqeenucggtffrrghtthgvrhhnpeeiueelkeeljeevvefhieeileffffdtleeihefg
    feefveekfffgudehkeejkeevleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhffh
    hmphgvghdrohhrghdpfhhrvggvuggvshhkthhophdrohhrghdpvhhiuggvohhlrghnrdho
    rhhgpdhmhihthhhtvhdrohhrghdpfhhfrgguohdrohhrghdprghrtghgrhgrphhhrdguvg
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdht
    rghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:4zUMZMlfzE_IKJT2xv5RVwQArjfGDWGC2KA8ZTsXJ-6s-Pz8T36TRQ>
    <xmx:4zUMZO0io2-uSHuo-wLOKmBuAVBwJ9CxuL6eO7fz1EZ4RDJ3HK_TPw>
    <xmx:4zUMZDtpOVPJjxELaYCQPBGS27vNQy3_OwkLRHhMox76RY5tN9os1w>
    <xmx:4zUMZDyb8SKVcUYz-KSTUcHaARD7Oa6wscv4T8mrDhlLXRfr7X5oGA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Mar 2023 03:03:45 -0500 (EST)
Date:   Sat, 11 Mar 2023 17:03:43 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, tiwai@suse.de,
        broonie@kernel.org
Subject: Re: [PATCH] MAINTAINERS: replace maintainer of FireWire subsystem
Message-ID: <20230311080343.GA378828@workstation>
Mail-Followup-To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
        tiwai@suse.de, broonie@kernel.org
References: <20230306035814.78455-1-o-takashi@sakamocchi.jp>
 <20230310210356.561dbe63@kant>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310210356.561dbe63@kant>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Fri, Mar 10, 2023 at 09:03:56PM +0100, Stefan Richter wrote:
> On Mar 06 Takashi Sakamoto wrote:
> > In the last few years, I have reviewed patches for FireWire subsystem and
> > requested sound subsystem maintainer to sent them to mainline, since
> > FireWire subsystem maintainer has been long absent. This situation is not
> > preferable since we have some user of sound hardware in IEEE 1394 bus.
> > 
> > I will stand for the maintainer, and work for FireWire core functions and
> > 1394 OHCI driver, as well as sound drivers. This commit replaces the
> > corresponding entry.
> > 
> > As you know, IEEE 1394 is enough legacy. I would like to schedule the end
> > of my work in the subsystem. My effort will last next 6 years. In 2026, I
> > will start strong announcement for users to migrate their work load from
> > IEEE 1394 bus (e.g. by purchasing alternative devices in USB and hardening
> > system for them), then in 2029 let me resign the maintainer and close
> > Linux 1394 project.
> > 
> > My current work focuses on real time data (sampling data) transmission
> > protocol in packet-oriented communication, thus I would provide less help
> > to implementations for the other type of protocol; i.e. IPv4/IPv6 over
> > IEEE 1394 bus (firewire-net), SCSI transport protocol over IEEE 1394 bus
> > (firewire-sbp2) and iSCSI target (sbp-target).
> > 
> > If receiving few objections from developers, I will start my work to send
> > fixes for v6.3 prepatch, and PR for future v6.4 or later. I'm pleased if
> > getting any help until the end.
> > 
> > Reference: commit b32744751e75 ("firewire: add to MAINTAINERS")
> > Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> Acked-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

I'm glad to see you again in the list ;)

I really appreciate your long effort for the subsystem. I guess that your
life became swamped recently against your work in the subsystem, while I
feel that soft-landing of the project is still preferable for users.

Below items are in my plan for the subsystem until being closed. I'm
pleased if getting your help in any time.

* 2023, 2024, 2025, 2026
  * take over the subsystem maintainer
    * set up repositories in `<https://git.kernel.org/>`_
  * refresh web site and update information
  * take over the administration of communication channels
  * adding the list archive of linux1394-devel to
    `lore.kernel.org <https://korg.docs.kernel.org/lore.html>`_
  * fix issues of subsystem
    * modernize 1394 OHCI driver
    * Pull requests to Linus
  * get help from Linux Foundation to place documents for specification
    defined by 1394 Trade Association
    * If no problems, upload the documents to the new web site
  * invite repositories of external librararies (``libavc1394``, ``libdc1394``)
    * Announcement to distribution package maintainers about the upstream shift
* 2027, 2028
  * Close announcement to below applications
    * `FFMPEG <https://ffmpeg.org/>`_
    * `GStreamer <https://gstreamer.freedesktop.org/>`_
    * `VLC <https://www.videolan.org/vlc/index.ja.html>`_
    * `MythTV <https://www.mythtv.org/>`_
    * `FFADO <http://ffado.org/>`_
* 2029
  * Close the project
  * Close the communication channels
  * Archive repositories
  * Resign the subsystem maintainer

> > ---
> >  MAINTAINERS | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8d5bc223f..e137c1b2f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7954,10 +7954,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nab/lio-core-2.6.git master
> >  F:	drivers/target/sbp/
> >  
> >  FIREWIRE SUBSYSTEM
> > -M:	Stefan Richter <stefanr@s5r6.in-berlin.de>
> > +M:	Takashi Sakamoto <o-takashi@sakamocchi.jp>
> > +M:	Takashi Sakamoto <takaswie@kernel.org>
> >  L:	linux1394-devel@lists.sourceforge.net
> >  S:	Maintained
> > -W:	http://ieee1394.wiki.kernel.org/
> > +W:	http://ieee1394.docs.kernel.org/
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
> >  F:	drivers/firewire/
> >  F:	include/linux/firewire.h
> 
> 
> 
> -- 
> Stefan Richter
> -======--=== --== -=-=-
> http://arcgraph.de/sr/

Regards

Takashi Sakamoto
