Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A66D6AF5DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjCGTiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjCGThj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:37:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3989E309
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:25:00 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C9831EC069A;
        Tue,  7 Mar 2023 20:24:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678217099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SOdasNpIVZBeTMQZbt7smR8ArnRs5idhx2L3K5sBUU=;
        b=JL1IOWo6bD1CXtSfHs86ZooGZBuL5z8YArxAaLYdFTF24OMBQNmbUH6cbj7L00ml+XvVOB
        M4dwe+mGY0EMhBDUDRpx/jeV4VtUynMLwp4xgbAFtXGkXO77fXYUxXkO88bl7434j3MZm4
        8yqPghVvPF9/PCoW5UKutIoPqnXkiMs=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        linux-coco@lists.linux.dev, x86@kernel.org
Subject: [PATCH -v3 06/11] virt/coco/sev-guest: Do some code style cleanups
Date:   Tue,  7 Mar 2023 20:24:44 +0100
Message-Id: <20230307192449.24732-7-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307192449.24732-1-bp@alien8.de>
References: <20230307192449.24732-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Remove unnecessary linebreaks, make the code more compact.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 07dafe22b27a..81a53c31ff46 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -412,18 +412,14 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		if (rc == -EIO && *fw_err == SNP_GUEST_REQ_INVALID_LEN)
 			return rc;
 
-		dev_alert(snp_dev->dev,
-			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
-			  rc, *fw_err);
+		dev_alert(snp_dev->dev, "Detected error from ASP request. rc: %d, fw_err: %llu\n", rc, *fw_err);
 		snp_disable_vmpck(snp_dev);
 		return rc;
 	}
 
 	rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
 	if (rc) {
-		dev_alert(snp_dev->dev,
-			  "Detected unexpected decode failure from ASP. rc: %d\n",
-			  rc);
+		dev_alert(snp_dev->dev, "Detected unexpected decode failure from ASP. rc: %d\n", rc);
 		snp_disable_vmpck(snp_dev);
 		return rc;
 	}
-- 
2.35.1

