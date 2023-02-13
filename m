Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C111F695018
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjBMS6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjBMS5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:57:53 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C970E76A9;
        Mon, 13 Feb 2023 10:57:49 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-15fe106c7c7so16264809fac.8;
        Mon, 13 Feb 2023 10:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhoQvg3BMaFTkvvFqgv6WpxCoYJyC9DRYUszslZVGiQ=;
        b=FXWPwOo/Ee+i5OIz6j2njqn0ZzUk6+WwUfHqMu0bXnatgSmwQmHnG+Iqvs4fG8bE2l
         qn3stmEtWIHTu7T53g0gyk86US2YfreUbGwa6bH6cqO4zTtCFZMf1THvRYLwSNe0sGI0
         CF1t/wP24ReLd6zmr/VQsWnppeI1WgQ5A9ZCh7+M+ZkaeMk3A7eWDK0+w8kPFYi1rxfW
         G5GVxZnhOrqahcj6G3zNy329jhG3W2RQqqlyVGLSwymtjNRBuAfpyE7/9tAUlPoOFi3s
         WLDmHZCWop11hftaciL9juMEqbn0z7lf8dtpDQdmQJpjSc9S0fOF03rya70VD/iK6M70
         2yPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhoQvg3BMaFTkvvFqgv6WpxCoYJyC9DRYUszslZVGiQ=;
        b=CZcFdh5JkOC3GZgEFLJlE20W00bKIbVf3E+SxIQvfPoLzZofZjwBgG+gyGPvl+Nm62
         Wl6UynFs3Bq2nEf6b8gRwzFm3tOPYO7l7ZbyGRgH0n4ga6Qlgw1qegCqX7x8wYOmyEeP
         k6Oooi9XgsB3VMUnzP0OF1pkDLDgjtEHjRaXlHVo7A2nVZvgnNjUJCoVkM0R5zwW72wB
         l22cAocXvacTmsTJRKILuPXDgdtrRgcaep/U+rLs7L3hmyChIBjXOgDeWNbl9uE/uVXx
         OmuGPva6lnrwR5FwmedlBPoCjhF1qLFnRwmR0GO1o4HtOOlHkk2IwWHlJfJRRZK756mk
         kTNg==
X-Gm-Message-State: AO0yUKVxeM47QUOMsSootrUMgYacor/shmOu4/FBj6XKnhHxHsTXhwKt
        0m+ut4R92biqJK9jpHSx2n0=
X-Google-Smtp-Source: AK7set+1cl1yGPyo8AOt32fCulUchZRPgSXW1CwXhWaBm9Rb86rE1dMKAg/PhygRr/6/KzL0rwE1vQ==
X-Received: by 2002:a05:6870:d69d:b0:16a:c8ed:f405 with SMTP id z29-20020a056870d69d00b0016ac8edf405mr8255809oap.52.1676314669212;
        Mon, 13 Feb 2023 10:57:49 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:5829:dabf:a50e:e9f2])
        by smtp.gmail.com with ESMTPSA id ef15-20020a0568701a8f00b0016df97ab05bsm1654958oab.31.2023.02.13.10.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:57:48 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] of: dynamic: add lifecycle docbook info to node creation functions
Date:   Mon, 13 Feb 2023 12:57:02 -0600
Message-Id: <20230213185702.395776-8-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213185702.395776-1-frowand.list@gmail.com>
References: <20230213185702.395776-1-frowand.list@gmail.com>
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

The existing docbook comments for the functions related to creating
a devicetree node do not explain the reference count of a newly
created node, how decrementing the reference count to zero will
free the associated memory, and the caller's responsibility to
call of_node_put() on the node.  Explain what happens when the
reference count is decremented to zero.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
---
 drivers/of/dynamic.c |  3 ++-
 include/linux/of.h   | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 657a65006056..12aa99018969 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -443,7 +443,8 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
  * another node.  The node data are dynamically allocated and all the node
  * flags have the OF_DYNAMIC & OF_DETACHED bits set.
  *
- * Return: The newly allocated node or NULL on out of memory error.
+ * Return: The newly allocated node or NULL on out of memory error.  Use
+ * of_node_put() on it when done to free the memory allocated for it.
  */
 struct device_node *__of_node_dup(const struct device_node *np,
 				  const char *full_name)
diff --git a/include/linux/of.h b/include/linux/of.h
index 8b9f94386dc3..e20a08c8a8c8 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -100,6 +100,17 @@ struct of_reconfig_data {
 	struct property		*old_prop;
 };
 
+/**
+ * of_node_init - initialize a devicetree node
+ * @node: Pointer to device node that has been created by kzalloc()
+ * @phandle_name: Name of property holding a phandle value
+ *
+ * On return the device_node refcount is set to one.  Use of_node_put()
+ * on @node when done to free the memory allocated for it.  If the node
+ * is NOT a dynamic node the memory will not be freed. The decision of
+ * whether to free the memory will be done by node->release(), which is
+ * of_node_release().
+ */
 /* initialize a node */
 extern struct kobj_type of_node_ktype;
 extern const struct fwnode_operations of_fwnode_ops;
-- 
Frank Rowand <frowand.list@gmail.com>

