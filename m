Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E32A63EB8D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiLAIsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLAIrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:47:47 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF2A6B39A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:47:12 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221201084709epoutp03b6f497f15c3bb1d8d881d9327fc231b2~snwqDfgiB1873518735epoutp03V
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:47:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221201084709epoutp03b6f497f15c3bb1d8d881d9327fc231b2~snwqDfgiB1873518735epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669884429;
        bh=xU5xTfeB/RV84pry0AX4eMewy1HuPhTACkMF9vC0oNc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bRrsUN77iPDpLemOjryfUGpNSGeaYNFAJq432IS1U252OYl4OAWOV2i0Vzsu+wzqH
         7iZ6rLf1pL5ubsEsP5Js6bOsSo1VSrcPFl7/7ZecwAliIYLYzHDAssjw1AI+xTwQEk
         qlZEnMlS5QZWODbgpJwWrEsuwblD5MeWgub7bMjQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20221201084708epcas2p127b040b4837295229e8d17ee4f6a9b51~snwpbx2w40396503965epcas2p1w;
        Thu,  1 Dec 2022 08:47:08 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NN8p41BcSz4x9QF; Thu,  1 Dec
        2022 08:47:08 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.DE.10048.C0A68836; Thu,  1 Dec 2022 17:47:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20221201084707epcas2p2cb6cfb1a0579bc30dfa4f1eca222f298~snwojs8d51017910179epcas2p2o;
        Thu,  1 Dec 2022 08:47:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221201084707epsmtrp11bbf5770071e4378a00dff36c2b21be9~snwoimDSm2387523875epsmtrp1a;
        Thu,  1 Dec 2022 08:47:07 +0000 (GMT)
X-AuditID: b6c32a45-7a3fe70000002740-06-63886a0c44cc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.9F.14392.B0A68836; Thu,  1 Dec 2022 17:47:07 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221201084707epsmtip10596135e10ba7ef4f3881ba0ace6f6bd~snwoUwZS-3064030640epsmtip1B;
        Thu,  1 Dec 2022 08:47:07 +0000 (GMT)
Date:   Thu, 1 Dec 2022 17:41:30 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [RFC PATCH v1 0/2] add xhci-exynos to support Samsung Exynos
 SOCs
