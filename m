Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3256CAF22
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjC0Tta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjC0Tt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:49:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2E23594
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:49:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so8077431wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679946553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NjCcLoIlqFNxoJB7I2WmOr2pxCSji/b+9pZvuMvJmaU=;
        b=WkY4SZMvLqxXNdUPpvROtO+jdZcoqHTQnKeXo3qafrs5wa3uJcfMi++yT21LU4WjAz
         Z+lIO24mQUKie7X/4qIV0Kiq1CjXXcE1p+YIWL/AYfUK8f5GM+62TUYeidu3b6Np6ix9
         qSWnBoB5OIoXFX0zf/Z0yhHUwa3dRSqpH09iLV8bc7qT+a27UH1EiiRucD0L63O5JbUC
         0RA4YxV/qjdtcskB4DqaDj3Zjex9/B+08+On/BQyRDE3ky8sFcHjMlXk0y6wZfZB1Lot
         ji5iU3VTXpZa8sM/FafKn3G21ygposz9ovy5+Vy8W17YaExN33OES3ebtPbjMmf43tiw
         +crQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679946553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjCcLoIlqFNxoJB7I2WmOr2pxCSji/b+9pZvuMvJmaU=;
        b=rO3ZsRfIrj/CmqRflxgNGxmbMFXwYp1Thy1/j7Ua5aBdLnTp8nQdfyupi6iA1z8gHY
         gH8/gyySres0GMXC9H/SaP5fQVsp1JmvYib/yX/lGP9YUWnU8LgS2uPsPiQuSmEkC2kv
         6ko+gRph5akO3J7TnSj3oieXahxtG8tIICG8l++46p+n5bUaUdudYIroyWdaoKKGmYwE
         gVpmJWmk2COxImRwveHrcoXWtDFA9H0isAKE9eqnE/wZh9ynJ6Y+RgERGeqpE9pabPqO
         EyOOvZJriZI+abAH4R42e6PrePrMKajjhVWBCtvHHjM4YizOn5X8OOr+V3RhyYcVWVrv
         EHzA==
X-Gm-Message-State: AO0yUKWNpv5QT+R3RUnzIH39i0QwlZ2m1/vUxrr8kI8r0D8dlB/U5YVK
        G5l3fcmfhPKu+TEmfSR1FduV37g7kG3rdj7b
X-Google-Smtp-Source: AK7set/se8+ke/Z5Xe1dYsL+TqqBgCJRwO6mI/LcJCRwMkdUheUkvvVzWR/BONIaftO6KEfHKtOQ6Q==
X-Received: by 2002:a05:600c:2182:b0:3ee:3b7b:73c1 with SMTP id e2-20020a05600c218200b003ee3b7b73c1mr9795173wme.28.1679946553125;
        Mon, 27 Mar 2023 12:49:13 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id c13-20020a05600c0acd00b003ee42696acesm14661366wmr.16.2023.03.27.12.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:49:12 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] staging: rtl8192u: clean up comments in r8192U_dm.c
Date:   Tue, 28 Mar 2023 00:49:05 +0500
Message-Id: <cover.1679945728.git.kamrankhadijadj@gmail.com>
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

Clean up several comments in file r8192U_dm.c

Changes in v3:
 - Split patch 3 in two patches, one for '*' on subsequent lines and one
   for '*/' on separate line, as suggested by Dan.
 - Add spaces after '*' in patch 3 

Changes in v2:
 - Remove the 'commented code' and 'revision history' before
   reformatting the block comments, as suggested by Greg. There is no use
   in fixing comments, only to remove them in the next commits 
 - Patch 1: Changed the description and removed extra blank lines under
   the change history
 - Patch 2: Changed the subject and description 

This patchset was created after reviewer feedback on an initial patch.
The feedback suggested additional cleanup comments. Link to the first
patch:
https://lore.kernel.org/outreachy/ZB2a5zwYpBZ%2F6qwU@khadija-virtual-machine/

Khadija Kamran (4):
  staging: rtl8192u: remove change history from comments
  staging: rtl8192u: remove commented out code
  staging: rtl8192u: add '*' on subsequent lines in block comment
  staging: rtl8192u: add '*/' on separate line in block comments

 drivers/staging/rtl8192u/r8192U_dm.c | 206 +++------------------------
 1 file changed, 23 insertions(+), 183 deletions(-)

-- 
2.34.1

