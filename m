Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2255BC29C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 07:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiISFw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 01:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiISFwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 01:52:24 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460A913F19
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 22:52:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2BECB580109;
        Mon, 19 Sep 2022 01:52:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 19 Sep 2022 01:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663566739; x=1663570339; bh=lh4UlmlwDy
        FH09vWCOuLpCQb6N9GcsA+rPlgsVFYYok=; b=a/dN70qFxpEtFlFRN0lX6Pv89X
        oaVrpfIkSZAD6bOr9PL/2dDm++GXBESbiGv3cx5JYYhfPdWvlla7QRSO7Uw6jOgl
        udGoqqSs2HY3r7mR0fV+pT46m8rl7qc9xSe+RwHdDsjQZtgh9foDJsslUQUwSnyE
        VThmqUruREeCKtHdmc3THso1BZNh/wttdCszWhYAQ86sLqAYemrkE+AU9r/13t8n
        lKaRqsnp9flZ3TSVHPz3b/YFCxwNl9MMx/pVS3U9jjVZIkgKqKgZltzTqQs0VyvF
        oXNSVpkpdbkxeEd5t6ZtuaoYLV/WPsyf+hhrC5LYg/Q9seBheHO6BRHrgJow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663566739; x=1663570339; bh=lh4UlmlwDyFH09vWCOuLpCQb6N9G
        csA+rPlgsVFYYok=; b=vmHHkWkCFL/SXvQAw0jlJZXOj3DY15eYb8k4Zz87BJvD
        gE6lWPMhCUNnbcXn0s7W/Li35ajTadiTgRS9EI0RsF9RmMn7QGhM2SKKkgbr4Jda
        Uuq6An+/nUH/7Cap6y+zcljEJpUWPEyPtODbTrnp1SQGGQFJuviK45hQka5pWqfh
        ya+fYjjHic4LhN0szEh7We3SowOZjGm5wqJIUTUYx5f64LGPmqpiSFujGU/teSbV
        LduK+U4ZbsdIhq4IbyxS8BQ50zm33LYAG+PWoaUXUP9Ymq2+FHD+390zqexlwpBp
        qHwpb6VtH1hsNPcVHL70awvU0tUi13v2tSCK605gKw==
X-ME-Sender: <xms:kgMoY6BbvhrqkPjO5V2p0EOiiSU1PMR4iRGaQTsggq3N34IyIIkQVg>
    <xme:kgMoY0jf1OhhVoYbXaHo2gJMgzVCjpKcyn4AbxHqYdIwahMbo5vJe_KAefXOZVWiD
    qRc6WPmPf0MKTwaax8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedviedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:kgMoY9kZ_qB5JQg9RYk019pyduaUBx5xcXQzZedtQ1xsHmQLKDj1ug>
    <xmx:kgMoY4xjWR7szNAcXWsLXs-V1wEQJl31e38Q53b0XNKVZh6B3jFFVw>
    <xmx:kgMoY_Tu0qQSWluWIyUlguWPu47dZYfzQhvbW0xF3EV8i3vPOLHkgw>
    <xmx:kwMoY5fITRTFaKqqp15dYZhF5GvQtLSM_LKo-Pp5K6Y68sMd4zN7qw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5CDD1B60086; Mon, 19 Sep 2022 01:52:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <95e9c01a-1523-4187-9d1c-3c84eb875af1@www.fastmail.com>
In-Reply-To: <20220919040251.GA302541@ubuntu>
References: <20220919040251.GA302541@ubuntu>
Date:   Mon, 19 Sep 2022 07:51:58 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Hyunwoo Kim" <imv4bel@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Paul Fulghum" <paulkf@microgate.com>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>
Subject: Re: [PATCH v5] char: pcmcia: synclink_cs: Fix use-after-free in mgslpc_ops
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

On Mon, Sep 19, 2022, at 6:02 AM, Hyunwoo Kim wrote:
> A race condition may occur if the user physically removes
> the pcmcia device while calling ioctl() for this tty device node.
>
> This is a race condition between the mgslpc_ioctl() function and
> the mgslpc_detach() function, which may eventually result in UAF.
>
> So, add a refcount check to mgslpc_detach() to free the structure
> after the tty device node is close()d.
>
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
