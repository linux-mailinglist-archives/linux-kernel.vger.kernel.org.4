Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608D274189A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjF1TFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjF1TFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:05:13 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B51F19B1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:05:12 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6c3921c8bso2475151fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687979111; x=1690571111;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J5YZzdJQyh4eu5fAj6xameoZPW5lmqQSZHtsSrZxy+c=;
        b=bApBKeIV6L+P7bQQSgdCs8KOomZuQ+P1vVzFbdcBYF5YrlqR1gQpUbDKW+svoxZM5u
         ZMI1O2A432MkFzaG9yEcIzwtnDdz7yUanUYRGGth1TcETQ9nw9TCowrr7KBXzjA4LaTT
         5a9wa4Mx67QZRyBtXHn535wSfV3hKRjiKJ8O6R7VMaIhU8OrO+kbE1JHkq26aLgK220A
         SlOWKQVRIMGY/BBPpmz2qqLFTj6aG1IUWc/dmxZA5aT9ZSYr01DHDkK0pZbIM0b67bCb
         G1p8PRTStaNe7WCI/CTPdXo6fR7CNQGEg7Na2JMDre/uMZseZJCfO5KoSO4gZyFtudW2
         uK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687979111; x=1690571111;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5YZzdJQyh4eu5fAj6xameoZPW5lmqQSZHtsSrZxy+c=;
        b=AMwfXJcVNjcbu/k88LiwXJJ8F9WWoMOT57AuU3O8rUeJ4Df5YnlWyuIVwC5LcEAl/M
         xagh4Ey/xDv8XtiREIowXf8LPicll+W7ILI9m+ZL+hGqTbtr9sjFa1yQ1ii7nXiSt7xL
         G5FRLt1ebDaTrapYsjSLJ8xaytiwaCEiNJTjEnZSG9W1uiF7piB0cltdIpTqNwmi49NM
         LlAre7Zo8J0Yi/5Jl5YzF4s6x4h2zs9DyY2OPvDsDzBh/mCDwO9H7Ah6NmLx5hiXeg57
         cULKuAh2tGJqUl1ArP0Kb3iKbwhePEa+3spnNhDl04p+rg40mF2E4S6j7nbnaof4uu3U
         nLiA==
X-Gm-Message-State: AC+VfDxxAONoj0Zif53o6+KunSb0WGqADlPi2ifZlocbw+EqHt+aUYdu
        eqF9bLSmzN0BFRXDAYNEjAbQCw==
X-Google-Smtp-Source: ACHHUZ4bn9WdqZwlwgpaohN+JH/FskgQr6To+oDImxYoZ8FAbp2paEayyppRUM7Xb7j7v5znECW0yA==
X-Received: by 2002:a2e:900a:0:b0:2b4:6195:bb26 with SMTP id h10-20020a2e900a000000b002b46195bb26mr22432303ljg.25.1687979110797;
        Wed, 28 Jun 2023 12:05:10 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id t6-20020a2e9c46000000b002b6a85a7292sm1102616ljj.19.2023.06.28.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:05:09 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 21:05:08 +0200
Subject: [PATCH] drm/msm/adreno: Assign revn to A635
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-a635-v1-1-5056e09c08fb@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGOEnGQC/x2NQQqDMBAAvyJ77oJJrNp+RTwk221dkCiJihD8u
 0uPMzBMgcxJOMO7KpD4kCxLVDCPCmjy8ccoH2WwtXV1a3vcllUIfeueaIIjS6++a0wHGgSfGUP
 ykSZN4j7PKtfEXzn/h2G8rhsjRnTzcQAAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687979108; l=1049;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yOF2V2vC/eERQ5I69KrybMFDlBclITTn/+Bht2rKkYY=;
 b=T9f2BftsBHUMn+H55F1KeMb0BOE9TuUoOA3jtNlB1lxYTYSv97uLuQMLHUS9T4OyQkR1hib9J
 t+Eg5u6zA8ICDEQPx9CoIlDczwxnK718qaXUbFdux/m3XE4IGEwzpIS
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, a WARN_ON() was introduced to ensure that revn is filled before
adreno_is_aXYZ is called. This however doesn't work very well when revn is
0 by design (such as for A635). Fill it in as a stopgap solution for
-fixes.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index cb94cfd137a8..8ea7eae9fc52 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -345,6 +345,7 @@ static const struct adreno_info gpulist[] = {
 		.address_space_size = SZ_16G,
 	}, {
 		.rev = ADRENO_REV(6, 3, 5, ANY_ID),
+		.revn = 635,
 		.fw = {
 			[ADRENO_FW_SQE] = "a660_sqe.fw",
 			[ADRENO_FW_GMU] = "a660_gmu.bin",

---
base-commit: 5c875096d59010cee4e00da1f9c7bdb07a025dc2
change-id: 20230628-topic-a635-1b3c2c987417

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

