Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7C95FAC11
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJKGDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJKGDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:03:16 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E52881691;
        Mon, 10 Oct 2022 23:03:11 -0700 (PDT)
Date:   Tue, 11 Oct 2022 14:03:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665468188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rte2EN89JRxUxg4Wtg1wYIa3tdrLEl7y80JoncSD68w=;
        b=S2Kul76HybQI0ujUAP3yDltLhQ+ieV8AbIOofPheNhZowkK63Xaez5gothMilW7zrbNUQy
        gUemgkqkYeSHjZm6h14dHJHwMiwFK+asA7MwFcydY/be7Cgoa++j5TZ6BLMMbSuBONDI2E
        Jl+P4/VGq6QLyupyX4XkBwvzMwqmdOc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, chenhuacai@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] docs/zh_CN: add a man-pages link to zh_CN/index.rst
Message-ID: <6e289528ed1b40c1fcc03ea5e854e7c8ba264e67.1665467392.git.bobwxc@email.cn>
References: <cover.1665467392.git.bobwxc@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1665467392.git.bobwxc@email.cn>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu XiangCheng <bobwxc@email.cn>

update to commit 489876063fb1 ("docs: add a man-pages link to the front
page")

Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
---
 Documentation/translations/zh_CN/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index 7be728bed46d..ec99ef5fe990 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -97,6 +97,8 @@ TODOList:
 * 用户空间工具 <tools/index>
 * userspace-api/index
 
+也可参考独立于内核文档的 `Linux 手册页 <https://www.kernel.org/doc/man-pages/>`_ 。
+
 固件相关文档
 ------------
 
-- 
2.30.2


-- 
Wu XiangCheng	0x32684A40BCA7AEA7

