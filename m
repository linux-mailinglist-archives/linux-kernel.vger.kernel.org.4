Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6943661EEE5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiKGJ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiKGJZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:25:45 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6BE18358
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:25:24 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id j4so15969489lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jzp9MRQjovzg8BNVfT7q5u2Mz9rz7xK7aSnH6aL+IKQ=;
        b=BrpbOOAIBgScV4u/8B9HMPNJm7mtmbWK9yr8fUbq/hNPiSowN3/0GpVDkVH51/AZTw
         CfznfFysbj+ePClkC1K9fg0KDZ6fLmg9zeJS2UPS9W2+1Udm7efjvHMRmeTRXb++boU/
         KYsiLecYoyccCEPzvsuHWkfqZlAF4CKSWYm5drYzf9/qa5P0UCvPnoK2ZsG1ttTqhBVm
         dLaMRfpMAMpNQHH6meVUmcNcWuKqLYeNhJ/sdyXNh+dQ3HQi1ufHj9YJkeKn0An9y5QT
         u29B34IcH7fWnMi/dwkX/2WECStNg6Ty3c3z2iImYKdfUhFEtNy6vP/PVeoKaAK/atZX
         /CdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzp9MRQjovzg8BNVfT7q5u2Mz9rz7xK7aSnH6aL+IKQ=;
        b=XHeRBhqDC6ve5F9YxIx4lwRGimq7IIWDi14jDao7nlE4X6zcP0PRvAXeQtuzMpp4ve
         B1lLaBKvTYWC590PN8uX5YNb1JFPM8YwIxW+ege7qpvZrHhD0/oa1/gPRmn02V1sDFEU
         6Le/X/+rkFowv5t2o4smTK6R48OhZkjYxW2m/ySyIjKVN6psElKCmK8w3XM+N1SGGqE4
         MiDQZ4KZzgW860Z0vsWLF7UQfDsdaomAV7z/exxeXjAWmI92hqjORuIaUbYjq60v9D9s
         kt1iw6O1fuLtHmAKss/ELPN1Sq+zRh6M+HnyHAJzF9c/mbOjHtlAEQhirnj8bSk2x08T
         22AQ==
X-Gm-Message-State: ACrzQf0YGtZ2n4l3rd4ES6uciJl04BOHkqH60gEJbwCMnaI4b8rFkuDr
        1+jPQ7Pi/lwuP5abn1A3YjzOEg==
X-Google-Smtp-Source: AMsMyM6rdQchz45OLMip8PQQtIc21znakXUaH2kLPl66OJspBcUv5GyyCC7yvlA/wacC1dlZQFrGgA==
X-Received: by 2002:a19:2d0d:0:b0:4b0:975c:f1cd with SMTP id k13-20020a192d0d000000b004b0975cf1cdmr14362039lfj.361.1667813123338;
        Mon, 07 Nov 2022 01:25:23 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id t1-20020a2e9d01000000b0026fa9e19197sm1126150lji.36.2022.11.07.01.25.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Nov 2022 01:25:22 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update Konrad Dybcio's email address
Date:   Mon,  7 Nov 2022 10:22:07 +0100
Message-Id: <20221107092207.5832-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use my new Linaro address in place of my SoMainline one.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03ae061c5f6f..16751383a233 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2641,7 +2641,7 @@ W:	http://www.armlinux.org.uk/
 ARM/QUALCOMM SUPPORT
 M:	Andy Gross <agross@kernel.org>
 M:	Bjorn Andersson <andersson@kernel.org>
-R:	Konrad Dybcio <konrad.dybcio@somainline.org>
+R:	Konrad Dybcio <konrad.dybcio@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
-- 
2.38.1

