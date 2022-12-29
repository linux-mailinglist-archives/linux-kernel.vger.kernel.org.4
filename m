Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C845658B75
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiL2KPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiL2KMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:12:39 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03E113F7A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:04:19 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221229100418epoutp016ac1ebd669a03f0b40fb1f8879f14b32~1O4AaZuGP1357313573epoutp01Y
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:04:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221229100418epoutp016ac1ebd669a03f0b40fb1f8879f14b32~1O4AaZuGP1357313573epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672308258;
        bh=yrMrH+zAEllRQiyZ4imQyuFdt3JAySbiorsThIUkVOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/0QEuXQe2r3g86038BRbd3/qPxkhUBjfqg3yuThldgKwADC5wWc5DfxVGHvrB/eD
         Kn1twQiUMSXHqItFANaAGdiJtPZ30cvCFqEfJjfw2BrlG628YOuk+rgNCnfNbj6squ
         89gWsXauE7W9zx/AMwaJoouX3ibEvryq78MPOmik=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20221229100417epcas2p2b5eb2b3af79011011765ea5ddc2cf7db~1O3-7vx8r1066110661epcas2p2P;
        Thu, 29 Dec 2022 10:04:17 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.100]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NjPB91Js1z4x9Py; Thu, 29 Dec
        2022 10:04:17 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.28.15497.1266DA36; Thu, 29 Dec 2022 19:04:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20221229100416epcas2p18f7600737b8f4149a1d75d2d8db3317a~1O3-LFLOT1797217972epcas2p1J;
        Thu, 29 Dec 2022 10:04:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221229100416epsmtrp1748bb5a2d8b4f1b8a8e088f7428482d6~1O3-KNsJz2828628286epsmtrp1C;
        Thu, 29 Dec 2022 10:04:16 +0000 (GMT)
X-AuditID: b6c32a48-225ff70000023c89-91-63ad6621f569
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.1F.02211.0266DA36; Thu, 29 Dec 2022 19:04:16 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221229100416epsmtip2379f4dc3c814cbc84ac01355a185ef29~1O3_7jeuy2157121571epsmtip2Y;
        Thu, 29 Dec 2022 10:04:16 +0000 (GMT)
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
Subject: [RFC PATCH v2 3/3] dt-bindings: usb: snps,dwc3: add generic-xhci as
 child
