Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F19064585D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiLGK7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiLGK6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:58:51 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574561A39E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:58:50 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221207105848epoutp046e7c32720c415ae6bff816c950c704e6~ufbUJPNzt1330513305epoutp04p
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:58:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221207105848epoutp046e7c32720c415ae6bff816c950c704e6~ufbUJPNzt1330513305epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670410728;
        bh=bZ7juhbPVmvnfRZmYoXsE+PJXqIHvFCzrm+/xqlBPdo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pPToPeuvt7gekCLxDbFJxuqtHOk4zb/mlYPU4cLboBGo1fTwnlkZ0zfndURews+Wb
         U0KpEgr/Y2U8hAV9yn1vZkZA8xcjczmOd9EYnt/Nn/bTsPPeQkUvLxOOCNGi8dBat4
         xC+0SIUuDR7Fz0ygVxkv5L/UBxGqgEfw1uuv0c1U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221207105847epcas5p38a85abbbd1c91eca8cab2f3489b7f143~ufbTyctF72019920199epcas5p3o;
        Wed,  7 Dec 2022 10:58:47 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NRvR95TLfz4x9Pt; Wed,  7 Dec
        2022 10:58:45 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.32.01710.ED170936; Wed,  7 Dec 2022 19:58:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221207105040epcas5p187cb82e00083eb7106f78264a76a866b~ufUN61KcG2705427054epcas5p1y;
        Wed,  7 Dec 2022 10:50:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221207105040epsmtrp2cd836474e6cd80fa867d00f2dd0448f1~ufUN6I8Ue0073900739epsmtrp2q;
        Wed,  7 Dec 2022 10:50:40 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-2f-639071de3894
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.4C.18644.00070936; Wed,  7 Dec 2022 19:50:40 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221207105038epsmtip1373c05257271660b48bc76913bb334d6~ufUMY3ndb2444524445epsmtip1D;
        Wed,  7 Dec 2022 10:50:38 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v2 0/4] amr64: dts: exynos: add dedicated SYSREG compatibles
 to Exynos850 and Exynosautov9
