Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7849A60FA1F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiJ0OIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiJ0OIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:08:44 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554091187B1;
        Thu, 27 Oct 2022 07:08:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BE1345C00D4;
        Thu, 27 Oct 2022 10:08:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 27 Oct 2022 10:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666879722; x=1666966122; bh=iCtPu1jp0I
        wdJMYxxdjgBYCTltAD023MDCiowAfRTN0=; b=tMEWO0Zl1UM+bVWVu9dH/h+uqX
        iIXiI4j0c0j1KS42QF0jOlIoZUd5LKmFZz6zrmjNMs0Uc3/6tgBryeA4uKaQhZpG
        u52MmaABZTdFpHpLNnHm/O0zA9hV04leGYvdMYzO9/meG4+kxLPE/iXXx65emUdq
        zHzOjJR53mel7bOMDVPDEXaH/gBKedBdmsHGujNIapsce34pKojUZr+fVk8tusoh
        FFgz9FbdcZWpfqeCKcyr0kOjqNngtUNa4Tf/JHpKV38nK4edxqWG/UQ8IaS4PGK2
        Vnu1lX375HnfXYJVzDVDvLDRQY0A3Sb5TeJHCd0HZMBex/BiSJVssO3LE+JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666879722; x=1666966122; bh=iCtPu1jp0IwdJMYxxdjgBYCTltAD
        023MDCiowAfRTN0=; b=LvhG6YLgC3Sx2ZjMFu8HNgKZl5wswIxoY87GTJtJ6Qgi
        az0mbD5/RzQ4ubRTSNROHWVNGkf4mWsEM8P4SSMzyR9knwAVgnFhvIfvSCAsEP/8
        dMfP0UkKndKfyOJjIDYZmc/kuEfrVicPmn+ip5fHfcjKh8fDjDLKJnMntQG95Xj9
        nE9kGVblAycz58QevBASqq2SfSu/58qr7PJD/piNOVuqgfuhB4QrWdQUOq0e407G
        9pYwhIxWli4girVfqYdyqvLFiqm675UUWrRYCC8QlSSRkZKhIUSMS3KEJQLN+E3e
        C1cMQn+OiAvKc+Rz1Dcst2XXgCsu0Mv2qCDdpCplbg==
X-ME-Sender: <xms:6pBaY_Ytf-kgllGeYWso320lffZs3ScLwoghznggpxpFtZOhzV-hLw>
    <xme:6pBaY-axL6n9e7j-Uj0vOTuKB53Bh5YCB39bZ3EG8WO_jeYhvoHOjX00LosOHnN_h
    8Am5gymEC_v5lPp64Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:6pBaYx-7i051iGK68ZIZtwn8wnc7YtJEvBpMIVOo6VVRzCujP5j9Ng>
    <xmx:6pBaY1ryE6OmCTW20VX1CVqz3PcVyf6Djb_J1PigrcQXNAbfmUJoag>
    <xmx:6pBaY6rQdg7mxxvSGQ4KYF8eZzt2f1lYdczbPp5WeuEJM3OObYpTKw>
    <xmx:6pBaY7f8iwbGHc0KJoUSJQfYek8UwHb6JrWUJyZnglpHnNc-T7GQAw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5000BB6008D; Thu, 27 Oct 2022 10:08:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <52599d6e-dc16-4186-9fb9-d17ce428fe9c@app.fastmail.com>
In-Reply-To: <Y1Okpjbi2kKU2GFz@kroah.com>
References: <20221022043548.1671644-1-scottjcrouch@gmail.com>
 <Y1Okpjbi2kKU2GFz@kroah.com>
Date:   Thu, 27 Oct 2022 16:08:22 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Scott J. Crouch" <scottjcrouch@gmail.com>
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022, at 10:07, Greg Kroah-Hartman wrote:
> On Sat, Oct 22, 2022 at 03:35:48PM +1100, Scott J. Crouch wrote:

> Nice try, but this breaks the build in a very horrible and strange way
> that no one has been able to figure out yet:

I got curious and figured out what happens:

Without CONFIG_OF, of_match_node() always returns NULL, so
vchiq_probe() returns -EINVAL unconditionally before calling
vchiq_platform_init(). 

If vchiq_platform_init() is marked 'static', gcc's dead code
elimination then eliminates it, which in turn means that
'g_fragments_base' is never initialized and gets replaced
with a NULL pointer.

I think the easiest workaround is to take this otherwise correct
patch but at the same time add 'depends on OF' to BCM2835_VCHIQ.
This is a correct dependency as shown by gcc above, and it still
allows compile testing this driver on x86 allmodconfig, which
enables CONFIG_OF.

     Arnd
