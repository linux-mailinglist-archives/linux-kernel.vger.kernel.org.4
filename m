Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5328656053
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 07:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiLZGVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 01:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiLZGVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 01:21:00 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EB93B2;
        Sun, 25 Dec 2022 22:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672035640; bh=v4MwRi2Ll/ZlnMu4qPACL7FxGTUvGFtOeMw4tcfp6h4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=mHzyZfz7LX+to2PTNt3LTCjlVfdaiaT3EHID9wEnG0b8xDV/4Eg05cf/2Cdbh7KzH
         iznd9gC2F8oB2zt/qTNQ+VTi60418mqWniYhrpG2sgYjcSYqqgqpwdVlc66XkBwAwC
         HzVkKqCK8hWgUarBQOuTp4LT1GjAPW0js1p2Pcws=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 26 Dec 2022 07:20:40 +0100 (CET)
X-EA-Auth: NThRsUfD1aX+HyjWUrZMS8iU/rFeZWeWIGMKH3STVufxG0OIpyuisQz7i/Di8jYLMdnn7CwLfOju5zTuh2+lbpGdOY3T6T7c
Date:   Mon, 26 Dec 2022 11:50:32 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v4 0/2] tty: serial: dz: convert atomic_* to refcount_*
Message-ID: <cover.1671898144.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series proposes to transition the driver from using atomic_t APIs to
refcount_t APIs for reference count management.

Dependency note: Please apply path 1/2 first since patch 2/2 depends on it.

Changes in v4:
   1. Correct the dependency note text above.
   2. Version label added for patch 2/2. No functional change.

Changes in v3:
   1. Patch series introduced rather than individual patches.
   2. Update patch subject line to indicate the atomic_t variable being changed

Changes in v2:
   1. Separate the change to patch per variable rather than combining multiple
      atomic variable changes into a single patch.

Please note:
   The patches are compile tested using dec_station.defconfig for MIPS architecture.

Deepak R Varma (2):
  tty: serial: dz: convert atomic_* to refcount_* APIs for map_guard
  tty: serial: dz: convert atomic_* to refcount_* APIs for irq_guard

 drivers/tty/serial/dz.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

--
2.34.1



