Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5BF7389FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjFUPn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjFUPnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:43:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71950E69;
        Wed, 21 Jun 2023 08:42:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so1085525e87.3;
        Wed, 21 Jun 2023 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687362172; x=1689954172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzxiaQ082ZFew564dfizmutmqfV0MIQOlwM4DhrL6Ig=;
        b=DnH636UX7kGEnRpOVDWD065E2A7A+d66pQf0h3YL7NRfQsbdrdNIvirYGSd73IkXSk
         kcoJ1lnxOlZBW2fKCvEuRhpKtupQbp4IxZMvKcJ4YvvlMg6MlfIForbYnAX+Tt1W8qQy
         5aQQM36JHa5n1+VX8r2GdnmDN+GhkJOcUVltA3OiZygvcFnM4vqgzHjPvVChi2SdNgWa
         YHwUzJ1OdLIXlCrua4LA032FZudH1sIWh/D5nv0fjmg05eOG+BDPpVNHegMTRjMyx0FO
         iLU3RW1XC0I7fdkuta3Abr4kAjZqfqyZKXuey3P4yhUeNbOJ4jHlVXWbyP8QO4ghHQGl
         Dl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687362172; x=1689954172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzxiaQ082ZFew564dfizmutmqfV0MIQOlwM4DhrL6Ig=;
        b=fCuG0sVcJj6BSHHWKV5c402a4yTk5PgZtheoQkSy2w3Ad0s2yWnZ5QIZGvcfDJ9+QH
         hrOH7AwAXKYPT8LWrN9BPa8p33+ZiNHBwTSxLM1C79f0CQ1XgqD4o67cjNAd9lsvtHcn
         CTqRZXvVQLrRtyMjZLnVzAMk16bDrR9FZaRdEQmnCiv1Qn/RS+3Jvbgb1ryHRPH3jIUB
         8z1cJDcCpLWSBJUoaLSSYd/MBN9HbEJEE5cA4esJrnsLlhBxc97qu73JZ6YncchOszMd
         uyAdQl+RISJ6hD9ib1f5nCHHjoKeB/omFe5a7RxYwgfd5EAEtH5I8/VJW0RkbruTbESB
         ki+g==
X-Gm-Message-State: AC+VfDx9OlQLYcfKWLs2kNgZiEtkEfUehv7/LBgWd+pCfP4Hss16/qLa
        wXU1gzcVl4Nekcp52hRHTl0=
X-Google-Smtp-Source: ACHHUZ6Oy/XXvR8t4B7d/NTgPTdlbFRDbN1BltI4AoZQjNz5Dhl5IEq4dU7qm1CazjTVer2vn6hV8g==
X-Received: by 2002:a05:6512:55a:b0:4f7:669f:7da8 with SMTP id h26-20020a056512055a00b004f7669f7da8mr10582510lfl.7.1687362171346;
        Wed, 21 Jun 2023 08:42:51 -0700 (PDT)
Received: from localhost.localdomain (sa-84-52-56-253.saturn.infonet.ee. [84.52.56.253])
        by smtp.googlemail.com with ESMTPSA id j17-20020ac253b1000000b004f76684329esm813156lfh.234.2023.06.21.08.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:42:50 -0700 (PDT)
From:   Emma Christy <emma.t.christy@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Emma Christy <emma.t.christy@gmail.com>
Subject: [PATCH v2] media: rkvdec: removed redundant blank line
Date:   Wed, 21 Jun 2023 18:42:47 +0300
Message-Id: <20230621154247.43983-1-emma.t.christy@gmail.com>
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

Signed-off-by: Emma Christy <emma.t.christy@gmail.com>
---
Changes in v2:
  - Fixed Singed-off-by.
  - Fixed Subject line.

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

