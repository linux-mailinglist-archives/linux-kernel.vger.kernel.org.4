Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B6B73D794
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjFZGJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjFZGJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:09:39 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E296EE;
        Sun, 25 Jun 2023 23:09:38 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CE3F15C00A2;
        Mon, 26 Jun 2023 02:09:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 26 Jun 2023 02:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687759774; x=1687846174; bh=qf
        uwH513zFMWuo2i2IpH5QB5uYfjDBN+0K7CDVDIlgI=; b=sA/jjAP2G7/0DRMLy3
        I2IYFTFFEPO1haQwABjNa8w26Nk6BL7viwDNN9YF2UTmckv1yZgYOCdriFdMDXZc
        M15GL3Qt1UoqFA7yiRRynNYwHEJxyawMJZ6Z1vYGtZA5l142OSgyCmyqOpicoUBq
        fSIfgW9sw7PEI0LFztHmfpTL+EAra/koMUkNm6jVTQmfLgyfVNEywOjzqiiknow/
        LzGebNHbWk3ZCbgtMaboFvmQD3akNbbEo68bZ1LcNjvAfo8YkTKw4rCdKZLklbKV
        eYDNH0PfJq473qMhbHzCELDPagYKBgHN9SRM7y4+E6KoPYRvotsdglBr4KzfPnEQ
        MyBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687759774; x=1687846174; bh=qfuwH513zFMWu
        o2i2IpH5QB5uYfjDBN+0K7CDVDIlgI=; b=DX+HRGeczHv1H5a8BuJYCffVvULKT
        oyWrdd7XsZtPz4kY8EUFFvXSHlfSLtYKbffSeKEWP6MTLTYolH8HA7QxQwjURwu3
        OTbwzdWc0+xVYzJCWVDxLksDr/zECy6wUaGubs2CQMS2pP2j2MFm+ILCg5bkc3RO
        OleDipmOTi+mfUHz78YeM8TkmYDrPtbuk6FwtbXUjIuC3v/7aL2KemrEMHQyMt3e
        o3x5f/P7T69/A8leY8xIlSOrATuFaOFwU9+Z/1X9aiaPDEDC/IT4wlMjNswS/3Hd
        /uwpPVjiz+8DDjtsPd8QXFs6ZDY3bvtI/xHtKZqURKl3z7OF6eBj2Vszg==
X-ME-Sender: <xms:niuZZJofb3VXTFYsx3wLUMCZYBGQygnzTEJLFEgQ9aaF1xHQEHsplA>
    <xme:niuZZLrsosy97OWKpbH1l9apN7kK3rTlE9bnXuMZQ5OAkEPQ2yyIIPWhxWa40REkX
    XIvv9_MDFRQEw>
X-ME-Received: <xmr:niuZZGM_5gBbWdxzwEsIZ71asitefY0cm4R-VZf5Fuzk_FHPtmOiM-io3YGsNjIGDnzrxEj9Ycp4tTk8Tau28CczgO2U88DPjKnCuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehvddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:niuZZE5bI80fFaGja607ZRQBL38CXsfyfpv4obSolcApF0RbGPr7jw>
    <xmx:niuZZI64QSiaqbzofBZ25xDZYFM4n--kmmo1_XrysW9tYk2Spkb95w>
    <xmx:niuZZMjEmfebJm7KA1UkrG3mHKyh0DMJXf5SXOWGcgpwS2RDXwTXsQ>
    <xmx:niuZZFyK3ywN9DESjbkqUiUAAyP5cAEVxatqyOey_3urRVFG-CeuOw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 02:09:33 -0400 (EDT)
Date:   Mon, 26 Jun 2023 08:09:31 +0200
From:   Greg KH <greg@kroah.com>
To:     Uros Milojkovic <uroshm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, marvin24@gmx.de,
        p.zabel@pengutronix.de, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: nvec: udelay to usleep_range
Message-ID: <2023062653-banked-embroider-2026@gregkh>
References: <CAP=xWk6GvVQxzTJ6jS2pQ9dKvgoFFHc=m4yMma101MGKgdcm5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP=xWk6GvVQxzTJ6jS2pQ9dKvgoFFHc=m4yMma101MGKgdcm5A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 02:55:35PM -0400, Uros Milojkovic wrote:
> Checkpatch pl alerts that usleep_range is preferred to udelay. The
> change is made.
> Signed-off-by: umilojkovic <uroshm@gmail.com>
> ---
>  drivers/staging/nvec/nvec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index 2823cacde130..8bb3b691d1f5 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -627,7 +627,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
>          break;
>      case 2:        /* first byte after command */
>          if (status == (I2C_SL_IRQ | RNW | RCVD)) {
> -            udelay(33);
> +            usleep_range(33, 200);
>              if (nvec->rx->data[0] != 0x01) {
>                  dev_err(nvec->dev,
>                      "Read without prior read command\n");
> @@ -714,7 +714,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
>       * We experience less incomplete messages with this delay than without
>       * it, but we don't know why. Help is appreciated.
>       */
> -    udelay(100);
> +    usleep_range(100, 200);
> 
>      return IRQ_HANDLED;
>  }
> -- 
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

- You sent a patch that has been sent multiple times in the past, and is
  identical to ones that has been recently rejected.  Please always look
  at the mailing list traffic to determine if you are duplicating other
  people's work.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
