Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A22642171
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 03:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiLECRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 21:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiLECR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 21:17:27 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB1F12A92
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 18:17:25 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221205021723epoutp04f54a267ef80bee75335267ff07bd47bc~txBfya6JM0645906459epoutp04K
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:17:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221205021723epoutp04f54a267ef80bee75335267ff07bd47bc~txBfya6JM0645906459epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670206643;
        bh=TQMO1HpsoCxaU8DiNFBs3GsDK7ImM5RabRrq5luFARA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OjShH931MUEnXin1Bturi2CXgVKAtrAYsX4uCK/K4b5HrTqMTV5w6HkJNyOzPlDLF
         Ur2YXQZOa6gJABNNuxC7JGYVKv/4OciBDmMowscU23qT5SfkYDRPdeLhazTXuNqymA
         9hKk3DQhikHr8rSTfabygJoUsXNIsOxSb7jmM/yo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20221205021723epcas2p3a8a1d21f640f6687bb79bf93db20b12d~txBfIftdR2144621446epcas2p3W;
        Mon,  5 Dec 2022 02:17:23 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NQRyV50w3z4x9Q6; Mon,  5 Dec
        2022 02:17:22 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.AF.08487.2B45D836; Mon,  5 Dec 2022 11:17:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20221205021722epcas2p3617020b6605820b9e10590af26f96d59~txBeALNMF2144621446epcas2p3P;
        Mon,  5 Dec 2022 02:17:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221205021722epsmtrp15791d2e2e88d229ac94c6bd04a9e90b2~txBd-IFYe1913919139epsmtrp1j;
        Mon,  5 Dec 2022 02:17:22 +0000 (GMT)
X-AuditID: b6c32a47-ac5b870000002127-74-638d54b21719
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.64.18644.1B45D836; Mon,  5 Dec 2022 11:17:21 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221205021721epsmtip2d0e2f9ed7eb4e01ddf5486274d8dd97d~txBdtqHBf2291822918epsmtip2i;
        Mon,  5 Dec 2022 02:17:21 +0000 (GMT)
Date:   Mon, 5 Dec 2022 11:11:43 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
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
Message-ID: <20221205021143.GB54922@ubuntu>
MIME-Version: 1.0
In-Reply-To: <c524cba6-4438-461a-ab05-9325fe09f832@app.fastmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc3p7by+4mkuBcQDH6oVswni0lcdFxZDp9CYSw4aiQjYo7bVl
        lLZpi8PNDRbHY8wpYglY2BQhA/FRuSKBChKgccIYkDFxknVMxxjF4BwQh6jbWi4s/vc539/j
        e37ngSOiWSwAz9aaGINWriExT35bX2hMBLvnS4Vk2h5C/fp1G0Y9r7gpoO6WXwRURckCSp2x
        D6HUQGMdjzpab8Wo2rsyynFvkU8dn76HUOZnjTyK/W0MpUZttRhVPXyDR537pgihjrJmlCrq
        sguoMsdPrk49vtRS6wxI9KGfLlUAusPiEND1nU4ezTZ/jtE/j3VidPdXFwX01YYC+nhrM6Ct
        rbf59DwblOyZlrNFzciVjEHMaBU6ZbZWlUDuSsnYlhETK5FGSOOpOFKslecyCeT2pOSIHdka
        13Sk+JBck+eSkuVGIxm1dYtBl2dixGqd0ZRAMnqlRh+njzTKc415WlWkljFtkkokshhXYmaO
        2jZ0CtV3eeUvtTnQQnBqbRnwwCERDWcezCFlwBMXEe0AllQVAndARMwBeKEK4wLzAF76+wds
        tcJ5aQLlAjYAPzVfXVlMAljZNLGcxSdCYN+tAZ6bMSIM/rJ4C3GzD7EeVk5PLfshxBkBfFg/
        uZzkTaTAkuJKgZuFxBuQffQdj2Mv2H96ku9mD2I7HKwqchXjuK/LYKanwN0HEv/isOb3JuDW
        oSvnj5F4bqfecObbVgHHAdB5oniFc+Cdx1/wOc6HTV2rvBFapkqWx0cINex/OLnSMhjax/mc
        vBaW9j0XcLIQlhaLuMpgWDVajnLsD3seDCEc03C8vkbAHc8VHnxk7hOUg1ctLwxmecGN43B4
        9vocZnFZIEQgbPwH5zAUWm1RZwHaDF5m9MZcFWOU6Tf+f9cKXS4Llt992M52UD37KLIX8HDQ
        CyCOkD7C1+qPKURCpfzwh4xBl2HI0zDGXhDjuqaTSICvQuf6OFpThjQ6XhIdGyuNk8VI4kg/
        YY25VCEiVHITk8MwesawWsfDPQIKeZVkTrqeGM7yOTJlX2ezDYuHcpuebQhEQfdAlp/v4JN9
        rzzeizX4ZYdv2Hr/QOLepDVe9P15TJQRujRdp/gzSiMoumy9vadQM2W+9mbajrH3dgZGbYob
        l822SNnrlyueBu1OGUtOGc368eA0u77t/NvfpyLnT3eu2Rfuf2Bd4BU0OlxFOZUf7ao+sm1z
        eveFG+yxk46KOusUW1Tauf8t5euy0M6+a4rUD/D5zHMN1UHqmdn49E9ivds/U2UdXCAPjbSk
        /lXqSLV3a0ffScODLf0nOjzCNr+/+yVrx7vOkJsTc5bE2vzFw87K9JG67P0tmaEfJ/mHF4iF
        joWeUXNJXtWdJ4Mk36iWS8MQg1H+H9Rxj5uABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSvO7GkN5kg/4TphYP5m1js/g76Ri7
        xc0JaxgtJrV/YbWYf+Qcq8Wp5QuZLJoXr2ezmHPTyOLuwx8sFn0vHjJbTPmznMli0+NrrBaX
        d81hs5hxfh+TxaJlrcwWzZumsFq07j3CbtF19wbQpIOiFr+2vGJ0EPH4/WsSo8fOWXfZPRbv
        ecnksWlVJ5vHnWt72Dz2z13D7rF5Sb1H35ZVjB7rt1xl8fi8SS6AK4rLJiU1J7MstUjfLoEr
        Y/aOi4wFf/kqPq2YwdjA+Ia7i5GTQ0LAROLl2vusXYxcHEICOxglzq3+zgyRkJRYOvcGO4Qt
        LHG/5QhU0SNGiV9X5rGCJFgEVCQOnzjFBGKzCWhJ3PtxAqxZREBRYuqLZ8wgDcwCi9klHs27
        ygiSEBYIlmhvmwo2lVdAW2LTh9NMEFM3MEn8Xz6RESIhKHFy5hMWEJsZaOqNfy+BijiAbGmJ
        5f84QMKcAi4SZ6a3MoOERYGOeHWwfgKj4CwkzbOQNM9CaF7AyLyKUTK1oDg3PbfYsMAoL7Vc
        rzgxt7g0L10vOT93EyM4ZrW0djDuWfVB7xAjEwfjIUYJDmYlEV61xT3JQrwpiZVVqUX58UWl
        OanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTAJFJjcnqz1QmD63Edz9sqaaf35
        WFrtv4Rv32aNTYXF15U+6Jy5/j2acRlTSPwtozxFnZS2U4nWTp6tx65/4Hdym2j3+f6RRq55
        yqp613s6vT5/zv+07GDV8b2sL1fcS5ilW7jn14b37y4nz4oy7Pmo94prxbmJYW2d2odi+S5e
        +FoTGTgp4A4/V+bNn/HTQm7ofRV4u+5s7awD/y7LlFdGXE38ozjLYfrydR4WFjFL2oIYT87Q
        i297Kr95SYUx3zK1x83PtedU9XEUHE1xNw2dXDZ993muPx9fdDA8KmXuqxP6/PDkMcYbsTM2
        7Fuxh3GR1RH3A5u8zaouKuhsjc37/Zw5g39v9NqGVw9cO7y2K7EUZyQaajEXFScCAFEoiJ1I
        AwAA
