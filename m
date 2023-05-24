Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0591770EE7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbjEXGu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbjEXGua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:50:30 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E271996
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:48:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A5435C02F7;
        Wed, 24 May 2023 02:48:48 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 24 May 2023 02:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684910928; x=1684997328; bh=rC
        ObM6rn3MR8V88+Rh4tdvCkCcWoIRVeoJwuS+gP6zw=; b=Uh099bochqxpgcnxvl
        oObXU0WyIWjCdVxN4KQQ93zZOAo9/HHHOBwJsn+y2lUEEJYRQnGrRH0tkVEJZPDw
        pkR/ORaecuEKklB3fTgwWNZfJHCycWd10fZTWbIC/pOnWYYUyScZumlsgngm/Y1l
        ARj+x2ilR6e+87sVbAq+XI1pkQw6g+wAXlzR11UOxRy2NPV++0JdElbthy3Inj7E
        ERYF3dAI6+xDrjl3YaQB4GOueOSQP/pxmfV9VIMRoCCFvzUR+14d/oAE6NWsjUsV
        FvkW2NS7b7G2hU1OkqH1xRhsMB/vvrxSeKCUtGMlSqUgx42FWxpQhBvEOT9Ma7DF
        t2NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684910928; x=1684997328; bh=rCObM6rn3MR8V
        88+Rh4tdvCkCcWoIRVeoJwuS+gP6zw=; b=ve+VxQ5ALJ6sr5QMtSz6LD/HmQZ/X
        bYymd9NsROfs84CycvPKIkpw8EeV6ktE01bAByr2x883ZJKrFwlXQxPGuJaEm16K
        2KUNmTFTi1ijw5tKmEYDhNnoGbDUnggPLKjfni/5yEGoWPhCQwOxR2UMGyd+OXCC
        oRSqVbVWhJ6XsrLRFYlyd+THRZ2BIGIx9Fb88mKogQaCsx0KBhjiQhkwTh2CUaKM
        C/tA4rdAflgQP88tQbKjFPtZo66nAyvf+E+QJEp3uGwh1OxtDdU88ELiA7ZZgrlR
        bWPrKeAfjsehasydCNVy7wU5gyrgox+AQ83WhGYtVxLu8OfoYvZ/z9n7w==
X-ME-Sender: <xms:T7NtZDpvV7M2JO1JvL_QijTcBcQZyP1ztibx_fJywSfR3_oBjhW61g>
    <xme:T7NtZNqTlgf5j6NMAcDbCB0jDoO-QF3OfOE17Tp5VXG1H0yvjKx1EV4GOr8LAPZiO
    sT9O0gDi-gb5S-x4sE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejgedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:T7NtZAMoS9QiFWBtFyReUxpb6YExQsTtK-qxUeEf6WtR343BlpoQeA>
    <xmx:T7NtZG4nmqtJLcP2r0LVPDt9TMX-5T_MHb_eIzSbEqYV8NFd91v9Zw>
    <xmx:T7NtZC5iu4ljHdtCs3Q5As__Vx5SYgb0zIZrmSRBa96VEpw9z-P5ng>
    <xmx:ULNtZFJfhM8p6FIy2O_5SeH00RTHv_p1UShT7NpjL56vxn-wXQJmlA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 39B16B60086; Wed, 24 May 2023 02:48:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <b8166ed7-2d3b-4bdd-b597-f0aeddb7ecdc@app.fastmail.com>
In-Reply-To: <20230523212829.2539417-1-otavio@ossystems.com.br>
References: <20230523212829.2539417-1-otavio@ossystems.com.br>
Date:   Wed, 24 May 2023 08:48:26 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Otavio Salvador" <otavio@ossystems.com.br>,
        "Shawn Guo" <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Alistair Francis" <alistair@alistair23.me>,
        "Fabio Estevam" <festevam@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Russell King" <linux@armlinux.org.uk>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Stefan Hansson" <newbie13xd@gmail.com>,
        "Stefan Wahren" <stefan.wahren@chargebyte.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Remove KERNEL_LZO config
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023, at 23:28, Otavio Salvador wrote:
> The KERNEL_GZIP is used in most config and is the default, there is no
> clear reason to diverge so let default be used.
>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

I don't mind that change, but it seems odd to single this one out, as
there are many other options in that particular defconfig that
stick out more, picking LZO seems like a reasonable choice for slightly
faster booting, though ZSTD would be the more modern choice.

If you are looking into cleaning up this file, maybe see if we can
kill off these options:

CONFIG_EXPERT=y
CONFIG_ARCH_FORCE_MAX_ORDER=13
CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
CONFIG_CS89x0_PLATFORM=y # none of these four are in dts files
CONFIG_SMC91X=y
CONFIG_SMC911X=y
CONFIG_SMSC911X=y
CONFIG_STAGING=y
CONFIG_STAGING_MEDIA=y
CONFIG_VIDEO_IMX_MEDIA=y # not graduated from staging after 6 years
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y # select EXT4 instead
CONFIG_ISO9660_FS=m

I have not investigated why any of them were added originally,
so it's likely that some are actually needed.

     Arnd
