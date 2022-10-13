Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132095FD85E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJML2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJML2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:28:20 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19A0D0396
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:28:17 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221013112816epoutp03ebe580e77ffc483083fa67acdc2fc10d~dnWV5JNgA1611516115epoutp03e
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:28:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221013112816epoutp03ebe580e77ffc483083fa67acdc2fc10d~dnWV5JNgA1611516115epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665660496;
        bh=UD9KcMOvzSKTV9rP2NoLIN3VGLg+79Mu6mUZFETlM6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sL7OeRHRY9ADzB+2h1Wo8XUcH7G9LkFDjKoxR6/E58/d9pNjY00MWtLffl0KGTHmE
         AdUKrljh4taKu1VMoAKKClKIcl3txbdHy5c/Yi7k0h0Eh8ZnNwrBYeQdPkC8H9oV9n
         C1xlDSIRCZhotgxh/GZMKiaRsgR202wkA1c2q5kM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221013112815epcas5p151c9a0e34cc551e335518354246b92fe~dnWVel_Pr0635306353epcas5p1I;
        Thu, 13 Oct 2022 11:28:15 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Mp6hX5r3qz4x9Q1; Thu, 13 Oct
        2022 11:28:12 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.AE.56352.C46F7436; Thu, 13 Oct 2022 20:28:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221013110728epcas5p22fb8b83f6cfb4b6a035a9fbb5a38546f~dnEME-iRM3250332503epcas5p2E;
        Thu, 13 Oct 2022 11:07:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221013110728epsmtrp1da49dc49788f52fcb6c6d88046cbfa92~dnEMEKCT-2875628756epsmtrp1P;
        Thu, 13 Oct 2022 11:07:28 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-72-6347f64c7391
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.A5.14392.071F7436; Thu, 13 Oct 2022 20:07:28 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221013110727epsmtip1ca6eb4a5c7354428199d245e90775e96~dnEKo1Nxo0877308773epsmtip1h;
        Thu, 13 Oct 2022 11:07:27 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, chanho61.park@samsung.com,
        linus.walleij@linaro.org, pankaj.dubey@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v3 3/4] arm64: dts: fix UART drive strength values as per
 FSD HW UM
