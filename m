Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6E06CBA84
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjC1J0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1J0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:26:19 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E766D3594;
        Tue, 28 Mar 2023 02:26:17 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-53d277c1834so218115697b3.10;
        Tue, 28 Mar 2023 02:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679995577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ET0WBr8YKj1eA2HA94tcZdb4WGxsEVdQEBVDSPWcXmw=;
        b=ppqY09tR5sm5z/8am1ZM/TA22i7RRKVosNObZmQENqBuGmq0qFa3z6+AU30BDAWaRH
         T63QvKfFrfHG1qJRPM1WwUh6BFifu9+IY7NUIZDUShGEbQAAQUw73zQc/vtEdc9wCI7H
         xulnhBsPInc/baHhMI8TX7vRk/XxAX6vkJ3IXXIxHlVVF9u8Oybr7n9gShKedxdmVWDS
         8VRyybuct7TJUyoFc1GcZpsk33fQvGLwSexTKr02icIJhD03NJCMpc6ZdYZy26Lo/CGs
         Z5xJ96oXOPDg47iISpBvR8yIN0Ame90ncVHPzeg9fzf9irtVmlZ/Eh3gZf/W+HRToGXH
         qjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ET0WBr8YKj1eA2HA94tcZdb4WGxsEVdQEBVDSPWcXmw=;
        b=yM7ejoU+xDXIZESefbUnTcsnnWk5MOI+IVEHTBDiy5GqfeY4Hldj70mwFHQMvmHlPp
         stEIlYG9CV7nHHGPPQsSyOzVVo94OZpYJBUZkrpCzHf44sZMPNF+xLHbNk/+awvaFQCN
         QrlJJUIPyjAgAtbqixbRAyhXhsioreISZqlrB+bLf/jPwPVMjy22FexiV0dIc1+3HsrT
         iGjNNxK+R4ftyxw3nMBmyR1ehYrQhBxU88ic2sO8qHvQ0Y08iowjp60yEonq3ZlOZGZ4
         lb9wUfWwvqZMKkCt1ozJ/KUjv8RwybJctlgMApPTKTnw1MHWnPYrxIwt2Jz8CBz7yal/
         ijSw==
X-Gm-Message-State: AAQBX9cg7MJvBJoNxZYLaOphVMJLm6QJzGi528lqFvERFumXNfhSkunc
        fiEYwFL4ifL29Th5iIpb1/c=
X-Google-Smtp-Source: AKy350YCbe1C6CuK51osRGy+cn0oCfy2X0sSC78oKe+SrwmzPgwW20fbW4MMNHKDKvLhSihDW1AmGw==
X-Received: by 2002:a81:5b45:0:b0:541:a189:bc74 with SMTP id p66-20020a815b45000000b00541a189bc74mr14986512ywb.41.1679995577070;
        Tue, 28 Mar 2023 02:26:17 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id a67-20020a811a46000000b00545a0818482sm2328586ywa.18.2023.03.28.02.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:26:16 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     tiffany.lin@mediatek.com
Cc:     andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] media: vcodec: Fix potential array out-of-bounds in vb2ops_venc_queue_setup
Date:   Tue, 28 Mar 2023 09:26:08 +0000
Message-Id: <20230328092608.523933-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable *nplanes is provided by user via system call argument. The
possible value of q_data->fmt->num_planes is 1-3, while the value
of *nplanes can be 1-8. The array access by index i can cause array
out-of-bounds.

Fix this bug by checking *nplanes against the array size.

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index d65800a3b89d..1ea02f9136f6 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -821,6 +821,8 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
 		return -EINVAL;
 
 	if (*nplanes) {
+		if (*nplanes != q_data->fmt->num_planes)
+			return -EINVAL;
 		for (i = 0; i < *nplanes; i++)
 			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;
-- 
2.25.1

