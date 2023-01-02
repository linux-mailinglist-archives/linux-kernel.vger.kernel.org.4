Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C14265AD3E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 06:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjABFhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 00:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjABFg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 00:36:59 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5860F1156
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 21:36:55 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230102053652epoutp048d33202c10354888d9e7b9dc367592e5~2Zzp211hD1782317823epoutp04b
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 05:36:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230102053652epoutp048d33202c10354888d9e7b9dc367592e5~2Zzp211hD1782317823epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672637812;
        bh=2zdqGEKgFKRQC4ThirZiGZBm1TO9HpEh7hl1O9l+xc0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IKF6OuFGZjpNoFqjhz8FD7//xuG6RZ2KGvlWsObzjQibdYo3OoWLDexLt6/d/OUH7
         YQSTJ1SCPzfTXhneSjWbBcgR0gnfTxPdsQAlBqlNtAnzO/nSQAVmXfkxdz3rn6+ClD
         eYw2wOMurhFmdlT0vkSWuzXuQ18oczLswnNd1Q+U=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230102053651epcas2p400bd9d0e8d06e3cee3f85fd5ce62c500~2ZzpLumjz1090410904epcas2p4g;
        Mon,  2 Jan 2023 05:36:51 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Nll3l2XTtz4x9Pv; Mon,  2 Jan
        2023 05:36:51 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.1B.03803.37D62B36; Mon,  2 Jan 2023 14:36:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230102053650epcas2p4e261cc28b63a0002a39af7098bc32677~2ZzoJpoFf1088710887epcas2p4_;
        Mon,  2 Jan 2023 05:36:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230102053650epsmtrp114a7f3634cc44ab7a33c0bf7d2697d4e~2ZzoF4qrQ2758227582epsmtrp1u;
        Mon,  2 Jan 2023 05:36:50 +0000 (GMT)
X-AuditID: b6c32a45-f47ff70000020edb-f3-63b26d73be22
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.EB.10542.27D62B36; Mon,  2 Jan 2023 14:36:50 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230102053650epsmtip28c9e1bdff7774081c4574524a4946b1e~2Zzn4pTmj2504225042epsmtip2J;
        Mon,  2 Jan 2023 05:36:50 +0000 (GMT)
Date:   Mon, 2 Jan 2023 14:30:37 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
Subject: Re: [RFC PATCH v2 2/3] dt-bindings: usb: generic-xhci: add Samsung
 Exynos compatible
Message-ID: <20230102053037.GA74470@ubuntu>
MIME-Version: 1.0
In-Reply-To: <d84f46f5-9975-cde2-0b56-b51990e27150@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmqW5x7qZkg3td7BbH2p6wW8w/co7V
        4tTyhUwWzYvXs1ncffiDxaLvxUNmi72vt7JbXN41h81i0bJWZovmTVNYLVr3HmG36Lp7g9Fi
        0kFRi1ULDrA78Hks3vOSyWPTqk42jzvX9rB57J+7ht2jb8sqRo8t+z8zenzeJBfAHpVtk5Ga
        mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0spJCWWJOKVAo
        ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+P6qQlM
        BbcEKzZMX8jWwNjB18XIySEhYCLR3XKcDcQWEtjBKPFmm3AXIxeQ/YlRYvWv2SwQzmdGiedr
        f7HDdPzf8pkZIrGLUWLG5weMEO1PGCWuzNIHsVkEVCQO/TwCNpZNQEvi3o8TzCC2iICFxOIN
        C1lBmpkFVrFIbH/1kAUkISwQL7H881GwBl4BbYkPm/axQtiCEidnPgGr4RSwk3jdvA+ohoND
        FGjBq4P1IHMkBHZwSDz80ckGcZ2LxJ2GaawQtrDEq+NboK6WknjZ3wZlZ0tc/9bNAmFXSKzY
        C2MbS8x61g72DLNAhkTf4rPMILskBJQljtxigQjzSXQc/ssOEeaV6GgTguhUlph+eQLUVkmJ
        g6/PMUPYHhLvL05jhIRVJ5PEjtvfWSYwys9C8tksJNsgbB2JBbs/sc0CWsEsIC2x/B8HhKkp
        sX6X/gJG1lWMYqkFxbnpqcVGBYbwuE7Oz93ECE7MWq47GCe//aB3iJGJg/EQowQHs5II7+XP
        65KFeFMSK6tSi/Lji0pzUosPMZoC42kis5Rocj4wN+SVxBuaWBqYmJkZmhuZGpgrifMGbZ2f
        LCSQnliSmp2aWpBaBNPHxMEp1cA0M+XfZ7ebC6b/mDgnJvLoEUctCRljx+U10zse7ZGcdW/X
        JmeGvENvTKJyDAM1P31canpL6tIlxajCbwyVGSvN1we9WV4uV6NzzTHszCT+7p2ZN15qbGX2
        WHIt8YAxi8a+5v512tnO1taTZi+beHzdzpk31wuYhiwIYyxQLXx+rue+wJkQ7m5Nv9OW9qvt
        FWU+PfXyVPX6vXVGwyd1leIP5488+zNbft+MxXMEn7zdn9eYNtn++vFnhyYf536bd1vy1MwW
        84S6TL0H1ZsuPDROVFw8yUbR8+zsFeznZi1dHNLHLF03tcnv6o+PT6vfPff7yL9QMm96Ypmk
        bpBIzAbev7JvTKs4lr3KvSg69aXtHSWW4oxEQy3mouJEAI3T2UFVBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXrcod1Oywa39khbH2p6wW8w/co7V
        4tTyhUwWzYvXs1ncffiDxaLvxUNmi72vt7JbXN41h81i0bJWZovmTVNYLVr3HmG36Lp7g9Fi
        0kFRi1ULDrA78Hks3vOSyWPTqk42jzvX9rB57J+7ht2jb8sqRo8t+z8zenzeJBfAHsVlk5Ka
        k1mWWqRvl8CVceTtLraCWfwVWz5vZW9gfMjdxcjJISFgIvF/y2dmEFtIYAejxJbDARBxSYml
        c2+wQ9jCEvdbjrB2MXIB1TxilOjtfMoGkmARUJE49PMImM0moCVx78cJsEEiAhYSizcsZAWx
        mQXWsUhsnRwPYgsLxEss/3wUrJ5XQFviw6Z9UEM7mSQmTv3FDJEQlDg58wkLRLOWxI1/L5m6
        GDmAbGmJ5f84QMKcAnYSr5v3sYGERYFueHWwfgKj4CwkzbOQNM9CaF7AyLyKUTK1oDg3PbfY
        sMAoL7Vcrzgxt7g0L10vOT93EyM4srS0djDuWfVB7xAjEwfjIUYJDmYlEd7Ln9clC/GmJFZW
        pRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cCk/XTmlXNLFSZZz+2Q
        nllgruxb/HL6jJTtqsJhQTeb5dbsf8cgtDJrrsmD56IsRlsiKzn6M/6L6nCtiru+aLI9m3ip
        wYRkNTFe9cw5HAaf3qr6CKySjf1643JfRJ5v4XKVpzHea2+nXnRuVZWOfqtz3H91/aHSBi+R
        9Y4Vk5jfaCcan/fMns2w9EPQD6kdz7Lzee/PCZq42vizxrzv7oynXbd/Mfa0y5pQL2F9Uf7g
        4vehbDsbQ6KPcZo0dHExHky5PjnwzOy2nIk7ry2W/FK0y9hMvE6wVMfn8B23V3ZhqfssUhd5
        pWpxr9l7af9nCY3Ih/9jynKuOr20ron2tDVe/VtvyuubtucrFP1bk5RYijMSDbWYi4oTAULF
        roYbAwAA
