Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A972668EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbjAMHAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbjAMG66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:58:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDD16B1BB;
        Thu, 12 Jan 2023 22:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Y9TFXyY/sfG1sJ/KVOexQqe/pZPSRJnNn2M9xtAbxXc=; b=kIlHQJUiyMYQIPLxOs3YG6fejv
        pctQUj9Ppqu7l4c9B2B/vfh8IOf9JdZstk/Z14AHQqIkQ7B9SjwzrF5Ubxh1LG69XOUT/KX/xULqP
        1byMrUPYBnnKoNifXJaFpC5U2pEnNEtHOSxRpQnpz+4ZAlukNzHcAGDjNqKskSI4LaShq9Ud7/B8t
        FHHQ7SpqyZSUBqDyRPKq9ywQTQOAVOCv0u92e81exNCts4XJQCUFVz4q5ECKSLAD5Wxei4wVaVb+9
        J74qlC2ebZ3BnyjrOA9gFZd3KZZdcevDsBtNZ0qbFW7zPLB20+8bi7iVM98DEYt3DmCN0dMLbITg/
        yUvSUEdw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDoK-000s0H-QD; Fri, 13 Jan 2023 06:45:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] thermal: uniphier: use regular comment syntax
Date:   Thu, 12 Jan 2023 22:45:07 -0800
Message-Id: <20230113064507.17224-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "/*" comment for the file's initial comment since it is not
in kernel-doc format. This prevents a kernel-doc warning:

drivers/thermal/uniphier_thermal.c:26: warning: expecting prototype for uniphier_thermal.c(). Prototype was for PVTCTLEN() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/thermal/uniphier_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * uniphier_thermal.c - Socionext UniPhier thermal driver
  * Copyright 2014      Panasonic Corporation
  * Copyright 2016-2017 Socionext Inc.
