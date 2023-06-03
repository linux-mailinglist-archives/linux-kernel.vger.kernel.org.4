Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988CA7210FF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 17:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjFCPkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 11:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFCPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 11:40:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F24B99;
        Sat,  3 Jun 2023 08:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1254615C1;
        Sat,  3 Jun 2023 15:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E53C433EF;
        Sat,  3 Jun 2023 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685806811;
        bh=KuLD2EieaZl3hj3EQhXt/gEIzUtAAcbn2wmGeT/RqrA=;
        h=Date:From:To:Cc:Subject:From;
        b=khztilMr+6z0WMS4Z5Swe7+fCtDufndWrsFw/Tls+PZv8A+UiaQdOmkvLBStMATnS
         5QZVUw4TtAMp6BakfS8AErBMyCepo+5PGDmydIKLKWEqvozkUMm7HWGhe8vixJJIeu
         YjVMxyrqgxHEGLUFhfWmOux8mJWs97TgT2uP6UkS4vggjpmzLPyunzrWs74yvgZOfW
         7ywr5XiTI5dbsVKedGHO0UqFw3YAmQcgR23z4h4H7Eh1qzSgtNivcG9cbRo7R6fOvG
         VjZbgvjN/von8nt42deMhvjdTzP1W1issFpd3+ocll7hkoM37Hc9DVRyhJ3FerD1YI
         ca/SQayUvxthA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q5TMc-0002aR-S5; Sat, 03 Jun 2023 17:40:23 +0200
Date:   Sat, 3 Jun 2023 17:40:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] LEDs fixes for 6.4-rc5
Message-ID: <ZHte5sPkB6-D-94G@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a fix for a regression in 6.4-rc1 which broke the backlight on
machines such as the Lenovo ThinkPad X13s.

The patch has been acked by one of the maintainers who suggested someone else
should send it to you:

	https://lore.kernel.org/lkml/20230602091928.GR449117@google.com/

Please pull.

Johan


The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/linux.git tags/leds-6.4-rc5

for you to fetch changes up to b05d39466ba111fc3775d5d46180b73c34ebe8f7:

  leds: qcom-lpg: Fix PWM period limits (2023-06-03 17:00:28 +0200)

----------------------------------------------------------------
LEDs fixes for 6.4-rc5

Here's a fix for a regression in 6.4-rc1 which broke the backlight on
machines such as the Lenovo ThinkPad X13s.

----------------------------------------------------------------
Bjorn Andersson (1):
      leds: qcom-lpg: Fix PWM period limits

 drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