Message-ID: <20221201084130.GA195673@ubuntu>
MIME-Version: 1.0
In-Reply-To: <Y4hftXoUdAQ3SK4s@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmqS5PVkeywY+NrBYP5m1js/g76Ri7
        xc0JaxgtJrV/YbWYf+Qcq8Wp5QuZLJoXr2ezmHPTyOLuwx8sFn0vHjJbTPmznMli0+NrrBaX
        d81hs5hxfh+TxaJlrcwWzZumsFq07j3CbtF19wbQpIOiFr+2vGJ0EPH4/WsSo8fOWXfZPRbv
        ecnksWlVJ5vHnWt72Dz2z13D7rF5Sb1H35ZVjB7rt1xl8fi8SS6AKyrbJiM1MSW1SCE1Lzk/
        JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoOyWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbpLzoF7zkrTvwXb2D8
        w97FyMkhIWAicfbrdqYuRi4OIYEdjBJ/7n9kAkkICXxilLj8Sx0i8Y1RYuWJXkaYjq0LX7NA
        JPYySjTOWMkO4TxhlDjWc54ZpIpFQEVixuGzYB1sAloS936cAIuLCBhL9J+dBdbALNDNLnHg
        yTUWkISwQIDEm8NtYEfxCuhI7D6/gRHCFpQ4OfMJWA2ngKbExdVPWbsYOThEgRa8OlgPMkdC
        4D+HxOPOPawQ57lItM9+yQZhC0u8Or4F6lEpiZf9bVB2tsT1b90sEHaFxIq9MLaxxKxn7Ywg
        85kFMiXOHJIDMSUElCWO3AKrYBbgk+g4/JcdIswr0dEmBNGoLDH98gSoAyQlDr4+xwxR4iHR
        fsYZEp47GSW+X1CYwCg/C8lbsxBWzQKbryOxYPcnNoiwtMTyfxwQpqbE+l36CxhZVzGKpRYU
        56anFhsVGMKjOTk/dxMjOMlrue5gnPz2g94hRiYOxkOMEhzMSiK8HZ/bkoV4UxIrq1KL8uOL
        SnNSiw8xmgLjaCKzlGhyPjDP5JXEG5pYGpiYmRmaG5kamCuJ83bN0EoWEkhPLEnNTk0tSC2C
        6WPi4JRqYMp7m3iiuk7iyouDh7sOtx/NZmM4eFTVWEkzeRtj+HkxC6MPmVPvCIpYeM/RqHM7
        eGHlhz+r1Z/cLpCWWFqyyUUvXWbuy9aZn67y9ansfTBxes4/j81Ft++xRH5lehSZ2ys5USox
        bV9QYarGssMv27b7X1pca7C98KHO+imCB3w3lD48++nIpBUbFFOmzX/7lPdu8Hqp9O+2mjeu
        1HGXFLZYi0Qu/8nyiz+ubOFz5QuhJp+be4yfF85tqW6PCO/ysf/X7qJus2Xe12u8nG3C+mdv
        6k+tdHNxsup8tWyyjBQz34+q1uZtvDIOSzcJPrnpFb+IZ01bVrDzZlcN+fvb+FcGi+X4XC5I
        mW7x4dECASWW4oxEQy3mouJEAF7wz+Z7BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSnC53VkeywY7LahYP5m1js/g76Ri7
        xc0JaxgtJrV/YbWYf+Qcq8Wp5QuZLJoXr2ezmHPTyOLuwx8sFn0vHjJbTPmznMli0+NrrBaX
        d81hs5hxfh+TxaJlrcwWzZumsFq07j3CbtF19wbQpIOiFr+2vGJ0EPH4/WsSo8fOWXfZPRbv
        ecnksWlVJ5vHnWt72Dz2z13D7rF5Sb1H35ZVjB7rt1xl8fi8SS6AK4rLJiU1J7MstUjfLoEr
        48KVn6wFa9grts7Zxd7AeIm1i5GTQ0LARGLrwtcsXYxcHEICuxkl+t/2MUMkJCWWzr3BDmEL
        S9xvOcIKUfSIUeLZ9EawIhYBFYkZh88ygthsAloS936cAIuLCBhL9J+dxQ7SwCwwkV2id8ci
        ti5GDg5hAT+J+TNYQGp4BXQkdp/fANYrJLCTUWJJozpEXFDi5MwnYDXMQDNv/HvJBNLKLCAt
        sfwfB0iYU0BT4uLqp6wgYVGgE14drJ/AKDgLSfMsJM2zEJoXMDKvYpRMLSjOTc8tNiwwzEst
        1ytOzC0uzUvXS87P3cQIjlctzR2M21d90DvEyMTBeIhRgoNZSYS343NbshBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MUfOtDsYVsazT4b1jyJ/EcTb8
        cM8ML7tvJbsK5IXfJ/RNf/eUy1zltP9Op8fRIbYHr9g2du3Ynblr4cRY872eB12Sb/af5Bew
        L1i2YOeT5hfq8cKzveKnse6+eGKzhnBoQ//LTW/2R5uUVnMtv6y522Z1b1TIxaD5zIou64/s
        XjH77nf1KQuOu7Gs331e2+nWUT7uyTxq7wxTXu4PO1l8P9BZvjX36ZFdZ3NuHa5drTH3sOfu
        q3zTDC1uNEo+6pm3yq9Db18a+zau1gbGPXN+lSd8LzJXWbQ02Xyn3lO2tu+Mzmf3Nu1ieXfd
        QK+m8Z67w//ba3dPTOjSNlwQ8SX66xq3ypL49z2/XducvOyZlViKMxINtZiLihMBCPAyH0YD
        AAA=
X-CMS-MailID: 20221201084707epcas2p2cb6cfb1a0579bc30dfa4f1eca222f298
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----vASH.pIaeqe1VhI1kM1L2G1Xl7-k5WZCtOgud_GtoWwibbjx=_102990_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221201021940epcas2p2073f25dad069314022471eaa16d26592
References: <CGME20221201021940epcas2p2073f25dad069314022471eaa16d26592@epcas2p2.samsung.com>
        <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
        <Y4hftXoUdAQ3SK4s@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------vASH.pIaeqe1VhI1kM1L2G1Xl7-k5WZCtOgud_GtoWwibbjx=_102990_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Dec 01, 2022 at 09:03:01AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 01, 2022 at 11:13:29AM +0900, Daehwan Jung wrote:
> > This patchset is to support xHCI Controller on Samsung Exynos SOCs.
> > 
> > Daehwan Jung (2):
> >   dt-bindings: usb: samsung,exynos-xhci: support Samsung Exynos xHCI
> >     Controller
> >   usb: host: add xhci-exynos to support Exynos SOCs
> 
> Why is this a "RFC" and not a real submission?  What needs to be done to
> it to get it into mergable shape?
> 
> And thank you for posting this, I've wanted to see this merged for a
> very long time given the millions of devices already using it.
> 
> thanks,
> 
> greg k-h
> 

Hi greg,

That's because It's my first time to submit the patchset with dt bindigs.
I've been trying not to miss anything needed but I want to check whether
it's acceptable or not. I will resend it if there's no problem.

Best Regards,
Jung Daehwan

------vASH.pIaeqe1VhI1kM1L2G1Xl7-k5WZCtOgud_GtoWwibbjx=_102990_
Content-Type: text/plain; charset="utf-8"


------vASH.pIaeqe1VhI1kM1L2G1Xl7-k5WZCtOgud_GtoWwibbjx=_102990_--
