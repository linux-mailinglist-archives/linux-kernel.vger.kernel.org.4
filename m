Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFBC63E7B6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 03:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiLACUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 21:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiLACUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 21:20:00 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063159FEDB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 18:19:46 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221201021943epoutp049cde197f7ddec2175a36ab3ab074e1ba~sieYlleFx0741407414epoutp04r
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:19:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221201021943epoutp049cde197f7ddec2175a36ab3ab074e1ba~sieYlleFx0741407414epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669861183;
        bh=l1If9qevrdgPMTnDZvKYFeo3U9Zroo6SmdbsNrjgols=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sPKMhG9DeNXMx5JigZvNGgY0UOMzAHvuUxvPvEjFJiMw6k/Ubv8V5uiBFThLNmLJ6
         VBmBgxQf/oXlFFQHANncgfHPN+49J+njHwBrUg28Rdh1eZ6N2cpszE0HR1KgyRnJj+
         IjZlDUOPGzTtzJ7MVtR9Nk30XTpoiEN1SflFkIZo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20221201021942epcas2p1e1acaf3c4e6d875572e0cf2e21032495~sieX6t7eC0927609276epcas2p1i;
        Thu,  1 Dec 2022 02:19:42 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NN0C22k8jz4x9Q3; Thu,  1 Dec
        2022 02:19:42 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.CC.18762.E3F08836; Thu,  1 Dec 2022 11:19:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20221201021941epcas2p4a536a9eb029a990fcb9f27f2b4668d07~sieXLmuXf2464024640epcas2p4l;
        Thu,  1 Dec 2022 02:19:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221201021941epsmtrp2f5d9a4da7d63fcac65127172340d3019~sieXKkCQy1711217112epsmtrp2J;
        Thu,  1 Dec 2022 02:19:41 +0000 (GMT)
X-AuditID: b6c32a48-64bff7000001494a-07-63880f3ec91e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.D6.14392.D3F08836; Thu,  1 Dec 2022 11:19:41 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221201021941epsmtip245fc816685679eede3eff0351f5f8bd5~sieW9QbBW2761727617epsmtip2h;
        Thu,  1 Dec 2022 02:19:41 +0000 (GMT)
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
Subject: [RFC PATCH v1 1/2] dt-bindings: usb: samsung,exynos-xhci: support
 Samsung Exynos xHCI Controller
