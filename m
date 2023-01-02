Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70A765AD84
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 07:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjABGl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 01:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjABGly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 01:41:54 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46973F06
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 22:41:51 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230102064148epoutp04bb12612fd1fb2fab1c9cd704221801f4~2asWmNUy70784907849epoutp04y
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:41:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230102064148epoutp04bb12612fd1fb2fab1c9cd704221801f4~2asWmNUy70784907849epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672641708;
        bh=iENR/Lpbp9pO+khBHW4bk8uIePN9ziLkKDUIjKxkGKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tbQCvfZcy+pqCbfs9zAYAwFZUXx/gRG9b6Wd9gtfch+J7s0Gz0ihVDz6QALEO1DHa
         lnzg0oWkjYeWk+3vLGtd+xn46C/IXi1hEQBOYOpjSJVPTg/3oNTdlKMmGnyz42B650
         JMXJjuqzl3YBqN6Da38Ght0bzcG9LWeBLiu615UM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230102064147epcas2p298f17801c6b811872af2956fc055fa45~2asV5aLqN0835708357epcas2p2V;
        Mon,  2 Jan 2023 06:41:47 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NlmVg4lKhz4x9Q3; Mon,  2 Jan
        2023 06:41:47 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.10.61831.BAC72B36; Mon,  2 Jan 2023 15:41:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230102064147epcas2p4049d9efd78521375e2fd709326df0fb2~2asVMqNrb3080130801epcas2p4Y;
        Mon,  2 Jan 2023 06:41:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230102064147epsmtrp2caac934753ae984767844a10ce2886b7~2asVHGtKm1419014190epsmtrp2h;
        Mon,  2 Jan 2023 06:41:47 +0000 (GMT)
X-AuditID: b6c32a47-887fd7000000f187-29-63b27cabd1a8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.E1.10542.AAC72B36; Mon,  2 Jan 2023 15:41:46 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230102064146epsmtip1c5b182fdaa248f830f5f37db620a329d~2asU214C52799127991epsmtip1F;
        Mon,  2 Jan 2023 06:41:46 +0000 (GMT)
Date:   Mon, 2 Jan 2023 15:35:36 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Arnd Bergmann <arnd@arndb.de>
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
Subject: Re: [RFC PATCH v2 1/3] usb: support Samsung Exynos xHCI Controller
Message-ID: <20230102063536.GD74470@ubuntu>
MIME-Version: 1.0
In-Reply-To: <4c779562-37d2-4bd3-bb02-41b943d7ef9d@app.fastmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmhe7qmk3JBhO+KFv8nXSM3eJY2xN2
        i/lHzrFanFq+kMmiefF6Nou7D3+wWPS9eMhscXnXHDaLRctamS2aN01htWjde4TdouvuDUaL
        SQdFLVYtOMDuwOfx+9ckRo/Fe14yeWxa1cnmcefaHjaP/XPXsHv0bVnF6LFl/2dGj8+b5AI4
        orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DuVlIo
        S8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZk
        Z5z4Ooux4K5oxexv+1gbGFcJdjFyckgImEhcWryTuYuRi0NIYAejxK8TB6GcT4wS7y7sYYdw
        PjNKfJy4jwWm5cfSs2wQiV2MEh9+/4aqesIo0XC5hxmkikVAReJGz0w2EJtNQEvi3o8TYHER
        AUWJqS+ege1gFljFIrH91UOwscIC3hJzzvaA2bwC2hKzNxxngrAFJU7OfAIW5xRwkdjS/Ji1
        i5GDQxRowauD9SBzJASOcEg8P7AN6jwXiYl39jFB2MISr45vYYewpSQ+v9vLBmFnS1z/1g1V
        XyGxYi+MbSwx61k7I4jNLJAhcf/pa3aQXRICyhJHbrFAhPkkOg7/hQrzSnS0CUF0KktMvzyB
        FcKWlDj4+hwzhO0hsf3YJxZI+PQzSVyeO5VpAqP8LCSfzUKyDcLWkViw+xPbLKAVzALSEsv/
        cUCYmhLrd+kvYGRdxSiWWlCcm55abFRgDI/t5PzcTYzgNK3lvoNxxtsPeocYmTgYDzFKcDAr
        ifBe/rwuWYg3JbGyKrUoP76oNCe1+BCjKTCeJjJLiSbnAzNFXkm8oYmlgYmZmaG5kamBuZI4
        b9DW+clCAumJJanZqakFqUUwfUwcnFINTIzaGTopE43CfgVu93qd2/v8BZNLwdYNy67MKDhd
        Mq01qVjgv+xtxwj1gwkSh6Wbq0uqxc7s9Jkyv3fRk90r4300mTKUeldsDeLOSz43IW76vNk6
        c2Q61de2GZSc28XSppykNbkkiy9hC6do2R5fbwZG5gnx/sF3gr/UTFB6+HGmTQtjdY6MxfpD
        KoK5uw/Lmv74/Pwfm4z/i8l6HO4Sj8yztUV8pwbe+tjn43recKunWtvs/mnn2KZH3n/y9FCB
        7SnfqWsPK6d9CH0mtdFeS8V7//+GZVttPzkf4Z7kfunMfYMDm24KcW2etvjA7Sf/tqnoXJzu
        m6Wf+cSYYwKL7MLZTF9iRVO3v6xzMZu+QImlOCPRUIu5qDgRAODvvxJcBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTndVzaZkgy3fbCz+TjrGbnGs7Qm7
        xfwj51gtTi1fyGTRvHg9m8Xdhz9YLPpePGS2uLxrDpvFomWtzBbNm6awWrTuPcJu0XX3BqPF
        pIOiFqsWHGB34PP4/WsSo8fiPS+ZPDat6mTzuHNtD5vH/rlr2D36tqxi9Niy/zOjx+dNcgEc
        UVw2Kak5mWWpRfp2CVwZPy5MZSyYK1yxaOdhpgbGZv4uRk4OCQETiR9Lz7J1MXJxCAnsYJT4
        8/McG0RCUmLp3BvsELawxP2WI6wgtpDAI0aJjfdqQWwWARWJGz0zwerZBLQk7v04wQxiiwgo
        Skx98QzMZhZYxyKxdXI8iC0s4C0x52wPC4jNK6AtMXvDcSaIxf1MEpNffWKDSAhKnJz5hAWi
        WUvixr+XQEUcQLa0xPJ/HCBhTgEXiS3Nj1lBwqJAN7w6WD+BUXAWkuZZSJpnITQvYGRexSiZ
        WlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHGNaWjsY96z6oHeIkYmD8RCjBAezkgjv5c/r
        koV4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg4i59bfvB
        ct9xRc2FNu/PWSkGbDhXIpTzjftwK9OizgR5PiOWzMLDyZ9feH9Ivz3Tc6Xdyk/2fIJKfzRN
        tzQ3la66c1B0j7rIBxm1Y1nXl8Yu1KqUy9bfwPhgXlfqtSuux58zSD5bW2aXsbog/tNs7tjY
        fKUb59va74pl3zCqqF3s9beuqGDrC4fVkhMquDk659ftP7ZIhlHYdceiL21b97N1yHPvEHat
        m+GlU8a4YOtPvdTcUPm/phs2fPri0Mv7M/XOdSNHfp2HpjtUWyM2WRz7nbNj5df7nj++vXxd
        8d2xO1Vs25e3KbPDfi/Y8tSt3X/Nlf2Hr5p9KZu7vPSFu/FZ3eMf+RzUzKbElSY+VWIpzkg0
        1GIuKk4EALp+zp0gAwAA
