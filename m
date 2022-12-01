Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0482363E7B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 03:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiLACUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 21:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiLACUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 21:20:00 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0639E9FEDD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 18:19:46 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221201021944epoutp013a7b4a000e8c5e9cb1c12614b8a6f54d~sieZrzQl50288502885epoutp013
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:19:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221201021944epoutp013a7b4a000e8c5e9cb1c12614b8a6f54d~sieZrzQl50288502885epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669861184;
        bh=iEjC8lqfpO01Q1ZmjgLYl5Rtgr4U6xZPWxnHQDK8+h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHK0iJPjeJ3k93pY4FZN3zSISOzH7/bdPNoHeE02KnFsO0V8+9p3NBgrRnd677lbG
         gaZc8xzrF2/kbyS90fWWneEnf3A7QGxVY6YcuzrkDnW0wTZUfrWlHPBDbfsYLJNVCo
         R16BJivK7rE6TyhEU/oXTg5mEG2XTFTxs2FFnh78=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20221201021943epcas2p1f666f32e944c382c8e0acf87d84c1b48~sieZDt8-P0927609276epcas2p1o;
        Thu,  1 Dec 2022 02:19:43 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NN0C32fzDz4x9Q9; Thu,  1 Dec
        2022 02:19:43 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.CC.18762.F3F08836; Thu,  1 Dec 2022 11:19:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7~sieX-mfgg1899818998epcas2p25;
        Thu,  1 Dec 2022 02:19:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221201021942epsmtrp2b45672dc9682ee05553ff112c19919ed~sieX_M6uV1711217112epsmtrp2L;
        Thu,  1 Dec 2022 02:19:42 +0000 (GMT)
X-AuditID: b6c32a48-64bff7000001494a-0d-63880f3f144c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.D6.14392.E3F08836; Thu,  1 Dec 2022 11:19:42 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221201021942epsmtip231d6b221d1988c3dbfa9a501f7dda92f~sieXwKZz-2761727617epsmtip2i;
        Thu,  1 Dec 2022 02:19:42 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Daehwan Jung <dh10.jung@samsung.com>,
        Artur Bujdoso <artur.bujdoso@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Tomer Maimon <tmaimon77@gmail.com>
Cc:     linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES),
        linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND
        EXYNOS ARM ARCHITECTURES),
        linux-kernel@vger.kernel.org (open list), sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
Subject: [RFC PATCH v1 2/2] usb: host: add xhci-exynos to support Exynos
 SOCs
