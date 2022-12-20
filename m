Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787476522E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiLTOlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiLTOlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:41:50 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF585E023
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:41:49 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id AC73C320046E;
        Tue, 20 Dec 2022 09:41:46 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 20 Dec 2022 09:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671547306; x=1671633706; bh=iClaCkki3v
        9TPMge0vG+JPP+v5Fih+a6PrGlURk2qMw=; b=uPvgbxBl+RLNwBRhA3s2XMwpGZ
        adg3K4GH55BD0Uu8mXlm0O8eOfygPTlOCsQxuFjZWdoTsYZWaAzAU74mpnxERt4S
        sFpIuH/dyJUhjn9bKKciqwvGxQ6po+4G9f60Uow5107Rpb8L+SchjQDFGObo0tKr
        iDEJjRXWIGM5B9uaTuD/buHrSX27oacKqn51BeDOEbS9aOHvUbUS0gfZVXYV0jh/
        VAkks0FIjdqjRg5xFX25g0YWxfTEjd029WDiy/k84yWdjAxEUXyCgPAWsxrRqz5f
        BYbLhqLGcMhqtsTbk3tBfVyBR0Cd0reH1oaWGjC6T2hMXTV5K7+tbJjkmLYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671547306; x=1671633706; bh=iClaCkki3v9TPMge0vG+JPP+v5Fi
        h+a6PrGlURk2qMw=; b=MpCozFlq5uZQhmz/uQRiZzbJd1WOFsKMBoeeJ6d+ttTu
        J+LfBtyv2G1SGSW3Gq2dK3Agg3ovKAr4MG0ZV0pnNunWATmOW2SgBB7IdagJ/O3q
        ndEwPeBbPGaDR/3IK6Z7YHA0c7sRnWWAoKUCrM8FCIKqHvIS9pq+vU5H08wwTmsI
        2CeiLdGm7+NTeBk9IOX5VkbmMeReOSo1N6UvEB+l0C9P5AEpMfHYAmQZ3feBL0LK
        TrpADovj8/fVDXjFmHH0jxyMbtopuQOl3GAptgV0izp4PoXUY6DeWwec4DzD5Xnt
        B/PqcaL7mT9t4VohYpeVhu2i10iUM+nJZ3c/WMMdyA==
X-ME-Sender: <xms:qcmhY6RMQ-E6Dngr8oC96y6hvH8r9os_hEgAPgCYO19LzptbPE14-g>
    <xme:qcmhY_wVqYf2HGfZeWnZbtnGfhSh7AcQjRawstDFVnUKlnPiEjHbPNFMF6r3V6QNt
    iSmfbXejq-XjWICUlU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeigdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qcmhY30cb3AK0I4NYjwOGKAQiIGT-xwHsz9gOQSandWRoDwkFRsotg>
    <xmx:qcmhY2DbBqGyDbqvqUwyrub4zc5fj5cmtS4uYLmUNImwvpFf7fSDyg>
    <xmx:qcmhYzhsx3GqcH2D9VS3GG0jhMTnZug0Y7oB5yXuWIE6OXjCc7Td1w>
    <xmx:qsmhY4Z8QQz53oEkfqoZcsuEmLUurIb4_3_XdGuLOVA63RfiBo33uw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7E8C0B60086; Tue, 20 Dec 2022 09:41:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <b543cdaa-f880-4413-bdb0-80e9a94d03c4@app.fastmail.com>
In-Reply-To: <4a378429-9a23-13a2-5837-512823e182c3@linaro.org>
References: <20221215163950.649791-1-arnd@kernel.org>
 <d68c9137-f485-e0a0-dfc3-c72c26d0433a@gmail.com>
 <4a378429-9a23-13a2-5837-512823e182c3@linaro.org>
Date:   Tue, 20 Dec 2022 15:41:25 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Tudor Ambarus" <tudor.ambarus@linaro.org>,
        "Tokunori Ikegami" <ikegami.t@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>
Cc:     "Lee Jones" <lee.jones@linaro.org>,
        "Mauro Lima" <mauro.lima@eclypsium.com>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>,
        "Mika Westerberg" <mika.westerberg@linux.intel.com>,
        "Boris Brezillon" <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: cfi: allow building spi-intel standalone
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022, at 06:51, Tudor Ambarus wrote:
> On 19.12.2022 17:12, Tokunori Ikegami wrote:
>> 
>> On 2022/12/16 1:39, Arnd Bergmann wrote:
>>> From: Arnd Bergmann<arnd@arndb.de>
>>>
>>> When MTD or MTD_CFI_GEOMETRY is disabled, the spi-intel driver
>>> fails to build, as it includes the shared CFI header:
>> The header file linux/mtd/cfi.h is included by the head file 
>> linux/mtd/spi-nor.h so seems the warning caused.
>> Is it really necessary to inculude linux/mtd/cfi.h from 
>> linux/mtd/spi-nor.h?
>> (It seems that it can be resolved the issue by removing the including 
>> cfi.h from spi-nor.h if unnecessary.)
>
> SPI NOR does not depend on CFI. cfi.h shouldn't be included by
> spi-nor.h, indeed.

Right, I sent v2 now doing this instead.

    Arnd
