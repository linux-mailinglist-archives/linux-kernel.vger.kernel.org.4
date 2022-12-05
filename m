Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7246423DD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiLEHxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiLEHxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:53:50 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11610FDF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 23:53:47 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221205075344epoutp021a40f95b603fdd68de6b8df4370fbcb7~t1nK18SbB1191411914epoutp02K
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:53:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221205075344epoutp021a40f95b603fdd68de6b8df4370fbcb7~t1nK18SbB1191411914epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670226825;
        bh=CT84Z1FUooBtVGNP+3a7LwN8q80cGWTSXz6TlavkWsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oUwHdtZZbvjnLgNg3/81ri52eobOLb3RMmU8hs3mh2KfiHyeBd8GBo1K+7O5fdn21
         pmu82/THvUrzvlRYkr0gh0qDSJeNaXCG4BDZaMXh/ZjxKrx/eApMgpV6rDNoKr4g42
         zemTq8XYgQgLAGpwk3TNCzfw8RvvnCbkyoOx3C1c=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20221205075344epcas2p2039ab711bff7e75ba62f54a55c15dcb9~t1nKIz4dW1970119701epcas2p2H;
        Mon,  5 Dec 2022 07:53:44 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NQbQb6MKrz4x9Pt; Mon,  5 Dec
        2022 07:53:43 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.05.18762.783AD836; Mon,  5 Dec 2022 16:53:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20221205075343epcas2p1f133223da3d9c01668e8176e58bd51a4~t1nJTGUPC1923719237epcas2p1n;
        Mon,  5 Dec 2022 07:53:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221205075343epsmtrp1c93c6b8ff431e2d8e9a09f7d69af502e~t1nJSCSXP2442324423epsmtrp1T;
        Mon,  5 Dec 2022 07:53:43 +0000 (GMT)
X-AuditID: b6c32a48-8a7fa7000001494a-6d-638da387b0df
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.69.18644.783AD836; Mon,  5 Dec 2022 16:53:43 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221205075343epsmtip23505438685f24220328bdc3e97ac23e6~t1nJBPivF3190031900epsmtip2T;
        Mon,  5 Dec 2022 07:53:43 +0000 (GMT)
Date:   Mon, 5 Dec 2022 16:48:04 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Artur Bujdoso <artur.bujdoso@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
Subject: Re: [RFC PATCH v1 1/2] dt-bindings: usb: samsung,exynos-xhci:
 support Samsung Exynos xHCI Controller
