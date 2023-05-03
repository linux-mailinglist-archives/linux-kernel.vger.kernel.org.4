Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF176F5260
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjECHyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjECHyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:54:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569F33C29;
        Wed,  3 May 2023 00:54:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso1411219a12.2;
        Wed, 03 May 2023 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683100455; x=1685692455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wLmnpSio5vQ/EjDA+3lL/g42L7mPofPw3du+/1V3GRA=;
        b=mIBzN4ZIAx7HPJqQiAyClDVA/HOCx83EqaqYx+sdN4d+Fp52SbCzYEcYtX1TguFL35
         AJ21+5v2y9q5PFnJN1Bdw0IlXl6majlUtlw7eDfgl9HKY5oghtQnZP0WEfEW2n0xW0Jd
         W+Dh67lnwjLL+mYtVOs1CJqZZq8+wRKDyuEFDsHW/wNwnMorP4n3XNicuLH1fgecifjG
         ao/gVRcGaGuZiuq0nOWh+8+nP5e53LN/tCMxOAwo22RdH4mvttz+T69uL23cHJFue/Np
         lQZzuga2+vHyt+6hSzCKGLMKlVqzjdWOEYg5xzJufE/nFQED62qcGfV5b9ydWNemZ3bv
         Z2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683100455; x=1685692455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLmnpSio5vQ/EjDA+3lL/g42L7mPofPw3du+/1V3GRA=;
        b=X8xYsX//FLL4nbMwp6HVamrliXlRXlQ2O5dJuxE9rXdwnIkfAnCFw7766wrfMqZ1EZ
         7FC9LjKsj8JPapbvLz2z4lT+z+nwu/AY3UDRS7y3h1x36DIfIsxN0wpraombBv2OSqmN
         cVH05SQcLNLpC+zRG9XUBURoA1CNWqA3N+XNJJo1hJW0+IP6cEfULQ3Zqp4wvhQF3Yh8
         oXDNWF6qjta5tOolxMUYWM2nasrscvHMVHDH3jSyvoKlOTC5op1Pw1d8B9YE7yGFvveB
         LM6TcnC1fzhRnT3J0AZKV7VDWZgSkfLLKYropP8LeQMEo2h5mdDyJyC7JBz6sE7nlkkq
         VjAA==
X-Gm-Message-State: AC+VfDx44LHaRhfKI+B6W6rwQdHA2zmkVE/TDgmX/TozWOWc8r0lUWCO
        ThJXMtJTf+4Gxu5U9bOlqEs=
X-Google-Smtp-Source: ACHHUZ5ch75iq1id6BgZJ9+L0KYzDCi6DHl5EyT8lz8i+s23JiM4bvG0YIdKsa/1x4rH1eC6XaVD/g==
X-Received: by 2002:a17:907:31c4:b0:94f:e00:c8c9 with SMTP id xf4-20020a17090731c400b0094f0e00c8c9mr1765803ejb.34.1683100454508;
        Wed, 03 May 2023 00:54:14 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b009571293d6acsm15815339ejc.59.2023.05.03.00.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 00:54:14 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: camss: camss-video: Don't zero subdev format again after initialization
Date:   Wed,  3 May 2023 10:53:40 +0300
Message-Id: <20230503075340.45755-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.0
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

In an earlier commit, setting the which field of the subdev format struct
in video_get_subdev_format was moved to a designated initializer that also
zeroes all other fields. However, the memset call that was zeroing the
fields earlier was left in place, causing the which field to be cleared
after being set in the initializer.

Remove the memset call from video_get_subdev_format to avoid clearing the
initialized which field.

Fixes: ecefa105cc44 ("media: Zero-initialize all structures passed to subdev pad operations")
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/media/platform/qcom/camss/camss-video.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
index 898f32177b12..8640db306026 100644
--- a/drivers/media/platform/qcom/camss/camss-video.c
+++ b/drivers/media/platform/qcom/camss/camss-video.c
@@ -353,7 +353,6 @@ static int video_get_subdev_format(struct camss_video *video,
 	if (subdev == NULL)
 		return -EPIPE;
 
-	memset(&fmt, 0, sizeof(fmt));
 	fmt.pad = pad;
 
 	ret = v4l2_subdev_call(subdev, pad, get_fmt, NULL, &fmt);
-- 
2.40.0

