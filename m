Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B529C64544D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLGG7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGG7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:59:35 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5837E62DC;
        Tue,  6 Dec 2022 22:59:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id w23so16183489ply.12;
        Tue, 06 Dec 2022 22:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URJLtETWn+YZV56sYZN2y9Ammv06Km5wjcz9Xfa36wA=;
        b=lBKqGEScVr/kOYKmMuclGkO9cibboL2kFQ5OW7GPQGtifD5zo2uyHZcJ6yi5AJ4YAD
         NooMxx80w9ItHZM2XHVzTUxK3+UGh+Vl+Y4H8VZYum6RJuL5jTWIQVRZ5axYjsXnrkO0
         QO0EgX2CXhC0MOZvtHfobb/n4Bg+Gu/pQ7E619gb7VORVJnKjTdeLd+i67FMj1hour71
         L7dOkmXXWUsc1YGY7Pz8hFqPGZEtn8PMoDr2VCiq6Mtwy/LUAL5tuFez/d20X06qURi2
         bGBt4UMmlvBQrUHE0RSeqwbpHOjH+Gw6HAQEc0vsN1Mbfgqdzp3bgFE3BGmo9n7b7Js9
         dJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URJLtETWn+YZV56sYZN2y9Ammv06Km5wjcz9Xfa36wA=;
        b=0Iw287yB75oBr8MVh7MDvk8mI8DXrLTNZ331rRdx0lODL75eb8bAP5YYzRpgWBPmrB
         WYSYK2nkNJjlicrkgnrnPboX71+QYwta8SWcBGEVnrhEoCcTLIzGBwUwTdeF+fk/8JaO
         piu8XOLzitKWCLgUt3pukmnVTxa7QYm2ZyE7TkRJexJ+RIb4z5UA4Pbb7jHVgnGP2JLw
         ++tK4SNO2u1AZrUS810Hzwf27kjswNfNMJ8XJap2xkGg1oghbrjPnJskC7LSaDJZPAjv
         Zf59A5mXJwn0gdu3dGU1qZO9Yj66XeMKr5GErqQWwvujGoRKTye8qmpX7JUTBh38+QyQ
         +9TA==
X-Gm-Message-State: ANoB5pkVOByl9X1Jd8L+v1nUmz750ulZTCd3gyME2XgujZl/gjkpsVLL
        mN5rptkF0qOS5m49tbpM+HU=
X-Google-Smtp-Source: AA0mqf6beKWDf3dqOMpuuZAuHED3fpDTatCs+YeGixJMzVPTqS2PO3y/S6m/UXrq7oz9e89qo+0Vxg==
X-Received: by 2002:a17:902:e8c3:b0:186:5de2:e17e with SMTP id v3-20020a170902e8c300b001865de2e17emr76737175plg.35.1670396373706;
        Tue, 06 Dec 2022 22:59:33 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 18-20020a17090a001200b002086ac07041sm472055pja.44.2022.12.06.22.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 22:59:32 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] drm/msm/dpu: Fix memory leak in msm_mdss_parse_data_bus_icc_path
Date:   Wed,  7 Dec 2022 10:59:22 +0400
Message-Id: <20221207065922.2086368-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_icc_get() alloc resources for path1, we should release it when not
need anymore. Early return when IS_ERR_OR_NULL(path0) may leak path1.
Defer getting path1 to fix this.

Fixes: b9364eed9232 ("drm/msm/dpu: Move min BW request and full BW disable back to mdss")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- move getting path1 after error check for path0.
---
 drivers/gpu/drm/msm/msm_mdss.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index e13c5c12b775..3b8d6991b04e 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -46,15 +46,17 @@ struct msm_mdss {
 static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
 					    struct msm_mdss *msm_mdss)
 {
-	struct icc_path *path0 = of_icc_get(dev, "mdp0-mem");
-	struct icc_path *path1 = of_icc_get(dev, "mdp1-mem");
+	struct icc_path *path0;
+	struct icc_path *path1;
 
+	path0 = of_icc_get(dev, "mdp0-mem");
 	if (IS_ERR_OR_NULL(path0))
 		return PTR_ERR_OR_ZERO(path0);
 
 	msm_mdss->path[0] = path0;
 	msm_mdss->num_paths = 1;
 
+	path1 = of_icc_get(dev, "mdp1-mem");
 	if (!IS_ERR_OR_NULL(path1)) {
 		msm_mdss->path[1] = path1;
 		msm_mdss->num_paths++;
-- 
2.25.1

