Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA466F9F27
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 07:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjEHFjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 01:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEHFjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 01:39:02 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635BFA245;
        Sun,  7 May 2023 22:39:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8FDDD3200916;
        Mon,  8 May 2023 01:38:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 08 May 2023 01:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683524336; x=1683610736; bh=IG
        uhB1AfYiLDeTeaCQ/lxK2IkfOy97OVYEZQfyjOyE8=; b=HJd/3ixkuBsg4xH/jW
        HALc0Cwu+ulF/i847SnxtIL6wpmn+wKSZzdrX8COeeTh2pJUr7mjgfjAV/yBogVI
        4H+MkQOCtwBkyOE4wsMxGuf23aS4vq/pDPReE7t/ANoKccMY50tE4JOJTjL2TJcC
        Nv+9xteKpPhn2Hyycya5TYfQ5p6WtWS1xUwn3RkX1PmX1otQ2+3ipgKvz+sIAhfE
        nvqUhveiwgO8JhCS+6vuvF07nuv17pBGeTZrDItsC2kDz8gbFHIUJ6/HmleSh07C
        bLV9GVBQ2lIHunynM9vT5DBXCS9o0V9OXafyBGeOsU3H5P6UeYJVCVADTUir/WTz
        5cdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683524336; x=1683610736; bh=IGuhB1AfYiLDe
        TeaCQ/lxK2IkfOy97OVYEZQfyjOyE8=; b=NhLJsAvdYck62CQOjCB7hCftKFF3D
        d27LqxB91+09qM+pOG4hu4dl7Nirzj0DiNmonJncuYTR5p0jEPrP6thcbFY7P+m0
        rle4a4b7EePpHkIhn1YOSChhwcBYX4hCZbf9PR7z6lZQXlpZy0VF7q36V8Up9Gsp
        GJsChYslLGTNuygxZPMK2R8Lp6eoyixShZP2O0iuAqIVmD8vAoBFrZ8G5EBr+iGQ
        SxzWEWTsltXMJvHZKgNEEtVzXFBtNoM32lRvH+XY03YsUy5nPQ9WPdyaWGhAttyg
        Fpv+//Ds8/ITZ0baNIskmRQyX6xlgbaO/bQPXh/603v7NZAY/GmlkiVog==
X-ME-Sender: <xms:74pYZHTiZBhpNP0D8IKwpg3P1zqobXUMkDV9QgKqZqn6OtKiG_gvsg>
    <xme:74pYZIy_TqlfS6KOkc-7hbVLGu7G3eLU-NfORB8Ni7IgAVCfKysdSGJDuI-aCHeSW
    3OIGGfp0JHWMznmxKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefjedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:74pYZM2uD8uY6FiKh_pinA8SCEg8kyrFeqmU4plDxicr9nnZzWON7g>
    <xmx:74pYZHAHmbzNTBKdTFgwAsFyyIz8ufJbYPOuw-n6Gl3HJI0jg5lMlg>
    <xmx:74pYZAiPWgFd1ktDCeQo_0-DNnzh_H-BUIQc1glhyj3FrWviveLQFQ>
    <xmx:8IpYZLXMX8Pm0PmIE822VPYkH0-qXK_6C84T2hl0zffVLS9EkwGcIw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7E219B60086; Mon,  8 May 2023 01:38:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-386-g2404815117-fm-20230425.001-g24048151
Mime-Version: 1.0
Message-Id: <730b1560-cf57-482a-966b-93b4c51568b2@app.fastmail.com>
In-Reply-To: <20230508040433.13648-1-lukas.bulwahn@gmail.com>
References: <20230508040433.13648-1-lukas.bulwahn@gmail.com>
Date:   Mon, 08 May 2023 07:38:35 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, soc@kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: s3c: remove obsolete config S3C64XX_SETUP_IDE
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023, at 06:04, Lukas Bulwahn wrote:
> Commit 0d297df03890 ("ARM: s3c: simplify platform code") removes the line
> in Makefile.s3c64xx to configure the inclusion of setup-ide-s3c64xx.c,
> with CONFIG_S3C64XX_SETUP_IDE. So, since then, config S3C64XX_SETUP_IDE has
> no effect and any further purpose.
>
> Remove the obsolete config S3C64XX_SETUP_IDE.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Indeed, this was only used on the smdk64xx board file,
so the file was removed along with the deletion of the board,
but I forgot to remove the Kconfig option.

Acked-by: Arnd Bergmann <arnd@arndb.de>