Message-ID: <20221205074804.GF54922@ubuntu>
MIME-Version: 1.0
In-Reply-To: <380178d3-7248-4200-d9db-2fd8584eb386@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd3pvbwsZ8/IoO9SFQdnIwIEtrx4nD7MRvcy5YPaQQAh25a7F
        lrZpi5ONCcHwEHy0jAypuMlq6GxcwMKQhzB5zFcmyyggzymPISJkKGRjMHEtFxb/+5zf4/s7
        v9/vHC7m8ZjgczNUelqrkigFhCve2BUkDikyn5QKv7aI0P1vGgn0tOw6Bw0ZLgFUVrTERt92
        97DRbUs1Cx0z1xKoaigMjY0v4+jUzDiG2h79yEHl/1pYyDY5wEb2lioCnfm1nYW+qynA0DFb
        ORsVtHVzUMnYoEOug4dWGmbBLh61ulIGqGbTGIcyX33IomzW4wQ1OnCVoH46d4lD1V/IpU41
        WAFV29CPU4s230TXZEW0nJak01o/WiVVp2eoZDGCvR+kvZMWGSUUhYh2ILHATyXJpGME8e8l
        huzOUDpaFPgdliizHKZEiU4n2B4brVVn6Wk/uVqnjxHQmnSlRqwJ1UkydVkqWaiK1r8lEgrD
        Ih2BBxXyma8mcc1t7yNLhQNYHjB6lgAXLiQj4OBaJ3CyB9kE4LkHBxh+AmBLb04JcHXwIoBr
        pUb2ZsKtOQPOOFoALKiys5jDFICWebsjisvFydfgldotzgSCDIa/L9/EnOxFImiuq2Y74zGy
        nQMvnmzlOB2epBr+dvc04WQ3chv8xzqKM+wOb1VOrbMLGQsrKltZTn2eQ3+2I9epA8llLqyp
        /hMwt4uHfcYFFsOecPZGA4dhPnx4unCDFfDuX6U4w0fg922bHA5N00XrOhgphwtd/eu9QDIA
        dg/jjPklWNz1lMOY3WBxoQeTGQAr7IaN+fjAjkc9GMMUNBgmN8YzzoJ101a2Abxqeq4z03PV
        GH4Tnm99QpgcJTByK7SscRkMgrUt288DthV40xpdpozWhWki/l+1VJ1pA+tvP5hqAmfnF0I7
        AYsLOgHkYgIvt0DzCamHW7ok+3Naq07TZilpXSeIdKzJiPF5UrXj86j0aaKIHcKIqCiROCxS
        KBa87Ha2vFjqQcokelpB0xpau5nH4rrw81ipb784Qa1askPykqPjK+tv+JcLV/r2PjuQnYBX
        /XDvy6NBC121scspN/ec6et9XXjoGkq+7zLy4R3LlqTkPPmFktbSOzt79YHZJh6KKQuYCHXf
        5t00EDacz50vyD26SPj83bOvbG4wLtO1UZE0tydnf/MrX4zITzR/dvB9/62lSQ/aEtgv2Fan
        WlE9si6PYc/22VN4oglz+FDOu0aNVZ7/2D01cFqdqvCpi7NbihP2u5OJn/LD8Z4rb1C7oqoD
        P+mRDf4Sl9Rbk+c/E/KR2b2pfebQ5ZKMpXt+w9f+iKuw+xwenSfkkRddf5YaZde9jidfLvLu
        F5t3e6WM8D/2FfjmB+4U4Dq5RBSMaXWS/wD7VmqnhAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ra0hTYRj2O7edraTjrT61lEbXheuC5VeZlaAcjECFIgqppYctcnPtaGVB
        BVnD1dIs0FmWutJahbm05jXaRFuQdjMXTHNaoTNJycK0JKdG/nt4ri+8NO5rIYLoQ6p0TqOS
        pYopEfHYJg4N0xr1yWtejs9B3TceU+hPXrMAfci9D1CedoREN5taSfSivARDZ40VFLr+YR3q
        dI0S6FKfC0cNA9UCdPV3OYbMve9J9Lb2OoUK2hoxVFp2DkdnzVdJdK6hSYB0nY7JumcBaKzK
        DbYFsONjeYCtKewUsMb6fow1m7Ip1vm+nmKfFt0XsI9unWYvVZkAW1HVTrDfzSHxor2iyBQu
        9dBRTrM66oBIYdK6CLXO//iLN9FngJvRASENmXBo/5pL6ICI9mUsAFprDIJpIRDeLnLMYD/4
        MauJnDb1APijxInpAE0TzBL4pGKex0MxEtg1+hz3YH8GQePDkik/zjQJYNFwD+kR/Jg0+Loj
        h/Jgb2YV/GVyziy7MPjpsnNG8IF2wyfCg/HJVsdE/9QYzgTD8gnaQwuZKJhvqJuiAyZvcD87
        nQt8CmeFC2eFC/+HiwFuAoGcmlfKlfxa9ToVd0zKy5R8hkouTU5TmsHUcyUSC6g3DUmtAKOB
        FUAaF/t7LzNeTPb1TpFlnuA0afs1GakcbwXBNCFe4P1KZ9/vy8hl6dxhjlNzmn8qRguDzmDM
        yjA5ltQWK1e2lRbEJx28shDEJNQk6m1DNqZVWNbRPb+h0VwW9yT/c5SiMuvat1KzXuZFei3u
        Ug1sxIcDT31DYdIyTuF1gIw73iqK2E6J4+7uICCfP1Gn350w1mi7IbndMeRsn8u1dr9MNp+s
        TWoBoeqdZLxtuK1bL1xaD2qfj+gN9ogWe3Rf8Tx3S/qRjOze6Gyfr9bv91Zo+0OUYHRP1uC+
        PW+6fjouVG3teUfxmzf0CRVRu6rXa9tDsTUWqao4vtKCMoO+2BZlFf08L8+pGIvM2dB7h3xn
        aI4JDV++JePYnwcRiQeHwwd/JcSOuF3tmyIyBSHjdYscnJjgFbK1ElzDy/4CKJnvbEsDAAA=
