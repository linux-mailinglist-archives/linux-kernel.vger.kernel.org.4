Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1CF5F54B6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJEMpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiJEMo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:44:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA87548CBA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 05:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79F2AB81DE8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 12:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8BAC433C1;
        Wed,  5 Oct 2022 12:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664973893;
        bh=WSJFVKlMikDv7xDQlfvsIbggnLJjnOsLioq2/O5IlYQ=;
        h=Date:From:To:Cc:Subject:From;
        b=n3eWhKLFT0DzrtkBiUWLHOL/dP1ECrfKOU7hs0Jr4Zj141S6JmXBA+fVVS2d4LekK
         5U+pzviK3KNCNFI8eD216cH3KOMcSOSS45O4RwOlHphuY+htUafQqt5jiqIEqyutYO
         DPbugohRM+Toxo70rwAXPR1vwLTgE4RwjEXjNPr6igQjJOelCqeF9KgXTS1/RUYTH8
         A8zPKQuZwtAXhELZCCgXVsiEczH/lTvtJnzzNKBB28A14HfQ5CUeeUegIG2wHWemxp
         bWp4nxn4jax2ahNSMUVCDVl4/aAzxdkHIko06zkumsxB6ih+YIZ9TbZhMNiQEQ0Yai
         A4Kk8XjBetwzg==
Date:   Wed, 5 Oct 2022 13:44:48 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Backlight for v6.1
Message-ID: <Yz18QA27+gN0oaM3@google.com>
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

Good afternoon Linus,

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.1

for you to fetch changes up to e7647de058cba3c05b0d4753d84cbc042d02956a:

  video: backlight: mt6370: Add MediaTek MT6370 support (2022-09-08 08:50:57 +0100)

----------------------------------------------------------------
 - New Drivers
   - Add support for MediaTek MT6370 Backlight

----------------------------------------------------------------
ChiYuan Huang (1):
      dt-bindings: backlight: Add MediaTek MT6370 backlight

ChiaEn Wu (1):
      video: backlight: mt6370: Add MediaTek MT6370 support

 .../leds/backlight/mediatek,mt6370-backlight.yaml  | 121 +++++++
 drivers/video/backlight/Kconfig                    |  13 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/mt6370-backlight.c         | 351 +++++++++++++++++++++
 4 files changed, 486 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
 create mode 100644 drivers/video/backlight/mt6370-backlight.c

-- 
Lee Jones [李琼斯]