X-CMS-MailID: 20221205021722epcas2p3617020b6605820b9e10590af26f96d59
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----nsGjZeq2cmX7r6z8R2mwVRxDvTH8Yl9kQPEM01OfpImQQXYH=_151ec_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7
References: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
        <CGME20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7@epcas2p2.samsung.com>
        <1669860811-171746-3-git-send-email-dh10.jung@samsung.com>
        <Y4hgnxGMEuizJumr@kroah.com>
        <c524cba6-4438-461a-ab05-9325fe09f832@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------nsGjZeq2cmX7r6z8R2mwVRxDvTH8Yl9kQPEM01OfpImQQXYH=_151ec_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Dec 01, 2022 at 10:01:44AM +0100, Arnd Bergmann wrote:
> On Thu, Dec 1, 2022, at 09:06, Greg Kroah-Hartman wrote:
> > On Thu, Dec 01, 2022 at 11:13:31AM +0900, Daehwan Jung wrote:
> >> This driver works with xhci platform driver. It needs to override
> >> functions of xhci_plat_hc_driver. Wakelocks are used for sleep/wakeup
> >> scenario of system.
> >
> > So this means that no other platform xhci driver can be supported in the
> > same system at the same time.
> >
> > Which kind of makes sense as that's not anything a normal system would
> > have, BUT it feels very odd.  This whole idea of "override the platform
> > driver" feels fragile, why not make these just real platform drivers and
> > have the xhci platform code be a library that the other ones can use?
> > That way you have more control overall, right?
> 
> Agreed, having another layer here (hcd -> xhci -> xhcd_platform ->
> xhcd_exynos) would fit perfectly well into how other SoC specific
> drivers are abstracted. This could potentially also help reduce
> the amount of code duplication between other soc specific variants
> (mtk, tegra, mvebu, ...) that are all platform drivers but don't
> share code with xhci-plat.c.
> 
> Alternatively, it seems that all of the xhci-exynos support could
> just be part of the generic xhci-platform driver: as far as I can
> tell, none of the added code is exynos specific at all, instead it
> is a generic xhci that is using the wakeup_source framework.
> 
> It should be possible to check at runtime whether an xhci-platform
> instance uses the wakeup source or not, and then have the same
> driver work across more platforms.
> 
>       Arnd
> 

Currently there's no other platforms using wakelock. I wanted to add
xhci-exynos as I think Exynos use it specially. I also agree we can add it
on xhci platform driver if needed.

Best Regards,
Jung Daehwan

------nsGjZeq2cmX7r6z8R2mwVRxDvTH8Yl9kQPEM01OfpImQQXYH=_151ec_
Content-Type: text/plain; charset="utf-8"


------nsGjZeq2cmX7r6z8R2mwVRxDvTH8Yl9kQPEM01OfpImQQXYH=_151ec_--
