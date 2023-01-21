Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C226764F7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 08:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjAUHaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 02:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUHax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 02:30:53 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5487028D;
        Fri, 20 Jan 2023 23:30:53 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id ABEFA5C007B;
        Sat, 21 Jan 2023 02:30:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 21 Jan 2023 02:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674286250; x=1674372650; bh=xQZuJHWaJy
        nRRhNGWAzBSKfZB3gdlchERVUXaGTKKGY=; b=J+bZs+dTheCGrwXth4OQo8UvvP
        jZTlu5wuJ8SACzM4fz2cHg3h8p1r/VOJG6mfrAoXxynbDnItqG0+DvGvx1gSaEh7
        M6wR3Uij9+syLEJE+U6xA/xZ9pfKEudsrtPKselHFaUe2R9Fx41cYt0SIA1CwyEL
        7wrVnPaWa+ibHEnSTDazp5g/DP3wdMlhp895LzJVrqU7Vr77LGCOaTIH1b7J6WFc
        CExu/tErByIfyqUgXr3lx0K/933eCbVUofhMoGR2hQb1Po+GjnpU7TxaD76RIIPk
        NC1d+e5Vw6ABxMUQ9pXnKapEDyXcsDymiHWjj3y9wKTJWIAYVM/jCiA/cYbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674286250; x=1674372650; bh=xQZuJHWaJynRRhNGWAzBSKfZB3gd
        lchERVUXaGTKKGY=; b=pXDGgc8sRF3RQCWFzQrOa7dZuc2JBzhu0vr5Ds61RIEs
        balSsy8rQKjuxQR1K658FNLHo5ApTGY/27kbR3XBGS8fm7BVPgIR/r9Zrn6oO4f8
        h4jvSO1bbM2fAvt7xG99NNuZpdOp68Xi2zCXu2KqqdgYAPOYwkZ434ZLjNr8baFI
        77O5eCC0eG5f8E3WiAdPMLiPDrUdswgRlSFk5OQdnAZFKbHmwO7JmcdTDL4E6ZDN
        rvjjDGU9VBhJtgBbz9SG+TLKP1B0S9kXcfHU45LKrB3PlZO46Dj1jKlbhHsaS6P1
        SK/rus3SRQBGRGLXu9eLWFENIMXaykTsBMDTre/KhQ==
X-ME-Sender: <xms:qpTLY5BYtRn3zEhQC3P77wzDeuTaAPxBSn0LqusuFRwR-WEVsbVbFw>
    <xme:qpTLY3gxfqw7gtEPCeT2Ee0XFxJplSC25Jxgj-UjO6uD-CjuwV7V7-0Pkef3fhejM
    W8Pz3ctC2yzBQ>
X-ME-Received: <xmr:qpTLY0k4LXT2bkbOXSdkaPiIXGE2gRaX_PRBgd1oU60AjRd0_dSWM1QZ5ekpaedeGSXUAK0D0btlmOBUYlW1qTD5mZ05FBno7psOcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddufedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:qpTLYzz5AY7dzmN0J5W0ek27leN-R2gH1uAicuy4Zsbpbt61KmveoQ>
    <xmx:qpTLY-TKVkRgRcXD0XmEhdGmTVFFhZqVQpvRDi5zf5k5NvSgS9L3Qg>
    <xmx:qpTLY2bXU1arMEpratg9x6rWlAEqfwtswEYgdFKPP4YXgvuW1NfOPw>
    <xmx:qpTLY9EBar7kWVLPykxuvxcF2k1GoNjMrViF393_wSfrP_XtElIMBQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Jan 2023 02:30:49 -0500 (EST)
Date:   Sat, 21 Jan 2023 08:30:45 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Marek Vasut <marex@denx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tty.current tree
Message-ID: <Y8uUpXDM2xnlqhjD@kroah.com>
References: <20230120075832.02bc1124@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120075832.02bc1124@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 07:58:32AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tty.current tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/tty/serial/stm32-usart.c: In function 'stm32_usart_interrupt':
> drivers/tty/serial/stm32-usart.c:804:62: error: 'flags' undeclared (first use in this function)
>   804 |                 uart_unlock_and_check_sysrq_irqrestore(port, flags);
>       |                                                              ^~~~~
> drivers/tty/serial/stm32-usart.c:804:62: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>   f24771b62a83 ("serial: stm32: Merge hard IRQ and threaded IRQ handling into single IRQ handler")
> 
> I have used the tty.current tree from next-20230119 for today.

Should now be fixed up as I reverted this, thanks!

greg k-h
