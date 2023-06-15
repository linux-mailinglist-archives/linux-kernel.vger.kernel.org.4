Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F94D7317D8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343974AbjFOLtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344497AbjFOLsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:48:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80CF618D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:44:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C36363B95
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A41EC433C8;
        Thu, 15 Jun 2023 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829410;
        bh=joSpN9GN18PedDJ2tBBgHGj8y04ZII6qALXuCKEOKPI=;
        h=From:To:Cc:Subject:Date:From;
        b=IxOh9ffkgkPKoxngK5hJ9R8+JGqdb/shFkg8wXOnbv+yoiKzV2mdj82Dj7HjX7vMK
         e4WMeWHwK0qQP8hlvvbPrxxU6Jo8ifPqh58IRcCwmAOsaK+UEYhmNCYYaw+ukgrRMH
         T5+s/eieWdRCGUk7cByiO6YkCpswNHEfHVUg1UkT1SOIQr4EQ8NZlg6es4tEBCllj6
         frAq7TL2BDKFjf/VkcHy9YonmT/QGHAGMf0ZqKWyEqpy5+EQbY/aZnFCLY4XIvbAH9
         7g7Ep0xlJJDkeIxUAum2KE0WXbTsb1mLRssRZf8vN2+4aDsKA53v69J8HuJhD6ZZyM
         HAZvuee3uaKGg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.4-rc6
Date:   Thu, 15 Jun 2023 12:43:23 +0100
Message-Id: <20230615114330.8A41EC433C8@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.4-rc6

for you to fetch changes up to b00de0000a69579f4d730077fe3ea8ca31404255:

  regulator: qcom-rpmh: Fix regulators for PM8550 (2023-06-07 14:20:04 +0100)

----------------------------------------------------------------
regulator: Fix for v6.4

One fix for v6.4, the set of regulators described for the Qualcomm
PM8550 just seems to have been completely wrong and would likely not
have worked at all if anything tried to actually configure anything
except for enabling and disabling at runtime.

----------------------------------------------------------------
Abel Vesa (1):
      regulator: qcom-rpmh: Fix regulators for PM8550

 drivers/regulator/qcom-rpmh-regulator.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)
