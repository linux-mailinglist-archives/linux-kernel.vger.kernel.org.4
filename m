Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAD5642190
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 03:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiLECd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 21:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiLECdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 21:33:54 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DD0640C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 18:33:52 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221205023350epoutp0297bac74bdaaeea2400b5d5c61203f93b~txP2aB1XU1248012480epoutp02R
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:33:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221205023350epoutp0297bac74bdaaeea2400b5d5c61203f93b~txP2aB1XU1248012480epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670207630;
        bh=t3r1eSa3NMhGWj5E9vHOcmDhjhBVmQtWQLLxmViU1oQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tz+chi/wjJDEphsHi+FSCdxumBNqgJQHHNgax8TRdt/aUCTBGUikjv0opOoRdT3PU
         KAvTmKwpIdDwHOUm+1WLY64JOls6OIs99x09obboPsKvJ9V3cVLaBnBL9LeUawxsC4
         jESygoflhV4saiy8oY24o5xYrbV7W5SGbuy4cxao=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20221205023349epcas2p3c58fed1b7e0147398b9d3e8ec8d15975~txP15BVok2165521655epcas2p3t;
        Mon,  5 Dec 2022 02:33:49 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NQSKT2Fllz4x9Pp; Mon,  5 Dec
        2022 02:33:49 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.BD.10048.D885D836; Mon,  5 Dec 2022 11:33:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20221205023348epcas2p368016dfb7cd9b13057269142d9f76812~txP06Z-QD2953529535epcas2p3a;
        Mon,  5 Dec 2022 02:33:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221205023348epsmtrp177d1f0ad128a440a4158d8cf9c5cca17~txP05arms2949029490epsmtrp1O;
        Mon,  5 Dec 2022 02:33:48 +0000 (GMT)
X-AuditID: b6c32a45-7a3fe70000002740-22-638d588d561f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.36.18644.C885D836; Mon,  5 Dec 2022 11:33:48 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221205023348epsmtip2f490df09b8313f11f5b997e3e415e4da~txP0lwW3D0370003700epsmtip2L;
        Mon,  5 Dec 2022 02:33:48 +0000 (GMT)
Date:   Mon, 5 Dec 2022 11:28:09 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20221205022809.GC54922@ubuntu>
MIME-Version: 1.0
In-Reply-To: <ec0ce90c-b165-d84f-340d-4973b65609b3@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVRTZRzHz7O73V3A5XU4eZoHnTMtQNhLvFyMeSyUruk5QXR6sw5etuvG
        GWw72yjqH0hlLF4UeSkdJG8KtDA8G4q8SAeEgjqJgSFgCBSSQHSQdZBDUO220fG/z/P7/t5/
        58EQ/hIqxFJ0Ztqoo1LFqC/72s2gqNCCtwqU0oksHjFx4RpKrBV9wyVGChsAUZTzJ4eo6L7F
        Ib6rq2IRJ2saUaJ8RE6MTS6zidMPJxGiZLWORTh+HeIQg63lKHGuv4NFVNdmI8RJRwmHmFs4
        wSayb3RzidyxYXe6TgGx0jQL9gvIv1aKANliG+OSNe0zLNJh/wQlfx5qR8kLfQnk1583cEnn
        xUzydJMdkI1NP7FJl2NbvN872hgNTaloo4jWKfWqFJ1aIT6cmBSbFBEplYXKookosUhHpdEK
        8YEj8aFxKanuMcWi96nUdLcpnjKZxJJ9MUZ9upkWafQms0JMG1SphihDmIlKM6Xr1GE62rxX
        JpXKI9yOx7Sa/Olh1NAYkPHl7A9oFsjzzwU+GMTD4ZXvh5Bc4Ivx8esAjt+Z5DACH18EsG/U
        K7gALC+c5qxH9BTd5nqEVgDriwdYnscUgJZTU24vDGPjz8DR5V1MAIoHw/vLvQjDm3EZXBpo
        Bow/gndw4XDzDMoI/ngizLGUchnm4SHQ0lDA8fAm2Hd+is2wDx4L7zX3ACa/wJ1/tjOTyQPx
        PB9Y0l+NeLo7AMdq573sD2e/beJ6WAhnzli8rIV3l/LYHs6A9TfW+Xlom84BDCO4BhYN3kGZ
        WhDfCbtH2R7zU9B6c43rMfOg1cL3RO6Enw0WevfzNOycu+XtgISjNWXeXc2w4D1rBbsQbLc9
        MZntiWoe3gMr2xbdjLl5K6z7G/NgEGxslVQCjh1soQ2mNDVtkhtk/99aqU9zgP8+QPDB66B4
        fiGsC7Aw0AUghog383bX5Cv5PBX14Ue0UZ9kTE+lTV0gwn2ms4hQoNS7f5DOnCQLj5aGR0bK
        ouQR0ihxAK+sxKrk42rKTGtp2kAb1+NYmI8wi9Uxrj51pnxc/4bz6LPlAsnhWY5gRt+LvXo2
        aEIYWIqVuqxC/7TAtiNtqChZbrDYaiXz7Ocet+QqEq5Y219wFUt/W0COVx29veH+IZsibjd1
        KTZW9kt21tvq+h0xTdH127XVzd2BG50P7Jrk967uaQ7gb9n/sdR+aTL9YbCLY9Qef4RWjat2
        jTwSdCOJE6/1qj6NVGyc63uzZnWgU+7Xu3XF2Z7sTDmW+NJIgP5gWz/2YkbPIhkZVzXsdK2+
        8oVo28Uwqvef83v5ZX7auXdDKsrQD/b98TizpUPStyH+8uv4+KaEE4NrdxsFLIldfTU0UOi7
        +uPll3+vzv9qrHKHVvLAESJmmzSULBgxmqh/AeGimuWJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSvG5PRG+ywfY98hYP5m1js/g76Ri7
        xc0JaxgtJrV/YbWYf+Qcq8Wp5QuZLJoXr2ezmHPTyOLuwx8sFn0vHjJbTPmznMli0+NrrBaX
        d81hs5hxfh+TxaJlrcwWzZumsFq8/tDEYtG69wi7RdfdG0DjDopa/NryitFB1OP3r0mMHjtn
        3WX3WLznJZPHplWdbB53ru1h85h3MtBj/9w17B6bl9R79G1ZxeixfstVFo/Pm+QCuKO4bFJS
        czLLUov07RK4Ml73fGIreC9ScaN/F3sD4xOBLkZODgkBE4mjky6wdzFycQgJ7GCUaLj7ihUi
        ISmxdO4NdghbWOJ+yxFWiKJHjBJHZp4ASnBwsAioSNz6oQpSwyagJXHvxwlmEFtEwFDi26Xt
        jCD1zAJH2CXOr+pgBEkICwRLtLdNBRvKK6At0bamF2roSyaJrsnLWCASghInZz4Bs5mBpt74
        95IJZBmzgLTE8n8cIGFOAWeJ29uPMoKERYFueHWwfgKj4CwkzbOQNM9CaF7AyLyKUTK1oDg3
        PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4hrW0djDuWfVB7xAjEwfjIUYJDmYlEV61xT3JQrwp
        iZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTAxzPl9Jrs451ro
        +0fFTMzBWUzNHUY2Lnwbpd4Kr+W5Uj39zvwd9pOZHndkNp+53rBRuPaR6HchhTLGJZ0KfyL8
        HZ347516nlp7ZPOxCQLvL3Ln/du3O3bVFr/FlRcVlEN8Jf26867271z73o0vM91Po9z1d1qm
        4v/TzYZtNufaOWcpbm68IP4h595/GTPTdXlhQmEZu58bCD+Rmiw+y2qxqeaEoxWZCzfJT/YV
        4bmY+2t1ovcCbxdhQ+Z5veeiuk+rnzrn43Nj9hQ75leSLJPXVHyVDrpkynPlxvPjeVtijT2L
        ov8pyWfm+f65f2FxQWy51NeOOdOOBtz+VaPxR9b4yR2ezLRDvdIGCq9c5ymxFGckGmoxFxUn
        AgALJsisUAMAAA==
