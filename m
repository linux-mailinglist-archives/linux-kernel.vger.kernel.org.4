Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EAA668E69
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbjAMGzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjAMGyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:54:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB92A81136;
        Thu, 12 Jan 2023 22:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bxqKt58hvR1yu9IqldV+R5b5cGD0Xza3I0u2tbjL9Vw=; b=Wh+nfVSNf4NbvGaGxlIHDg4IAB
        mcDVwoYf8O3L82sKpPNQNfs/KGLiyCheywd8BkTLRhOhZ4qEsCbqApFsHIUvUghkJLUU1u04m5z2u
        EyjwGsgmzx5x6GQj46Wf1LmS525inrEGIo8oLi9b6qKjN0txyJ0YqxtTUk81Dxbv8w3vGah71KQV3
        /nk1G743QDnhWrJAPAvZEXpTZoyl3OPKB08GUf+D6m39j6w8xZ5l3krqBt6DLPdJc0Gssi3Tucibe
        SnJL7wfswZ/oc72XbYs9xVQztuSCfn7TRzSTEomlLDMFZqUvI7ZGnYjJDI73clyluJiqtwpqDt39l
        ugg0jbQQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDhw-000qKx-DE; Fri, 13 Jan 2023 06:38:32 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] input: cpcap-pwrbutton: remove initial kernel-doc notation
Date:   Thu, 12 Jan 2023 22:38:31 -0800
Message-Id: <20230113063831.16469-1-rdunlap@infradead.org>
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

Change the beginning "/**" in the file to "/*" since it is not a
kernel-doc comment. This prevents a kernel-doc warning:

drivers/input/misc/cpcap-pwrbutton.c:2: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * CPCAP Power Button Input Driver

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/misc/cpcap-pwrbutton.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/input/misc/cpcap-pwrbutton.c b/drivers/input/misc/cpcap-pwrbutton.c
--- a/drivers/input/misc/cpcap-pwrbutton.c
+++ b/drivers/input/misc/cpcap-pwrbutton.c
@@ -1,4 +1,4 @@
-/**
+/*
  * CPCAP Power Button Input Driver
  *
  * Copyright (C) 2017 Sebastian Reichel <sre@kernel.org>
