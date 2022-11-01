Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B974D614766
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiKAKDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiKAKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:03:47 -0400
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE991CD7;
        Tue,  1 Nov 2022 03:03:39 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 2617140A00; Tue,  1 Nov 2022 09:19:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 2617140A00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1667290743;
        bh=dS+mrSmTjV9cGrEVnP+JzIRf6IDkKLIUSKsJEcVLsk8=;
        h=Date:From:To:Cc:Subject:From;
        b=eBQODKP9/yFlKi7PylTclZjB7HxpewSI+8CUZCVHS26FVov0XtuFRkx4xRBOeUKnc
         kroPtIiMH4iX4XSSMBe2Zx8QGctrzKaapWj2zGPtZS09/HWaT8yp1QcaCMRgpUibN2
         sGLpsP7N/WJAbnfiCFy2jcBHszAta9aw11TkNjDY=
Date:   Tue, 1 Nov 2022 09:19:02 +0100
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        Manank Patel <pmanank200502@gmail.com>
Subject: [GIT PULL REQUEST] watchdog - v6.1 release cycle.
Message-ID: <20221101081902.GA5794@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull following watchdog changes for the v6.1-rc4 release cycle.

This series contains:
* exar_wdt.c fix use after free

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit e25b091bed4946078c0998e4be77bc56824a9adf:

  watchdog: Add tracing events for the most usual watchdog events (2022-10-12 09:47:02 +0200)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.1-rc4

for you to fetch changes up to 82ebbe65d781064cfb0a6a8af221a9cebcaaac9e:

  drivers: watchdog: exar_wdt.c fix use after free (2022-10-19 19:49:47 +0200)

----------------------------------------------------------------
linux-watchdog 6.1-rc4 tag

----------------------------------------------------------------
Jiangshan Yi (1):
      watchdog: sp805_wdt: fix spelling typo in comment

Manank Patel (1):
      drivers: watchdog: exar_wdt.c fix use after free

 drivers/watchdog/exar_wdt.c  | 4 +++-
 drivers/watchdog/sp805_wdt.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)
----------------------------------------------------------------

Kind regards,
Wim.

