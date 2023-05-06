Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DD86F8D24
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjEFAZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEFAZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:25:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D094B5FF2
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 17:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6197A63C2E
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C47FC433EF;
        Sat,  6 May 2023 00:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683332754;
        bh=G5t594neWHHexTQ+yG9E+ECImPUCCHLxErr+Uym6JnE=;
        h=From:To:Cc:Subject:Date:From;
        b=qcT8JHn4iVLLH2aNPDwmHpGKMZ5KiU95/pUToiez2bMcM4TJYY73GX4ITa9mVnh41
         58N3hM/QJ27wDBUpbbxMnaqJbdlrPa34n5NxfbN5WsIK3r+3Q0rCgvt2zZUwqabOiJ
         WHaXQOo/qGoBqNN7fYGN0Y1qPwd8mU4OQXJKeLK1HELaLTnbq3uap3jjRuw83zA573
         4zKGwmKHrN/PihrCkmg/kK60lSmqp2VabtJA3oNyeG+zcRwLA+HAJIaV0lyVpu1gTt
         Lm3OmzAf1S2ZlNPvnT7pcf4fVpCO/0b67ApKKQ6or37fJu5zS65zDIR0VgCX8pFHXd
         +AZt411AUN/Xw==
Message-ID: <7c6f8881772b1689ba8bc0f9e28ff319.broonie@kernel.org>
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.4
Date:   Sat, 06 May 2023 09:25:38 +0900
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ed479907ff79007548c3bd1aed387f8cf0a62065:

  regulator: dt-bindings: qcom,rpmh: Combine PM6150L and PM8150L if-then (2023-04-18 14:02:31 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.4

for you to fetch changes up to 3302212f0384ab286b65683bc340f3953f88f70a:

  regulator: consumer.rst: fix 'regulator_enable' typo. (2023-04-27 21:55:38 +0100)

----------------------------------------------------------------
regulator: Fix for v6.4

A trivial typo fix that came in during the merge window.

----------------------------------------------------------------
Philippe De Muyter (1):
      regulator: consumer.rst: fix 'regulator_enable' typo.

 Documentation/power/regulator/consumer.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