X-CMS-MailID: 20221205075343epcas2p1f133223da3d9c01668e8176e58bd51a4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----O100lSkHJvpeqAZUg6J-pc56spCM8SnYWoYgfiXYPjbcU737=_1861c_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221201021941epcas2p4a536a9eb029a990fcb9f27f2b4668d07
References: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
        <CGME20221201021941epcas2p4a536a9eb029a990fcb9f27f2b4668d07@epcas2p4.samsung.com>
        <1669860811-171746-2-git-send-email-dh10.jung@samsung.com>
        <e140fdfd-4d8b-7214-d264-0503e6fcc498@linaro.org>
        <20221205020634.GA54922@ubuntu>
        <380178d3-7248-4200-d9db-2fd8584eb386@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------O100lSkHJvpeqAZUg6J-pc56spCM8SnYWoYgfiXYPjbcU737=_1861c_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Dec 05, 2022 at 08:31:46AM +0100, Krzysztof Kozlowski wrote:
> On 05/12/2022 03:06, Jung Daehwan wrote:
> > On Thu, Dec 01, 2022 at 09:59:06AM +0100, Krzysztof Kozlowski wrote:
> >> On 01/12/2022 03:13, Daehwan Jung wrote:
> >>> Add the Samsung Exynos xHCI Controller bindings with DT schema format.
> >>>
> >>> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> >>> ---
> >>>  .../bindings/usb/samsung,exynos-xhci.yaml     | 25 +++++++++++++++++++
> >>>  1 file changed, 25 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
> >>> new file mode 100644
> >>> index 000000000000..c5dde53b6491
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
> >>> @@ -0,0 +1,25 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: https://protect2.fireeye.com/v1/url?k=7899b46f-19e45c17-78983f20-74fe485fffb1-728a1b33a5d009dd&q=1&e=bdc50247-e986-43da-a15e-03ac6c3a25e8&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fusb%2Fsamsung%2Cexynos-xhci.yaml%23
> >>> +$schema: https://protect2.fireeye.com/v1/url?k=ea1282f0-8b6f6a88-ea1309bf-74fe485fffb1-536f21757c62f28b&q=1&e=bdc50247-e986-43da-a15e-03ac6c3a25e8&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> >>> +
> >>> +title: Samsung Exynos xHCI
> >>> +
> >>> +maintainers:
> >>> +  - Daehwan Jung <dh10.jung@samsung.com>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: samsung,exynos-xhci
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>
> >> These do not look like complete bindings... What type of device has no
> >> resources at all, just compatible?
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >>
> > 
> > It gets resources from dwc->xhci_resources as you can see
> > dwc3_host_init(usb/dwc3/host.c). I think it doesn't need to get another resource.
> 
> You refer to driver, but we talk about hardware. Not driver. Your
> hardware has no resources, so this does not look like complete binding.
> 
> Best regards,
> Krzysztof
> 
> 

It actually doesn't get new resources but shares resources of dwc3 driver.
You mean it's not complete binding without resources? Is it okay if I
add description about it? If not, could you suggest a good way?

Best regards,
Jung Daehwan

------O100lSkHJvpeqAZUg6J-pc56spCM8SnYWoYgfiXYPjbcU737=_1861c_
Content-Type: text/plain; charset="utf-8"


------O100lSkHJvpeqAZUg6J-pc56spCM8SnYWoYgfiXYPjbcU737=_1861c_--
