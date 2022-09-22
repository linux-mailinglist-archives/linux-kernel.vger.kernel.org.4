Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DCE5E6437
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiIVNvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiIVNvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:51:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25813A00E9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90B53633A0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D88C433D6;
        Thu, 22 Sep 2022 13:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663854683;
        bh=NeGFrtEIpiL1PLwuDIJMKm/T/v2XPcFsQQ14kOP7FDE=;
        h=Date:From:To:Cc:Subject:From;
        b=NACEWJNjKrFxKYyQoerCShxXAfiQsdIQqJPcellArOHyFf+H+fh9rSBt1eFI8iTEi
         jklQW68n0rFowTQPTHy4NlE5t/vMz+aVht+rNagduZGf0zHN/XQeJAxYKThdkDCdte
         RtaBdQGLmwXurVbh0SnPp6Z4rOkYIKwKClhYbHpPXKM7I323hhKQdV5/+ghLNe+LPr
         wKugHyIfpZ09zrd6ZFlv+u1QBHNPLxL3tuE/c8+6ncqShXmC5fOCbfnbvlEXoUWi+K
         ueiC/6IH9qxxu6VF6SFNhWTotPP+H72GMkSYrWUVoEkWGk3isJyzA0j31OhYR0IyAB
         I2dvTTZTRReSg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1obMbw-0005NX-N7; Thu, 22 Sep 2022 15:51:28 +0200
Date:   Thu, 22 Sep 2022 15:51:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] GNSS updates for 6.1-rc1
Message-ID: <YyxoYMIT4lMw/O5f@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-6.1-rc1

for you to fetch changes up to c0c725d7350ec8b8453257676a440bb4b2df2422:

  gnss: replace ida_simple API (2022-06-21 09:30:36 +0200)

----------------------------------------------------------------
GNSS updates for 6.1-rc1

Here are the GNSS updates for 6.1-rc1, which includes a single IDA API
cleanup.

Everything has been in linux-next with no reported issues.

----------------------------------------------------------------
Bo Liu (1):
      gnss: replace ida_simple API

 drivers/gnss/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
