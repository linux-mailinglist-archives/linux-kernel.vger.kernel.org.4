Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1F26A6A07
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCAJrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjCAJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:47:40 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26D93A870
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 01:47:38 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id g3so3681153wri.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 01:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677664057;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1pni8PEkrIGMBG+jXk+bVH6dacln+AXocrU2+hsam8=;
        b=LaJ7npUADITLVfxDj5CjFSESLEac57tU7PrtsB3MDvLyeucQh/8rn4py00CGBOX7Xq
         SI4zCnIpSoOo1D2X0Pmq0nxxf/IEJkIhbB1yULFW78IVzDypBR1iLHPsPNRwtgaMltIH
         3ccxW2i98kJRQMqHIXdGpU4pOUiISZ0W/Oy/DeGLOl5VMFJ4iGgqBsMrmwX588z1c2Ur
         mWH1HBZlav6W+/pIcqZAks0Swjw4azkcFQiAE5lSeAioYadhNEwd6y4HNAVkqqpb0Piy
         2OkSoBbeBtGtU5B0/3tLJPITkeivD7lDgbVpDBbcLwTpgtMfi6Y4rQxq2bXAVEihhpMQ
         AuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677664057;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1pni8PEkrIGMBG+jXk+bVH6dacln+AXocrU2+hsam8=;
        b=y4EsAer9d6qSULG/9AXPwcLAyvZru3o56Zme3psUlm7r6cc1qfcIqrujIc9LFyD39B
         zSpjka+sjXh1txd9CyCSJQP/NwdeSh7BZMGctpNrXNtMEXmBeBeCMEwZTycrDeSBoXFz
         H5ONqEVN5dKhnT7vhV33cTSOnsOwuA7f5nq8G8HPJHD8yNj+fHWJyNnjQWnYRu7oYaqn
         +MIfvjUWe7JW7HGkfya75LbnmRdTB1Kbe2g45xb5joSolNgMof7hQde1DA5No2zIkhQ5
         B4QY/t8AwuvXWpWC++6K6hKY4liTVNCza3+nr8EHSmqr+UCtd1sPOqwV6RV3JS6Kcg8X
         +BwA==
X-Gm-Message-State: AO0yUKUJh2HftM4maKEfJ1X66KIrO50/7R3lGgjjfY2OJnibkH2dUOqZ
        G+n7fh5EwtJnzU1ACiKM7JhSOA==
X-Google-Smtp-Source: AK7set+L+5GW0GgI9KztlmCUknRctTJccLaZrCPTKnfWNMHzWH7YoENj8bpyyBGhW0pO//0mMQZeBw==
X-Received: by 2002:a5d:6a85:0:b0:2c9:6b87:962d with SMTP id s5-20020a5d6a85000000b002c96b87962dmr4265353wru.15.1677664057170;
        Wed, 01 Mar 2023 01:47:37 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a10-20020adfe5ca000000b002c3dc4131f5sm11880701wrn.18.2023.03.01.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 01:47:36 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 01 Mar 2023 10:47:35 +0100
Subject: [PATCH v2] MAINTAINERS: Add myself as maintainer for DRM Panels
 drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230216-topic-drm-panel-upstream-maintainance-v2-1-ffd262b72f16@linaro.org>
X-B4-Tracking: v=1; b=H4sIADYf/2MC/5WOQQ6CMBREr2K69htaFdGV9zAsSvuBJqVtfgvRE
 O7ulxu4mMWbSWZmFRnJYRaPwyoIF5ddDAzqeBBm1GFAcJZZqEqdKyVrKDE5A5YmSDqghznlQqg
 nmLQLhaWDQajt1WhUjZXNRXBXpzNCR5yN3BZm79lMhL177+Ovlnl0uUT67F8W+XP/nV0kSNAoT
 X9XdaPk7ek5oXiKNIh227YvdFLT0fAAAAA=
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as co-maintainer for DRM Panel Drivers in order to help
reviewing and getting new panels drivers merged, and Remove Thierry
as he suggested since he wasn't active for a while.

Thanks Thierry for all your work!

Acked-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Added Acked-by from Sam, Thierry and Jagan
- Removed Thierry from maintainers list as he suggested, updated commit accordingly
- Link to v1: https://lore.kernel.org/r/20230216-topic-drm-panel-upstream-maintainance-v1-1-ae1cf9268217@linaro.org
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index be167c695c64..f8e1b80bf41f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7042,7 +7042,7 @@ F:	Documentation/devicetree/bindings/display/xlnx/
 F:	drivers/gpu/drm/xlnx/
 
 DRM PANEL DRIVERS
-M:	Thierry Reding <thierry.reding@gmail.com>
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 R:	Sam Ravnborg <sam@ravnborg.org>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained

---
base-commit: 9d9019bcea1aac7eed64a1a4966282b6b7b141c8
change-id: 20230216-topic-drm-panel-upstream-maintainance-6d5cae28d184

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

