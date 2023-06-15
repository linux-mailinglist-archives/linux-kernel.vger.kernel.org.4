Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C196731E78
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbjFOQw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbjFOQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:51:15 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E72C2D43;
        Thu, 15 Jun 2023 09:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686847856; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=d3zPtsVTgD5hyhwoqPWohda0jXCYjzNRYMKluicmWVR1TwPEu7Fq2N9+sKnOuvCbRF
    gwNm4j06rcJ5wNJt9g8A46epgsKNnfEkCt7pGRPMBSpJ/EsOSe0q33Xj2gI6zte/++bz
    SlLinn8FSifsgMwCT3xEuJfpCFPLuONPtrEi31/UU76OaIsArOTrs4HBZGCeYaSo5BDH
    uknULAa32I7b1V14w3IH+NPpe2Wkw3YWS5bOvYONs7ihOQa/QVN1zz/fBgmIQvK5tD0f
    S7JZD6ON+PgBlql/QzNaPQ4Avi+0P7q7L/VWdcuizaHa49igAfPt0Qr6wqYPWEdBWCe4
    Pzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847856;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HwHhKZChtnT5QeLJ51MFqhGAkBh98wtO5B8+zILKtRo=;
    b=YEmOnax6A7URthJUd29To6B+zNhkZgMYYYVUCoKnyEOYrAgan+5UG2gMbNfHTilJUk
    NJ+O6s5bGZIci14B1c+Azhi0lN7/dnc5j6mylC4jOivXJDYFlf7H9aMcfdf2X6mZsQL8
    3t5vx000QPr7zbuc+ocOCKuJCZxZJ5/1MoiwuVpqyUxzfcWVB+EQJEzMpK4tPFIeTt8+
    oehEfsFCb00b7zlgZLhkgBsgdq6awFoj/8kniCiqEZVfi95nssY3LguUQCmdU7EVTzye
    8Iwu9Bz5D/caljT8QFGN4yvGOyoMMo6/h3YCmcgcYnZD8eapMh9y/cukYupfmxcgxsa4
    5RVA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847856;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HwHhKZChtnT5QeLJ51MFqhGAkBh98wtO5B8+zILKtRo=;
    b=d+mIGCIqadkj2FGOHiSdFwtdTQIsGbKU1kbHty7QFv6iqJRqMRzPZGSyRW8AofQyy9
    KsZwrx6EVLojFvoxb9/xSfBjrzK2n/nAl0sRfyNmNjyhf4pwDxGOWUYF4jm6V/YWCmko
    xzc2Jw6Qpd3+F5MFlbVT30qbLDeF4FX+fMvqUfzD/9KPqBGtTn1fEfMHu5EgsjWroO7y
    fEefv3hMi8DD9h8rMN4qFV1IPK7reCvJgoWOSQcj1HP3BKscW1Vhh0ZOcZFUREhENX5R
    nsYlGC5ZZ2wkBYcUAuCCnJ/lf+pxapiH/vkCQxTjVujd6tmeS5VDVJyIScvc04xegT8i
    lIfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686847856;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HwHhKZChtnT5QeLJ51MFqhGAkBh98wtO5B8+zILKtRo=;
    b=5cSU+ysyKfiZpn+t/RszEh5hAqVQrstwj7SWvLSff1RhJo+YBH5v0qIsYXk3sq6eAg
    dQdwBZIARPTBM9FnLRAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOf59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5FGot42f
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 18:50:55 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 15 Jun 2023 18:50:37 +0200
Subject: [PATCH v3 04/13] soc: qcom: smd-rpm: Match rpmsg channel instead
 of compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v3-4-a07dcdefd918@gerhold.net>
References: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an ever growing list of compatibles in the smd-rpm.c driver.
A fallback compatible would help here but would still require keeping
the current list around for backwards compatibility.

As an alternative, let's switch the driver to match the rpmsg_device_id
instead, which is always "rpm_requests" on all platforms. Add a check
to ensure that there is a device tree node defined for the device since
otherwise the of_platform_populate() call will operate on the root node (/).

Similar approaches with matching rpmsg_device_id are already used in
qcom_sysmon, qcom_glink_ssr, qrtr, and rpmsg_wwan_ctrl.

Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM6375 (G-Link)
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/soc/qcom/smd-rpm.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 0c1aa809cc4e..13d8c52330d0 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -199,6 +199,9 @@ static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
 	struct qcom_smd_rpm *rpm;
 	int ret;
 
+	if (!rpdev->dev.of_node)
+		return -EINVAL;
+
 	rpm = devm_kzalloc(&rpdev->dev, sizeof(*rpm), GFP_KERNEL);
 	if (!rpm)
 		return -ENOMEM;
@@ -230,38 +233,18 @@ static void qcom_smd_rpm_remove(struct rpmsg_device *rpdev)
 	of_platform_depopulate(&rpdev->dev);
 }
 
-static const struct of_device_id qcom_smd_rpm_of_match[] = {
-	{ .compatible = "qcom,rpm-apq8084" },
-	{ .compatible = "qcom,rpm-ipq6018" },
-	{ .compatible = "qcom,rpm-ipq9574" },
-	{ .compatible = "qcom,rpm-msm8226" },
-	{ .compatible = "qcom,rpm-msm8909" },
-	{ .compatible = "qcom,rpm-msm8916" },
-	{ .compatible = "qcom,rpm-msm8936" },
-	{ .compatible = "qcom,rpm-msm8953" },
-	{ .compatible = "qcom,rpm-msm8974" },
-	{ .compatible = "qcom,rpm-msm8976" },
-	{ .compatible = "qcom,rpm-msm8994" },
-	{ .compatible = "qcom,rpm-msm8996" },
-	{ .compatible = "qcom,rpm-msm8998" },
-	{ .compatible = "qcom,rpm-sdm660" },
-	{ .compatible = "qcom,rpm-sm6115" },
-	{ .compatible = "qcom,rpm-sm6125" },
-	{ .compatible = "qcom,rpm-sm6375" },
-	{ .compatible = "qcom,rpm-qcm2290" },
-	{ .compatible = "qcom,rpm-qcs404" },
-	{}
+static const struct rpmsg_device_id qcom_smd_rpm_id_table[] = {
+	{ .name = "rpm_requests", },
+	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, qcom_smd_rpm_of_match);
+MODULE_DEVICE_TABLE(rpmsg, qcom_smd_rpm_id_table);
 
 static struct rpmsg_driver qcom_smd_rpm_driver = {
 	.probe = qcom_smd_rpm_probe,
 	.remove = qcom_smd_rpm_remove,
 	.callback = qcom_smd_rpm_callback,
-	.drv  = {
-		.name  = "qcom_smd_rpm",
-		.of_match_table = qcom_smd_rpm_of_match,
-	},
+	.id_table = qcom_smd_rpm_id_table,
+	.drv.name = "qcom_smd_rpm",
 };
 
 static int __init qcom_smd_rpm_init(void)

-- 
2.40.1

