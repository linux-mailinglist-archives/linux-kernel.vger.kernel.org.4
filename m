Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565B263194C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 06:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKUFBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 00:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUFBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 00:01:04 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE741B1FE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 21:01:01 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221121050059epoutp03f4137c2a1bceb728f152aef762d9ca3e~pgOVxvt290475404754epoutp03Q
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:00:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221121050059epoutp03f4137c2a1bceb728f152aef762d9ca3e~pgOVxvt290475404754epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669006859;
        bh=6tt9g7xuR7alYqq+mhfUn4B1yyFjrMOO04eGSeP0KTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stYCXYpMshLVoIuVSH0eomj0ngx1HEV2yRt+BACZnfHdSD26KbC8Cph5WAg66jy16
         ucXFfaNdKw82r1pIDqnLqf1S6HmArF++5ealbYpDSVQvdw27RbmaYOSnj+IalvDBsY
         kEDFqebsU5thhSBzUpYd6h7uLuz/hyNxvGXD20u4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221121050059epcas5p3ccc9b7439a4e3f0d04e9f35cbc653e67~pgOVXfACt2185421854epcas5p3R;
        Mon, 21 Nov 2022 05:00:59 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NFwFj5CLxz4x9Q0; Mon, 21 Nov
        2022 05:00:57 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.D2.01710.9060B736; Mon, 21 Nov 2022 14:00:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221121045301epcas5p1d6195b5dc6cafebfb429044b41d0d123~pgHYibe0L0383203832epcas5p1Z;
        Mon, 21 Nov 2022 04:53:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221121045301epsmtrp20ead75c375a3e18adc1fc8493f9d5deb~pgHYhqov80735607356epsmtrp2b;
        Mon, 21 Nov 2022 04:53:01 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-af-637b0609fa9a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.22.14392.D240B736; Mon, 21 Nov 2022 13:53:01 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221121045259epsmtip1f7d59f1b03b1075ab3f05ca39e18057c~pgHWfoOko2866528665epsmtip1F;
        Mon, 21 Nov 2022 04:52:59 +0000 (GMT)
From:   Sathyakam M <sathya@samsung.com>
To:     catalin.marinas@arm.com, will@kernel.org, andersson@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, krzysztof.kozlowski@linaro.org,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        dmitry.baryshkov@linaro.org, broonie@kernel.org,
        pankaj.dubey@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Sathyakam M <sathya@samsung.com>
Subject: [PATCH 5/5] arm64: defconfig: enable FSD MIPI CSI2 Rx controller
 driver
