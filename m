Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F57658B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiL2KOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiL2KM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:12:29 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451A310FC6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:04:17 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221229100415epoutp01201798c08bb0ea25c3d4941979133245~1O3_Pxtos1120111201epoutp01j
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:04:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221229100415epoutp01201798c08bb0ea25c3d4941979133245~1O3_Pxtos1120111201epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672308255;
        bh=dplttHGWL97k9zkZU+DBVvNgaW6tStyWd3q2Kneia8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJbk5Btr99+hzonJmYOnPotSjCdz1x8E7iAmkTJP0qOpmPMKJCoIvyiEoLxCsKiE6
         hqN060I2v9QCGQiqeuzVu+hyxwRvgIEQky/U7wxiNwup0uaSIgkuGWjebi58LKEhOR
         wMgXpl7p1M4ANE426djCgL0WMzP2/9Hv89Y0OrvY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20221229100415epcas2p42a49b9e99c5f8b95a8e05175b2948466~1O39u7IvY1198811988epcas2p4O;
        Thu, 29 Dec 2022 10:04:15 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NjPB64Gn5z4x9Ps; Thu, 29 Dec
        2022 10:04:14 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.EB.03803.E166DA36; Thu, 29 Dec 2022 19:04:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20221229100413epcas2p34c702faf8c96d207cf1659b1173f8858~1O38Xq-mM2202722027epcas2p39;
        Thu, 29 Dec 2022 10:04:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221229100413epsmtrp1f2ae4b5010939a31ae2db49becf99d82~1O38W2YLJ2828628286epsmtrp1B;
        Thu, 29 Dec 2022 10:04:13 +0000 (GMT)
X-AuditID: b6c32a45-f47ff70000020edb-92-63ad661e70ae
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.CE.10542.D166DA36; Thu, 29 Dec 2022 19:04:13 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221229100413epsmtip224864ad58e8955358c4f490b97eb7bae~1O38FbIaa1657916579epsmtip2w;
        Thu, 29 Dec 2022 10:04:13 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        sc.suh@samsung.com, taehyun.cho@samsung.com,
        jh0801.jung@samsung.com, eomji.oh@samsung.com,
        Daehwan Jung <dh10.jung@samsung.com>
