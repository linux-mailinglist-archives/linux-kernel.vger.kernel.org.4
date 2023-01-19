Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AED674B13
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjATEoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjATEnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:43:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6CBCE895
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:39:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5548BB82059
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3714AC433EF;
        Thu, 19 Jan 2023 10:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674124425;
        bh=gxlphDU9pbZkh6ENeWN11bIpyYGrYXAEwSZoAItiC94=;
        h=From:To:Cc:Subject:Date:From;
        b=UEGZqjQNEcBuyIaKPRsIZUo5dUFC/XFwRT1uskgBljSLcnEiVFHhyEeJDEg3gll0F
         q1T3kEpObx8QkakPtsJG7RVDjWgyR4A8ssASK0a7aePHOl6qsZiT5ifdH3CDaBx3Hx
         EF3MMyiwzQpnMAn/wKlNTNP4mU6AC7BXP7tKminrGHqhMijusOHyQGw140VqQ130vd
         XYkvYopVG+KgDH9mrZU4WG8EqVEH7mM2KmiY8dsbUYPNGl6ebeXAAy4AixGTtuYcUN
         9GdWdL+F1iywS6YaHzl9bSWSSRdaSnvqqsPD3X8SGiZSiiR9PHWWEmPsuvqCmgAmV6
         Z/zRH5RovaCwA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 01/10] habanalabs: update device status sysfs documentation
Date:   Thu, 19 Jan 2023 12:33:30 +0200
Message-Id: <20230119103339.718430-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As device status was changed recently, we must update the
documentation as well.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 Documentation/ABI/testing/sysfs-driver-habanalabs | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
index 13b5b2ec3be7..df2ca1a401b5 100644
--- a/Documentation/ABI/testing/sysfs-driver-habanalabs
+++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
@@ -201,7 +201,18 @@ What:           /sys/class/habanalabs/hl<n>/status
 Date:           Jan 2019
 KernelVersion:  5.1
 Contact:        ogabbay@kernel.org
-Description:    Status of the card: "Operational", "Malfunction", "In reset".
+Description:    Status of the card:
+                "operational" - Device is available for work.
+                "in reset" - Device is going through reset, will be available
+                        shortly.
+                "disabled" - Device is not usable.
+                "needs reset" - Device is not usable until a hard reset will
+                        be initiated.
+                "in device creation" - Device is not available yet, as it is
+                        still initializing.
+                "in reset after device release" - Device is going through
+                        a compute-reset which is executed after a device release
+                        (relevant for Gaudi2 only).
 
 What:           /sys/class/habanalabs/hl<n>/thermal_ver
 Date:           Jan 2019
-- 
2.25.1

