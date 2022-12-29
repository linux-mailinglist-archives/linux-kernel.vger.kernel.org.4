Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC70E658DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiL2Oob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiL2Oo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:44:28 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50C712AEA;
        Thu, 29 Dec 2022 06:44:27 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 81A23320051E;
        Thu, 29 Dec 2022 09:44:24 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 29 Dec 2022 09:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1672325064; x=1672411464; bh=JTZgLSlIIO
        qenxEyLqfYo+J6+xlLVEFKuOuTUw7iSWE=; b=DZTPZthcZYu1YEUlH1zU3pVIG3
        RzyI9Zm0zpIAOe8fvCgTm13UsUnNFGXVWZXfN9XFrY9emstyy746EfdppTH+rs1K
        nESO87lyUky4GtWjyfgb6xdqrRGJNJml423z04OqR1uzFVIeDeyBhKUmjPRrg2Lm
        X1GCZd3LrJmjG7qmnq9Qcd+pcs/dqMT6VO7QDWV3R5oElO2eZPLQe95HEEFil1Yo
        PBV2Ymm1IsZh2yE44klgHvNdQcteYWGMOKgqP/WCtXoy9tlO/bz4UFxFny50ZsEg
        5GE1mvcf+qA6tezCydHEGd4T8lGlTyTw/uf+6JH9JvZin2zKKNYXp0HoV8BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672325064; x=1672411464; bh=JTZgLSlIIOqenxEyLqfYo+J6+xlL
        VEFKuOuTUw7iSWE=; b=bLSbDrHhS8mDxk5E+B4reyFQ2TvYVxi2YOEZKLDx/AZ5
        7a/E+YLSbCqWeK4lJZ8xVdlbhpdry5H/Cmn2ek0DtLS9cZ6N+NmRjHW8P57u5nHz
        9JhKqmqL3tJ8IZ3C3luaDV+YvLeup/A+xeiTQj0nKdyrBzz3lh2kUmPMJVt+q+xu
        bfcYL3CIOI13yE1U30yVcocSYlRWEaxreEJiDC48eVPYqPbn/eCFQg5Igv9GpEX5
        KiF08DMezFHcecNODfsIjyy/nm+o2UGYiS0Ncvc5asuTfgZtM7LbBnIsYG16kJRT
        DPZtEjhxLndbXccqH1yAEmnymf9P+MXl78JciTR2kQ==
X-ME-Sender: <xms:x6etY4Ct9AFWXGC9nEQtP26zZAncySJfT1MfpLpaTzqymEPMB4kP-Q>
    <xme:x6etY6j7BOMcFbWpYIZT8C_Bw8tHiTXcKLYpocF-aAP8yAFhfXIh4cnunxYeTuXcp
    UjRuviFusDfeSgGpZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:x6etY7lueMmwiP7xJPHL13jyILA21u7gCw-emD34a2rA1lMjCj7I-w>
    <xmx:x6etY-zGMMELoPCgcBp6AdiznVmP8rEO_tKyuHS3YaRscHN6LPC_3g>
    <xmx:x6etY9R-UFq5lpUObbZt8oZ4sWF6dqh3-vO2Mh-9QVu86z4GX_0mwQ>
    <xmx:yKetY9Z4C58471U1lsksfQ1qQwEmOVEjo1TuVIG0tv7aRa24A2zkzw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 60BDFB60086; Thu, 29 Dec 2022 09:44:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <4c779562-37d2-4bd3-bb02-41b943d7ef9d@app.fastmail.com>
In-Reply-To: <1672307866-25839-2-git-send-email-dh10.jung@samsung.com>
References: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
 <CGME20221229100413epcas2p34c702faf8c96d207cf1659b1173f8858@epcas2p3.samsung.com>
 <1672307866-25839-2-git-send-email-dh10.jung@samsung.com>
Date:   Thu, 29 Dec 2022 15:44:02 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Daehwan Jung" <dh10.jung@samsung.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Thinh Nguyen" <Thinh.Nguyen@synopsys.com>,
        "Mathias Nyman" <mathias.nyman@intel.com>,
        "Felipe Balbi" <balbi@kernel.org>
Cc:     "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
Subject: Re: [RFC PATCH v2 1/3] usb: support Samsung Exynos xHCI Controller
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022, at 10:57, Daehwan Jung wrote:
> Currently, dwc3 invokes just xhci platform driver without any data.
> We add xhci node as child of dwc3 node in order to get data from
> device tree. It populates "xhci" child by name during initialization
> of host. This patch only effects if dwc3 node has a child named "xhci"
> not to disturb original path.

Using child nodes is not the normal way of abstracting a soc specific
variant of a device, though there are some USB host drivers that
do this. Just use the node itself and add whatever samsung specific
properties are needed based on the compatible string.

> @@ -86,6 +90,33 @@ static void xhci_plat_quirks(struct device *dev, 
> struct xhci_hcd *xhci)
>  	xhci->quirks |= XHCI_PLAT | priv->quirks;
>  }
> 
> +static int xhci_plat_bus_suspend(struct usb_hcd *hcd)
> +{
> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> +
> +	if (xhci->quirks & XHCI_ROOTHUB_WAKEUP) {
> +		if (hcd == xhci->main_hcd)
> +			__pm_relax(xhci->main_wakelock);
> +		else
> +			__pm_relax(xhci->shared_wakelock);
> +	}
> +
> +	return xhci_bus_suspend(hcd);
> +}
> +
> +static int xhci_plat_bus_resume(struct usb_hcd *hcd)
> +{
> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> +
> +	if (xhci->quirks & XHCI_ROOTHUB_WAKEUP) {
> +		if (hcd == xhci->main_hcd)
> +			__pm_stay_awake(xhci->main_wakelock);
> +		else
> +			__pm_stay_awake(xhci->shared_wakelock);
> +	}
> +	return xhci_bus_resume(hcd);
> +}

It looks like these are no longer tied to the Samsung
device type, which would be a step in the right direction,
but I think adding this should be a separate patch since
it is not a hardware specific change but a new feature.

    Arnd
