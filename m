Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587AC727869
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbjFHHLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjFHHLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:11:21 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FC31BE4;
        Thu,  8 Jun 2023 00:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686208274; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hzngWKxO5bsAn0CoGZZJfWQX5mChq4W5T3Dcn80+qY4j+uc2H5GlQE48tugvucENJ6
    uVDDH3P5a3FUjFK+CbPkE+6WVTPMMBmg5Eq10Pt7W43uXs0zC3J5Z0/9a3e1ntUkAmEP
    u29Liq+DRcxWLgi4XRJoDnm1vcsV056p0i0pS/FiloHiKWNbfMHBd+oXodepZiZrEcL6
    wtD2fs+jEz/aiqo/jL+zICwEBudYEgbPxKQVRaUPntZ8l66C3AXMFNGnMaBpFHAadbey
    goID78mAOw6jhZ6yegZaYTJCuiqTj1DsmdhZMZv/9b3E15Rtqn5YYfpEqPPY2zyevW7L
    VxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208274;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dGXPc4c33p441Ugh4Y0rgBXLzemaPqz7jwQRolXy1RQ=;
    b=bdZVL36KsuuTgz0xN6vuZYk46HlkjAkzegaFDPUxD2cC779yxBwQXZtB+iMywSmhsS
    KXIwvUHfsasNBKbHEaUBFId49GnVdg9/QxeN+GR0GfQlUrqtkCoqaGaF0syDqMwXMrD2
    OjgQIdnWhSU4wBY4AqdSmg1keg2MgzLz6I8QyUKIB3cT7/XfCUHnsRgZLms8aUZCohUw
    F1vKwGupuI5y+YrFhXh1vwyrKp29giluhdPKlWU6V/7Xj2JNj4CFVUHLpTRcgZAabsAx
    g2hzHvMxUOB7p4GQNSbey1y83pZIMiCKDIVZ8imsNmAFL4pgi7lCch5a3Ef7PHUbuLtc
    IsRA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208274;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dGXPc4c33p441Ugh4Y0rgBXLzemaPqz7jwQRolXy1RQ=;
    b=Fc+NKpGUvZ9X3CoQ22lPJ6xsc+rbeIYz+FvY439z8h5sxe7sEtcuWS1wDgJGHx1UQ/
    0ZTMTPGZVEOH8gJtYuxNOZhMJtB4RlypcCyX89A4dx5Uhn9ExcEX3ueLp1KCFy2W1IeI
    oT6/GFcjIzg3zsdnek2+qWo409HXLZu11acmEBdz+YkKmK2dAUlP7LM4XseRl08/BRDy
    C3Hsfui2YKv6bh1u1X7m5IAHWdKLf4jPDAZ9sxF6Tst8kFxtMHl4Oqcq1p4W/MhFNE3K
    ROb40Qvl1Fjf6zo5KPR8txNtJyTioLhJA/F0dcXL71C1AhDuZQF8QAOB1F2t0IsYOi/e
    l3Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686208274;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dGXPc4c33p441Ugh4Y0rgBXLzemaPqz7jwQRolXy1RQ=;
    b=qzPDNISNoPq/GHvNmMOjk3h2muNGqTr5vJzncUw7376TUUbRoYUk4wcSDxFCXurKrD
    QOIX2QPRgWiiSYT33TBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z587BDKI1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 8 Jun 2023 09:11:13 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 08 Jun 2023 09:10:28 +0200
Subject: [PATCH v2 08/12] soc: qcom: Add RPM processor/subsystem driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v2-8-56a4a00c8260@gerhold.net>
References: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

