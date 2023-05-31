Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F87E7186FC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjEaQGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEaQGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1114F8E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 982B6632C0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F11C4339C;
        Wed, 31 May 2023 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685549188;
        bh=eb1YgxE/egV3/lApa/O/ClXsJ4sYaJmKrT1Nk9Vg4Nw=;
        h=From:To:Cc:Subject:Date:From;
        b=PyJHlB3aCIq7ly7Lho3EPUlAN8PVoxeh0Mi4LGlkq4PoRQ+6ztgaNK9B/Gy15NhCN
         O9onmMPBuRbJhUovLf2/OoZ/4s1CF7lTZNrYMUS+FyoMlPR1fAyVY3u7HcVttuBqD0
         HcG+a869Q0tn58dA10GYChveS/Nhs1gujCoO2Najdf1dC0Zw2DHaWqhJ46JfDXdvlX
         M670wZ+7RpiIych7D+6bPukA+ilVgQnlCMUeaOrqlLs4e/ZvqFb/6nmKxhupYC+5sF
         VoxgWfO29bPJNvR3yr69CFpK3Xn0bCxuRKOm9MN+q+blPGvDoJc4/EidyiXVY2gSgs
         zVuUPpUwQPjog==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1q4OLB-001fUj-Pb;
        Wed, 31 May 2023 17:06:25 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 6.4, take #2
Date:   Wed, 31 May 2023 17:05:49 +0100
Message-Id: <20230531160549.433528-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, dianders@chromium.org, geert+renesas@glider.be, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

I'm about to disappear for a few days, so here's the only urgent fix I
have pending, fixing a regression introduced in the previous set of
fixes. Oh well.

Please pull,

	M.


The following changes since commit cddb536a73ef2c82ce04059dc61c65e85a355561:

  irqchip/mbigen: Unify the error handling in mbigen_of_create_domain() (2023-05-16 11:19:29 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-6.4-2

for you to fetch changes up to 91539341a3b6e9c868024a4292455dae36e6f58c:

  irqchip/gic: Correctly validate OF quirk descriptors (2023-05-30 11:01:22 +0100)

----------------------------------------------------------------
irqchip fixes for 6.4, take #2

- Fix regression introduced by the Mediatek workaround.

----------------------------------------------------------------
Marc Zyngier (1):
      irqchip/gic: Correctly validate OF quirk descriptors

 drivers/irqchip/irq-gic-common.c | 2 ++
 1 file changed, 2 insertions(+)
