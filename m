Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877B3631A22
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKUH0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKUH0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:26:09 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D5F2A419;
        Sun, 20 Nov 2022 23:26:08 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 136so10412545pga.1;
        Sun, 20 Nov 2022 23:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1MiOaGlNC43gZkqyEAf4nEibj9lSNJWEeV4vVtbOJE=;
        b=JGYzC6xqmct/PfIsIWjPN63rryv70dobhe3MPkw8h85uVfj85DjOITM2umZT/uEIkW
         fQzlMlsoFaL/uDPE4PT3MotMLZ16xLqfQI5uR/mmqez22GVROEiHybxzj5ET/9EwdImy
         w6dDvpnxM4xgSpoJltBFyuKs6JANcGcU9ycLlLc1Dv6IFuQh/yYY23EIFMymed2xZ7Y0
         7Jcwri8zMp3DyzoqYyU1XNAU39kV0w4zwcexZiV8iY98BSigxr9R/U+PBr+7hyxH9gCa
         KJIS/B2pBx2tY25R8qhNj6MYXUQLJT2ollMY1N+w0dAvPs2UydLM49HJFFwa5pAfhJKu
         Vg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1MiOaGlNC43gZkqyEAf4nEibj9lSNJWEeV4vVtbOJE=;
        b=WLr9P4Kx6ea0nGOdyytLTTLkXiLP/h1Eflko9cPodnpKSMy4jaT3lTkiN28m/Ij3/s
         W+z64A3BVQtF8O+qX38x/wQbe6jH5PMDupqn/ahbi9z+ueGoG1ROLU0YKuAuBlVnn/dc
         D26qm9ZpDYMlaCSVwXScAeJjKWa2gkFQ1IlViNVIaU/qzjQfc8vRaz1I0He38ftv7iWz
         NiEZeDKxAGe/ZeIIa0Mwg+ox9GekKti6pvuO3DL5Lc3dR9SDlkcvXRMI9BNrpCgISqIh
         X5Vf90Ln91+axLLhg7nBnHJytMFFqqDSLVDVtuMq/DFtVmiJLbDfPWU+tOp7sQCo3wN/
         rScA==
X-Gm-Message-State: ANoB5pn4uI/DKhOgF0q4aHf8WuUCpVpJQaD8I+AKwrdLNeeWYq7yNfu6
        hcTUYtt4jDr4zii5+qW8nP3DPI9Qh8uDdaqq
X-Google-Smtp-Source: AA0mqf4FdlwzUnYoZupo+TMdLcrqocwbaFhD1CVO4P3v50a87ag8Ulr8W9ot/Fuo4EzzPkiR+iLexQ==
X-Received: by 2002:a62:f24e:0:b0:572:149c:e278 with SMTP id y14-20020a62f24e000000b00572149ce278mr19200844pfl.8.1669015567395;
        Sun, 20 Nov 2022 23:26:07 -0800 (PST)
Received: from mail.google.com (125-237-50-34-fibre.sparkbb.co.nz. [125.237.50.34])
        by smtp.gmail.com with ESMTPSA id z18-20020a170902ccd200b0017a032d7ae4sm8933920ple.104.2022.11.20.23.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:26:07 -0800 (PST)
Date:   Mon, 21 Nov 2022 20:25:58 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        Slark Xiao <slark_xiao@163.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH] [next] drm/amdgpu: Replace remaining 1-element array with
 flex-array
Message-ID: <Y3soBt1jmXHUKhW9@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with
flexible array members instead. So, replace one-element array with
flexible-array member in struct GOP_VBIOS_CONTENT and refactor the
rest of the code accordingly.

Important to mention is that doing a build before/after this patch
results in no functional binary output differences.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/238
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
This should be the last one-element array that had references in source
code. Given the way it was used, no *.c code change was required.

I will move on to the atombios.h in the radeon driver.
---
 drivers/gpu/drm/amd/include/atombios.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index 4dc738c51771..b78360a71bc9 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -9292,7 +9292,7 @@ typedef struct {
 
 typedef struct {
   VFCT_IMAGE_HEADER   VbiosHeader;
-  UCHAR   VbiosContent[1];
+  UCHAR   VbiosContent[];
 }GOP_VBIOS_CONTENT;
 
 typedef struct {
-- 
2.37.3

