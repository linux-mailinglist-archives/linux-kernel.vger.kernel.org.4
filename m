Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A9A6FC36B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjEIKE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjEIKEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:04:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEAFDD8E;
        Tue,  9 May 2023 03:04:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32BEA62808;
        Tue,  9 May 2023 10:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102B2C433D2;
        Tue,  9 May 2023 10:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683626670;
        bh=478tQNtd0bYwq0TBSEOC3ofnei1ThTQcsDZ0NkuIvwQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ZcRsqRbmqX45semrAv+8Zi+zdyK/evTHP7peNB9Msqpi75O/PUuhuzK66l7RO8yKI
         HBrF0jkIbrr+GwU+KV/YBHRI5dT1qVnu5Vx0LW4I/tzqr19X6tUqT4c7t/1JuHnXAe
         yKd3iEs0M3UeI8RTdEJFf1es8wGwGYjC6SrfHv2DfyuipqiX/mcRfV3o1TDC61g8/H
         frMRq/t+wLhoaA0fGERSRkOteC7OhaGdMiZ/kvYGr5k0P5EGoXgAnyElXkPMhS//Go
         K8KCN+WoyDxnbrNTItKp/ytL9HFdeZs+Hzmxb+T8R2TRNL30pSocfZGQklZ8BfOGTu
         fKpzzZvvvy3Ug==
From:   matthias.bgg@kernel.org
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc:     brcm80211-dev-list.pdl@broadcom.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        SHA-cyfmac-dev-list@infineon.com,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Matthias Brugger <mbrugger@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] wifi: brcmfmac: wcc: Add debug messages
Date:   Tue,  9 May 2023 12:04:20 +0200
Message-Id: <20230509100420.26094-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.40.1
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

From: Matthias Brugger <mbrugger@suse.com>

The message is attach and detach function are merly for debugging,
change them from pr_err to pr_debug.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
index 02de99818efa..5573a47766ad 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
@@ -12,13 +12,13 @@
 
 static int brcmf_wcc_attach(struct brcmf_pub *drvr)
 {
-	pr_err("%s: executing\n", __func__);
+	pr_debug("%s: executing\n", __func__);
 	return 0;
 }
 
 static void brcmf_wcc_detach(struct brcmf_pub *drvr)
 {
-	pr_err("%s: executing\n", __func__);
+	pr_debug("%s: executing\n", __func__);
 }
 
 const struct brcmf_fwvid_ops brcmf_wcc_ops = {
-- 
2.40.1

