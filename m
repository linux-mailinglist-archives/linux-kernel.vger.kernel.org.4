Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEDE6A32EC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjBZQxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBZQxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:53:44 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DAFB772
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:53:41 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 54AD18319A;
        Sun, 26 Feb 2023 16:53:39 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677430421;
        bh=07fZW5onW2pNiEysaKb9KIlVEY5WfB0wO8+WJdu+KXI=;
        h=From:To:Cc:Subject:Date:From;
        b=UT7LvdFCxVkAWHZbA+tfnhGaDFLXIEXPYB61xPmXvQsN8DhCR5IEB09sdcEpcXddr
         CeSTPL+KgT1S+ybFVwoGuPrGLy+C9w5B8oWiGt10t9UIcNfPh7c7LVVljfSMWELtVO
         eum4zD2DBcB9kjZempdLH/tOPt9oe8lRueUjAvDrAZPz1yDXr0TRDz9AVOFHRFtayM
         IFV4q56O9dz3e5f2oLg3Hgh97Xt/utTE/NN51Ec0q2fezBazMq8p9OzNc1sDcP07xs
         gzBc6a4mxlIigjJM3vEpru/E2h+NB8YLYzwHA6CJO2b5BRmuWXfTog7K9+e33COUbZ
         A8B6+VDit042w==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH v1 0/2] Two small patches for workqueue
Date:   Sun, 26 Feb 2023 23:53:19 +0700
Message-Id: <20230226165321.24825-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
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

Two small boring patches for workqueue.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (2):
  workqueue: Simplify a pr_warn() call in wq_select_unbound_cpu()
  MAINTAINERS: Add workqueue_internal.h to the WORKQUEUE entry

 MAINTAINERS        | 1 +
 kernel/workqueue.c | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)


base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
-- 
Ammar Faizi

