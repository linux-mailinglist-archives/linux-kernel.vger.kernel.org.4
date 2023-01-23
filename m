Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FB3677E49
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjAWOm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjAWOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:42:24 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7002201A;
        Mon, 23 Jan 2023 06:42:23 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7DF85320092E;
        Mon, 23 Jan 2023 09:42:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 23 Jan 2023 09:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674484942; x=
        1674571342; bh=KbSF4ldL5+pYxUQfvT9aGEQGL7o7DDUOIC5afK3e+u8=; b=W
        LWgwah5aSrHOtwas+kvZ93vWTKJ93PBChKSGm6pWvksmKY9E1QcCGzY5pAK4zCQH
        cSqUhMStqt/PqS+HTvu79aVYapIjeDF8lvnoHOND+aJ7FFNbZ1se3Iv+stJVWjaq
        +eAR38N9NlMdWGMYbnKWqFoH2Hp3dIzXVk6DZGEa6vqVHz2NPJA1yHt6/zErhLf3
        BIQMmip8TwMv9iuXDDLd+795b8D88/wrBCrPGnl+PV/Uy5jupoVuRLDTrkPEM/Tr
        9RpN4aG3WaCgIv5D7tujc3xNoQYuapEXDe4wtFjv36PO39cYfloPEFj8qnRwpOua
        AjKFXf4h2Qeomf+HYmK7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674484942; x=
        1674571342; bh=KbSF4ldL5+pYxUQfvT9aGEQGL7o7DDUOIC5afK3e+u8=; b=Q
        HbXnDSPIExubYFxbO1UeHWr+WZ00v2wIOfqnSMJsfeAuLayvi5FYLNcj4rWGAvod
        J5jXTj74gbx8HArfnB6fYRlrN60PSQmkZZMUmo0/tQEnHyS9YGykr7RpJj5SXtZh
        SI2fiJ0QWLsZGrrY7ahQ5vSW1KaYs9uBRmEzVF/c1VfFKysaFRY8rRtrxCYyTGTx
        TLEZbF5RffYahjcF/NYSgNpei4oSdt/WhMnbczpcuvfsDMbo5mJXRTPpfzhEZ9CF
        VCfTU4VYWeSHxqbb/Q+/z/HR8w0h6Hqe4hZUFvG41/EJk0Dd42mbNiboOLyCgBhP
        EEsyQgihTlWBz3dlbiGBA==
X-ME-Sender: <xms:zpzOYyFGjYXGgW4IbSmW36Cm1HQvzzGftlaJogfxMyolAKenqa33ug>
    <xme:zpzOYzWeilb8VcQXLlr2lluCOAdNhR6psRVs28eUwfwwPjtXLjcUbVXbTT6hBgML7
    JxeMpCotgUaKA>
X-ME-Received: <xmr:zpzOY8JSZSlEpDcxSLorTFconEuAWitN3aLo_3dsSFKfoGdIZIyhuZOIBxK0qmBEpNw4smrUKKyotWBRAozrV0cg5SJ6Jhcdd3O2hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddukedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelhe
    ehudduueeggeejgfehueduffehveeukefgkeeufeeltdejteeiuedtkeekleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:zpzOY8H0OXTLc_AbTdnzombngB2zdrw6bgPiooGkVj9g_PPQ953kOQ>
    <xmx:zpzOY4VgwspGQKaU8hSDa9TyIUKv3Yy5gP9KAtNgSmCWe-ncsbSkZw>
    <xmx:zpzOY_My_cjqvjpAYoZHbWbhk-m4E7Zpf49CLAugalx7qjbQvEYlTA>
    <xmx:zpzOY6J1zNU0VS6vLP_l8C2og1wFqa79yWmQVUq196JiYJIKgufqLQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jan 2023 09:42:21 -0500 (EST)
Date:   Mon, 23 Jan 2023 15:42:19 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <Y86cy1AM4w5ju5A4@kroah.com>
References: <20230123152430.3e51fd25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230123152430.3e51fd25@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 03:24:30PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> include/linux/usb/composite.h:510: warning: Function parameter or member 'bcd_webusb_version' not described in 'usb_composite_dev'
> include/linux/usb/composite.h:510: warning: Function parameter or member 'b_webusb_vendor_code' not described in 'usb_composite_dev'
> include/linux/usb/composite.h:510: warning: Function parameter or member 'landing_page' not described in 'usb_composite_dev'
> include/linux/usb/composite.h:510: warning: Function parameter or member 'use_webusb' not described in 'usb_composite_dev'
> 
> Introduced by commit
> 
>   93c473948c58 ("usb: gadget: add WebUSB landing page support")

Jó, can you send a follow-on patch to fix this issue please?

thanks,

greg k-h
