Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567FC676725
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 16:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAUPaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 10:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjAUPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 10:30:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274812CFFC
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 07:30:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9DA2B8085B
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 15:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFE6C433D2;
        Sat, 21 Jan 2023 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674315003;
        bh=fWAJvJtB1JBVE3R/mnNuaOLmlYSvKSOjZruyxXQwJvY=;
        h=Date:From:To:Cc:Subject:From;
        b=DbluQd8eBIBjClHY/Yk50EOlNnwMpavSy6+RXNIjKoVUasavSMg3KJjHzRbqOa+A4
         dGSJ3uaGD/gJKm+gTpAOl/S3teqEIOEeowkrBVbvIpsBPksmwUikLbDnpY6bZnqbxx
         WHglDL4roGYoxziZv2foPaRzmhuam64N9UDXa7tA=
Date:   Sat, 21 Jan 2023 16:30:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 6.2-rc5
Message-ID: <Y8wE+Zifm+0wcajr@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.2-rc5

for you to fetch changes up to 739790605705ddcf18f21782b9c99ad7d53a8c11:

  prlimit: do_prlimit needs to have a speculation check (2023-01-21 16:14:17 +0100)

----------------------------------------------------------------
Driver core fixes for 6.2-rc5

Here are 3 small driver and kernel core fixes for 6.2-rc5.  They
include:
  - potential gadget fixup in do_prlimit
  - device property refcount leak fix
  - test_async_probe bugfix for reported problem.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Chen Zhongjin (1):
      driver core: Fix test_async_probe_init saves device in wrong array

Greg Kroah-Hartman (1):
      prlimit: do_prlimit needs to have a speculation check

Yang Yingliang (1):
      device property: fix of node refcount leak in fwnode_graph_get_next_endpoint()

 drivers/base/property.c                     | 18 ++++++++++++------
 drivers/base/test/test_async_driver_probe.c |  2 +-
 kernel/sys.c                                |  2 ++
 3 files changed, 15 insertions(+), 7 deletions(-)
