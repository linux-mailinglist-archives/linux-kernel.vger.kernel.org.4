Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A946A7D79
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCBJS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjCBJSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:18:48 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF33136D4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:18:39 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c3so13029922qtc.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 01:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ur3zzFSZ+L9nV38J9531/+rGzVcRq8CFrus3AZSDIC4=;
        b=Ql31hrT5twUkGostOsh1nmd4im63SgW755GgYt3GS4BXhnbkG8ne6ZyhfUlLgo3t3+
         iHwbogagcCXr5FD+AzXCJpunon2xqnGpMzm80nAQm0mANklMJf8j8B3PQGQrRUQ5Blc1
         /rkyJwI0DYUpJJOg0eRIs6XQuQiYNJ3bKPicHU39NmmbjEGTCkm0VDdiE9TJ/VpEwhWp
         cO0JTYBI3RV+TMRJJg0r5lOtSTr7d+mFrg2+q8RSU7YPcX7zsDBYZZnREYN63dEYwcG7
         wgwOWNUl4z9697pEaT35wQBct/CVnR4ZBDtcLPRKpNKJVUfhXNicZxu9kdWysS+NOW2b
         zX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ur3zzFSZ+L9nV38J9531/+rGzVcRq8CFrus3AZSDIC4=;
        b=O/qu5kleHFKz5X7qNB0n/NumYMBkStVXXGjSfRNOiQnnsVzrAtHQnAXHDBh00tn2GG
         M4KMgJppWvtbNhM4wVXrynbYiiBtzEb+qocwLfBz1D1Vn6/6gNqRYGKKdtMmMCHu8Mlk
         SHjD9sPe4YrSOgu5UmnQ7kz1aEzGJGCDBzsF02E2etuDHDJfEndh4JZ5F6fo0TmkFm6C
         51SL4k8HhlVgMYfCeVbIR2DAM5Xhl6UeaMfRlVcVsFbAB3rtAkhn39Qep4LpDIqC6+3T
         dwaHBgT1shIytxptU+OUxcGMvXqUBnvmUWozXJoTnM5EG27w3tZqgJHnXFumBg4N4CwB
         vlZw==
X-Gm-Message-State: AO0yUKUueM1GZaNBj+tRSuui7XTSyZQ+H7masbuwRKwiNAyayVd1A1HT
        +x9HPgGTpmbiieRs3DgQeRA=
X-Google-Smtp-Source: AK7set9SuQ0AOlZ1zc7C0byxOux2y+v0hR+O7KZZvVydEwsFnjb+4DOp3GVQQK7F6g3bXCqz65vwnw==
X-Received: by 2002:a05:622a:15c2:b0:3bf:db42:777f with SMTP id d2-20020a05622a15c200b003bfdb42777fmr16599569qty.0.1677748718118;
        Thu, 02 Mar 2023 01:18:38 -0800 (PST)
Received: from localhost ([45.61.188.240])
        by smtp.gmail.com with ESMTPSA id n19-20020a05620a153300b0073df51b5127sm10505174qkk.43.2023.03.02.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:18:37 -0800 (PST)
From:   Jeff Pang <jeff.pang.chn@gmail.com>
To:     evan.quan@amd.com
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Jeff Pang <jeff.pang.chn@gmail.com>
Subject: [PATCH] gpu: amd/pm: mark symbols static where possible for smu11
Date:   Thu,  2 Mar 2023 17:16:14 +0800
Message-Id: <20230302091614.62093-1-jeff.pang.chn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I get one warning when building kernel with -Werror=missing-prototypes :

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:1600:5:
error: no previous prototype for ‘vangogh_set_apu_thermal_limit’
[-Werror=missing-prototypes]
int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)

In fact, this function don't need a declaration due to it's only used
in the file which they are.
So this patch marks the function with 'static'.

Signed-off-by: Jeff Pang <jeff.pang.chn@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 016d5621e0b3..24046af60933 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1597,7 +1597,7 @@ static int vangogh_get_apu_thermal_limit(struct smu_context *smu, uint32_t *limi
 					      0, limit);
 }
 
-int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)
+static int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)
 {
 	return smu_cmn_send_smc_msg_with_param(smu,
 					      SMU_MSG_SetReducedThermalLimit,
-- 
2.34.1

