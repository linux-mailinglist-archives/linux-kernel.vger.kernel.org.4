Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20665708445
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjEROwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjEROwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:52:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F4119
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:52:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d1d68b4dbso786886b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684421534; x=1687013534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ps7W4euBnPTypuQ48jqWiVzSPldfhUMwv3snwxq59YY=;
        b=hedsU+5EjGATXBibLsEBR117qR3ng1l4mxOXnuvUpXBTRC1Ybnm6AXilzxo2yN7CGW
         ccffY//czw6Bi66/P6D3kQ13uVVNHKtEMrMSoUgOY4ARN4GtYZliD+VxWyxw/ChOuJNM
         GIupt/1J2Raug6vh00CvSUJe4Kqd73ip50Gw0gSW29KzkiC/U9CALCAA5M0+Qz2g0y6h
         ValE8TpyRilytjdmgbFzyhexQgU+Yvp8rMEr5f6ST4bE6bsPDqf2kjJueHveFQGj9GpK
         r0u/dhef5d57WW6tVU7/WV1Euf59rI9zIbW2JWaujQ2GK216r2FYge8JfVSor3kimTb9
         zT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684421534; x=1687013534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps7W4euBnPTypuQ48jqWiVzSPldfhUMwv3snwxq59YY=;
        b=hi8ux3gsiN66aVhTHLgL/zC2SU5VSkMJ/W5JPNMKByuUJ0Aey2siWH575RzGDnR2ll
         aYL9OG1uQIeb/pML6SzQ1TMZQXJdbPoi835N190wj9mKlrgTbGwHKGa1e+sOgYvoIGbK
         jtXue2QYVoEIE9WiCHZTRZKJSy7N+D8WMPuV/GkT4Uzu5jbmiQ6yj4HlpAomdL4UtAHe
         pK4kok1Q+K5Ku/uHY1OP1+U60PkV6w2cfd7GUgAIakbSAGW9te6/TBenUrZzaAMTJfcq
         OKjEaJPWlao6K42o5euuYzaDcU9yt3GK4uqPTlGcNs3e14S3ub7IsucT9RucSJ/nUYv/
         o/HQ==
X-Gm-Message-State: AC+VfDyb/3+3N1dDQP4R9JBU4aXuf6fMrLsaFvYKZwlalF0Ndzmj55MT
        WJ1n/47R7SEvu2Cl/RE5dr4=
X-Google-Smtp-Source: ACHHUZ6sF60++RITMwmE7PHxBQftVercRGQ0dQRL769ij1imkDmMP4hnEMet45k+CaMg65sIOr1Y9g==
X-Received: by 2002:a17:902:6e17:b0:1ae:762a:b660 with SMTP id u23-20020a1709026e1700b001ae762ab660mr692394plk.39.1684421533749;
        Thu, 18 May 2023 07:52:13 -0700 (PDT)
Received: from redkillpc.. ([49.207.202.99])
        by smtp.gmail.com with ESMTPSA id jn9-20020a170903050900b001ac741dfd29sm1506647plb.295.2023.05.18.07.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 07:52:13 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     prathubaronia2011@gmail.com
Cc:     dan.carpenter@linaro.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        oe-kbuild@lists.linux.dev
Subject: [PATCH v3 2/2] axis-fifo: cleanup space issues with fops struct
Date:   Thu, 18 May 2023 20:21:54 +0530
Message-Id: <20230518145154.33377-2-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518145154.33377-1-prathubaronia2011@gmail.com>
References: <CAJp9fsfJxoY2=fFK3-R_XoDatMB9z5WT4BaeSw3-nMScicERJQ@mail.gmail.com>
 <20230518145154.33377-1-prathubaronia2011@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required spaces for proper formatting of fops members for better
readability.

Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index d71bdc6dd961..59e962467a3d 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -716,11 +716,11 @@ static int axis_fifo_close(struct inode *inod, struct file *f)
 }
 
 static const struct file_operations fops = {
-	.owner = THIS_MODULE,
-	.open = axis_fifo_open,
+	.owner   = THIS_MODULE,
+	.open    = axis_fifo_open,
 	.release = axis_fifo_close,
-	.read = axis_fifo_read,
-	.write = axis_fifo_write
+	.read    = axis_fifo_read,
+	.write   = axis_fifo_write
 };
 
 /* read named property from the device tree */
-- 
2.34.1

