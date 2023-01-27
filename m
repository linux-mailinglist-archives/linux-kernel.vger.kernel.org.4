Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9290167ECA9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbjA0Rk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjA0Rkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:40:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C3BC65E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:40:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13411B82190
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7406C433D2;
        Fri, 27 Jan 2023 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674841249;
        bh=5BK2hfTkggyWWnwdeBBxeWDAs8DNHOUUJUDA/+QDTrY=;
        h=Date:From:To:Cc:Subject:From;
        b=sEhzqNnsZ/bFIw6f6sFtt5OJs6/XeXs5jjcyjjZ6h5zINy1qhTUlK/8aBRQAh3L0D
         Nbtkte/zZVaXDimcy9R1Jx/HAf9TkYyD/Mokd7kNxbExU5f4qv0xMTb1ijJTuibMST
         6Qzsch2b+r64NaT320EXnV2v9129ndQ6MMF2bPoIL+E/kyPkQ76JTKWzmd2Xw4lvv3
         OvBZBJlT6FGAhiwY5TKpiBmkq7VjgL217EoGGj6vIYs0+uUSX+kY2KjKF+EvY+EoP4
         EOcIdEZ+B7eYvf8UVTHdOtTC4y892gDcHGkFppOimjPZghvpA3s/hST8XYx1Qv+axB
         PC7ZhkdtfnTiw==
Date:   Fri, 27 Jan 2023 17:40:45 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fix for -rc6
Message-ID: <20230127174044.GA31044@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this CMN PMU driver fix for -rc6, which fixes a regression
in the event counting caused by a broken optimisation. Summary in the
tag.

Cheers,

Will

--->8

The following changes since commit 68a63a412d18bd2e2577c8928139f92541afa7a6:

  arm64: Fix build with CC=clang, CONFIG_FTRACE=y and CONFIG_STACK_TRACER=y (2023-01-09 15:59:42 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to a428eb4b99ab80454f06ad256b25e930fe8a4954:

  Partially revert "perf/arm-cmn: Optimise DTC counter accesses" (2023-01-26 13:55:38 +0000)

----------------------------------------------------------------
arm64 fix for -rc6

- Fix event counting regression in Arm CMN PMU driver due to broken optimisation

----------------------------------------------------------------
Robin Murphy (1):
      Partially revert "perf/arm-cmn: Optimise DTC counter accesses"

 drivers/perf/arm-cmn.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
