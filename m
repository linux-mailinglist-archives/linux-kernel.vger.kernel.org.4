Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E636D45EC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjDCNgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDCNga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:36:30 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAE4CDD0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:36:27 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h31so17488959pgl.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680528986; x=1683120986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a7N1WSWoZn0JJ7eOsORwGMrwNl3/fBDC6Q3/zMBlJ3g=;
        b=k1bO+o1c5CeXjCUGLxpFwnplL3MFWBVxbpUoZcBKXnGeqGk2BbeugWKbmePaXU8TDn
         JcRN5QBfOiCZ3VzApAAzyro2u27pFYKVmvSfpVxo04tOoIqDhnEd91ApPeBDs7/Ttao6
         pdrDJ3Yl4JQwlX9hh65I5oCZCIJxfWsYttHsPn1j2dntZyy8N8usf0yzrv7Xj2X2RRgx
         oyOVWgGQ+udEXZgd54tvHsB2Ex+kTbLE2FRXkPXMsma7mGBd9tHQxBUDnGCOjxOS+4gM
         5XXqnSlwYWMdarzYzLOowARRfp7w4q4uC0gqHD556eUFgDyu8sCCY2JsL6/GZzilRP1A
         Vdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680528986; x=1683120986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7N1WSWoZn0JJ7eOsORwGMrwNl3/fBDC6Q3/zMBlJ3g=;
        b=CgOvdUVXwxTaDAC8xjCciQrStko5quDwE3yd4mFKey/gUmp721O/EtHG/J4GLm5TPu
         pXBpzYywRsUgeIRL7xWPmsjrj0E4R8494gOeP7Sxuv+Z71ekIs+AlnkXn+nDUFpC6UN8
         uzVDi4578TFFY0tIpgzNFjUzV1Et+oq6QRpn/OBUQn4VScm9W5Ab+LXkyk/KzuL4kDE9
         xFADVeeqf8+gJda4WjWn9/vmykrBDy2xmqUivBdicMx5YnLKy4qANgnb6zIveueX5CZT
         JazVsE9Qi53Ry6ig4gAmvs7og+TJwc96oGBV5WOsEwT16R72kXYn+jbwPOqdLBiOAoRJ
         K8Sg==
X-Gm-Message-State: AAQBX9cZv1oQcUy6C4GB2E8+pW6Nc7VV/hx3TZlRKt6G2u48eU0GDWHL
        mIpVC7GvgYqbW0gCz1JNQQl5PZEjLe1MM88B
X-Google-Smtp-Source: AKy350aSgBmaCUIUvuM/O6IAuSON3DYO21PDfoqt0lSsBOpJz0wHBLR8825IPUN0xBLKIC75AdoNpw==
X-Received: by 2002:a62:790e:0:b0:628:1155:3a69 with SMTP id u14-20020a62790e000000b0062811553a69mr20154864pfc.1.1680528986406;
        Mon, 03 Apr 2023 06:36:26 -0700 (PDT)
Received: from toolbox.. ([104.28.240.148])
        by smtp.gmail.com with ESMTPSA id i17-20020aa787d1000000b00627ed4e23e0sm6978669pfo.101.2023.04.03.06.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:36:25 -0700 (PDT)
From:   Qiyu Yan <yanqiyu01@gmail.com>
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     trivial@kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Qiyu Yan <yanqiyu01@gmail.com>
Subject: [PATCH] i915: Correct description of default value for enable_psr2_sel_fetch
Date:   Mon,  3 Apr 2023 21:36:20 +0800
Message-Id: <20230403133620.42905-1-yanqiyu01@gmail.com>
X-Mailer: git-send-email 2.40.0
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

The default value of i915.enable_psr2_sel_fetch is true while the
description given in i915_params.c is 0. Changing to correct the
description.

Signed-off-by: Qiyu Yan <yanqiyu01@gmail.com>
---
 drivers/gpu/drm/i915/i915_params.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index ade744ccc..fa9ddcbe8 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -119,7 +119,7 @@ i915_param_named(psr_safest_params, bool, 0400,
 i915_param_named_unsafe(enable_psr2_sel_fetch, bool, 0400,
 	"Enable PSR2 selective fetch "
 	"(0=disabled, 1=enabled) "
-	"Default: 0");
+	"Default: 1");
 
 i915_param_named_unsafe(force_probe, charp, 0400,
 	"Force probe options for specified supported devices. "
-- 
2.40.0

