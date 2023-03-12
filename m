Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A856B6786
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 16:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCLPeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 11:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCLPee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 11:34:34 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97A16EA9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 08:34:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so8132324edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 08:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678635272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ksvn1qLyFWFuPBY6uKwSYze+p9CmBi8BDb68DqvsMsE=;
        b=zMvjqsjYAeUA+vFEKA2/S732aWQkr7mHojBdCbfp/P5tAsIjgg263Mt5bn49sSZBb7
         rGG/9cDUlNCf2mNlK5HFAS7wmKZJKWNY3mPm0nGZQg+DywTeXevUP/PLnDpf1GNnX/U6
         XnxuMLELqmdZkD5saATcNR2nAKYbzQjGYyj/K0jnSfmmfaTqxWKGLX/tiqZ6rQJkfbln
         3Uc080pwtvAvkd4P+a6XFK5qn43ieR6RzIhSJQPJbLYchWsUgzYtmwS13oq73r0SnZkI
         zCYhvu+cuelx4XbGAbNynjlfWd6nK8umC2+1NZzP7hMSj/vYvi94ehBepn2ua80hPJmR
         w6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678635272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksvn1qLyFWFuPBY6uKwSYze+p9CmBi8BDb68DqvsMsE=;
        b=NFmpuySeJIHNrKiIIgaUWZl9WfPRln2LEKMkLZQjN0ix7wOu33hqq+ZBdGg0kqn6Rk
         VjEN10hvzJsPgYeiz1LzX5fH7Ic8X277wF0LKM09iPfe6sl5Zd9S9/8faqvDVvnYBXL1
         XDcMLalBtf3i5uUt8gNArlrYFsUZG0EEWPzLNt1+rB+RC45TG0X2GT7ubwErHA2cS95W
         ypqy8ofaFzzz1f7A5L7AjTUnvXzXBn0RbNNOTKkqlQM9bX7BDrA675gcAZKMCGqxw4y9
         WkMeooBcStqCPpKinRj/zaKbiONk2RdTTnaoXMkr0PiOqjqYQ4TxgStHHGznBxUcisME
         w1bw==
X-Gm-Message-State: AO0yUKWWlCVD9tNf8CubgNOrYel3E1wbQtSlN+CDIYKUJ2+KhQmhyLF8
        533n0q/CE0/239mzjzMN3CScjg==
X-Google-Smtp-Source: AK7set8VSGMSRJL8L749CvyrBt04OYaMMELy6gEabbN4Ic/q95eM3v++xTHbXs/hDkzQU6NCgYO/Tg==
X-Received: by 2002:a17:907:8746:b0:8b1:7fe9:162e with SMTP id qo6-20020a170907874600b008b17fe9162emr35320405ejc.47.1678635272168;
        Sun, 12 Mar 2023 08:34:32 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id z2-20020a170906668200b008e0bb004976sm2312723ejo.134.2023.03.12.08.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 08:34:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] iio: dac: ad5755: mark OF related data as maybe unused
Date:   Sun, 12 Mar 2023 16:34:27 +0100
Message-Id: <20230312153429.371702-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused (of_device_id is not used for device matching):

  drivers/iio/dac/ad5755.c:865:34: error: ‘ad5755_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. None.

Although Jonathan expressed need of changes here, they are a bit too
invasive for me thus I am resending it only for completeness.
I understand therefore that patch might not be accepted.
---
 drivers/iio/dac/ad5755.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index beadfa938d2d..a6dc8a0bfc29 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -862,7 +862,7 @@ static const struct spi_device_id ad5755_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad5755_id);
 
-static const struct of_device_id ad5755_of_match[] = {
+static const struct of_device_id ad5755_of_match[] __maybe_unused = {
 	{ .compatible = "adi,ad5755" },
 	{ .compatible = "adi,ad5755-1" },
 	{ .compatible = "adi,ad5757" },
-- 
2.34.1

