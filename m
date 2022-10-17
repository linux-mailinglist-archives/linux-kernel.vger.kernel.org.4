Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B736015C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiJQRuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiJQRtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:49:43 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A632167C3;
        Mon, 17 Oct 2022 10:49:36 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h2so4104697plb.2;
        Mon, 17 Oct 2022 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oMR6/650TUuxa8AWJTBFDSSqrQfZOVjzX/rHGH2mR4=;
        b=gTuX67ZrPXvnWMMUi5s4SHaxySdq+IlCqEdYMIPpu8qihH7+Px6Q4LJ6wMs+7UNIIy
         kFfMs/hv9qLAKPjmrwZbT7FrcHODtmWe+Mh9hbnrl6k/XKDqmFa/kHa9mkDdjhz+eooO
         biFY4iZeNnjvrSLm1BcCQm98igLaF73MPrwxH9NMZYiVGlPmaPzp4EaQH1v6ZwgA57Th
         1CueHBH34HLgiAawFaiWLnijD087rQ20S1nnB9s7SbPjlY1mT6ALopp1dlFvZl0VxpTA
         i/ocY5rG4CIMCB4C4jTLYSFtnkwnBc8A6EOJSEDsP0LI1aI+QMrcVO4SjEzIqYwsNjBi
         8oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oMR6/650TUuxa8AWJTBFDSSqrQfZOVjzX/rHGH2mR4=;
        b=UaT6V+ECd5+PJblgrdWwqzQ7r/UlIc9Pq2HQcah/ctmGsWQgkojbVw60joBaMAnhwq
         sYqG/4L7A1vl8YhAjaegrzAkiGGEJEg4C9RkJ0haReY/2tW5Y9uUfHQoxtyCeTfi4oFa
         Wkmf9prKJuwvCU+7SI+sq3Ff3IJ2DdOmme5ZYCGo89v9wTkP+76e0/XLVI+QDNF9ccOO
         GiRAioXQ9bF1kI8exqP1eDRR56hzJptvNeFu37Py72MwsEy5iTGvi1eeZAAOzUIH7B9V
         QS+j7ebJP/S6qVcx/cbfbuHeiiMD8dAW+ZRDLP+TJ/V9b8VCT5v2BBkLwTjffU5/HLrF
         YDCw==
X-Gm-Message-State: ACrzQf32FcE8P43ZJ6dwT7RNadBd5Ul0FgSfbR1BPVmRJjJzW27w5FuL
        kxxtGmQO+ZCWsoYXNucRpYGAKBfGTqY=
X-Google-Smtp-Source: AMsMyM57YlI6CQC1JuTHgBu+dS/pEQ48VJkO2tLaeJh1cpT7zrDg90e6tJdeBAdbVCS1J3udtYNbag==
X-Received: by 2002:a17:903:2312:b0:185:43a2:3d0e with SMTP id d18-20020a170903231200b0018543a23d0emr13463825plh.118.1666028975621;
        Mon, 17 Oct 2022 10:49:35 -0700 (PDT)
Received: from localhost ([115.117.107.100])
        by smtp.gmail.com with ESMTPSA id c11-20020a624e0b000000b0056170e7299csm7376420pfb.9.2022.10.17.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:49:35 -0700 (PDT)
From:   Manank Patel <pmanank200502@gmail.com>
To:     rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manank Patel <pmanank200502@gmail.com>
Subject: Re: [PATCH] Fixes: 91cefefb6991 ("ACPI: PCC: replace wait_for_completion()")
Date:   Mon, 17 Oct 2022 23:19:15 +0530
Message-Id: <20221017174915.45916-1-pmanank200502@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013130311.1433314-1-pmanank200502@gmail.com>
References: <20221013130311.1433314-1-pmanank200502@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed unintentional u32 overflow by changing PCC_CMD_WAIT_RETRIES_NUM to 500ULL

Signed-off-by: Manank Patel <pmanank200502@gmail.com>
---

Sorry for the spam, I made a mistake in the previous patch (I had a confusion 
in your suggestion about the Fixes tag).As you would have realised, i'm new 
to this, and not so familiar with the workflow (Though I have read the 
Documentation). Let me know if you have any suggestions.

 drivers/acpi/acpi_pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index ee4ce5ba1fb2..3e252be047b8 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -27,7 +27,7 @@
  * Arbitrary retries in case the remote processor is slow to respond
  * to PCC commands
  */
-#define PCC_CMD_WAIT_RETRIES_NUM	500
+#define PCC_CMD_WAIT_RETRIES_NUM	500ULL
 
 struct pcc_data {
 	struct pcc_mbox_chan *pcc_chan;
-- 
2.38.0

