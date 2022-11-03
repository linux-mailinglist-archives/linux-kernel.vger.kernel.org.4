Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577F8617BC3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKCLlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKCLlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:41:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D4B4B14
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:41:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F5A01FB;
        Thu,  3 Nov 2022 04:41:10 -0700 (PDT)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBF233F703;
        Thu,  3 Nov 2022 04:41:02 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Steven Price <steven.price@arm.com>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@collabora.com>
Subject: [PATCH] drm/panfrost: Remove type name from internal struct again
Date:   Thu,  3 Nov 2022 11:40:36 +0000
Message-Id: <20221103114036.1581854-1-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 72655fb942c1 ("drm/panfrost: replace endian-specific types with
native ones") accidentally reverted part of the parent commit
7228d9d79248 ("drm/panfrost: Remove type name from internal structs")
leading to the situation that the Panfrost UAPI header still doesn't
compile correctly in C++.

Revert the accidental revert and pass me a brown paper bag.

Reported-by: Alyssa Rosenzweig <alyssa@collabora.com>
Fixes: 72655fb942c1 ("drm/panfrost: replace endian-specific types with native ones")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 include/uapi/drm/panfrost_drm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
index 6f93c915cc88..9f231d40a146 100644
--- a/include/uapi/drm/panfrost_drm.h
+++ b/include/uapi/drm/panfrost_drm.h
@@ -254,7 +254,7 @@ struct panfrost_dump_object_header {
 			__u64 nbos;
 		} reghdr;
 
-		struct pan_bomap_hdr {
+		struct {
 			__u32 valid;
 			__u64 iova;
 			__u32 data[2];
-- 
2.34.1