Date:   Mon, 21 Nov 2022 10:28:27 +0530
Message-Id: <3e5e21930e6da6e6d8046fc2e89945dd7449de49.1668963790.git.sathya@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1668963790.git.sathya@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTS5eTrTrZ4EiPlsW2DhuLv5OOsVtM
        ffiEzeL9sh5Gi4nnf7JZ7H29ld1i0+NrrBaXd81hs2h8vIrJYtHWL+wWX468ZrR4sUXcYued
        E8wWLXdMHfg81sxbw+jx+9ckRo9NqzrZPO5c28PmsXlJvUffllVAoVceHp83yQVwRGXbZKQm
        pqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDdrKRQlphTChQK
        SCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIznh35SRz
        wXzuih9LJjM1MD7m7GLk4JAQMJE48ZKji5GLQ0hgN6PExkmn2CCcT4wSjafusUA43xglXqx5
        ydjFyAnW8bLhJVRiL6PEuzvN7CAJIYFWJolbS1RBbDYBNYn13eeYQYpEBM4wSdw9950JJMEs
        oCJx+MF7ZpDdwgJBEpsu1YOEWQRUJS5vmAw2h1cgQmLdxb1MEMvkJVZvOMAMYnMKmEm07rnN
        BDJTQqCXQ2LlznvsEEUuEhNfg5wKYgtLvDq+BSouJfH53V42CDtZonP2ASg7Q+LYq8NQ9fYS
        B67MYQG5h1lAU2L9Ln2IsKzE1FProE7mk+j9/QTqHl6JHfNgbAWJBb1XoUaKSZzuvgBle0jM
        XtvDCAmgTkaJG8/2sUxglJuFsGIBI+MqRsnUguLc9NRi0wLDvNRyeKQl5+duYgQnSy3PHYx3
        H3zQO8TIxMF4iFGCg1lJhFfkWGWyEG9KYmVValF+fFFpTmrxIUZTYABOZJYSTc4Hpuu8knhD
        E0sDEzMzMxNLYzNDJXHexTO0koUE0hNLUrNTUwtSi2D6mDg4pRqYvPpvd//JPj6XRX+VW+jF
        9lthDHmrhOftmiZyN4Lhje2xO+wMjHxTZEuueZhXTfsYnFbyf/2GJ+45y36dtxO7KR5+Z+6U
        a48+vtO0MYqa8GtdUczTk9t79VInOE4Lljlo3bqr8pmx8dGmiO8LRW1sLwclq87UKm78bPDk
        HkdRWtTpU74Z3nVhWmscJHmKFnR8//rlmN6cezpfP/EWS2SUV3VflNbcVX6CibE8v+XN7QUz
        DjFaBd7nu86a3SRziznGoTro3/QAT645Z88EnpqqZ9xVMEd0g9aulffWJPYf33hmbdTZl7fP
        NJ9b/fVy7032XFHvY4YOf1aJVHrU2itdebLHed830U2aj4pl3L43KbEUZyQaajEXFScCAFLa
        wJkfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSnK4uS3WywcdL2hbbOmws/k46xm4x
        9eETNov3y3oYLSae/8lmsff1VnaLTY+vsVpc3jWHzaLx8Somi0Vbv7BbfDnymtHixRZxi513
        TjBbtNwxdeDzWDNvDaPH71+TGD02repk87hzbQ+bx+Yl9R59W1YBhV55eHzeJBfAEcVlk5Ka
        k1mWWqRvl8CV8e7KSeaC+dwVP5ZMZmpgfMzZxcjJISFgIvGy4SULiC0ksJtRYuJHQYi4mMSG
        lfeYIWxhiZX/nrN3MXIB1TQzSZx995UVJMEmoCaxvvscM0hCROAOk0TD+i1sIAlmARWJww/e
        AyU4OIQFAiSWHs4HCbMIqEpc3jCZHcTmFYiQWHdxLxPEAnmJ1RsOgC3jFDCTaN1zmwniIFOJ
        lwtWsU5g5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4nLU0dzBuX/VB7xAj
        EwfjIUYJDmYlEV6RY5XJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgt
        gskycXBKNTBtjd/zYMY+OaH6IL4kcy+2P/IPBZjmXbc4wPe5IrqV/4e70+69ExYa7ZjIyj4/
        VDS+//MM3y9ZnTn2v9kWvfn5TPXILJHfG6WUOn9tetIlkxVwYf38qescrSNLMrczzazbwF+0
        /3PgzZgJiQdTmDtddPjmd8RK+wcq/55kfuyPxLUf/IsZMy22Kiqn2PUlLmbMfdUS+b6eccHP
        4x7H4mdKfHrmonlp8SPxA/+KXwrKzDsyJUd8d6H29IjsjdNSE8RaJpyte1DtU2J//S7TykAW
        PWHeqW83n85YKqJvrqdk0buIxSNa+Z3Q5keLDUtWBPjyWjO9ev1QVuKxXvYEBamVD1Yeyp3l
        9O+rx2dluy1KLMUZiYZazEXFiQAQCX6j1gIAAA==
X-CMS-MailID: 20221121045301epcas5p1d6195b5dc6cafebfb429044b41d0d123
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221121045301epcas5p1d6195b5dc6cafebfb429044b41d0d123
References: <cover.1668963790.git.sathya@samsung.com>
        <CGME20221121045301epcas5p1d6195b5dc6cafebfb429044b41d0d123@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add build rule for FSD MIPI CSI2 Rx controller driver support

This enables CSI2 compatible Camera streaming
with D-PHY as 1600Mbps default data rate.

D-PHY interface can be configured for data rate of 800, 1000,1500,
1600, 2100 Mbps. The corresponding PHY parameters are set accordingly.

Signed-off-by: Sathyakam M <sathya@samsung.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pankaj Kumar Dubey <pankaj.dubey@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0b6af3348e79..9d152a26dc0b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -698,6 +698,7 @@ CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SDR_PLATFORM_DRIVERS=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_FSD_MIPI_CSIS=m
 CONFIG_VIDEO_QCOM_CAMSS=m
 CONFIG_VIDEO_QCOM_VENUS=m
 CONFIG_VIDEO_RCAR_ISP=m
-- 
2.17.1

