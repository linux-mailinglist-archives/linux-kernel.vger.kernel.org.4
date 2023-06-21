Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7F738134
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjFUJWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFUJWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:22:34 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AE110F0;
        Wed, 21 Jun 2023 02:22:33 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b47354c658so52499521fa.1;
        Wed, 21 Jun 2023 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687339351; x=1689931351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EDeNQQqyz/nKt5P8lWcisu6DsEDZkm29WDucZUEslLo=;
        b=LvA+yAc7uqyQWWHYSZ/EweD6nBt0ToDoNvUQfmFPftuB3YQaD3wDtfcddxerdjpqLK
         zNURLecHDA0Q6cOBY3eeGf4xX6I9MmmOuJ3gASfKbMSoWsMUsi6UzaomNPo4JNN88KxB
         y3nMyhHHXkjrJ0okRDyTFUog714z1htWRo6ewS0Zm/XhbEi+5kbQVg7YkggJN9ODNKW8
         looCIxDSUKflL9OdA8dMMf3ZwQufzYK0AjgZ47SJeC/bu/mpG4Ov3dQHEsE+VGcWlOPx
         0kihrQ7jlL0p5ijllp28oM66AKUJrmxVHjFbWLmDiID2FFyCr5wG06Pi4u6MY21pLv4q
         9qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339351; x=1689931351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDeNQQqyz/nKt5P8lWcisu6DsEDZkm29WDucZUEslLo=;
        b=Jjp0cVdYtWayDmT32m9b93/MK8UjjUJFMBqiP2e4H7DMlI8TghPaeNs0HaRXdZ/zsG
         G93NghQtjPtJJVsH50b0lTXkfq5IC5LhcMpSvtquaBfpJ/fO54GDPXYwCO6PFN8ovcaI
         9DSX8MrPCh0gj1bme4paMkfexEWyKHBFRsJ1I6dxmAahGsutBx2db6PV1o5ESkbGvsLa
         T8XF1fwucikQY7aKOtm5GszLeuJnDSFXpLY84Hs0JIjeIxxUkqAP4Ls9+ZXKPaLv4yhc
         ekehLj8qfCDOmbPnkeubpkGso0MemMddplxHhQRtcZlZ9/2W5NdEsNEEIk5nulqAiP9Z
         eYRA==
X-Gm-Message-State: AC+VfDyiMVV5AbfEYoh+fg/yPbii96MOMn1qyYlIluXGoR/5Bnxj18NY
        SYhsfeDW57QoLLh1ce3NiiA=
X-Google-Smtp-Source: ACHHUZ4b5B0OPx8Ocken2B6jez7ePavuLOeKLr41nwQeM7rYzRLGaa8mAeN0QJbfqgiDZ0QYVm5Ecw==
X-Received: by 2002:a2e:3211:0:b0:2b4:7d83:c80b with SMTP id y17-20020a2e3211000000b002b47d83c80bmr5066194ljy.13.1687339350913;
        Wed, 21 Jun 2023 02:22:30 -0700 (PDT)
Received: from localhost.localdomain (sa-84-52-56-253.saturn.infonet.ee. [84.52.56.253])
        by smtp.googlemail.com with ESMTPSA id w7-20020a05651c102700b002b1b92910c8sm811575ljm.86.2023.06.21.02.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:22:30 -0700 (PDT)
From:   emma christy <emma.t.christy@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     emma christy <emma.t.christy@gmail.com>
Subject: [PATCH] Subject: [PATCH] media: rkvdec: removed redundant blank line
Date:   Wed, 21 Jun 2023 12:22:23 +0300
Message-Id: <20230621092223.10805-1-emma.t.christy@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to Linux kernel coding style. Removed redundant blank line.
Issue found by checkpatch.

Signed-off-by: emma christy <emma.t.christy@gmail.com>
---
 drivers/staging/media/rkvdec/rkvdec-vp9.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-vp9.c b/drivers/staging/media/rkvdec/rkvdec-vp9.c
index cfae99b40ccb..0e7e16f20eeb 100644
--- a/drivers/staging/media/rkvdec/rkvdec-vp9.c
+++ b/drivers/staging/media/rkvdec/rkvdec-vp9.c
@@ -227,7 +227,6 @@ static void init_intra_only_probs(struct rkvdec_ctx *ctx,
 				}
 			}
 		}
-
 	}
 
 	for (i = 0; i < sizeof(v4l2_vp9_kf_uv_mode_prob); ++i) {
-- 
2.40.1

