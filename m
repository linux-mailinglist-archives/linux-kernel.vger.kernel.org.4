Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10B86F4849
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjEBQbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjEBQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:31:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72129173C
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 09:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09478626C2
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 16:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820D9C433EF;
        Tue,  2 May 2023 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683045093;
        bh=deR6rr28MFMDPtl2zYle/9OiHvFXy3qBS5/xmSbtnmY=;
        h=Date:From:To:Cc:Subject:From;
        b=pMHGlileJJbCCAKKWCfdGlBqblNU+rzeAW+nBRxXc6Aw/d1Cb83xdVCJLdAvrx8jY
         Gf+9dh4lO6k0JKIT0JRZNdaZ1Y+GgUk1jTnR+YcTVuelL2vVfqBuhlP5ehA5ZRihQ6
         J9EBfuE4okgENKB26qd00q2+AQi0t5Lv/2GYZuqKZtwEWRehG8yRFt3eSq+mKwyXYI
         2YxBGq366SXknJXI1ZkMbizmXq2RXC41KrwIKhL5esmTSklu7HlvM9cgxvXLpD+YmM
         KWV4xR4WUPHT4BftdYlu6/hOMuSpbNq2VdDA1zT1bPe7JpMj2upViEJaegLA1ORFfy
         dJpDOitdpxgdQ==
Date:   Tue, 2 May 2023 17:31:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Backlight for v6.4
Message-ID: <20230502163129.GL620451@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.4

for you to fetch changes up to fb200218b40b7864f64f1a47de61e035d8934e92:

  backlight: as3711: Use of_property_read_bool() for boolean properties (2023-03-16 16:12:53 +0000)

----------------------------------------------------------------
 - Fix-ups
   - Add / improve Device Tree bindings
   - Convert (int) .remove functions to (void) .remove_new
   - Rid 'defined but not used' warnings
   - Remove ineffective casts and pointer stubs
   - Use specifically crafted API for testing DT property presence

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      backlight: lp855x: Mark OF related data as maybe unused
      backlight: arcxcnn_bl: Drop of_match_ptr for ID table

Luca Weiss (1):
      backlight: qcom-wled: Add PMI8950 compatible

Rob Herring (2):
      backlight: hx8357: Use of_property_present() for testing DT property presence
      backlight: as3711: Use of_property_read_bool() for boolean properties

Uwe Kleine-König (13):
      backlight: aat2870_bl: Convert to platform remove callback returning void
      backlight: adp5520_bl: Convert to platform remove callback returning void
      backlight: cr_bllcd: Convert to platform remove callback returning void
      backlight: da9052_bl: Convert to platform remove callback returning void
      backlight: hp680_bl: Convert to platform remove callback returning void
      backlight: led_bl: Convert to platform remove callback returning void
      backlight: lm3533_bl: Convert to platform remove callback returning void
      backlight: lp8788_bl: Convert to platform remove callback returning void
      backlight: mt6370-backlight: Convert to platform remove callback returning void
      backlight: pwm_bl: Convert to platform remove callback returning void
      backlight: qcom-wled: Convert to platform remove callback returning void
      backlight: rt4831-backlight: Convert to platform remove callback returning void
      backlight: sky81452-backlight: Convert to platform remove callback returning void

 drivers/video/backlight/aat2870_bl.c         |  6 ++----
 drivers/video/backlight/adp5520_bl.c         |  6 ++----
 drivers/video/backlight/arcxcnn_bl.c         |  2 +-
 drivers/video/backlight/as3711_bl.c          | 24 ++++++++++++------------
 drivers/video/backlight/cr_bllcd.c           |  6 ++----
 drivers/video/backlight/da9052_bl.c          |  6 ++----
 drivers/video/backlight/hp680_bl.c           |  6 ++----
 drivers/video/backlight/hx8357.c             |  2 +-
 drivers/video/backlight/led_bl.c             |  6 ++----
 drivers/video/backlight/lm3533_bl.c          |  6 ++----
 drivers/video/backlight/lp855x_bl.c          |  2 +-
 drivers/video/backlight/lp8788_bl.c          |  6 ++----
 drivers/video/backlight/mt6370-backlight.c   |  6 ++----
 drivers/video/backlight/pwm_bl.c             |  6 ++----
 drivers/video/backlight/qcom-wled.c          |  7 +++----
 drivers/video/backlight/rt4831-backlight.c   |  6 ++----
 drivers/video/backlight/sky81452-backlight.c |  6 ++----
 17 files changed, 42 insertions(+), 67 deletions(-)

-- 
Lee Jones [李琼斯]
