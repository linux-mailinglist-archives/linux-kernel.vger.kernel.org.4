Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6D766A98F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 07:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjANGJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 01:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjANGIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 01:08:54 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9119230DC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 22:08:53 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id k11so3664662qth.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 22:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+2LAaOxNQuhC+S8GRJpCwLfoqVevt1c8Xbyr6vRhjU=;
        b=gFnpBpSkC70sxHenDkPzNMijYG/24BmL8bGnUIuoE13k3qT7qn/PAOuHK/80vnAL2H
         E5If086c3G8wGYctQ921urUJs0LqxYH76Kbq//y2cnKhZJUniTly09Sq4POIuq/sKqW2
         DEfU+MChdgcpc3ZKTsl4gbejqfhI1wK1xQrrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+2LAaOxNQuhC+S8GRJpCwLfoqVevt1c8Xbyr6vRhjU=;
        b=4aX85PhRFuk34y7jHTyYk6PvsFLUMYHWOIN684/wazZwtt3PdU3i5DSuBOz76rgdiA
         i5tp8e75bYZasm7akkRmgpEOxdRV3I23cqFV6A9G1OaCKaAGWT/2XA0cMn6yreyqta04
         gSoPrKMV2REV58AJJUbDsn3BFUC7nPGDnJmXLIOoQpOk/9RsB5tAEsa6bvq9Vp5vHqvu
         k4Yao97+EQeUoxvilI8iKYmB/zjX/4qsU/atRbO0W14Z/Y05Lchds0l8LTYtx1vfgo+P
         o6VlIiXn6kSwmQcIWxRshGHkKx7X3kSwcE/eRoF6DtZ22QXtvkihfzR0/OwpV+eCYAkd
         TnbA==
X-Gm-Message-State: AFqh2kpQcAuqa/A1vUYQ787foeiMtVDAGfFy+YY6v9FCVlGbMeCoDhDr
        A0VabOZ/+t4TZV/5if10rq3r1g==
X-Google-Smtp-Source: AMrXdXtmFUppigjwv0C/k5mQlzbCkvyuCL8GIlLqzgqKplS56HkGm+iznQF/skNIo+h34mxAUORiTQ==
X-Received: by 2002:a05:622a:1aa1:b0:3b5:77ff:fbff with SMTP id s33-20020a05622a1aa100b003b577fffbffmr89441qtc.37.1673676532448;
        Fri, 13 Jan 2023 22:08:52 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id z26-20020ac8101a000000b003a70a675066sm11553086qti.79.2023.01.13.22.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 22:08:52 -0800 (PST)
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Sat, 14 Jan 2023 01:08:41 -0500
Subject: [PATCH] Documentation: Avoid duplicate Kconfig inclusion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230114-doc-v1-1-efec2689e423@pefoley.com>
X-B4-Tracking: v=1; b=H4sIAOlGwmMC/x2MSQqAMAwAvyI5W2hdQP2KeIht1ByskogI4t+tH
 ocZ5gYlYVLoshuETlbeYgKXZ+AXjDMZDomhsEVpnatM2Lyxtg5Thb5xbQmpHFHJjILRL1+7oh4k
 n9iFJr7+fT88zwsoAllAbgAAAA==
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673676531; l=634;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=cT2yd4HoZ95mdHyqj3Z2j/xAavuANzfRGr7ZZ7U0xB0=;
 b=tS0PDOXdiSBNHvVvN1q7KitOv6SCfxJJupFDvSaky/lTE5HpdWF4YoDDoA3u5+DHRwXHMJrOc+7Z
 KSUI3/QbBGZ3KG4NFu2ONZHhUEPUaah8qJ5F1YF884p1y0aMeghR
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/Kconfig is already included from lib/Kconfig.debug, avoid
including it again and polluting the top-level menu.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 745bc773f5670..97ed6389c9211 100644
--- a/Kconfig
+++ b/Kconfig
@@ -28,5 +28,3 @@ source "crypto/Kconfig"
 source "lib/Kconfig"
 
 source "lib/Kconfig.debug"
-
-source "Documentation/Kconfig"

---
base-commit: 97ec4d559d939743e8af83628be5af8da610d9dc
change-id: 20230114-doc-005df4ac8193

Best regards,
-- 
Peter Foley <pefoley2@pefoley.com>
