Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2E3658B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiL2KOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiL2KMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:12:31 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC6D13F49
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:04:19 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221229100417epoutp02ac97bfd3f983a40159d0bc9684d09ba3~1O3-5xWHc0652506525epoutp02A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:04:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221229100417epoutp02ac97bfd3f983a40159d0bc9684d09ba3~1O3-5xWHc0652506525epoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672308257;
        bh=+7UyEP8u7ZuEOhQRmNW84KzrakctEPHUNlyDedOD7bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nz2MhRezRPV8hdsVDWrbfujBB7kPKag81yJw2oFbahBK9jz7KW9AAUkFEKvhX6M7j
         0gX/q9X999C7r2ocAzAAyTaDbWtZwnzLLbF207LcZfTrVhdCSyn4ynfXx1apPdycuS
         fJWAIjpONmlGADFV0wtjSpT4HBITej4SkfqzHbLc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20221229100416epcas2p4e0c641d59e399d6522489b2359c6d2a2~1O3-R5qUl3162931629epcas2p4d;
        Thu, 29 Dec 2022 10:04:16 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NjPB83Lzlz4x9Py; Thu, 29 Dec
        2022 10:04:16 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.EB.03803.0266DA36; Thu, 29 Dec 2022 19:04:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20221229100416epcas2p3614b693ab922aadbdc76c0387f768de9~1O3_kFpj_2202722027epcas2p3G;
        Thu, 29 Dec 2022 10:04:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221229100416epsmtrp25c50de5f0a0bab34845bdb931ccac126~1O3_jPy0Z1682316823epsmtrp28;
        Thu, 29 Dec 2022 10:04:16 +0000 (GMT)
X-AuditID: b6c32a45-f47ff70000020edb-a2-63ad662021b5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.1F.02211.F166DA36; Thu, 29 Dec 2022 19:04:15 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221229100415epsmtip27cfcd0df77c9a2dd60399d41060203df~1O3_VUet_2159721597epsmtip2e;
        Thu, 29 Dec 2022 10:04:15 +0000 (GMT)
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
Subject: [RFC PATCH v2 2/3] dt-bindings: usb: generic-xhci: add Samsung
 Exynos compatible
