Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B8D668E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240697AbjAMGzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjAMGyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:54:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B333809A8;
        Thu, 12 Jan 2023 22:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6Oe5pngS4zjkmz1lYubpQMTIHz9uRDw0CU0YC0V6wD0=; b=pXvJWqLjv4lgpXQvPP6PGer754
        sHhCKTNnwaUdJkSMgH0VikqgkymfAStvaxxiPA/nzBy5kBlDvkxO+ARZcjMi817vzN/mazkqxZ4JI
        fKYYMZ1ZeI/9vN7MFYM0mB+YQtavd14pD7gCMSJvcNs2jsDb1jqpv94Vc5s3wQZaUspBPnKofTM0l
        6fwFG2x/9lVACroexRAruDto/ZT2RqfsdrAdA4b0+LmVXHnrEwGn2bEMmlZP/KAuHZa0xRXA9pog5
        zbVdLhe1ePdvkGu83tMlzKtv1emnjMTD3+H6i4uQz7tTtX7xeBtepEfUxjJiCJo/rBuh+RjengYaB
        s9OojMTQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDi5-000qNW-SY; Fri, 13 Jan 2023 06:38:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] Input: synaptics-rmi4: use correct function name in kernel-doc
Date:   Thu, 12 Jan 2023 22:38:41 -0800
Message-Id: <20230113063841.17191-1-rdunlap@infradead.org>
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

Use the correct function name in kernel-doc notation to prevent a warning:

drivers/input/rmi4/rmi_bus.c:300: warning: expecting prototype for rmi_register_function_handler(). Prototype was for __rmi_register_function_handler() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/rmi4/rmi_bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -285,7 +285,7 @@ void rmi_unregister_function(struct rmi_
 }
 
 /**
- * rmi_register_function_handler - register a handler for an RMI function
+ * __rmi_register_function_handler - register a handler for an RMI function
  * @handler: RMI handler that should be registered.
  * @owner: pointer to module that implements the handler
  * @mod_name: name of the module implementing the handler
