Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E346564216A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 03:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiLECMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 21:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiLECMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 21:12:40 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CA4317
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 18:12:36 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221205021233epoutp0142b0e0df9439efae6f39244f783d5e55~tw9Q2VMUc1697816978epoutp01R
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:12:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221205021233epoutp0142b0e0df9439efae6f39244f783d5e55~tw9Q2VMUc1697816978epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670206353;
        bh=8S4V1LR3sOVIdBHGRZ5RpKByLtMllKFInzZ20UxvDug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=biCJ9TYvCoIlAxgeOeIceCjTO5Xi5JNF3tvu5wJoHOo46Yj6hNomOM8r9DIFx6RFm
         Kst2s7Z2fhpUk+M5tUQMnlr69TdLNAlz00PKIeBTGogOhGoPoL6AAgEMWG4pyNYVoV
         ND3zI78c72MwjSd90OMuUlxvsrb9VtmvocqvuDnw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20221205021232epcas2p1e8f3b87d5afb1366610c33e5b02c1a24~tw9QVwXEG0979109791epcas2p1L;
        Mon,  5 Dec 2022 02:12:32 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.70]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NQRrw1Tllz4x9Pr; Mon,  5 Dec
        2022 02:12:32 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.77.12278.0935D836; Mon,  5 Dec 2022 11:12:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20221205021231epcas2p2a6634eec58bd602d537583cc3b74ca05~tw9PmSGc_0645306453epcas2p2y;
        Mon,  5 Dec 2022 02:12:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221205021231epsmtrp1fb88dd14f06a1e63c7d63c2de80b5f12~tw9PkiPMa1629016290epsmtrp1D;
        Mon,  5 Dec 2022 02:12:31 +0000 (GMT)
X-AuditID: b6c32a46-ad1fd70000012ff6-6c-638d539004c7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.B3.18644.F835D836; Mon,  5 Dec 2022 11:12:31 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221205021231epsmtip292d497fdf6ad1cbbfc29312fc33fadda~tw9PWs5lo2231722317epsmtip2f;
        Mon,  5 Dec 2022 02:12:31 +0000 (GMT)
Date:   Mon, 5 Dec 2022 11:06:50 +0900
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
Message-ID: <20221205020634.GA54922@ubuntu>
MIME-Version: 1.0
In-Reply-To: <e140fdfd-4d8b-7214-d264-0503e6fcc498@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc3rb21ti3aWKnuGirDg33m2FcjBiiBJzl5FAwrIxsgWbctci
        0HZtQV22QCQg1AFtwyKUMkGUd1JTK0MUNh7KpqFsvASUBRRQeUQBZ/DVrOXC4n+f8zu/7+97
        fud3DoEJVnFfIk2lp7UqWYYQ92K39gSgEGNisVxUUUOgqV9acfTWfIuLxo0tAJnPPOeg871O
        DrpdX8NCebU2HFnHJWhyeo2NSh5PY6hj4SoXlb2pZyH7w1EOGmq34qh8oJOFLtTlYyjPXsZB
        +R29XGSYHHOX6/JBrxzzIMaHev3KDKhrlkkuVXvjCYuyNxXh1P3RGzj1W1ULl7pyMYcqcTQB
        yuYYYVOr9t0JXsnpB5W0LJXW+tEquTo1TaWIFn6WmHIkJUIqEoeIo1Ck0E8ly6SjhbFxCSFH
        0zLcLQr9smUZWe5QgkynE4YdOqhVZ+lpP6Vap48W0prUDE2kJlQny9RlqRShKlp/QCwSSSLc
        icfSlX/ZF4FmwvtkQWUBOxdY3jMAHgHJcLg63QUMwIsQkG0ALg+8xJnFCoDj/S62J0tArgK4
        UJS9qXDNXOYySe0A1k+Ub8hnAKy7b11XsMm9cHDEyvEwTgbCf9b+wDy8nUSw9nINxyPAyE4u
        bCy+zvVsbCPV8O+7pbiH+WQQLH/WBxj2hn9WzKwX5ZGH4NMX424xQfi4Dea7cjx1IJnHgy2G
        OS5zvFh4c2qJw/A2ON/n2Ij7wielBRucDu++OMtm+CRs6Njk/dAyd2bdFyOV0HB1GvN4QdIf
        9k6wmfBWWNjzlsuE+bCwQMAo/eG5IeOG6/uwa8GJMUxBo/Ehi7mfsyy4NOzCjWCP5Z3OLO+4
        MRwMq6+v4Ba3BUbugvUugsEAaGsPqwacJrCD1ugyFbROopH8P2y5OtMO1l9/4NE2ULb0LLQb
        sAjQDSCBCbfz99X+JBfwU2Wnvqe16hRtVgat6wYR7jmZMF8fudr9fVT6FHF4lChcKhVHSiJE
        kcKd/MqyQrmAVMj0dDpNa2jtpo5F8HxzWYHScw+OX+yr+pCancmWu775QGr6ePm88/DOL6jH
        nZdMs9WW6oW1r011IUXfTo2UqL3nYpXD+Yotzafbuz+Z7RmtkkQ1OwdO/WBdXLXZGk4EmO/E
        FZTfdqpKW2xrFGZJ5JuH5/pzeDenWpKCfbVhrDT/PZbvMrP39nxZFXTtx0fk6PAjU0Xwifh4
        7a43Cmflp/tHupJOPw/2OdxsmGg8UHpL9JLbzOt/kPK59aOx5IUwZdmvca/vXRlIw1nHjvf1
        xS/mDkLtV0mhQQ1bkuVh3UNHLPi4PMD1s6NzubFxbMUU7pgbBBHme8E5rft+L/5XmuAMjLlj
        rNgtJrbGKGaftu0oFrJ1Spk4ENPqZP8B/Dk0d4YEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSvG5/cG+ywdRZKhYP5m1js/g76Ri7
        xc0JaxgtJrV/YbWYf+Qcq8Wp5QuZLJoXr2ezmHPTyOLuwx8sFn0vHjJb7H29ld1iyp/lTBab
        Hl9jtbi8aw6bxYzz+5gsFi1rZbZo3jSF1aJ17xF2i667N4DGHRS1+LXlFaODqMfvX5MYPXbO
        usvusXjPSyaPTas62TzuXNvD5rF/7hp2j81L6j36tqxi9Fi/5SqLx+dNcgFcUVw2Kak5mWWp
        Rfp2CVwZP4/2sBXM4q948ncaewPjZ54uRk4OCQETiX9PNrB3MXJxCAnsYJRo2jiHESIhKbF0
        7g12CFtY4n7LEVaIokeMEgcnPWIDSbAIqEhcujqHFcRmE9CSuPfjBDOILSJgIbF4w0KwBmaB
        I+wScz8+AisSFsiXuHi9H6yZV0BbYsaH44wQU7uZJM60HoBKCEqcnPmEBcRmBpp6499Lpi5G
        DiBbWmL5Pw6QMKeAncT7bzdZQcKiQEe8Olg/gVFwFpLmWUiaZyE0L2BkXsUomVpQnJueW2xY
        YJSXWq5XnJhbXJqXrpecn7uJERy9Wlo7GPes+qB3iJGJg/EQowQHs5IIr9rinmQh3pTEyqrU
        ovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamJIdGYs0TbeH7BFem9Qz
        I7qe1Zp5z/yZhw+9OHY/449+q1Xckzn3Vj4tOvzoRRh7o13wntPxd59nps1Wu9O80bD71ROH
        4gsP0hYduxHiMV1n32PRyPU77SUfKiVEhzmErepclJIQs3X9Iw33TXWRRQZttwXm1rWKbTtq
        1GSaezp9B3vHJO3VMlfzfoSamXbObhd7xhSSvkrGtrCutD9cbUpaUVB9Z8riDSqt5b/TV9xZ
        /vu28myjqQuD/h0OU9w5R3rDETGrRr6O87pm/Zs252m7r12w8kzRTYGzPRWSVprvVt5bGzDN
        OkqfZQXz5Of3jTqsJyupzgj9W6q4z4ZJ23yG2zKzPafLvDUvbHj/W4mlOCPRUIu5qDgRAFVg
        twdNAwAA
