Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02B96D386F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjDBOcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjDBOcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:32:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A403759DC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 07:32:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y4so107760349edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 07:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680445970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=btTikhkSAhCNIjZnkFaaVYNDj8dPGj1R6e13KUaPBKQ=;
        b=GoKwnVSzTLPQiUQiv4d2EsRl+TJeqJ4ImhxfaM4msiuHVkekw7pKa9OtNb7vtrz1M1
         vzlouMNmYme95Hr1OZxELt/6G4GWozhmGLW1aaOujotlDdHrvRdA7kzaE5XXiOILsTDl
         gwqibkZgg1Ya5A/+2xgLdgXEH8UMbFh2Vnj7g8ci1ruRkCKznIrffjzgdBRjzdc6rLT7
         PJ8bOpZfMfPiK37txnZp679ddQoQakB9i+blSoLy3G9L5sVaci5QCm1LH4lfoCQgdbeU
         zyIcvM0pstBV0mKsdSp9f+6sS/1GA5bgvudMRCY9IenMmpt2QicqU0OjbojKj2r5Mcv4
         73ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680445970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btTikhkSAhCNIjZnkFaaVYNDj8dPGj1R6e13KUaPBKQ=;
        b=Am9j4MsgTnBYcqjdgxKfi5M+rxip4GqECYEIMIMrrtsIKmlvieXtCOq9TecnyZuj2V
         4vQwKWMH/kEkBWTkwOO9L8fXHuun+EI2CLlFL+Zb+kD/xxq3zVI+7UyCkX00Pb3CyDjs
         199jHDbF55NuHTH66uqu6Gv2kKB5zyiHUUe4zE6KOMcA1ZeQ/ivRJxM+yjlPZ/skdFks
         XPiMNzxXqkbwBdWKqJPGEpXV7ZcMfOrRN0vftDS+zbGgQT0GBucdm3YJTAoeYPgKmncC
         2sUwzjlUJzJnMDp3/diBnpJoAAfwCGQ1fERRFIT6u2hay+i3/ufbAfJIYhPqNC4n+yc+
         3d3w==
X-Gm-Message-State: AAQBX9cjxEDO4smZ8PqxuDRCFTufspO+UQ/l9UqKGod2PUDDBMrRYAcS
        Kbi7TEbK587FDB+k9yH0jSGCnPqx4tJ+SQ==
X-Google-Smtp-Source: AKy350aZdFkDoEKRIqv/GHTM30RquYGykcCtD+5cOTSeMjg/39EC+NgfkiSPTUO8+kcKgpFheMsvXQ==
X-Received: by 2002:aa7:c9d6:0:b0:4f9:db7b:b6b4 with SMTP id i22-20020aa7c9d6000000b004f9db7bb6b4mr26956323edt.40.1680445969959;
        Sun, 02 Apr 2023 07:32:49 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id p18-20020a170906839200b009476dafa705sm3273292ejx.193.2023.04.02.07.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 07:32:49 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] staging: rtl8192e: fix checkpatch issues in rtllib_crypt_ccmp.c
Date:   Sun,  2 Apr 2023 19:32:41 +0500
Message-Id: <cover.1680445545.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fix several issues reported by checkpatch in rtllib_crypt_ccmp.c file.

Changes in v2:
 - Update variable_name in PATCH 3, 4 and 5 to dot11rsna_{variable_name} 
 - Remove comment from PATCH 3

Khadija Kamran (5):
  staging: rtl8192e: remove extra blank lines in rtllib_crypt_ccmp.c
  staging: rtl8192e: fix alignment to match open parenthesis
  staging: rtl8192e: avoid CamelCase <dot11RSNAStatsCCMPFormatErrors>
  staging: rtl8192e: avoid CamelCase <dot11RSNAStatsCCMPReplays>
  staging: rtl8192e: avoid CamelCase <dot11RSNAStatsCCMPDecryptErrors>

 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 32 +++++++-------------
 1 file changed, 11 insertions(+), 21 deletions(-)

-- 
2.34.1

