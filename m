Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E97693EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBMHF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBMHFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:05:24 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1860C147;
        Sun, 12 Feb 2023 23:05:23 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 36FB732002FB;
        Mon, 13 Feb 2023 02:05:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 13 Feb 2023 02:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676271921; x=1676358321; bh=DBQVAebrmI
        WqlhZBhjundCNnAZEyy9IeLdHeIoP2zeg=; b=XgxmjIgd/jTQJtiYkdG5myJwk9
        6R5wRp+yTL79kdAj1RAfi5jto+Qi44ilhcJTf/FQsDT6/ZpfP/rGJUrt8BIONBTB
        yHZW4YCoASiVrHCG+xwugvORHurnqqt42ZBtdZnh7g4FAytRstSq2DxL3ZIU9ZBc
        cZ+SQkXWuxoMybRvhK5LkpxqZ7RuELLMotRgP3QQwSQcsQPjHwj59rSVknP5O8qK
        Z1N7Z47w9k4U0Csl1MkV3grSlph+qAPWHd2B47s92XCwku2Q1aMD1U7/v/mFiXlH
        K+uuQo4gi1ywK5nqrBgrAzU9+C+YTpQ4dGPXBg9weJ0K+1qRxE6sUDQ2meeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676271921; x=1676358321; bh=DBQVAebrmIWqlhZBhjundCNnAZEy
        y9IeLdHeIoP2zeg=; b=pVQIOmIB+Dx7O3NbOj4r4jzWDo68I6L6Hl7vI/lfGvIt
        WQpal4QZXv542k48sjP6yyz7a/bKizVHlpOT8OHoMBXQngBtxQzIdJZ3Qozk3z/B
        TMavyep7v187Nv5Tg/2SiPwtDuu48ceOSKHPtJ55iF6wGM2usY4Kf0JEVLmQoUAt
        Jrrjk6K1TcynfAMahK0jlXhrTeYAeNyouBO8frOmWbWIPesr5Hgbg75SNaQMTPz6
        rHYDKQQx3Ba3U+/Fkb/OGlnIi/urJt6SazHWF3/yocf4xK/w5HuxJphPUm0tVH94
        jInh74KIEl9OeSOS6a3Sdx26hg3FJ9MxAygKecbz+g==
X-ME-Sender: <xms:MeHpY2FdF_FSe8PdPNu3CXYCQrL5Kne5WK-aSlnPWxRXTbgM5IP8-g>
    <xme:MeHpY3UEOiAxNx7wTd-kZQ4ubK9L8IJNnAdPhGEPKSvVs5bBKedBk40tifziyJFyK
    wMEQp5l2oUSPw>
X-ME-Received: <xmr:MeHpYwJc8WHDBGJ95IEzKgvuk8twKP_RrFGphn6ci3TmM2u6TTg_jiwify540_1-6-C9cD7VwilhB3qHm0XQQnX7dx7EWS-O4dVb2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeitddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:MeHpYwFlKV-OEhf62ZiJVfem7_bWuVVT7659wDEyOhrVbxw2z6IhHQ>
    <xmx:MeHpY8Wrjuzw3kahjZvWEkf9WG23NwXWr7UFqM1T4P8jnGJi6hYpMA>
    <xmx:MeHpYzO9lJeXY45-23pCUAtIQmC2pHcv-ap5XizVaTNIGqX4Km43tg>
    <xmx:MeHpY9v7om47ElUe0dt5GOBluu2Mpd6A6u5ij3w9mMyis0NcQrKRUA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Feb 2023 02:05:20 -0500 (EST)
Date:   Mon, 13 Feb 2023 08:05:18 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: Re: linux-next: manual merge of the staging tree with the v4l-dvb
 tree
Message-ID: <Y+nhLqlblKqae87H@kroah.com>
References: <20230213131318.2fdaf4fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213131318.2fdaf4fa@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 01:13:18PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   MAINTAINERS
> 
> between commit:
> 
>   ba47652ba655 ("media: meye: remove this deprecated driver")
> 
> from the v4l-dvb tree and commit:
> 
>   eec8ccab1b57 ("most: add maintainer entry")
> 
> from the staging tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Fix up looks good, thanks!

greg k-h
