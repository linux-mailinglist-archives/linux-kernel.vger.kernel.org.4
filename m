Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE976318C6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 04:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKUDCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 22:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKUDCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 22:02:08 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB59D31DFE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 19:02:04 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221121030201epoutp019c74877c89d38be399dd2ff9cac91ee9~pemdRcCbp0482804828epoutp01l
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:02:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221121030201epoutp019c74877c89d38be399dd2ff9cac91ee9~pemdRcCbp0482804828epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668999721;
        bh=vjbfUFyJK93wID0lNnghGDCYcHsDlchldmX4KHuR58A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=E8ClenqF1etN5uBw1yC3g1UNDn5TfwI7kaI8VAkTY9qd7iA47Z3/vCYIJxbSkakw3
         bENMtaxM6B0aN6S97b9Xm1oOPahZZkBbaG0ZJZ+L/uzCRlEZgkJUhYcdFMZGC5Uv1k
         DFlA1MVinX6D8s/uNroN5jNXSGfy0rCcIDOO5CE8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221121030200epcas5p3fb56e78c633640ee7a6e155b63d95a73~pemcl68AI0188501885epcas5p3j;
        Mon, 21 Nov 2022 03:02:00 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NFscQ556fz4x9Pv; Mon, 21 Nov
        2022 03:01:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.1C.39477.62AEA736; Mon, 21 Nov 2022 12:01:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221120184648epcas5p3e08766377944a2c5850f9600bf75cf8f~pX2FSUNgc0474704747epcas5p3X;
        Sun, 20 Nov 2022 18:46:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221120184648epsmtrp1b7b1c94339974b98eae8144b4987909d~pX2FOtdYE0246702467epsmtrp1K;
        Sun, 20 Nov 2022 18:46:48 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-5b-637aea26ebc8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.E5.14392.8167A736; Mon, 21 Nov 2022 03:46:48 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221120184646epsmtip2a39b4e4feb3d410449cd7cf54fb2a1fe~pX2DNRgsC1606116061epsmtip21;
        Sun, 20 Nov 2022 18:46:46 +0000 (GMT)
From:   Sathyakam M <sathya@samsung.com>
To:     sathya@samsung.com
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pankaj Kumar Dubey <pankaj.dubey@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Andi Shyti <andi@etezian.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ming Qian <ming.qian@nxp.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] media: add FSD MIPI-CSI2 Rx controller driver
Date:   Mon, 21 Nov 2022 00:22:16 +0530
Message-Id: <cover.1668963790.git.sathya@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmlq7aq6pkg/eTVSwezNvGZrH4x3Mm
        i0Obt7JbXJx5l8Xi7vMWRoujrf+ZLfpePGS22PT4GqvF5V1z2CwaH69istg1fQe7xaKtX9gt
        vhx5zWjxYou4RcsdUwd+j+tLPjF7/L/xiNlj06pONo871/aweWxeUu+x8d0OJo++LasYPTa9
        8vD4vEnO49TXz+wBXFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2
        Si4+AbpumTlAPygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L1
        8lJLrAwNDIxMgQoTsjP+7SsvmCJfcfTDAuYGxn2SXYycHBICJhI/zt9g62Lk4hAS2M0ocbPz
        BjOE84lRYsbLw6wQzjdGiQkvzjHBtLxbdAaqZS+jxN22jYwQTiuTxK1rE1hBqtgE1CTWd59j
        BrFFBMQkrmz6BTaXWWADi8T95Q/BRgkLOElMnL4crIhFQFXi+OIFYHFeAVOJz/M/MUKsk5dY
        veEAM4TdyiFxc5UnhO0icfLRbDYIW1ji1fEt7BC2lMTL/jYoO1mic/YBqJoMiWOvDrNA2PYS
        B67MAbI5gA7SlFi/Sx8iLCsx9dQ6sBOYBfgken8/gfqYV2LHPBhbQWJB71WokWISp7svQNke
        En9/PQFbKyQQKzH75GG2CYyysxA2LGBkXMUomVpQnJueWmxaYJSXWg6PqOT83E2M4KSp5bWD
        8eGDD3qHGJk4GA8xSnAwK4nwihyrTBbiTUmsrEotyo8vKs1JLT7EaAoMsonMUqLJ+cC0nVcS
        b2hiaWBiZmZmYmlsZqgkzrt4hlaykEB6YklqdmpqQWoRTB8TB6dUA1Me91fr7imKp9azJ5af
        s02S8WVy4r0suJn11ZmfLyxEjv6e2LqazTmJ8WltHNPK/XInFRXXG0eys+VWJfVMW7/dRfLN
        10f7S1RzVj2O0ePjXJznsFAi413+7WLL/S/uT/LU38K/NePOfvsLl3ILBf7HOdyv2PV17xMR
        tmau1Z4aPxlWKghMSMnXn/aHc//d9Mq9TxKf/LoRUffhzC2Ta+vPfxTr2HvyTuXSsqifuWEV
        rBZ/Y8Nvf9J64HuBK/ivv0FLe17Azy1rObqePBMVfOW565P07hcLbzWHvFT8WaTcHpT1IXnH
        o89zn5THpjrecejg9VnBJ7sgU35d8cF70lvMZm4Mn1tfXP9r8wIfzi9KLMUZiYZazEXFiQCb
        N7g/IwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSvK5EWVWyQe8ZUYsH87axWSz+8ZzJ
        4tDmrewWF2feZbG4+7yF0eJo639mi74XD5ktNj2+xmpxedccNovGx6uYLHZN38FusWjrF3aL
        L0deM1q82CJu0XLH1IHf4/qST8we/288YvbYtKqTzePOtT1sHpuX1HtsfLeDyaNvyypGj02v
        PDw+b5LzOPX1M3sAVxSXTUpqTmZZapG+XQJXxr995QVT5CuOfljA3MC4T7KLkZNDQsBE4t2i
        M2xdjFwcQgK7GSUeTXrKDJEQk9iw8h6ULSyx8t9zdoiiZiaJb5dPsoMk2ATUJNZ3nwMrEgFq
        uLLpFzNIEbPAHhaJ/50L2UASwgJOEhOnLwcrYhFQlTi+eAETiM0rYCrxef4nRogN8hKrNxxg
        nsDIs4CRYRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnAAa2nuYNy+6oPeIUYmDsZD
        jBIczEoivCLHKpOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi
        4JRqYJoyzb5SPkzY6XKT2KVbh7+J3p0fedptYeB89b/eT1IjHxqXeDKkezzR4jTVmW31QqrX
        W1JkzZbaqWdOfOw88UqFce/1TSw6HuvCfJZFzGnmjJ/NEjlzxTq3wwJ8Cq4nuJZybS65Hsi3
        Z9v1Tv/2BatrmSzbtWVa2OeuuRHpffzP0iPS5llnnXYm3fGaI2kSE2z2Vz9HX6Rtn2eX5WHj
        I95fjoQu3fQhqOWFzKF7r9asXF2X13639edF84yKTXu69roJLbu0astDUb6X7RzvVhnoe0nn
        T5X8KdjEl+rLqFu3YdNC9YDHETo5K3vuP2q9U1S86V5jq1l7h9DfVwIsz+9a5L4PXNhbnBQz
        d/a6vUosxRmJhlrMRcWJAPbRg4LPAgAA