X-CMS-MailID: 20230102064147epcas2p4049d9efd78521375e2fd709326df0fb2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----3fo7lev8HRxwEdfRbJiPjGY7XcYF58l8nMiK-NSEDm8eBp4M=_e4df7_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221229100413epcas2p34c702faf8c96d207cf1659b1173f8858
References: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
        <CGME20221229100413epcas2p34c702faf8c96d207cf1659b1173f8858@epcas2p3.samsung.com>
        <1672307866-25839-2-git-send-email-dh10.jung@samsung.com>
        <4c779562-37d2-4bd3-bb02-41b943d7ef9d@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------3fo7lev8HRxwEdfRbJiPjGY7XcYF58l8nMiK-NSEDm8eBp4M=_e4df7_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Dec 29, 2022 at 03:44:02PM +0100, Arnd Bergmann wrote:
> On Thu, Dec 29, 2022, at 10:57, Daehwan Jung wrote:
> > Currently, dwc3 invokes just xhci platform driver without any data.
> > We add xhci node as child of dwc3 node in order to get data from
> > device tree. It populates "xhci" child by name during initialization
> > of host. This patch only effects if dwc3 node has a child named "xhci"
> > not to disturb original path.
> 
> Using child nodes is not the normal way of abstracting a soc specific
> variant of a device, though there are some USB host drivers that
> do this. Just use the node itself and add whatever samsung specific
> properties are needed based on the compatible string.
> 

I've tried to use existing platform drivers(dwc3, xhci-plat).
Dwc3 has host mode and I think it's necessary to have child node.
Currently we can't use compatible string but can just use xhci platform driver
itself. That's why I modified to have a xhci child. It makes us to use
specific properties.

I don't find a better way even if it's not the normal way.
I'm going to talk with other maintainers(dwc3, xhci-plat) to solve the
problem.

> > @@ -86,6 +90,33 @@ static void xhci_plat_quirks(struct device *dev, 
> > struct xhci_hcd *xhci)
> >  	xhci->quirks |= XHCI_PLAT | priv->quirks;
> >  }
> > 
> > +static int xhci_plat_bus_suspend(struct usb_hcd *hcd)
> > +{
> > +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> > +
> > +	if (xhci->quirks & XHCI_ROOTHUB_WAKEUP) {
> > +		if (hcd == xhci->main_hcd)
> > +			__pm_relax(xhci->main_wakelock);
> > +		else
> > +			__pm_relax(xhci->shared_wakelock);
> > +	}
> > +
> > +	return xhci_bus_suspend(hcd);
> > +}
> > +
> > +static int xhci_plat_bus_resume(struct usb_hcd *hcd)
> > +{
> > +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> > +
> > +	if (xhci->quirks & XHCI_ROOTHUB_WAKEUP) {
> > +		if (hcd == xhci->main_hcd)
> > +			__pm_stay_awake(xhci->main_wakelock);
> > +		else
> > +			__pm_stay_awake(xhci->shared_wakelock);
> > +	}
> > +	return xhci_bus_resume(hcd);
> > +}
> 
> It looks like these are no longer tied to the Samsung
> device type, which would be a step in the right direction,
> but I think adding this should be a separate patch since
> it is not a hardware specific change but a new feature.
> 
>     Arnd
> 

Thanks for the comment. I will separate and fix commit msg on next
submission.

Best Regards,
Jung Deahwan

------3fo7lev8HRxwEdfRbJiPjGY7XcYF58l8nMiK-NSEDm8eBp4M=_e4df7_
Content-Type: text/plain; charset="utf-8"


------3fo7lev8HRxwEdfRbJiPjGY7XcYF58l8nMiK-NSEDm8eBp4M=_e4df7_--
