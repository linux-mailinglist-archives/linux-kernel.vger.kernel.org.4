Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AF165AD51
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 06:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjABFvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 00:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjABFvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 00:51:36 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374351FB
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 21:51:33 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230102055130epoutp01980b3d9e533df64e7c9a8c8914cae2eb~2aAcA1qxz0801808018epoutp01W
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 05:51:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230102055130epoutp01980b3d9e533df64e7c9a8c8914cae2eb~2aAcA1qxz0801808018epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672638690;
        bh=BMMDvKaXow6XQx0xLyroErL+Z2f6ROn3AyW0pu+OnGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QrOcbOvhw8pVc5yMftSf6JiN4Tzo653YsKEYJ857zp08aTzFY8raGQ3ZMz+djEc6/
         DjdFFPT7tSLSU+PQ3QZvzMd98+OwJdFIdY5WfpecOZwvROJ1UFnRFZSZUGK2OBhG1t
         4XmZDUcUAsuLvvjvQV8fVEZ02BeGFptUAsdmqehs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230102055129epcas2p332e505345029cd511e53407530208ca1~2aAatrdFl2478524785epcas2p3e;
        Mon,  2 Jan 2023 05:51:29 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NllNd13RJz4x9Q9; Mon,  2 Jan
        2023 05:51:29 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.B4.61831.0E072B36; Mon,  2 Jan 2023 14:51:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230102055128epcas2p3b07590114310fc6f40d4955bf953dfec~2aAZXCBYU3264832648epcas2p3S;
        Mon,  2 Jan 2023 05:51:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230102055128epsmtrp17e33fe8817bbfe730488b30b7285fe80~2aAZWH_QA0349603496epsmtrp1a;
        Mon,  2 Jan 2023 05:51:28 +0000 (GMT)
X-AuditID: b6c32a47-619ff7000000f187-79-63b270e05c23
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.AD.10542.FD072B36; Mon,  2 Jan 2023 14:51:27 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230102055127epsmtip1f808733f10ce4b7aca80b853fd9477ef~2aAZHNdjo2947229472epsmtip1h;
        Mon,  2 Jan 2023 05:51:27 +0000 (GMT)
Date:   Mon, 2 Jan 2023 14:45:17 +0900
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
Subject: Re: [RFC PATCH v2 3/3] dt-bindings: usb: snps,dwc3: add
 generic-xhci as child
Message-ID: <20230102054517.GB74470@ubuntu>
MIME-Version: 1.0
In-Reply-To: <f9b59733-61b1-67d8-01fa-fb3d3d7fbe0e@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmue7Dgk3JBse8LI61PWG3mH/kHKvF
        qeULmSyaF69ns7j78AeLRd+Lh8wWe19vZbe4vGsOm8WiZa3MFs2bprBatO49wm7RdfcGo8Wk
        g6IWqxYcYHfg81i85yWTx6ZVnWwed67tYfPYP3cNu0ffllWMHlv2f2b0+LxJLoA9KtsmIzUx
        JbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hiJYWyxJxSoFBA
        YnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xuEPG5kK
        XotXzD40ga2BcapQFyMnh4SAicSrT48ZQWwhgR2MEq9/mnQxcgHZnxglnp8/wQLhfGaU6Dp/
        ix2m4/WcL+wQiV2MEm9/3mKCcJ4wSkw8e54NpIpFQEWi5exXZhCbTUBL4t6PE2C2iICFxOIN
        C1lBGpgFVrFIbH/1kAUkISwQIfGmYzOYzSugLXH1ykomCFtQ4uTMJ0BxDg5OATuJXQt9QUxR
        oPmvDtaDjJEQ2MEhcWFzG9R1LhI3r29kgbCFJV4d3wIVl5J42Q9Tky1x/Vs3VE2FxIq9MLax
        xKxn7eCwYBbIkOib/pIJZJeEgLLEkVssEGE+iY7Df9khwrwSHW3QUFSWmH55AiuELSlx8PU5
        ZgjbQ2Lbw5nQ4Olkktje9YNlAqP8LCSPzUKyDcLWkViw+xPbLKAVzALSEsv/cUCYmhLrd+kv
        YGRdxSiWWlCcm55abFRgDI/r5PzcTYzgtKzlvoNxxtsPeocYmTgYDzFKcDArifBe/rwuWYg3
        JbGyKrUoP76oNCe1+BCjKTCaJjJLiSbnAzNDXkm8oYmlgYmZmaG5kamBuZI4b9DW+clCAumJ
        JanZqakFqUUwfUwcnFINTIayGqdrnWNqdX/X2/Ap8K3798KXjSf76ob/RXdTfjxoEftVGvLH
        a939hQF3629p3WH/8tWkiKeS2Wqm2t3f7FETJHRfpr5cdDlWsXBxZGXL4/vMV7Q4fiw/0TBZ
        1GLOwY+lKhdn6azsn7htilKG9c5M+RlVeuWqS9ufMN+xNKibtqC+TKzzj6LNPTPpNK1dYSq9
        E6xmbhIqqVD+dmDbzGL2VZNPZe+efL3ZlLfvwv705HU5EmIPpq1b2dZ5xAIYuXfsdj6JZV+o
        UCpsbNflrXNt17/XyupBTPs8Vul2zA12913i6s+6rnha0p+zeeuC9J5E1xXybnJpXnCTdV+n
        weMI8boJ3QruHEYLfyorsRRnJBpqMRcVJwIAAln+aFQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJTvd+waZkg00nzS2OtT1ht5h/5Byr
        xanlC5ksmhevZ7O4+/AHi0Xfi4fMFntfb2W3uLxrDpvFomWtzBbNm6awWrTuPcJu0XX3BqPF
        pIOiFqsWHGB34PNYvOclk8emVZ1sHneu7WHz2D93DbtH35ZVjB5b9n9m9Pi8SS6APYrLJiU1
        J7MstUjfLoEr48/SeWwFq0UrHv/9xtrA+I6/i5GTQ0LAROL1nC/sXYxcHEICOxglln6dzwyR
        kJRYOvcGO4QtLHG/5QgrRNEjRon5y+6zgiRYBFQkWs5+BWtgE9CSuPfjBJgtImAhsXjDQrAa
        ZoF1LBJbJ8eD2MICERJ7DnYzgdi8AtoSV6+sZIIY2skk8XDTSaiEoMTJmU9YIJq1JG78ewkU
        5wCypSWW/+MAMTkF7CR2LfQFMUWBTnh1sH4Co+AsJL2zkPTOQuhdwMi8ilEytaA4Nz232LDA
        KC+1XK84Mbe4NC9dLzk/dxMjOLK0tHYw7ln1Qe8QIxMH4yFGCQ5mJRHey5/XJQvxpiRWVqUW
        5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAFK7Q0jTpzK8rcV8u6umF
        bPmUtJHr+owU33+LFM8uzlIw103hSv6y+ml5pbocT3yk9eOMtHMeOrZm9h+ivwbf5fN4v0OO
        xevs1ijx6IlbXXz23Y+MUWaatvchm8W2Xc26oRq3PmgFMO9xfh0r5sF7w2Ve9H6uTYc6T967
        cfew6AyTG5oJ8168jald+GeR6avUvxc2zJtf3ChYfPhcnP8Gdeabc9fdWqc/d9s99/tWXy9s
        FJRV2OO/LnWe2ZV0Y7sp7oduMBalT3HfmTMjeWeuoUxE/85/d6dsvqzPV3ij2e9qwamAL9ay
        Z7QyVuUd91Jk/3F0T6L1ZkNeqaTfvHNCLsqrKW65OVPj+emkqDRzfiWW4oxEQy3mouJEAA8Z
        KSkbAwAA
