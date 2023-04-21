Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0446EAA62
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjDUMab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDUMa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:30:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E48A5E4;
        Fri, 21 Apr 2023 05:30:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0135561284;
        Fri, 21 Apr 2023 12:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF286C433EF;
        Fri, 21 Apr 2023 12:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682080226;
        bh=qurM6pSWM3IbAE+idFHL8b8eovX/lSH8OmOwkRoNcQU=;
        h=From:To:Cc:Subject:Date:From;
        b=dkojo8e4E9lctsqc1uQxZF4+U9G3ahKKcxNKmT09NBEk458trFj5orQAej4jkMPQK
         IoobBKYALuG3MCUEkAQcuPl5F9WS0IJFfNQqH05HbfTZGKQJwmp/NXSuOtrLDYeuB8
         /3AImFxmOTBH/cAVJJyxW/8/45w5BGbk5yp+Z4t+PxXdoKaCcrgXRtyPOr9xYomQsL
         L9cXwH1DTiz9BvBrdKg0r5QG1cGR1W1bLe3ZOuddAbMOtTkBf+/KjahIBcazY6tEkQ
         u1jdWZXYzyfZ4vNgfybwZ8kzYwrC2Qzvl9XWbN2k+CVfGuGDV26MFy/H2nWVZZeguc
         7QBuFjifVSZeg==
From:   broonie@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: linux-next: manual merge of the nfsd tree with the powerpc tree
Date:   Fri, 21 Apr 2023 13:30:18 +0100
Message-Id: <20230421123018.78201-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the nfsd tree got conflicts in:

  arch/powerpc/configs/powernv_defconfig
  arch/powerpc/configs/pseries_defconfig

between commit:

  9ecda934f43b1 ("powerpc/configs: Make pseries_defconfig an alias for ppc64le_guest")

from the powerpc tree and commit:

  e485f3a6eae08 ("ixgb: Remove ixgb driver")

from the nfsd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 92e3a8fea04a5..f2a9be02a8d27 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -170,8 +170,6 @@ CONFIG_S2IO=m
 CONFIG_E100=y
 CONFIG_E1000=y
 CONFIG_E1000E=y
-CONFIG_IGB=y
-CONFIG_IXGB=m
 CONFIG_IXGBE=m
 CONFIG_I40E=m
 CONFIG_MLX4_EN=m
