Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901C96DF288
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjDLLG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDLLGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:06:55 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6842B6A5F;
        Wed, 12 Apr 2023 04:06:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1EA923200971;
        Wed, 12 Apr 2023 07:06:50 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute5.internal (MEProxy); Wed, 12 Apr 2023 07:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1681297609; x=
        1681384009; bh=rw7S/JgA2JrMVobRPddZrjcohJoirU+TUYEN/TSwRsY=; b=w
        iCJiNgWhSUXtMxgR2cclqjoBX7mZ+9xy/hZO2yd6asjOPKqakUPvxUGrC1EmJbaF
        J+bnftwP/dp2L5CcgDrGEHR6CiPKzXrSrkeiunW5tzPbQzbGIiw7FYeZ9xo+njFJ
        K3sN67Zpd1+1HbQSpySMP24WDa4KsZUaS4xWSQtwjMryzcTCsewHJwRMwySyiaxy
        IoRsv95Wko+SIPRyvutYFaGFEiQOjI4QBWzHiMMXwlj+cajjxUBWNAtUC6N8PUqF
        zqj3Q367PNhZMRdYXH+i6gnl7N/cCFAoSLO6CtTZdi31TnZK4rF2rIJmsIduOhIH
        YwJ2C0js5apLC9tgNBxDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681297609; x=1681384009; bh=rw7S/JgA2JrMV
        obRPddZrjcohJoirU+TUYEN/TSwRsY=; b=FiMNbLiY/Fg0H4UWtb83QFXwA0Uca
        bPtZcwAqeNhcwQWnSXEP+O6c8gwTA7AoAv2GqCjvITAI/sRcR3hyTU7n1ejWMw/j
        G3dpTNcEB9nSOatWE6xEg2rlTecibkVxnMOwDos9Oqh+DY7620mDxiVRbzJqRvBM
        8mZCaqiUq3Wc9/vuLxkIX/2k8LZbUK0LnLMQiQoOrLqUQU8CsXqvKOYGXXnadh9x
        92IK8G0g+Fwyo9Q0GVIgJcE1qm9Pdbj1lwMydxwh3LkE28eqxFHmY7xp+aMZ/ND5
        rQWftFKHTCNeC2mckVQQm53aK4Ogw/mHkQjDfOhSTX1wxxRbjyUdEcNAQ==
X-ME-Sender: <xms:yZA2ZJzZDzXzzXYmgIcW8UKFV3nUMYFE6-AZfaCSdkPwRU2FT5nGJw>
    <xme:yZA2ZJTrBwH4OENp7xGx7EcqYVQzaOQ5B_yYgSOPRKnQOxDBwP0p75eT8rL3iNtpk
    YbvpMIFzhwjRkQ2DcE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpeetlhhi
    shhtrghirhcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrf
    grthhtvghrnhepueekffekhfejteehtdeigedujeevvdfhjeelkeehfefhudffhfejgfej
    ieehhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:yZA2ZDWe1gm_JtrRvXUG0APTzwNLMiWoYNhtCExg2d8FX5lGyvcT-w>
    <xmx:yZA2ZLhmRBavGrc7NrSTVlojn0cgyStncoDEHnVc8h3JwRdSZMy-VA>
    <xmx:yZA2ZLDQTG3_C0iRKnDMn7Ylbz9y-XPiyml3uOZK68Rb-9mB1aZTVA>
    <xmx:yZA2ZONDvwIu5VgevShCMJIsrxw2stX_3lHdk6BN-GZrnkBhZo6rjA>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 73C162D40074; Wed, 12 Apr 2023 07:06:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <8113942f-589f-4834-9ecf-7f611af82819@app.fastmail.com>
In-Reply-To: <20230411211651.3791304-1-git@hrdl.eu>
References: <20230411211651.3791304-1-git@hrdl.eu>
Date:   Wed, 12 Apr 2023 21:06:29 +1000
From:   Alistair <alistair@alistair23.me>
To:     hrdl <git@hrdl.eu>, "Linus Walleij" <linus.walleij@linaro.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: cyttsp5 - fix sensing configuration data structure
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023, at 7:16 AM, hrdl wrote:
> Prior to this patch, the sensing configuration data was not parsed
> correctly, breaking detection of max_tch. The vendor driver includes
> this field. This change informs the driver about the correct maximum
> number of simultaneous touch inputs.
> 
> Tested on a Pine64 PineNote with a modified touch screen controller
> firmware.
> 
> Signed-off-by: hrdl <git@hrdl.eu>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

Alistair

> ---
> drivers/input/touchscreen/cyttsp5.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
> index 16caffa35dd9..30102cb80fac 100644
> --- a/drivers/input/touchscreen/cyttsp5.c
> +++ b/drivers/input/touchscreen/cyttsp5.c
> @@ -111,6 +111,7 @@ struct cyttsp5_sensing_conf_data_dev {
> __le16 max_z;
> u8 origin_x;
> u8 origin_y;
> + u8 panel_id;
> u8 btn;
> u8 scan_mode;
> u8 max_num_of_tch_per_refresh_cycle;
> -- 
> 2.39.2
> 
> 
