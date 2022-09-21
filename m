Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5585E541A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiIUUCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiIUUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:02:08 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066D79E2E5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:02:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 15531580ED1;
        Wed, 21 Sep 2022 16:02:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 21 Sep 2022 16:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663790525; x=1663794125; bh=oGGXYEkeSg
        3udg+6b8awJgLxB8TPBETarCs6k+G1+dE=; b=o68in3Kjh7MI13xwjSJzVX2N1H
        nus8OAK2keiPAYRkx5f4wPJ5Ntw4T2JQJyukk6nsk9sav7wAcx3TR/jRoThLzl8q
        rQOBjU5wDKFignAbp/J0ZzW0B+wgSGSFP+QtMmzsVcy5kSc3NNoCQABegIFrQ8FW
        2R+xhGDIdxnG9YvJqpviSBEk9Op3qmPdQWF5OyvmnkTLhKaCNB46VC/3AlWIUrq+
        8jPhIYMzd7vuBQ2+VnUceZiC0DzLHaUV+dBWSuTXjC1r7fNHuIP1XCsV6/qOBuvB
        BkpUeLFAAI8ON9lODjtuBN6cggSn4BgBjU1L/hKMSmw0lmzwCyBRb1KDjmqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663790525; x=1663794125; bh=oGGXYEkeSg3udg+6b8awJgLxB8TP
        BETarCs6k+G1+dE=; b=W17627AYzgkG2rEklMQXw26R9M9DFKT66rBhBVyNS9qb
        QwWzMmYGezQJwv9rSSbRIL+hKmVMI/OBApy9SyUwigizS3CMoF06lSoSuX09UMZp
        hOnTGmuuWanIB6UA8Kq+NiXTTiPx4xudx8U78m5ihKMLIVv4uCOa9F02K9rLbxpw
        BmeaY8iS81Yr1PqFXsTNbP1TqHzhgsj1APjzEAJGR3N3bJAaenncQUFrcrgtJOsL
        ogElERsIvTnbXJV8AuA0MuFftWBkY4UUD128slNhqQmY7M+AjDoQ3UxWD13FO60/
        uMI8k1YiDbIkSqjXZj4oLcUOSeE4IIW1ek+O9fiWgA==
X-ME-Sender: <xms:u20rYyEptQqZlODHJrBemwVZNCEeRzTYLkZ2R0-tDecJcRmdgIp-Rg>
    <xme:u20rYzVFeCLLTxz_UTtjtI-by0Vm_lU9wJo_I3b32eYVV6edQtd23ZDkx9qRflbY-
    QmCkp9it_QyelsaCH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefuddgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:u20rY8Jtn3Waw3Hn9zNNTRHDGOfli8_RDQJ565DK-xCk-vLDmi95qQ>
    <xmx:u20rY8FzOQFioJyCGOVTGsmRHnTIyjYcJqD5BTy8QX-GeHwhqj9QLw>
    <xmx:u20rY4VzpXNN2kZFwU2NRUBF2Ukqg15v-0ex4nPColwA9uJghBxTDA>
    <xmx:vG0rY_TaPAPa3vGrf73xn9NrsfBHKgz9uKLB3MS6JTowu4qUt_-XPQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A8F19B60086; Wed, 21 Sep 2022 16:02:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <b7e5ebb4-0de8-4958-9bc4-fe06ec4c3635@www.fastmail.com>
In-Reply-To: <20220921183807.241e2518@xps-13>
References: <202209210641.MziHAbW7-lkp@intel.com>
 <20220921104002.226ff3f6@xps-13>
 <ffde44bc-d4ae-4052-c60c-35c8775a5101@sequans.com>
 <7074197c-aa8d-f763-cb0f-03ea5335b923@sequans.com>
 <20220921164720.6bbc56d5@xps-13>
 <ef9a2618-2dd0-4d1b-b9d2-37d59506f004@www.fastmail.com>
 <20220921183807.241e2518@xps-13>