Date:   Thu, 29 Dec 2022 18:57:45 +0900
Message-Id: <1672307866-25839-3-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTQlchbW2yweT94hbH2p6wW8w/co7V
        4s6CaUwWp5YvZLJoXryezeLuwx8sFn0vHjJbXN41h81i0bJWZovmTVNYLVr3HmG36Lp7g9Fi
        0kFRi1ULDrA78Hks3vOSyWPTqk42jzvX9rB57J+7ht2jb8sqRo8t+z8zenzeJBfAHpVtk5Ga
        mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0spJCWWJOKVAo
        ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+NpX3HB
        WraKx4+XMzcw9rJ2MXJySAiYSOzd08bUxcjFISSwg1Hi2cV3bBDOJ0aJn/sWQjnfGCVuHjnC
        BtNy7upWdojEXkaJ5u+ToZwfjBLzvs0AGszBwSagJfF9ISNIXESgi0li252vLCAOs8ARJomN
        M04xgowSFoiWOLptKthYFgFViVvb3rGD2LwCrhKLFjYzQayTk7h5rpMZxOYUcJNo3/oDbJCE
        QC+HxNsnDVBvuEgcmNbFDmELS7w6vgXKlpL4/G4v1N3ZEte/dbNA2BUSK/bC2MYSs561M4Jc
        zSygKbF+lz6IKSGgLHHkFlgFswCfRMfhv+wQYV6JjjYhiEZliemXJ0AdIClx8PU5ZgjbQ+L9
        xWmMkDCZyShx9+9xtgmMcrMQFixgZFzFKJZaUJybnlpsVGAIj7Hk/NxNjOAkqeW6g3Hy2w96
        hxiZOBgPMUpwMCuJ8GqcXZ0sxJuSWFmVWpQfX1Sak1p8iNEUGHYTmaVEk/OBaTqvJN7QxNLA
        xMzM0NzI1MBcSZw3aOv8ZCGB9MSS1OzU1ILUIpg+Jg5OqQYm2T3uSfctnn0JuetRNFvvSoOA
        /ZmVMlI3zs41KQnbvOjSAWXnANEfu4NEmXhbnpkdf2BY1ON2lanx5pOu+Eizm/t2xVRKvg9y
        Csuez2u9iyVhVdH2Y/PaKlmuNG+Y0dYQZBV2q3gif6DiFba2hZ+cntc/mH7HyPLYZIOuqv70
        xoD1cyft1Ovo6BLf/i+HdcLBsPmmATesvDIEeKP7Pc0um7ZNOhDGulL+OWsPN2dnidLenYsK
        Mj4KpRW1Ws2MnDjl5/6GQy3xdx/+3JBhfWmLaVhl71b3yZ8sJn/curOPJ5b1/xEbwfWMIucz
        A1pk1ni9vnDVN9Ey+9Ozer5Y77JX9t8Ochx28FSXnfQ9vUyJpTgj0VCLuag4EQADKsYHGwQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSvK582tpkgzd/LS2OtT1ht5h/5Byr
        xZ0F05gsTi1fyGTRvHg9m8Xdhz9YLPpePGS2uLxrDpvFomWtzBbNm6awWrTuPcJu0XX3BqPF
        pIOiFqsWHGB34PNYvOclk8emVZ1sHneu7WHz2D93DbtH35ZVjB5b9n9m9Pi8SS6APYrLJiU1
        J7MstUjfLoEr42lfccFatorHj5czNzD2snYxcnJICJhInLu6lb2LkYtDSGA3o8TeVYuZIRKS
        Ekvn3mCHsIUl7rccYYUo+sYoce7BYqYuRg4ONgEtie8LGUHiIgI9TBILp2xlA3GYBU4xSdw6
        /ooJpFtYIFLi19NVjCA2i4CqxK1t78Cm8gq4Sixa2MwEsUFO4ua5TrDNnAJuEu1bf7CA2EJA
        NRe6/7FNYORbwMiwilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOJy1NHcwbl/1Qe8Q
        IxMH4yFGCQ5mJRFejbOrk4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQ
        WgSTZeLglGpgWvHBeXah+r1mhm1hD8V53h04/OMnyy/jNVncx03nrDwvUh3y7dL2OC3BbyKe
        xWGZj6oCNrC8m7zBTpRDW6E9KJfrp+nezCXbj5gIG9rKPDW+cnBJ5/3J1xL7dy9yUKv56GPz
        VWD5+61T+HNW3ZBVjGULajr0vvLcqkDhkia7Gda9Nu+qfblLpjjohNw4rNQ1YdblbxPitWe8
        2dLObnBp1zHHNWwbzTx/hYnLnan1E/timKdokeb8VvvkAw1R149nK6P0HFKnfPng5a9x8Zrw
        tnCFE3NvJX6YW5l88cJBK8Urc58Gc/nPXfYiRvCTfvedl7aXtbW2rrBb6L74zzdRiavqF/iv
        exssu8vZrXI7SImlOCPRUIu5qDgRAKmdlnXWAgAA
X-CMS-MailID: 20221229100416epcas2p3614b693ab922aadbdc76c0387f768de9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221229100416epcas2p3614b693ab922aadbdc76c0387f768de9
References: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
        <CGME20221229100416epcas2p3614b693ab922aadbdc76c0387f768de9@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for Samsung Exynos SOCs

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 Documentation/devicetree/bindings/usb/generic-xhci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-xhci.yaml b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
index db841589fc33..f54aff477637 100644
--- a/Documentation/devicetree/bindings/usb/generic-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
@@ -29,6 +29,8 @@ properties:
         enum:
           - brcm,xhci-brcm-v2
           - brcm,bcm7445-xhci
+      - description: Samsung Exynos SoCs with xHCI
+        const: samsung,exynos-xhci
       - description: Generic xHCI device
         const: xhci-platform
         deprecated: true
-- 
2.31.1

