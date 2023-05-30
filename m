Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F81E715A31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjE3JbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjE3Jal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:30:41 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA94E50;
        Tue, 30 May 2023 02:29:24 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D05815C01AF;
        Tue, 30 May 2023 05:29:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 30 May 2023 05:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685438961; x=1685525361; bh=an
        gFdZkSyuEVQZ0FiF1yuU0Dlh7K45G0dRsuCiplCx0=; b=kbFV8ONJ7ix6FUPr+S
        gnCReTdRCMo/53CWKuedXuMJ67k6+fHljS8s7ZSsOT1DY4fg6fExXh4684vkHBrR
        BqNGocVesWI+SGvg2gMfbde+PoQrZCPbR+v0pn7+YHyTtKaaoxU5odQhuK2DpkNi
        JMgdnHjI1GDOjDhslsq0R+kT48PASJHVHPhCRGwxUExleSxZNFa43MZDtXOfh7/z
        Q/3kSnHm9zbybGcu7J2fRmtF0tpwnNuzoRdXMPqLj8ajNbePni5p/fk1nS0zHYY0
        3E+FpItg2ZdXvYiTwfSmpIVMKoQhSCqbuL5usDQoAhk/iJGKhyEhZNT1N5S3/LLT
        KfqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685438961; x=1685525361; bh=angFdZkSyuEVQ
        Z0FiF1yuU0Dlh7K45G0dRsuCiplCx0=; b=pZsS7wER/K2yTAX8NdqYIYaotk0O8
        A0MXNLpARAFprs8wTW5JG0VxETVVoQsug6XZ+SxABxUx1nnDpz+272EPaN6Cs4qV
        WDjMj4TjO2NqKOKfpiLj5645QsYsaE0OV09yyxzf1Xoliegj8jRnFUNLA4BpkMQk
        n6MFMLHeAEsyvimyu0PzbxDYR27pyG32LPQql/EZa8zq0MzUr7K1epnDZeTv/gEu
        82BRIOdTA1AeVPD2ei7hb/XDa8g52jflZYiHl6S8CXsPe+rv27cSpUP3iwzBO3f4
        qDDsmtDNqJgBdFmOO1u3kqcX7Jk/0l2/4kRwEAN1CAp+Lq4d7yK+f04qw==
X-ME-Sender: <xms:8cF1ZEq3ijU55gpjZ51-8WGmN5W5IZK3N0HIuR16c9mwDUGsGW_cuw>
    <xme:8cF1ZKqi6tjCz0NAPu5xKqUJO3iBeYMcA0vrBvTI5nIhg-H86xGxt5-ZQyQBAwclH
    QA3uORkqZwVgw1ZqUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:8cF1ZJNWJILuHs9RSygMa2kokjdxH5WCdq3wUJYIofq_gVfKgQ9pqw>
    <xmx:8cF1ZL5aqJ0VbF6STp0JuLsM6hToQ4wmSVy_U_K5Sir4Ec339NPg4A>
    <xmx:8cF1ZD4boQncZ5zomYhokqUeS83_O8tO1C4vaJSOw--8wgdts37jpQ>
    <xmx:8cF1ZAuDnCbH5fgCjVl795nbBu3MWQ0CPbDvgP98GwqqBaZsIKp_8w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DFF27B60086; Tue, 30 May 2023 05:29:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <e6217d79-0e80-4478-a8f9-c52ce0f65377@app.fastmail.com>
In-Reply-To: <20230530141914.672a8e59@canb.auug.org.au>
References: <20230530141914.672a8e59@canb.auug.org.au>
Date:   Tue, 30 May 2023 11:28:13 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Olof Johansson" <olof@lixom.net>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        "Andrew Davis" <afd@ti.com>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the gpio-brgl tree with the arm-soc tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023, at 06:19, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the gpio-brgl tree got a conflict in:
>
>   drivers/gpio/gpio-twl4030.c
>
> between commit:
>
>   d5f4fa60d63a ("ARM/gpio: Push OMAP2 quirk down into TWL4030 driver")
>
> from the arm-soc tree and commit:
>
>   fbc8ab2ccd85 ("gpio: twl4030: Use devm_gpiochip_add_data() to 
> simplify remove path")
>
> from the gpio-brgl tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Maybe Bartosz wants to merge Linus' gpio-omap-descriptors-v6.5 series
into the gpio/for-next branch as well? It touches both the
arch/arm/mach-omap and a lot of the drivers using the gpios, so we
could treat this as a shared immutable branch.

    Arnd
