Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311D5651FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiLTL0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbiLTL0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:26:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F6A167DF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:26:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A623061328
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2317DC433EF;
        Tue, 20 Dec 2022 11:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671535561;
        bh=jOVtCJggIM0oxUKo//5l6aX8dwZIk924IfBqQt7vbrM=;
        h=Date:From:To:Cc:Subject:From;
        b=mgS3NVOeg1pd9UJNxmP5UOtnYwr2w+8pQZ2nJORyPmrwapaNeygrtQUAPIz/uNG/r
         h6DXcKDNeXy7i01pPwh9CgAWz/3sAoayIdGpfyefpbQpODgVtEJmxRsnft/+eg/f/r
         19OwfEKFnXB64EVX4hOYEyNl+R6jhiUsdPJAZQFhbo8mqdHjr7Ee7rOAiEDMQAfbTo
         O8a180lboW6tZzqqR9hC+OVyqt+/FFx+6GZpH+UBmkRF41VHM7C+7WQQXnx4l7TS//
         fVQGCaR3eUnZX5a9Uqtk7MSMpsAk0Y7s/Zq3DKS8rL3ssmgIKf+h9OKiCaAI5mN4u2
         7FQHafbBlKNtA==
Date:   Tue, 20 Dec 2022 11:25:57 +0000
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Backlight for v6.2
Message-ID: <Y6GbxUZ2weD7PxoN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.2

for you to fetch changes up to 0de796b6047d1ccc29d03fcd0a93dca52691ec21:

  backlight: tosa: Convert to i2c's .probe_new() (2022-12-07 13:33:03 +0000)

----------------------------------------------------------------
 - Fix-ups
   - Convert a bunch of I2C class drivers over to .probe_new()

----------------------------------------------------------------
Angel Iglesias (1):
      i2c: core: Introduce i2c_client_get_device_id helper function

Uwe Kleine-König (9):
      backlight: adp8860: Convert to i2c's .probe_new()
      backlight: adp8870: Convert to i2c's .probe_new()
      backlight: arcxcnn: Convert to i2c's .probe_new()
      backlight: bd6107: Convert to i2c's .probe_new()
      backlight: lm3630a: Convert to i2c's .probe_new()
      backlight: lm3639: Convert to i2c's .probe_new()
      backlight: lp855x: Convert to i2c's .probe_new()
      backlight: lv5207lp: Convert to i2c's .probe_new()
      backlight: tosa: Convert to i2c's .probe_new()

 drivers/i2c/i2c-core-base.c          | 14 ++++++++++++++
 drivers/video/backlight/adp8860_bl.c |  6 +++---
 drivers/video/backlight/adp8870_bl.c |  6 +++---
 drivers/video/backlight/arcxcnn_bl.c |  4 ++--
 drivers/video/backlight/bd6107.c     |  5 ++---
 drivers/video/backlight/lm3630a_bl.c |  5 ++---
 drivers/video/backlight/lm3639_bl.c  |  5 ++---
 drivers/video/backlight/lp855x_bl.c  |  5 +++--
 drivers/video/backlight/lv5207lp.c   |  5 ++---
 drivers/video/backlight/tosa_bl.c    |  5 ++---
 include/linux/i2c.h                  |  1 +
 11 files changed, 36 insertions(+), 25 deletions(-)

-- 
Lee Jones [李琼斯]
