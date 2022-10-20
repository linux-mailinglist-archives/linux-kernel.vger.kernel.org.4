Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0251B6057EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJTHJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJTHJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:09:37 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FAC5F9D;
        Thu, 20 Oct 2022 00:09:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 28B5C5C01E8;
        Thu, 20 Oct 2022 03:09:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 20 Oct 2022 03:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666249769; x=1666336169; bh=/t4Z9bLnF2
        xmVdZWXqjDI32xl+lMqj7En+thDsi771s=; b=lIMpDNdoqFyUKUk6mYQoSX3lTN
        6orgtDH9Pr4DQ7xtHsOZUw7vD2XYRHRvJ30OUqUq4o79BM4YjAnKuu1HHZIyNzQO
        snPyXZ2ssUXj/1zpNDAZxC2MBlNn6sEaa11Q/3gl9calJguQjtSwWschdjwp4X2n
        W+gLNNWgMB96FRqmoOQ7PcTkIA3H4cbPhM7Z42XhJJh95zsNCmZNuuKg8Lfi9ogY
        1rKjhjew9Q9YuoScN7GAUhBVD36Wx1XQ8AxtVTEGLX35FryWnjlPIufC+B9qbMle
        73r92SisTBxHXZH/5saNsBt3tpIxgUqcHsNdvUvcaI2DpV5217+l77KT56RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666249769; x=1666336169; bh=/t4Z9bLnF2xmVdZWXqjDI32xl+lM
        qj7En+thDsi771s=; b=Sf+Mp+N7c/eRebH++z/2SsQlzLfjGGIkPeK256x26N9w
        7WrRGU21JMH/P077/FtoAxv6F7UhSrYqR06Lplc8vJeMRtL5ovjdT89GnGGbMp6M
        sekjWfTSvNNwlDOq0YAfZW+cEIst9XYNrNXHxpIRt7hlGszVxPw2Tu207/BWSp8O
        0hAZlhb9XZONWwgbXFg0ohBSK6Q/CTai8x2ur5YKmZi/BzLjeoJJYb6L7qBFoDD0
        Pq2G6jv78bzGf0mfo+wZT5BddTb+71zHqqi7aY8SxDnFhsPWwFeVYHLktwzKNIBT
        kk5JIHCVUhYiuw+Z0RjHUFjYfEAgWVYvis7bGy8WAg==
X-ME-Sender: <xms:KPRQY6DlX3wDnMlw2URek3kyE0iOQY_560U4v4BLotpcLRFNDMMy9g>
    <xme:KPRQY0ihmNTF5k3l-SAAYJTX3FTb66s6FhTJhyphEaX09J-_1JjOsXBHdOP9m4hoC
    0bEkbRn42_ul170S3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelhedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:KPRQY9mzo7tODYnPY9k_l20HvZwEPPPKjW_bMpMXNKjSWK3pqYYxbA>
    <xmx:KPRQY4z1Nzcysc2-vlkC_7KAg8CY4GGpojwM5WTajyQ8nc8neWL3nA>
    <xmx:KPRQY_QYw8rDQ4bKGRlHpHzU6V_TlzPZn1Xh-KCFktqumourUsdiVw>
    <xmx:KfRQY4QNDTPgmGw4Vdm-6Wp6tQk7Q_ayzvep-5pgMy67BCwf1HaJkQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 07EAAB60086; Thu, 20 Oct 2022 03:09:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <e8390747-082c-4b1b-a340-ce5bc1993497@app.fastmail.com>
In-Reply-To: <5780fa6b-4a18-7382-5600-02007f82a1a6@opensource.wdc.com>
References: <20221019152947.3857217-1-arnd@kernel.org>
 <20221019152947.3857217-12-arnd@kernel.org>
 <5780fa6b-4a18-7382-5600-02007f82a1a6@opensource.wdc.com>
Date:   Thu, 20 Oct 2022 09:09:07 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "Arnd Bergmann" <arnd@kernel.org>, "Sekhar Nori" <nsekhar@ti.com>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        "Kevin Hilman" <khilman@baylibre.com>,
        "Sergey Shtylyov" <s.shtylyov@omp.ru>,
        "Hannes Reinecke" <hare@suse.de>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 11/14] pata: remove palmchip bk3710 driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022, at 01:17, Damien Le Moal wrote:
> On 10/20/22 00:29, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> This device was used only on the davinci dm644x platform that
>> is now gone, and no references to the device remain in the
>> kernel.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Great, one less pata/ide driver !
> I can queue this in ata tree. I do have some changes in ata Kconfig queued
> already, but they should not conflict.

I have two more patches coming today: the palmld and samsung_cf drivers.

You can apply all three as they come in, otherwise I'll
just keep them in my tree along with the arch/arm/ boardfile
removal.

      Arnd
