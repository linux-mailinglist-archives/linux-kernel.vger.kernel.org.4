Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AFE6A3318
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBZRLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjBZRLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:11:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6101210247;
        Sun, 26 Feb 2023 09:11:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 992AFCE0E27;
        Sun, 26 Feb 2023 17:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45092C433EF;
        Sun, 26 Feb 2023 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677431489;
        bh=UpDzg7KBodEaf7bO/mNQqYMfCxtKnD2JgwuVTYR8fY8=;
        h=From:To:Cc:Subject:Date:From;
        b=G/lAbOnZICxIR8Z+ofJzce7GDWT9qeJoNXY1AW9t/Nn9cwk6uk+evNEgTA1pYpuES
         GYDE5J5Mis0vInSIun7r1AzBmMh96quwifv5pKC4dMNcb7hSXbqwj0KzDXZp70aAuo
         VWTYQ6NkQki82qUrLUpI5fXb4Cm3dwidseDxDvrf8cld24DK505yipZt6yh/N6gSmc
         Gwe6G89d3fMH8opXOUqfbDyho2K1I4DlSqoUhu8n5rkiD3LIw5TArm3BQHrzxh02+5
         6zlzpqtd4HPHUkXcpntxFfsYw200cMO16tEv+XwxK5G+Y0kEnGSa95jwkyLn9oiCm+
         w5hw5pP7Wf+Vw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bastian Germann <bage@debian.org>,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: [GIT PULL] hwspinlock changes for v6.3
Date:   Sun, 26 Feb 2023 09:14:52 -0800
Message-Id: <20230226171452.298931-1-andersson@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.3

for you to fetch changes up to 95e158ec843666d76c09900507db08b76d77ce3e:

  dt-bindings: hwlock: sun6i: Add #hwlock-cells to example (2023-02-20 18:02:01 -0800)

----------------------------------------------------------------
hwspinlock changes for v6.3

This updates the sun6i DT binding, to allow (and require) #hwlock-cells,
and it makes use of device_match_of_node() to slightly clean up the
condition in of_hwspin_lock_get_id().

----------------------------------------------------------------
Bastian Germann (2):
      dt-bindings: hwlock: sun6i: Add missing #hwlock-cells
      dt-bindings: hwlock: sun6i: Add #hwlock-cells to example

ye xingchen (1):
      hwspinlock: Use device_match_of_node()

 .../devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml   | 5 +++++
 drivers/hwspinlock/hwspinlock_core.c                                 | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)
