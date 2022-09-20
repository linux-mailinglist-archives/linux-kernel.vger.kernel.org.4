Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C43F5BDD67
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiITGhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiITGg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:36:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB795AA2C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:35:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id jm5so436262plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=1w2FoXD/D84E4uId7V6otTfMc/siOHJMEbdjZCWmVQE=;
        b=nX6kX11S3z8+LJuWsnbGzwCHtLr3LAeddNwLT7EL/R0GRHzdaTd7qe62REc6g/5IiR
         2oUhvpfXk5SpcOeTONQXWO2or6rRg6AUj8oriXlGCWcDhwYi2IUrO1IxIepjKdcg94Mi
         U4qHTCkhmcXnZ6QJsjBeOqVvJgPazGwdhEcVmVj1aBBtEmIuWS9GNR/pkYofYKimRctg
         riqi/I6SQlOxaeMuLdlEz644KshLgB4aRdf9bNvhNbDrSVGJZAOw9h5GjobDC4TWO/CQ
         ETrBBRFyP5WYUBft6Syyw3oC4hiA/7zOzPLHCHoEPWJI0BqiXLbiGqiP5SlD6ShTZD5l
         Asdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1w2FoXD/D84E4uId7V6otTfMc/siOHJMEbdjZCWmVQE=;
        b=noC/Fz36RJNXUbisEtg9KC9aiQtMkjldMC0OQF+QFSDYOQ8ZyoMhzzYiaHLLO7MUNI
         x6q1EZTZOnh48DtpK6cLCGU//slxSnVp/gTAPSUGeEukeO64J8RwFPBlUa5dvE8NPdfa
         o1++mIQ+rTrI6e5MPNB8WVbNr9SiPL/yJF1mVzUMGsZTPh3PHibWA2umo2eiKQynrCTa
         4P4rtZTr7hNVzrAGcdJQGJWgmTyP8KTjKT+MoA3WA1LTcZ/+mEy6hkPQnz1mPw3iK0Ir
         Ykad6jsrm/suEa0T5o6h5JsEy+4svEusSZ1M9iKKpzKIcGlGE0heK+P7co1LSIM4X1Ik
         QZRQ==
X-Gm-Message-State: ACrzQf3813psTeOvDKsCHT1NVtGZBcsPqxqp0N4KC/X6gY5hCK6Lqg8+
        sjWmOFaBV38/NAHusQaeunA=
X-Google-Smtp-Source: AMsMyM51Pi43Dc1ZYoqtfTvn38npskOu+AoDg7unRGej6tmsmu2fJmbEtLy3dbmnwg8bDqJ5dnogWg==
X-Received: by 2002:a17:902:db0a:b0:178:2636:b6de with SMTP id m10-20020a170902db0a00b001782636b6demr3434799plx.58.1663655709167;
        Mon, 19 Sep 2022 23:35:09 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b005409c9d2d41sm629444pfh.62.2022.09.19.23.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:35:08 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     evan.quan@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/amd/pm: Remove the unneeded result variable
Date:   Tue, 20 Sep 2022 06:35:03 +0000
Message-Id: <20220920063503.215199-1-ye.xingchen@zte.com.cn>
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

Return the value append_vbios_pptable() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c  | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
index 1e79baab753e..bd54fbd393b9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
@@ -195,7 +195,6 @@ static int init_powerplay_table_information(
 	struct phm_ppt_v3_information *pptable_information =
 		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	uint32_t disable_power_control = 0;
-	int result;
 
 	hwmgr->thermal_controller.ucType = powerplay_table->ucThermalControllerType;
 	pptable_information->uc_thermal_controller_type = powerplay_table->ucThermalControllerType;
@@ -257,9 +256,7 @@ static int init_powerplay_table_information(
 	if (pptable_information->smc_pptable == NULL)
 		return -ENOMEM;
 
-	result = append_vbios_pptable(hwmgr, (pptable_information->smc_pptable));
-
-	return result;
+	return append_vbios_pptable(hwmgr, (pptable_information->smc_pptable));
 }
 
 static int vega12_pp_tables_initialize(struct pp_hwmgr *hwmgr)
-- 
2.25.1
