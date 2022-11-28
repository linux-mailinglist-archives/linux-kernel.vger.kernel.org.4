Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD7163B628
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiK1XwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbiK1Xv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:51:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6993121A;
        Mon, 28 Nov 2022 15:51:57 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q7so18644602wrr.8;
        Mon, 28 Nov 2022 15:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T9PeG33kXwVJumNyWLvqPW0QBrgUXmRNtC0tTxLZOs0=;
        b=LHCZGbP1WcodVWuYoawEeW65BtZaS/xkusakUDkQW5KXTzlq9d8fBlHzZpvEVZQlP5
         asZVF3PR/9cVjhJDQtm4ppEJImlW+wisCS11ave5+NhXtqqJczswHfI+grnV1KZPDW3R
         OMhYkH/pzJjiDySTdkvYxihCjMYm2hcaYFN92H5iMfUlhi3K0Ihkd4KooWAsGHHA4vZw
         82FVfw/ZJ14Ecgb77dfPmnVzQB1LnaY6dL81f8kQEzpjLPavZlRTdQGT//d80vWHZPcu
         ZjT3AxEbOXUgeUydEjOvxywHIHRTNS4Xb7Dd5zBjZ7+5zKWV+tYR5rqxuD+87WjszgLA
         jcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9PeG33kXwVJumNyWLvqPW0QBrgUXmRNtC0tTxLZOs0=;
        b=n9o5/7z0gN92O1L9wpzURE2x9iTDAhmjcnzdvJeJIUobu8K3qgJCM9n3S5rFiUrRdu
         qbWeVdUNyp5Q5dJXJ+Q3wcTjXmS4AtpoY1Bs2RJf1KFVklne0VHRk/2TYxLxC+9ETRJN
         kc3hlkZFPAf524M7svFA+OOahE3wClh0e9MlVay0FiMFBrNPt+W/bo0Y5tkSQ3FsUgF0
         i61ZTnWb/m9pCECuDvnXKBwUzvXV7HaV+FRibr5qx29Cv5gX/zkSqjSAaJmvvc4Ln7ue
         ekAcNxlNZB+nR0bdRtMg7YFY+VvAEZKQKtabv8sui0dEFiBnOAfvBbtOUkU4yYimoqrb
         XOJg==
X-Gm-Message-State: ANoB5pmMMYwxcwbYb34LzCT5tbyJordCHtH6tXYWJ/tDBi4uaWGHKL5K
        yPCL0v0ip8E3v+XSwzxAvfs=
X-Google-Smtp-Source: AA0mqf7ONpFyFxUZ+KuDI6MIEzqUgf/Jtmlq7v9vIWVmI+qoqhv9zTBgEuZLlj3HE4RJc8TrRZooSQ==
X-Received: by 2002:adf:b30f:0:b0:241:bfbe:81bc with SMTP id j15-20020adfb30f000000b00241bfbe81bcmr23228748wrd.603.1669679516210;
        Mon, 28 Nov 2022 15:51:56 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:a876:e68e:5e5f:704e])
        by smtp.gmail.com with ESMTPSA id w13-20020adfec4d000000b00241dd5de644sm12035140wrn.97.2022.11.28.15.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 15:51:55 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] media: platform: renesas: rzg2l-cru: Add missing documentation for image_conv_irq
Date:   Mon, 28 Nov 2022 23:51:42 +0000
Message-Id: <20221128235150.27267-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add missing documentation for image_conv_irq element in
struct rzg2l_cru_dev.

Documentation needed to avoid build warning with W=1 builds. It doesn't
really add any non obvious information but good to have it anyway.

Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 5cb4fad6d6e0..0b682cbae3eb 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -68,6 +68,8 @@ struct rzg2l_cru_ip {
  *
  * @vclk:		CRU Main clock
  *
+ * @image_conv_irq:	Holds image conversion interrupt number
+ *
  * @vdev:		V4L2 video device associated with CRU
  * @v4l2_dev:		V4L2 device
  * @num_buf:		Holds the current number of buffers enabled
-- 
2.25.1

