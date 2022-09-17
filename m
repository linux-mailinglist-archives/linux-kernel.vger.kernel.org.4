Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A64F5BB6EF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiIQHYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIQHYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:24:10 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE3246217
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:24:05 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220917072401epoutp0161f67a9a9d9feff6810e89d6d1df0bd0~VlPqRf85J2007820078epoutp01c
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:24:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220917072401epoutp0161f67a9a9d9feff6810e89d6d1df0bd0~VlPqRf85J2007820078epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663399441;
        bh=uIG1Ab2hwSuc2OnMPQIs1HHNtvMtYsH7j0lr/KbeZwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBT3yzpkQsCeSa9J+4QIckytRdOy+Le2RiWqcByg2yoz5TUaNvOiE7ImFLByRRDRU
         fKdfwZgNd4bSW5+CvLVvlkDMMcIzWb1McBUe/ayzgp9NlD3diR+wUs3DjCGGmOrZge
         gHiZ0cfURcZIjsDQgQd0+IGh1TBP0GFa3IX94Dag=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220917072400epcas1p410367dd6f8ad959e503576a0e5674128~VlPpGZZTy2768227682epcas1p43;
        Sat, 17 Sep 2022 07:24:00 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.135]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MV2Vl2mKYz4x9Pt; Sat, 17 Sep
        2022 07:23:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.40.07146.F0675236; Sat, 17 Sep 2022 16:23:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220917072358epcas1p30b24a99cbf5a0ae7175efc794c5d218d~VlPnxGGxt0623006230epcas1p3N;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220917072358epsmtrp1188c2b6e8a05a6525dbdf45ab750f8cf~VlPnwY6CP0556805568epsmtrp1f;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
