Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4903612D44
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 23:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJ3WMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 18:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ3WMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:12:22 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1AF5F99;
        Sun, 30 Oct 2022 15:12:21 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B8855C009E;
        Sun, 30 Oct 2022 18:12:18 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Sun, 30 Oct 2022 18:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1667167938; x=1667254338; bh=tP
        RsvYKMzoBepXHlPZC3yr8dl6CfTUvt8eIYV/0rQTQ=; b=FBymAW+aSsW+HB70CN
        bRb5MPLPZVZ4YJ439RbOvEYMehw0+MsV+dB+x2RWhjVuHNAgdbQ6nyQ+Y9SA8lzo
        FHeQIu2nDdxzK0m6dFF8EcfgRY5S8gCONh6HpGp6Ovnb4S4MEVXqdEVYXKfsUBSx
        c/Yq24gasaXhZRDZjdmgplHY4+U6I0W3LuGrtUHclpjsQidkRAACcguUp5AQQxBn
        0I1nlZCYkSEm/qdr13P707wKjwNbxhZRv0z6JnSXUjHHPGbPLnezGshjzJYdT/TQ
        HMApZL9nR+B6FW0Z5ZBZRVI3TCIQlxYPZLeBnQrZZ7D9tCKnqp/nRxZEutK4mw7A
        iBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667167938; x=1667254338; bh=tPRsvYKMzoBepXHlPZC3yr8dl6Cf
        TUvt8eIYV/0rQTQ=; b=d7woH4IBlKG8Ex38lCqJuyRoGdKZa5RSNfIQw4FyFp0T
        aKfdWvwAOYkCG8vxT2uZW5NBZBm5GwOr6NKEcmoNcbkUSz4HCbryLOMA9dK6qxb4
        dfRf/SVB/T7qqdVsdaJJpK9oUAzwRG2Afr1Ayz7b+X9ogUrceJwkHtWe6hXz8pgT
        wLtTeWhQ9NzLGZyvAzrt4Tw/4ZTqgrJHqILH5H/9C7TExRN69E39oGgyRV/9lh/R
        JtjU7fZexfflFk+tDMLdLxG2tXx8WD84phTojDtteKcUDwEqwTuDM65EHDpHooAf
        guiuVgi7FWPwD3wG/Ewzsu0UC46fRwrUzUqBMRupqQ==
X-ME-Sender: <xms:wfZeY_dVMzTcG5qfeaWjLg5tFGhyr2ic5ZDbElOsDET-XbksBMrRkw>
    <xme:wfZeY1OgwRIpaInCMRAXb2Y49RqqH78PYlDA90x4DSfNl2zyxguHhhdblbSSIDcaS
    XdMdM5JyBbrXqE2SNY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedruddtgdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpeetlhhi
    shhtrghirhcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrf
    grthhtvghrnhepueekffekhfejteehtdeigedujeevvdfhjeelkeehfefhudffhfejgfej
    ieehhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:wfZeY4gtYLCaJiJW42_6zacZ8WwnkdttyqNOBLEIVc0ukSbZpgFS9g>
    <xmx:wfZeYw__HrCvlwZZ9T0wQycrHqe7iPLRpEOzj0WHTjV6hWnKNlPOxw>
    <xmx:wfZeY7vXcTakZuAmdm_qhuwkzJ3QGXuEfxrkkiCaOus8lFqRwzuOCQ>
    <xmx:wvZeY0U96z2emaCqSwRcLQcCOWzE4KAE3ayAa2Z8I1RWtPU2_Eyx4w>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D6EFF2D40074; Sun, 30 Oct 2022 18:12:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <87cab9ba-883b-4275-8170-12b525399751@app.fastmail.com>
In-Reply-To: <20221031090904.7ce6ca3c@canb.auug.org.au>
References: <20221031090904.7ce6ca3c@canb.auug.org.au>
Date:   Mon, 31 Oct 2022 08:11:57 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Shawn Guo" <shawnguo@kernel.org>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the imx-mxs tree
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

On Mon, 31 Oct 2022, at 8:09 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the imx-mxs tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> arch/arm/boot/dts/imx7d-remarkable2.dts:26.15-44.5: ERROR (phandle_references): /thermal-zones/epd-thermal: Reference to non-existent node or label "epd_pmic"
> 
> ERROR: Input tree has errors, aborting (use -f to force output)

Sorry, that's completely my fault. Apparently I had a local change
that didn't get committed. I'll send a new version of this patch.

Alistair

> 
> Caused by commit
> 
>   b725fda78895 ("ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a")
> 
> I have used the imx-mxs tree from next-20221028 for today.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
