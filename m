Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A885FE998
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJNHc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJNHcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:32:24 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1041B76FB;
        Fri, 14 Oct 2022 00:32:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D60585C00A7;
        Fri, 14 Oct 2022 03:32:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 14 Oct 2022 03:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665732739; x=1665819139; bh=iYvmehNBlw
        06CbCuBOD7St3FUBj4CVVluYujD7ayDLQ=; b=Ep1sOt8A+qbphOkwJNMS+bZLPI
        fEDpw6wWBA0iKtWim8X/cGXLMdxzH9uDxaQeNqmOtXCrfXPx3DXYoI+hgJ0tmx0y
        RVTnV7fN4/91vAfA4uaZHokKX++vPp73iEsHqaHk1jUw3Qyuv6Zz2+HeMgTOj2w/
        tzJSbOqAzefr80yOxvWnlTnjd7L26tMKxr398379T+0MeJyfZyMoYc1fBcG4kWaT
        2RZp/Onca1bJn4ICIhqQJXkjVuygoH25+5zSA7B64mTCpdsYLR7Xb/utpFBrtHpL
        qL1hzHzLsflpqR9kgutHmYrAn/bni9PvxfBiCZWCkjgp7ccRMPIpnmAYa7ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665732739; x=1665819139; bh=iYvmehNBlw06CbCuBOD7St3FUBj4
        CVVluYujD7ayDLQ=; b=VGwd6u0xuftNgTZ8id3L5Cmu4x1grNfv49BGbEcLoSFC
        MpftI5ayl0p/D9AxMHyu57NWqdJlZzRa3ubk+71v1jplmcoRo19QOSM5r+vkh4hh
        qWYajAHaeT4Df2R/l0lKBRBuffHgdG2SwRjil88hNxLhHAj1lIarEvq+eiZzy4bN
        AjHu73YPiMOQxIpr5oyW8bttA8Um5DlMIUKRB1zRY/yRJzfPQxsksf29YGpghAoy
        /AHbCED/8jgEQCOk40nbaL2GGpqyJ8cidTtzZv7wQ1rjs2y5lFUKEq7VjrZhv1Hg
        kaW+YUeGW8Yw8s4mZx3IuALE3CXPWtdY+uZxmytDzg==
X-ME-Sender: <xms:ghBJY8rQQUX89VmEP719Vlga8mGPnIly6_zLHeQmJXF1-VcKbe8Ogg>
    <xme:ghBJYyp-yYxDAFGGI_kbPfy9Da1sDiQF73MnMsQjynnn435wgmGgISPmtGbPWFYGi
    w8UfK3KuAjaDU8dhH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekuddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ghBJYxPMPKv6ivZxtF1uk9-anNwMvt76e7OgfhXmTRHxOkDeds3wiA>
    <xmx:ghBJYz5io2gJQ1k5Q6b-nW7Okh-UaZSuOKWizh4QRqKxI7OBHL5QNQ>
    <xmx:ghBJY75MQOlIccS_xJ_ua4u5VMX6D_PRyl0TjVOQX8z-8RpSXT6sOA>
    <xmx:gxBJY1vfUsQ7_xS9EOI6dAmJGrvGYHEsWZh12MYIJS476czTtYI13Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CF023B60086; Fri, 14 Oct 2022 03:32:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
In-Reply-To: <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com>
 <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
 <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
Date:   Fri, 14 Oct 2022 09:31:55 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "Anders Roxell" <anders.roxell@linaro.org>,
        "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        Sergey.Semin@baikalelectronics.ru
Cc:     "open list" <linux-kernel@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        regressions@lists.linux.dev,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, lkft-triage@lists.linaro.org,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Niklas Cassel" <niklas.cassel@wdc.com>
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006 tag
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

On Fri, Oct 14, 2022, at 2:22 AM, Damien Le Moal wrote:
> On 10/14/22 07:07, Anders Roxell wrote:
> [...]
>>> 8)
>>>> If reverting these patches restores the eSATA port on this board, then you need
>>>> to fix the defconfig for that board.
>>>
>>> OTOH,
>>> Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
>>> device failed to boot.
>> 
>> I thought it would work with enabling CONFIG_AHCI_DWC=y, but it didn't...
>
> As mentioned in my previous reply to Naresh, this is a new driver added in
> 6.1. Your board was working before so this should not be the driver needed
> for it.
>
>> However, reverting patch 33629d35090f ("ata: ahci: Add DWC AHCI SATA
>> controller support")
>> from next-20221013 was a success, kernel booted  and the 'mkfs.ext4' cmd was
>> successful.
>
> Which is very strange... There is only one hunk in that commit that could
> be considered suspicious:
>
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 9b56490ecbc3..8f5572a9f8f1 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
>  static const struct of_device_id ahci_of_match[] = {
>         { .compatible = "generic-ahci", },
>         /* Keep the following compatibles for device tree compatibility */
> -       { .compatible = "snps,spear-ahci", },
>         { .compatible = "ibm,476gtr-ahci", },
> -       { .compatible = "snps,dwc-ahci", },
>         { .compatible = "hisilicon,hisi-ahci", },
>         { .compatible = "cavium,octeon-7130-ahci", },
>         { /* sentinel */ }
>
> Is your board using one of these compatible string ?

The x15 uses "snps,dwc-ahci". I would expect it to detect the device
with the new driver if that is loaded, but it's possible that the
driver does not work on all versions of the dwc-ahci hardware.

Anders, can you provide the boot log from a boot with the new driver
built in? There should be some messages from dwc-ahci about finding
the device, but then not ultimately working.

Depending on which way it goes wrong, the safest fallback for 6.1 is
probably to move the "snps,spear-ahci" and "snps,dwc-ahci" compatible
strings back into the old driver, and leave the new one only for 
the "baikal,bt1-ahci" implementation of it, until it has been
successfully verified on TI am5/dra7, spear13xx and exynos.

     Arnd
