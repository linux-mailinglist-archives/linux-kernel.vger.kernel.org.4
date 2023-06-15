Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D85731E71
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjFOQwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbjFOQvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:51:14 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A215F2977;
        Thu, 15 Jun 2023 09:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686847857; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Yjc0Vuz2dWSmf0y4F5QRSvl7PHgteaxfcp1vUP9WMKFyzTxTfKyeyKTwDgZh5L1iIF
    nw4wCCx5X3OArGNoOSnYvGElVk9vbeCx/k/KZdYr9MgZMxUsEKB4HvZcgHTVkK0Mhr46
    WFsVjG8LXLBsglAu/0xVbCCbDEoLScUtSSbzhQcd5uURAAREh9jfJrDRUxDRHdNDHF+V
    bjG+Ld9Vc/nnKv8JXr9LVnRbwMLaQGKeZFWHDDb8F2R1VAtjjSGU2KNpPBta58QvawMm
    yd7CAt2cQ1uQZP2JX200eikgNTLrfjyFZP1i0NQ/aDfYCXfYYI2oPVQjALffG7g1xvAR
    T1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847857;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Au4TMu9xKZsKryyhqXZKpKI8x4NWUO2Kfst6H6dV5ng=;
    b=RRzV0mqgZbptj0htyCvrsrbInmunwKLiRPXBtjY+lamHpT0fXsZSf62OZ3WzXmUj8O
    iX7HVgkrc+CftJQhk95YWSji6HZqGKUnO9vRc3NlwgL5GHAMsBoNVDPxfhIjUUbBtPFS
    1lXUOukm/5qXOki58Y3mrGKAkObLsyW63dPp45ocB/s82AzWjtbyHjCDmFg83N5LGirN
    La/U5oXXgnghiYviaOnYQ7zGpElbO5T5ai+kvzvjDNNKZFDOh3CoclXaGOCypNT3UMZU
    Z4e7OhGdNL0d+m1bQsjrvIHcCOhipGV74eUO5PpDLHk7gOwisCA4gJWFtRlg/3kug6mp
    BlTg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847857;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Au4TMu9xKZsKryyhqXZKpKI8x4NWUO2Kfst6H6dV5ng=;
    b=Qn38BmzYwdERkiCdKdRBiGx0JdPiR6nRsBQo+oY5CIU/5WPxJjmQXwpbVGcM0wnEdG
    b32rZJV6Ovg2QeFYb5RKgFCrLsxOp2fgb50BykffiP8pi0jUrTom3nyumOypmZbffikl
    I4cAinh+oCkzbIJxUIfGBwaRFkGgPZ//9TLPg0JwHfWlvag1rxCN+SbnpCuK9bXE/7di
    AQgXvnF6hjW+g0O6583SV6YcuTcOjy7+eXSxgU2n9wO3GErF8bgG1SlMYrSCC6BZcDVp
    oqUhZr4tmPPgKREduNMWNg/u0ZNK6JOsJR2FAPMxkoqmmJMTzDXZ4OVevvQKdvCi4egb
    xnkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686847857;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Au4TMu9xKZsKryyhqXZKpKI8x4NWUO2Kfst6H6dV5ng=;
    b=zCckzR4gaq089ztJtV9K1UYdpCHnqaHKIQPzI9zWxdFZfqvkEqxfRJ7ek9ldibFBtr
    Oc83cU5p0FtzlqEqYaAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOf59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5FGov42k
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 18:50:57 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 15 Jun 2023 18:50:42 +0200
Subject: [PATCH v3 09/13] soc: qcom: Add RPM processor/subsystem driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v3-9-a07dcdefd918@gerhold.net>
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
To avoid build errors CONFIG_RPMSG_QCOM_SMD must be also built-in if
rpm-proc is.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/soc/qcom/Kconfig    |  1 +
 drivers/soc/qcom/Makefile   |  2 +-
 drivers/soc/qcom/rpm-proc.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e597799e8121..715348869d04 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -191,6 +191,7 @@ config QCOM_SMD_RPM
 	tristate "Qualcomm Resource Power Manager (RPM) over SMD"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on RPMSG
+	depends on RPMSG_QCOM_SMD || RPMSG_QCOM_SMD=n
 	help
 	  If you say yes to this option, support will be included for the
 	  Resource Power Manager system found in the Qualcomm 8974 based
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
index 000000000000..2995d9b90190
--- /dev/null
+++ b/drivers/soc/qcom/rpm-proc.c
@@ -0,0 +1,77 @@
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
+		of_node_put(edge_node);
+		if (IS_ERR(edge))
+			return dev_err_probe(dev, PTR_ERR(edge),
+					     "Failed to register smd-edge\n");
+	}
+
+	ret = devm_of_platform_populate(dev);
+	if (ret) {
+		dev_err(dev, "Failed to populate child devices: %d\n", ret);
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

