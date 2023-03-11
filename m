Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E720A6B5A44
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 11:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCKKCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 05:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKKCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 05:02:11 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91101F5EF;
        Sat, 11 Mar 2023 02:02:09 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 59AA13200035;
        Sat, 11 Mar 2023 05:02:06 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 11 Mar 2023 05:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678528925; x=1678615325; bh=Vq
        ji9kNwgOAY0G705adR/Zk+/mY3GWNulE6EVZ2CAoc=; b=fAfnGDPrx+xyPwoV/n
        sb18NsgqLLtUkhF+OpMG6/y/zUi5H7lu5X+axeL3eGVERfPjOx+xxSmxq0Wx9lwn
        uU9yQOEaD/i2QnuuPmLia+hCsS9HsHCseSWpuxnA6BirfePDLsVoJum3Y9tUHdeI
        kwIEYU9sPTZ+J0XkKq48Qt8ReiDKPUDH4CYFah24foHpPaY2EhOUU1v5d0ghCVCc
        xmgbMlpB2vFUmK+NyFPGx0XwhXJzl1la3xPCF3H2QqFn6gik5ingl1FjGmV55rcP
        t5M9PWCqug5iz1PDUS5/+lXhxQdj9dQQ0vT09XCf1+bKx5FxPrTRluiTsr2kCieB
        pS/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678528925; x=1678615325; bh=Vqji9kNwgOAY0
        G705adR/Zk+/mY3GWNulE6EVZ2CAoc=; b=K5OG5lWvbvLAxKd1g0jbX1DfxFSJm
        RIjT4JVfdmXT+lOTvZNxrJWf45CAcgknk5s81LJo5yVYexNWAtmfnO207tcYnUJ3
        +P+uJ5HJdnc06ofDQEdhNpV7x7MLjZxd4A61SBFgAbq4XM5npp+yGk9PGCiGoS6Q
        fkMkUuZyoAO1owtJBMVrdTymIWkgugWKW5fAOYxiJ94B4M6M4r1PHAoH1MB6zmAK
        ze2lDkYgwngA6cN+dqsF2FNxDJBT8gqncnBj5n76AfRkvKLVJF2Yd+nePf1W7YYa
        GSdYpCfUUMDuxp9mLERIi3lvKUMJeHw41RxnBZbTDybK3cOfSjLL3/zgg==
X-ME-Sender: <xms:nVEMZG1upFtZIvcSZYPhR7t4hQwpnsajIZW7M_ifwgdD7qscnyjmoA>
    <xme:nVEMZJEOq1q9ANO2qtJ5YkXljCxuWPrSu4bzQjrOG4T_WIXAacXBuPMptzpYlEt1O
    K2mR6rcUFO2Ip6z_xk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduledgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:nVEMZO7R92ybIAS9hfXFf3MYYkleTayKsS-pgEKGI4zil-diBCpB2A>
    <xmx:nVEMZH2iazwGwxfsjfxUTWghYxWF82OlElU4SOukE3946GSwhS3SbA>
    <xmx:nVEMZJFBUNtB7yzaX01wxMIDFhGVj6oEWpe6EdY7PUZjhrKXc0qP3A>
    <xmx:nVEMZOSP0WMMLYky6GB_d3dQGx7o-nd54c1FuE7Xht9LJeQHs2WIlA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9BB0CB60089; Sat, 11 Mar 2023 05:02:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-206-g57c8fdedf8-fm-20230227.001-g57c8fded
Mime-Version: 1.0
Message-Id: <30cce69b-f0a1-4cce-a77f-5f5ee2fc9890@app.fastmail.com>
In-Reply-To: <20230310144713.1543683-1-robh@kernel.org>
References: <20230310144713.1543683-1-robh@kernel.org>
Date:   Sat, 11 Mar 2023 11:01:45 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Rob Herring" <robh@kernel.org>,
        "Eric Piel" <eric.piel@tremplin-utc.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: lis3lv02d: Use of_property_read_bool() for boolean
 properties
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023, at 15:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
