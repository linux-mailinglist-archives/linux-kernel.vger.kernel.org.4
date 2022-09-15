Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AB75B9580
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiIOHg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiIOHgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:36:22 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A708C454
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:36:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 33E282B05FBD;
        Thu, 15 Sep 2022 03:36:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 15 Sep 2022 03:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663227373; x=1663230973; bh=K2Mo55ZuZo
        DuYpVGQJVvkk6noybttryMgqIosqXqRiw=; b=Y92Wih/2+bjts9Hrml97Z9/bZI
        03+yFyYHirVJMONsPgrWeJkZiWY0rY130iJKH08agcyQPZKmhDncrxCI11TqpOjN
        9V5XOVIGFmaGn1TXLno9Bd95bX5dPC2p7k39EUumaDDk69j0W8UgUalrJtHo17nM
        yQSA4bGfF4ot4mb7aG8mRI8riRyk/0Qs2TOYa6XLQcyBlLoTulvzF91DioNG1wCr
        QA3vN813V/WQFab+Zpz/+GN6iJkQvKR35QxEq0qJCQFPbk4HqB3aQwRoD5CwFqQx
        LlCrXmLkF6g8mIvWIGIJPdx8MG3LfzNVpeuHjl9vxL+yTeJ0GE2osnc+scJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663227373; x=1663230973; bh=K2Mo55ZuZoDuYpVGQJVvkk6noybt
        tryMgqIosqXqRiw=; b=fuppx5dHKICLMoxdh7k7UBOVp8rVq66j7pOxy+1cVzlM
        Gfmlk/80FBoNx7imhDpS50VGZBnQZcqjBVbqFUHTfihohlcHFU9yER0DNnwUfwQu
        kwjCh/WYfSZe9iGd7PwklitZ+yIacU/N7WTASUEiQuuiZgKAjce63idw0G2AuBSk
        hj5/TtkU78T3Q/jCiDm0WsIAH8+tKzKEQL14EMgYoyWGHe7ItxoBy4cxz8Q2bVpL
        HHCXL53LvPieSIXH1NcT1r8kv/d9lFVNh8ohBnRsT9EoCQfEjG9DamDE7IDD7Knw
        lYmuMbCXyRzhDRzJ8zi4Zf9oKnT7uJCCdkQlTWcoww==
X-ME-Sender: <xms:7NUiY9aMpZzx8TZe0vvdYMfElSxAh4gP5hwa-mdenfMK8SPC58KZ8Q>
    <xme:7NUiY0ZXQyAfdFJsFHARCbn1jDn-B4_TwygDLbjHjAPoTJ92-31ijoKnyUt1mdxXN
    0dkwDn183TdG0yW2Io>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedujedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:7NUiY_9k_VyNE7gMWgtZWYIXwC-QYVJvYBLCylLybwYj3dM8lttCUA>
    <xmx:7NUiY7qGmMId1vrBCguRzndmPBWKDorjVB2TLMxYcFuWUT5gNBN9_g>
    <xmx:7NUiY4o9uJ-tqSYFtOwK1DmYE26JCvSIseR6hmjAN0RR-eP3SXxtjg>
    <xmx:7dUiY5fTh8146oRl3R2YpY8JjNgisuo7y0vsccEFYJqLsWA2mMgmAd-Kigc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A5138B60086; Thu, 15 Sep 2022 03:36:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <f41c2765-80e0-48bc-b1e4-8cfd3230fd4a@www.fastmail.com>
In-Reply-To: <20220915020834.GA110086@ubuntu>
References: <20220913052020.GA85241@ubuntu>
 <a8a9fd74-4ee5-4619-8492-be7139e6d48e@www.fastmail.com>
 <20220915020834.GA110086@ubuntu>
Date:   Thu, 15 Sep 2022 09:35:51 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Hyunwoo Kim" <imv4bel@gmail.com>, laforge@gnumonks.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        "Paul Fulghum" <paulkf@microgate.com>, akpm@osdl.org,
        "Lubomir Rintel" <lkundrak@v3.sk>,
        "Harald Welte" <laforge@gnumonks.org>
Subject: Re: [PATCH] pcmcia: synclink_cs: Fix use-after-free in mgslpc_ioctl()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022, at 4:08 AM, Hyunwoo Kim wrote:
> There are 3 other pcmica drivers in the path 
> "drivers/char/pcmcia/synclink_cs.c", 
> the path of the "synclink_cs.c" driver I reported the UAF to.
> A similar UAF occurs in the "cm4000_cs.c" and "cm4040_cs.c" drivers. 
> (this does not happen in scr24x_cs.c)
...
> In the cm4000_cs.c driver, the race condition flow is tricky because of 
> the start/stop_monitor() functions.
>
> The overall flow is similar to cm4040_cs.c.
> Added one race condition to bypass the "dev->monitor_running" check.
>
>
> So, should the above two drivers be removed from the kernel like the 
> synclink_cs.c driver?
>
> Or should I submit a patch that fixes the UAF?

There is a good chance that we can remove both now, along with the
synclink_cs. The scr24x driver is from 2016, but of course the
hardware is much older. The cm4040/cm4000 drivers are from 2005.
My guess is that the hardware still exists in actively used systems,
but none of them get upgraded to modern kernels any more.

Let's just ask the driver authors (Lubomir and Harald) if they
think the drivers may still be needed.

      Arnd
