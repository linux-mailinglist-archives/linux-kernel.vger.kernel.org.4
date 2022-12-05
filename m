Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386776421EB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 04:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiLEDg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 22:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiLEDgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 22:36:21 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C205013DF4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 19:36:18 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221205033615epoutp03b1c7dfddd3ad0908feea8502c5c145d8~tyGV842jT1215512155epoutp03G
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:36:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221205033615epoutp03b1c7dfddd3ad0908feea8502c5c145d8~tyGV842jT1215512155epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670211375;
        bh=vykUbSZQ2tSNJ4Q6qaLHYNUo8WIpdFle8u7wtY6lG5A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G0PQ0aGfbsmH2quk4G3iyHZgJJSDkAixc5TS58HNxPaoS/nDrgVNBDybfXaappqjt
         J62hSqOKjKnBavBXS1xNZcb6OW6UStLKVDtV20dFY/ZxiCyvyKSHBsJic0qMeA5KAb
         eJpGaCwICqv132CgiY9cmnpuRPhHm7INZ1qTJBFE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20221205033614epcas2p1868ca6484b026c918fe3d253cc156712~tyGVahCgL1877318773epcas2p1G;
        Mon,  5 Dec 2022 03:36:14 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NQTjT6Y4tz4x9Pt; Mon,  5 Dec
        2022 03:36:13 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.17.12278.D276D836; Mon,  5 Dec 2022 12:36:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20221205033613epcas2p26b786c2a02615009d5d8c705187c3f76~tyGUKviyE2041720417epcas2p2-;
        Mon,  5 Dec 2022 03:36:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221205033613epsmtrp2989e175d66a68b16f0b25424b5609b85~tyGUJo7Pc0472304723epsmtrp2r;
        Mon,  5 Dec 2022 03:36:13 +0000 (GMT)
X-AuditID: b6c32a46-ad1fd70000012ff6-04-638d672d6153
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.74.14392.C276D836; Mon,  5 Dec 2022 12:36:12 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221205033612epsmtip22e7eca52c67549d89f161b3e1a48b628~tyGT13sWv0727907279epsmtip27;
        Mon,  5 Dec 2022 03:36:12 +0000 (GMT)
Date:   Mon, 5 Dec 2022 12:30:34 +0900
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
Subject: Re: [RFC PATCH v1 2/2] usb: host: add xhci-exynos to support Exynos
 SOCs