X-CMS-MailID: 20221205023348epcas2p368016dfb7cd9b13057269142d9f76812
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----3fo7lev8HRxwEdfRbJiPjGY7XcYF58l8nMiK-NSEDm8eBp4M=_1539a_"
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
        <ec0ce90c-b165-d84f-340d-4973b65609b3@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------3fo7lev8HRxwEdfRbJiPjGY7XcYF58l8nMiK-NSEDm8eBp4M=_1539a_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Dec 02, 2022 at 02:22:39PM +0200, Mathias Nyman wrote:
> On 1.12.2022 11.01, Arnd Bergmann wrote:
> >On Thu, Dec 1, 2022, at 09:06, Greg Kroah-Hartman wrote:
> >>On Thu, Dec 01, 2022 at 11:13:31AM +0900, Daehwan Jung wrote:
> >>>This driver works with xhci platform driver. It needs to override
> >>>functions of xhci_plat_hc_driver. Wakelocks are used for sleep/wakeup
> >>>scenario of system.
> >>
> >>So this means that no other platform xhci driver can be supported in the
> >>same system at the same time.
> >>
> >>Which kind of makes sense as that's not anything a normal system would
> >>have, BUT it feels very odd.  This whole idea of "override the platform
> >>driver" feels fragile, why not make these just real platform drivers and
> >>have the xhci platform code be a library that the other ones can use?
> >>That way you have more control overall, right?
> 
> Agree that overriding the generic platform driver xhci_hc_platform_driver
> from this exynos driver is odd.
> 
> But I don't understand how this works.
> Where are the hcds created and added when this xhci-exonys driver binds to
> the device? all this driver does in probe is the overriding?
> 
> Am I missing something here?
> 

This works mainly with xhci platform driver. But xhci-exynos needs to override
some funtions. xhci-exynos probes first with override own functons and
it works with xhci platform driver.

> >
> >Agreed, having another layer here (hcd -> xhci -> xhcd_platform ->
> >xhcd_exynos) would fit perfectly well into how other SoC specific
> >drivers are abstracted. This could potentially also help reduce
> >the amount of code duplication between other soc specific variants
> >(mtk, tegra, mvebu, ...) that are all platform drivers but don't
> >share code with xhci-plat.c.
> >
> >Alternatively, it seems that all of the xhci-exynos support could
> >just be part of the generic xhci-platform driver: as far as I can
> >tell, none of the added code is exynos specific at all, instead it
> >is a generic xhci that is using the wakeup_source framework.
> 
> Sounds reasonable as well, and if some exynos specific code is needed
> then just create a xhci_plat_priv struct for exynos and pass it in
> of_device_id data like other vendors that use the generic
> xhci-platform driver do.
> 

I considered using existing overrides like xhci_plat_priv but I couldn't
find a solution. My driver invokes probing xhci platform driver in
source code not device tree. Allocation of platform device is done
in dwc3_host_init(usb/dwc3/host.c). That's why I can't pass device data
to xhci platform driver.

> -Mathias
> 
> 

------3fo7lev8HRxwEdfRbJiPjGY7XcYF58l8nMiK-NSEDm8eBp4M=_1539a_
Content-Type: text/plain; charset="utf-8"


------3fo7lev8HRxwEdfRbJiPjGY7XcYF58l8nMiK-NSEDm8eBp4M=_1539a_--
