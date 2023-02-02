Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB0B687A47
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjBBKcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjBBKck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:32:40 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9CB37F1C;
        Thu,  2 Feb 2023 02:32:39 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q5so1298433wrv.0;
        Thu, 02 Feb 2023 02:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EejFREaRcGB12MROc0EjjXorli5U5zGmeKKwC+PD69Y=;
        b=lkaOghGgKEQfqkgsXwmtwNQu620B8HWmBvHbt38srdgUNTDNN05Th8aLCqnBgb6VAx
         ua3g8NumFJ08kJCBV0N0auJgpyo2Ffg7eNGBbDVcTIrq4jrgLp85fG2Xeb31asM3TY1l
         q+TpSafFUrp0VhfvO0Vxx8r/JXY25T6ZFLFMILS6LVaMGBCFsR7ozAfKqwGpXdzFDVjO
         it2+korIam7YnPh0UMeXmgAzG7r2YeaYZ6OB2J44ieMxlWhY0QlrCaxPVqIHh8ykkkx4
         ikYVQNH46nff01C71lhV9E8qavSMde/Yd2940+5AoHarT41x1KG6U2TRDU/zxKdFprOh
         q9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EejFREaRcGB12MROc0EjjXorli5U5zGmeKKwC+PD69Y=;
        b=DjUvWCrPADrQyd8rVA4+ujrJ0/6RhBkxqF68rlCVxjpJh6YlLfFwuxom2SLMhi3K+Z
         +VDaw282dVi60jBziKVi/yZAAuedSc5iaorDX+TQoacMgpKH5jIkUkcgoTpilnIu3vzf
         nY/ulmpdDYQhpt9viOnLPx+F9A3mDimnMLw9sDXSnxxmxqi7BUou4hRWM7vuYlDJjGuZ
         slG53kHAjZJq4WrdTsKj6WIrDT6dG5boOvJIcyybASCUhcSoBJX/N7jRQ7gQEns/qAaq
         TXQjoKPLlkscpjSJ3+OS97c7wJ715VsxCTUyvLUp4yAVQIRG2PWN/CLdHnUzUrDKw3Eq
         6aww==
X-Gm-Message-State: AO0yUKXyjiYiksYi+26Um3sMouZ4CZ1/+VB60XfMvajI2Gc0S1zwTvcr
        ncysL7Yw5DZf7dxvMd2HaU0=
X-Google-Smtp-Source: AK7set8HdyNKLMuUjW2H8YE/xzHf42PoOyS1nBg2jpeu/DVWNlu8unfSe9+oQS4qNg3TDRb9x0a4og==
X-Received: by 2002:a5d:5984:0:b0:2c3:bbfa:d509 with SMTP id n4-20020a5d5984000000b002c3bbfad509mr4366725wri.61.1675333957908;
        Thu, 02 Feb 2023 02:32:37 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h4-20020adfaa84000000b002bfbf4c3f9fsm19533001wrc.17.2023.02.02.02.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 02:32:37 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Bruce zhao <zhaolei@awinic.com>,
        Weidong Wang <wangweidong.a@awinic.com>,
        Nick Li <liweilei@awinic.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: codecs: aw88395: Fix spelling mistake "cersion" -> "version"
Date:   Thu,  2 Feb 2023 10:32:36 +0000
Message-Id: <20230202103236.270057-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There are spelling mistakes in dev_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/aw88395/aw88395_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/aw88395/aw88395_lib.c b/sound/soc/codecs/aw88395/aw88395_lib.c
index 34ae405bb43d..64dde972f3f0 100644
--- a/sound/soc/codecs/aw88395/aw88395_lib.c
+++ b/sound/soc/codecs/aw88395/aw88395_lib.c
@@ -890,7 +890,7 @@ int aw88395_dev_cfg_load(struct aw_device *aw_dev, struct aw_container *aw_cfg)
 	case AW88395_CFG_HDR_VER:
 		ret = aw_dev_load_cfg_by_hdr(aw_dev, cfg_hdr);
 		if (ret < 0) {
-			dev_err(aw_dev->dev, "hdr_cersion[0x%x] parse failed",
+			dev_err(aw_dev->dev, "hdr_version[0x%x] parse failed",
 						cfg_hdr->hdr_version);
 			return ret;
 		}
@@ -898,7 +898,7 @@ int aw88395_dev_cfg_load(struct aw_device *aw_dev, struct aw_container *aw_cfg)
 	case AW88395_CFG_HDR_VER_V1:
 		ret = aw_dev_load_cfg_by_hdr_v1(aw_dev, aw_cfg);
 		if (ret < 0) {
-			dev_err(aw_dev->dev, "hdr_cersion[0x%x] parse failed",
+			dev_err(aw_dev->dev, "hdr_version[0x%x] parse failed",
 						cfg_hdr->hdr_version);
 			return ret;
 		}
-- 
2.30.2

