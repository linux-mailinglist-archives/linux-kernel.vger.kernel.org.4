Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55126D3347
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDAS6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDAS6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:58:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE242FF
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 11:58:49 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso17388846wms.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680375528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pvhkRPvXdeV1MvCkQhlmcgNllu5JzWC+z+MaeDHhAgk=;
        b=pP7DiipO3CsrF0nHke2LU6/tnLaYTX3qA+/kyd2for23PMMErAm7pbzbuwFCpqd5kb
         9+c6eHLeO07zPWaylJi29feeJjw3U6yfsGCIy8THKWpi4FIZPu+fLsQxU3E5Sywac0D+
         52vIlHkYi/Y+5b7FSIbL7lQuOPRXQmAnRJVAFoH2VeKPeFayLP2/g8H7czxyT4OJnRH4
         gPddsLd/WNGFK17fvN+OaTH2/jZeLLRRxTgjMYoZzGiZzUuJjOJeb6iTYCJBFjrGyzVz
         uJcguOzJrFEf9Hsf4l9f5N+wQMlXMjuIaijQKt1G9N+093WG1yXNjgTrwGsx1vKYDo4p
         UuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680375528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvhkRPvXdeV1MvCkQhlmcgNllu5JzWC+z+MaeDHhAgk=;
        b=FZArXhftPKU5XEXsE8acgCVoMQSlcrKhm3ls8/+tjXLalKl/mc9dZzFk7+3siY5glf
         UFr3nUMnCBKyGEwPR5eeO65mmoCI5lfe6JM0EAmPP4qKvFigL3CJAL5bOrKnbTX+F5l0
         GtvV6neUHCOfiITS68AEXlP04rlksmRmMyHPBRFcxzXmYEfpWM5NGS+rWPthIBuy0Y1u
         DRSbtRDZJoNj5RJu/OrFpVdu8k8PS7dgbZLjCQtS9yrY5nPMRxpC1S2f4fUQdzjTO/Yy
         ksO/L/PxOXrgJ14g6czO49rL/UXRhMs+cOsyj245sBktTL9ToNcwadHwflnGqd6/frea
         TbkQ==
X-Gm-Message-State: AO0yUKXiijP5Jh5cCM9J1mCcodsgUqwwXt2Wphpz8DQY+MLQWBKa4udm
        gnNk4eUKy2PO9VRYVOottNxT0EfsHFA11uYV
X-Google-Smtp-Source: AK7set9oCYKWk9mo+0+bIIkFTcMGIXiDNA91s9KMCxQWQegj/+KREZFB2CNsQetfeOnslex9ai85gA==
X-Received: by 2002:a7b:cd97:0:b0:3ed:ce50:435a with SMTP id y23-20020a7bcd97000000b003edce50435amr23042468wmj.10.1680375528092;
        Sat, 01 Apr 2023 11:58:48 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id s17-20020a05600c45d100b003ed51cdb94csm14017463wmo.26.2023.04.01.11.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 11:58:47 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] staging: rtl8192e: fix checkpatch issues in rtllib_crypt_ccmp.c
Date:   Sat,  1 Apr 2023 23:58:39 +0500
Message-Id: <cover.1680375200.git.kamrankhadijadj@gmail.com>
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

Khadija Kamran (5):
  staging: rtl8192e: remove extra blank lines in rtllib_crypt_ccmp.c
  staging: rtl8192e: fix alignment to match open parenthesis
  staging: rtl8192e: avoid camel-case <dot11RSNAStatsCCMPFormatErrors>
  staging: rtl8192e: avoid camel-case <dot11RSNAStatsCCMPReplays>
  staging: rtl8192e: avoid camel-case <dot11RSNAStatsCCMPDecryptErrors>

 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 33 +++++++-------------
 1 file changed, 12 insertions(+), 21 deletions(-)

-- 
2.34.1

