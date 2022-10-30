Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCA4612A36
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJ3Kqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3Kqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:46:31 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EE61A1;
        Sun, 30 Oct 2022 03:46:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1C1B53200657;
        Sun, 30 Oct 2022 06:46:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sun, 30 Oct 2022 06:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667126785; x=1667213185; bh=n2XmmRi1oW
        dp+rLyx5p7iZBFSaHdBnA+sbnpzzjIu/o=; b=kHxfx6FLwhpLwCLvvcJl1huW1a
        M5+5p2APsfRQgIXAPG8iTFpjeR0lVMbQEo9MIXYHimbe7IWQM8b1JBvxHgiOszyW
        U2/kmrLblk9ootpNBOIOI9A7PHoWY6ua8EX1Uc7FDANuS6bzvPwSaJQkzuJegmAn
        V1D2kfyeHU0H6fre5O357EWf6BETNKDiNZKz7yS9AGBncm3UtIkIIWt5Oxtb4Pj+
        Uve1HHIPK9YNX6kELrZOevBkmCnqvYLyfOVpGNIe43VvNAQnmpXLB0II1001t98g
        jUn4rNUPWrhLOjWiEXtiklUVSEFDu5org9/boCLq9vubwNfuDUSgggVm5cLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667126785; x=1667213185; bh=n2XmmRi1oWdp+rLyx5p7iZBFSaHd
        BnA+sbnpzzjIu/o=; b=l/pbJTRu67AWHkdAT/fYSOvOplO36SrkhvMnRY/0aRRu
        IHtkqMfOnpZQfVPcGxDrjKwYng7MVm4vrRUob8Xwgpx+eV2DO15+R0uSP5HsqyCc
        XXOQYG7wcQyKR3LjqYx7KLl7wvlKc5xMXtZsVi3r3odEVxkh/0VOBH1ZvZSh4DRV
        u5/km4//TTNBGMT+RzDNSpHZ0NOJKb7vmwAIdGSBSbrHZ1WTw3XAHUic6zB2tIGM
        SmYi1QcomFuj4kEH5Ebc9FEjYxiwKpMLODX9XKRgGmqjvs1XS7xqtuEHoci/zkff
        bKALmrdO2q6BRAkR6qvYBdVzKEFCQVuFf+Z823poUQ==
X-ME-Sender: <xms:AVZeY34mlCzAfKvPy0zl_OsXEIdYmGRSBxkkBYK1liZjqCQb4WVF4w>
    <xme:AVZeY86zxx1RYW9dDUgFLCxXXJuVK8LA3s4GVyBYJBMLvaG1d6pINtYaQZn1kGlQZ
    1dDpI6LYYY80aM_Opo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedruddtgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:AVZeY-f62naTpk0ykqC4kvjUdJYWLKPznwTeorCmyq27WdQ_RPcCOA>
    <xmx:AVZeY4LKfzxBchnmzvfDhZNwTwdTqaCY5C59oZBrcoSNGTVIttzBnA>
    <xmx:AVZeY7LJdTpKxX6cOe_3jiO5tQAFd-8G3G7uuxwG2CoNzgvGMkR8zQ>
    <xmx:AVZeYz8ncNYP5QM7YaAH8_9qwQO5GwyTMKEBIL84G8sMi0aZp_BhPA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 28A04B60086; Sun, 30 Oct 2022 06:46:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <d64dc0b4-ba82-49f4-9a43-c50b735ad91d@app.fastmail.com>
In-Reply-To: <b874e6ff-6a19-410f-1fe8-2334a58f503a@gmail.com>
References: <20221022043548.1671644-1-scottjcrouch@gmail.com>
 <Y1Okpjbi2kKU2GFz@kroah.com>
 <52599d6e-dc16-4186-9fb9-d17ce428fe9c@app.fastmail.com>
 <b874e6ff-6a19-410f-1fe8-2334a58f503a@gmail.com>
Date:   Sun, 30 Oct 2022 11:46:04 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Scott J. Crouch" <scottjcrouch@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Florian Fainelli" <f.fainelli@gmail.com>,
        "Broadcom internal kernel review list" 
        <bcm-kernel-feedback-list@broadcom.com>,
        kernel-janitors@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq: add 'static' to function definition
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022, at 03:43, Scott J. Crouch wrote:
> On 28/10/22 01:08, Arnd Bergmann wrote:
>> On Sat, Oct 22, 2022, at 10:07, Greg Kroah-Hartman wrote:
>>> On Sat, Oct 22, 2022 at 03:35:48PM +1100, Scott J. Crouch wrote:
>> 
>>> Nice try, but this breaks the build in a very horrible and strange way
>>> that no one has been able to figure out yet:
>> 
>> I got curious and figured out what happens:
>> 
>> Without CONFIG_OF, of_match_node() always returns NULL, so
>> vchiq_probe() returns -EINVAL unconditionally before calling
>> vchiq_platform_init(). 
>> 
>> If vchiq_platform_init() is marked 'static', gcc's dead code
>> elimination then eliminates it, which in turn means that
>> 'g_fragments_base' is never initialized and gets replaced
>> with a NULL pointer.
>
> Good spotting.  Actually, I was clumsily learning how to run sparse on the
> staging directory and wasn't sure what config to use that didn't involve
> enabling everything manually.  But from what I can tell, it's OF_OVERLAY (or
> something downstream of that) that gets rid of the warning.  BCM2835_VCHIQ
> requires BCM_VIDEOCORE which already depends on OF. 

Ok, I see. My best guess would be OF_DYNAMIC in this case, but I don't
actually see how that changes anything in this file (I only looked
at the sources, did not build)

> I'm also confused why devm_rpi_firmware_get() doesn't have the same problem as
> of_match_node() just above it -- it returns NULL when RASPBERRYPI_FIRMWARE is
> unset, but gcc still builds without the warning.

Hmm, I see an of_node_put() between devm_rpi_firmware_get() and the
error check. With OF_DYNAMIC=y, this is an external function call, so
I guess gcc can no longer assume that drvdata->fw is NULL after that,
so it doesn't make this optimization.

This would mean you only get a warning when both RASPBERRYPI_FIRMWARE
and OF_DYNAMIC are disabled. If you can confirm that, adding a dependency
on RASPBERRYPI_FIRMWARE is still the correct fix.

        Arnd
