Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2C46B59F9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCKJTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 04:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjCKJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:18:44 -0500
Received: from einhorn-mail-out.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6511CF6D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:16:20 -0800 (PST)
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id 32B9Ftmi3700766
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 11 Mar 2023 10:15:55 +0100
Date:   Sat, 11 Mar 2023 10:15:54 +0100
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, tiwai@suse.de,
        broonie@kernel.org
Subject: Re: [PATCH] MAINTAINERS: replace maintainer of FireWire subsystem
Message-ID: <20230311101554.14c211d4@kant>
In-Reply-To: <20230311080343.GA378828@workstation>
References: <20230306035814.78455-1-o-takashi@sakamocchi.jp>
        <20230310210356.561dbe63@kant>
        <20230311080343.GA378828@workstation>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 11 Takashi Sakamoto wrote:
> I'm glad to see you again in the list ;)
> 
> I really appreciate your long effort for the subsystem. I guess that your
> life became swamped recently against your work in the subsystem, while I
> feel that soft-landing of the project is still preferable for users.

Thank you. I need to apologize that I neglected to (at least) drop my
maintainership title myself. I should have done so when I started to
realize that I am not able to fulfill this role anymore.

> Below items are in my plan for the subsystem until being closed. I'm
> pleased if getting your help in any time.
> 
> * 2023, 2024, 2025, 2026
>   * take over the subsystem maintainer
>     * set up repositories in `<https://git.kernel.org/>`_

Do you plan to re-use the existing (but neglected, by me) repos at
kernel.org? 
	https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
	https://git.kernel.org/pub/scm/libs/ieee1394/libraw1394.git
	https://git.kernel.org/pub/scm/libs/ieee1394/libiec61883.git

If so, is there something which I can do to transfer access to you?
(Although if yes, before that I need to enable myself to send encrypted
e-mails again, after both of the mail user agents which I use dropped gpg
support. Maybe the kernel.org admins can assist you quicker with repo
access than I might.)

>   * refresh web site and update information
>   * take over the administration of communication channels
>   * adding the list archive of linux1394-devel to
>     `lore.kernel.org <https://korg.docs.kernel.org/lore.html>`_
>   * fix issues of subsystem
>     * modernize 1394 OHCI driver
>     * Pull requests to Linus
>   * get help from Linux Foundation to place documents for specification
>     defined by 1394 Trade Association
>     * If no problems, upload the documents to the new web site
>   * invite repositories of external librararies (``libavc1394``, ``libdc1394``)
>     * Announcement to distribution package maintainers about the upstream shift
> * 2027, 2028
>   * Close announcement to below applications
>     * `FFMPEG <https://ffmpeg.org/>`_
>     * `GStreamer <https://gstreamer.freedesktop.org/>`_
>     * `VLC <https://www.videolan.org/vlc/index.ja.html>`_
>     * `MythTV <https://www.mythtv.org/>`_
>     * `FFADO <http://ffado.org/>`_
> * 2029
>   * Close the project
>   * Close the communication channels
>   * Archive repositories
>   * Resign the subsystem maintainer

It's good to see you being active in the kernel and related userland
development/ maintainership, and that you have a plan for the next years.
-- 
Stefan Richter
-======--=== --== -=-==
http://arcgraph.de/sr/
