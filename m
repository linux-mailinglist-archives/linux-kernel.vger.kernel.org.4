Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF5E6F63F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEDESu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEDESp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:18:45 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4616D1BD3;
        Wed,  3 May 2023 21:18:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 54F9732000E5;
        Thu,  4 May 2023 00:18:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 04 May 2023 00:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1683173906; x=1683260306; bh=sB
        OpqE6ZyD5TuQjQQQ+LegbaXjUHqO7D3JUbKKQLkRE=; b=hNketbjBsMKpiS6r2v
        e3HvheuyyvEf8+BBmu4s23Re46Cz9dPRzMVAKB7d9wjjynOZmeooKAQdthGdGWMt
        QrL9dbsbsGO0iih6jMYyCxF4YWHG5kR1tzFgla2B0q45IoknUt2IQPWSzvuioJi8
        IW9BqRbHFsvlcRKi8n8p9gqwP7O70JcAKKeq9a8e+/kekYsObpIHbNYc4+o/i4oa
        +a0k7Eit0yAYeTPyA1wfptfwPupiE7C5i6gw9VHFY8PyvX8KI9yNc414LMbMze4w
        4qxCJ4JrX6a8CzDaklXV/8wYox98XDfehEXwkrzMVv02UlBIGYMfHQ0n0ZCHo3b9
        Kfzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683173906; x=1683260306; bh=sBOpqE6ZyD5Tu
        QjQQQ+LegbaXjUHqO7D3JUbKKQLkRE=; b=EGdMeRehyrYOs0b9gDRZbs/6gnW0f
        KXbjpqCFuIlv0XCDgonnutdIgksx1hudzBQFOtFJhSr5Tx7Pnyqz1XAXD4ZquZF7
        Dln8VtjiSDGeExs1OZPkp4hzGNnS2D9/fZx/DNdi9+wEyH4vY/PcRT1qeZsF4yNX
        SrxPucUneyZd06d+fc/Cp8lN5h4srupVCtC8N/F1dDs4Vv69fMu9O3V17W80cBuV
        sHbLTm7YSmiZLvHKD4zgjRRZXLzo1nAOTlhGFI0lcyheLwkEve/blAp5MG9Lehdb
        DrzoOHEF0eQZQUrUfm8OHdCAosMpBImHOKb/iwmvD/tDomGrW4UoTLiEg==
X-ME-Sender: <xms:EjJTZDbPtSy6Y48lyLDtiGXCzLpc04zGnDUwpCXmaa-4d9zdHz08TQ>
    <xme:EjJTZCbaUYMR6txW8f2JiCromde1UGeMh0Zc4qoWGa9pX90GX3fGoxj_YfJA0SPrm
    Puf_Jd1XLult_TBc0o>
X-ME-Received: <xmr:EjJTZF9eQHq3pjqcNyM0633ct5BurtK8eJ-cJMSk-1eP-gk61MDgOCH5y5TdDjDuuAg59PHpb7HZ4cQVbXQFmnd36V4Fu1KkEljQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvledgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgv
    rhcujfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeekvdekgeehfeejgfdvudffhfevheejffevgfeigfek
    hfduieefudfgtedugfetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:EjJTZJr0qIhBiAVI7f94PmpMuEfYeGo5pUkmdSZ27S5Mi90RAY1goA>
    <xmx:EjJTZOpF7kHr4BaQOU5-I9p9Ybg8xb03LW2inFskNaJcZZiKPlmEIQ>
    <xmx:EjJTZPSc4gUZ-16NCZr-gf_fuumlCSLU7_nw0tL44h7JypGWMNw-fg>
    <xmx:EjJTZDA5TKl54IwW6KdW7fFuSLg-En9V3ONUPiSpMyz1wXAIc3_jYg>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 May 2023 00:18:25 -0400 (EDT)
Date:   Thu, 4 May 2023 14:18:19 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: fix open count when closing inhibited device
Message-ID: <20230504041819.GA1128727@quokka>
References: <ZFFz0xAdPNSL3PT7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFFz0xAdPNSL3PT7@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 01:34:27PM -0700, Dmitry Torokhov wrote:
> Because the kernel increments device's open count in input_open_device()
> even if device is inhibited, the counter should always be decremented in
> input_close_device() to keep it balanced.
> 
> Fixes: a181616487db ("Input: Add "inhibited" property")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Yep.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
  Peter


> ---
>  drivers/input/input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index f791d14ecf23..8c5fdb0f858a 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -705,7 +705,7 @@ void input_close_device(struct input_handle *handle)
>  
>  	__input_release_device(handle);
>  
> -	if (!dev->inhibited && !--dev->users) {
> +	if (!--dev->users && !dev->inhibited) {
>  		if (dev->poller)
>  			input_dev_poller_stop(dev->poller);
>  		if (dev->close)
> -- 
> 2.40.1.495.gc816e09b53d-goog
> 
> 
> -- 
> Dmitry
