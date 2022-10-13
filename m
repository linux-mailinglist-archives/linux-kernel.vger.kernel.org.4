Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FDF5FD862
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJML2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJML2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:28:39 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E076DACC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:28:24 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221013112822epoutp01773cb37c6e5bfc9041cc2f4857ad5370~dnWbl7EJF0761007610epoutp01J
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:28:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221013112822epoutp01773cb37c6e5bfc9041cc2f4857ad5370~dnWbl7EJF0761007610epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665660502;
        bh=ouH+iL/+WExx5wqVfayC91GLl49lcZBc4TFvvZRll+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6eZ7MEDXTyFMcE6XEUkeENGvRuuKj8QJBRQ+y52tAg2l/03d0RPK8v3/QrRUGAic
         XErVdtkx3MMa1SGo+BMnrdSVADDxhjtX09M2qdHOFQ58d58XOea6x9zeNOW5sFcLev
         dYDGMmGWmPNlF7h31gg03lywTduud6cN32jqozH4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221013112822epcas5p24d6cf5a0478c8b74c132ed9204696684~dnWbOPVTv0826208262epcas5p2P;
        Thu, 13 Oct 2022 11:28:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Mp6hf73L0z4x9Pt; Thu, 13 Oct
        2022 11:28:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.BE.56352.256F7436; Thu, 13 Oct 2022 20:28:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221013110733epcas5p36e0104bfa4da37159da77f9231ff6e2c~dnEQNy0S61722817228epcas5p3p;
        Thu, 13 Oct 2022 11:07:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221013110733epsmtrp1716059bc5957e169f0d962f499ffb393~dnEQM8-w72875628756epsmtrp1U;
        Thu, 13 Oct 2022 11:07:33 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-8a-6347f6523ddc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.FC.18644.571F7436; Thu, 13 Oct 2022 20:07:33 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221013110731epsmtip15a615ba3d9a747e4b57debcd896fbc49~dnEOrLyLQ1695216952epsmtip1X;
        Thu, 13 Oct 2022 11:07:31 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, chanho61.park@samsung.com,
        linus.walleij@linaro.org, pankaj.dubey@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v3 4/4] arm64: dts: fix SPI drive strength values as per FSD
 HW UM