Date:   Thu,  1 Dec 2022 11:13:31 +0900
Message-Id: <1669860811-171746-3-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmua49f0eyQfcRQYsH87axWfyddIzd
        4uaENYwWk9q/sFrMP3KO1eLOgmlMFqeWL2SyaF68ns1izk0ji7sPf7BY9L14yGwx5c9yJotN
        j6+xWlzeNYfNYsb5fUwWi5a1Mls0b5rCatG69wi7RdfdG0DjDopa/NryitFB1OP3r0mMHjtn
        3WX3WLznJZPHplWdbB53ru1h89g/dw27x+Yl9R59W1YxeqzfcpXF4/MmuQCuqGybjNTElNQi
        hdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAXlRTKEnNKgUIBicXF
        Svp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGX9nPmcqWOVa
        0XViEWMD43OrLkYODgkBE4lPX9O6GLk4hAR2MErs7l3CCuF8YpTYuHMWC4TzjVFiyoNLzF2M
        nGAdV9a+YINI7GWUuDx5OlTVD0aJC1/3MYPMZRPQkvi+kBEkLiLwiVniXuc9RpBuZoF3zBL9
        W6JBbGEBf4lJb76xgNgsAqoSXy4/BNvAK+AmsXj9f3aIbXISN891gsU5Bdwltu65wAwyVELg
        AofE+S3rWCCKXCRWvWuFahCWeHV8C5QtJfH53V42CDtb4vq3bqj6CokVe2FsY4lZz9oZQY5m
        FtCUWL9LHxIuyhJHbrFAnMwn0XH4LztEmFeio00IolFZYvrlCawQtqTEwdfnoOHjIXFr8Wx2
        SJDMYpS4eWo20wRGuVkICxYwMq5iFEstKM5NTy02KjCBR1hyfu4mRnAK1vLYwTj77Qe9Q4xM
        HIyHGCU4mJVEeDs+tyUL8aYkVlalFuXHF5XmpBYfYjQFht1EZinR5HxgFsgriTc0sTQwMTMz
        NDcyNTBXEuftmqGVLCSQnliSmp2aWpBaBNPHxMEp1cAU/LfQYImo7jLDZauPFbxbV3kyTse0
        ImLavatf2+N4d4VoVh6OMtxmezyM/bIol+OWyUfuTPlc9fNB6y5JF70Zba8Mwj5I3lBdEnln
        y0O/1dcXscfys7wOLfycoOavZnnl/lMGmb7GY8FLfhuUvj9QmtPQ/uxVMcfhe5feTZj/Tr4z
        T/7VZ27+K1yaeW+y1lnb7DI7o1rd7Dh9KfstzZBD/yaXfbBkjOZ9fOjo3mDJoyLpc71tm7oO
        xgrMqEv0vuqdLn3HO2nJu/wJ2VOKGq1uzrjyfsoksZ2ZKyX3/lGZ9nhhDmfBJq0ZSlsmvBK+
        cG77y1an/5Myt3uKBiiePJI6q6fNOKGd60+p6tNwxbR2JZbijERDLeai4kQAAqiDIUoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvK4df0eywbc+TYsH87axWfyddIzd
        4uaENYwWk9q/sFrMP3KO1eLOgmlMFqeWL2SyaF68ns1izk0ji7sPf7BY9L14yGwx5c9yJotN
        j6+xWlzeNYfNYsb5fUwWi5a1Mls0b5rCatG69wi7RdfdG0DjDopa/NryitFB1OP3r0mMHjtn
        3WX3WLznJZPHplWdbB53ru1h89g/dw27x+Yl9R59W1YxeqzfcpXF4/MmuQCuKC6blNSczLLU
        In27BK6MvzOfMxWscq3oOrGIsYHxuVUXIyeHhICJxJW1L9hAbCGB3YwS29sKIeKSEkvn3mCH
        sIUl7rccYe1i5AKq+cYocf3STaAGDg42AS2J7wsZQeIiAr+YJV78bmYGcZgFPjBLHOncADZV
        WMBXomnKChYQm0VAVeLL5YfMIDavgJvE4vX/oTbISdw81wkW5xRwl9i65wIzxEVuEm3bpjBO
        YORbwMiwilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOF60NHcwbl/1Qe8QIxMH4yFG
        CQ5mJRHejs9tyUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFw
        SjUwLYnkLVg6TbFwnqvLfr23p5OO/+2M1N7m67/qoNlxn8vVxWzOzJN7+gULTRKvzNw91fvH
        5FOBjwzK7n7Z9e5jS9nn0BJPdSE5i+NMUlfbvuR8ijtd2/0r89gW3fn/Gd45XvSZ3n1kItOD
        HWtvu5XXMv7696w2oG8do58886XzF5wLXPf/CGDykLrlZrNS8OjZKVkOL1LqQ79Gr8kMOjvd
        1NfoOsu9TdO+ey46/YmZ52TEqgf8k5zSrcN3TvNg/LQwpeD+yW3ZMck/mE8dubjTdL+7Rp+E
        wfr8XWa31i1me7SH9bxryZewozNCX4Vcdnozrc5B5o/xvArHLZYCNruVCsVX14lxZrQzbZB7
        vPtFjRJLcUaioRZzUXEiABmDt+UGAwAA
X-CMS-MailID: 20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7
References: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
        <CGME20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver works with xhci platform driver. It needs to override
functions of xhci_plat_hc_driver. Wakelocks are used for sleep/wakeup
scenario of system.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/host/Kconfig       |   8 ++
 drivers/usb/host/Makefile      |   1 +
 drivers/usb/host/xhci-exynos.c | 154 +++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-hub.c    |   2 +
 drivers/usb/host/xhci-plat.c   |   6 ++
 drivers/usb/host/xhci-plat.h   |   2 +
 drivers/usb/host/xhci.c        |   4 +
 drivers/usb/host/xhci.h        |   2 +
 8 files changed, 179 insertions(+)
 create mode 100644 drivers/usb/host/xhci-exynos.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 8d799d23c476..007c7706ddeb 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -104,6 +104,14 @@ config USB_XHCI_TEGRA
 	  Say 'Y' to enable the support for the xHCI host controller
 	  found in NVIDIA Tegra124 and later SoCs.
 