Subject: [RFC PATCH v2 1/3] usb: support Samsung Exynos xHCI Controller
Date:   Thu, 29 Dec 2022 18:57:44 +0900
Message-Id: <1672307866-25839-2-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTQlcubW2ywbV/shbH2p6wW8w/co7V
        4s6CaUwWp5YvZLJoXryezeLuwx8sFn0vHjJbXN41h81i0bJWZovmTVNYLVr3HmG36Lp7g9Fi
        0kFRi1ULDrA78Hks3vOSyWPTqk42jzvX9rB57J+7ht2jb8sqRo8t+z8zenzeJBfAHpVtk5Ga
        mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0spJCWWJOKVAo
        ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO2Nh60vG
        gk+uFT8urmFtYHxp2cXIySEhYCJx9Oh1ti5GLg4hgR2MEheO3GGEcD4xStze2Q7lfGaU6Nj5
        kRmm5fDyrWwgtpDALkaJN+9FIIp+MEq833KFqYuRg4NNQEvi+0KwZhGBLiaJbXe+soA4zAJH
        mCQ2zjjFCNItLOAucb6jC8xmEVCVuDLpNJjNK+Aq8Wb+ZjaIbXISN891gm3mFHCTaN/6A2yQ
        hEAvh8Ttp9Ohilwkfn64CmULS7w6voUdwpaSeNnfBmVnS1z/1s0CYVdIrNgLYxtLzHoG8icH
        0HWaEut36YOYEgLKEkdugVUwC/BJdBz+yw4R5pXoaBOCaFSWmH55AiuELSlx8PU5aPh4SGw/
        9okFEiYzGSXmPprLPoFRbhbCggWMjKsYxVILinPTU4uNCgzhMZacn7uJEZwktVx3ME5++0Hv
        ECMTB+MhRgkOZiURXo2zq5OFeFMSK6tSi/Lji0pzUosPMZoCw24is5Rocj4wTeeVxBuaWBqY
        mJkZmhuZGpgrifMGbZ2fLCSQnliSmp2aWpBaBNPHxMEp1cB0+uyOW62sPAI15S83id/a2NFS
        W6+388Cdv4dOfP31xjvR0bMv7/2hlIQ/IXlB/1MDlxx1nciwKv/lqszkT79bBL7fMV1xMfK4
        7ffp+S8iauq5Nq302vF8TxhzqmvSyfLGuUkxqu2NB107LBee8Qx8MOXPDcdH6yaJH8wq4Kq4
        7lPhxn3Uzf94QJmC+6qoC55TJ1tox1zSOfX7uo5VfaW2aPzWNZof4qrvisgWMukeeh/gKV2r
        nvlxQtbXSb5xc5PNtfTat22wnsrQs13/wYLilBcFvq8Tfyot2t7zOcRRaGruB99357/MPHbw
        2qT/1ay2BxW8tNyXpmxRll2xoVnfnWGy26Qpk9jyn4gvPKuhxFKckWioxVxUnAgAEgHunhsE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSvK5s2tpkg30n5C2OtT1ht5h/5Byr
        xZ0F05gsTi1fyGTRvHg9m8Xdhz9YLPpePGS2uLxrDpvFomWtzBbNm6awWrTuPcJu0XX3BqPF
        pIOiFqsWHGB34PNYvOclk8emVZ1sHneu7WHz2D93DbtH35ZVjB5b9n9m9Pi8SS6APYrLJiU1
        J7MstUjfLoErY2HrS8aCT64VPy6uYW1gfGnZxcjJISFgInF4+VY2EFtIYAejxM//pRBxSYml
        c2+wQ9jCEvdbjrB2MXIB1XxjlFj35yuQw8HBJqAl8X0hI0hcRKCHSWLhFJBBXBzMAqeYJG4d
        f8UE0i0s4C5xvqOLEcRmEVCVuDLpNJjNK+Aq8Wb+ZjaIDXISN891MoPYnAJuEu1bf7BAXOQq
        caH7H9sERr4FjAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCw1lLawfjnlUf9A4x
        MnEwHmKU4GBWEuHVOLs6WYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWp
        RTBZJg5OqQamsufTcpMUJraUX+WPUe8uUJS9eCaournuuuk+9j2L1yZcPfLY/t+/Ct0HGVdY
        lxyY0bv5/qXMY4/DfsQpa7wzOOO9XSjYXuiWfOvJ7EVuIdNPvAhIDtns6bRPP/X85OXqE57u
        vKcp+4X1l419DfvZ49VTGFuy90+2kNe0MdWwiPk+1WtJV3yaxIKmJt1q6/XKtwKOe2Y4rXDX
        jN/W9U/LIv+Y1dxin8tast6Vyy8fPPXSIu/Ikeq5U1Mcfc2Nbz1gjGD85Ms8ZVHO1+Yvhx+J
        Nvneq3kS3uXy0JllR+rTK/x1N8///Sd/8PuVtPqlLv8ixKO2xl7RXzdnwpqGU/9KHvq73TXn
        yemrXjrn5vbvSizFGYmGWsxFxYkAj39CQ9YCAAA=
X-CMS-MailID: 20221229100413epcas2p34c702faf8c96d207cf1659b1173f8858
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221229100413epcas2p34c702faf8c96d207cf1659b1173f8858
References: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
        <CGME20221229100413epcas2p34c702faf8c96d207cf1659b1173f8858@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, dwc3 invokes just xhci platform driver without any data.
We add xhci node as child of dwc3 node in order to get data from
device tree. It populates "xhci" child by name during initialization
of host. This patch only effects if dwc3 node has a child named "xhci"
not to disturb original path.

