Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144DB64888C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLISlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLISlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:41:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B7E59FFB;
        Fri,  9 Dec 2022 10:41:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95ABB622FB;
        Fri,  9 Dec 2022 18:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A663BC433D2;
        Fri,  9 Dec 2022 18:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670611294;
        bh=HLCdf8lbrHwu/F+e8HIf65ZhPNgQNds3cOGyMfVwQPk=;
        h=Date:From:To:Cc:Subject:From;
        b=I9aZVSS/VKQ1Xy4vYME7UQLO2LIA5iYVtBgW4KmYXZNmyYM5XIdeVuccv5sx+vcGG
         01he4ygi8EPnt9wsUbZ6qafFdgQ3ZmBZ4I0pIab+3FbGsWGPVkAPflFRk5y9R+ejtY
         Gc5G32aywSJjLishtIWlp6UftbZQjBbe/6UOxX4WsOALIXYuWA0tqeNASxy0ElUZAP
         +YtCO19hY45gPmvdL1YhAY4GhYuYhkoJ834P1I4vPcpIhx6SldQChkie1P/kKhoUQ1
         GsXgySt+u3R173MFUagSXzxtSlGuw+s+ITSJnEWvufUne8dw/wb05HCMjtC3gbCNTZ
         GMOQ6L4jZUhHw==
Date:   Fri, 9 Dec 2022 18:41:29 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.1] media fixes
Message-ID: <20221209184129.1fdf3973@sal.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.1-4

For a v4l-core fix related to validating DV timings related to video
blanking values.

Thanks!
Mauro

---

The following changes since commit de547896aac606a00435a219757a940ece142bf0:

  media: vivid.rst: loop_video is set on the capture devnode (2022-10-25 16:43:54 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.1-4

for you to fetch changes up to 5eef2141776da02772c44ec406d6871a790761ee:

  media: v4l2-dv-timings.c: fix too strict blanking sanity checks (2022-11-23 12:02:30 +0000)

----------------------------------------------------------------
media fixes for v6.1-rc9

----------------------------------------------------------------
Hans Verkuil (1):
      media: v4l2-dv-timings.c: fix too strict blanking sanity checks

 drivers/media/v4l2-core/v4l2-dv-timings.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

