Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3871F6E75D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjDSI6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjDSI6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:58:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD004C0B;
        Wed, 19 Apr 2023 01:58:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g6so11234752pjx.4;
        Wed, 19 Apr 2023 01:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681894686; x=1684486686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3zpvMjDc8PUDIFIffBUt+CiFgxX1fPBud4Kt6HqJXz8=;
        b=UtlW7QeLG94NWEB+dlWHbmjRnFYxbJOyvIGIfJLxjiZJWo8SZyBMKGSu71KsdnwYkM
         5Embc4NaJ3SRopVgqDxHW19iPNF3jiDTDgNow4AnPZhfVsPAXcYRUDzE1Vg8kwHbGJUD
         Jul3ZOIWXSqS2g+Yx3G3JGBEeRD5s3faZmYLtYfgoeuGOtaIwe0inEdi+yDJ2XrC4o8H
         C6Fmym88uYZ4psi3ZY8pPDaFiFCq2RZWCtlWPWIPlglDjw9gTAEpgU/1MgyiFw6Rw5Y2
         F0XB+yzdy9HPo3WvfTOqm4b5GZvfeXDVeSU9m4fgJCGIpN5Emu8pXWkG/fnCjF7VARx6
         /heA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681894686; x=1684486686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zpvMjDc8PUDIFIffBUt+CiFgxX1fPBud4Kt6HqJXz8=;
        b=QUESDNMuoJr9tIGOtV90fWczd4JWggk6X/fNPw+6jhCIBJGcmimF7LT0uz+Bs86uJO
         qh52vQStPXUT32TaXtA22u7fLQmAQeno2LqHfY8VZZ7CdHkIJw1U3jYxBge/pBFpMOCL
         lrZhCIYKYNGd8Pj5w0PnsKEcr74RS9eZVRr52u5LtjC0C2J/6xReYI9Sz0eamryjJnm0
         JiscFjeoPftJGPs8GZKJEI0ElnU8ufDSmM5ZBxWKQCv4FyEddLUx5QJoUEc3VSZcKqcw
         53uOPuXUPQcUXYZTI3/C82nT2Hq5eyLxR7zP5SCUkZPL+6cmGrsePhhcZZdQ7DQFrlih
         qp0g==
X-Gm-Message-State: AAQBX9esrGA2VQ0VbH81qV3S/f5+oABxAy4pAGGPimF/LouYXCsmcOvI
        QnQCLJC5v7solFohwlJBjzc=
X-Google-Smtp-Source: AKy350ZsGA0KS7CsW/PhUED2oIMNWfU0ei4iNIRQe4Ug65OBD1ljL1KiruI2NorA2j6a8NNhWpDYRA==
X-Received: by 2002:a05:6a20:5493:b0:ef:ecaf:ff6d with SMTP id i19-20020a056a20549300b000efecafff6dmr2062989pzk.12.1681894686508;
        Wed, 19 Apr 2023 01:58:06 -0700 (PDT)
Received: from hackyzh-virtual-machine.localdomain ([58.34.53.146])
        by smtp.gmail.com with ESMTPSA id r10-20020a63d90a000000b0051b72ef978fsm8144902pgg.20.2023.04.19.01.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 01:58:05 -0700 (PDT)
From:   hackyzh002 <hackyzh002@gmail.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, sumit.semwal@linaro.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, hackyzh002 <hackyzh002@gmail.com>
Subject: [PATCH v2 1/2] drm/radeon: Fix integer overflow in radeon_cs_parser_init
Date:   Wed, 19 Apr 2023 16:57:47 +0800
Message-Id: <20230419085747.4720-1-hackyzh002@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of size is unsigned, if size is 0x40000000, there will be an
integer overflow, size will be zero after size *= sizeof(uint32_t),
will cause uninitialized memory to be referenced later

Signed-off-by: hackyzh002 <hackyzh002@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
index 46a27ebf4..8e12b406e 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -270,7 +270,7 @@ int radeon_cs_parser_init(struct radeon_cs_parser *p, void *data)
 {
 	struct drm_radeon_cs *cs = data;
 	uint64_t *chunk_array_ptr;
-	unsigned size, i;
+	u64 size, i;
 	u32 ring = RADEON_CS_RING_GFX;
 	s32 priority = 0;
 
-- 
2.34.1

