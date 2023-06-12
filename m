Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F254772C81A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbjFLOWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbjFLOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:21:52 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393475592;
        Mon, 12 Jun 2023 07:19:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 16FDE5C012F;
        Mon, 12 Jun 2023 10:17:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 12 Jun 2023 10:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686579460; x=1686665860; bh=aP
        w1HIovDb5iJ4pYiKtcUIbVnbrPXJ4FRPPswedoB04=; b=xlRymHB7jHhqWfKboK
        BHHqpl7IpRva7ElJrYLJVJASMlzQsmeKtxySzdMSNVsP7eM9qWcHiklcKHH8ldrR
        e2RbYqLHf7hMXK2baDiAZO8QAuN8vWyOJ8O49CSDjDDJMweOyrGHjLXFwcxKTuQZ
        Zvdd9KLvcL8IYb/BgzodMn7SnK4Mcd9ujhGQmmts2bhA677S4nrIAi3KxkQXyODo
        Xt2PNj7lyC/8YcUAO9B4oCGwFBTeTuUMoeVIkvBAJMJvtm/2SHU8d5Max+IyJjB2
        79kVFZQZ2LnrhrOI1tsi8dimV3t1/20ootFlgrgxiD16eaWycOj8gyOpkExJoaeG
        esMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686579460; x=1686665860; bh=aPw1HIovDb5iJ
        4pYiKtcUIbVnbrPXJ4FRPPswedoB04=; b=kXCb8NjVNnVfQaNku5rC9rlj+tYCE
        FdaGelcMW8aCd0ol5JRcA3cj06/McwJhHYP5iMJXHVaraLvikWcfJFL3XuUnPf+J
        /BYOF70bL9Xx6bqTP9b+vFPtkrV8wKNR6u116mhWK6rNBw6N72HkBNqZWKQcF+BC
        WvrJTzswEm7G/9qBGrIaMgpVLn4dGH+9DMmf5A4T8axThkoHPPiZBYd+yUvHB68x
        m/lMiszjdT5Bv6TlfZiAXHYZK66n+mBC9zmsY8mV030VXvRhHM2Y6rQoqHYqJmf0
        0sda/0ZdjQiR5SRYwKyR0nvGr0D3iFQP94EhgW7tEynpyckb/20r6kPfg==
X-ME-Sender: <xms:AymHZIjn2lJtucqP8ooR0CmlmbD3XpfUMkn_7M1TJnAgC-paBlWwDQ>
    <xme:AymHZBDhjpxmEeBQy3Z6Yobz7aMaIA4ZUANBqO_qHurvdSEXB4XwWea6XgMS-zW-h
    b12jHG4SWq_j3SvdG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduhedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:AymHZAGMKlkcPuUrADy3F5CyMZkm-HOzaYM0AgMch72sCXleBR1ghw>
    <xmx:AymHZJTutWTBlZcjFTGMxY6LX_FoQMoY05VLUoMHSUXiBpaEvBpVFw>
    <xmx:AymHZFxRg9o5UgK776RV8TsNgTm026ETAkIi1sxIQYOPmKKYaYQv4Q>
    <xmx:BCmHZL4WckZf90RZhXQG-JfPfmj6SjErT0aGgG875uhd06imw642Lw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 946CDB60086; Mon, 12 Jun 2023 10:17:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-492-g08e3be04ba-fm-20230607.003-g08e3be04
Mime-Version: 1.0
Message-Id: <ba58f0cb-3683-4aae-8c10-2fad2e701501@app.fastmail.com>
In-Reply-To: <7846c69b-5c2d-16d3-6079-d11a60171a69@foss.st.com>
References: <20230609120546.3937821-1-arnd@kernel.org>
 <7846c69b-5c2d-16d3-6079-d11a60171a69@foss.st.com>
Date:   Mon, 12 Jun 2023 16:17:19 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Arnaud POULIQUEN" <arnaud.pouliquen@foss.st.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>
Cc:     "Ben Levinsky" <ben.levinsky@amd.com>,
        "Tanmay Shah" <tanmay.shah@amd.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Dan Carpenter" <dan.carpenter@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] remoteproc: stm32: use correct format strings on 64-bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023, at 16:10, Arnaud POULIQUEN wrote:

>>  	ddata->rsc_va = devm_ioremap_wc(dev, rsc_pa, RSC_TBL_SIZE);
>>  	if (IS_ERR_OR_NULL(ddata->rsc_va)) {
>> -		dev_err(dev, "Unable to map memory region: %pa+%zx\n",
>> +		dev_err(dev, "Unable to map memory region: %pa+%x\n",
>>  			&rsc_pa, RSC_TBL_SIZE);
>
> What about cast the RSC_TBL_SIZE define instead to ensure to be independent from
> the arch and to match with the use of RSC_TBL_SIZE?
>
> #define RSC_TBL_SIZE		((size_t)1024)

I have no objection to that, but I don't see it doing anything good either,
as this is a constant value that will always work.

     Arnd
