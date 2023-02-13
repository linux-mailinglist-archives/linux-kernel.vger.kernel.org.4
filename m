Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28393693C64
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 03:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBMCey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 21:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBMCew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 21:34:52 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C74AFF31;
        Sun, 12 Feb 2023 18:34:41 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id BFD753200392;
        Sun, 12 Feb 2023 21:34:37 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Sun, 12 Feb 2023 21:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676255677; x=1676342077; bh=ChGoJ4GRCi
        EK4ihxYoeB/GRDzwmtaTjjQbAlTxLyMhs=; b=oF1g34aexBhv1b0WCitgWhRbtk
        NCMOw36Qm8VxejAWjXg8mENjK4fPB+Wi5mGlPyUqA8n1KfOMcqib4EQ52m0O/w+W
        Z8Vq6f++2q3DTcAAD6Cqm5+nSI8SvxQSDh6iP3kW2OAYU5WDY6xGmComlYbv9r03
        qeiFUaq6aBSKTxNY4SyeN3Q8l2EwrVPWEKZFpepMvNmNmS7eW0/G6sp+zD/4Nbhs
        coTP/v6wzZDQHQXzlzXmh1PXQyyHimGVS4fLRIMBa8o9n35Or4pTngAbko9viffB
        +qxuowobGPIfsE0JBPVW7U5Lxpn9RDtBUfvB9m5xycncxHihBHsUjngbNePg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676255677; x=1676342077; bh=ChGoJ4GRCiEK4ihxYoeB/GRDzwmt
        aTjjQbAlTxLyMhs=; b=TZ7zSkNmZIPVKuqOEREJDO25NX1M57HSynFHTHcY2eJN
        8O9qp3DvdYBqsKC3duklBcaalUy+XKPrF0QoHIpGLnCIllkvwcd1PdPHvOIx7uqF
        ebtMjXAdlMHFBmyi7J8x0MOyDjaNmpqjuXKRyCPZG9lQXb6E0X2WRyxvrg6LwhqL
        vxKr51+OvoPbg5VndzdV2qyXB2qFR4DNKyuWwmVOdBOE5D9FUFOjMgRa/mqfo4iF
        vt3QiTTASSV6KvbgrPB/NDQE9Xg92lsqE78fJ1pwIgIv/Cgcb+EGWGIRdekbUxwA
        Gqn82TxQJHI4BFa2VH7eVvGETB5fQ8ZmCU7bx/Puzg==
X-ME-Sender: <xms:u6HpY43gaZ4s5BeMAwII7PGu4sLFE7zP7PadlzutH9GiiXxg_bh-7Q>
    <xme:u6HpYzFmxSK2wvh67PzoW1SaQgnoicsFammhAFzrmgcoOSd7gDUE-6sz5zVC1BR4s
    -bB_aUfklbE9yKTiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeitddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:vKHpYw7haNK5jYaU3a47ZK3-NefD15ad2Jv6CTN7AL-ol1tuhIV63Q>
    <xmx:vKHpYx3TpbLQRk_qu4ig22VlFo6_B-cio63wXeLEnXwERscDcMJzeQ>
    <xmx:vKHpY7G1Rg1CqP_-bA_0z8Q1MdTAxZ_MZ9TqJ04asWrruSU_Xbs__A>
    <xmx:vaHpYw6D9Fc4ocU2_GzTIh2DODwqhNUb8HaltiOA11iGFPZrTqYzIA>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E9C621700089; Sun, 12 Feb 2023 21:34:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <d7cbb0e8-20cd-4413-b89d-f7a3bb259c15@app.fastmail.com>
In-Reply-To: <20230203083721.23455-1-yuzhe@nfschina.com>
References: <20230203083721.23455-1-yuzhe@nfschina.com>
Date:   Mon, 13 Feb 2023 13:04:15 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Yu Zhe" <yuzhe@nfschina.com>, "Jeremy Kerr" <jk@ozlabs.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Alistair Popple" <alistair@popple.id.au>,
        "Eddie James" <eajames@linux.ibm.com>
Cc:     liqiong@nfschina.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org
Subject: Re: [PATCH] fsi: fix some spelling mistakes in comment
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Feb 2023, at 19:07, Yu Zhe wrote:
> Fix typos in comment.
>
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
