Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EBB6405DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiLBLca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiLBLc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:32:29 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE7A9854C;
        Fri,  2 Dec 2022 03:32:28 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id c14so3241901qvq.0;
        Fri, 02 Dec 2022 03:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kKMmcMkr+j9BB+n8Fm2ml56npFsgtQtlINX/YhhToLk=;
        b=X95XJiV6MMyJnPyOY2F5zvNYMMJ0xjdXsvtJ8JBGkzMeaIAGMLZsnclKiiCpPB8gcU
         tpAqtTeN3xTKacRPkIDmNF/2zgOQm2aAiu2rE44OhOxNWXa004rtu/iIZ26Pc9fqeE1/
         NNjChcOSbPJ3Mu7pru9XoFd6OeMLGEuzGSEp/6FWvQAvaNMBIMhwhoZGmdunJk012iqz
         wcbh92FuKyfrB6kR20vJQZdtLmPBvSqTopVz/qtgRU1S7aRqIWdxUdJI4AoVzuuKoKtY
         /WJ+1TT7EkMHuQsKBgjirfymnBqlsOV/Not06zlkDy9I1IJcOCU0TFepmVErJF2pa2ch
         BG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKMmcMkr+j9BB+n8Fm2ml56npFsgtQtlINX/YhhToLk=;
        b=klEcZPYtkKMAUNXfDZbA+e5SjGy6pxFaGQZd93FPY5dZ4K3OrZd/2Czfxa4fEfIJ9p
         KIdM7UpwvoD8wqcy8LvsVYmhsK0qH9YLZVcI36aVFK4+/k6V0puUG6BHKbmR9erRetkA
         6rtQj7RVtbKJSmrCDlLmHhQijbDcnk2naOD86dv5/SFbIdjLRo6MOjdZuYPuFkY7irjS
         n7Cmfm3LOFMXwbmjf8QlNMpcADBfplG0bVLC68UyAnYUiQcYTSdqLc8mzRr+ead8KjPz
         3t1/mD7h1vbctFx4JyiByDJeKeKBw/23CjMfFYI7K0HfvmhtWaPnzeWhxfXojsH4Abfi
         5FAA==
X-Gm-Message-State: ANoB5pl9niY07WtwfQh4fbb957iKhSbp+8QIbKqMrQhUZLmMzusAP0Wb
        M4Jz9pKUJS4X9RvGWugY2I4vrCe+aFE=
X-Google-Smtp-Source: AA0mqf40s/y25dCbY2LYIFM2o0OtbxByBlz0Fo4ZzjflEFdFt5yZx6Ha4X3P6h5vX84X1ZmjKtxZVw==
X-Received: by 2002:a0c:fde3:0:b0:4c6:5908:84f0 with SMTP id m3-20020a0cfde3000000b004c6590884f0mr63424362qvu.9.1669980747169;
        Fri, 02 Dec 2022 03:32:27 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab ([96.237.180.62])
        by smtp.gmail.com with ESMTPSA id x9-20020ac85389000000b003a530a32f67sm3904772qtp.65.2022.12.02.03.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:32:26 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, lee@kernel.org, lee.jones@linaro.org,
        Mr.Bossman075@gmail.com
Subject: [PATCH v2] drivers/mfd: simple-mfd-i2c: Add generic compatible
Date:   Fri,  2 Dec 2022 06:32:26 -0500
Message-Id: <20221202113226.114465-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices may want to use this driver without having a specific
compatible string. Add a generic compatible string to allow this.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 drivers/mfd/simple-mfd-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index f4c8fc3ee463..0bda0dd9276e 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -73,6 +73,7 @@ static const struct simple_mfd_data silergy_sy7636a = {
 };
 
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
+	{ .compatible = "simple-mfd-i2c-generic" },
 	{ .compatible = "kontron,sl28cpld" },
 	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
 	{}
-- 
2.38.1

