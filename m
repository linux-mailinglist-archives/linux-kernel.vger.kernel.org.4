Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43971721F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjFEHK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjFEHKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:10:21 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF62E49;
        Mon,  5 Jun 2023 00:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685948956; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tEseBMuPiyHNkdf3PJVTdgcri1s7a/qwOZ4iHULrsTwXURbFpBHrAwtUVwkjnUdITH
    DJ8QKFpKujtdfD+SsQtcfQVeBlAftQ51zRO2+sMYrQPGzddpZu8QEzQPZksjSc6lWPmE
    tuswhqTx2ZOGo14qF81z6Yh64srURVGHjF56hcMZG7tu1aWsXZ74izG8miL3AmQ50m5F
    g4r/8Sit8awpzb2MJzHw4tqbeCc2gfZOMTyHawoTgIGuaBK/NnxuKMLcBeF8SsG7z7le
    g8Hty7caITEHcaygOZnmTAoHhblGQRw4WY7y2QBW65MJLowNqLQGDElfBDtwbObv6C8k
    XpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948956;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HXm1VPTXAHe9VxfUC/BDKK9cTt+IOrtmh6/3aJodKcc=;
    b=M+4XqxZYCdp6Yctru+wnT/xOTwkNyA7HTDChDXWXr41Xj6Mw05EqD/tVK7CmOEOCS8
    s5utTkbyK9RHv2UMBkTfqyr5GfH7zsNKXOTDd+OsWB1sEUxqO+JtFBk6R1DeFvuBXDIA
    qFZGWkwWHd33yjo2hUcRoWUwIzxjdbM8yB0yavICkZEhYWvAbbUQzOcVnebz5hytCthB
    7PIfv9Yf3s4xW9zqGTH1v5rTHESY4ND37XE5mOxKM9b4qzyReva9xu+Gh9yGqCZDuVQK
    FKNYrYvppMc/ZfZ2FrN7Ph7yyzpwT11n4ouGwjT+saxUXRw5alUHPIMzIKwG8vbVL84w
    jqzw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948956;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HXm1VPTXAHe9VxfUC/BDKK9cTt+IOrtmh6/3aJodKcc=;
    b=i2xM3Mvkukrx6fAcPtbzSw8iMYg/lRfWBtU089P4toggKVpFl+NnTjaUmcgVaKU654
    S3OcMkSOUXNIV0HjBaBqEUFKdQ1b8eUjK//2ZglCwIk538CbOFNeiy9bO4gVeyex/55e
    /VpfNS9eQWDfDM9/2OdhTm5yNpC5zouF5SP1liJ1Zqr1I65km22/YXclC2KH8YW0SPWb
    QuC+U5oaJ0yLuMJqrs77aGaZ2OolaWsvKj+nTycQ4QonfujMhtcXDPfkklv7rm4NXYpX
    H67kwEL2x6TedLFvZy1CGy2OxC12NPuWtrZtE6xFLEYjgQr0qC5AZqmY0UjAWHNVIeAH
    wmbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685948956;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HXm1VPTXAHe9VxfUC/BDKK9cTt+IOrtmh6/3aJodKcc=;
    b=vRpSUz2N6xDNY4VgbmBeVOdliW8t6pv1YcqVpCdV1VN3fihJg9j8wgbvSTeLDih2OB
    DPb6s2wDBUWMZziRzmAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL5nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5579F8a9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 09:09:15 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 05 Jun 2023 09:08:26 +0200
Subject: [PATCH 10/14] soc: qcom: Add RPM processor/subsystem driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v1-10-e0a3b6de1f14@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
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

Add a simple driver for the qcom,rpm-proc compatible that registers the
"smd-edge" and populates other children defined in the device tree.

Note that the DT schema belongs to the remoteproc subsystem while this
driver is added inside soc/qcom. I argue that the RPM *is* a remoteproc,
but as an implementation detail in Linux it can currently not benefit
from anything provided by the remoteproc subsystem. The RPM firmware is
usually already loaded and started by earlier components in the boot
chain and is not meant to be ever restarted.

To avoid breaking existing kernel configurations the driver is always
built when smd-rpm.c is also built. They belong closely together anyway.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/soc/qcom/Makefile   |  2 +-
 drivers/soc/qcom/rpm-proc.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 99114c71092b..113b9ff2ad43 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_QCOM_RPM_MASTER_STATS)	+= rpm_master_stats.o
 obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
 qcom_rpmh-y			+= rpmh-rsc.o
 qcom_rpmh-y			+= rpmh.o
-obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
+obj-$(CONFIG_QCOM_SMD_RPM)	+= rpm-proc.o smd-rpm.o
 obj-$(CONFIG_QCOM_SMEM) +=	smem.o
 obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
diff --git a/drivers/soc/qcom/rpm-proc.c b/drivers/soc/qcom/rpm-proc.c
new file mode 100644
index 000000000000..0652be7f7895
--- /dev/null
+++ b/drivers/soc/qcom/rpm-proc.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021-2023, Stephan Gerhold <stephan@gerhold.net> */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/rpmsg/qcom_smd.h>
+
+static int rpm_proc_probe(struct platform_device *pdev)
+{
+	struct qcom_smd_edge *edge = NULL;
+	struct device *dev = &pdev->dev;
+	struct device_node *edge_node;
+	int ret;
+
+	edge_node = of_get_child_by_name(dev->of_node, "smd-edge");
+	if (edge_node) {
+		edge = qcom_smd_register_edge(dev, edge_node);
+		if (IS_ERR(edge))
+			return dev_err_probe(dev, PTR_ERR(edge),
+					     "Failed to register smd-edge\n");
+	}
+
+	ret = devm_of_platform_populate(dev);
+	if (ret) {
+		dev_err(dev, "Failed to populate children devices: %d\n", ret);
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, edge);
+	return 0;
+err:
+	if (edge)
+		qcom_smd_unregister_edge(edge);
+	return ret;
+}
+
+static void rpm_proc_remove(struct platform_device *pdev)
+{
+	struct qcom_smd_edge *edge = platform_get_drvdata(pdev);
+
+	if (edge)
+		qcom_smd_unregister_edge(edge);
+}
+
+static const struct of_device_id rpm_proc_of_match[] = {
+	{ .compatible = "qcom,rpm-proc", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rpm_proc_of_match);
+
+static struct platform_driver rpm_proc_driver = {
+	.probe = rpm_proc_probe,
+	.remove_new = rpm_proc_remove,
+	.driver = {
+		.name = "qcom-rpm-proc",
+		.of_match_table = rpm_proc_of_match,
+	},
+};
+
+static int __init rpm_proc_init(void)
+{
+	return platform_driver_register(&rpm_proc_driver);
+}
+arch_initcall(rpm_proc_init);
+
+static void __exit rpm_proc_exit(void)
+{
+	platform_driver_unregister(&rpm_proc_driver);
+}
+module_exit(rpm_proc_exit);
+
+MODULE_DESCRIPTION("Qualcomm RPM processor/subsystem driver");
+MODULE_AUTHOR("Stephan Gerhold <stephan@gerhold.net>");
+MODULE_LICENSE("GPL");

-- 
2.40.1