X-AuditID: b6c32a35-205ff70000021bea-80-6325760f1cd3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.F0.18644.E0675236; Sat, 17 Sep 2022 16:23:58 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072358epsmtip23409063fa42f0515fafc25b3eac731ea~VlPniMp0Y2858228582epsmtip27;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        krzysztof.kozlowski@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com, jiho.chu@samsung.com
Subject: [PATCH v2 12/13] MAINTAINERS: add TRINITY driver
Date:   Sat, 17 Sep 2022 16:23:55 +0900
Message-Id: <20220917072356.2255620-13-jiho.chu@samsung.com>
In-Reply-To: <20220917072356.2255620-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTT5e/TDXZoHOmqMXfScfYLaY+fMJm
        0bx4PZvF++7dzBZ7X29lt7i8aw6bxe3GFWwW+3o+Mlo8n3adxYHT4/evSYwem1Z1snncubaH
        zWP/3DXsHn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQ
        l5ibaqvk4hOg65aZA3SVkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAtECvODG3
        uDQvXS8vtcTK0MDAyBSoMCE74/e3WawFDewVt3/NZG5g/M/axcjBISFgIvHtS00XIxeHkMAO
        RonOO+2MEM4nRonWtk5mCOczo8SsWzOYYDoWz3SGiO9ilDg7eQ4LXNHXN0eBxnJysAmoSsyc
        sYYdxBYRKJdo3ngCzGYWyJF4cqeJGcQWFrCU+HP+JVg9C1D99YkHWUBsXgEbieO7doHVcALZ
        Nzc1QcUFJU7OfMICMUdeonnrbLDrJAS+skvcmH8DrEFCwEXi6L5FULawxKvjW9ghbCmJl/1t
        UHa2xJSORSwQdoHEuedbmSE+M5a4uCIFxGQW0JRYv0sfokJRYufvuYwQa/kk3n3tgYYcr0RH
        mxBEiZLEkj+HoYZLSEyd8Y0JwvaQOL7jDjRA+xkl+jo+MU5glJ+F5JtZSL6ZhbB5ASPzKkax
        1ILi3PTUYsMCQ3icJufnbmIEp0st0x2ME99+0DvEyMTBeIhRgoNZSYRX1VMlWYg3JbGyKrUo
        P76oNCe1+BCjKTB8JzJLiSbnAxN2Xkm8oYmlgYmZkbGJhaGZoZI4r542Y7KQQHpiSWp2ampB
        ahFMHxMHp1QD0+q+9te60stnzp1aX3/6za3fXl7iMu7KfK/lnuyfU/f6/z+XSgenDa4/Wc9s
        SmLI6XnR8Ctg2SyP9jOlAcXSH9pu2mwXmrCTe8UVtYMVKxLVgu7F/DUJfyrzd5q33sR/AjXt
        zDWVWhqMx24lTIvyM3sT5mj/SLZo48WrKu0fVq3LVHBcrNBmpXvq7KPfj10cr60TiVxUPjH9
        nvtswfqOnL/1G56XNG9e6dHGkbjP69WjLcJWHeoFoV+sZc5f9Vl+myMj5reU3YOXUq6zTDZd
        u7LplcJ0lZvRsx8LPUzwy5Gq2Hj4f8VxbosasZ+dIoEqi42khQ1mOb4MfzZ3V9K5jqb5dY8X
        7BS4srh956+QFCWW4oxEQy3mouJEAO6bJa4gBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvC5fmWqyweyb8hZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfG72+zWAsa2Ctu/5rJ3MD4n7WLkYND
        QsBEYvFM5y5GLg4hgR2MEr/+z2TrYuQEiktIbLq3nBmiRlji8OFiiJqPjBKL/zSA1bAJqErM
        nLGGHcQWEaiVOHh0PjOIzSxQIDH76UwWEFtYwFLiz/mXrCA2C1D99YkHweK8AjYSx3ftAqvn
        BLJvbmoCiwsJWEvMnj6XCaJGUOLkzCcsEDPlJZq3zmaewMg/C0lqFpLUAkamVYySqQXFuem5
        xYYFRnmp5XrFibnFpXnpesn5uZsYwYGtpbWDcc+qD3qHGJk4GA8xSnAwK4nwqnqqJAvxpiRW
        VqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXA5Bi92bB8/+ywE7aK
        r+8zLYusfviRpbSt7Phrk4Nrg6/cddDfJH1RdPmefwtq2UOjD3Ey1TpMsjVfWmR+39L1hbre
        239Kk5szPwlYVp55/U/Ps0Y81ff9fMvV98tmPLD4cCdDf0qodXB6+JuQKs3potPv3DbbpNIa
        9TO9yqxSJe2mWrjPyken79kHqeZsFBZ/9PR1Oq+YknPdKu17WfEL1tSummmw8uqRqMVzD+89
        OOXYarclxqE8x7g3z0w4vKFT5IOb+LbVTX0fkh9ZLYqTexo4Z8m72S0hZoUpTV9WKxY2z5ae
        53dCJG3b4gU+kxjqWR+8zJtqO1nWeYIFl/fprR9q1OZP/aTz5+ruTwd2ViuxFGckGmoxFxUn
        AgBnWdp22wIAAA==
X-CMS-MailID: 20220917072358epcas1p30b24a99cbf5a0ae7175efc794c5d218d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072358epcas1p30b24a99cbf5a0ae7175efc794c5d218d
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072358epcas1p30b24a99cbf5a0ae7175efc794c5d218d@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SAMSUNG TRINITY DRIVER.
Jiho Chu and Yelin Jeong is added as the maintainers.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cf9842d9233..e166558e693e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17690,6 +17690,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
 F:	drivers/thermal/samsung/
 
+SAMSUNG TRINITY DRIVER
+M:	Jiho Chu <jiho.chu@samsung.com>
+M:	Yelin Jeong <yelini.jeong@samsung.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/arm/samsung,trinity.yaml
+F:	drivers/misc/trinity/
+F:	include/uapi/misc/trinity.h
+
 SAMSUNG USB2 PHY DRIVER
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.25.1

