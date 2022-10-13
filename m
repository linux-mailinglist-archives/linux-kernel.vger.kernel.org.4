Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D205FD859
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJML2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJML2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:28:12 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23CCC7065
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:28:10 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221013112809epoutp013a137af4f436d570fce9831c77596318~dnWPPISom0382103821epoutp01X
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:28:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221013112809epoutp013a137af4f436d570fce9831c77596318~dnWPPISom0382103821epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665660489;
        bh=JeVojRj3kk+BkahlcsybIQQYLyYwgh3yqE4Midxx2Gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ei7mfba+6RwTgY/NIMq4KkltN5UwcKaaAwIAlCO3sLY0sbraR3vJMrxlftxETLFsY
         ZL0FGQb2YAfxJDYLcHp4+XMd+NF7G76/WJiyuUEPDVlkbS8r5R7D2C3xfWKQ4Osey+
         grRlnpH5cgRvg+To8sugxWys9dwLP/Rrb3vxgT7s=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221013112808epcas5p3c377c620763bd678891df82ff8abc324~dnWOjdprO2614026140epcas5p3Q;
        Thu, 13 Oct 2022 11:28:08 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Mp6hP6MNNz4x9Q1; Thu, 13 Oct
        2022 11:28:05 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.E3.39477.546F7436; Thu, 13 Oct 2022 20:28:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221013110725epcas5p1411c422eb2c29494fd5c1e66e09564c5~dnEIqtEfP2676526765epcas5p18;
        Thu, 13 Oct 2022 11:07:25 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221013110725epsmtrp2e8031efb14d087625e52b936ebfbb22d~dnEIp6GgD0657106571epsmtrp2V;
        Thu, 13 Oct 2022 11:07:25 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-e7-6347f645f63c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.FC.18644.D61F7436; Thu, 13 Oct 2022 20:07:25 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221013110723epsmtip1571eca9c15e1f902c3ff481e551a5189~dnEHPG1pT0877308773epsmtip1f;
        Thu, 13 Oct 2022 11:07:23 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, chanho61.park@samsung.com,
        linus.walleij@linaro.org, pankaj.dubey@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v3 2/4] arm64: dts: fix HSI2C drive strength values as per
 FSD HW UM
