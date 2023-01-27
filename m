Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9635A67EDEF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbjA0TA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjA0TA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:00:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C633440
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:00:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D0F3B82163
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 19:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4066EC433D2;
        Fri, 27 Jan 2023 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674846024;
        bh=8oq/AoS5S6sN5TnP7YMOGLRY1G1ZGeVnCPorJ3SUuL4=;
        h=From:To:Cc:Subject:Date:From;
        b=fjSEzdMyUiNXQRoO/WBzEwRe/4GOo/0N2LwvkQt8jMa7CXDv/dx2POPrDIrLGzWP3
         1KQlKmIEHtJ9GpHbiD8gm//fUkmpfuIvLZq3Wo7xZNH9I/1RuXNtB7gWWYxf0WLTle
         nmQYGFsXVeUbKGiwumIqWWIacw35pdihPI7eqsLWRghROAmY/jrhOSIb8aeyyLEGfJ
         JY4yn8nD5/GMjPHApmPnw6flmUQY18OPrUSI1rTpzwjC1x6sWFjKuq9R8zf3FLFNXQ
         7y5JrI5uRISL/z3Kwe0pjRBLKn5XSXL3/j1sDjliAS/hpqAN+epRv/Gbxf1BJFWvpN
         zfw11qDOYWExg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.2-rc5
Date:   Fri, 27 Jan 2023 19:00:11 +0000
Message-Id: <20230127190024.4066EC433D2@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f528fe213a6ad21a6e8644dbd5de10dc264a89fd:

  regulator: qcom-rpmh: PM8550 ldo11 regulator is an nldo (2023-01-03 15:54:38 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.2-rc5

for you to fetch changes up to 4bb3d82a1820c1b609ede8eb2332f3cb038c5840:

  regulator: dt-bindings: samsung,s2mps14: add lost samsung,ext-control-gpios (2023-01-20 14:09:57 +0000)

----------------------------------------------------------------
regulator: Fix for v6.2

A fix for the DT binding documentation which dropped a property
when being converted to YAML format causing spurious errors
validating device trees for platforms using the device.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      regulator: dt-bindings: samsung,s2mps14: add lost samsung,ext-control-gpios

 .../bindings/regulator/samsung,s2mps14.yaml         | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)