We add "samsung,exynos-xhci" compatible in xhci platform driver
to support Exynos SOCs. We introduce roothub wakeup, which uses roothub
as system wakeup source. It needs xhci platform driver to override
roothub ops.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/dwc3/drd.c       |  7 +++++
 drivers/usb/dwc3/host.c      | 33 ++++++++++++++++++--
 drivers/usb/host/xhci-plat.c | 60 +++++++++++++++++++++++++++++++++++-
 drivers/usb/host/xhci.c      |  4 +++
 drivers/usb/host/xhci.h      |  5 +++
 5 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 039bf241769a..7263fd7bdf4f 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -496,6 +496,8 @@ static enum usb_role dwc3_usb_role_switch_get(struct usb_role_switch *sw)
 static int dwc3_setup_role_switch(struct dwc3 *dwc)
 {
 	struct usb_role_switch_desc dwc3_role_switch = {NULL};
+	struct device_node *dwc3_np = dev_of_node(dwc->dev);
+	struct device_node *xhci_np;
 	u32 mode;
 
 	dwc->role_switch_default_mode = usb_get_role_switch_default_mode(dwc->dev);
@@ -514,6 +516,10 @@ static int dwc3_setup_role_switch(struct dwc3 *dwc)
 	if (IS_ERR(dwc->role_sw))
 		return PTR_ERR(dwc->role_sw);
 
+	xhci_np = of_get_child_by_name(dwc3_np, "xhci");
+	if (xhci_np)
+		goto populate_skip;
+
 	if (dwc->dev->of_node) {
 		/* populate connector entry */
 		int ret = devm_of_platform_populate(dwc->dev);
@@ -526,6 +532,7 @@ static int dwc3_setup_role_switch(struct dwc3 *dwc)
 		}
 	}
 
+populate_skip:
 	dwc3_set_mode(dwc, mode);
 	return 0;
 }
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index f6f13e7f1ba1..8adfe45d9681 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -9,6 +9,7 @@
 
 #include <linux/irq.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 #include "core.h"
@@ -68,9 +69,22 @@ int dwc3_host_init(struct dwc3 *dwc)
 {
 	struct property_entry	props[4];
 	struct platform_device	*xhci;
+	struct device_node *dwc3_np = dev_of_node(dwc->dev);
+	struct device_node *xhci_np;
 	int			ret, irq;
 	int			prop_idx = 0;
 
+	xhci_np = of_get_child_by_name(dwc3_np, "xhci");
+	if (xhci_np) {
+		ret = of_platform_populate(dwc3_np, NULL, NULL, dwc->dev);
+		if (ret) {
+			dev_err(dwc->dev, "failed to register xhci - %d\n", ret);
+			goto err;
+		}
+		dwc->xhci = of_find_device_by_node(xhci_np);
+		goto populate_done;
+	}
+
 	irq = dwc3_host_get_irq(dwc);
 	if (irq < 0)
 		return irq;
@@ -126,14 +140,29 @@ int dwc3_host_init(struct dwc3 *dwc)
 		goto err;
 	}
 
+populate_done:
 	return 0;
+
 err:
-	platform_device_put(xhci);
+	if (xhci_np)
+		of_platform_depopulate(dwc->dev);
+	else
+		platform_device_put(xhci);
+
 	return ret;
 }
 
 void dwc3_host_exit(struct dwc3 *dwc)
 {
-	platform_device_unregister(dwc->xhci);
+	struct device_node *dwc3_np = dev_of_node(dwc->dev);
+	struct device_node *xhci_np;
+
+	xhci_np = of_get_child_by_name(dwc3_np, "xhci");
+
+	if (xhci_np)
+		of_platform_depopulate(dwc->dev);
+	else
+		platform_device_unregister(dwc->xhci);
+
 	dwc->xhci = NULL;
 }
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 5fb55bf19493..0eeaf306076a 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -29,11 +29,15 @@ static struct hc_driver __read_mostly xhci_plat_hc_driver;
 
 static int xhci_plat_setup(struct usb_hcd *hcd);
 static int xhci_plat_start(struct usb_hcd *hcd);
+static int xhci_plat_bus_suspend(struct usb_hcd *hcd);
+static int xhci_plat_bus_resume(struct usb_hcd *hcd);
 
 static const struct xhci_driver_overrides xhci_plat_overrides __initconst = {
 	.extra_priv_size = sizeof(struct xhci_plat_priv),
 	.reset = xhci_plat_setup,
 	.start = xhci_plat_start,
+	.bus_suspend = xhci_plat_bus_suspend,
+	.bus_resume = xhci_plat_bus_resume,
 };
 
 static void xhci_priv_plat_start(struct usb_hcd *hcd)
@@ -86,6 +90,33 @@ static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 	xhci->quirks |= XHCI_PLAT | priv->quirks;
 }
 
