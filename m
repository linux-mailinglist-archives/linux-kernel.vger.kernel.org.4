Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B46CD3F6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjC2IFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjC2IF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:05:27 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E4B2114;
        Wed, 29 Mar 2023 01:05:21 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5456249756bso279016747b3.5;
        Wed, 29 Mar 2023 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680077121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nghk3fxsfft5bLKjR6qNTwc/77bFbrdVB/T8jga+IXE=;
        b=m/wB8IYx1klF5QHZlk3xM0LIUXYrS0g0/6SG2q5BTrkPUi98dq+nBRoCIgz9BDZhWq
         xEkPB0O7kO8Ki1ybClCLtpMw1e6m22u4NxTarJJnOMjLCTV2TCtb+yTH3TNDNTRNQC3n
         xsiIQ2BjHgR9zNPmQP/ac2LjzUZrJfaHThdJpSFGY5Q7hlaebD53Dz3pU1vl34AmEUwM
         jUuSb3rdgUR5Qubu5oPTpPrZYfVMya4VyOSZAMwRoYAXP+1teQZwPE2qPo3QDvFWaBVa
         T9uYWun5rPauglIrrnu2f1VA1POO+P3jZkroqeHXI5ynRPv6dcq9NDphCm2W7UHkJP9t
         CPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nghk3fxsfft5bLKjR6qNTwc/77bFbrdVB/T8jga+IXE=;
        b=f/UTa9LkJOVEsR4eNuu91hR72tv9t+BJ72/bL4q+dBOEYZ+jF2TV7msJ2Jno9Er4sW
         IEZNl49GTdd9Yve6Zv9l2QukcQ3M2yysArv6D5WaajxZV7U++6jWojLUgc7jfBSJWOXz
         ltKSh0Nhq7FE2HmvkTz2+pKOyknng5///OJ0PnavMtCRpqPIE6oeAoSgx2n24FstPYnD
         HkyTaCBbQBKH7ufapEwknla6nnQMx0whxwt+RYxCERH7402hmvRZizaPHTiO/AkKvPxf
         OzRGp+DAvrb0EiHSQGDuWxR5exnOj23iei0DxFg8WYQ3SRixopsEUCINaW+/7xY0Ecti
         jVFQ==
X-Gm-Message-State: AAQBX9fLxmb8stZvbkobfQ1BtgJbqS7iJ33aQA0QLsRQ1cKMRohMz/Rr
        gaDK1TdrS2QdN2VuV/8zfmg=
X-Google-Smtp-Source: AKy350YEliHm+7GMl+5Gc1UlsBXS9j6nsNRg2RMOr6mxYA6BZNv4Om7iZdbKk23o6a4iQJk3E/3syg==
X-Received: by 2002:a0d:d402:0:b0:544:d3f3:30cf with SMTP id w2-20020a0dd402000000b00544d3f330cfmr20814654ywd.49.1680077121002;
        Wed, 29 Mar 2023 01:05:21 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id 199-20020a8119d0000000b005460251b0d9sm988965ywz.82.2023.03.29.01.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:05:20 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     tiffany.lin@mediatek.com
Cc:     andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH v2] media: mediatek: vcodec: Fix potential array out-of-bounds in decoder queue_setup
Date:   Wed, 29 Mar 2023 08:05:13 +0000
Message-Id: <20230329080513.1127982-1-harperchen1110@gmail.com>
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
Changes in v2:
 - Add explicit braces to avoid ambiguous else

 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 641f533c417f..173407664cf4 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -753,6 +753,13 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 	}
 
 	if (*nplanes) {
+		if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
+			if (*nplanes != q_data->fmt->num_planes)
+				return -EINVAL;
+		} else {
+			if (*nplanes != 1)
+				return -EINVAL;
+		}
 		for (i = 0; i < *nplanes; i++) {
 			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;
-- 
2.25.1