X-CMS-MailID: 20230102053650epcas2p4e261cc28b63a0002a39af7098bc32677
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="-----MZMhAa2FDKenVcG4rwH3wgKue-rxPmwBkiUVsWz4GNry_6C=_e4678_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221229100416epcas2p3614b693ab922aadbdc76c0387f768de9
References: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
        <CGME20221229100416epcas2p3614b693ab922aadbdc76c0387f768de9@epcas2p3.samsung.com>
        <1672307866-25839-3-git-send-email-dh10.jung@samsung.com>
        <d84f46f5-9975-cde2-0b56-b51990e27150@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-------MZMhAa2FDKenVcG4rwH3wgKue-rxPmwBkiUVsWz4GNry_6C=_e4678_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Dec 29, 2022 at 11:19:09AM +0100, Krzysztof Kozlowski wrote:
> On 29/12/2022 10:57, Daehwan Jung wrote:
> > Add compatible for Samsung Exynos SOCs
> 
> Missing full stop. Please explain here in details the hardware.
> Otherwise it looks it is not for any hardware and patch should be dropped.
> 

I got it. This patch may be for new feature of generic xhci not for exynos.
I will add hardware description on next submission.

> Also, missing DTS. I am going to keep NAK-ing this till you provide the
> user.
> 
> NAK.
> 

I've added a example and checked bindings following below guides.

https://docs.kernel.org/devicetree/bindings/submitting-patches.html
https://docs.kernel.org/devicetree/bindings/writing-schema.html

I have no idea that I have to also submit DTS.
I will submit it on next submission.

> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  Documentation/devicetree/bindings/usb/generic-xhci.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/generic-xhci.yaml b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
> > index db841589fc33..f54aff477637 100644
> > --- a/Documentation/devicetree/bindings/usb/generic-xhci.yaml
> > +++ b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
> > @@ -29,6 +29,8 @@ properties:
> >          enum:
> >            - brcm,xhci-brcm-v2
> >            - brcm,bcm7445-xhci
> > +      - description: Samsung Exynos SoCs with xHCI
> > +        const: samsung,exynos-xhci
> 
> Missing fallback.

Modifying it like below is OK?

decription: Samsung Exynos SoCs with xHCI
        items:
            - const: samsung,exynos-xhci
            - const: generic-xhci

Best Regards,
Jung Daehwan

> 
> >        - description: Generic xHCI device>          const: xhci-platform
> >          deprecated: true
> 
> Best regards,
> Krzysztof
> 
> 

-------MZMhAa2FDKenVcG4rwH3wgKue-rxPmwBkiUVsWz4GNry_6C=_e4678_
Content-Type: text/plain; charset="utf-8"


-------MZMhAa2FDKenVcG4rwH3wgKue-rxPmwBkiUVsWz4GNry_6C=_e4678_--
