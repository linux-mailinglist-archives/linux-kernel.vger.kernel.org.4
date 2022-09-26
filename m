Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F015EAF25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiIZSGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiIZSF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:05:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C5D754B0;
        Mon, 26 Sep 2022 10:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2EEFB80B9F;
        Mon, 26 Sep 2022 17:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D45C433D6;
        Mon, 26 Sep 2022 17:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664214601;
        bh=dfRtJrOyfuNQSb5O1EcqfWI5vVuj+fieEC5eUAhWmc8=;
        h=From:To:Cc:Subject:Date:From;
        b=bkPQBDeTCsHdEajVYrLXBe77kld1oJRz2kSXY3Q2mLgbZT8WphZhiuMVAskm+TQRh
         FJfgFYkPaQ9jZkjBVWbK2MOWWU5wKpjePreXNnu/vMa9xN52QnX2pP7fuMbB5S6FB9
         Frus2BsngarZ1Pm1nZ750LE2W6P2+UexwFzS7FMTxQGha0BFbb1saSN2Y2iLOgSX4W
         koWpNkVglVKiUpWqiQch/yw+FTt59djgSqmHt+c2nA2MiIDpe0T0apXWwY8cdtYY9O
         8IzdtOjlCR8dqcXjR3kElVzmyouasovHluzPjtyIowLMSAVIcwrTuSefB5mLydhRUI
         G1lNKNkq0Vpuw==
From:   broonie@kernel.org
To:     Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>, Lee@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Date:   Mon, 26 Sep 2022 18:49:50 +0100
Message-Id: <20220926174950.231288-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c

between commit:

  58d97c99c99f4 ("drm/amd/display: Update MBLK calculation for SubVP")

from the drm-fixes tree and commits:

  41c81dcf59991 ("drm/amd/display: Update MBLK calculation for SubVP")
  5c1a431aaf52b ("drm/amd/display: Added debug option for forcing subvp num ways")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 1f195c5b3377d,417dfdcf95962..0000000000000
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c


