Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF805E8A2E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiIXIeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIXIeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:34:07 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2F8D4A8C
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:34:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 0568E2B06765;
        Sat, 24 Sep 2022 04:34:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sat, 24 Sep 2022 04:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664008441; x=1664012041; bh=/WWds24ntc
        UKbKWLsiLHKDoxKaoSccYQR5V3Km1yp4s=; b=BhkT20XEhvFZug/DAGPfWynldN
        u02HADT75UMmdSvz/VjsbL1cBuDFGdC+8TJOrLbXsgEsWfQUlHEy676nZJ92254r
        oQ54yOIiM8xuOz6aPiQZ1o4H6c6yNMu2V4ZDg3MYv/9TJTdCKZSg6W3GC/dXxXr0
        GZ+q1TTT6nGzhJMLheGnn97Gwf6HXgFZDVenrdggdB6scG/RJZx+6R1LAV4q15KF
        jPm2+z8t5kWwJDr9lfvyrMiDZtwNgAW7tUVUyxYVzHwuKg2Z6VO+lbPpRKZHQG0z
        +wn2/+LgnEdnqPCZSMgwzdlOPNZEW/mwAdq8kKIBSZld9qab+wGwFhfnhq7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664008441; x=1664012041; bh=/WWds24ntcUKbKWLsiLHKDoxKaoS
        ccYQR5V3Km1yp4s=; b=0rG88KEBbrUvwYUlsGimvq4nvPwN/kdGSw2+zWZrDMLl
        ygFQfRlpfYV0ik2JZjZ+Es17o+OjwO/b3zY43n3b3Vz9XFMUVR39dxh0cpuMUQkJ
        tpzyWj+fTppZD/dDgYKRZFjrLm0drCV9Prx6ZWgGWc+BlmZOcVAgOTxwwGWVrXbQ
        fljwWG0IAMDX0Ug9jrI6vXxss1YjLgZ0CnkjrMux0f1JKtTFrhUHzBsbJrBgaUQc
        YBgz4aGLiVy5yZwNusQpbNT+7xml71lE0/6P8qGdCPLJhdSghxx4TTwAqMyzuuSB
        8yI247cIoS/Yuto6cFiXztGsIUpO9XTvsE9yZkdTjg==
X-ME-Sender: <xms:-cAuY29Lmh6-UpYO9KwU4MOM63iBt_m2M3qFPfNeCFM867vYJgQLnQ>
    <xme:-cAuY2v0wbtHxLur6YkvcNIAkKuQh_PFSfKuhtK7QD9Y0LtS93zsSh-IfgJtyhBVi
    fVE5WxkAWgOPhKomY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefkedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-cAuY8CLMUexoLgeLSuvf1gOgojavpOa3VcRuGGDMDfW81JGDwD12A>
    <xmx:-cAuY-dsim37CNs9lBP0D0Py3fSz9sN1UQEXqTGVj8YKo6hTzqbnrA>
    <xmx:-cAuY7Os__TJBu3yzYYRRHfCOffNuZckg8R1t6GlTFAh1s9pvWMLlQ>
    <xmx:-cAuY0Z94kDPILiJvycBxg7dskYeeH4F7gkZXHiyYn6mF0L9dVZnrkqVIus>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ECB1CB60086; Sat, 24 Sep 2022 04:34:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <68c63077-848b-45f5-8aca-ed995391f2b6@www.fastmail.com>
In-Reply-To: <Yy6d7TjqzUwGQnQa@penguin>
References: <Yy6d7TjqzUwGQnQa@penguin>
Date:   Sat, 24 Sep 2022 10:33:29 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: Re: [PATCH] pcmcia: at91_cf: switch to using gpiod API
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022, at 8:04 AM, Dmitry Torokhov wrote:
> This patch switches the driver to use newer gpiod API instead of legacy
> gpio API. This moves us closer to the goal of stopping exporting
> OF-specific APIs of gpiolib.
>
> While at it, stop using module-global for regmap.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This looks good to me overall. Three comments:

> @@ -63,7 +62,7 @@ struct at91_cf_socket {
> 
>  static inline int at91_cf_present(struct at91_cf_socket *cf)
>  {
> -	return !gpio_get_value(cf->board->det_pin);
> +	return gpiod_get_value(cf->board->det_pin);
>  }

a) The change in polarity looks wrong here, I can't really tell
from the patch. If this is intentional, maybe explain it in
the changelog. With that addressed (either way)

Reviewed-by: Arnd Bergmann <arnd@arndb.de>


b) In case you are doing more patches like this one at the moment,
note that I'm in the process of removing all unused board files
for arch/arm/, which will in turn make a lot of drivers unused.
I should be able to provide a branch soon, which can be used to
identify drivers that don't have DT support any more and don't
have any board files. Rather than converting them to gpio
descriptors, we can probably just remove those drivers.

c) I'm not sure about the state of the at91_cf driver. Apparently
we used to have three drivers for the same hardware (pcmcia,
pata and ide), and only the pcmcia driver remained in the tree
after drivers/ide/ was removed and pata_at91 did not get converted
to DT. I think in the long run we will remove the pcmcia layer,
so if you are actually trying to use this hardware, we may want to
revive the pata variant and drop this one instead.
There is no dts file in tree that actually declares either of them,
so chances are that nobody is actually using the CF slot on at91
any more.

      Arnd
