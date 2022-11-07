Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3206661EAFE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiKGG2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiKGG2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:28:35 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DB26251
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:28:34 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so9401531pjl.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 22:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/I3XW6m+6xjdtRqibwEtgmXY2H9vLL7qEm/Qo2Np4gE=;
        b=pMQmgSP5aWtkBbeSv4Q543HsShauzs3Txq4IsMI06svBJKP/YWAJA0sBtsppi2bZUw
         iVM7uyd1J3l0441T0WqD0mup12CLIxoT7dTgpLk0oy7U6rHefGT9jL/lz8RPz7xI60Kt
         Jd1s804M+7eK4t+HcHkyd5fWourWcM6z58KpeH70lryuijH5WwqWY67Jf1r4seMFxg4j
         8xuz7zNPxXWYfvx1ZP8b2YiFPN1t52lCh6oyaHEpCiaa0z7IHNVOOqm7FT7V0TeSnahL
         5EQk/hYYGln24sEtS9VT/BGgzhfH3DLqLwE6o3D11YnGQ2ia3z0jMZJELefLTh46SGYx
         oRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/I3XW6m+6xjdtRqibwEtgmXY2H9vLL7qEm/Qo2Np4gE=;
        b=QZhW+2cWZ9jQdnhNJi8F7Hy/UREzHLh+bMOp1oCaDIoGq33p5+LvlAcQ1UsWTWNdSK
         w+wIQd7KPfmNMZMGJ/6amnWqs58vSCW3csORX7dwphgIvOtNeqlY9+e+L3HUR0pTLhjL
         AUPFYPJirLej0h+RQMupdVRgtR5iFZ2EGkndwTj50WpxDBprIuIG0jeForPRtRHggb7D
         gmH4p2pSczHe72DsHbx2/R7p+eP6f4bz8+bEG8ehItZeq1Bnq/dta0XpreanGTSLkOqB
         8Xkdrcj5FB+qLqjJeobHbwnaqcQY6ilOUNgWCO77fhsf4xrfsFsQTDVDolqkNVSZI8mC
         dmjA==
X-Gm-Message-State: ACrzQf2MHS92EHnRbG9RikMQX1NiKS18XZVb+QNctyFPrCbAgKHEWUbp
        rs6o28qToUEVXtg5AEDDMRY=
X-Google-Smtp-Source: AMsMyM4eupwsQZtatIdNUX8A2TKr25bkpRv1SmTO4IuFGbItNOX8/N5LzpduP2h8juu9hvbCedN3rA==
X-Received: by 2002:a17:902:ced1:b0:186:b18a:d0d5 with SMTP id d17-20020a170902ced100b00186b18ad0d5mr49667567plg.60.1667802513705;
        Sun, 06 Nov 2022 22:28:33 -0800 (PST)
Received: from sophie ([89.46.114.207])
        by smtp.gmail.com with ESMTPSA id a143-20020a621a95000000b005629b6a8b53sm3729549pfa.15.2022.11.06.22.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 22:28:33 -0800 (PST)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 5/5] memblock tests: remove completed TODO item
Date:   Mon,  7 Nov 2022 00:28:09 -0600
Message-Id: <f2263abe45613b28f1583fbf04a4bffcf735bcf6.1667802195.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667802195.git.remckee0@gmail.com>
References: <cover.1667802195.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove completed item from TODO list.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/TODO | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/memblock/TODO b/tools/testing/memblock/TODO
index 503cc96fcdc3..e306c90c535f 100644
--- a/tools/testing/memblock/TODO
+++ b/tools/testing/memblock/TODO
@@ -1,10 +1,5 @@
 TODO
 =====
 
-1. Add test cases using this functions (implement them for both directions):
-   + memblock_alloc_raw()
-   + memblock_alloc_exact_nid_raw()
-   + memblock_alloc_try_nid_raw()
-
-2. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
+1. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
    for the new region
-- 
2.34.1