Date:   Thu, 13 Oct 2022 16:10:24 +0530
Message-Id: <20221013104024.50179-5-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013104024.50179-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmum7QN/dkg2fXzC0ezNvGZnF5v7bF
        /CPnWC36XjxktpjyZzmTxeVdc9gsZpzfx2RxdGOwxaKtX9gtWvceYXfg8ti0qpPN4861PWwe
        fVtWMXp83iQXwBKVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITvj6VzHgkaeioUTG9kbGJu4uhg5OSQETCSWH9nICmILCexmlNh9WAnC/sQo
        8eaIbRcjF5D9mVHiY992ZpiGb5vWMUEkdjFKTFz6lxXCaWWSWNk6iRGkik3AVGLVnEawhIjA
        UkaJ/58WMYI4zAJTGCW2brsBViUsECLR8G0xmM0ioCqx7NpR9i5GDg5eARuJmYv5INbJS6ze
        cIAZJMwpYCvx5II8yBgJgWvsEitnXWIBiUsIuEjsexQBUS4s8er4FnYIW0riZX8blJ0vMe1j
        MxuEXSHR9nEDE4RtL3HgyhywMcwCmhLrd+lDhGUlpp5aB1bCLMAn0fv7CVQ5r8SOeTC2qsT6
        5ZsYIWxpiX3X90LZHhI9fz4zQ0JxAqPEvavKExjlZiFsWMDIuIpRMrWgODc9tdi0wDgvtRwe
        Y8n5uZsYwclNy3sH46MHH/QOMTJxMB5ilOBgVhLhdQlxSxbiTUmsrEotyo8vKs1JLT7EaAoM
        vInMUqLJ+cD0mlcSb2hiaWBiZmZmYmlsZqgkzrt4hlaykEB6YklqdmpqQWoRTB8TB6dUA1NI
        gfoq/W93JM7+3fHoiduO/xvPTouz3/Hg1ofilB0Xmg+wCm79xyQmdc1y5guvcK9bDxWaQ0ze
        nH/RuN17ee9f2bNstuKLWBy+zrLNKuC0fDzlU+3+BY2zYrr6D/7W48p/uvqh1tME058Hv7+e
        XC33tPjo/D7jUuYvB8Mf13cvuvfh5OkI7uiSnc8Wph8I7NfjV/Vd5HK3V2H3/G+1z6c1r4nm
        /hjsp6ExT+JhZfVmpu8Hlc+7y81az//f4eDRGdMn6s/6etRJ+mvCHisT6dUdik+2tD3Qj76q
        c9Fg6tJIY+PvEkI7LpfsKjhqYbaF6d4u3g27r209pt3Ku/3KLL0fpx1uap1QezmreIpKa77T
        FyWW4oxEQy3mouJEAH5wt4b3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSnG7pR/dkgztzOSwezNvGZnF5v7bF
        /CPnWC36XjxktpjyZzmTxeVdc9gsZpzfx2RxdGOwxaKtX9gtWvceYXfg8ti0qpPN4861PWwe
        fVtWMXp83iQXwBLFZZOSmpNZllqkb5fAlfF0rmNBI0/FwomN7A2MTVxdjJwcEgImEt82rWPq
        YuTiEBLYwSjRvus6I0RCWmJ6/x42CFtYYuW/5+wQRc1MEn8mt4MVsQmYSqya08gKkhARWM0o
        8bm/HayDWWAao8SuqfUgtrBAkMTPV9eZQWwWAVWJZdeOAk3i4OAVsJGYuZgPYoG8xOoNB5hB
        wpwCthJPLsiDhIWAKiZ8XcI0gZFvASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M
        4BDU0trBuGfVB71DjEwcjIcYJTiYlUR4XULckoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6
        GS8kkJ5YkpqdmlqQWgSTZeLglGpgqlpZeq19RdHaNSozD6nxrwiedOHgdL7DhZmzHqXoGe2P
        SA1NzhF6Zb9qzhSdpUppIdsPKtxcuP1f/8wn2eUXdPMPZKSzBD2fFlf4o2fT02lp7TKe4S9M
        T05vXsH0TNk0/vBewf29SfWtkdMeLz2Yv3nj1+V+ChxGlV521cfXmfpsF2ppT7S61Va5IWTa
        xTNBRtu/XfopV6G78MHhdy9eXmlOuCVzV/Sd6vk5fvuW2SmstGK+5zfPfc/Wukssf5d8d7uj
        7/z8ofOPmN+X10z/xrqH6ekT0cAUd3sZcWOp2mcfO+d5pS/qWnpJY8qE18eeOq6RXFFQ5i/D
        MqW7u3RG+qOQ+4cXxDNGlrSdnbeGy12JpTgj0VCLuag4EQDNYtL6sAIAAA==
X-CMS-MailID: 20221013110733epcas5p36e0104bfa4da37159da77f9231ff6e2c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221013110733epcas5p36e0104bfa4da37159da77f9231ff6e2c
References: <20221013104024.50179-1-p.rajanbabu@samsung.com>
        <CGME20221013110733epcas5p36e0104bfa4da37159da77f9231ff6e2c@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drive strength values used for SPI is not reflecting the default values
recommended by FSD HW UM.

Fix the drive strength values for SPI, thereby ensuring that the existing
device tree file is using default drive strength values recommended by UM
for FSD SoC.

Fixes: 684dac402f21 ("arm64: dts: fsd: Add initial pinctrl support")
Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index a2634e70925a..e3852c946352 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -323,21 +323,21 @@
 		samsung,pins = "gpb4-0", "gpb4-2", "gpb4-3";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpb4-4", "gpb4-6", "gpb4-7";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	spi2_bus: spi2-bus-pins {
 		samsung,pins = "gpb5-0", "gpb5-2", "gpb5-3";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 };
 
-- 
2.17.1

