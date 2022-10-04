Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B055F473D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiJDQNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJDQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:13:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724515F9AE;
        Tue,  4 Oct 2022 09:13:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id ay36so9234996wmb.0;
        Tue, 04 Oct 2022 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=l1KZpUgo00G/5L4dmMW5myayn4Zqd7m3fQ8mEVKtoi0=;
        b=ZaacCWCIe0ILL/+CwFEyO4+MxyQwkhPj6wNUBHx/wY4ZSIzoXw4ecmNJOCYM57Sv4C
         vAKGjElpFDakNao2KI3c0I4dTS6XTzz9EdDBu4z6927BruzU1CtKm0bGl6fqAAPedpWu
         rs9UhjZUc+EkaoCEK0EPc1b6mleAaw9jkD1D7kWIukyTJsSoHj62KTP2QbDa29qn0DbJ
         xfCx+buSmZrf+YOJ1UGmr8xU0RirEDs1zTa+MSMsO1WHfU3JFF69FvHqeFEQESkLk3gm
         xhZI9jtNNZosaQaWVWXG6aBvzdd9kzda2Aflh3/OeAt5CCrh80FRIDwGbkbvD/Kq4VQv
         WWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=l1KZpUgo00G/5L4dmMW5myayn4Zqd7m3fQ8mEVKtoi0=;
        b=JI/2jx9d5V1FImLPmgYfaKZnNrnmAUeBjQMFCiD1ChP3asl/cY3HKecQrOCVthmiPX
         nildcd8NVQ/vQJ24Zw0gYepL2RrigaEc/1ipELSlUnrSzgRv4gQlLvfeCcNbbI1n14eq
         A9DptgMhqM5Vm8CRhxW6fV0GRE4lCYPx/o+oU4yr3IxVw81tOZIldgUhrL12EhnpbRnZ
         wv07IdfO/g9x9I0d6vKVQZKd5/ud1ABGz42ol10KkOIJxDlIsN/1x9qVJu9yBc8eBznj
         TKo5LiZxfgYVySdV7i2zOS3HLhgWHE9dt3scvNrXoDuXmbDv0Zf5wWUlan1lNvthahrV
         AbSw==
X-Gm-Message-State: ACrzQf2Vky1XsNOiKaMciVsYL06Qg3pVxLtcPElPn09egbeHW2ZTMv2L
        W4S2jMgfK+V7NG43uNhQBrk=
X-Google-Smtp-Source: AMsMyM5fuTuElVWbTJBd+GRRwB0eIy4mOiqZXTScu7eYqYNWJ4h3qgVk9rHIVmD1F/k1NAZEMaOc0Q==
X-Received: by 2002:a05:600c:3b13:b0:3b4:757d:93a5 with SMTP id m19-20020a05600c3b1300b003b4757d93a5mr354003wms.183.1664900018064;
        Tue, 04 Oct 2022 09:13:38 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm19116073wmh.16.2022.10.04.09.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:13:37 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: atomisp: Fix spelling mistake "modee" -> "mode"
Date:   Tue,  4 Oct 2022 17:13:36 +0100
Message-Id: <20221004161336.155337-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
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

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../media/atomisp/pci/css_2401_system/host/pixelgen_private.h   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h b/drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h
index 1c7938d8ccb5..8f79424bedb2 100644
--- a/drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h
+++ b/drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h
@@ -161,7 +161,7 @@ STORAGE_CLASS_PIXELGEN_C void pixelgen_ctrl_dump_state(
 		     state->syng_stat_fcnt);
 	ia_css_print("Pixel Generator ID %d syng stat done  0x%x\n", ID,
 		     state->syng_stat_done);
-	ia_css_print("Pixel Generator ID %d tpg modee  0x%x\n", ID, state->tpg_mode);
+	ia_css_print("Pixel Generator ID %d tpg mode  0x%x\n", ID, state->tpg_mode);
 	ia_css_print("Pixel Generator ID %d tpg hcnt mask  0x%x\n", ID,
 		     state->tpg_hcnt_mask);
 	ia_css_print("Pixel Generator ID %d tpg hcnt mask  0x%x\n", ID,
-- 
2.37.1