Date:   Wed, 21 Sep 2022 22:01:43 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     "Valentin Korenblit" <vkorenblit@sequans.com>,
        "kernel test robot" <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:nand/next 11/31]
 drivers/mtd/nand/raw/cadence-nand-controller.c:1893:4: error: implicit
 declaration of function 'ioread64_rep' is invalid in C99
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

On Wed, Sep 21, 2022, at 6:38 PM, Miquel Raynal wrote:
> arnd@arndb.de wrote on Wed, 21 Sep 2022 17:49:11 +0200:
>> On Wed, Sep 21, 2022, at 4:47 PM, Miquel Raynal wrote:
>
>> - every architecture should provide readsq()/readsl()/readsw()/readsb()
>>   these days, regardless of CONFIG_GENERIC_IOMAP. If x86 does
>>   not have that, we should fix asm-generic/io.h.
>
> ARM does not seem to define readsq/writesq. Should it be fixed?

64-bit Arm should get it from include/asm-generic/io.h. If it does
not, this should be fixed. 32-bit Arm obviously cannot define them
in a generic way.

>> - CONFIG_GENERIC_IOMAP just means an architecture uses the generic
>>   ioread32_rep() style wrapper around readsl()/insl(). On most
>>   architectures (not x86), insl() is implemented as a wrapper around
>>   readsl() itself, so readsl() and ioread32_rep() should be identical.
>
> Ok. But if CONFIG_GENERIC_IOMAP=n (ARM, aarch64, x86_64),

x86_64 has GENERIC_IOMAP=y

> ioread64_rep is then only defined if CONFIG_64BIT. As it is based
> on readsq/writesq() and those must be defined (as you said), I don't get
> why the *64_rep() helpers are not defined in all cases. Maybe because no
> 32-bit system _should_ need them? But then compile testing gets more
> difficult.

Both readsq/writesq and ioread64_rep/iowrite64_rep must be defined
for 64-bit architectures and cannot be defined for 32-bit ones.

>> - For a FIFO, you cannot use readq() but have to use __raw_readq()
>>   to get the correct endianness. You cannot use this for an
>>   MMIO register with side-effects though, as this needs the byteswap
>>   and the barrier in readsl().
>
> I'm not sure about the true definition of "FIFO" as you say. I guess
> you just mean reading from a BE device?
>
> In this case I guess we need the barrier+byteswap helpers.

The difference is that a register has a fixed length, and gets
accessed with a device specific endianness, which may have to
be swapped if the device and the CPU disagree.

A FIFO register is what you use for transferring a stream of
bytes, such as reading a file system block from disk. The
first byte in the register corresponds to the first byte in
memory later, so there must not be any byteswap while copying
to/from memory. If the data itself is structured (i.e. an
on-disk inode or a network packet), then the byteswap will
happen if necessary while interpreting the data.

> I don't think this is actually what we want. My understanding is
> (Valentin, please correct me if I'm wrong):
> - on ARM: we will always use 32-bit accesses
> - on aarch64: we may use either 32-bit or 64-bit accesses
> - on other architectures: we only want to compile test
>
> I believe what Valentin wanted to achieve in the first place, was to
> use 64-bit accesses when relevant (otherwise it does not work).

The width is read from a device specific register at
runtime, it is not related to the architecture you are
running on, presumably this is hardwired during the
design of an SoC, based on the capabilities of the DMA
engine:

        reg = readl_relaxed(cdns_ctrl->reg + CTRL_FEATURES);
        if (FIELD_GET(CTRL_FEATURES_DMA_DWITH64, reg))
                cdns_ctrl->caps2.data_dma_width = 8;
        else
                cdns_ctrl->caps2.data_dma_width = 4;

This usually means the largest access that is valid for
reading from the FIFO, but usually smaller accesses work
as well, just slower.

     Arnd
