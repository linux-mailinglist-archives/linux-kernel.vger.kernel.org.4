Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4729C733E07
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 06:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjFQEk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 00:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQEky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 00:40:54 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEF81732
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 21:40:53 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-39eab4bbe8aso818629b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 21:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686976853; x=1689568853;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdTXgdzdalPUjI3Ht3T1J7by7Wvs6eS5DA4nj1ZXZls=;
        b=TmUuyayMRWJtcc7lll42NWrHN9ZTGtFNwyTVMVacmssHpZENrIWp01v69I1vBIDcKc
         GgXNjou394k0gyc/QbrYQz+WhwbuNXlf4xsBLvjSzOEF816LLgMWTKD4mjrAs4o3BG8N
         5aYRL0BvfVGKNTp34xnxaLO96YbmNwqWV68RmbQpJDv0TC0kqslkmMAajG7b4lJ+ZA4A
         QtQKpz+F1HaOB1Kl2uqGcBC2yYXPS4asqtxtiUGbh0kL9TBOU2A9dC6JSpbRZ29zNY5j
         97hBT2S74RlieT9iQmLqKPgFtjlcBY/yFoD+DMP2Z5Dwl1rCR/R2LhYINAbjl7/YgWsg
         BH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686976853; x=1689568853;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdTXgdzdalPUjI3Ht3T1J7by7Wvs6eS5DA4nj1ZXZls=;
        b=dE0vK9sKEeKtJYA2tnwiNXAN7IJa3Z0kQoq3mnZipOHkBG/UmioqhJ+dRzkTrc1c86
         h9H0GIoe5IUUPlvdZXY6V3GeZ5xNGRUHuGO4k+1oGSCe21NbJt5PoLpMia4I2buIrrw0
         NyDkVvSmkTQG+eGkwNTkEo0S54V+AaBJO3lp25qIS1/wbQ+1WwhAVzVa+OCg9SRdzVrP
         ayWcPP7ddoL15roDjF39mwB9bvv9hpMMdHZtzs9a2csKJV3kP+Y3P2VsTEGGGyBa+4ky
         SUgkI2YZkDaH9jig/vf4CKOfa+GAcmYJzDIOvhOXsYMwOdT6vhNPpLx5OhW1SsR1FjyI
         NB8g==
X-Gm-Message-State: AC+VfDyVVtx4Ej++xPj5R41rw+mpiedCVvI1m0N+kdLX0CaTojJD7zIt
        /zbG0L6lVd64FoMe7s90KAg=
X-Google-Smtp-Source: ACHHUZ4gYURqhUUkMPEdrxMDKQayn+10xNi14I/kungRha1hXNiO8wzNWYoiyPAkYT35KE/zYTCRfw==
X-Received: by 2002:a05:6808:f92:b0:39a:a77a:eb48 with SMTP id o18-20020a0568080f9200b0039aa77aeb48mr5206055oiw.0.1686976852938;
        Fri, 16 Jun 2023 21:40:52 -0700 (PDT)
Received: from localhost.localdomain ([112.213.33.6])
        by smtp.gmail.com with ESMTPSA id kg14-20020a170903060e00b001b06361a38dsm3413397plb.116.2023.06.16.21.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 21:40:52 -0700 (PDT)
From:   Liam Ni <zhiguangni01@gmail.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org, rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        zhiguangni01@gmail.com
Subject: [PATCH] mm/sparse:avoid null pointer access in memory_present()
Date:   Sat, 17 Jun 2023 14:40:36 +1000
Message-Id: <20230617044036.3985524-1-zhiguangni01@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__nr_to_section() may return a null pointer,
before accessing the member variable section_mem_map,
we should first determine whether it is a null pointer.

Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 4e6e3a9d49dc..37fa3818bc25 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -258,7 +258,7 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
 		set_section_nid(section, nid);
 
 		ms = __nr_to_section(section);
-		if (!ms->section_mem_map) {
+		if (ms && !ms->section_mem_map) {
 			ms->section_mem_map = sparse_encode_early_nid(nid) |
 							SECTION_IS_ONLINE;
 			__section_mark_present(ms, section);
-- 
2.25.1