X-CMS-MailID: 20221120184648epcas5p3e08766377944a2c5850f9600bf75cf8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221120184648epcas5p3e08766377944a2c5850f9600bf75cf8f
References: <CGME20221120184648epcas5p3e08766377944a2c5850f9600bf75cf8f@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the V4L2 media driver for
Tesla Full Self Driving (FSD) SoC MIPI-CSI2 Rx controller.

The controller is compliant to MIPI CSI2 v1.3 specification.
It receives images from camera sensors over the D-PHY interface.

The D-PHY interface is compliant to MIPI D-PHY v1.2 specification. It
supports up to maximum of 4 data lanes.

V4L2 user control is provided to set the desired number of data lanes.

Maximum of up to 4 streams can be received simultaneously by one Rx
port. (Each streams identified by designated Virtual Channel
Identifier).

The controller instances consist of port property describing the endpoints.
When combined with remote-endpoint property the driver instantiates
video device nodes using V4L2 async subdev methods.

Streaming formats supported:
- YUV420
- RGB565, RGB666, RGB888
- RAW8, RAW10, RAW12
- JPEG

The driver implementation is verified on FSD evaluation board.

Thanks, Sathyakam

Cc: Sathyakam M <sathya@samsung.com>,Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Pankaj Kumar Dubey <pankaj.dubey@samsung.com>,Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,Shashank Prashar <s.prashar@samsung.com>
Cc: Aswani Reddy <aswani.reddy@samsung.com>,Chandrasekar R <rcsekar@samsung.com>
Cc: Andi Shyti <andi@etezian.org>,Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Ming Qian <ming.qian@nxp.com>,Dmitry Osipenko <digetx@gmail.com>
Cc: Jacopo Mondi <jacopo@jmondi.org>,Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>,Bjorn Andersson <andersson@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>,Arnd Bergmann <arnd@arndb.de>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,linux-phy@lists.infradead.org,devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-media@vger.kernel.org

Sathyakam M (5):
  dt-bindings: phy: fsd: MIPI CSI2 Rx controller syscon node
  media: dt-bindings: fsd: MIPI CSI2 Rx controller device nodes
  arm64: dts: fsd: add device tree nodes for MIPI CSI2 Rx controller
  media: fsd: add MIPI CSI2 Rx controller driver
  arm64: defconfig: enable FSD MIPI CSI2 Rx controller driver

 .../bindings/media/tesla-fsd-csis.yaml        |  148 +
 .../bindings/phy/fsd-csis-syscon.yaml         |   48 +
 .../media/drivers/fsd-csis-uapi.rst           |   78 +
 MAINTAINERS                                   |   12 +
 arch/arm64/boot/dts/tesla/fsd-evb.dts         |  232 ++
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  162 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/fsd/Kconfig            |   73 +
 drivers/media/platform/fsd/Makefile           |    1 +
 drivers/media/platform/fsd/fsd-csis.c         | 2664 +++++++++++++++++
 drivers/media/platform/fsd/fsd-csis.h         |  785 +++++
 include/uapi/linux/fsd-csis.h                 |   19 +
 include/uapi/linux/v4l2-controls.h            |    5 +
 15 files changed, 4230 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/tesla-fsd-csis.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/fsd-csis-syscon.yaml
 create mode 100644 Documentation/userspace-api/media/drivers/fsd-csis-uapi.rst
 create mode 100644 drivers/media/platform/fsd/Kconfig
 create mode 100644 drivers/media/platform/fsd/Makefile
 create mode 100644 drivers/media/platform/fsd/fsd-csis.c
 create mode 100644 drivers/media/platform/fsd/fsd-csis.h
 create mode 100644 include/uapi/linux/fsd-csis.h


base-commit: 77c51ba552a1c4f73228766e43ae37c4101b3758
-- 
2.17.1