Date:   Thu, 13 Oct 2022 16:10:22 +0530
Message-Id: <20221013104024.50179-3-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013104024.50179-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmpq7rN/dkg09bhSwezNvGZnF5v7bF
        /CPnWC36XjxktpjyZzmTxeVdc9gsZpzfx2RxdGOwxaKtX9gtWvceYXfg8ti0qpPN4861PWwe
        fVtWMXp83iQXwBKVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITvjxO2FzAWNYhVbdm1namCcLtTFyMkhIWAisWZfB1MXIxeHkMBuRokX+7vY
        QBJCAp8YJR4cT4RIfGaUeNmyggWmY1tPExtEYhejxImu2SwQTiuTxPIHhxlBqtgETCVWzWlk
        BUmICCxllPj/aREjiMMsMIVRYuu2G2BVwgJhEhdnXWIHsVkEVCX2L7vJCmLzCthIvNs1hxFi
        n7zE6g0HmLsYOTg4BWwlnlyQB5kjIXCNXeLvmbusEDUuEosvzYa6T1ji1fEt7BC2lMTnd3vZ
        IOx8iWkfm6HsCom2jxuYIGx7iQNX5rCAzGcW0JRYv0sfIiwrMfXUOrASZgE+id7fT6DKeSV2
        zIOxVSXWL98Edaa0xL7re6FsD4lHXR+gQTSBUWLNvJlsExjlZiGsWMDIuIpRMrWgODc9tdi0
        wCgvtRwebcn5uZsYwWlOy2sH48MHH/QOMTJxMB5ilOBgVhLhdQlxSxbiTUmsrEotyo8vKs1J
        LT7EaAoMv4nMUqLJ+cBEm1cSb2hiaWBiZmZmYmlsZqgkzrt4hlaykEB6YklqdmpqQWoRTB8T
        B6dUA1PtDe8dXi5x2a2iq3jv+yy55OHx8shB00Xftk7dc/hdVmLRgyc6/IWRvRGpn8oczkRy
        7He49O3W+wmxUunC3aYeF8sytMUm/c2auD9L4s/Ry79lAs1vKH2dtujrTZsJ0UfUV7GXTYu9
        Us2mzVgQ8F8/ou9q4DY5qxkznt7QEbpQvFTp6EnbzDkZdya6bdcLZlNhfiS2feXTTTz3wnaf
        6A8p+SRWz/lvxdYJ1x7sjeM5HfFmj5aahnbm38L7p/TKO15pzbx9vPGcJpPwowcrw6s+3Phf
        +7wuRfVJZArbV8FprPkntv1avuX3qqNC15PWJ3tM3XGP57XVs6mr2RrCVjwovhjwTu6q5d1p
        /8zNVcwZlViKMxINtZiLihMB2VTOwfwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSnG7uR/dkgzW/2CwezNvGZnF5v7bF
        /CPnWC36XjxktpjyZzmTxeVdc9gsZpzfx2RxdGOwxaKtX9gtWvceYXfg8ti0qpPN4861PWwe
        fVtWMXp83iQXwBLFZZOSmpNZllqkb5fAlXHi9kLmgkaxii27tjM1ME4X6mLk5JAQMJHY1tPE
        1sXIxSEksINR4sHne2wQCWmJ6f17oGxhiZX/nrNDFDUzSWzYsZgFJMEmYCqxak4jK0hCRGA1
        o8Tn/nawDmaBaYwSu6bWg9jCAiES/7bfYAWxWQRUJfYvuwlm8wrYSLzbNYcRYoO8xOoNB5i7
        GDk4OAVsJZ5ckAcJCwGVTPi6hGkCI98CRoZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5
        mxjBYailtYNxz6oPeocYmTgYDzFKcDArifC6hLglC/GmJFZWpRblxxeV5qQWH2KU5mBREue9
        0HUyXkggPbEkNTs1tSC1CCbLxMEp1cB0JT6lzMn6zjrjpRtqjqRlb6174r/T4PIXyzmH305c
        EZM3KWFtdbXYArsDbqvfcjHumZ7tnayuLenb2h5ZPynnV+accxe0NwhemPU7hK2iamdb9E5p
        gTP7o+s+nH2c65Dz+XhnZ8lRvpXpv0/KaoRsntfmE5aqvLLBb/UmAfWn/y8cmfxw1ZKQ/MUq
        /bdt/SdEzvnf/ENu4rbcD91rOypdQx3uW2Qer+ZLYm++xKCx809xi5nj+lvCqyMa30iXMASc
        1BOrdBfhWCkVmMyc15LDaLX009roN4zh/yOm+pb91DUNEop/VqZrv+b758nzxdvOcf36ucOO
        8eNVJWkH9nm2P/mEtlb4WBkZegrNi1ViKc5INNRiLipOBABDJo7GsgIAAA==
X-CMS-MailID: 20221013110725epcas5p1411c422eb2c29494fd5c1e66e09564c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221013110725epcas5p1411c422eb2c29494fd5c1e66e09564c5
References: <20221013104024.50179-1-p.rajanbabu@samsung.com>
        <CGME20221013110725epcas5p1411c422eb2c29494fd5c1e66e09564c5@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drive strength values used for HSI2C is not reflecting the default values
recommended by FSD HW UM.

Fix the drive strength values for HSI2C, thereby ensuring that the existing
device tree file is using default drive strength values recommended by
UM for FSD SoC.

Fixes: 684dac402f21 ("arm64: dts: fsd: Add initial pinctrl support")
Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index 4e151d419909..09a492b1fd6e 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -253,56 +253,56 @@
 		samsung,pins = "gpb0-0", "gpb0-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c1_bus: hs-i2c1-bus-pins {
 		samsung,pins = "gpb0-2", "gpb0-3";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c2_bus: hs-i2c2-bus-pins {
 		samsung,pins = "gpb0-4", "gpb0-5";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c3_bus: hs-i2c3-bus-pins {
 		samsung,pins = "gpb0-6", "gpb0-7";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c4_bus: hs-i2c4-bus-pins {
 		samsung,pins = "gpb1-0", "gpb1-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c5_bus: hs-i2c5-bus-pins {
 		samsung,pins = "gpb1-2", "gpb1-3";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c6_bus: hs-i2c6-bus-pins {
 		samsung,pins = "gpb1-4", "gpb1-5";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c7_bus: hs-i2c7-bus-pins {
 		samsung,pins = "gpb1-6", "gpb1-7";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	uart0_data: uart0-data-pins {
-- 
2.17.1

