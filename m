Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EAC6C8E7F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjCYN2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCYN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:28:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3476AF31
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:28:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x3so18182424edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679750914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ShMF2P8iaE6k70YQQ7/9mT94Sb/9TGolk0qbMWkXhfQ=;
        b=WonXO4DE67eifx43i6erh/LtEC9O4lRAVF3Xm2UOVFed3hPR4uSGZAKLcZddtxYN2G
         YGlTndk/dAsfAAzfJXH2yS5aG4Iq2CrureG+1FAZNP40R2Q1VzmTbL0HWn6b8QsQr4Bd
         ZXkJMaZHBXjAwlgmTjMhdkzU9b/uodjIH86PhK3OCVqBbVqyWuOqymRsDJUydgavx91t
         mC66/U3zEXzaJut41zW9Oo2vd9CBLBH/gsvSVB00z7pXTM//05kBqVFB8kYCG9OkEPhe
         iNDLnHf1VW+aN0VfNtqUmrdCyOF12usJF1sUySHAe0qrM3XQRSwx171L8c+6XdzJhDzR
         ogEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679750914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShMF2P8iaE6k70YQQ7/9mT94Sb/9TGolk0qbMWkXhfQ=;
        b=ewd0s+vZSG9jOAdVI5egFR8VcNtIT4QSpmQ+iyMSGLMvMawW3gQ6AogbVxckkMJ35v
         ApVnMmsaH5EcSHSkbj4IphSiXanGQ0dNyv3dB+d9oqY9mvHylHL2h/YqkfaDwZIKrsYb
         MI4IZmiafF1sc1C2HN3PgSls0Psv7Te5Ltg19iojwM9RLGZ0ssGhlOCcOGWn9EjSlxfw
         Dtk683QXXAov4WnrLs+Z+ZC0pt5IYm0TR9O3sNL8iTuxRNJ+0DUuwUIcP6RilQoHEB3N
         Ef1odjnNOeapfHZfkTTx24IbmHuAPU3altP1LzaaT+xNAmFBsbx8xC9btJ5/ubrx+FB2
         /+FA==
X-Gm-Message-State: AAQBX9fAE9m+0vpKSsVmpvqPcyj1emQpWpqf15wQpB0UF7tZLfbz9PBS
        32zyOVAftFIrCCJDuiqL+eLMCoolObM=
X-Google-Smtp-Source: AKy350YQhHJtLJumsu2kOulRSbPK9C5zaOwUBnVuvUjvV0wghRqcQtCKS6bz1YmzH6uZkPTGPJajWg==
X-Received: by 2002:a17:907:3e1d:b0:931:1567:f84f with SMTP id hp29-20020a1709073e1d00b009311567f84fmr7846000ejc.4.1679750914406;
        Sat, 25 Mar 2023 06:28:34 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abbe9.dynamic.kabel-deutschland.de. [95.90.187.233])
        by smtp.gmail.com with ESMTPSA id lt11-20020a170906fa8b00b008e54ac90de1sm11727610ejb.74.2023.03.25.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 06:28:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: rtl8192e: remove rf_type from r8192_priv
Date:   Sat, 25 Mar 2023 14:28:19 +0100
Message-Id: <20230325132823.22872-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes the rf_type field from the r8192_priv structure.
RF type is always RF_1T2R, so we do not need to store it in an extra
variable.

I don't have any hardware to test this, so compile-tested only.

Michael Straube (4):
  staging: rtl8192e: remove RTL819X_DEFAULT_RF_TYPE
  staging: rtl8192e: remove redundant setting of rf_type
  staging: rtl8192e: priv->rf_type is always RF_1T2R
  staging: rtl8192e: remove rf_type from struct r8192_priv

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 19 +++-----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  7 ++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  3 ---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 25 +++++++------------
 4 files changed, 15 insertions(+), 39 deletions(-)

-- 
2.40.0

