Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5FB7304F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjFNQcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFNQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:32:15 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426E91A3;
        Wed, 14 Jun 2023 09:32:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686760325; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=svbPe323u+L4XXWIhtfqYnowXOJoDHc8+oHjEl5Qt7DhVydd6t1Hh+COLm1+mKS7F9
    nxe9UJaA9459NAlfTLRRX3beZeEwqB4JeZv2s0zb++8hzTfq32QdppKPowfb+eonzlpj
    CSRkjH8EmZr0hbtAnfP+CxUJ1y0bfI4NXZjWjiNLNxqEQJ7wZT/x/9gpuv/tIneJKOrB
    ONWfYcRxPlGBgJ5m+iCBR/JbycDSUA9Z2u0UxSdeijjM4gMNN84giG6+To6BylzJzbPX
    Y3Bo747cCRFB4h9HnoaWSIBxzVnEFJXunY3yMkPOVMdDtmc9jcoxuLaaogDlM2Clw2lS
    K9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686760325;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=7CZkh2tsWk1KLyX3MYfuwePFgnEoOOmuyhey9E40TaI=;
    b=pLWXrq/l7HJWkttzP11zi3TVWFU7s2t7O5HR6TkhIo8FwgPP0hOF62j6uYLu8P+1Or
    NUSI4BWpc2JIIUOMG0M+IsajVrkVIceE+yFj/ABzPuNTOW4aIYQJmQO3y9p59TceoB2i
    +tBu0VrHJGLo9MwDm+vMlzEyCQtMqCXWI9ijy+XJGQmXjQMMI2bCd04OQSgB6KbuUejo
    jYRpvwe9sWpRTDO27C3YUJXKFK+wNRnw+8HoHJyo8sfGk6UgTCoQ4cS4rQS42yk8T2cU
    L86gmlZ3rHV6wXr7LXuV+A/xbtxlrJrinVDsvw8w0BbSTH71rnIUU85EhlepmLfuN+Cd
    CunA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686760325;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=7CZkh2tsWk1KLyX3MYfuwePFgnEoOOmuyhey9E40TaI=;
    b=JcxBcGPaZqH2eE+/LNMff7DL9IRVol6Q5Dyp5d0r1AXlaWe3GPYtFOPYuSj59zdIud
    Ec6NRiwXwuWG0OF75PvkU3bcrZwNZwpM3MyFinfsIqhjIn7GFzZoPtFKLswbOjvenT9F
    vIdutPC4AOd4HjQcwXwo6HQbVKhsbLn34Pa1XbHJxOm7wKqlACrYKVhd02tgNjYNv7P1
    QshQOleyHGBj69Wyot4xm5CwD6AsM3nVXEu+nvjgfBAL8wg+MChRry1/s1RUC6LleoCm
    9Nfck7F1gJt6I1Dtnbo1wPEppR7MOUNVan4H1iXToDs/NwtKU9VjsRqTZZlqZJ/LkCOt
    1a5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686760325;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=7CZkh2tsWk1KLyX3MYfuwePFgnEoOOmuyhey9E40TaI=;
    b=qciHgIC2hl9TZ//hlpzHC4kgh7sXed9uT58ElvtBAAxkJk5E1j6V21RwxcAMFLGuiD
    f+f/EvEkWMXCH2I9OcBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5EGW50U3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 18:32:05 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 14 Jun 2023 18:31:54 +0200
Subject: [PATCH v2 1/2] remoteproc: qcom: Handle reserved-memory allocation
 issues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230529-rproc-of-rmem-v2-1-95e39b959585@gerhold.net>
References: <20230529-rproc-of-rmem-v2-0-95e39b959585@gerhold.net>
In-Reply-To: <20230529-rproc-of-rmem-v2-0-95e39b959585@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If Linux fails to allocate the dynamic reserved memory specified in the
device tree, the size of the reserved_mem will be 0. Add a check for
this to avoid using an invalid reservation.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
New patch in v2, I wasn't aware of this until Bjorn posted a similar
patch for rmtfs:
https://lore.kernel.org/linux-arm-msm/20230530233643.4044823-4-quic_bjorande@quicinc.com/
---
 drivers/remoteproc/qcom_q6v5_mss.c  | 2 +-
 drivers/remoteproc/qcom_q6v5_wcss.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 70bffc9f33f6..a35ab6e860f3 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1932,7 +1932,7 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 		return 0;
 
 	rmem = of_reserved_mem_lookup(node);
-	if (!rmem) {
+	if (!rmem || !rmem->size) {
 		dev_err(qproc->dev, "unable to resolve metadata region\n");
 		return -EINVAL;
 	}
diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
index b437044aa126..9edab9d60c21 100644
--- a/drivers/remoteproc/qcom_q6v5_wcss.c
+++ b/drivers/remoteproc/qcom_q6v5_wcss.c
@@ -882,7 +882,7 @@ static int q6v5_alloc_memory_region(struct q6v5_wcss *wcss)
 		rmem = of_reserved_mem_lookup(node);
 	of_node_put(node);
 
-	if (!rmem) {
+	if (!rmem || !rmem->size) {
 		dev_err(dev, "unable to acquire memory-region\n");
 		return -EINVAL;
 	}

-- 
2.40.1

