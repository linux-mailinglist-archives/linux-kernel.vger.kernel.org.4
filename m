Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934D05BA721
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIPHA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIPHAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:00:20 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB54459B9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:00:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 109575810C7;
        Fri, 16 Sep 2022 03:00:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 16 Sep 2022 03:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663311606; x=1663315206; bh=Jy5IMsflTG
        UOnBMaDBoxhuUXVOkL2vtNuhacCgu+FE8=; b=gkEGluXcYFL0nhK5fZWtlvW2Co
        GkDw8cJ/5L7Tww0Na4mf+SkYqTzQ7Y4uLGjA3hsfSpkp87p0FCA/LPmCo5/xBOvF
        P9oAKssi/Uua2YuBy4RxQrnUSP5jQNDpnUfMGB+kZWd92nFa4ArE7RywpGo8POsF
        aWU9/xLdacLVLns/dvwniVbwsTxoDTOlycyJjyAf4aTPbEMDs7nkbdafHBKaTfcF
        rd+LSak/nD11+4vJIDjYh23KEqwJi6YTCF376xz7QZmO3ARUqTLG3pTwXCmQI9BZ
        NcDCMId9vIsvSM0w/FEQZnJbLgr9/+nEY7eKjo8CLfzWYDsG61hE0EdbC5+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663311606; x=1663315206; bh=Jy5IMsflTGUOnBMaDBoxhuUXVOkL
        2vtNuhacCgu+FE8=; b=q35jvGMb2MoJLxxi99r9DET3u0O2eYwi4oTvjo0GToLQ
        COgOJLOriKnEJevrz6UbGcCxh4MtzPwmn2NQSo5nJteI307nsuGhE7u1nuXvFKES
        8/9XBNKe0EFtO9kfvPhRyro9ZF7EalmWdlj6+z8Vr8KuPJUDHiNPQb/RS5mnAeVW
        kgpKHrQaQabOI+kJhR2BDq88FwsrE/vM+TUQdjn6TaK/P2qUbgkcPfEqfT1IQBND
        GkWCIo0OPL3eddxtoE/H89jt8XhG3kdltktEDJvUPk4+haXFHql9svhL+KCzWW/t
        v+rxyYKbmba7o18KlBsu72WXkvpfKvFQZznbf/bN4Q==
X-ME-Sender: <xms:9R4kY4UbWDLXcjRQWWj6-3tiDr0Tt7sMXu-DL8qP1wNeL-C5KgRnYg>
    <xme:9R4kY8lRz5Sg55oqNFYL-mZbNaKHfF-dzbOsTxdaTBYK4adNFEsF_KGO10fleY54w
    Ww_S4tP4IRKv0eIGmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduledgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:9R4kY8bAbEqIRe0UEYzG9nnA8o2XKstN5Am6XSEfbcz4CMxqR9IJOw>
    <xmx:9R4kY3Vk6xR_sZhA-uEv5ONLT-K-zVhoPibika9WEk1eVefDV7hwJA>
    <xmx:9R4kYymomrIVQCtpsk7mbaOPTyuQlMilbvxmIddy7XVybQYQCLHXbw>
    <xmx:9R4kY2up_DA1hV9ls43b4eXH9uVVSo_OCYja5J8Nvf7gtwPec3qXHQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A80E1B60086; Fri, 16 Sep 2022 03:00:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <d28d59c1-1ed0-422b-b749-0082de05e7ee@www.fastmail.com>
In-Reply-To: <20220916050006.GA188273@ubuntu>
References: <20220916050006.GA188273@ubuntu>
Date:   Fri, 16 Sep 2022 08:59:44 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Hyunwoo Kim" <imv4bel@gmail.com>,
        "Lubomir Rintel" <lkundrak@v3.sk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: pcmcia: scr24x_cs: Fix use-after-free in scr24x_fops
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022, at 7:00 AM, Hyunwoo Kim wrote:
> @@ -298,9 +300,10 @@ static void scr24x_remove(struct pcmcia_device *link)
>  	cdev_del(&dev->c_dev);
>  	clear_bit(dev->devno, scr24x_minors);
>  	dev->dev = NULL;
> -	mutex_unlock(&dev->lock);
> 
>  	kref_put(&dev->refcnt, scr24x_delete);
> +
> +	mutex_unlock(&dev->lock);
>  }

This appears to introduce a new use-after-free, when the kref_put()
frees the 'dev' structure and you unlock the mutex in that structure
afterwards.

       Arnd
