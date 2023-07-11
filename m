Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA7A74F3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjGKPid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjGKPhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:37:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA321FEB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:36:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fc03aa6e04so38473465e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689089811; x=1691681811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GJI50mwxWlMPNP5cWPxpWEEdZG5lOnOefrq0yW+CGM=;
        b=wUDuda6My1fJhNJVTT4xzuCaPmZY9FWx4CNdwFY76vkATX+e7rRSrHp9ms5ohVNIOu
         IrLDOM0o95o8ib0GLHo08AGMsQQSPq48+rYhBhainzia4BksqYK9okETo7tFlymZM+Rf
         tYqT8fTpFGbbE3g1scqMByZUHJxF7frvB5/PgKqI5M2qTrkxiJbDIU9IzPrECsxOBd5Y
         xGTLlnCDj6UoBNkYmy+hk7EPro7JzQTwkFpQ8neSbIGi7wrqFt+vKFDyCt0pvEGb1JxN
         HubtI3fLpCuZE9ICFKpYlZD+O7QQ6PgY+6pcArhT515Axy0o6GKn4bX8fzSu34HybOp8
         6SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689089811; x=1691681811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GJI50mwxWlMPNP5cWPxpWEEdZG5lOnOefrq0yW+CGM=;
        b=Y0DwGipyQV5+WJ8vu0PWbocclkjXQ+V1BcFjqO00s3NrNMxEObPXBAPi+VIs1f8eMu
         BnkJOWjPSD5bPLV9p7qjx3LWlOkmQYlGHJ06aUFtHkEC3t7UhkddaluV43GPrETYGa9Z
         FB6GGAEk7r/MyKtrxxuYNdPFFxir+sINQDoufUCviGJQE+Nn2z+W3DV13mmxHqn0eoRR
         eM6iSXNdXjEFkG67GNYqcEWSaGpHF1qhoEvBamFO48N8E3XFw0qf3oivwMA82y8QfuKX
         mruFFkSvMjJqze9Znd8fpnfOlRHWuBo0VfKSWOqHFYlui/rs32hvtkbk4Iu1YyO9gH44
         3AcA==
X-Gm-Message-State: ABy/qLZXLHuBVj4pREkkWDxRNewrQq457n3uOkoK6CI5RrmEmpNpJL0J
        2QVuePqEUCC+Uwz1PcQHrjv5lQ==
X-Google-Smtp-Source: APBJJlF9So6LfwkBVH+qlI0rbO+D3Aq+ntkutH+LIy5IavL97S9sKAgEMeI+1n9UiFYVZdmvXxGIuA==
X-Received: by 2002:a05:600c:22c1:b0:3f7:f45d:5e44 with SMTP id 1-20020a05600c22c100b003f7f45d5e44mr13522351wmg.32.1689089811521;
        Tue, 11 Jul 2023 08:36:51 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id v6-20020a05600c444600b003fbb1ce274fsm23458249wmn.0.2023.07.11.08.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:36:48 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 11 Jul 2023 17:36:29 +0200
Subject: [PATCH 3/3] arm64: defconfig: enable STARTEK KD070FHFID015 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-startek_display-v1-3-163917bed385@baylibre.com>
References: <20230711-startek_display-v1-0-163917bed385@baylibre.com>
In-Reply-To: <20230711-startek_display-v1-0-163917bed385@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=767; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=3ewdZnRTwiLei9nYvBO9iEQ33z/6iSvXdTZm6ylJVyY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkrXcKUQWbV2iAeFPR/VjBVggDjm9Nq2Kb2ijsPX3v
 LhVCYBaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZK13CgAKCRArRkmdfjHURaueD/
 99uwr2/xYOYtFmN2Ous86Zl0n+MhUimAFkQ78BPNDlViDKM2LofCjegnKCtkPmgo+vOZbrZ7/Zv3D4
 sxjws2zW5NwdZRHRaSODznJG4NJFvt4fp62/Ndi6aUSXtQZgTRDfBstVPlKoOp5+mHT+LkpT7VqF2s
 QNZ5hbqOOrVcHJWvTnm1Na38zw65IvNOizOPsfov+cnpmc2G04tezzZUkLwQZxqeK6TottpGR9zGkR
 HzRuWIkAbQnkbss+XvXUFZpPVDjlZwPDEap9wIOHHRFyGziLv4sXoKaOn+bf2BlJsMmg9Mf5xxXyJZ
 KM3dpb0d9wCwaiUlGyWI4Dd9bYGwykqzI18RywHBJjAY2sAAGiIx/earW3dVSJaYaV6NEMdc1ENMAz
 47rSlNev8SPoutpEERMpE7sATabdhQYW9vtdwF5GQLiUOv4LvOE9MekZhYT2DWANzdpj16npCvcHBt
 6McpSQrTqnvFFSsGm0jrWO0Xgfi7w6H71iDw3KvcPsDvq3rUo9YLTKB0lSVA6b90+lm4QBEqiEZDWE
 eplqDbUJ+aHJUp09rlxeL8LSjIm6+LVr7ZQLqBuYGsC/lCV17lVSPdHGFBSzFYRodmLHoSTLj/SMjK
 0ip5nUMmiVX8RPZGoJLm+eN4VKcOICM/5GkztLRm63b+li6qa3QGNUvaFG+A==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build Startek KD070FHFID015 panel driver. This MIPI-DSI display
can be used for the mt8365-evk board for example.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0777bcae9104..cb24a3d1219b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -816,6 +816,7 @@ CONFIG_DRM_PANEL_EDP=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
+CONFIG_DRM_PANEL_STARTEK_KD070FHFID015=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
 CONFIG_DRM_LONTIUM_LT8912B=m

-- 
2.25.1