Date:   Thu, 29 Dec 2022 18:57:46 +0900
Message-Id: <1672307866-25839-4-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTVFcxbW2ywZ8Z7BbH2p6wW8w/co7V
        4s6CaUwWp5YvZLJoXryezeLuwx8sFn0vHjJbXN41h81i0bJWZovmTVNYLVr3HmG36Lp7g9Fi
        0kFRi1ULDrA78Hks3vOSyWPTqk42jzvX9rB57J+7ht2jb8sqRo8t+z8zenzeJBfAHpVtk5Ga
        mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0spJCWWJOKVAo
        ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+P2hOWM
        Bed4Kr7NXczWwHiWs4uRk0NCwETi1fI5zF2MXBxCAjsYJT5cncAO4XxilPg8+yQLhPONUWLN
        ltVsMC077p1mhUjsZZRY/uElVMsPRomeVw+AWjg42AS0JL4vZASJiwh0MUlsu/MVbBSzwBEm
        iY0zTjGCjBIWCJFoOtXHBGKzCKhKbP+/ihnE5hVwlWhZ1ccOsU5O4ua5TrA4p4CbRPvWH2CD
        JAQ6OSTuHT0OdZOLxJGrM1khbGGJV8e3QDVLSbzsb4OysyWuf+tmgbArJFbshbGNJWY9a2cE
        uZpZQFNi/S59EFNCQFniyC2wCmYBPomOw3/ZIcK8Eh1tQhCNyhLTL0+AWiopcfD1OWYI20Ni
        28OZYF8JCcxklNi+UW0Co9wshPkLGBlXMYqlFhTnpqcWGxWYwGMsOT93EyM4SWp57GCc/faD
        3iFGJg7GQ4wSHMxKIrwaZ1cnC/GmJFZWpRblxxeV5qQWH2I0BQbdRGYp0eR8YJrOK4k3NLE0
        MDEzMzQ3MjUwVxLnDdo6P1lIID2xJDU7NbUgtQimj4mDU6qB6VTQT9PmOosQvidRO7jTd7MJ
        20z++KHl0Jt3zVfkJUROyUyQPbot8wX/lnLOPt3v8yf8dbEJNjpzsitlmlXl9Wc+rEkXA/qe
        hLisdNg4/9KLr8av4/LYZYOt5KRZV6T4a2xpefhvua5ikUicuFMVU/f9+sVLsl2uFFdcZcmZ
        VSVQwFLxSHhty6PWpqXqARWitz9oftC6qnu1s3t9aXLhkS2hB8qkovd4nMtmPhsmdzD95jbW
        tS895h3N+bqw0f7rZK3TzCYly7JXl762vNa7XaaOq0zrX7N5iM8XudOCx0TL5gnevXEw3OeH
        9L2VsXYpbrt3pFqoSmw0unrjXoF3grDNoZc75cRvfblgLJaqxFKckWioxVxUnAgAPtglJhsE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSvK5C2tpkg8dPFC2OtT1ht5h/5Byr
        xZ0F05gsTi1fyGTRvHg9m8Xdhz9YLPpePGS2uLxrDpvFomWtzBbNm6awWrTuPcJu0XX3BqPF
        pIOiFqsWHGB34PNYvOclk8emVZ1sHneu7WHz2D93DbtH35ZVjB5b9n9m9Pi8SS6APYrLJiU1
        J7MstUjfLoEr4/aE5YwF53gqvs1dzNbAeJazi5GTQ0LARGLHvdOsILaQwG5Gib4XWRBxSYml
        c2+wQ9jCEvdbjgDVcAHVfGOUODjrAlsXIwcHm4CWxPeFjCBxEYEeJomFU7aygTjMAqeYJG4d
        f8UE0i0sECTRcacFbBKLgKrE9v+rmEFsXgFXiZZVfVAb5CRunusEi3MKuEm0b/3BAnGRq8SF
        7n9sExj5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECA5nLc0djNtXfdA7xMjE
        wXiIUYKDWUmEV+Ps6mQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbB
        ZJk4OKUamHIzNF6rFnCZbzhY9PK5BItBSOqmvwaWKcc2fN7Y/6L2dfUUx073ZcefPLcxvMK7
        pYOfU36h/y4m59MObKr6zBOck90unDCsPyGoGi/F2lnq4um+PHTLaa6zZZcdmlbLR+hNO7Yu
        6lr0+n8nVy/8ciznT5hDoHOEz3GRDT133olmZWufbju2kfOytMoktlNRdy8cYLj06PZLuVVL
        3+3R+uQ2y8diY98Wm6S7IVt/8639l6n6vlLW7rq1YoBkX3SDZrNO6Kr93cs92lg+XhcPiJFc
        f3ny2UcJgg67JXwqD32bGN6511XQS7/pnLbQ3l0zOBOyded1+T2cFrymxWh/OefMcwLzzG/t
        UJDpMJs6Q4mlOCPRUIu5qDgRAAJnJWXWAgAA
X-CMS-MailID: 20221229100416epcas2p18f7600737b8f4149a1d75d2d8db3317a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221229100416epcas2p18f7600737b8f4149a1d75d2d8db3317a
References: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
        <CGME20221229100416epcas2p18f7600737b8f4149a1d75d2d8db3317a@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, dwc3 invokes just xhci platform driver(generic-xhci) without
DT schema even though xhci works as child of dwc3. It makes sense to add
xhci as child of dwc3 with DT schema. It also supports to use another
compatible in xhci platform driver.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 .../devicetree/bindings/usb/snps,dwc3.yaml    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 6d78048c4613..83ed7c526dba 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -360,8 +360,22 @@ properties:
     description:
       Enable USB remote wakeup.
 
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+  ranges: true
+
 unevaluatedProperties: false
 
+# Required child node:
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    $ref: generic-xhci.yaml#
+    description: Required child node
+
 required:
   - compatible
   - reg
@@ -388,4 +402,19 @@ examples:
       snps,dis_u2_susphy_quirk;
       snps,dis_enblslpm_quirk;
     };
+  - |
+    usb@4a200000 {
+      compatible = "snps,dwc3";
+      reg = <0x4a200000 0xcfff>;
+      interrupts = <0 92 4>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+
+      xhci: usb@4a200000 {
+        compatible = "generic-xhci";
+        reg = <0x4a200000 0x7fff>;
+        interrupts = <0 92 4>;
+      };
+    };
 ...
-- 
2.31.1

