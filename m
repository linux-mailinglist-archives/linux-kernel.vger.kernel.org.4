Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577CF6AB46A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 02:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCFByY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 20:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCFByV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 20:54:21 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3260CB74A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 17:54:19 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230306015415epoutp0170240eba42f9ce4e0b5f12bee9dddec4~JsaRWMb3j0203202032epoutp01B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:54:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230306015415epoutp0170240eba42f9ce4e0b5f12bee9dddec4~JsaRWMb3j0203202032epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678067655;
        bh=mJxdAUSREaShX8DFcolRF1CTxDCXGUzkG0FBk9MUzLE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MZwREKSRLcFG+3oQhZ18wXAOQXGqnDOZOpeaQdN+VFp1rr9OvAE+B0ATtRvRUFps+
         aS9auZMwuRgLuULjKvC9R5uxqpLGIEsq99gOHdRIXz2h2OyY/rXdVWvMagY6tFHaem
         aNnFOLQs3KnGSTB0L7IXB0g5pPZxZ4aFopH47Wms=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230306015415epcas2p48b5dd3cb926655134760454c32937ce2~JsaQ2RIOG2100121001epcas2p4R;
        Mon,  6 Mar 2023 01:54:15 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PVM7p4Mtwz4x9QD; Mon,  6 Mar
        2023 01:54:14 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.51.61927.5C745046; Mon,  6 Mar 2023 10:54:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230306015413epcas2p371356e4008af6978cdadb5b859d8be2a~JsaPPhEka0846908469epcas2p3J;
        Mon,  6 Mar 2023 01:54:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230306015413epsmtrp21fa4b2a6f718957f6c580df5ccd5995f~JsaPOxz9c2845028450epsmtrp2d;
        Mon,  6 Mar 2023 01:54:13 +0000 (GMT)
X-AuditID: b6c32a45-e942ca800001f1e7-74-640547c56c07
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.08.18071.5C745046; Mon,  6 Mar 2023 10:54:13 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230306015413epsmtip28258ff89ad99ffc419c1afbac00231c5~JsaO-NCCp0452104521epsmtip23;
        Mon,  6 Mar 2023 01:54:13 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH] spi: s3c64xx: add no_cs description
Date:   Mon,  6 Mar 2023 10:42:39 +0900
Message-Id: <20230306014239.80570-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7bCmue5Rd9YUg4NXlS0ezNvGZrH4x3Mm
        ix0NR1gt9r7eym6x6fE1VovLu+awWcw4v4/JovHjTXYHDo/rSz4xe9y5tofNY/OSeo++LasY
        PT5vkgtgjcq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAE6RUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhg
        YGQKVJiQnbHvZBNrwT62ioNnwhsY97N2MXJySAiYSPy50MbSxcjFISSwg1Gib+05RpCEkMAn
        RokTnVkQiW+MEp/XnGaE6VjfcI4dIrGXUeL+JpAOEOcjo8TidzPZQKrYBLQlvq9fzAqSEBFo
        YJRovjyVDcRhFljPKLHuwhcmkCphoFknVx5hAbFZBFQl/m/aygxi8wrYSlzu38ECsU9eYvWG
        A8wgzRICm9gl7rTuYYJIuEhMfPcU6ihhiVfHt7BD2FISn9/tZYOwsyXap/+BerVC4uKG2VBx
        Y4lZz9qBejmALtKUWL9LH8SUEFCWOHILbC2zAJ9Ex+G/7BBhXomONiGIRjWJ+1PPQQ2RkZh0
        ZCXUMR4Sp/53sYGUCwnESmzZnzCBUXYWwvgFjIyrGMVSC4pz01OLjQoM4XGUnJ+7iRGcuLRc
        dzBOfvtB7xAjEwfjIUYJDmYlEV6eUpYUId6UxMqq1KL8+KLSnNTiQ4ymwNCayCwlmpwPTJ15
        JfGGJpYGJmZmhuZGpgbmSuK80rYnk4UE0hNLUrNTUwtSi2D6mDg4pRqYXJv0DDv3akga7hHV
        q76y5L7YD+8daZYHzi4W/VRq9nHWFlPPS2n9ch0GnWsnSbzfeHDxQmODKYabdgipW//q+Sr+
        cmayTa47X/l615NPNkla1TyxuPZtd2TqJXd/p99LD/A8meL4Z3Pb2Z1Tr9mF/o2Xuh5gZXXJ
        bKmOwubJGmWxoX+3fbOf0b7wq/PLl2HK3maMRyMO94sX7RBUPJWS+LbU4crzafbNpdpNcmVm
        wXe5pj8MqnVcnnq/LZArO6Yq++HS5S4hORvtZsvrV1hph3Xl7vquxpOb1HAj87OOfFLkOt4k
        t2lHHL96f2lin9t/ReydlO2maY+sOTguvqheuVBSOv2PccplHUsfhSdKLMUZiYZazEXFiQC/
        VJ3T5QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphluLIzCtJLcpLzFFi42LZdlhJXveoO2uKwcXXnBYP5m1js1j84zmT
        xY6GI6wWe19vZbfY9Pgaq8XlXXPYLGac38dk0fjxJrsDh8f1JZ+YPe5c28PmsXlJvUffllWM
        Hp83yQWwRnHZpKTmZJalFunbJXBl7DvZxFqwj63i4JnwBsb9rF2MnBwSAiYS6xvOsXcxcnEI
        CexmlDiy/BQLREJGYvmzPjYIW1jifssRVoii94wSuxY/YwRJsAloS3xfvxgsISLQxChx41wv
        M4jDLLCZUaL9/DmwHcJAO06uPAI2lkVAVeL/pq3MIDavgK3E5f4dUOvkJVZvOMA8gZFnASPD
        KkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4IDS0tzBuH3VB71DjEwcjIcYJTiYlUR4
        eUpZUoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgSr11
        +800OR2Xfsl39q3Nzh3ul3gT9U63Md5/slVMZ7naqeO3woUS5H49Yms3Dv8c2W++t1Tb7827
        dZt4uRMy+ip2rLbM8pS+FzivqYy19GGOFWPxvfPKTr+vfjpY9/3Wye1nEha+ebkw7WvHBPVL
        WxeEmucrcW0P/7U9bvJcyyVz8lXeSnqG358sN+fT1D9/NyR3zr3MsZd7+4NfQq6yp+y7ypoM
        2HoXKXR+Y0qxPPxnZ0oP66xH05cfnfpPa94C71WyEfynrnhlf5JW9jOdckxza9DligRR3fa/
        jy51yn2t9l/FGFJ2OVIja8915SXyMxSYfy+MEbG1X5byclmb39ewWNkfUgunufebWcxKV2Ip
        zkg01GIuKk4EAL3mhwWXAgAA
X-CMS-MailID: 20230306015413epcas2p371356e4008af6978cdadb5b859d8be2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230306015413epcas2p371356e4008af6978cdadb5b859d8be2a
References: <CGME20230306015413epcas2p371356e4008af6978cdadb5b859d8be2a@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing variable no_cs descriptions.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 include/linux/platform_data/spi-s3c64xx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index 5df1ace6d2c9..3101152ce449 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -29,6 +29,7 @@ struct s3c64xx_spi_csinfo {
  * struct s3c64xx_spi_info - SPI Controller defining structure
  * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] field.
  * @num_cs: Number of CS this controller emulates.
+ * @no_cs: Used when CS line is not connected.
  * @cfg_gpio: Configure pins for this SPI controller.
  */
 struct s3c64xx_spi_info {
-- 
2.17.1