Date:   Thu,  1 Dec 2022 11:13:30 +0900
Message-Id: <1669860811-171746-2-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmqa4df0eyQc9jYYsH87axWfyddIzd
        4uaENYwWk9q/sFrMP3KO1eLOgmlMFqeWL2SyaF68ns1izk0ji7sPf7BY9L14yGwx5c9yJotN
        j6+xWlzeNYfNYsb5fUwWi5a1Mls0b5rCatG69wi7RdfdG0DjDopa/NryitFB1OP3r0mMHjtn
        3WX3WLznJZPHplWdbB53ru1h89g/dw27x+Yl9R59W1YxeqzfcpXF4/MmuQCuqGybjNTElNQi
        hdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAXlRTKEnNKgUIBicXF
        Svp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGXf6j7AWtHNW
        TD3QzNzAeIO9i5GTQ0LARGLPjj3MXYxcHEICOxglHjUfYYJwPjFKrOy/yw7hfGOU+NIxhw2m
        pXXHK1aIxF5GianT/7FBOD8YJXpWT2XpYuTgYBPQkvi+kBEkLiLwiVniXuc9RpBuZoF3zBL9
        W6JBbGGBbIl3Ly6BxVkEVCU2bnrJBNLLK+AmcfOjAsQyOYmb5zqZQWxOAXeJrXsugN0qIXCB
        Q+LSxousEEUuEhdfzGGCsIUlXh3fAvWclMTnd3uhrs6WuP6tmwXCrpBYsRfGNpaY9aydEWQv
        s4CmxPpd+iCmhICyxJFbLBAX80l0HP7LDhHmlehoE4JoVJaYfnkC1AGSEgdfn2OGsD0kJkx4
        DA3EWYwSd58/Y5nAKDcLYcECRsZVjGKpBcW56anFRgUm8AhLzs/dxAhOwVoeOxhnv/2gd4iR
        iYPxEKMEB7OSCG/H57ZkId6UxMqq1KL8+KLSnNTiQ4ymwKCbyCwlmpwPzAJ5JfGGJpYGJmZm
        huZGpgbmSuK8XTO0koUE0hNLUrNTUwtSi2D6mDg4pRqYeOKLtJcUXirc8Ozv2wf7X/w1ur7j
        sZRZ487j58x1srMe3t33yM/ULuN4t8gqztOruTd/PZVadGPVi/CGBUvLZ7nb81SeYVnUXJDl
        9vNe2KogXg92FmeRpOoA+T1GDQl+HaZ88e+u3HgUGq3BnzSpJ4mh/u5LLm4lwwdTD66eLGm+
        j0/KosDn07+gyXanHS5vuG04qzjr6ymp8wEno1XKWZm+H+2JyJ3mblXLdvZZ7HnftWuc6oW2
        czLs/MRXV+QVWJ+z5d/DtcxFH59xTmGzSTr1oMnCPStr3gWTj75HLvgbc/1Xjpw3ce4kcdUj
        63nSWWfL5Zcw7//hr7vFKqXZpcFKOFlWi2/Twn9iWsZKLMUZiYZazEXFiQDv0lD6SgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvK4tf0eyweF/BhYP5m1js/g76Ri7
        xc0JaxgtJrV/YbWYf+Qcq8WdBdOYLE4tX8hk0bx4PZvFnJtGFncf/mCx6HvxkNliyp/lTBab
        Hl9jtbi8aw6bxYzz+5gsFi1rZbZo3jSF1aJ17xF2i667N4DGHRS1+LXlFaODqMfvX5MYPXbO
        usvusXjPSyaPTas62TzuXNvD5rF/7hp2j81L6j36tqxi9Fi/5SqLx+dNcgFcUVw2Kak5mWWp
        Rfp2CVwZd/qPsBa0c1ZMPdDM3MB4g72LkZNDQsBEonXHK9YuRi4OIYHdjBJNvUvZIBKSEkvn
        whQJS9xvOQJV9I1RYteFVsYuRg4ONgEtie8LGUHiIgK/mCVe/G5mBnGYBT4wSxzp3MAGUiQs
        kClx/0EeyCAWAVWJjZteMoGEeQXcJG5+VICYLydx81wnM4jNKeAusXXPBTBbCKikbdsUxgmM
        fAsYGVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgRHi5bmDsbtqz7oHWJk4mA8xCjB
        wawkwtvxuS1ZiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6p
        BqbQHWd5HS/o33W8/mb1zY7dO7+/dm2Wn7Tx+5Hnug/1vEVXdey3uzn3Xn47V2mCapQyq4xA
        WEPJfuF1WX+1uDprr8TI3TdLCz/J8Mh9xcODamVtU0V425Xdu2Iy9xW/9OVovbbm/KPyOx+n
        6fhIvTV65Rqy2OPkDNOovqcVxbmRqtG1O3dbet/yUZlrd6mKt/iGQKl10a7Ak+FPl9ufP8bw
        1ELQn/sHV+oHxy9m9z7PuP3C6E/8+v3r3M7m32rZ+1fW+pXzpnt1Bz3XFN9kOVQZPKGtNbFq
        fomb5eEf/lKn/x2WnJDGujuOycOtZ8p6lvr9860zNGf9aohTW3x1nb/h5rtGmxsEUmc9vRhl
        EqjEUpyRaKjFXFScCADLkdGZBQMAAA==
X-CMS-MailID: 20221201021941epcas2p4a536a9eb029a990fcb9f27f2b4668d07
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221201021941epcas2p4a536a9eb029a990fcb9f27f2b4668d07
References: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
        <CGME20221201021941epcas2p4a536a9eb029a990fcb9f27f2b4668d07@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Samsung Exynos xHCI Controller bindings with DT schema format.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 .../bindings/usb/samsung,exynos-xhci.yaml     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml

diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
new file mode 100644
index 000000000000..c5dde53b6491
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/samsung,exynos-xhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos xHCI
+
+maintainers:
+  - Daehwan Jung <dh10.jung@samsung.com>
+
+properties:
+  compatible:
+    const: samsung,exynos-xhci
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    xhci {
+        compatible = "samsung,exynos-xhci";
+    };
-- 
2.31.1

