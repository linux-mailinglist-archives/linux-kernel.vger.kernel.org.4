Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773216D6A73
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbjDDRXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbjDDRXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CDF59F4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:51 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so133635552edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1xH/p/sJcwkb7exDMsp+3qcLqt43HDr7CjsEC4aw8I=;
        b=TYpXPoEnChRyGVDdjx8vg/tZq8C6uccRZO7NvMmtQVYiIkQjfM+PCsaX2iYLrO30bT
         zASMICQzWbQaawK9s0Gl8R5nsgNDwDUxQe1xs8Wd3K3OKNpjZPVIRGUhmDQd28At3hLD
         Xi0MA2JxiarAERyCVMJ1N5H9y9Mgdp2Ca0QkIVOsecyj0OCUz7Vwj9nGeyjiXVCJ6Z+m
         /DxL6QmQK+NAxvqZWboPSWXj3Zu4YFIlDNSDoLDmF/3BDUWxnEfYYJkY8UZAHTwPExnQ
         OUucVE/Ev0MijRNmf2ubs6oA9fwRvwGRSVjdyIuntwucth8tc7tH5sb154a4fxF8yvrr
         GIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1xH/p/sJcwkb7exDMsp+3qcLqt43HDr7CjsEC4aw8I=;
        b=wSC3W5VtEQjT5+X0F8ngtZ5/8sUhIh475u+/NUqYxhugR+SFEvcp8IRnK5U9Wmhwha
         Kfp35PglTqwgryGj+DASDQ5nl6IbHoK7VFCheUHQyv5E80T8OQT7X/JYdNOOz8XrbOhS
         uoU5EfFXgfBJWHJnjEjepbMNiGdgfF7QHb0PCih/vCifcFUPPKWSXVziLx2uwdmAB8f+
         WujHJxs3juA1Hx2my3O5euB69pPrglX0tLyKXJXe3vBqm9rcU8JUHjo8lSFHDLtk81mL
         0O2PyfLOgE5R0WWFLfyWXJupKZFa8BHb8bo8GOhl2Xdttiyg8Fdcq5MRcDy33JQEuuhF
         b3Iw==
X-Gm-Message-State: AAQBX9dWLVsQbwPro5wx9QUkIUK4BUXbgH80ItUFbTK43E7QIJP2JqHV
        GVdMxeuKc3hi6f7Q0zWMpTlN6Q==
X-Google-Smtp-Source: AKy350ahAasKv6PwcmyWbpR+6xa8Ed7QlUMV4MgrUUp1xt8MQ6kS+wty+0DvWuqWDlLMnkioqwxzGQ==
X-Received: by 2002:a17:907:c30a:b0:8b1:779c:a8b1 with SMTP id tl10-20020a170907c30a00b008b1779ca8b1mr367648ejc.5.1680628970787;
        Tue, 04 Apr 2023 10:22:50 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:50 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 20/40] nvmem: core: provide own priv pointer in post process callback
Date:   Tue,  4 Apr 2023 18:21:28 +0100
Message-Id: <20230404172148.82422-21-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

It doesn't make any more sense to have a opaque pointer set up by the
nvmem device. Usually, the layout isn't associated with a particular
nvmem device. Instead, let the caller who set the post process callback
provide the priv pointer.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 4 +++-
 include/linux/nvmem-provider.h | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index fccb2728193a..212c5ba5789f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -54,6 +54,7 @@ struct nvmem_cell_entry {
 	int			bit_offset;
 	int			nbits;
 	nvmem_cell_post_process_t read_post_process;
+	void			*priv;
 	struct device_node	*np;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
@@ -471,6 +472,7 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 	cell->bytes = info->bytes;
 	cell->name = info->name;
 	cell->read_post_process = info->read_post_process;
+	cell->priv = info->priv;
 
 	cell->bit_offset = info->bit_offset;
 	cell->nbits = info->nbits;
@@ -1568,7 +1570,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
 	if (cell->read_post_process) {
-		rc = cell->read_post_process(nvmem->priv, id, index,
+		rc = cell->read_post_process(cell->priv, id, index,
 					     cell->offset, buf, cell->bytes);
 		if (rc)
 			return rc;
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index d3d7af86a283..0cf9f9490514 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -20,7 +20,8 @@ typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
 /* used for vendor specific post processing of cell data */
 typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, int index,
-					 unsigned int offset, void *buf, size_t bytes);
+					 unsigned int offset, void *buf,
+					 size_t bytes);
 
 enum nvmem_type {
 	NVMEM_TYPE_UNKNOWN = 0,
@@ -56,6 +57,7 @@ struct nvmem_keepout {
  * @np:		Optional device_node pointer.
  * @read_post_process:	Callback for optional post processing of cell data
  *			on reads.
+ * @priv:	Opaque data passed to the read_post_process hook.
  */
 struct nvmem_cell_info {
 	const char		*name;
@@ -65,6 +67,7 @@ struct nvmem_cell_info {
 	unsigned int		nbits;
 	struct device_node	*np;
 	nvmem_cell_post_process_t read_post_process;
+	void			*priv;
 };
 
 /**
-- 
2.25.1

