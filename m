Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9273F672257
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjARQCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjARQA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:00:29 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10B04743D;
        Wed, 18 Jan 2023 07:57:42 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 873D35C00B5;
        Wed, 18 Jan 2023 10:57:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 18 Jan 2023 10:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674057460; x=1674143860; bh=lhuRRX4nZc
        nfSkbGPlEVZUMLxgtDCIH82Wit+HugQ7g=; b=b2CxJRGEHjEoDWeQlom2JGf8h0
        41l/jbnvkIcudriFcooVZAf0ivh5eOrB9jxtJ4c+NNNQMPN5UnNHExr0rMziEL8u
        OMseJN5bw0h0zN1GYSntmxIf+qZ5zbm8F5GAPrubz9peeepYqaNr+vsJZLhJpw5R
        cryQB2/dfJvjD/vhCD0fPYXYYOR189gXhPein2aVA/QFCVskK2prifNUuQh/oOKs
        W2kP0b+LSTE3P6ViO2IliytcDFZduXUWKHXbTPNKvY4kBroDWbsIRiKt3lrJ9dqT
        9uebUpJokTlr8bCSGAyQF5djz0NRg3EgC8nbhKXFFMZmLECssPKRZhSx2z4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674057460; x=1674143860; bh=lhuRRX4nZcnfSkbGPlEVZUMLxgtD
        CIH82Wit+HugQ7g=; b=UajZseswPDKAE+UaOIX3Vin5eOt/niePhLfhE7A5noZ9
        1BybhBxUMVKV77VBF/FEQWjJZNPUDNbkDXK9iMQVy/bM/lqiNftlg5vOMgYPIm5H
        KgwUmSuIRjYEOniph19An0qv4BIFzpsdW8LHT8eFunMU277bVsIMJUIl668s7Uox
        jh5w8N2Au0xE/5gYS5V031zGKtXvT6duWALKtqd7ALiyPLtuzOf0d9/9qYU7BFm8
        sRE1qGo6Y7IZwPynPeccgY39iV7pXpkkNl8/l62/b/GTHpQlNidHhqbbEc44OolZ
        G0nsQ4WYjRJFVAOO/rDX8XjoQm6pvoGX/Kb++lxeNw==
X-ME-Sender: <xms:8xbIY33Udf-uyeWg3ZiA5d9WCBoGjLnXnzn7imC4uv1lYq6Rd3WhIA>
    <xme:8xbIY2HjRTPxspnDU2Mpb_i2eCHBUzbUJveoPHpJ60zuYVOMLW1QECAEki66mG3Xg
    GbREKbqZ9X4Kj6DL_U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtkedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:8xbIY35O11Hb49zJIS_cvvXeEWc1hSXaS9qxKyHqCvbdQ67uupiHSw>
    <xmx:8xbIY80LPS78JqVfGDLx3rjTBXC4tFb9EQEdTnm-fP9PeOU__eVTGQ>
    <xmx:8xbIY6H412uaG4GizoPDF_SvkMUVuU-fIxCFQ83qYiej0bSqZkMK0A>
    <xmx:9BbIY4bSDn-5hegn3f9WHZKeAc4bBoXtRJzG6E9R2SI3oh8vYZ2FGA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4BBF2B60089; Wed, 18 Jan 2023 10:57:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1187-g678636ba0d-fm-20230113.001-g678636ba
Mime-Version: 1.0
Message-Id: <2f310818-7b19-4c07-9948-d5e413989594@app.fastmail.com>
In-Reply-To: <f045d0c6-0043-8feb-a423-954ce381396d@isely.net>
References: <20230117171055.2714621-1-arnd@kernel.org>
 <f045d0c6-0043-8feb-a423-954ce381396d@isely.net>
Date:   Wed, 18 Jan 2023 16:57:19 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Mike Isely at pobox" <isely@pobox.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Lecopzer Chen" <lecopzer.chen@mediatek.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        "laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
        "Jacopo Mondi" <jacopo@jmondi.org>,
        "Andrzej Pietrasiewicz" <andrzejtp2010@gmail.com>,
        linux-media@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: pvrusb2: fix DVB_CORE dependency
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

On Wed, Jan 18, 2023, at 16:39, Mike Isely wrote:
> That doesn't seem right.  The pvrusb2 module should reference that 
> symbol like any other.  There is no special treatment of it within 
> pvrusb2 - so why is that requiring special treatment here?

The problem is that VIDEO_PVRUSB2_DVB is a 'bool' symbol, not
a 'tristate', so the existing 'depends on DVB_CORE' is not sufficient.

Another way to do this would be to prevent VIDEO_PVRUSB2 from
being built-in when DVB_CORE is a module:

 config VIDEO_PVRUSB2
        tristate "Hauppauge WinTV-PVR USB2 support"
        depends on VIDEO_DEV && I2C
+       depends on DVB_CORE || !DVB_CORE
        select VIDEO_TUNER
        select VIDEO_TVEEPROM
        select VIDEO_CX2341X

but that doesn't feel right for users that don't care about DVB
support.

> Is it possible that dvb_module_probe and dvb_module_release are not 
> exported?  (Or that there are two corresponding different exported 
> symbol names that pvrusb2 should be using instead?)

No.

   Arnd
