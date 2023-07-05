Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05F747AA0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 02:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjGEALF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 20:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEALE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 20:11:04 -0400
Received: from mx-lax3-3.ucr.edu (mx.ucr.edu [169.235.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E71410DA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 17:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688515863; x=1720051863;
  h=mime-version:from:date:message-id:subject:to;
  bh=qJGV4Ihn5aLv2rzCYISjNoN3t4WUUgPb+u7XyG6brjg=;
  b=jr9Xp6MCBvnZBTLdYav3MNQwJu6fKZyWKyyzK8ivCVv8l/anQD2VpHZZ
   ulC0vKTKluhpbo1EkkbOzSNpZB8fg/SDYzX0R8aKUm1NIXBd1Ed3e24z1
   cWMD5Ih6w7BEEWgL2lGveTlRLMKayKuhFaKkN4pIViuwErgOCYyo2Uqdo
   gh8ncpXyoH3HseUEdQmHJ41rsVKxWrZCy5gE9Zf1M9YlO4owwKYUFd6pJ
   V4vXWW5qDJGf9RgPegwnOfvcE0Z5JYN62hB7/HRQOLi/Mvjgw7JduklLp
   FmCzakErnLoZ03+sH6brwOWuKbeOJGTk4oCAjmvFyGymRWGpQdv3xa8hW
   A==;
Received: from mail-wr1-f71.google.com ([209.85.221.71])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2023 17:11:02 -0700
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31437f02985so1649832f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 17:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688515861; x=1691107861;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Cx88c8TooVAgvxbbV7gir3Kl8V3dsEGMmFOU/R0Gkc=;
        b=eqOVJ+ZIOAlOzUY3CyGT14tTXLweY+Fl2hm4x/JqtOQOq58R88a+ORK0eiYgletc2t
         iiw4xghVq4+6/tZGjuCUGm1so6PDuoYsGBVAKNDw3EXuZnHBTSklAJx5ZsJGC4m07/+E
         pfelACY5IEEN71veledD0Z3U17h3Oh6KbgpXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688515861; x=1691107861;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Cx88c8TooVAgvxbbV7gir3Kl8V3dsEGMmFOU/R0Gkc=;
        b=ipld2U0iQzB7b3pqSuZksxV5DDqu1CHaWU1nlouO0U1qAfHIKy2lGhzqDOIcFyivpO
         HdBVk9dR+yPpq5hQ3+5LPIJG1Cq5eaFoO/gcJ1kEWtVb1O2wfbo0/50wo82hBUVCfyTk
         nBedo3vY4LJVQxFNmpyZ9x13LK7w9C9z7trKM6mbv5CbiUzQjAExC4c40Sn4khYUdnyG
         ZcVftVBYGVV5PLTAyCCIzD1t4Wc2OpaQmbTdoZXsfDb307glKtRdzX0lkmLkamVIiF0t
         hC5P7zcUwJBQN6zRmZKNe1abVOYCICAIn2g/IOChHLqxy9q0xR4axvdczeZODaNfTzsv
         nrmw==
X-Gm-Message-State: ABy/qLZPrpeuJVdTVH8PiCUqYN4qJFSO5FnMagkLBcvU9Rh27MAaPPtS
        oBzIKKJ2hHfM85m2S1eWAa1Dcz1+YFX9eYsG19uPzGLyNNZ67exkaEbP7HYXSDx2Y7tjLoEhadp
        oZV9o/IA4CDYop9rcUtbCK0i/90AlyHyKX9lnNDEKGA==
X-Received: by 2002:adf:f504:0:b0:314:f18:bc58 with SMTP id q4-20020adff504000000b003140f18bc58mr13506730wro.58.1688515860985;
        Tue, 04 Jul 2023 17:11:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFqjXkpHddsxxifSXjJ5i+5FdCHTLPsSKeVVQZ6XLfHIVa778JXLVbCsBJ2trBYzxWgtJBg0GkROtqXVmUc5wA=
X-Received: by 2002:adf:f504:0:b0:314:f18:bc58 with SMTP id
 q4-20020adff504000000b003140f18bc58mr13506718wro.58.1688515860688; Tue, 04
 Jul 2023 17:11:00 -0700 (PDT)
MIME-Version: 1.0
From:   Yu Hao <yhao016@ucr.edu>
Date:   Tue, 4 Jul 2023 17:10:48 -0700
Message-ID: <CA+UBctC57Lx=8Eh6P51cVz+cyb02GE_B-dWnYhffWoc-nm7v6Q@mail.gmail.com>
Subject: [PATCH] ethernet: e1000e: Fix possible uninit bug
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable phy_data should be initialized in function e1e_rphy.
However, there is not return value check, which means there is a
possible uninit read later for the variable.

Signed-off-by: Yu Hao <yhao016@ucr.edu>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
b/drivers/net/ethernet/intel/e1000e/netdev.c
index 771a3c909c45..455af5e55cc6 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6910,8 +6910,11 @@ static int __e1000_resume(struct pci_dev *pdev)
    /* report the system wakeup cause from S3/S4 */
    if (adapter->flags2 & FLAG2_HAS_PHY_WAKEUP) {
        u16 phy_data;
+       s32 ret_val;

-       e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
+       ret_val = e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
+       if (ret_val)
+           return ret_val;
        if (phy_data) {
            e_info("PHY Wakeup cause - %s\n",
                   phy_data & E1000_WUS_EX ? "Unicast Packet" :
-- 
2.34.1
