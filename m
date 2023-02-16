Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB7C699027
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjBPJi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjBPJhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:37:54 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644B54DBE4;
        Thu, 16 Feb 2023 01:37:25 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1F53832001BB;
        Thu, 16 Feb 2023 04:37:24 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Feb 2023 04:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1676540243; x=
        1676626643; bh=3qtMvMYknHGfh40A4UZz8DLaQZp4jnMbRhe8LWR0t+w=; b=Z
        a29HGkgXDBwGZutqlRmhhXBtrfdhm+RQSPaXkaZfv7g2H8BUD+XGxD9Z3gOZL3VD
        hDST43RArWz6FqW2ciSohYdggFEBr7DrSMh3JtSwgJ1U27jjoGAx1KN6HLKKTFe5
        8Vu0GYbQom02qG9k8k9ZjKF1USmDBVvEP+kwJdziu5kj8hIj7DCTKa4NCcq6hVn0
        CFwK0kG5AOMhSCGb/5uENc44bB/706/cvPX3lnHZDDA9a8hoOZpHjN9xez9FIIfM
        4QwXZ7nntvAnzJHNq32+GlRbcZ4PHfAYbbNQApR/vDj/WD2MckYLxIr1R4aKmifH
        tqy3VHLIjgR8U4LxJ042Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676540243; x=
        1676626643; bh=3qtMvMYknHGfh40A4UZz8DLaQZp4jnMbRhe8LWR0t+w=; b=j
        xevGVtKl+Wj3W5n+dwZnJO7A9RahIL2woSK1vX0bN9ORfgETkXVv62w05plyBVr5
        3j8121hBMzLwT5mrHp9ok/JKRM0RBe+MOPmPnQ5fJ30Z59Qvm0gPWBM5KHVJmtEQ
        I+iXsn6/cZjFh3nNFqw+mCQtICfB0Nlu2CV8orbowthY6+XyE2JQUq72aGdNvIaN
        ukaMhd+p4hKFkfj8O1GAEBt9nXeTbsEceRxj9Htx8jjt/xl6EEKc8/SB2Zu9m0L4
        HEpxtbnLdCOV0rg/Z2t05fbpcL9BWEuDIeQQicg4NSp+ysxcubfmHw//uOCbAjO2
        1YhfqZjcxV8CN9Inc+zlQ==
X-ME-Sender: <xms:U_ntY25cIggzzknlxJrQ0N09Is7mpzeycTAGYsY9N2ROL0tAAlyhlA>
    <xme:U_ntY_5KCjdyhs1C9G_UoHhs0NxHxckj-yxAUvjZyto6XlaTD6iLHinToxGqhp9DQ
    Yf-IMa575qJVvtU9fQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:U_ntY1d6SgyMH17ULVOhD4DJptvKdByotyBYzOBQxgU29yBP28cXzA>
    <xmx:U_ntYzKtt6TIGFh0Eoye6b0NWjCLUeHSLT5-UVxlJEr3sb1DO82PiQ>
    <xmx:U_ntY6JuK2oheuOZhcyArJWfesQyJyQiNprbSWDuaNAddh0SwyGAvw>
    <xmx:U_ntYy-5tyK7S_OmCci68nz7ncPUWIV2ERa62n7GEA4EKnV-BzpQ4A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 02688B60089; Thu, 16 Feb 2023 04:37:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <2c8d97ad-126d-4912-b4eb-37437d8c3407@app.fastmail.com>
In-Reply-To: <4f98164406cfd6da084f9ef617a6668dc4e8d44b.camel@linux.ibm.com>
References: <20230216073403.451455-1-bhe@redhat.com>
 <4f98164406cfd6da084f9ef617a6668dc4e8d44b.camel@linux.ibm.com>
Date:   Thu, 16 Feb 2023 10:37:03 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Baoquan He" <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 1/2] pcmcia : make PCMCIA depend on HAS_IOMEM
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023, at 10:05, Niklas Schnelle wrote:
> On Thu, 2023-02-16 at 15:34 +0800, Baoquan He wrote:
>> diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
>> index 1525023e49b6..7c412bbe8bbe 100644
>> --- a/drivers/pcmcia/Kconfig
>> +++ b/drivers/pcmcia/Kconfig
>> @@ -20,6 +20,7 @@ if PCCARD
>> =20
>>  config PCMCIA
>>  	tristate "16-bit PCMCIA support"
>> +	depends on HAS_IOMEM
>>  	select CRC32
>>  	default y
>>  	help
>
> Not sure how many PCMCIA drivers only use I/O memory but not I/O ports
> the latter of which are badly stubbed out on s390, though at leat they
> compile. I have a series on that part that I intend to send a new
> version for soon=E2=84=A2. That said yes this does solve the compilati=
on issue
> and there could be drivers which rely only on I/O memory and are not
> broken in principle.

There are no platforms that have I/O ports but don't set HAS_IOMEM, so it
doesn't really matter.

> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
