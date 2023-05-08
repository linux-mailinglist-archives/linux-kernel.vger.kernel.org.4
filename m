Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7442B6FB37E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjEHPNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjEHPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:13:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEE7C1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 08:13:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f24d4900bbso1638216e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683558823; x=1686150823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k2NhpEht6/YcxE5v+acQwgEzjbdaWwnCz06L3qNmxkA=;
        b=DDKTap0L3LTjkBLPSZKpyFRcYXZcgt6wXyhHzFxSrPKOWksrMR+wAz9r0o9TnP9vaf
         a3EtL0MerHyp32m0Kqi5I9kX0g8bOxMWZUnzib6Hmfyo97MShejspCiqup62tl8u9FFr
         8Ch1HwNK/kVZmLFkFYqaYRUZtufPqo/yiKAz1HRTV6GWcoek7MhrkqlGfj6+rV/oONAP
         8W5Tbqbtl+dQ0wY+clvnITwRJ5lFzJPwQiE5YNzu/jOlRSfBnUz92lAjCgXYBjOZBkRh
         DdIvC0edzOnSZlQyn9Ovx/GTLpcvjQxpAsE2WKLAPoVewA5plobvV+8b5vEXU4c+uWjr
         Z19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683558823; x=1686150823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2NhpEht6/YcxE5v+acQwgEzjbdaWwnCz06L3qNmxkA=;
        b=l66FKMz71moBYb2hOHZmADJ1hpnHkLQvtd18hagYVl9JYCq42xo6GgIiU0957jb8qb
         gr1E3ivUBmb6QU+7Z47FW5CJtNIx/TK3LKMWSl2sEGrCglu+LvPTWDbHnRTM2pg6//Fl
         XxRZMEzPAPw7EbxJutkBWvP+qLNDh5GpNQJKk9nGqO5EMC7xSAdm7X2rrOcvI+cs2Xyw
         mHUk5y6TjbTC75bNMGPpKTkVx7XiDUWfYMaX6albbFj1CW72q87FIsCXU9zEvMmS1tbk
         ees2DQWIp/Dv0YaMcDov2n6IeBfEcC1AyH8FBK2D6sK9n1iJalHvNBfM5RJdzj+iUm2l
         zNFw==
X-Gm-Message-State: AC+VfDysYuX1odbxIfnDSzxliIgqAZfbTE2x0SFcFmSqTUMW0kC+QMhy
        OmgP5EbYi2Fb7q0kbTEcpOiraQ==
X-Google-Smtp-Source: ACHHUZ4t26ala4hpP3P4kURPg8VBzKcb6+939tj0XOVg0YVmxyIV0y4qA7mtxpbw1UTqtE375/Bi+g==
X-Received: by 2002:a19:f004:0:b0:4f1:223c:dc83 with SMTP id p4-20020a19f004000000b004f1223cdc83mr2477949lfc.48.1683558823069;
        Mon, 08 May 2023 08:13:43 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id s12-20020ac25fac000000b004eff32d6a21sm19641lfe.121.2023.05.08.08.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:13:42 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, joneslee@google.com,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] ext4: remove superfluous check that pointer is not NULL
Date:   Mon,  8 May 2023 15:13:37 +0000
Message-ID: <20230508151337.79304-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If @buffer is NULL, no operation is performed for kvfree(buffer),
remove superfluous check.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 fs/ext4/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index dfc2e223bd10..6778c6eb6e30 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2676,7 +2676,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 
 out:
 	kfree(b_entry_name);
-	if (needs_kvfree && buffer)
+	if (needs_kvfree)
 		kvfree(buffer);
 	if (is)
 		brelse(is->iloc.bh);
-- 
2.40.1.521.gf1e218fcd8-goog

