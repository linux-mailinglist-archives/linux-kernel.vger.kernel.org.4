Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB60060B365
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbiJXRFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbiJXREg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:04:36 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC90CA8A0;
        Mon, 24 Oct 2022 08:40:22 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso12274660fac.6;
        Mon, 24 Oct 2022 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf1QpnlooM/EzBO71nDJaALY4Af30m+RUToV/sEcQc0=;
        b=YWb/8dOxbdWFi4W7XwLCdMiy/5vsnQT8eIL9iFMK1j1zGHbcH8zlhIrf2maHvqZxWd
         oXNooHcb+yWL1U45waazeowROIGQd7Opoztx9JkTr5CXm7YXwfkNq9uZxy19vgCpYoZc
         +D6jAY30f5t9XUbRvHErE3uyr92pqndnuW3B+graI/nmQAZZzZtKSSo5ZeBdMEdJjnZa
         IkqKtQ9YM2lhnJpZcwB6vcZpn0138OfBhnxoj9zBFEcnowyJ1GIHob6C7oUe8PAzCUOV
         shDXtPOYUIy8/3fp5UcXXxnQbWXJhO81EVz0OLw9904X5s1+AQvgnFws0JLZjCJXOJD/
         +FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xf1QpnlooM/EzBO71nDJaALY4Af30m+RUToV/sEcQc0=;
        b=xC+aEI6jMN01pDb+ydbBfvleuZlw4x0Ez/M6l5q6GRMsvB4h6TVr/fnhHquhXZc3NA
         2te+LBNTPLdexYcYqwLC+kyClqDS1y0tLqki4ZnqdgKiDZS2DeCnEQA2+YhfQTGVS9cA
         vTUIUBUTneDLtOhk8jahIkXRfFSEMU5bKlnMwDnx4nnUJvrFzjzfoS0RppCvdUsWBG1i
         59EdYTH1oTEdsdWutGHZ4UJEZqhtTqgYR8fnt7MlPI+wlwZ8EfPEN8K3Zw2z/9NIsyeA
         lvvDRAv5Lp5JypwhWWDy9Qgd2Z4WW1KVQCXv4nys+AC3FrXkXT+q87G5w6R4M9NIXQqI
         7mNA==
X-Gm-Message-State: ACrzQf2yGSqm1EBiffF66g7mb8MXKE+vhYnf8wdxcFMXQq50Ad7KFmba
        gI5tOEjzTB+HpDb0gofjon968UK6ChE=
X-Google-Smtp-Source: AMsMyM5RpJNF3gJeZ9+k4mWvaTefhcNVEdR3otp/3VizCshKQP+5vqFHs/wyK0UugSqNcNfbJ+mZvg==
X-Received: by 2002:a05:6871:112:b0:13b:99e0:2be3 with SMTP id y18-20020a056871011200b0013b99e02be3mr4297213oab.299.1666624105441;
        Mon, 24 Oct 2022 08:08:25 -0700 (PDT)
Received: from gabriel-Nitro-AN515-54.. (201-27-204-68.dsl.telesp.net.br. [201.27.204.68])
        by smtp.gmail.com with ESMTPSA id e18-20020a056830201200b00661ad8741b4sm4532583otp.24.2022.10.24.08.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 08:08:24 -0700 (PDT)
From:   Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
To:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
Subject: [PATCH] staging: media: imx: imx7-media-csi: Fix parenthesis alignment
Date:   Mon, 24 Oct 2022 12:07:44 -0300
Message-Id: <20221024150744.72641-1-lima.gabriel.luz@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: Alignment should match open parenthesis

Signed-off-by: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
---
 drivers/staging/media/imx/imx7-media-csi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index cbc66ef0eda8..9ad7205a3f2f 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1704,7 +1704,7 @@ static int imx7_csi_init_cfg(struct v4l2_subdev *sd,
 		mf->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(mf->colorspace);
 		mf->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(mf->colorspace);
 		mf->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(!cc->yuv,
-					mf->colorspace, mf->ycbcr_enc);
+								 mf->colorspace, mf->ycbcr_enc);
 
 		csi->cc[i] = cc;
 	}
-- 
2.34.1

