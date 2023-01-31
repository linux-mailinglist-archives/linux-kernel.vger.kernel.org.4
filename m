Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B42A68264C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjAaIYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjAaIYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:24:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B047F3B0D4;
        Tue, 31 Jan 2023 00:24:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C81F61440;
        Tue, 31 Jan 2023 08:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB9BC433EF;
        Tue, 31 Jan 2023 08:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675153483;
        bh=GNZBWTzNzOGrP0Nz1ONrZ4ukSsG986yq+VvcIMTLpSo=;
        h=Date:From:To:Cc:Subject:From;
        b=LhPnPluqsiD8VkGuQT1EU5bM5BM0AJhYJSo122ohp7+5qsOMDrClfkVxeZ0EsH/qm
         NCjYphQd9o64AkG8jbPxUOG7YzGmJKIIkE+ZyYyHGIxM68ZW3IUhzl5w2/bKf6KDuM
         /CL0Cf/8aj+wtF0B2ktXZfXk5egcpXupb8ITky0GEdASn8xdx6BfJXIptZsJPZ2+FD
         WORR04jiWRcI8PoBQP44VzAddysKwEiEmtnzS1WgQ713g7QtoYzq2pAOpjDD6gtYCe
         qZAcHbtGVTcbR7kU/4nSoSO4CvJxlQ5LT2Y6GjQNYG87F8csbfjm1ZXKnYWgAXI8KL
         JcJubIQGRwtfQ==
Date:   Tue, 31 Jan 2023 09:24:39 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.2-rc7] media fixes
Message-ID: <20230131092439.1abf31d0@coco.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
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
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.2-3

For a couple of v4l2 core fixes:
  - fix a regression on strings control support;
  - fix a regression for some drivers that depend on an odd streaming behavior.

Regards,
Mauro

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.2-3

for you to fetch changes up to 89c08aef8f8dcb5fc98ad8db7ca92c9dab1f26b0:

  media: videobuf2: set q->streaming later (2023-01-24 16:34:06 +0100)

----------------------------------------------------------------
media fixes for v6.2-rc7

----------------------------------------------------------------
Hans Verkuil (2):
      media: v4l2-ctrls-api.c: move ctrl->is_new = 1 to the correct line
      media: videobuf2: set q->streaming later

 drivers/media/common/videobuf2/videobuf2-core.c | 5 ++---
 drivers/media/v4l2-core/v4l2-ctrls-api.c        | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

