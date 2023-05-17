Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C1B706B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjEQObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjEQOa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:30:57 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FC67AB8;
        Wed, 17 May 2023 07:30:57 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-76c64ddee11so20345339f.2;
        Wed, 17 May 2023 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684333856; x=1686925856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m4G0ffA6zmiA7GH7zmCNMUfYrrJvuole56H+sbXXV7w=;
        b=eT5kHWUFo55SmDc35iD7xK/1mEeYE8kGtY53rC3Sb1A2IjklfvANgMkamm3iTyhZUC
         qehFKlUlF+n5vqwJZ12TElAHVl3WbxNVEXt5hBeWZ+OUxB/IhcvH61MmuY4RQ1KGv7bC
         FEp3XPX65zhltac05BRDePQPq59og8srm6AZ8zakNFF2SsoCEMtID1h2K1f6pKiadHuf
         wJEpCZn7UtyFYkHff9Gq34IqD9EZQfuRCKzrDTUhA5uNZQXJ8F75+g9/v6+nmPEsboTi
         xMIbnCsAeCnGM92eFciAa9sfyK4RaWrZGJPhAFJR/lQsr1wMXB1tW0aKF/1rsYNbrYku
         ltYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333856; x=1686925856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4G0ffA6zmiA7GH7zmCNMUfYrrJvuole56H+sbXXV7w=;
        b=g2GMBT9tT0yjMu5JyY4KNoFBrO13fUlq3Ki7Fj7z+zxwQnZDKynCivhduvTaYHv/xy
         nG+UFd4acKhQ++EIcSHCwWdu6UgZl4DMO4w36Y1SY7iPZhvjD8Auxsdk629Wcgpl2erp
         WUVDvt7r4wvlo2gksH8/kC+ILCUH/Zilg5VafICSJsfDox4strFq9EYBpRkeRSoKFxlG
         gGEj3h267iOaXBaETc/HxTePOtZbSt/skWoYUIneNMTNoi60hHFSxJeizQUl5cqiorUH
         rBqjVwYwoVEs8pEpOl+DcesZip3DPcRxWlHwbL5AODI7u/QKgae14rHU87D9TSEI1Z9/
         R6wA==
X-Gm-Message-State: AC+VfDyOrYpduXU26XJJ+NY2QFQI3v73mXydMzuQPVusdh1hLKbSqAJW
        pJqJz+vUB4fg090NJmyWRoU=
X-Google-Smtp-Source: ACHHUZ6p682nSxZpGqVNGTnWlwaKJsm8R0x2lauLJBIZsfd9OAZwuzm+jcFKbEM9dL4QdZb6TzaBAg==
X-Received: by 2002:a6b:680d:0:b0:76c:8674:81e7 with SMTP id d13-20020a6b680d000000b0076c867481e7mr4727944ioc.21.1684333856216;
        Wed, 17 May 2023 07:30:56 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id g11-20020a6be60b000000b0076f931316b0sm2775923ioh.55.2023.05.17.07.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:30:55 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: aacraid: Replace all non-returning strlcpy with strscpy
Date:   Wed, 17 May 2023 14:30:49 +0000
Message-ID: <20230517143049.1519806-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
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

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/scsi/aacraid/aachba.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 24c049eff157..70e1cac1975e 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -3289,7 +3289,7 @@ static int query_disk(struct aac_dev *dev, void __user *arg)
 	else
 		qd.unmapped = 0;
 
-	strlcpy(qd.name, fsa_dev_ptr[qd.cnum].devname,
+	strscpy(qd.name, fsa_dev_ptr[qd.cnum].devname,
 	  min(sizeof(qd.name), sizeof(fsa_dev_ptr[qd.cnum].devname) + 1));
 
 	if (copy_to_user(arg, &qd, sizeof (struct aac_query_disk)))