+static int xhci_plat_bus_suspend(struct usb_hcd *hcd)
+{
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+
+	if (xhci->quirks & XHCI_ROOTHUB_WAKEUP) {
+		if (hcd == xhci->main_hcd)
+			__pm_relax(xhci->main_wakelock);
+		else
+			__pm_relax(xhci->shared_wakelock);
+	}
+
+	return xhci_bus_suspend(hcd);
+}
+
+static int xhci_plat_bus_resume(struct usb_hcd *hcd)
+{
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+
+	if (xhci->quirks & XHCI_ROOTHUB_WAKEUP) {
+		if (hcd == xhci->main_hcd)
+			__pm_stay_awake(xhci->main_wakelock);
+		else
+			__pm_stay_awake(xhci->shared_wakelock);
+	}
+	return xhci_bus_resume(hcd);
+}
+
 /* called during probe() after chip reset completes */
 static int xhci_plat_setup(struct usb_hcd *hcd)
 {
@@ -126,6 +157,10 @@ static const struct xhci_plat_priv xhci_plat_brcm = {
 	.quirks = XHCI_RESET_ON_RESUME | XHCI_SUSPEND_RESUME_CLKS,
 };
 
+static const struct xhci_plat_priv xhci_plat_exynos = {
+	.quirks = XHCI_ROOTHUB_WAKEUP,
+};
+
 static const struct of_device_id usb_xhci_of_match[] = {
 	{
 		.compatible = "generic-xhci",
@@ -167,6 +202,9 @@ static const struct of_device_id usb_xhci_of_match[] = {
 	}, {
 		.compatible = "brcm,bcm7445-xhci",
 		.data = &xhci_plat_brcm,
+	}, {
+		.compatible = "samsung,exynos-xhci",
+		.data = &xhci_plat_exynos,
 	},
 	{},
 };
@@ -185,7 +223,6 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	int			irq;
 	struct xhci_plat_priv	*priv = NULL;
 
-
 	if (usb_disabled())
 		return -ENODEV;
 
@@ -350,6 +387,21 @@ static int xhci_plat_probe(struct platform_device *pdev)
 			goto put_usb3_hcd;
 	}
 
+	if (xhci->quirks & XHCI_ROOTHUB_WAKEUP) {
+		/* Initialization wakelock for HCD */
+		xhci->main_wakelock = wakeup_source_register(&pdev->dev,
+							dev_name(&pdev->dev));
+		__pm_stay_awake(xhci->main_wakelock);
+		device_set_wakeup_enable(&xhci->main_hcd->self.root_hub->dev, true);
+
+		if (xhci->shared_hcd) {
+			xhci->shared_wakelock = wakeup_source_register(&pdev->dev,
+								dev_name(&pdev->dev));
+			__pm_stay_awake(xhci->shared_wakelock);
+			device_set_wakeup_enable(&xhci->shared_hcd->self.root_hub->dev, true);
+		}
+	}
+
 	device_enable_async_suspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
@@ -398,6 +450,12 @@ static int xhci_plat_remove(struct platform_device *dev)
 	pm_runtime_get_sync(&dev->dev);
 	xhci->xhc_state |= XHCI_STATE_REMOVING;
 
+	if (xhci->quirks & XHCI_ROOTHUB_WAKEUP) {
+		wakeup_source_unregister(xhci->main_wakelock);
+		if (xhci->shared_wakelock)
+			wakeup_source_unregister(xhci->shared_wakelock);
+	}
+
 	if (shared_hcd) {
 		usb_remove_hcd(shared_hcd);
 		xhci->shared_hcd = NULL;
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
index c9f06c5e4e9d..cb9c54a6a22c 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1752,6 +1752,8 @@ struct xhci_hub {
 struct xhci_hcd {
 	struct usb_hcd *main_hcd;
 	struct usb_hcd *shared_hcd;
+	struct wakeup_source *main_wakelock;
+	struct wakeup_source *shared_wakelock;
 	/* glue to PCI and HCD framework */
 	struct xhci_cap_regs __iomem *cap_regs;
 	struct xhci_op_regs __iomem *op_regs;
@@ -1898,6 +1900,7 @@ struct xhci_hcd {
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
+#define XHCI_ROOTHUB_WAKEUP	BIT_ULL(45)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
@@ -1943,6 +1946,8 @@ struct xhci_driver_overrides {
 			     struct usb_host_endpoint *ep);
 	int (*check_bandwidth)(struct usb_hcd *, struct usb_device *);
 	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
+	int (*bus_suspend)(struct usb_hcd *hcd);
+	int (*bus_resume)(struct usb_hcd *hcd);
 };
 
 #define	XHCI_CFC_DELAY		10
-- 
2.31.1

