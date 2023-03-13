Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69C66B7831
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjCMM6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCMM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:58:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE071116D;
        Mon, 13 Mar 2023 05:58:12 -0700 (PDT)
Date:   Mon, 13 Mar 2023 12:58:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678712290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RwaUg6myi9ABQdqJVGJv37nQDlbAAjsh5eWKeZHxlsg=;
        b=iEwGaDNNr7y6Ql9Djt9w/wsyVB6fpZ6OkY83kAW93Ab+gJF9NirqFG/t9kWjMX5Ywi47nf
        7Do+2s0WlnAPD35kfGhwhXn02R4FrCfyEOhGysJ9TeuINI5Ec0Ts7nqaxhxKHsQqK3bjbn
        bJYf3AZoZqp28K4flL6IXv/yY6UneucLuI14hAkiycBvY5daFJ0NRiT6yHWS50fnHce5Dh
        cqEVN3EnGcpHyms3oc54ZNM4JKfYWnOmutH5eEdotpINx7o52wWa56ERYn+eLpqfqgYWWm
        n3TtXkL7+0F/XSBTPRHDIqwx9DrmVVkhUj6zRjR2+OiXA4NwTKww1caWFYHLWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678712290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RwaUg6myi9ABQdqJVGJv37nQDlbAAjsh5eWKeZHxlsg=;
        b=jjJS3D5JIWbLW93M4elErtQ4iiKhvA6NFKgnSKDkEpwmGYwMKore9jsDZkhmATLSX1+UXG
        CNOVq/4As6ZGckCw==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt/coco/sev-guest: Do some code style cleanups
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307192449.24732-7-bp@alien8.de>
References: <20230307192449.24732-7-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167871229014.5837.18422777440334772026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d25bae7dc7b0668cb2a1325c64eb32d5fea4e5a9
Gitweb:        https://git.kernel.org/tip/d25bae7dc7b0668cb2a1325c64eb32d5fea4e5a9
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 15 Feb 2023 11:54:59 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Mar 2023 12:47:55 +01:00

virt/coco/sev-guest: Do some code style cleanups

Remove unnecessary linebreaks, make the code more compact.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20230307192449.24732-7-bp@alien8.de
---
 drivers/virt/coco/sev-guest/sev-guest.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 07dafe2..81a53c3 100644
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
