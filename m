Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164F1749F35
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjGFOlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjGFOlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:41:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7211BD4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF53B61997
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 14:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31A6C433C8;
        Thu,  6 Jul 2023 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688654469;
        bh=h2tlXGTgQ7sZFubegxdE4+0aXvrEsMeDOmxGv9uIROg=;
        h=From:To:Cc:Subject:Date:From;
        b=AOL602bITvIEdju4AIm6A8XxFHdn2JALflg3wBA5WJq9ceh6Mgizq9w3Qvn+tvN99
         wC1RJf/ZQQYtJ4SrE8rP+vaMiUvRpcG78oqzALxjZ2h3jND59tIgxWhZzKnJttmVmp
         4TBahyB+/SUlkC/9cZ8S5o38yjth/or76t00YfBL6Jg4qz7cmKi4+QF/1Cw8i29qDa
         kw7DJkHjENMhiINRqN3fUJhaB2U+R3Za6KkuGQNbZ22FxeHK70X0fRLeAKbVj9vkh6
         TajaWTmt1HasanOOn3yxpC3Mza9Qi5wVIKE/ZMVOMPsE/NnTUWp4atjvMpIMHk+DQ+
         dSkGBuXejUaNg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.5-merge-window
Date:   Thu, 06 Jul 2023 15:40:57 +0100
Message-Id: <20230706144108.B31A6C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 54e47eade73046e860634736d2651ddc118ca694:

  Add Renesas PMIC RAA215300 and built-in RTC (2023-06-24 01:57:59 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.5-merge-window

for you to fetch changes up to e9bd04e52d649c3cfd713b594c5db35cab03c42b:

  regulator: raa215300: Add build dependency with COMMON_CLK (2023-06-28 21:31:59 +0100)

----------------------------------------------------------------
regulator: Fix for v6.5

A simple dependency fix for a newly added driver.

----------------------------------------------------------------
Biju Das (1):
      regulator: raa215300: Add build dependency with COMMON_CLK

 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)