Date:   Wed,  7 Dec 2022 16:20:28 +0530
Message-Id: <20221207105032.103510-1-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmuu69wgnJBmduilg8mLeNzWL+kXOs
        Fn0vHjJbbHp8jdXi8q45bBYzzu9jsli09Qu7xcMPe9gtWvceYbe4/WYdqwOXx6ZVnWwed67t
        YfPYvKTeo2/LKkaPz5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTy
        EnNTbZVcfAJ03TJzgI5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YW
        l+al6+WlllgZGhgYmQIVJmRnHHp+mKmgg73i2PQFbA2Mz1i7GDk5JARMJHZPm8bWxcjFISSw
        m1Hiys21zCAJIYFPjBLH3iZDJD4zShyce5kRpmPdmx9QHbsYJbbsX8II4bQySWxpP8MGUsUm
        oCvReu0zE0hCRGAJo0Rr9y6wKmaBKUBzfy0DmyUskCOxr/k8O4jNIqAqce/TZTCbV8BO4mz3
        bGaIffISqzccgLKPsUucvB4HYbtIbPy+mgXCFpZ4dXwLO4QtJfH53V42CDtdYvORzVCf5kh0
        NDVDzbGXOHBlDlAvB9BBmhLrd+lDhGUlpp5axwRiMwvwSfT+fsIEEeeV2DEPxlaTWPyoE8qW
        kVj76BPUeA+JPUueMkLCLlZiQ89HxgmMsrMQNixgZFzFKJlaUJybnlpsWmCYl1oOj6nk/NxN
        jODEpuW5g/Hugw96hxiZOBgPMUpwMCuJ8L7Y2JssxJuSWFmVWpQfX1Sak1p8iNEUGGQTmaVE
        k/OBqTWvJN7QxNLAxMzMzMTS2MxQSZx36ZSOZCGB9MSS1OzU1ILUIpg+Jg5OqQYmhgXX3+o8
        b9g9T9tMyaC2LTlJ93zi32+Tv7NYR/UERNn9X8cXyjapQlA1/d+POO09Op9i1aMec/7108zc
        d+Rmo3FqmmnnJ1Zjt/yZ0vGVK05mFLSdy0jhT+2+P/etyJFbggGJSd/2Kdfnyymx1nm9+HZk
        H1fEn22rKgyXH13MKVl4qLTiypw/rCe+/pu/8Rmn1K03HyTfqjGr7O25O39XXEv+g4LJug3X
        Kz60KGuKzf2dN4114Wm9a/FZaQFTLj7+/f/ecz5Gmd73EakJ2QfqZZILf2hPMXh+5r1qZ+/b
        iD953unrf/bcPn8m59vPSNVFSzyPLEm/fqfM6t7GwzPfvpoQOWWm6sfTj9y1f8lnKrEUZyQa
        ajEXFScCABaMoZb1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJTpehYEKywYInMhYP5m1js5h/5Byr
        Rd+Lh8wWmx5fY7W4vGsOm8WM8/uYLBZt/cJu8fDDHnaL1r1H2C1uv1nH6sDlsWlVJ5vHnWt7
        2Dw2L6n36NuyitHj8ya5ANYoLpuU1JzMstQifbsEroxDzw8zFXSwVxybvoCtgfEZaxcjJ4eE
        gInEujc/2LoYuTiEBHYwSjS8OwCVkJE4+WAJM4QtLLHy33N2iKJmJokr7x+xgCTYBHQlWq99
        ZgJJiAisYpQ482gqmMMsMINRYunSM2wgVcICWRLzfoC0c3KwCKhK3Pt0GczmFbCTONs9G2qF
        vMTqDQeYJzDyLGBkWMUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERxmWlo7GPes+qB3
        iJGJg/EQowQHs5II74uNvclCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0t
        SC2CyTJxcEo1MLHNP+ISWvaoeMN0ZbkdAtwryxecz/4iVGu++8MXjc/CYTNaeL8t3/hEaHLL
        woR/Tt9Ysqd94y2edMlw3SaV71cCLu+z19+/8UHzpCsb52sfE959KJZZ2jblmLi34685G9Lf
        1kvt2vh9+96QHfdvffWc9V/ka+UU4YjEx5pivOtEysVWbClvtmh8MfX1v/PH9Xc873I8OnHC
        iRetiVemZwRZqHU//XSNV3jWrfeH6xJFphipvWzdWnFxXXKn2YEFOw6ft+6z3znfUuBgcXKe
        j4qJSkWkbPN2NcWw4/JsT19Zxj6/0rok+OK3CvvmyAmct/2+L2UM2TffUFHqVfEJqUeHNu87
        9n1vF8uxG8EeTiKPlFiKMxINtZiLihMB947/KKICAAA=
X-CMS-MailID: 20221207105040epcas5p187cb82e00083eb7106f78264a76a866b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221207105040epcas5p187cb82e00083eb7106f78264a76a866b
References: <CGME20221207105040epcas5p187cb82e00083eb7106f78264a76a866b@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos850 and Exynosautov9 has several different SYSREGs, so use dedicated
compatibles for them in dtsi file and add respective compatible in the
samsung exynos devicetree binding document.

Changes since v1:
1. As per Krzysztof comment made an enum of deprecated compatibles.

Sriranjani P (4):
  dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG
    compatibles to Exynos850
  arm64: dts: exynos: add dedicated SYSREG compatibles to Exynos850
  dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG
    compatibles to Exynosautov9
  arm64: dts: exynos: add dedicated SYSREG compatibles to Exynosautov9

 .../soc/samsung/samsung,exynos-sysreg.yaml    | 24 +++++++++++++++----
 arch/arm64/boot/dts/exynos/exynos850.dtsi     |  6 +++--
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi  |  9 ++++---
 3 files changed, 30 insertions(+), 9 deletions(-)

-- 
2.17.1

