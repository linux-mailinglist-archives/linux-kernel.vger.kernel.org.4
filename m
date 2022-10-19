Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CF36049F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiJSOy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiJSOyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:54:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA06C16084E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18045B822B8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E04C433D6;
        Wed, 19 Oct 2022 14:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666190721;
        bh=HRv1w9sVKhzl0I06514+nrn2V5MpzamfNaLLpfMRNFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dUVedYK28DyLQFAhLTdoU05pvBWO9DitjpbOb8JzQG0rYinRyOQYW8XUrZm8sdISS
         pHZP8crjkawtgVIAtmphn7eWfzxKaJ7CTUU2S1G9GPA0AXwd+gc9IXip3gwVICksIJ
         CpCx5UHBGI0LW5JlHM64DpgueY9nyf5DYGBgJb4XsKhA3o9kz2rtxCu1BTIlGMpbgZ
         QUOtEP4eSNFRgOmhS08jE/mKxzysUGSZV81voZOkdFQi3J//TzXzXqUaWYMDH9GEFL
         FHYOVqHjIs4YPsvI+pd5z8qbLgbyLYKDpRpXWaZDoI+uqYTFBBzENoHvL+3aJDpCqa
         M4lWEG8698ayg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] ARM: at91: remove stale MAINTAINER file entries
Date:   Wed, 19 Oct 2022 16:43:47 +0200
Message-Id: <20221019144505.3848435-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <patches-remove-boardfiles-part1/000>
References: <patches-remove-boardfiles-part1/000>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Going through the entries of recently removed machine types,
I found these two that were removed a long time ago.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..aedb7c008dd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1798,16 +1798,6 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
-ARM/AFEB9260 MACHINE SUPPORT
-M:	Sergey Lapin <slapin@ossfans.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-
-ARM/AJECO 1ARM MACHINE SUPPORT
-M:	Lennert Buytenhek <kernel@wantstofly.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-
 ARM/Allwinner SoC Clock Support
 M:	Emilio López <emilio@elopez.com.ar>
 S:	Maintained
-- 
2.29.2

