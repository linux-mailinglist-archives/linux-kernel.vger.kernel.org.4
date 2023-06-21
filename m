Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456E173856A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjFUNiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjFUNiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:38:17 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51EBE59
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:38:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E4855C01EE;
        Wed, 21 Jun 2023 09:38:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 21 Jun 2023 09:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687354696; x=1687441096; bh=1d
        BRv88m8DzmsRCY2sdR5AtUmMT+gLlbjdNPhPq4Vr4=; b=yyYLrOekmAbDvkrI40
        13wTo/99CDXoenIiXNlDedT/o823/dNHm8vCZ/KHY2BFkv8FJwVtaKEXPHYocrZ/
        cXc+oAmavpuBDPszHzeS4VvdzQONA4eXJr9fBZoisuGxJeFULL8+++nracCCHHCn
        wh5ew3hK3F2WKsakvkhhgIXDHjrumvALKlSEBfpEtmXrfQSM8MiIzPiSrIdJHayE
        v4118BovNTCInZNKQFXSicMVtREPBMm9NWRt9OdBKcWBAIrIoM+Nu+820nDslL9I
        j/jhakcDl08RltP2o2RKJAYhIm8/61/8uD3yBJMLyLY8ktVD20wjl8HLokZOtO+z
        pjvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687354696; x=1687441096; bh=1dBRv88m8Dzms
        RCY2sdR5AtUmMT+gLlbjdNPhPq4Vr4=; b=QNWAj4DumqXhr/oHnIoKGkfN+sXCx
        MvJfP9/RYZNPp8VOW6DCfgEa/oASJYEeoF6Vns7aAXp8SI0knGIwNWMQSCySZcai
        ddcubxk1bosLygTf7pD1KWTm0QGZsNxe6PDMpdWf/QnThlRF6u8YcS9nXauRZgth
        6kOkJnESxNl8ymdO2nZb7hyYKhMBp3UcqVdASxYfbZrkI7zyWC39QwclHbZOTPxK
        ba8GVLPyn95Z+V6Qez9pZUO52huxeCOmhQMlpHn7+bMWWMWOUvewP1sTXlHAA2MN
        +EJKIs2NY32pLMqJXl72QB2m9RhmSArpKdX7FgRJm24SI9ezoXJMO+w6A==
X-ME-Sender: <xms:SP2SZAztbx1fWdlj0Ts0r-9XTm6EiuayH5AdjjUWGmWyN8gKj6MZNw>
    <xme:SP2SZETSpk6wUkKGgv_SSa_d4EYzelKvrfHKcUtkJzAbmvbT65kixKiCjEUJ0nrf4
    esq4Z2Aie9ixtzrnj8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:SP2SZCX3ACRTg5otRMSoHKt69dsqr5RHOwBp9B8oX72sQ4K2s7R6tA>
    <xmx:SP2SZOjkc2OP0tjeZrB1GtTDTvWccSdVV8bQJpGHNZ1j6E4xany4pA>
    <xmx:SP2SZCCrJOqg7VxbJVnvvLa5enFVoJYk3m3eU_mHQ3fKsIy4j0Vjig>
    <xmx:SP2SZD6l-xXSjGQf9PP1VAESZ7eUcjY0JXNg3NLA9yHsrVns9Pcd0Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F31DDB60086; Wed, 21 Jun 2023 09:38:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <246274e5-851d-4cea-8e01-d165ebd967f9@app.fastmail.com>
In-Reply-To: <168735222615.404.5437100914727545952.tip-bot2@tip-bot2>
References: <168735222615.404.5437100914727545952.tip-bot2@tip-bot2>
Date:   Wed, 21 Jun 2023 15:37:55 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org
Cc:     "Marc Zyngier" <maz@kernel.org>, "Shawn Guo" <shawnguo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [irqchip: irq/irqchip-next] Revert "irqchip/mxs: Include
 linux/irqchip/mxs.h"
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023, at 14:57, irqchip-bot for Marc Zyngier wrote:
> The following commit has been merged into the irq/irqchip-next branch 
> of irqchip:
>
> Commit-ID:     d93c22199966696cfb76c6942797de2fbb22da24
> Gitweb:        
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d93c22199966696cfb76c6942797de2fbb22da24
> Author:        Marc Zyngier <maz@kernel.org>
> AuthorDate:    Wed, 21 Jun 2023 13:46:25 +01:00
> Committer:     Marc Zyngier <maz@kernel.org>
> CommitterDate: Wed, 21 Jun 2023 13:50:53 +01:00
>
> Revert "irqchip/mxs: Include linux/irqchip/mxs.h"
>
> This reverts commit 5b7e5676209120814dbb9fec8bc3769f0f7a7958.
>
> Although including linux/irqchip/mxs.h is technically correct,
> this clashes with the parallel removal of this include file
> with 32bit ARM modernizing the low level irq handling as part of
> 5bb578a0c1b8 ("ARM: 9298/1: Drop custom mdesc->handle_irq()").
>
> As such, this patch is not only unnecessary, it also breaks
> compilation in -next. Revert it.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Shawn Guo <shawnguo@kernel.org>

Thanks! I had prepared the same patch but not yet sent it as I
was still debugging some unrelated issues. Once 5bb578a0c1b8
ends up in mainline, we can get back to fixing the warning
by marking the handler as 'static'.

     Arnd
