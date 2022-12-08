Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D486470B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiLHNXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiLHNXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:23:10 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603AB8138F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:23:09 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5A00A3200917;
        Thu,  8 Dec 2022 08:23:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 08 Dec 2022 08:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1670505787; x=1670592187; bh=86NztHs9QVX/n93qJfYm/s7/pby6qjrKy/D
        ct4MFEvM=; b=hI/3Sg1/GdBfxNMFsIa5cqTzUSo210/cc/BCASPSTZpe7XSPovA
        NhrsU/JH61i1otSd+PSr+bh5IQQWEioASuB2YC9ff5xVvQOs5xC/5cTaLyueMOG5
        AFkBx2XPJMfh1G7lUEvrzCIkMgE7C8g2E7J3IY7APBn/0BU4Wrn3I7iMwzDVnrCW
        2bE1w9VOs2RRZXMFlaZj+H3k7UZkLzOILXDPw6vY8ENUt2GDhYmHMuROYXtRhNAE
        CoierpoudtgoLhPmA49givAHfrIIZfV2MRYnDidI+FV2n1+HTNi1+PdBa0gR9GnW
        kvG7e6h1ruxu7x1Smmcld2kijuJQQlDog3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1670505787; x=
        1670592187; bh=86NztHs9QVX/n93qJfYm/s7/pby6qjrKy/Dct4MFEvM=; b=w
        Fd6NpQgsqe+ZhM8kTFTOq87R9Og2Q1craJFjVm4qW3kE0UlUATPxJVFQO9SSBlNG
        js7jg+BZoSDPhIrPV6CW6E5Z5OuFu9v20ouzM2Et2I0F8vjR2FetJdMYwkZn6THC
        tGFTS6Ic1DVyrIGDGL7Psthex2Bg2gpWR6AVUyVDsM/fthPlNWDIAls1ZBnE0ROq
        qlQJGDuuDWhuoThUB9r+eBsb+NMJG2dq11FcIZCIDOrarJi7KSbmShMb+xSw2dBr
        z/OyBaVHw3vxr21SfuUKF5vKQ8F0fy3I59/epJ7aZhzFeX8+MsaF+1xUhjXImq/G
        R7zMFM7CTEn84S5Pa6HzA==
X-ME-Sender: <xms:O-WRY3AzwOM8jZao1owRU5u_6JCBqeCdr26TRJ4yunjFjAp3htA2RA>
    <xme:O-WRY9iiQnoi6BIoM-gnVyqtmyNwo9wITdGlmZPdlvVH_L6_gWoQ3rERNoR6zf1yD
    t1QGV9xZsXn4dNZ8Fk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeeffeeuhfekjeevtddvtdelledttddtjeegvdfhtdduvdfhueekudeihfejtefgieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:O-WRYym-LVNTQ05GPp6HulfGIDRQGldMkjJOJK9lqRK-N-hHYZXsog>
    <xmx:O-WRY5w5AqRgvFRUz9rn9Z98hXGIjBr-N7Zh9Ra97fGlaBq-6IURQw>
    <xmx:O-WRY8RzyHSYprtaGXT5Hl_vGONMQzHGMYgOaZpbVjjJQwf-ZblqRA>
    <xmx:O-WRY3Jc9NhXXCPmN7Av54Ta_1f4B03ZX243PJuaNl_v5Oea1RTsPw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5D4EFB60086; Thu,  8 Dec 2022 08:23:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <c6664af4-7a91-401e-a079-e700e9ff5bbf@app.fastmail.com>
Date:   Thu, 08 Dec 2022 14:22:09 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: SoC fixes for 6.1, part 5
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d:

  Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.1-5

for you to fetch changes up to da0cbf9307a227f52a38a0a580a4642ad9d7325c:

  Merge tag 'at91-fixes-6.1-3' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/fixes (2022-11-29 15:45:36 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 6.1, part 5

One last build fix came in, addressing a link failure when
building without CONFIG_OUTER_CACHE

----------------------------------------------------------------
Arnd Bergmann (1):
      Merge tag 'at91-fixes-6.1-3' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/fixes

Peter Rosin (1):
      ARM: at91: fix build for SAMA5D3 w/o L2 cache

 arch/arm/mach-at91/sama5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
