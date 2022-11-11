Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1433C625791
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiKKKES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiKKKEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:04:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1E0D133
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:04:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F95561F19
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60CEC433C1;
        Fri, 11 Nov 2022 10:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668161054;
        bh=5koOtRSEWx0yydZKUPvgNBo/LeIOH3ftI8YIXoGxb5s=;
        h=Date:From:To:cc:Subject:From;
        b=skHoedCxj4+QlSa7hgT5DZw+j55QVpAOD8KLaUcMx7eATWmTNoc4ZKzbzA/o7Ef+C
         6LUrfZgS3J6lJIZ8RzIKgd69MVKMJZgi4RfP7gouo3Fcma1thbwl7fhVbX5kQQoyrF
         vmtktskgwb8wi+R4rM8ovKVOBnvvCiwvIrV4csvBSaTQTYvEXr3sPuejuAE60jHB5M
         lk+6tYFHXHFoFAnFrf9XEaNQqb776qHNGf1CKHnHC/DLQUP7P8D5dU2VfGqKUthoZh
         SOB6caK4lOf0pADRXm8dHJaB9kW6zKO5BAlnF542y46wt5YipDR4Q54YVyXMv1X4xN
         /ZzPZFxKl4GUA==
Date:   Fri, 11 Nov 2022 11:04:04 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2211111101080.6045@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022111101

to receive fixes for HID subsystem. Highlights:

=====
- fix for memory leak (on error path) in Hyper-V driver (Yang Yingliang)
- regression fix for handling 3rd barrel switch emulation in Wacom
  driver (Jason Gerecke)
=====

Thanks.

----------------------------------------------------------------
Colin Ian King (1):
      HID: asus: Remove unused variable in asus_report_tool_width()

Jason Gerecke (1):
      HID: wacom: Fix logic used for 3rd barrel switch emulation

Yang Yingliang (1):
      HID: hyperv: fix possible memory leak in mousevsc_probe()

 drivers/hid/hid-asus.c   |  4 +---
 drivers/hid/hid-hyperv.c |  2 +-
 drivers/hid/wacom_wac.c  | 11 ++++++-----
 3 files changed, 8 insertions(+), 9 deletions(-)

-- 
Jiri Kosina
SUSE Labs

