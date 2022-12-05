Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2338642CA1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiLEQO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiLEQOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:14:55 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFF7BD2;
        Mon,  5 Dec 2022 08:14:54 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E7D11320098E;
        Mon,  5 Dec 2022 11:14:51 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Mon, 05 Dec 2022 11:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1670256891; x=1670343291; bh=V4
        vTJpfLNp4JD7EhtbUrJAxpCsF/C0yXDqiu/DRVhng=; b=GLVeeZhbbtQTFdBhgH
        IgWxZmKO/ffO1fNtNqEqbRzZW8CJ5Zhq4cAtLz7NzMiZg0/Tcwu4iohXcIOPU6TX
        bYjtXIcpViCXMTlw5vDn5cUPyWh7tcimXZ75IXH+e+bnfiuz2KIGLV+KB47AkL0J
        ntcx/S1R8c8+g3+SkWUcI6XWgeGj9g3dGMRe2Hl55oFHL/qe5f6C/pZS9dVTGQnj
        CdsWUgJFaA6HBaVWiFMMC8ZXPEt4PuISBqPeONWJ7AFmGKELQ6s1r2MvNqndsCLF
        e+aBNyV94SMbefUNh89eCbcsI+xbavPgQGS2wrf0XOQZFuC2XgzyGp0NxCL6VOmH
        8tPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670256891; x=1670343291; bh=V4vTJpfLNp4JD7EhtbUrJAxpCsF/
        C0yXDqiu/DRVhng=; b=q2ezk8K++2LuV9eJZeqO26IOzHl10nAs8IKlk3EpCe0s
        Ya9XAhKqTn6U5z8YHh2JG3pZNCLP6Mx0gJGaM4o80j86YxZQA6OqZfdyKLtolicf
        cWlBbsv5fVKptFqQaNaNq/aUJ6NKgX34R6HMWUU4eUVbsON7fOCKK8YvQ6GlUH9I
        5dBBDo9oRde9gClfGPqztUu5MOrexE3vf+Rr5zJuMg2di6T6jJjEY64uo2D21JqS
        IMMCS/OHhg7BS/SZy7rETYpAdc2AvLvYyNXUGWg+7UcnIHQnFeTISxgFn5VN6MAl
        SI/HEr1xsBp/s6SQkGgvIVIg0M/Rdthk+dKnUebtnQ==
X-ME-Sender: <xms:-hiOYwUi1nzfJPdnjZL9duV5_2VfiX9rqY_f1TEWcBA9l942bP_3cQ>
    <xme:-hiOY0kWT4SSahXfXBB3O34xUqZelfcgOBGzWEcMihU8clCtdr6J4enXjH5WBBMDz
    WfjfiKSGGEXtLeibs0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeggdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:-hiOY0ZrXjTM_fcWE6PrWztPjyiBZBcosDzgj4zyCwe3aSEOXdtJuQ>
    <xmx:-hiOY_X8__0PYDbbLfPPswcoEwXRaVS_X-JH5zMvpA63A7wfzbxA1Q>
    <xmx:-hiOY6mWYgeheHDCkn7lHtgI289SKSSGMUZYND82fLRj8EvGyCJuNQ>
    <xmx:-xiOY8gfm2PEUh0bHPC289aPzZVnx8KKBZqjF6BGo2VatqaHEkzJfA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9D2FDA60082; Mon,  5 Dec 2022 11:14:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <73e71d99-a72a-48f5-898f-1ad72b788c83@app.fastmail.com>
In-Reply-To: <20221205100211.3155-1-marcan@marcan.st>
References: <20221205100211.3155-1-marcan@marcan.st>
Date:   Mon, 05 Dec 2022 17:14:50 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        devicetree@vger.kernel.org, asahi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: apple: Rename dart-sio* to sio-dart*
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Dec 5, 2022, at 11:02, Hector Martin wrote:
> All the other DARTs are named foo-dart, so let's keep things consistent.
>
> Fixes: 51979fbb7fb8 ("arm64: dts: apple: t600x: Add MCA and its support")
> Fixes: 8a3df85ad87d ("arm64: dts: apple: t8103: Add MCA and its support")
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Sven Peter <sven@svenpeter.dev>

