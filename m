Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797726C11A9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjCTMPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjCTMPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:15:38 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD18927D6D;
        Mon, 20 Mar 2023 05:15:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D9DFE5C0114;
        Mon, 20 Mar 2023 08:15:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 20 Mar 2023 08:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679314526; x=1679400926; bh=OM
        lmLWuV+A/Yqv7Kya9TpEk3g8brpy6OD4SOgUZi1tA=; b=rfXsafTbG3bHnslgsg
        UnfmOzp9WjGAObhwSh5UR9ihVljFkicSK0VfRo5lsFuHJ1YawAEa9pIgco7jcqf8
        bkSw8nk1egZp3T/HTIeYp7H/feQDJHY5jJB4I0u7Rmb00smVZ3BMB6K1kPIQ/44y
        yGmHpLDz8CEs52mcNOhXcA423/lGHl0QOKGjTU9dSnMvH0CG9Q3HjY4gSuN2IdJ7
        lr+4D6fNdj3uyNPr7fQdOfvr+Eapdq5K1Fo2d6qFddvg3CLuFqfuKf864UMNCJ3M
        GNXR/jbUrBsIVr/0jrfrZr4KoRaRpqqoFxzX8DgBubaw65pyxn4DTXeiXw1vw/1D
        JMuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679314526; x=1679400926; bh=OMlmLWuV+A/Yq
        v7Kya9TpEk3g8brpy6OD4SOgUZi1tA=; b=UAQihdlreAMEJvirEJJHqPLyfcZBh
        J9+4fdJgerMhQmBGntkda13EUAOAzY0LlZ0uA4bz1IlpqptLvYIzuleBm3SnLo2E
        LNQLJ5bm9/fmsq3XfRpvQ0B6nllIbzRbeYhnfLzQ5JJzECKwnjoUL4OwnRuUQ9Ap
        M2GgmSTaGGEbyrg2bD6LWEPVxWATq45FzM9ql2vZRfmBNbuqlKJ9e02EW1wbAoyL
        KrYyon2s9rQa7xSJClPPcjsAgqkkzx5Y6ql/hl7++3BmctrylJGovT7Q450YLC56
        LsBh8nPbY9ZpR4xQlYDp4kYGKOvTZE10bsSNywzT905T0mru5EZPSceIQ==
X-ME-Sender: <xms:Xk4YZCPSagn_g6Y-jWUkoL0208HCt46d3QN7XzQAZuJqjPLfyAh6Tg>
    <xme:Xk4YZA8HgVXyCtUKewJ5iduTKdjgsqppzimniUtvBldWGGx2GrPcYClBfvX4ehzTC
    SJNcd3PiKHeWw>
X-ME-Received: <xmr:Xk4YZJTTe89TZFcZ8fSol1tYsucfA6drHqcWSqXsrpf64c1-74JN7vVfdXmqmhFyj0kLJ_dHi9oCVaWCFhKxRCrkXYgYi6ya0u2Lvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:Xk4YZCt6I0FgskdoU338wd4vayx5wLL0g-JlRAslzA0FXwo6Q8guYQ>
    <xmx:Xk4YZKdqxcHMVaEjJ5UcfXjPAjj3cnQshMLvIX39Uryg3aec-6ezdg>
    <xmx:Xk4YZG0Pu4PD2JuQaelJt8VkbdjwDCYtU7sfA5s1ERvefLb8-9qf2w>
    <xmx:Xk4YZLX0B0KWZUNqyNTRauiDE6RZao1Eagluc-NY0Gjtb_Uwlk_2BA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 08:15:25 -0400 (EDT)
Date:   Mon, 20 Mar 2023 13:15:24 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core and tty trees
Message-ID: <ZBhOXGb7ukVyqJD9@kroah.com>
References: <20230320115430.06f26c33@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320115430.06f26c33@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:54:30AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got conflicts in:
> 
>   drivers/char/pcmcia/cm4000_cs.c
>   drivers/char/pcmcia/cm4040_cs.c
>   drivers/char/pcmcia/scr24x_cs.c
>   drivers/char/pcmcia/synclink_cs.c
> 
> between commits:
> 
>   1aaba11da9aa ("driver core: class: remove module * from class_create()")
>   035173c91c6b ("tty: Convert hw_stopped in tty_struct to bool")
> 
> from the driver-core, tty trees and commit:
> 
>   9b12f050c76f ("char: pcmcia: remove all the drivers")
> 
> from the char-misc tree.
> 
> I fixed it up (I removed the files) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Removing the files is good, thanks!

greg k-h
