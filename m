Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3751865EF9E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjAEPD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjAEPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:03:50 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516C05470B;
        Thu,  5 Jan 2023 07:03:48 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9E2A25C017F;
        Thu,  5 Jan 2023 10:03:47 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 05 Jan 2023 10:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672931027; x=1673017427; bh=hnKEwU7O73
        Fx9OjQg0uhy4MKVIQ65nRSz3iDfcvUew4=; b=NdNLMsuXncl3ZcBuRKpmlGB7pe
        fawM/kukjCK9fwgq14tVC6UgorHNHBHFxRPVEtyb5pqkQwHv5eBtXD3cbE1qFd3z
        tBSuwL4CtttrPr9/bxIiIF+1K9/+2nf7ebp36QmwWB3B6SJFD+wcPCM6YnFqMpc/
        QAm5R3y/KHNNB4GCekWpLyNK8A7eDj/201vH8vjlYy3io0DtfhK3NQKwluVBDRdJ
        lm9FCUvRWLbxbvvXMrGR6yglrmcipVtVvQ6AaQDDdomFF8vrZX3KZxzLjJVRP7U/
        0B1IhpHxez98+HtoJPVFsIXVMve8dI04UEuKp63fD1mU8Y0Jgu1lmQKVPi4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672931027; x=1673017427; bh=hnKEwU7O73Fx9OjQg0uhy4MKVIQ6
        5nRSz3iDfcvUew4=; b=W42z8JOZL+GZ6s2gnplyMAU4CISGHspBXgKR9bKKLekt
        ttfMFFcpbYNgqTz81lO/XX6tRFr7JeuVTFHb2B0S+DJUw9JPaL7MSOKBgplXe4rH
        P0nnKjxk+W59KGb8J+WAoSn0NchMWeLXg9ymp83JmQ5zg36nkfhCzLeTSkjQpqAm
        fHa4W1JonT9D2cXUQGxjsA3GP3j1U6VJUr1D7TY93PCidTbZaxWArVDPJH5urmN9
        FVjRQyvdk0KNNvAHbtb3H50EGjdv+Ih+DQkRhhiZp8sH0ZHdfJphRfCMefkotbS/
        OddVd0BxCiGzwf3fTjle3V1va7OEspj2vzFS2cxYBA==
X-ME-Sender: <xms:0ua2YxptTPPG5r8hgQ2jBDMB__IJgE8y5E-04AQ8qPbmN23zwYu2PQ>
    <xme:0ua2YzrsfanKcHUlhZISFQwivpac6zWK6jqXJM49l5ktNEkbln9IyDhZBv2pnXPYe
    3SbYv9QAj3AlMtbGRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeekgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:0ua2Y-MIslUJPgQvFIymozcDk48rIuxnJde-US8mqQwozei5MGyv3w>
    <xmx:0ua2Y84m8cDV3VYg0CA0J73qkeWaT2LTN9wkDtEwzlXUxwdmDW5EVg>
    <xmx:0ua2Yw5etnXnzmU6oCHOKcR-u0_aHbh1TX7Nh6LknWxLW_4AXYsKqg>
    <xmx:0-a2Y9tMdzodeDAGNCDNj8UZlJ7Oivf1ZkPDGgBiauZ67vmMxuVm-w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AA6A3B60086; Thu,  5 Jan 2023 10:03:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <ec9aa771-ed7c-44e0-8e8d-f4e34f6f23ab@app.fastmail.com>
In-Reply-To: <Y7bk4ktgGFUpxQLo@kroah.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-26-arnd@kernel.org> <Y7bk4ktgGFUpxQLo@kroah.com>
Date:   Thu, 05 Jan 2023 16:03:26 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Alan Stern" <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org
Subject: Re: [PATCH 25/27] usb: remove ohci-tmio driver
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

On Thu, Jan 5, 2023, at 15:55, Greg Kroah-Hartman wrote:
> On Thu, Jan 05, 2023 at 02:46:20PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The TMIO MFD driver is getting removed, so its OHCI portion is not
>> used any more either.
>> 
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-usb@vger.kernel.org
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/usb/host/ohci-hcd.c  |  18 --
>>  drivers/usb/host/ohci-tmio.c | 364 -----------------------------------
>>  2 files changed, 382 deletions(-)
>>  delete mode 100644 drivers/usb/host/ohci-tmio.c
>
> I can take this through the USB tree, otherwise feel free to take it and
> add:
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks!

I think it's easier to keep this together with the patches
that use the linux/mfd/tmio.h header, so I can remove
that file without getting build regressions in my tree.

    Arnd
