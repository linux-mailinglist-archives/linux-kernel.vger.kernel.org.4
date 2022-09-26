Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A2E5EA9F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiIZPNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiIZPMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:12:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5414674DEC;
        Mon, 26 Sep 2022 06:53:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7472560DD7;
        Mon, 26 Sep 2022 13:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B751AC433D6;
        Mon, 26 Sep 2022 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664200384;
        bh=G2mFLM1SSBAD6TZuV4aMLZzwYiNdepsid1TuuiSrE0A=;
        h=From:To:Cc:Subject:Date:From;
        b=nDyHInp2m/7CLFgFdOA2GAzHsc4525Z62dnhSre8c84SN8Ha+T3fDOHfGG2Dz0qho
         MRO1N0mOTVKcfDF4mUwXYV67LxRqtLXX9B3d6gmLEstgFc5X+HFpXtlSiefAkPTGtx
         5UvVKFsHUs0tyXItrWsoABBORXjTkD85++vXzBmhGHeHBrdQGjlbk/c4poEUzp99EO
         6FupLqYpG4VirB14P2up0619ixxDeSB4o4QgRx9TkSU/0PvA1UdeKZl9PeuU/0SvyG
         SC3MO/+yLuV3wMSFJxiGX00CZ+PDMvzVQGl/BG/GmkBsCdaACubFl/Q4+JKiwwcgE3
         4v/2Bvkqehd7Q==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.1
Date:   Mon, 26 Sep 2022 16:53:01 +0300
Message-Id: <20220926135301.28372-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request with interconnect changes for the 6.1-rc1 merge
window. It contains some tiny updates. The details are in the signed tag.

All patches have been in linux-next. Please pull into char-misc-next when
possible.

Thanks,
Georgi

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.1-rc1

for you to fetch changes up to 7360d55ba1993cb59267507d04b7e62c40bad424:

  Merge branch 'icc-ignore-return-val' into icc-next (2022-09-20 15:57:00 +0300)

----------------------------------------------------------------
interconnect changes for 6.1

These are the interconnect changes for the 6.1-rc1 merge window, which
this time are tiny. One is a series to convert the remove() callback of
platform devices to return void instead of int. The other change is
enabling modular support for a driver.

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Georgi Djakov (1):
      Merge branch 'icc-ignore-return-val' into icc-next

Huang Yiwei (1):
      interconnect: qcom: Kconfig: Make INTERCONNECT_QCOM tristate

Uwe Kleine-König (8):
      interconnect: imx: Ignore return value of icc_provider_del() in .remove()
      interconnect: icc-rpm: Ignore return value of icc_provider_del() in .remove()
      interconnect: icc-rpmh: Ignore return value of icc_provider_del() in .remove()
      interconnect: msm8974: Ignore return value of icc_provider_del() in .remove()
      interconnect: osm-l3: Ignore return value of icc_provider_del() in .remove()
      interconnect: sm8450: Ignore return value of icc_provider_del() in .remove()
      interconnect: Make icc_provider_del() return void
      interconnect: imx: Make imx_icc_unregister() return void

 drivers/interconnect/core.c            | 10 +++-----
 drivers/interconnect/imx/imx.c         |  4 +--
 drivers/interconnect/imx/imx.h         |  2 +-
 drivers/interconnect/imx/imx8mm.c      |  4 ++-
 drivers/interconnect/imx/imx8mn.c      |  4 ++-
 drivers/interconnect/imx/imx8mp.c      |  4 ++-
 drivers/interconnect/imx/imx8mq.c      |  4 ++-
 drivers/interconnect/qcom/Kconfig      |  2 +-
 drivers/interconnect/qcom/icc-common.c |  3 +++
 drivers/interconnect/qcom/icc-rpm.c    |  4 ++-
 drivers/interconnect/qcom/icc-rpmh.c   |  4 ++-
 drivers/interconnect/qcom/msm8974.c    |  4 ++-
 drivers/interconnect/qcom/osm-l3.c     |  4 ++-
 drivers/interconnect/qcom/sm8450.c     |  4 ++-
 include/linux/interconnect-provider.h  |  5 ++--
 15 files changed, 39 insertions(+), 23 deletions(-)
