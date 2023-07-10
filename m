Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5134474D4D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGJL5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGJL5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:57:10 -0400
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF86AE2;
        Mon, 10 Jul 2023 04:57:08 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id B43BF409CD; Mon, 10 Jul 2023 13:56:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org B43BF409CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1688990213;
        bh=LTL/NrSpFN7MDJhqtM5W5ZXMFtcsC+VlRpzl/LC6p74=;
        h=Date:From:To:Cc:Subject:From;
        b=Zy+6RLn81QyqdmE3py3uIt1fJWzGfintpuZp37a2aU53fX7vYnJ2+/+z9BpPxCohg
         hML9kMaa2+0olGUX2h/G8rGwtb2KC/UGLhRb/38gQ8WMhEdReh+T5KqVDjljWhWmF5
         NQCkN1HRb3r4nre195xEuqyHvfq+/m7qTc+azKsc=
Date:   Mon, 10 Jul 2023 13:56:53 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [GIT PULL REQUEST] watchdog - v6.5 release cycle (v6.5-rc2).
Message-ID: <20230710115653.GA23810@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull following watchdog changes for the v6.5 release cycle (v6.5-rc2).

This series contains:
* Add Loongson-1 watchdog dt-bindings

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit 009637de1f65cff452ad49554d1e8ef9fda99e43:

  watchdog: sp5100_tco: support Hygon FCH/SCH (Server Controller Hub) (2023-06-26 14:30:07 +0200)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.5-rc2

for you to fetch changes up to 2500df55a615f2f177bacf1a261f927790a137db:

  dt-bindings: watchdog: Add Loongson-1 watchdog (2023-07-06 11:49:53 +0200)

----------------------------------------------------------------
linux-watchdog 6.5-rc2 tag

----------------------------------------------------------------
Keguang Zhang (1):
      dt-bindings: watchdog: Add Loongson-1 watchdog

 .../bindings/watchdog/loongson,ls1x-wdt.yaml       | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
----------------------------------------------------------------

Kind regards,
Wim.

