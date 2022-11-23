Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A106355C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbiKWJVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiKWJVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:21:09 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2C66C729;
        Wed, 23 Nov 2022 01:21:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b12so14637301wrn.2;
        Wed, 23 Nov 2022 01:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eY1uoxUa/SzoVyhECcaH3Ygl3jk0Vc9W5NwCNu1iMGo=;
        b=XP6X7gMPnbSHQxIvyy+jkz1FbWjuBZoOmlwJNu7KswlVr3M4bHd7fDcpVk7NyZo4pI
         x71hz1r7zg8a6DeeB8VSSq+484swfsIRM2j5FQdW49jdpLv/c79ry7cK5Kx8d0fS+bz7
         k9v7La8Ddfx6xF84RU3xhQOb5U5R/xqlzyozq6l3bK+n2UMfJihOinxNdjoe6QPbFPxp
         GPzhc2NcTnHBGaC451kHiueKTEfNmk+qHe+HHCIAOqBjXXDQbwlKfhzCs+qvbNueBf69
         gXssQRwpZ6DcskJjMDeWdNvwlWkuTErz9K7CsTnfEpkSPe4Yd4DzaURlEZ/S184M+n6A
         X1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eY1uoxUa/SzoVyhECcaH3Ygl3jk0Vc9W5NwCNu1iMGo=;
        b=usP2Zp7tY6kF0sDxa9nmtO4kBIODRRpuRNneTRaj3oGcQaXKw9mhMPHOLpgeWZwzi8
         a7WQP8/yzjCLPw/CtU0TV59z5Fn1PV8VwHXtASOhvX1nc/MbIRSBfXws2JlLPnEkrhho
         xV/Zvpj6Bqt/dG8Ht+wb5CC9cKq5S4c8KThLKWp0IUjF/pWc4stqf5ZalyOcwo5kdNRw
         oUUEBzLbhUqA+stAYw+SWJWPjRzPlmTL3Zdh5GyoIlxHzYXuh9ZE3RVa3kOPxE5lE66A
         SIVZO6NjHJ2DHqbGoB1aY8YE/JXiVXVf6Ll0RSSWUXbdr6sOXQXd9LQRVZhZhmqVuc7M
         AMRA==
X-Gm-Message-State: ANoB5pkUIEUhh+W3ncI7f2uxNwLflb2PE3c790KpEVsTijozf4+0S/kT
        Xl2bgRP2Dd2+jS/uY5FYs2A=
X-Google-Smtp-Source: AA0mqf4AZfPqxkXKTZpyPC6UNsJZKfdPjFl92u7DCIP8nEiikEfWcf4S9ClPEqEr8bQ8f7jil+P1XA==
X-Received: by 2002:adf:f1cc:0:b0:236:e629:adab with SMTP id z12-20020adff1cc000000b00236e629adabmr7764763wro.621.1669195266358;
        Wed, 23 Nov 2022 01:21:06 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v1-20020a5d6101000000b002365cd93d05sm15794017wrt.102.2022.11.23.01.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 01:21:05 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "David E . Box" <david.e.box@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] tools/arch/x86: intel_sdsi: Fix a couple of spelling mistakes
Date:   Wed, 23 Nov 2022 09:21:04 +0000
Message-Id: <20221123092104.378937-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two spelling mistakes in some literal strings. Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 2cd92761f171..e2607992673c 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -280,7 +280,7 @@ static int sdsi_read_reg(struct sdsi_dev *s)
 	printf("Provisioning Availability\n");
 	printf("    Updates Available:          %d\n", s->regs.prov_avail.available);
 	printf("    Updates Threshold:          %d\n", s->regs.prov_avail.threshold);
-	printf("NVRAM Udate Limit\n");
+	printf("NVRAM Update Limit\n");
 	printf("    50%% Limit Reached:          %s\n", !!s->regs.limits.sdsi_50_pct ? "Yes" : "No");
 	printf("    75%% Limit Reached:          %s\n", !!s->regs.limits.sdsi_75_pct ? "Yes" : "No");
 	printf("    90%% Limit Reached:          %s\n", !!s->regs.limits.sdsi_90_pct ? "Yes" : "No");
@@ -308,7 +308,7 @@ static char *content_type(uint32_t type)
 {
 	switch (type) {
 	case  CONTENT_TYPE_LK_ENC:
-		return "Licencse key encoding";
+		return "License key encoding";
 	case CONTENT_TYPE_LK_BLOB_ENC:
 		return "License key + Blob encoding";
 	default:
-- 
2.38.1

