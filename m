Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB8372EF82
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjFMWf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241427AbjFMWfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:35:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC95912E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:35:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A37B63B14
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBB4C433C8;
        Tue, 13 Jun 2023 22:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695712;
        bh=iZ71ssEgbD/NlXvURP4DffMjG2Q9r1aY4As/hnirvXg=;
        h=From:To:Cc:Subject:Date:From;
        b=acudzA5UNEhJqLdDWRITLC/g5liIqEkWJIdYitNOGv7F64LQfKK7JHjzWfnj2AIzC
         +p6cDtJB32lBWKhiAT6yLStJLQxXi7cOIVlqJR2Htr9AEzowrA8tjBo/dDzKV22t+I
         WrrALQfhvzlZ4J7g9tJ3lJN+VqiR8++LXFqrZX/8PK9jF5+ibigVTLb24VUSEvc7NF
         I2FYSQDMWHUU0/vaPymi6vO1C6da+14MhnPtrrwDMkXvdywRMqSwoOCU91rqXZCHkr
         Cfdmv7d6gqeR3QvpOjOjRODfdIllxz7CkB6DCR3hYiLhQxNUGk0cPSZSiVDQ89UEj4
         69DXteOYNbTXA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] nios2: fix for v6.4
Date:   Tue, 13 Jun 2023 17:35:09 -0500
Message-Id: <20230613223510.20803-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fix_v6.4

for you to fetch changes up to 85041e12418fd0c08ff972b7729f7971afb361f8:

  nios2: dts: Fix tse_mac "max-frame-size" property (2023-06-13 16:59:46 -0500)

----------------------------------------------------------------
NIOS2 dts fix for v6.4
- Fix tse_mac "max-frame-size" property

----------------------------------------------------------------
Janne Grunau (1):
      nios2: dts: Fix tse_mac "max-frame-size" property

 arch/nios2/boot/dts/10m50_devboard.dts | 2 +-
 arch/nios2/boot/dts/3c120_devboard.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
