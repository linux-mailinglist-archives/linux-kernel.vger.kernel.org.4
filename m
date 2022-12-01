Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F7F63EBE0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiLAJC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLAJCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:02:10 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8294531DC4;
        Thu,  1 Dec 2022 01:02:09 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id EBE405C0162;
        Thu,  1 Dec 2022 04:02:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 01 Dec 2022 04:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669885328; x=1669971728; bh=Tr903Ha6Gn
        GkBubWESk087w5xs8HydaDZLktcx+BB4A=; b=dXYCXi+KFlOmGUtP2XGiezXVYe
        GOkuSUaMiwFCI0nevqHRkHxEezGdjE+fK5q2oKUTPfPW+qyJbQmuSGrWSHi6iGo3
        rJU0gv0uMcGvnm6rrT1kdfZmpRQ8qhtfYjBVuzyoxrfTcQ/YfY+QdSQlqeSWECpH
        UKQ+vRurXL3D+j+wLzQuoxfMDUPVBsNsueNdIcu2XJADPrABcBN7GiOXP3Nctq65
        17Z3nX2lnzyn+R2CKkd2YnwDbGxYY1sXHqxZ4qHbbA0uuXKUnyTBYH+nUYkb/pxI
        1NUD6zT7lNXxezrjkkIRynHerlpIvyVZlxNeKFzgA+CbNGKr0zlGsrW4RJow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669885328; x=1669971728; bh=Tr903Ha6GnGkBubWESk087w5xs8H
        ydaDZLktcx+BB4A=; b=ukTsSL5N5FrwOrv4HQKUWAP0huyiaZ9mQ1NuOEws4Svf
        rpk+X1F2qfHkbTNPjd/NgvjmWtPnYdCuT70ASZDVyGqijIqCCOGNQPSG4dz5TLNa
        ZkJVLYYIkArZ+joGaMdEMVGMFAgOnI7j2HD8s9ta/CPk4Tp29rBwsC8JKAYi11jB
        o9nESw5ycTDycCXWg8+7gMxHJsZy3x5c+BYiuVsxgae5TUWmhNcjmv/l+qJ2R2by
        I957Mr2QaGt4vF+GeCotP4KoPPbHy4LxjOpy6zqHbsL5LdXzyfkHo3xWoJ8PHCRg
        nJGDXBdrSeatIkJVU5KAKUHL+bFGAGO2XIRyLhXVXg==
X-ME-Sender: <xms:kG2IYztcelmjp9L5Pb4_-G79Vqefl7YwnYU_-0grOxE1ownT_QWWvA>
    <xme:kG2IY0djUIAkotCXc6xfSURipkuZX9mxYFGVeIKFztccU-Q-zYD8q9Xngp4qrBlHY
    ARALMadoPTb91hWnjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdeggdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kG2IY2xnQOrJOogoEffKIwTFrtRjtFecVoJOAKz5OfCBUK5-pP2UyQ>
    <xmx:kG2IYyN9yt6Kkh-hvHOhHvTVuzUDWMpc6Nm3NvNfzMoY2VqPbXYWXQ>
    <xmx:kG2IYz9-LLvWTWrao7SByxU1SrCiWjmuFiIElVNWvwBWOth8qfKcLA>
    <xmx:kG2IYwg3xpIUF4F5sM2PuvLBWnWCgyezH9MhyPTZ4uSoeC2CnkcZxA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1B769B60086; Thu,  1 Dec 2022 04:02:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <c524cba6-4438-461a-ab05-9325fe09f832@app.fastmail.com>
In-Reply-To: <Y4hgnxGMEuizJumr@kroah.com>
References: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
 <CGME20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7@epcas2p2.samsung.com>
 <1669860811-171746-3-git-send-email-dh10.jung@samsung.com>
 <Y4hgnxGMEuizJumr@kroah.com>
Date:   Thu, 01 Dec 2022 10:01:44 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Daehwan Jung" <dh10.jung@samsung.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Mathias Nyman" <mathias.nyman@intel.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Colin Ian King" <colin.i.king@gmail.com>,
        "Artur Bujdoso" <artur.bujdoso@gmail.com>,
        "Juergen Gross" <jgross@suse.com>,
        "Tomer Maimon" <tmaimon77@gmail.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
Subject: Re: [RFC PATCH v1 2/2] usb: host: add xhci-exynos to support Exynos SOCs
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022, at 09:06, Greg Kroah-Hartman wrote:
> On Thu, Dec 01, 2022 at 11:13:31AM +0900, Daehwan Jung wrote:
>> This driver works with xhci platform driver. It needs to override
>> functions of xhci_plat_hc_driver. Wakelocks are used for sleep/wakeup
>> scenario of system.
>
> So this means that no other platform xhci driver can be supported in the
> same system at the same time.
>
> Which kind of makes sense as that's not anything a normal system would
> have, BUT it feels very odd.  This whole idea of "override the platform
> driver" feels fragile, why not make these just real platform drivers and
> have the xhci platform code be a library that the other ones can use?
> That way you have more control overall, right?

Agreed, having another layer here (hcd -> xhci -> xhcd_platform ->
xhcd_exynos) would fit perfectly well into how other SoC specific
drivers are abstracted. This could potentially also help reduce
the amount of code duplication between other soc specific variants
(mtk, tegra, mvebu, ...) that are all platform drivers but don't
share code with xhci-plat.c.

Alternatively, it seems that all of the xhci-exynos support could
just be part of the generic xhci-platform driver: as far as I can
tell, none of the added code is exynos specific at all, instead it
is a generic xhci that is using the wakeup_source framework.

It should be possible to check at runtime whether an xhci-platform
instance uses the wakeup source or not, and then have the same
driver work across more platforms.

      Arnd
