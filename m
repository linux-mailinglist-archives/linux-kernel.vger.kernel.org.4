Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E266C2562
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjCTXFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjCTXEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:04:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292EB2F05D;
        Mon, 20 Mar 2023 16:04:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b20so20086410edd.1;
        Mon, 20 Mar 2023 16:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679353492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZHVKRyqUkVQgHIPcnrjM4VftHtoW1MPmlfE9Rq46vI=;
        b=c+NNbwr/+NJQq6R7u+ToUNyv1k1hJDK98hxkI8xpb6Sz8cHGTsBQ1Am/YOXVVijHnK
         n/OZGpTKM9gZD9bgPOe62QJGu7dcQkGOpyKZ2H60WsZadCeGE9vKA4jpFUmBtm3uM0/S
         ukg7FKm8ZZt2dGFVfs6GLO6lFZ89si96Q6vogwbSCBiNa1JPhnsXgk58cWLe6znvtuTJ
         /pXesrDYYcku9sOSU21Dp3+O+1gl81Rm40MB0sOI1mXayrykUCa4E2lOGXZCAZOJgOHq
         u/HutsC3loij572OEhBJFAc5vRlyfrbIn4Yvs0b0unBx4WaXVkluJF2jPju8T214mjlV
         0pEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679353492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZHVKRyqUkVQgHIPcnrjM4VftHtoW1MPmlfE9Rq46vI=;
        b=UkTx2JeZTn2ARPYbCVpvUCuOZhDCxX+r5ma5npTTjUS1JbldPyHRVx6YuH/SJEioYf
         lVJOpyxqCfGUWubuieWR9QIAkGLiS90M8zRIFLtQJ/y7MIuenjyR7CNEnxPCREC8EZ0b
         EyoWSWgvBwIX1WxgAd4v4N7I/CC6J4fuE/7kN8yzYkvyVuVKeaFGPuU2SeKvD/kl002l
         xeKh7jjxBpKtf1ixPPvGjs7n0XRY7YRc940etJ2evhqJr8YawQbrnIgI6E21U4wXqqh0
         NP0MuWe7yo7elm+7vX6GNC291nds7W5Df7z3LU0AZHfqzXj4p0CC7wlXV1BScfOeAVKZ
         p1Qw==
X-Gm-Message-State: AO0yUKW0mSlM5XJ64581SlsMwn4sk4LHVcpa1jVwloddL51JWuPVd5WD
        8akg80PzW/ZVqdgIOCQEtcg=
X-Google-Smtp-Source: AK7set+wgkZkpddvtjrwRkWTzSXRdr48NS7qmGH/+RLgQhNolVcXMwNfqT7C+AR6iDCzQz0vkD9e8Q==
X-Received: by 2002:a17:906:594e:b0:8f5:8da0:a482 with SMTP id g14-20020a170906594e00b008f58da0a482mr1279214ejr.25.1679353492536;
        Mon, 20 Mar 2023 16:04:52 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090690c500b0093188e8d478sm4956403ejw.103.2023.03.20.16.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:04:52 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        vireshk@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org, eng.mennamahmoud.mm@gmail.com
Subject: [PATCH 1/3] staging: greybus: remove unnecessary blank line
Date:   Tue, 21 Mar 2023 01:04:32 +0200
Message-Id: <4ea07eb91d7065d81799ad684741ace685a38088.1679352669.git.eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
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

Remove unnecessary blank line before struct as reported
by checkpatch:

" CHECK: Please don't use multiple blank lines "

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/greybus/greybus_authentication.h | 1 -
 1 file changed, 1 deletion(-)

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
-- 
2.34.1

