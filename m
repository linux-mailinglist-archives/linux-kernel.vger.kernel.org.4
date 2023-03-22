Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9426C4952
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCVLhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVLht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:37:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43835C9FE;
        Wed, 22 Mar 2023 04:37:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eg48so71466911edb.13;
        Wed, 22 Mar 2023 04:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679485067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ufD/aLu42UHkIOODHSMH1/E0WYEbXvQf/CWdu58h154=;
        b=ompbDY5ua/bSoxyasK11lHpffoErOOwV2sBWnSJqBvy51xtNqXaapwLRZrKeKi3mrR
         lNAOOm4shWIJvpM5pTscB2jGgPDcmDhRGOyYAHh7lagLbVXoLcedd9ImA98ydNxQ/p7W
         PAUwOKN9GLggsPbliQrOT+3/ILdW0lbU81Z8+IJGy47eYy7z+Qeogu8inDAqVsx7oa9O
         3BccEVB5K9DLCK7iQ/p5XuH6qy9D1eDD/ZFJQ7Xl0C3F9S39bYXhzXuoa+yZ7YI/B0i0
         tKmFyGn5+5a0SBtW8XLOtf9uNtF9s2ch0w7dC0+pcHg1sdvUrrYIdl7YGYXtvVCYMsJ/
         JLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679485067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufD/aLu42UHkIOODHSMH1/E0WYEbXvQf/CWdu58h154=;
        b=UfJkqlm/VXEHFO9L+vP/LzWJqpIP3aW4RZJ2Zd166iDGoN7kh2bUEHmGlq51nm5DFk
         CYMigSQeRo9porV+RMwoznzNajo5iPUQGVUnxbVcf1ahXOr0Wcr98LSDqZh+U0ReD2KN
         9o7bcaeo8wGjJw6dDA7QBJJyNUrfq5Sbps8agYGFsfj8TsxgoU5TzfkFbEZS58hIyPs7
         Q71naMY8oh0HoW0qfop6JI9DJP/fAXEa+KyG20SzH9eiw92wdTuy8DNKpDxQc9OFwqn7
         NSdj5AKTYIz/dPeJZCS42vxnbslG8pcohXz1VGlLRd9YyxkoIULmRqJx6uU7NYbjOPLZ
         9gsw==
X-Gm-Message-State: AO0yUKWE3UMZ9f/htFL748i8rZWtuIGkFe8AwRlJbACBAwv59CxqD6Vq
        xXp3SNKrwOxEGkZNfW4Dn38=
X-Google-Smtp-Source: AK7set+QYl632YO7U3z2o4iXfBMBL7347BgKxtJukkmWe5N/saAZ2jkFYmmMBz5K37ItBM9Prns2WQ==
X-Received: by 2002:a17:906:6450:b0:931:de76:c2e8 with SMTP id l16-20020a170906645000b00931de76c2e8mr7294230ejn.9.1679485067081;
        Wed, 22 Mar 2023 04:37:47 -0700 (PDT)
Received: from alaa-emad.. ([41.233.203.65])
        by smtp.gmail.com with ESMTPSA id ch19-20020a170906c2d300b00933d64cd447sm4412197ejb.121.2023.03.22.04.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 04:37:46 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        vireshk@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org, eng.mennamahmoud.mm@gmail.com
Subject: [PATCH v4] staging: greybus: remove unnecessary blank line
Date:   Wed, 22 Mar 2023 13:37:34 +0200
Message-Id: <20230322113735.31214-1-eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank line before struct as reported
by checkpatch:

" CHECK: Please don't use multiple blank lines "

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
change in v4:
        add version of the patch.
change in v3:
        add patches that have same edit in sigle commit.
change in v2:
        add patches that have same edit in sigle patch.
---
 drivers/staging/greybus/greybus_authentication.h | 1 -
 drivers/staging/greybus/pwm.c                    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/greybus/greybus_authentication.h b/drivers/staging/greybus/greybus_authentication.h
index 7edc7295b7ab..48b4a9794d3c 100644
--- a/drivers/staging/greybus/greybus_authentication.h
+++ b/drivers/staging/greybus/greybus_authentication.h
@@ -41,7 +41,6 @@
 #define CAP_AUTH_RESULT_CR_NO_KEY	0x03
 #define CAP_AUTH_RESULT_CR_SIG_FAIL	0x04
 
-
 /* IOCTL support */
 struct cap_ioc_get_endpoint_uid {
 	__u8			uid[8];
diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 3fda172239d2..26d39e08c3b6 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -24,7 +24,6 @@ struct gb_pwm_chip {
 #define pwm_chip_to_gb_pwm_chip(chip) \
 	container_of(chip, struct gb_pwm_chip, chip)
 
-
 static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
 {
 	struct gb_pwm_count_response response;
-- 
2.34.1

