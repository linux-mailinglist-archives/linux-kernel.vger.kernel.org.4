Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF1B678A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjAWV5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjAWV52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:57:28 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7108930B17;
        Mon, 23 Jan 2023 13:57:27 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D6ED5C01C9;
        Mon, 23 Jan 2023 16:57:25 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 23 Jan 2023 16:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674511045; x=1674597445; bh=rM1uu1HEvN
        wQPTLE5y8gAs73Yfp4O0scV92/kLTrA9M=; b=bEo0WdkcF5JUhEJ+dPriyLYcC7
        tK6ZGGaAtd5K3JkxEmF0jV9jhBO/xcl90wuCYjEWm58ausz8LC4y8/oyk7Iq+Rw4
        dHXBq1A+35ArdA6XZyYqltJyQUdEhuwtgx/c18+AAktOafp/LCv0SUBFynyGyzul
        wdZU9KhfNUI8FkK7A0Yz+c0oCQkFlBASU1HK4cZA7oxNwYs4Hu/qo4WehQ4llrwE
        k+bT3Z5j6irBYhNhl0LCRabeqleesT0JUalQtJcATaelzjrYzkiPY5MhetMNZ02N
        57lRHkj4REkQGzKYd6NJiVe6UUxYrkJDfYXD3BXkOizGijs90AQrGr0tbhJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674511045; x=1674597445; bh=rM1uu1HEvNwQPTLE5y8gAs73Yfp4
        O0scV92/kLTrA9M=; b=hcH/0Ak8+DxSXPQ5FxRWebWm90lT34xmyoSgwYY9GekX
        cIsNzlW8V89g7KiToDHSelL3Z6PhicyO2aYz7H9c1kCXHpu+n28vcfG25i8zKDOw
        fHYRyFNhNDxtIvTLk8QFeAneSW7KF4v0nz7ebY03rIxr1brocyXfH94RT9cF0/Ne
        j5RcDxr8qB67jr+Z/Sfyl7eSfTDLxk9zuWcSLeWN936xYymkc19pZh+3ydb4gQq9
        fyhIaMgcGvE6V0/wzLAyAeCSCP/6CgbGbe+1Chtzo7Od3q4YhIt2hExushi0qn8x
        V+7V56YcKEgbFLCRdbsJ+zkPtni0T1iUz3o22Ph7VA==
X-ME-Sender: <xms:xALPYwUzVt8ol6F_DBwfGhqv5wwBkFZH7r9eZI9Nt2lWqpppFefaGw>
    <xme:xALPY0lTHDAH0QrIwcbEzeZD_879LXZZAy1Vml89S3cE3yZdL3RgiGCUt8YywHaEY
    VRrb-2lnTlo_-BugCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddukedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:xALPY0Zkj_sZ0wzTa3u_sRnDiRN9JrzYSdhzlsLCK7Hq_woyzafRlQ>
    <xmx:xALPY_UBkFkXojYi_M6STB_wRQHvhYnA4Ou7NCzRwJgzijS0iJhl9A>
    <xmx:xALPY6m3MgSWGuaT9EEl3UOj5e0cjSPXI3bnCP9yv5lLoyRj0qPFvg>
    <xmx:xQLPY07ql-WaeUMSLU_60FmetuIve8cOKC7RGkJQzm8pMT96Q_1E7g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A96BCB60086; Mon, 23 Jan 2023 16:57:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <f8922fbc-13cc-4f08-a8e8-08d39ab7d63c@app.fastmail.com>
In-Reply-To: <20230123214924.27476-1-afd@ti.com>
References: <20230123214924.27476-1-afd@ti.com>
Date:   Mon, 23 Jan 2023 22:57:05 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andrew Davis" <afd@ti.com>, "Lee Jones" <lee@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Daniel Tang" <dt.tangr@gmail.com>,
        "Fabian Vogt" <fabian@ritter-vogt.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] TI-Nspire cleanups
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

On Mon, Jan 23, 2023, at 22:49, Andrew Davis wrote:
> Hello all,
>
> This series is an extended version of the series started here[0]
> and here[1].
>
> We break out what was the first patch into one for DTS change and
> one for code changes as suggested by Krzysztof. Those are now patches
> 2 and 8 of this series (I kept the ACKs, hope that is okay).
>
> As also pointed out by Krzysztof syscon nodes need a specific
> compatible, add that as patch 1.
>
> While I was adding that, I noticed some other dtbs_check issues,
> so while here fixed some of those up too (patches 3-6).

Looks all good to me, if there are no final comments within the
next few days, can you send this all to:soc@kernel.org, either as
separate patches or as two pull requests (dts and code) based
on 6.2-rc-1?

I think I previously commented on the lack of an entry in
the MAINTAINERS. It would be nice to have one more patch to
add this, whichever way you want to split this with Daniel,
adding one or both of you as maintainer and/or reviewer.
I'd keep that separate from this series though, to not hold
it up any longer.

     Arnd
