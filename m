Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBF95EAA2A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiIZPTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiIZPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:18:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31417285C;
        Mon, 26 Sep 2022 07:05:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FB5860DD7;
        Mon, 26 Sep 2022 14:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A6CC433D6;
        Mon, 26 Sep 2022 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201126;
        bh=PthIOKqjN3mlliP1rI72KfnGTjV0zECJS+IIHp5GcEo=;
        h=From:To:Cc:Subject:Date:From;
        b=WpNe7FWcQrju4iGTD2gG3vL+ziRoa6k0+rCVsen9lYKLfGYbBTKN5qNm8wAaSN8wu
         32ozia/8t95DSTyeItIlnrXZJia5vbgt6/tGtrpiL/ehDd9zI2b5hty0FcFGAp1ubv
         PaslDZzwS5j2OG+MD1n242QTWAS3OrqWtxG4Fg1yhRC/IADPZm6uKng/DXYQ6USgzJ
         Xwm+tVHfFRtc3PhvkhdBJwGxt/hUnGCZOPDPumUP2d1ExnxdkCu/Y+yWfCYjtddBJU
         dfb9/wwdQz9DGRFD0AlBSPbrt5l8KX0aYUpRmDpRE1nR1EQ9eGpZ8p2oTZl2b/drwT
         MGPWlQNnA95bw==
From:   broonie@kernel.org
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: linux-next: manual merge of the bluetooth tree with the net tree
Date:   Mon, 26 Sep 2022 15:05:22 +0100
Message-Id: <20220926140522.109472-1-broonie@kernel.org>
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

Today's linux-next merge of the bluetooth tree got a conflict in:

  net/bluetooth/mgmt.c

between commit:

  23b72814da1a0 ("Bluetooth: MGMT: Fix Get Device Flags")

from the net tree and commit:

  529d4492aed7c ("Bluetooth: MGMT: Fix Get Device Flags")

from the bluetooth tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc net/bluetooth/mgmt.c
index 72e6595a71cc0,a92e7e485feba..0000000000000
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
