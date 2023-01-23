Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD6E6783A7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjAWRwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjAWRwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:52:53 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E75D1717E;
        Mon, 23 Jan 2023 09:52:51 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5D3283200949;
        Mon, 23 Jan 2023 12:52:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 23 Jan 2023 12:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674496367; x=1674582767; bh=NJnqRwcpwU
        T+APDxZemOSPiySbFRy9evWMZn6qHEDEg=; b=Ukl3SAIeA43rY81BsV6teORpvR
        0WRadyd47/HbMxPQJsiATA1+dhzANRc5n5BFDip6FN2554cxgO41pbcSHl4X4jEM
        BDiq3pUh42G5/2D+lxusPIorZRSOF5flPoT1nFU+ADlFu+DUC1Mb7EQXPmho0EPZ
        rkh2gBMdVPyIspJ+KQ69hprZ0OMMsVzRdkDW9MFoVwkl5mdMun6h7Kxqv9lOJSxJ
        rNeuwTFRx8loBuIuIBp5pUa7sEYjGOMllt5HsCQhvSPc2nxWE6ph7TwXKWQdMy4L
        MLYV7HwB+JW8FMGk/q5s2sKsD4RT1pQKFbqueNKS4dCOXNpR7dA9OBaBZ6aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674496367; x=1674582767; bh=NJnqRwcpwUT+APDxZemOSPiySbFR
        y9evWMZn6qHEDEg=; b=AXCGKFw5aajuEqAbs0+IhnTR03Ptlfgiz9T1g/4C5TO+
        uP2yt4+0MJU+b+utUwu5T7KV/E2mZzOq1L6QIZLAvogPNVvj841JCyIFqvfHb2EN
        6sD3GuPT8fbRizQ3gFqD9HtqoO8VmQv0JY+MgxRj5xYkJH1FB8XlbUzKXko1ePPr
        n1m9ekdXswHYUORPfXCUYVnRrGUo/9602iI+CqJ0835NDcGFVtJ6Xneqf/9m35ZF
        CLfdPX+QA8yDiD2LpQke6Xg2I4IX7jKxnAMoGdaQUX9k8EpsDuuQpNoggO4ASyWh
        2Sgha4/yMAoIqgIgrEaiItIWR0T1Vwnc6UqjsAe9Pw==
X-ME-Sender: <xms:b8nOY5L2uB3YWlyCP-vM5yX9aWiv2WFgCMKug4E24dKmbdQ-OqCluA>
    <xme:b8nOY1JE1gdxqgVPifinrq5zlSiCc3JGLQR43_63tuqgQtCGouRgHkyLM51tdOgw7
    sp6NNgknTY2mQ>
X-ME-Received: <xmr:b8nOYxsbleaTFxgkleaH8KBzhR-Djvv1-3YRjAIkcvmI1RCT78_BOmLjbfq8LLsDsOzprPhRSJzWH4XtC8LAAQYgkhc0y7dXqqqeYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddukedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:b8nOY6Y4ns8-yrDpWjcQD2eOkvGOwU8Pg1HtpsXwwsHb-cVeATu6sA>
    <xmx:b8nOYwYHj_by3GBKwWPdHCDVYVKcYWXSzyyPUZq7EskaqE5X1qt8AQ>
    <xmx:b8nOY-D9o6kTwOUUQ_93W5f2S2bxVjkkY9lYiEzwpPm7idCIU7Dl6A>
    <xmx:b8nOY2MA_VWxDKwkhJd85csyf2qoacJHwaybJtEHSqrGA4Eg2TdgXQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jan 2023 12:52:46 -0500 (EST)
Date:   Mon, 23 Jan 2023 18:52:44 +0100
From:   Greg KH <greg@kroah.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tty tree
Message-ID: <Y87JbLHfRqAfQpHy@kroah.com>
References: <20230123131818.2785f4e8@canb.auug.org.au>
 <CACMJSevdzO7QuYqQ8B1QoAPC5CUW--+AeDm2dHbf1TGGL0=aMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMJSevdzO7QuYqQ8B1QoAPC5CUW--+AeDm2dHbf1TGGL0=aMA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 10:46:28AM +0100, Bartosz Golaszewski wrote:
> On Mon, 23 Jan 2023 at 03:18, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the tty tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> >
> > drivers/tty/serial/qcom_geni_serial.c: In function 'setup_fifos':
> > drivers/tty/serial/qcom_geni_serial.c:1058:17: error: 'struct qcom_geni_serial_port' has no member named 'rx_fifo'
> >  1058 |         if (port->rx_fifo && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
> >       |                 ^~
> > drivers/tty/serial/qcom_geni_serial.c:1059:21: error: 'struct qcom_geni_serial_port' has no member named 'rx_fifo'
> >  1059 |                 port->rx_fifo = devm_krealloc(uport->dev, port->rx_fifo,
> >       |                     ^~
> > drivers/tty/serial/qcom_geni_serial.c:1059:63: error: 'struct qcom_geni_serial_port' has no member named 'rx_fifo'
> >  1059 |                 port->rx_fifo = devm_krealloc(uport->dev, port->rx_fifo,
> >       |                                                               ^~
> > drivers/tty/serial/qcom_geni_serial.c:1062:26: error: 'struct qcom_geni_serial_port' has no member named 'rx_fifo'
> >  1062 |                 if (!port->rx_fifo)
> >       |                          ^~
> >
> > Caused by commit
> >
> >   2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
> >
> > interacting with commit
> >
> >   b8caf69a6946 ("tty: serial: qcom-geni-serial: fix slab-out-of-bounds on RX FIFO buffer")
> >
> > from Linus' tree.
> >
> > I have applied the following merge fix patch for today (I am not sure
> > if it is actually correct, but it builds).
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 23 Jan 2023 13:09:27 +1100
> > Subject: [PATCH] tty: fix up for "tty: serial: qcom-geni-serial: add support
> >  for serial engine DMA"
> >
> > interacting with "tty: serial: qcom-geni-serial: fix slab-out-of-bounds
> > on RX FIFO buffer".
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/tty/serial/qcom_geni_serial.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > index d98e0a8aae7c..61350007bf1c 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -1055,11 +1055,11 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
> >         uport->fifosize =
> >                 (port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
> >
> > -       if (port->rx_fifo && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
> > -               port->rx_fifo = devm_krealloc(uport->dev, port->rx_fifo,
> > +       if (port->rx_buf && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
> > +               port->rx_buf = devm_krealloc(uport->dev, port->rx_buf,
> >                                               port->rx_fifo_depth * sizeof(u32),
> >                                               GFP_KERNEL);
> > -               if (!port->rx_fifo)
> > +               if (!port->rx_buf)
> >                         return -ENOMEM;
> >         }
> >
> > --
> > 2.35.1
> >
> > --
> > Cheers,
> > Stephen Rothwell
> 
> This looks fine and works fine:
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Thanks for this, someone else just sent the same thing, I've queued it
up too.

greg k-h