Date:   Thu, 13 Oct 2022 16:10:23 +0530
Message-Id: <20221013104024.50179-4-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013104024.50179-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmlq7PN/dkgxsvdS0ezNvGZnF5v7bF
        /CPnWC36XjxktpjyZzmTxeVdc9gsZpzfx2RxdGOwxaKtX9gtWvceYXfg8ti0qpPN4861PWwe
        fVtWMXp83iQXwBKVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITvj0qqFLAV9XBUHV3xma2Dcx9HFyMkhIWAicethCyuILSSwm1Hi6NfYLkYu
        IPsTo8SJ59fZIZxvjBK/Hp9mhel4efMQM0RiL1DVqWZWCKeVSWLlzatMIFVsAqYSq+Y0giVE
        BJYySvz/tIgRxGEWmMIosXXbDUaQKmGBUIn+tVuAOjg4WARUJVbMrAcJ8wrYSOxbsJQJYp28
        xOoNB5hBSjgFbCWeXJAHGSMhcIld4sj3i1A1LhLPnt9kg7CFJV4d38IOYUtJvOxvg7LzJaZ9
        bIaqqZBo+7gBqtde4sCVOSwg85kFNCXW79KHCMtKTD21DqyEWYBPovf3E6hyXokd82BsVYn1
        yzcxQtjSEvuu74WyPST2z1vCCAmUCYwSC2ZtZZ/AKDcLYcUCRsZVjJKpBcW56anFpgXGeanl
        8FhLzs/dxAhOclreOxgfPfigd4iRiYPxEKMEB7OSCK9LiFuyEG9KYmVValF+fFFpTmrxIUZT
        YPBNZJYSTc4Hptm8knhDE0sDEzMzMxNLYzNDJXHexTO0koUE0hNLUrNTUwtSi2D6mDg4pRqY
        0qIvzbzQM0N6yemvAjns4ad5FQ12XRE+uMpbXnLC2q2C0+dVyKfkHPoYPO/dXcM7V3MPGm8z
        Z26Jlm97+N3xiwqDav7GjdsuCjyULWXbEuT7wXIbzwq2rC/8C76fLPKa9+6378ND2fGGAldk
        o0urjvCEdwRvWrVd5pS88KGz2nO3qBc4X6idXl7bZ/Ry9wRWVkOWetNG83P6vPzT5m81ihe8
        dCJ51r6OrUFMM7gvO21+s2uTs/cMic8e7dLXPzdsOj0x6HhIwPHU6Q+SWspFzvelTItrLb2d
        t3Xhs727F9S0ZU0+U8N9fsU9vyzBkNUFT5pTF+yTevvcQ792XZBMuy6/368XqaeSma8855T+
        pMRSnJFoqMVcVJwIANv8b7z7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSnG7BR/dkg+YHehYP5m1js7i8X9ti
        /pFzrBZ9Lx4yW0z5s5zJ4vKuOWwWM87vY7I4ujHYYtHWL+wWrXuPsDtweWxa1cnmcefaHjaP
        vi2rGD0+b5ILYInisklJzcksSy3St0vgyri0aiFLQR9XxcEVn9kaGPdxdDFyckgImEi8vHmI
        GcQWEtjNKPFxmRBEXFpiev8eNghbWGLlv+fsXYxcQDXNTBLX/m9lAUmwCZhKrJrTyAqSEBFY
        zSjxub8drINZYBqjxK6p9SC2sECwxKwNIA0cHCwCqhIrZoKFeQVsJPYtWMoEsUBeYvWGA8wg
        JZwCthJPLshD3GMjMeHrEqYJjHwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIE
        h6CW5g7G7as+6B1iZOJgPMQowcGsJMLrEuKWLMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJ
        eCGB9MSS1OzU1ILUIpgsEwenVAOT0QJJoaMfGVMSlA8pW0n9kUi3UtsffdH4FVvJ8k7B+k3H
        TkesXdDcvOnWqnsdDzsd381yv7I+6k5/pReX/9n4/XkHanUfSCQa/jBidNT6/uXPzNlZ3kuX
        nQuXYTO16I7LNJfc5Pvgq3imJXds86xPMRs+vvrVz7Ygz8NS3ePIkVgBx6W5Uld6Pl0p/eh5
        aGaY5VHNxc4SPytut+/8tuDPkXTZWQd0xNwl21gyG+ISe52OTD9ovOSRIvN1Hk2F3bYTuBfH
        bPu/X7655w+/ZLjdlN2+1+r7dx9V6gx9Mdu+Lz5p1UGGvw0xUk4LoooO33pelCTkuJNj7fMv
        eyxfaKSzO118/IVZYOWiDb/X2B5WYinOSDTUYi4qTgQAxV2lKLACAAA=
X-CMS-MailID: 20221013110728epcas5p22fb8b83f6cfb4b6a035a9fbb5a38546f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221013110728epcas5p22fb8b83f6cfb4b6a035a9fbb5a38546f
References: <20221013104024.50179-1-p.rajanbabu@samsung.com>
        <CGME20221013110728epcas5p22fb8b83f6cfb4b6a035a9fbb5a38546f@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drive strength values used for UART is not reflecting the default values
recommended by FSD HW UM.

Fix the drive strength values for UART, thereby ensuring that the existing
device tree file is using default drive strength values recommended by UM
for FSD SoC.

Fixes: 684dac402f21 ("arm64: dts: fsd: Add initial pinctrl support")
Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index 09a492b1fd6e..a2634e70925a 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -309,14 +309,14 @@
 		samsung,pins = "gpb7-0", "gpb7-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	uart1_data: uart1-data-pins {
 		samsung,pins = "gpb7-4", "gpb7-5";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	spi0_bus: spi0-bus-pins {
-- 
2.17.1

