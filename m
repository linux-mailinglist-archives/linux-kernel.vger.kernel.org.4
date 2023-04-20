Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA38A6E9DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjDTVR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjDTVRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:17:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064345584
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 14:17:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ec8ce03818so894511e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682025465; x=1684617465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqyMIYrZenERD+yF3K/aoB3sZGcu4giDZSstYVu8C3I=;
        b=A1iTL73a01GVqC7lJ31QCFZkwN5U4aipeB3kURuPpCA6gdg4c/4A8D7K9CcyIBzINt
         ASoyvHcAuS4F/9CmNfIfFzCQmwtDjDx0N+9JoAk6dzFFGvtTV2JTX9EjN0GK5W6h2lL2
         5hgxtF+trm9cWn4MeLlDo53vIjb1XI3ELYuIAUoynEIZJacl9mYCuRXW9ThKw0OlheEF
         6Z+vIyxmNxh4O8NgjUPU42bkLw3uKUmR+jB7I2G8g+/Q6xXCB6UdI8FHGgm7GnE98ooL
         8jXXiu1NVFMf4v39cBD/Wj16KnAg+pOWPFz9BfBPgAI6GMe2DtEQjZERGkdVmNzFbLI7
         LvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682025465; x=1684617465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqyMIYrZenERD+yF3K/aoB3sZGcu4giDZSstYVu8C3I=;
        b=gR9y3gzZaaX/FfCT7XNF0nCJ05hH6setZS/O5UcVCmF7PRbslOeFkboNfs7vEAHP1e
         mif5H5cNNK6sdLZkpCKle6y1cnFfEVzzDXJAo/+zkPX8ht6Hi8nAL3/x0xoiZvELEugI
         7b5DsaZdTDXyUAihM84QbOXGLEdShY5ujvMgjJiWYEAZLxQ4qTqoVTOx4QAGAIvRd2cE
         64HyhjOaYtV1CUb0fCEle3aCglpqvwJi4tpyNeEp2fZmK2AOElsVaeoovdan2zpQ14Uo
         aK8B/kANnFRmxoWJa6/T5J8yCRtuvH9KLdKu/0ukoJANnLpA8ZwKTJCm845EAcOBRpNX
         ImTw==
X-Gm-Message-State: AAQBX9dTRo0PyooP2+gK+Q+Bf9ohSgHJUR2of2hc/QE7d8cw3zBcoJs/
        uYvC5mo/jAV6MF9liIKpixjkDQ==
X-Google-Smtp-Source: AKy350aa2d/vdkUV7yYKQIAaLjVceOkfBQAWRliCxTVlaTzps/o86XD2fxhJutxHQvf5PqL1Pz/RJg==
X-Received: by 2002:a05:6512:3d0:b0:4e9:bf83:11a4 with SMTP id w16-20020a05651203d000b004e9bf8311a4mr740684lfp.7.1682025465234;
        Thu, 20 Apr 2023 14:17:45 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id g12-20020a19ee0c000000b004edd3f011cfsm332985lfb.43.2023.04.20.14.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 14:17:44 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Apr 2023 23:17:35 +0200
Subject: [PATCH v2 2/2] misc: sram: Generate unique names for subpools
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-sram-v2-2-6e62ad551faa@linaro.org>
References: <20230417-ux500-sram-v2-0-6e62ad551faa@linaro.org>
In-Reply-To: <20230417-ux500-sram-v2-0-6e62ad551faa@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code will, if we do not specify unique labels
for the SRAM subnodes, fail to register several nodes named
the same.

Example:

sram@40020000 {
  (...)
  sram@0 {
    (...)
  };
  sram@1000 {
    (...)
  };
};

Since the child->name in both cases will be "sram" the
gen_pool_create() will fail because the name is not unique.

Use dev_name() for the device as this will have bus ID
set to the fully translated address for the node, and that
will always be unique.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Stop complicating things and just use dev_name()
---
 drivers/misc/sram.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index f0e7f02605eb..f80c3adddf0b 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -240,10 +240,11 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 				goto err_chunks;
 			}
 			if (!label)
-				label = child->name;
-
-			block->label = devm_kstrdup(sram->dev,
-						    label, GFP_KERNEL);
+				block->label = devm_kasprintf(sram->dev, GFP_KERNEL,
+							      "%s", dev_name(sram->dev));
+			else
+				block->label = devm_kstrdup(sram->dev,
+							    label, GFP_KERNEL);
 			if (!block->label) {
 				ret = -ENOMEM;
 				goto err_chunks;

-- 
2.40.0

