Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501E46BE363
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjCQIYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjCQIXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:23:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4672630197;
        Fri, 17 Mar 2023 01:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88F62B824FE;
        Fri, 17 Mar 2023 08:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04883C433EF;
        Fri, 17 Mar 2023 08:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041372;
        bh=2fN05X8Hk+oG8PadKtWMVED3+Ll+rVeU4UKuOLTmoos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aH9baG6QVrmLtZIdI8tXrP/9/h9JdO4iRzL9ptVItpVzfubVeDhu64SQG34nnfShh
         IW3/aqBd7XXQlSDX+Z+ElfX4mUconWVPK14ovcqHvE16r92hReuGKMYXkEPtTv1Ozy
         T6kCDLNPrKDEg9NnUdHxVm1AW6wGDSuo+DbnTDWHzEXIGhbBo7TJ5uciA/tCxKpkYd
         8yXwFCJOMUrGt4mWlNxwiwYMTsNeHOVIchI8L9G6ARzcPcLbnWttjGbbn9k22GkLTm
         +J6qwBY4Ydw15V3Po/I75RCWYk9/4ZrCFfwP+6F6lVW1OqtEH9dol2w58CAH2hwjuQ
         4DFphXR+tsYCA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 14/37] drm/amd/amdgpu/amdgpu_vm_pt: Supply description for amdgpu_vm_pt_free_dfs()'s unlocked param
Date:   Fri, 17 Mar 2023 08:16:55 +0000
Message-Id: <20230317081718.2650744-15-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230317081718.2650744-1-lee@kernel.org>
References: <20230317081718.2650744-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:683: warning: Function parameter or member 'unlocked' not described in 'amdgpu_vm_pt_free_dfs'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 01e42bdd8e4e8..df63dc3bca18c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -673,6 +673,7 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
  * @adev: amdgpu device structure
  * @vm: amdgpu vm structure
  * @start: optional cursor where to start freeing PDs/PTs
+ * @unlocked: vm resv unlock status
  *
  * Free the page directory or page table level and all sub levels.
  */
-- 
2.40.0.rc1.284.g88254d51c5-goog

