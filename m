Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F010D5F3E4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJDI0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiJDI0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:26:22 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D342B625;
        Tue,  4 Oct 2022 01:26:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4126C5C01C0;
        Tue,  4 Oct 2022 04:26:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 04 Oct 2022 04:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664871968; x=1664958368; bh=nYJIR2k0EF
        yCjWdCxWOh2cI2l/iR85+dfplMtNc6+SU=; b=uSm3C3f0heRtAXDyKjQYiSKp0T
        VynUoKmiBSUCWDvYyddtmZZ5m+r3TQKtmCNkjwwYVbhnv3RhO0qD/utBqOuexcQr
        ozJwpqJnsLak1jxfNt7TbICWCp78vngNQxh+dMm9PsJFRvQqG6ZtC8MkM5ej+BxB
        Rm74lJk/LyQcjM1UvwnqpnCUMNhefOmzPsmxYQ+uqXmspU7R5Mq4Cd/oWxWvdxem
        h++8kVQDAfpj52IGglpUKxB+kzHY78weJfnS3ekc0J3JpbPyYVBRVrXUi19mzetD
        w9z0keMzziGKaEWW07EA657iQ1+aq1Yxgu/9NKd/0KxVjSDZrKliLm+nsOrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664871968; x=1664958368; bh=nYJIR2k0EFyCjWdCxWOh2cI2l/iR
        85+dfplMtNc6+SU=; b=1WzagopDo48qNZsHDL/fknPJp2BbLpu6hkVLr64sacEU
        WdLcqKSq8mgpKfxKOm3BDTfUrcOW7j/5duyltqpWwZxRx57SsotmERU11EfJ2Biq
        AKY7QNNpV8gzNO3y1vazotUugGtO6nablPYGfdAQ1h4GQASEIdmpRuU8x1vOXzAR
        zOCMYtCpPrYDWM1RoF4I5V2r0DNfSHzJaUzZYD93XMWlqzCZDu5slKZjLjAMzDTM
        XmT/6RMjB7q8hWvz7cKfs4xLy1QAUt3cIt0U/WXZF9j36O72VsyOHoEaNawiStKO
        zJ6sR+LjZNaE3HUflCbNQIS37wfItfO8qIFHb98kVw==
X-ME-Sender: <xms:H-47YzLDOa3QLFf1UUDSQh6XDfToXTfl-8IIXfdsXyJb-wSml8uF3A>
    <xme:H-47Y3IkBT3Pl1CcRn9Cm5PJsl6APRH35fbtvi5brqM6PO8hUTynhJmayRUeDYyyR
    3-V-2fmTQLOYg>
X-ME-Received: <xmr:H-47Y7tIZwZoTi1OqtOCPGjvvo1z6bO2mH8iG5abBoUJC__iWgVcwBWBc9RWOexlgWl0APHwO68Uh3BursBas5nZrI7MiEk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiuddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:H-47Y8ZlmQBhlWKRf0f8UKOUHa1EixGKgKJPjGIA1g9SdOEswzVYPw>
    <xmx:H-47Y6b9i9XHwS893jh5Tdvg9LTgEuh699vueDN6SR3pRbjgTIemtQ>
    <xmx:H-47YwDAbPwrTrN5-MQ6kYoBdoIZEdHAI-ZTv5Tk56-xGyb3tagJvw>
    <xmx:IO47Y_NYRk3YP4CvwTp_KaixbjPnIkITvLw9sqWQQP8qYcAZx3QSAQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Oct 2022 04:26:07 -0400 (EDT)
Date:   Tue, 4 Oct 2022 10:26:05 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the staging tree with the tty tree
Message-ID: <YzvuHflMJm6BMHxE@kroah.com>
References: <20221004173354.141e1a5b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004173354.141e1a5b@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 05:33:54PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/fwserial/fwserial.c
> 
> between commit:
> 
>   a8c11c152034 ("tty: Make ->set_termios() old ktermios const")
> 
> from the tty tree and commit:
> 
>   db65becab2a3 ("staging: fwserial: delete the driver.")
> 
> from the staging tree.
> 
> I fixed it up (I deleted the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Fix is correct, thanks.

greg k-h