+config USB_XHCI_EXYNOS
+	tristate "xHCI support for Samsung Exynos SoC Series"
+	depends on USB_XHCI_PLATFORM
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	help
+	  Say 'Y' to enable the support for the xHCI host controller
+	  found in Samsung Exynos SoCs.
+
 endif # USB_XHCI_HCD
 
 config USB_EHCI_BRCMSTB
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 6d8ee264c9b2..c682834f4260 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -86,3 +86,4 @@ obj-$(CONFIG_USB_HCD_BCMA)	+= bcma-hcd.o
 obj-$(CONFIG_USB_HCD_SSB)	+= ssb-hcd.o
 obj-$(CONFIG_USB_MAX3421_HCD)	+= max3421-hcd.o
 obj-$(CONFIG_USB_XEN_HCD)	+= xen-hcd.o
+obj-$(CONFIG_USB_XHCI_EXYNOS)	+= xhci-exynos.o
diff --git a/drivers/usb/host/xhci-exynos.c b/drivers/usb/host/xhci-exynos.c
new file mode 100644
index 000000000000..5e2323aee996
--- /dev/null
+++ b/drivers/usb/host/xhci-exynos.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * xhci-exynos.c - xHCI host controller driver platform Bus Glue for Exynos.
+ *
+ * Copyright (C) 2022 Samsung Electronics Incorporated - http://www.samsung.com
+ * Author: Daehwan Jung <dh10.jung@samsung.com>
+ *
+ */
+#include <linux/platform_device.h>
+
+#include "xhci.h"
+#include "xhci-plat.h"
+
+struct xhci_hcd_exynos {
+	struct wakeup_source *main_wakelock; /* Wakelock for HS HCD */
+	struct wakeup_source *shared_wakelock; /* Wakelock for SS HCD */
+};
+
+static struct xhci_hcd_exynos xhci_exynos_data;
+
+static int xhci_exynos_start(struct usb_hcd *hcd);
+static int xhci_exynos_setup(struct usb_hcd *hcd);
+static int xhci_exynos_bus_suspend(struct usb_hcd *hcd);
+static int xhci_exynos_bus_resume(struct usb_hcd *hcd);
+
+static const struct xhci_driver_overrides xhci_exynos_overrides = {
+	.extra_priv_size = sizeof(struct xhci_plat_priv),
+	.reset = xhci_exynos_setup,
+	.start = xhci_exynos_start,
+	.bus_suspend = xhci_exynos_bus_suspend,
+	.bus_resume = xhci_exynos_bus_resume,
+};
+
+static void xhci_exynos_quirks(struct device *dev, struct xhci_hcd *xhci)
+{
+	xhci->quirks |= XHCI_PLAT;
+}
+
+static int xhci_exynos_setup(struct usb_hcd *hcd)
+{
+	return xhci_gen_setup(hcd, xhci_exynos_quirks);
+}
+
+static int xhci_exynos_start(struct usb_hcd *hcd)
+{
+	__pm_stay_awake(xhci_exynos_data.main_wakelock);
+	__pm_stay_awake(xhci_exynos_data.shared_wakelock);
+
+	return xhci_run(hcd);
+}
+
+static void xhci_exynos_wake_lock(struct xhci_hcd *xhci, int is_main_hcd, int is_lock)
+{
+	struct wakeup_source *main_wakelock, *shared_wakelock;
+
+	main_wakelock = xhci_exynos_data.main_wakelock;
+	shared_wakelock = xhci_exynos_data.shared_wakelock;
+
+	if (xhci->xhc_state & XHCI_STATE_REMOVING)
+		return;
+
+	if (is_lock) {
+		if (is_main_hcd)
+			__pm_stay_awake(main_wakelock);
+		else
+			__pm_stay_awake(shared_wakelock);
+	} else {
+		if (is_main_hcd)
+			__pm_relax(main_wakelock);
+		else
+			__pm_relax(shared_wakelock);
+	}
+}
+
+static int xhci_exynos_bus_suspend(struct usb_hcd *hcd)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	int ret, main_hcd;
+
+	ret = xhci_bus_suspend(hcd);
+
+	if (!ret) {
+		main_hcd = (hcd == xhci->main_hcd) ? 1 : 0;
+		xhci_exynos_wake_lock(xhci, main_hcd, 0);
+	}
+
+	return ret;
+}
+
+static int xhci_exynos_bus_resume(struct usb_hcd *hcd)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	int ret, main_hcd;
+
+	ret = xhci_bus_resume(hcd);
+
+	if (!ret) {
+		main_hcd = (hcd == xhci->main_hcd) ? 1 : 0;
+		xhci_exynos_wake_lock(xhci, main_hcd, 1);
+	}
+
+	return ret;
+}
+
+static int xhci_exynos_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	xhci_exynos_data.main_wakelock = wakeup_source_register(dev, dev_name(dev));
+	xhci_exynos_data.shared_wakelock = wakeup_source_register(dev, dev_name(dev));
+
+	xhci_plat_override_driver(&xhci_exynos_overrides);
+
+	return 0;
+}
+
+static int xhci_exynos_remove(struct platform_device *dev)
+{
+	wakeup_source_unregister(xhci_exynos_data.main_wakelock);
+	wakeup_source_unregister(xhci_exynos_data.shared_wakelock);
+
+	return 0;
+}
+
+static const struct of_device_id exynos_xhci_of_match[] = {
+	{ .compatible = "samsung,exynos-xhci"},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, exynos_xhci_of_match);
+
+static struct platform_driver exynos_xhci_driver = {
+	.probe	= xhci_exynos_probe,
+	.remove	= xhci_exynos_remove,
+	.driver	= {
+		.name = "xhci-exynos",
+		.of_match_table = exynos_xhci_of_match,
+	},
+};
+
+static int __init xhci_exynos_init(void)
+{
+	return platform_driver_register(&exynos_xhci_driver);
+}
+module_init(xhci_exynos_init);
+
+static void __exit xhci_exynos_exit(void)
+{
+	platform_driver_unregister(&exynos_xhci_driver);
+}
+module_exit(xhci_exynos_exit);
+
+MODULE_AUTHOR("Daehwan Jung <dh10.jung@samsung.com>");
+MODULE_DESCRIPTION("xHCI Exynos Host Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 4619d5e89d5b..878c2c05055a 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1824,6 +1824,7 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_bus_suspend);
 
 /*
  * Workaround for missing Cold Attach Status (CAS) if device re-plugged in S3.
@@ -1968,6 +1969,7 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 	spin_unlock_irqrestore(&xhci->lock, flags);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_bus_resume);
 
 unsigned long xhci_get_resuming_ports(struct usb_hcd *hcd)
 {
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 5fb55bf19493..1cb24f8e0153 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -173,6 +173,12 @@ static const struct of_device_id usb_xhci_of_match[] = {
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
 #endif
 
+void xhci_plat_override_driver(const struct xhci_driver_overrides *xhci_hc_driver_overrides)
+{
+	xhci_init_driver(&xhci_plat_hc_driver, xhci_hc_driver_overrides);
+}
+EXPORT_SYMBOL_GPL(xhci_plat_override_driver);
+
 static int xhci_plat_probe(struct platform_device *pdev)
 {
 	const struct xhci_plat_priv *priv_match;
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 1fb149d1fbce..16436f72c5c4 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -21,4 +21,6 @@ struct xhci_plat_priv {
 
 #define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
 #define xhci_to_priv(x) ((struct xhci_plat_priv *)(x)->priv)
+
+void xhci_plat_override_driver(const struct xhci_driver_overrides *xhci_hc_driver_overrides);
 #endif	/* _XHCI_PLAT_H */
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 79d7931c048a..693495054001 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5502,6 +5502,10 @@ void xhci_init_driver(struct hc_driver *drv,
 			drv->check_bandwidth = over->check_bandwidth;
 		if (over->reset_bandwidth)
 			drv->reset_bandwidth = over->reset_bandwidth;
+		if (over->bus_suspend)
+			drv->bus_suspend = over->bus_suspend;
+		if (over->bus_resume)
+			drv->bus_resume = over->bus_resume;
 	}
 }
 EXPORT_SYMBOL_GPL(xhci_init_driver);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index cc084d9505cd..30e60c752c28 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1943,6 +1943,8 @@ struct xhci_driver_overrides {
 			     struct usb_host_endpoint *ep);
 	int (*check_bandwidth)(struct usb_hcd *, struct usb_device *);
 	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
+	int (*bus_suspend)(struct usb_hcd *hcd);
+	int (*bus_resume)(struct usb_hcd *hcd);
 };
 
 #define	XHCI_CFC_DELAY		10
-- 
2.31.1

