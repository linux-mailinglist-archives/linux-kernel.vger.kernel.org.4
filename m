Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CDD69A8BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBQJ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBQJ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:58:28 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C98A627C2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:58:20 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 8-20020a05600c230800b003ddca7a2bcbso479818wmo.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sEERacWPQn5HQJtCzUxWfR99VAovvx/3XuSHotdsRHA=;
        b=VPfE02aNCEYuXI0BCFH/J/s0URGJAw1PLavr3tDV711YPEeWPH98hBJRIwroJjxZgn
         aG9CLxjlfVeTp4SQKm4/1lwUeJplMDe28IES8FHuuD7z1ixLRyMevmPWe3SooYBLD9pB
         LXnanCo4IdXuRY0SewX4G9qwGCPHSH58mMiKW7bIrZa8q+9WrRST08jpP1hDUWfKvOnR
         lv+/26UBPKPACPwtY1bhddDx5JbDSqJmCG+HWALfR0H0zMzyocffpIKB97t7BjU5zwxZ
         PL9OcIaU2zjQblKbCPIG9r49WbIxPuqsGdY6ILhmrqi340VCv437cJjyIYuRoFzbiTUO
         PRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEERacWPQn5HQJtCzUxWfR99VAovvx/3XuSHotdsRHA=;
        b=8JtjynPaCnDpf1WwXV+bOTkEpKRCAMX6f4fJ2By0AAxWXBpaqqODgZ4Cd0M9V/Kcw2
         En80d2NMFz6FW4d1kVzy1mebeFodfR4Wf65CrRsG0JSGYJFKxhSfYxgg97EC1RsAPg2q
         CHdCT3H9lmziPtqBruXG9K9BGqq3iDUVutB/MPe3V+h8S6Vr+4hu+M7GfzI3mSd7ydjT
         24wu2Yet1EbZEqRQrploVHJkFumU5toPhmzlRDchzxhd7CF0BlQEr6/PwijZ2iekHN6i
         T4iHYAlTO9GuExedhVW1oUaPaKT5GqtXNB3j/ggbEq28f6XgPOaesMsWeGo5UfO+rPyo
         ivUQ==
X-Gm-Message-State: AO0yUKX4F4SQpGZMnnsgilofy3kvsI2jG/p9n5NdybOuta0IhdB3PFOK
        wE2g/Qwm9k6uPWkXmttFrEpm0g==
X-Google-Smtp-Source: AK7set98dRwRGA+mF2mTJNO2SDS7s1bSCUU7DPOpc9FRVOv722JlsCbRvWAIKDMtjxzMLB2DG+Hb6w==
X-Received: by 2002:a05:600c:130e:b0:3e0:9fe:34dd with SMTP id j14-20020a05600c130e00b003e009fe34ddmr769809wmf.4.1676627899023;
        Fri, 17 Feb 2023 01:58:19 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b003dc1d668866sm1172044wms.10.2023.02.17.01.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 01:58:18 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 17 Feb 2023 10:58:15 +0100
Subject: [PATCH] MAINTAINERS: Add myself as co-maintainer for DRM Panels
 drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230216-topic-drm-panel-upstream-maintainance-v1-1-ae1cf9268217@linaro.org>
X-B4-Tracking: v=1; b=H4sIALZP72MC/x2NQQrDMAwEvxJ8riBx2xD6ldKDYquNwFaM7IRCy
 N8retjD7MLs4SopU3WP7nBKO1dexWC4dC4sKB8CjsbO9/7a+2GEthYOEDVDQaEEW6lNCTNkZGk
 WlEAwxntA8lMcppsz14yVYFbbFrPJlpKVRenN3//583WeP+ORfpeMAAAA
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as co-maintainer for DRM Panel Drivers in order to help
reviewing and getting new panels drivers merged.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index be167c695c64..18fd7548a49b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7043,6 +7043,7 @@ F:	drivers/gpu/drm/xlnx/
 
 DRM PANEL DRIVERS
 M:	Thierry Reding <thierry.reding@gmail.com>
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

