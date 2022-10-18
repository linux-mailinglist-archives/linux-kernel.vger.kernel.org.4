Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B619601FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 02:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJRAyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 20:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiJRAyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:54:45 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C581C936
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:54:34 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id g130so14014649oia.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJF+WI60vk4zKRnY5WDcGvuP4IAKRIrw4t1y9atba+c=;
        b=CvJfsU/WmCgQx55S50cP58rTdE2xSJn65d6abDil0brE5yNcP10yKEpAc/a7KKh/Fs
         yqFVefwH05LvTg3rX1S9CEhqqGTzMej6Rk0n38uoOi3n8iOxpz8xatVBOQ1/R885MLk6
         jQoLSjlg+K6kZeWdAibBnwqVed/P4CsxsUtArSPhrDFbEDkR2TXjUxs6FDu4A2PwVMyk
         YvTCbdI0w+08paL2DOILF+jhO5ZKg7H2N9/qray/3nfSbF9EN+jRwYG3w+f7lBY/jAjk
         yYWpHNpe8gjWudH5mK0MpSO1OuMi0vt8deuLacYhX7t68oKkLfzp1DA2ttUkvGaCAzun
         rOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJF+WI60vk4zKRnY5WDcGvuP4IAKRIrw4t1y9atba+c=;
        b=d00quYbQNDMT9XYGwpYQsaLAu1igP/Txg4hgVhByVkJPydbH5wvwez+N3Vf4W+hQjL
         lCFCjnFYcpB4k9Bjn1Oa/6QCpq2cQVUTvuRldikLtxyS6vlK/dV8n+uaLBnOahCdbA5W
         tv1Y0vA4MJxg9S1TzI6+tMV8goHC+40PtXdqNEdbp+SxCqxRAIgoi6Qw8c44kkPkXABs
         tpUdEC5FP7bFKUJY9PeZlUuHr3fc7Qy5MSy8SZpICoewH88K+bDIX6z37LNYm85iY9yR
         fl9pAurF5b34hlrQqgaFP8/sg+mLlYrR204kLJ/9hsh6KtttyYUXiUrqS2Yp+J1x6Xj0
         jk4A==
X-Gm-Message-State: ACrzQf0iqyUTeeZE3M7aamtQvzng50H84iM2MTW5YDNHghC3qzi+3GHN
        LWP3eq8yakKcifoSMf9ty+k=
X-Google-Smtp-Source: AMsMyM79IByIZADRuZXKE3oiNsXeZdoaKL8oknpSXSisoaeefSbJlBgjf2cwkfIV4DxrdgGt6gsrng==
X-Received: by 2002:a05:6808:1893:b0:354:b5bc:cd0d with SMTP id bi19-20020a056808189300b00354b5bccd0dmr14943045oib.244.1666054461473;
        Mon, 17 Oct 2022 17:54:21 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cc:1855:b6d2:d55:b2d8:b57d])
        by smtp.gmail.com with ESMTPSA id l3-20020a9d7a83000000b00661a2c5fef9sm5420433otn.32.2022.10.17.17.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 17:54:21 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/powerplay/psm: Fix memory leak in power state init
Date:   Mon, 17 Oct 2022 21:53:57 -0300
Message-Id: <20221018005357.887009-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 902bc65de0b3 ("drm/amdgpu/powerplay/psm: return an error in power
state init") made the power state init function return early in case of
failure to get an entry from the powerplay table, but it missed to clean up
the allocated memory for the current power state before returning.

Fixes: 902bc65de0b3 ("drm/amdgpu/powerplay/psm: return an error in power state init")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
index 67d7da0b6fed..1d829402cd2e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
@@ -75,8 +75,10 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 	for (i = 0; i < table_entries; i++) {
 		result = hwmgr->hwmgr_func->get_pp_table_entry(hwmgr, i, state);
 		if (result) {
+			kfree(hwmgr->current_ps);
 			kfree(hwmgr->request_ps);
 			kfree(hwmgr->ps);
+			hwmgr->current_ps = NULL;
 			hwmgr->request_ps = NULL;
 			hwmgr->ps = NULL;
 			return -EINVAL;
-- 
2.34.1