Message-ID: <20221205033034.GE54922@ubuntu>
MIME-Version: 1.0
In-Reply-To: <Y4hgnxGMEuizJumr@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHd/va11JW8qyAd7AoK8MEGNDyq1cUMgdqF4khISbL3NbV9gW6
        Qtv1tQZ/bEAIP6wTETBikQFCRIEMh6Xj96AykIpAcDAx1ADSTVncFBUYyraWB8b/PufH95x7
        zr2Xg/Ef4z4cpVpP6tSyNAHOZVpuBIpDQlJOy4UlFRFo+nsLjlaL+9losqgRoOL85yxU2TfM
        Qra6agbKqWnC0cXJcGSfWWaiwoczGCp9VcdAzQ8mWOhO+0UclY10M9Cly7kYymkuZaHcrj42
        MtrvOiv1eqEV8zz40FPycqUYSNpMdrakpvMRQ9JcfxKXTE104pKfKxrZkuu1mZJCcz2QNJnH
        mZJnzVuTuJ+qdqWSMgWp8yPVco1CqU6JFexPlsZLo6KFohDRDiQW+Kll6WSsICExKWSvMs05
        ncDviCzN4HQlyShKEBa3S6cx6Em/VA2ljxWQWkWaVqwNpWTplEGdEqom9TEioTA8ypn4pSr1
        v9ojWsfbGY7BFmYW6OAagRsHEpFwcOYnlhFwOXyiFcCmaiuTNhYAtAz9g9HGIoC/VtayNiTX
        HIU4HegC0PaiZF0/B2DluTK2K4tJvA9/LG3FXIwTQfD+8s019iQi4JnbJrZLgBGn2LBnboLp
        CmwmkmF+3rk1MY8IhgV1Heu8CQ5emFvLcSMCYU5lnpM5HC9ng/neTFcdSCxzoKP1JObyQyIB
        lvRtpU+6Gc4PmNk0+8Bnf3XhNKvgb4unmDRnwCtdGxwBTb/nAxdjRCo05toYdEl/2HePSbs9
        YMGNVTbt5sGCPD6t9Ifn7xSt7+cd2PvnMEazBN6rKWe/XuL90VpWEdhmemMw0xvdaP4AVnUs
        4CZnC4zwhXX/cmgMhE3tYVWAVQ+8SS2VnkJS4drw13ct16Q3g7V3H7S3FZQ+fhJqBQwOsALI
        wQSevO0138n5PIXs6DFSp5HqDGkkZQVRzms6i/l4yTXOj6PWS0WRO4SR0dEicXiUUCzYwisv
        LZDziRSZnlSRpJbUbegYHDefLIbCu737m7lWqa1w37tDjk3jQVwbbyDg6wXD3IvOAJV7deLQ
        9T3dY6f3BWd7ZI/oRwrGRHp7T/DS8emn58cGDk01Hvyca5hfsmSfeGQZGWv6rIJ/U/qHanSK
        aqsKFh5IGFZefciLj3mpND/P7OmP5FYdv3trVhG57drRp/m7R5G4pSFOi2z22wc/it+5CJIu
        bZmNt37cUm7dOXFMmkwJz3gfeBX0lr9d1XBh+tvJlUT3J3Ewr3+2TYmMk76rGb1fmH+pteK7
        tweU7f8bC/2B3+W4ZalpUFCfxCRVZH81vudw95XcB3n+I8b6xPrDJ2S899wDl8oGGdFZHmFU
        m6/BdigZCphUqkwUhOko2f8jbdz+gAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSvK5Oem+ywcPJlhYP5m1js/g76Ri7
        xc0JaxgtJrV/YbWYf+Qcq8Wp5QuZLJoXr2ezmHPTyOLuwx8sFn0vHjJbTPmznMli0+NrrBaX
        d81hs5hxfh+TxaJlrcwWzZumsFq07j3CbtF19wbQpIOiFr+2vGJ0EPH4/WsSo8fOWXfZPRbv
        ecnksWlVJ5vHnWt72Dz2z13D7rF5Sb1H35ZVjB7rt1xl8fi8SS6AK4rLJiU1J7MstUjfLoEr
        Y8mhv0wFS7kqnv8/yNrAOIWji5GTQ0LARGLD0z62LkYuDiGB3YwS+7fdY4dISEosnXsDyhaW
        uN9yhBWi6BGjRM+Kq8wgCRYBFYmNU3aA2WwCWhL3fpwAs0UEjCX6z85iB2lgFpjILtG7YxEb
        SEJYIFiivW0q2FReAW2JjuW72SGmfmOU2HL0HAtEQlDi5MwnYDYz0NQb/14ydTFyANnSEsv/
        gZ3NKaAp0Ty/jQUkLAp0xKuD9RMYBWchaZ6FpHkWQvMCRuZVjJKpBcW56bnFhgWGeanlesWJ
        ucWleel6yfm5mxjBMauluYNx+6oPeocYmTgYDzFKcDArifCqLe5JFuJNSaysSi3Kjy8qzUkt
        PsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoFpao/BlyA3dd4E8/urHrm8t7/El2Ym
        ur9XWCQur7eKcWVHz6vN0+L/+W0NurHpPm/JrrTn62ZNL1gU8rip4cSS5IDcClUP9hXSysw5
        WyTsN2/cd0XhQRTTntezEzYGtSu8+s5qcNMgMqZuYYd2l4g3X6ie+CQpjctKt7ad3Cy1cw/z
        Ib7jvJuuC/7RYDm4I4Tv3LPtp28zLVhiZc7qvJ3trIX8lasH9rMsMGD68OtORreu0z6rwoh+
        S/U+nQTTeRaqlwqTtgh27+HdVvznuVnZczNJ4ymLYu6sCer7ukh/dkHmjKptJrtULm/Welwf
        vzh+13L++zELFrNpm9bP2Bg6y6ZmS1ZyjqPHv6t7pe4qsRRnJBpqMRcVJwIAzNtGT0gDAAA=
X-CMS-MailID: 20221205033613epcas2p26b786c2a02615009d5d8c705187c3f76
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----nsGjZeq2cmX7r6z8R2mwVRxDvTH8Yl9kQPEM01OfpImQQXYH=_15cf8_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7
References: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
        <CGME20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7@epcas2p2.samsung.com>
        <1669860811-171746-3-git-send-email-dh10.jung@samsung.com>
        <Y4hgnxGMEuizJumr@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------nsGjZeq2cmX7r6z8R2mwVRxDvTH8Yl9kQPEM01OfpImQQXYH=_15cf8_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Dec 01, 2022 at 09:06:55AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 01, 2022 at 11:13:31AM +0900, Daehwan Jung wrote:
> > This driver works with xhci platform driver. It needs to override
> > functions of xhci_plat_hc_driver. Wakelocks are used for sleep/wakeup
> > scenario of system.
> 
> So this means that no other platform xhci driver can be supported in the
> same system at the same time.
> 
> Which kind of makes sense as that's not anything a normal system would
> have, BUT it feels very odd.  This whole idea of "override the platform
> driver" feels fragile, why not make these just real platform drivers and
> have the xhci platform code be a library that the other ones can use?
> That way you have more control overall, right?
> 
> thanks,
> 
> greg k-h
> 

Currently It seems there are 2 ways to excute own function.
1. xhci_plat_priv
-> This is hard to use it if the driver invokes xhci platform driver from
dwc3_host_init(usb/dwc/host.c). I can't pass driver data during probe.
2. xhci_driver_overrides
-> This is only useful if I has own xhci driver.

That's why I wanted to extend overriding concept of xhci platform driver.
If some code is better to be directly in xhci platform driver than xhci-exynos,
I will modify it.

Best Regard,
Jung Daehwan

------nsGjZeq2cmX7r6z8R2mwVRxDvTH8Yl9kQPEM01OfpImQQXYH=_15cf8_
Content-Type: text/plain; charset="utf-8"


------nsGjZeq2cmX7r6z8R2mwVRxDvTH8Yl9kQPEM01OfpImQQXYH=_15cf8_--
