Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F213B60C4EE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiJYHWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiJYHWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:22:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3539C2E2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:22:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 21so931333edv.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0YW33z+5sedFd6ykp+dEMDyxDxlZxC4lhugdd/BGTRU=;
        b=vyxS4CY75IATziN/PhHdYVqT++bTwiQRXDL7wsyzFQhRR+3H6L9EebJNxg4cN7am0C
         3IIy00jinrYgXKW+ovL+9/P4rCFOpY0QOmiVIoSBTWU25qyv5pf1lAvMTKtd+2YmUaU2
         k717+5J0OOAtLoQE2eMSqBV1Gm+kyJCgTNq0o2Ti5PzQ1V0JDI5AcXoEjCpS0PG5kRhD
         TZHHdkwv+6SAGF57ChPsA2EI0/v0H1TtwEnPvCUXuc8waXZS5tjbr0cvQc05yPX4RWrL
         SCsJP5oNjl+sjLj7SwWgMNwLyXbX2J9D0yOTLRQ7anpj62+Qpd0ztDF8PPD41UjrJi94
         sJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YW33z+5sedFd6ykp+dEMDyxDxlZxC4lhugdd/BGTRU=;
        b=ncV1JhwjWJEiBS3QQ8ss/m8NkO4+4j01Mo+ijGBwrQ7dHmTudQNnIUC4BX3UND2cQN
         xB5e0pgHzYXhINImjUa3CjJ0CSsQepU8DoGrx/U7aCHISd6jmFnQ8tABCSmgZx0mRROn
         d88hiK99y56y6MrX5tfke7U/bNRPMiCF/pSb08mhHQpf88xPbuoqsSnTvQnPJPdECZtZ
         LGgL8Vwsb8VEHAXYtGGftKpCRSSokre9bYOBPldR1NZaIc+xu4KpCbZ2UAQGCQg3bJvT
         wKx3kf+vo7tff6GoOpPZ6cmMFOqbMeKWE+paVhxlpUuD3/iB7iFLs+R28wJcTW4WNPkv
         jIWw==
X-Gm-Message-State: ACrzQf1vYrpPiIWse/fuPqey0xWmTGUVoqhIaCDV4YoYYM3wvuC5c6xW
        UAZ6ZWvHTxamijB1WruqSnjmXNf70AJl0g==
X-Google-Smtp-Source: AMsMyM4iRLDXopCBe81cYXT+oZ/9Gj5EeyPKPZApZMgNAooqIRSb0uZnK8gR20R2QlMRT/BkA721QQ==
X-Received: by 2002:a05:6402:4411:b0:437:b723:72 with SMTP id y17-20020a056402441100b00437b7230072mr34992483eda.38.1666682531897;
        Tue, 25 Oct 2022 00:22:11 -0700 (PDT)
Received: from localhost.localdomain (hst-221-6.medicom.bg. [84.238.221.6])
        by smtp.gmail.com with ESMTPSA id e8-20020a50d4c8000000b004588ef795easm1091522edj.34.2022.10.25.00.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 00:22:07 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] MAINTAINERS: Change email for Venus driver
Date:   Tue, 25 Oct 2022 10:21:55 +0300
Message-Id: <20221025072155.2823985-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My email at linaro.org will be deactivated, change it with
my private email.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index df5969d88707..516b2dc69db1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17153,7 +17153,7 @@ F:	Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
 F:	drivers/thermal/qcom/
 
 QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
-M:	Stanimir Varbanov <stanimir.varbanov@linaro.org>
+M:	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
 M:	Vikash Garodia <quic_vgarodia@quicinc.com>
 L:	linux-media@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
-- 
2.25.1

