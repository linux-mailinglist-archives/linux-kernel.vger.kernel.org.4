Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90156A32EE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjBZQxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBZQxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:53:48 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA6F10262
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:53:47 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 017848319A;
        Sun, 26 Feb 2023 16:53:44 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677430427;
        bh=9YPCw915qKVGWwoFZaFeQr5pSs3AYecYx2tLRncmlc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhKH07kdWHJrGkijHEtkFaa1d6Gm9C3dpfLDkTsezkgkizdWUXfpUTaZlgoOJUIT2
         WaiVIOKTKS2nDFaUD21sQs0EogovchIesORpdlVX4R0ryz61CMGzfV9xrdCMpEKxVf
         xcpsnc+jpjBl8qEowSWjvbToJov+01FV+V0w4+TiWjDmAPsI7SBMiNbUgRe1UxDGiI
         zVNi0AtRU/LJbQIzffdSDwGydbh+H0xsWE80RdRxE+Fj9KJaW50e9w2J/9hGQfrbLG
         zGRanEoMZ7eXKIpS/Se45Xa4al+MkRvDnvOdb3CJORQoI/3jn1O9bZh3DixCDGfBJ9
         1DuRke5tCCz2A==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH v1 2/2] MAINTAINERS: Add workqueue_internal.h to the WORKQUEUE entry
Date:   Sun, 26 Feb 2023 23:53:21 +0700
Message-Id: <20230226165321.24825-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226165321.24825-1-ammarfaizi2@gnuweeb.org>
References: <20230226165321.24825-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file doesn't have a maintainer. It should belong to the WORKQUEUE
entry part. Add it to the WORKQUEUE entry.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb223dcf0f62f19d..ec4e40eb58778cc7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22585,6 +22585,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
 F:	Documentation/core-api/workqueue.rst
 F:	include/linux/workqueue.h
 F:	kernel/workqueue.c
+F:	kernel/workqueue_internal.h
 
 WWAN DRIVERS
 M:	Loic Poulain <loic.poulain@linaro.org>
-- 
Ammar Faizi

