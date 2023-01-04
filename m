Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4500C65D420
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjADNaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjADN3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:29:14 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8D41EC7F;
        Wed,  4 Jan 2023 05:23:44 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6B6C13200932;
        Wed,  4 Jan 2023 08:23:43 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Wed, 04 Jan 2023 08:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1672838623; x=1672925023; bh=8u
        HX+nCZK7LlNc0MfNr5rFJQuuJKrtCol6cwSt/LyQw=; b=cG+BY2KzlyYWUbtne/
        VXUGtPLSspz0B27UIpaDk9jYF254S345Sdvsfi263UFUlHIlCaKRDEivTg+/FLkg
        t4wd66LUAxlhTovAwTGJm1QDbizfnRKaI+oFjLNLKiE5SCWoU+v686dRGbRd+yZl
        S6zbt/oehRSfGQGWaVv32INHjPwpijbVBLTNhyGIGWw/ut6z5wV6LRnJLdGagZV5
        9EZiHeAHZWz/2qg/bFcRYfy3PHHzAjyNHwG6vGykgc893SnIFeT2RFJBD8PlDN2u
        K8IalOZYiwhS6FRD4A5s9tPieXrQl2IvwucDpIA4j3XLk8LshF+Ht0DFhBl++Jol
        P/iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672838623; x=1672925023; bh=8uHX+nCZK7LlNc0MfNr5rFJQuuJK
        rtCol6cwSt/LyQw=; b=dLGRDPCOMP/TwUZtTg2q/HitiRGbr6G7kfFKuLqGi2+d
        gEdaX2NYKbe0JgMIo1FbMu7GSPMBjQFjTkxvfYvyCtHUen9M/HgF30ApPX7t1Ag9
        i/JBWIqjbs7184VxGwB9bxRrRs/YVEnW5NMkZXaspy91MnwdC26JND9a892M/ncc
        YkBnjMAW7W/xxx5AIgwaserA6bYC48sUt2fdTyfh13Du/ITvNL1IAj4G+hoFOhKE
        DuJDTtLJRIfa3ED3AZB3+fwkxqz0G6ms5lK2WIFt1aUWhwTfq+y4GOo37IgiqU/5
        sWKW3Ir0K+DVj20bYRwIVkk3ghDOzTK5czUTGVlUwQ==
X-ME-Sender: <xms:3n21Y5UWGN0mwBgX-i7HOivpb-iaIpp5N6yP6I_mDBb6aHe3fBGI5A>
    <xme:3n21Y5mX3RbevceEexkBZj9GPNKiH-R4A26mgMiQbR0oPb5NKc68XAHhq1pSDc6Mc
    IUUOFJ6ztYmh_Wsb_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:3n21Y1Za-TgRMDRwshwfCl6nxYcS-c3VGAsvKHRW7HM7Aa4M9rFMCw>
    <xmx:3n21Y8UmgGkeFzmgohmsoXk-_W7CM2oJNYplGTjCr0ytHlnlrimXIw>
    <xmx:3n21YzlERd6GbIl-NKH1HIJEyJ6Pt51VoSXq39CliJ1rW92irWa5Jw>
    <xmx:3321Y8dWWdSVtbMqzLSN6wgSNTjLzo3mRkbVhbG3nmyXzx-62FehrA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 98036A6007C; Wed,  4 Jan 2023 08:23:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <a084b6d4-0167-4ae0-8397-f591809b628e@app.fastmail.com>
In-Reply-To: <20230104110013.24738-6-marcan@marcan.st>
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-6-marcan@marcan.st>
Date:   Wed, 04 Jan 2023 14:23:22 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Janne Grunau" <j@jannau.net>, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] iommu: dart: Fix DART_PARAMS1/2 bit define names
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

On Wed, Jan 4, 2023, at 12:00, Hector Martin wrote:
> They didn't have the PARAMS reg index in them, but they should.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---

Reviewed-by: Sven Peter <sven@svenpeter.dev>
