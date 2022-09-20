Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD185BDD6D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiITGhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiITGgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:36:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76875E540
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:36:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v1so1410483plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=DcE48FGDHv0yOSzbYjt1rNc9RDHXJDR1T2QYo0htzd4=;
        b=WfeSzzwjMlC1h/a8WfNvTmDa7ZVJvLPJO0rI2MnM0B5LsKfBrO7f7AfHe3L6gj0REV
         SagG+yVOhfjjKM8Y8I/9UnLYJNTWBIbNjo3LhfNA/69g7+k0PyRa2JWiSz9Howjc8BqQ
         cXTF60pxTFPfH1ivPQUBfdvqTJzuBQY7tBRwNOgGcabhmNrDBKzXQk+f5bxlwQoJx/gg
         H19nu/PHjwtk3VR6nDqM5fQ73dYzbhJyxWr9yRgdHoZAomNqcsTxNNqJ08KJshfC5AAt
         D3Fh9GTelOxInr1eevycB2gmafxEEZTMx/gdYo/6tUqBycmQamYBKTR+cJ78oPImHXnf
         W5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=DcE48FGDHv0yOSzbYjt1rNc9RDHXJDR1T2QYo0htzd4=;
        b=L2iXLIgkh6OL2c1/Bu/1N01j82tQknzjHDZ6OgRsuldOaaCnT5MdXBY/THZSmlm8N2
         WIu+00M3IVRA+Dm7nXu8ZevIh7o2P71X5JzB8BJppTqWlVNlqnsa/09ij4zbC33W/Fnr
         wK35NeoiZLVkp0R6n4V7EAGts/oKzyPB7ui0vHQkxJNN7r5lq8rqczIt7cJQBXayyzLY
         JkkdfWogV08dtZXH7cbYp757n6IMkL6Ljy+WEC4FyaExCFn40gjnmyEil430MNVZ7zFl
         MFGthc+CXfm9TAW4YdN0bmEFVg2GMPhjIJGxWkxdcGGIUjFzminWgTmla3YFJjRNP18x
         V/RQ==
X-Gm-Message-State: ACrzQf3tu0FDw3rdacBAZOuKiwExDWTpkG9lpDbOixO9ID642Psd22fO
        LBLSoa7vRY6uYP6cphyVHq0=
X-Google-Smtp-Source: AMsMyM4qpv+0B2J9/SDVZwkIT7eEtZIA5rLG3v1vSQ1E5LYdzYonEiVCQe3nrzq/M+cjqfWD0br5Nw==
X-Received: by 2002:a17:90b:2bd3:b0:203:1a03:6b1b with SMTP id ru19-20020a17090b2bd300b002031a036b1bmr2203013pjb.58.1663655765249;
        Mon, 19 Sep 2022 23:36:05 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i13-20020a63220d000000b0042c0ffa0e62sm611172pgi.47.2022.09.19.23.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:36:04 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     evan.quan@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/amd/pm: Remove unneeded result variable
Date:   Tue, 20 Sep 2022 06:36:00 +0000
Message-Id: <20220920063600.215257-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value atomctrl_initialize_mc_reg_table_v2_2() directly instead
of storing it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 45214a364baa..e7ed2a7adf8f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -2567,15 +2567,13 @@ static uint8_t polaris10_get_memory_modile_index(struct pp_hwmgr *hwmgr)
 
 static int polaris10_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
 {
-	int result;
 	struct polaris10_smumgr *smu_data = (struct polaris10_smumgr *)(hwmgr->smu_backend);
 	pp_atomctrl_mc_reg_table *mc_reg_table = &smu_data->mc_reg_table;
 	uint8_t module_index = polaris10_get_memory_modile_index(hwmgr);
 
 	memset(mc_reg_table, 0, sizeof(pp_atomctrl_mc_reg_table));
-	result = atomctrl_initialize_mc_reg_table_v2_2(hwmgr, module_index, mc_reg_table);
 
-	return result;
+	return atomctrl_initialize_mc_reg_table_v2_2(hwmgr, module_index, mc_reg_table);
 }
 
 static bool polaris10_is_dpm_running(struct pp_hwmgr *hwmgr)
-- 
2.25.1