X-CMS-MailID: 20221205021231epcas2p2a6634eec58bd602d537583cc3b74ca05
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="-----MZMhAa2FDKenVcG4rwH3wgKue-rxPmwBkiUVsWz4GNry_6C=_1519f_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221201021941epcas2p4a536a9eb029a990fcb9f27f2b4668d07
References: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
        <CGME20221201021941epcas2p4a536a9eb029a990fcb9f27f2b4668d07@epcas2p4.samsung.com>
        <1669860811-171746-2-git-send-email-dh10.jung@samsung.com>
        <e140fdfd-4d8b-7214-d264-0503e6fcc498@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-------MZMhAa2FDKenVcG4rwH3wgKue-rxPmwBkiUVsWz4GNry_6C=_1519f_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Dec 01, 2022 at 09:59:06AM +0100, Krzysztof Kozlowski wrote:
> On 01/12/2022 03:13, Daehwan Jung wrote:
> > Add the Samsung Exynos xHCI Controller bindings with DT schema format.
> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  .../bindings/usb/samsung,exynos-xhci.yaml     | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
> > new file mode 100644
> > index 000000000000..c5dde53b6491
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
> > @@ -0,0 +1,25 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: https://protect2.fireeye.com/v1/url?k=7899b46f-19e45c17-78983f20-74fe485fffb1-728a1b33a5d009dd&q=1&e=bdc50247-e986-43da-a15e-03ac6c3a25e8&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fusb%2Fsamsung%2Cexynos-xhci.yaml%23
> > +$schema: https://protect2.fireeye.com/v1/url?k=ea1282f0-8b6f6a88-ea1309bf-74fe485fffb1-536f21757c62f28b&q=1&e=bdc50247-e986-43da-a15e-03ac6c3a25e8&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> > +
> > +title: Samsung Exynos xHCI
> > +
> > +maintainers:
> > +  - Daehwan Jung <dh10.jung@samsung.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: samsung,exynos-xhci
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> 
> These do not look like complete bindings... What type of device has no
> resources at all, just compatible?
> 
> Best regards,
> Krzysztof
> 
>

It gets resources from dwc->xhci_resources as you can see
dwc3_host_init(usb/dwc3/host.c). I think it doesn't need to get another resource.

Best Regards,
Jung Daehwan

-------MZMhAa2FDKenVcG4rwH3wgKue-rxPmwBkiUVsWz4GNry_6C=_1519f_
Content-Type: text/plain; charset="utf-8"


-------MZMhAa2FDKenVcG4rwH3wgKue-rxPmwBkiUVsWz4GNry_6C=_1519f_--
