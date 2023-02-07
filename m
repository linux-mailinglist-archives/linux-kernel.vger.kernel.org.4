Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4593A68D29F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjBGJUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjBGJUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:20:30 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D5F3864F;
        Tue,  7 Feb 2023 01:20:23 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so14194938pjb.5;
        Tue, 07 Feb 2023 01:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6+lCjCIw+d121nhHvuoYoRysIALsYtMY+doyqH/Okk=;
        b=Oxed55OOAfqxd31PCQBLgupCqjkSIAF09L+33CcLoJhrLRXXmznaKYHlwpPlUmWz64
         V7gEHp9S2hrk8Bo9oG8op9c2Ku09LZiJHhTy4AJ4Ty/7o+y2d8s/pRfyemPZF1XIBfo9
         8Boz0KrSkmfDv03yvwq31V3JvIZE37ILVwsLi0RE5RI0zTg76y2ZclAIzvQldHce0XT0
         ltmpPAzTAf3+nyPHu0BICdHoMprzGiig9nmcizzN4MfTkHUXufVInVDYEkD9YDtLkGtY
         RT83HGJkNNInoLXFIyyJD3UhGRRpRQXgeaI68hwqctQnESyZrA9dtgtpINaUXQ4nNC/z
         9/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6+lCjCIw+d121nhHvuoYoRysIALsYtMY+doyqH/Okk=;
        b=NLa/Lvu1UHGZNEt7D1aKtLCptHhxf+28q/KvnpNxMwu3I67Bpe/FwkZZDfpsdBq2Xj
         /r+rZcWu/1kzwpqtHQAx1uNCqnzu7DG90zEw4IAWSclMLtIYNH9hJ2xzmt5886sNhy4/
         8As/KTsEcOA2UHejkG+h2v7sLujc+iUTY6ydgF8fE8mcuuCctHAvffMWbGJwzFInVU5u
         O7IAgGcy5rii1vA1j4ugTT7hrTmeWIqPZ7wv6ApYJW5u6rvrxuQ518kNSEHdDol0oKSf
         K+E0nA9podExJ692xibqviFPuQ9+ab+AfyHbZqSOIp1YXUtq4j7MrjgGoIsmmIplOn73
         0FDQ==
X-Gm-Message-State: AO0yUKVkyFfnjf1cwrSlBOms4G1TOp6ust9dP7POFydrT2nstQsfArL7
        yLfV/jlQ7ibICOUgu+eARLI=
X-Google-Smtp-Source: AK7set/Iot/ID55E3YLaEET0LXv0VhMzH/eYVcSzaabohSHX+tlnKdFf42veGm1ng/w61Oeoq1MkJQ==
X-Received: by 2002:a17:90b:4d81:b0:22c:59f2:9006 with SMTP id oj1-20020a17090b4d8100b0022c59f29006mr3257578pjb.34.1675761622808;
        Tue, 07 Feb 2023 01:20:22 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b0019934030f46sm545327plb.132.2023.02.07.01.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:20:22 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v11 5/7] media: v4l2-ctrls: Add user control base for Nuvoton NPCM controls
Date:   Tue,  7 Feb 2023 17:19:00 +0800
Message-Id: <20230207091902.2512905-6-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207091902.2512905-1-milkfafa@gmail.com>
References: <20230207091902.2512905-1-milkfafa@gmail.com>
MIME-Version: 1.0
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

Add a control base for Nuvoton NPCM driver controls, and reserve 16
controls.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 include/uapi/linux/v4l2-controls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index b73a8ba7df6c..aa5c9f64f1d6 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -199,6 +199,12 @@ enum v4l2_colorfx {
  */
 #define V4L2_CID_USER_ASPEED_BASE		(V4L2_CID_USER_BASE + 0x11a0)
 
+/*
+ * The base for Nuvoton NPCM driver controls.
+ * We reserve 16 controls for this driver.
+ */
+#define V4L2_CID_USER_NPCM_BASE			(V4L2_CID_USER_BASE + 0x11b0)
+
 /* MPEG-class control IDs */
 /* The MPEG controls are applicable to all codec controls
  * and the 'MPEG' part of the define is historical */
-- 
2.34.1

