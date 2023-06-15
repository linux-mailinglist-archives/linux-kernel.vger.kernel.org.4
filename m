Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411A2731651
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245654AbjFOLRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343819AbjFOLRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:17:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CAC2D5D;
        Thu, 15 Jun 2023 04:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF1E461D95;
        Thu, 15 Jun 2023 11:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8639C433C0;
        Thu, 15 Jun 2023 11:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686827847;
        bh=CAgZWGdb4N/GyJhEqPk/hvnqWKy+2W5s0qZ497CORwU=;
        h=Date:From:To:Cc:Subject:From;
        b=f5SaHHWj2cnBTSuGltkgWHTirhBD1KHQFixBQMM/1/BUl4YWPsR1AuhFN41CadrOj
         40vh3b3x7fO9ajpnhm102j4xWVTlHOdBFtwzpw+Yq1Ecbf0ZUFLa883SJYyhgoRbyx
         WrJiRmVTES3nfkh425IBmVaVSsy5MCfyqg2Pn3lnoXTnIqTP90MTMn2cg6ZcL6daCd
         RNPAhqEl9qX4B2ayjutvu3Kpjcxcx+zKy7yx4lEgoCOXbESZyIifCUJvr6Wiz7Y1NT
         2fCRgl5FPkBVmy1mpSdYG6kVvraijjsUSFoPArA+v+0MeG1Ttr+M/n+1jvNwIbHGqA
         pnD3N78nn/x0Q==
Date:   Thu, 15 Jun 2023 12:17:21 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.4-rc7] media fixes
Message-ID: <20230615121721.1f901ebb@sal.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.4-6

For a fix at dvb-core to avoid a race condition during DVB board register
time.

Regards,
Mauro


The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.4-6

for you to fetch changes up to ec21a38df77a5aefbd2f70c48127003b6f259cf3:

  Revert "media: dvb-core: Fix use-after-free on race condition at dvb_frontend" (2023-06-14 23:16:29 +0100)

----------------------------------------------------------------
media fixes for v6.4-rc7

----------------------------------------------------------------
Mauro Carvalho Chehab (3):
      Merge tag 'v6.4-rc4' into v4l_for_linus
      Merge tag 'v6.4-rc5' into v4l_for_linus
      Revert "media: dvb-core: Fix use-after-free on race condition at dvb_frontend"

 drivers/media/dvb-core/dvb_frontend.c | 53 ++++++-----------------------------
 include/media/dvb_frontend.h          |  6 +---
 2 files changed, 10 insertions(+), 49 deletions(-)

