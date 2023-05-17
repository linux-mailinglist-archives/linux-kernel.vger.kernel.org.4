Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8815E70604E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjEQGke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjEQGkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:40:32 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87A0CE;
        Tue, 16 May 2023 23:40:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A5A755C01A5;
        Wed, 17 May 2023 02:40:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 17 May 2023 02:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1684305627; x=1684392027; bh=kl6TNT66P/y7iDeev/8upXtGKNlx3dVK/bG
        gkTY44/g=; b=dDepjuPQJpgpVcowQGAp9w9CSr8sS4dhN4qAyaBed7q08tauAKA
        2JVAJPtCONiJyrmQqEUDNDyvKkkGeMzzhHDVORpiBuFBcnRJmRiuV+vrF/Q962QP
        tZwalgxXh/0ZtE5RzAQyER7HXq2ngLal+K8eZUWX3QL2QYR9DRqkxLBYYxmrxLTq
        64M/MrtC2X9tkI1WAaym1SGbvlp91I3xuHdeiuKRR5hlOX2x2AtteDfccnsqxqwJ
        5CsPP24TnqrV0sjE0Aer95/M7NgZ/up3BzTEkEeVQPH60OzUIgZszVz57EPxY3uP
        rMFGvmypNQBvgzdz2XSHXKsu8XnFmL/y3xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684305627; x=1684392027; bh=kl6TNT66P/y7iDeev/8upXtGKNlx3dVK/bG
        gkTY44/g=; b=PipUvu0ehXleAfyypA9PUQLNwaI2g6c2IRoo+aylUllBX3EY2ES
        XQz2+3ZvfVPqLVVOuoLtuZG5s50Y8MCOYOdsFo/jNk28UhjAfVdQ61BwzRlup4nj
        pxrQhR8Sko0agy4sNPUNV050rnNxwWEC6HwXpXcL0Gnp3RZYTS/m/1SBL4/Xp/ye
        IgLTQRhiINQ1HktO5BigEHjzcMyiB0MNjp7QYTfUAEwoR4VQcb1OUIXO1Ui78Xrn
        XD/fIpYfQ28Uh9F/uYXo9iHfxWSVXBZ61FNlcd0gsf8qZk/4tPvCQh8DWor2I4C6
        fJ0T9s6BC45qjosZzAf68noItbmhkrszv6g==
X-ME-Sender: <xms:2XZkZIW9r5pDXvUOE3TzlEet6QUxsBAiN2Kou2aOO2OakqNmEQQ_XQ>
    <xme:2XZkZMlLqxXEY-dMX6yWOkKmREEluiUAylF5d_eUMCn8NC5bFvQOLBGIbSkOVWR8F
    kioh-vEpfS3Z8iEgvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeitddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeu
    feefieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:2XZkZMYyskLJEfaL4VUUnUgyHfCJda5CAqllXBYgjB4C-OiZN-qMFQ>
    <xmx:2XZkZHXu6EZpul6Ml51QzRUL2ZmaPmfxpLxEKxWU0Xlj5eHeX9-h9w>
    <xmx:2XZkZClqiv3kxVLfuDFJ7IW2IYSGqKkJie_F9JqwPbvsXCD63B9JAg>
    <xmx:23ZkZFG39h66nlIjqAJI56u55rXpuzswWUC9U7JWRRqZoyJnw6dodw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 21F70B60086; Wed, 17 May 2023 02:40:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <4e026f08-d733-4b01-ab47-e921d041e74e@app.fastmail.com>
In-Reply-To: <CAOMZO5B0stW2X6YqPTTKDpCOAzPDvm=4HT8jfBAgbTy11gnKgg@mail.gmail.com>
References: <20230516153109.514251-1-arnd@kernel.org>
 <20230516153109.514251-6-arnd@kernel.org>
 <CAOMZO5B0stW2X6YqPTTKDpCOAzPDvm=4HT8jfBAgbTy11gnKgg@mail.gmail.com>
Date:   Wed, 17 May 2023 08:39:53 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Fabio Estevam" <festevam@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Martin Kaiser" <martin@kaiser.cx>
Cc:     soc@kernel.org, "Russell King" <linux@armlinux.org.uk>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Hartley Sweeten" <hsweeten@visionengravers.com>,
        "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
        "Andre Przywara" <andre.przywara@arm.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
        "Tony Lindgren" <tony@atomide.com>, "Andrew Lunn" <andrew@lunn.ch>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Viresh Kumar" <vireshk@kernel.org>,
        "Shiraz Hashim" <shiraz.linux.kernel@gmail.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 05/13] ARM: imx: remove unused mx25_revision()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023, at 01:34, Fabio Estevam wrote:
> On Tue, May 16, 2023 at 12:32=E2=80=AFPM Arnd Bergmann <arnd@kernel.or=
g> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> This function has no prototype and no callers:
>>
>> arm/mach-imx/cpu-imx25.c:43:5: error: no previous prototype for 'mx25=
_revision' [-Werror=3Dmissing-prototypes]
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Martin Kaiser sent a patch adding a user for this function:
>
> https://lore.kernel.org/linux-arm-kernel/20220815190748.102664-2-marti=
n@kaiser.cx/
>
> It would be better to apply Martin's patch instead of removing mx25_re=
vision().

I think either way is ok to address the warning. If we wanted to do this
properly, the mx{25,27,31,35,5}_revision functions could all be removed
and the logic hooked up to imx_set_soc_revision() in the same way that
they already use mxc_set_cpu_type() for drivers/soc/imx/soc-imx.c.

I'll leave it up to you, if you want to merge Martin's patches or
a replacement for the soc-imx driver through the imx tree for 6.5,
I'll drop my patch from this series, otherwise I'll keep it for now
and we can still do it better at later point.

    Arnd
