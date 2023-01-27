Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F5E67DB02
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjA0A6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjA0A6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:58:15 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F0ACA37;
        Thu, 26 Jan 2023 16:58:12 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 983BF5C016C;
        Thu, 26 Jan 2023 19:58:10 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 19:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674781090; x=1674867490; bh=WmwsakFQbG
        fg1ezI9Gsc9jkNreMt4GHPJItdrYtmGyA=; b=F5rwWncsLFk2OXNhktgk9/Klbf
        2SedEqj3xrW+a3fkPTBHRu5sVOBv6svg8H/vWJzzKrjiyitYz+032eMW4BgL27EF
        kALYJGq9lBEpXYj0avg7l1Jcw/dGaupQM106z91SQLSa4cWuQqu+wewNYRXXWoKp
        N5MXpxyMts85sLZerrAtm1LpwXcfkZJpMPw3566BTrJwuIdxzCY93x4/9tPvfNfj
        d7iNcpjzzCI40ieaIijaGkn5b9q5dMSpnIvXmJeUwGzogu3HFe2qPjvc1OwHniPz
        p4U75OP0t5RJ31dUm3kqSDQ6Gun5575XpetBm8YR3ZJYTWNcu+4gRv6Z0vYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674781090; x=1674867490; bh=WmwsakFQbGfg1ezI9Gsc9jkNreMt
        4GHPJItdrYtmGyA=; b=tE2Qg3BAX9qxk6bAwo3l6BQRyxpUPUuc8pP8WIRa+eWW
        27klzL9u/Kg0eEAZPsOeLOom+l7eSrCN/yN1zcnhKpfPjCiFZVTRjGjled+Ippn1
        j4P0fa7xaM9MePQizPh5fhfNqAR619jkCJtWmxesgVcm2t+tUEkE0ldRICxYsXi1
        lskvDAGLOLtKDIXcEIlmNCR/FCituuOhUUek/2nl6uc0362guqAD0uFYLq8KBLHI
        EFEa0++cPVvD59PxUkMeUANm4gODqb/+FpHqok1NlPzMZXpsk2v3eEP8VQIWmmHE
        3oDGlojlOZzQkr0/gb++44GlWiUdiusZs1h9RpYeWg==
X-ME-Sender: <xms:oSHTYwE34dxyf395mNRF35Nb73POUCxWVe-maVLOiMnX757wmQW0Rg>
    <xme:oSHTY5VtMT5IE1bCxjdJ1Ce4RhwJGRreWcm7G2lGr2XgqJXoenxlRx92cUss091Xf
    -Dvigb_fyf7hGPNyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:oSHTY6LeOxYyI9HTQL9SJUWnc002marlCxCkLlK0eHaEjR9mBlF7cw>
    <xmx:oSHTYyHDvj-j1gFtN3hnK7ezFonSeXX-bIUpZcj3BvVtE4VT5bDioQ>
    <xmx:oSHTY2V_OETe_xLWby5OSpqOsmYdhPgKw6OzmIgoQSCP_vxwoQCZcQ>
    <xmx:oiHTYyTu_pRuTkER4JNSq4Y9XLjO-BlJA5bcq1G2OYuCT17W5jxU1w>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C158D1700089; Thu, 26 Jan 2023 19:58:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <651c34fd-69a7-4317-b21e-9229f07c71a9@app.fastmail.com>
In-Reply-To: <20230126213123.884125-2-eajames@linux.ibm.com>
References: <20230126213123.884125-1-eajames@linux.ibm.com>
 <20230126213123.884125-2-eajames@linux.ibm.com>
Date:   Fri, 27 Jan 2023 11:27:49 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Alistair Popple" <alistair@popple.id.au>,
        "Joel Stanley" <joel@jms.id.au>, "Jeremy Kerr" <jk@ozlabs.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: fsi: Document the IBM I2C Responder virtual
 FSI master
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Jan 2023, at 08:01, Eddie James wrote:
> The I2C Responder translates I2C commands to CFAM or SCOM operations,
> effectively implementing an FSI master.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
