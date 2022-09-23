Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350FA5E7630
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiIWIu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIWIuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:50:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1AC126461
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:50:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w20so11133600ply.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=m0GiZu8zLID0eFEYzNtc/d/rbc2E3znwv6VNJxzsvXA=;
        b=L1P50DVoPxcpKqaRrMElsHyMYUo6ZaCJl7prsqcYutvTJA7fdBiEBxp1bG2bu1SVpu
         FDQKD1dFsz6h760y7ANrdH013zGD1YCkLjBi5vewQeL/h3yyoBjHNoOHM11XNGW2+N1o
         tvkjrU2s1NFsJTkPNrnF+lJn1q8CRjuHIong0uyoF4n160gkkvES7QFotkTGsYR+rB4P
         CrCtDdeCppNurnU2VQjWpeaokkIoukOavSBoanKSgp3/OYWEM8WU8pLg/+n7bwPUmaod
         zJHqB3Yc9wy5KZT9+RDWSQiyZZszMDoRGPwZ+G8jWSRfWPjCweKYgHcOWdG1T3dDmg3m
         gz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=m0GiZu8zLID0eFEYzNtc/d/rbc2E3znwv6VNJxzsvXA=;
        b=Y+iF1xt8WYwpYlkOgbMQr4AquCAM4uAOntrnw3NXWIwhgUz/K3qFLHgQqhfIh201Am
         xh6xlVagESrvOe7tRnVUP40vwE0WyiGP0kG0cRxmfjtwLH+66Q8UwC7IPSDA4Ewk3bIX
         TTeIta+OMwyMRr0ly3B0xYaKlxzPCKSepMsCwj7iI2TUnF/AJkcjXP5pBi+AgFkdDwv4
         R7iPDO66w+NVcE3czASpb7JenZexl9VOgOMc9BrjHoDQRHDKnmD7QnGHXbmngSkQ/rDS
         zQSynvK6e4fk57K4EcTTv4ULIW7mHySMud00CucrrALJY5GicGZZxtRlztF7TFPF9eYE
         RUDQ==
X-Gm-Message-State: ACrzQf2lho1CKc+p57RG6xnxNLNAOLdagol+d1Hw2yR3zcO2DRin7WPq
        h/TLKx62nnBAbBFUp5tGvK+MGQ==
X-Google-Smtp-Source: AMsMyM6XLM/RH9WGNR6ufoC8vvzvqomkeXaZ1axni1bMksT4CeQzyEhzm1cd+oc/7z3kyomHv+TvOQ==
X-Received: by 2002:a17:90b:38cb:b0:200:aaa6:6428 with SMTP id nn11-20020a17090b38cb00b00200aaa66428mr20116518pjb.47.1663923033565;
        Fri, 23 Sep 2022 01:50:33 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902f78300b001752216ca51sm5507871pln.39.2022.09.23.01.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 01:50:33 -0700 (PDT)
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
To:     dianders@chromium.org, thierry.reding@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add BOE NT116WHM-N21 (HW: V8.1)
Date:   Fri, 23 Sep 2022 16:50:28 +0800
Message-Id: <20220923085028.306790-1-sean.hong@quanta.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the BOE - NT116WHM-N21 (HW: V8.1) panel.

Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 060f4f98bc04..5069440633fd 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1885,6 +1885,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0786, &delay_200_500_p2e80, "NV116WHM-T01"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07d1, &boe_nv133fhm_n61.delay, "NV133FHM-N61"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x082d, &boe_nv133fhm_n61.delay, "NV133FHM-N62"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x094b, &delay_200_500_e50, "NT116WHM-N21"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x098d, &boe_nv110wtm_n61.delay, "NV110WTM-N61"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
 
-- 
2.25.1