X-CMS-MailID: 20230102055128epcas2p3b07590114310fc6f40d4955bf953dfec
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----HOtZ9yd3N7yF5SFbHINLR7X-T_3piWaZJDYS8aWXhrzmidxZ=_e44a6_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221229100416epcas2p18f7600737b8f4149a1d75d2d8db3317a
References: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
        <CGME20221229100416epcas2p18f7600737b8f4149a1d75d2d8db3317a@epcas2p1.samsung.com>
        <1672307866-25839-4-git-send-email-dh10.jung@samsung.com>
        <f9b59733-61b1-67d8-01fa-fb3d3d7fbe0e@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------HOtZ9yd3N7yF5SFbHINLR7X-T_3piWaZJDYS8aWXhrzmidxZ=_e44a6_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Dec 29, 2022 at 11:23:02AM +0100, Krzysztof Kozlowski wrote:
> On 29/12/2022 10:57, Daehwan Jung wrote:
> > Currently, dwc3 invokes just xhci platform driver(generic-xhci) without
> > DT schema even though xhci works as child of dwc3. It makes sense to add
> > xhci as child of dwc3 with DT schema. It also supports to use another
> > compatible in xhci platform driver.
> 
> You use some driver as an argument for hardware description, which is
> not what we need. Describe the hardware.
> 

OK. I will it on next submission.

> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  .../devicetree/bindings/usb/snps,dwc3.yaml    | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > index 6d78048c4613..83ed7c526dba 100644
> > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > @@ -360,8 +360,22 @@ properties:
> >      description:
> >        Enable USB remote wakeup.
> >  
> > +  "#address-cells":
> > +    enum: [ 1, 2 ]
> > +
> > +  "#size-cells":
> > +    enum: [ 1, 2 ]
> > +
> > +  ranges: true
> > +
> >  unevaluatedProperties: false
> >  
> > +# Required child node:
> > +patternProperties:
> > +  "^usb@[0-9a-f]+$":
> > +    $ref: generic-xhci.yaml#
> > +    description: Required child node
> 
> DWC does not have another piece of controller as child... DWC is the
> controller. Not mentioning that you now affect several other devices
> without describing the total hardware picture (just some drivers which
> is not that relevant).
> 

DWC controller supports USB Host mode and it uses same resource and
really works as a child. I guess it's same on many SOCs, especially
mobile..

I just want to modify it to work with DT schema (dwc3 -> xhci-plat).
I think it needs to dicuss more..

Best Regards,
Jung Daehwan.

> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -388,4 +402,19 @@ examples:
> >        snps,dis_u2_susphy_quirk;
> >        snps,dis_enblslpm_quirk;
> >      };
> > +  - |
> > +    usb@4a200000 {
> > +      compatible = "snps,dwc3";
> > +      reg = <0x4a200000 0xcfff>;
> > +      interrupts = <0 92 4>;
> > +      #address-cells = <1>;
> > +      #size-cells = <1>;
> > +      ranges;
> > +
> > +      xhci: usb@4a200000 {
> > +        compatible = "generic-xhci";
> 
> There are no such device...
> 

> > +        reg = <0x4a200000 0x7fff>;
> > +        interrupts = <0 92 4>;
> > +      };
> > +    };
> >  ...
> 
> Best regards,
> Krzysztof
> 
> 

------HOtZ9yd3N7yF5SFbHINLR7X-T_3piWaZJDYS8aWXhrzmidxZ=_e44a6_
Content-Type: text/plain; charset="utf-8"


------HOtZ9yd3N7yF5SFbHINLR7X-T_3piWaZJDYS8aWXhrzmidxZ=_e44a6_--
