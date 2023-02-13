Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638596952D8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjBMVOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjBMVOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:14:53 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C412057F;
        Mon, 13 Feb 2023 13:14:38 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8C3E3320091B;
        Mon, 13 Feb 2023 16:14:37 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 13 Feb 2023 16:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676322877; x=1676409277; bh=toJ0aRISUt
        MBe2PAWCD05F6YdfjUmcb8gkQpLzyWDFw=; b=BrFuVHFtixFjgWUrf3w2F2WqBi
        q6TIX7hyLg22dy/d35ZSeQpyYoegIJ0RONsRDN+HRus2Kee6Iu+yBW3aV60DT4UM
        cJjE0ynEjo7Aza7uTjLNAIyvPu8MqmshYX5Au0UxLykxS581wYBN/KjleJ4wtt+t
        f21GOGik8strKbAW0vy70tszDvbqAEEsIUk6XFcN4zHj7T1RyB9wSx/jJc3R+05z
        U7W7tf9MGoeN9A6085RCsx0FQyZw5tneo2USK1h2hUOeZVzWd7YZsyE9kQKHDpjj
        n2b6B7yJAk8TvOKKuvxHlWKFIKAyHZUj34Idqlxd6jAU6lKAddwlkvOTvvOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676322877; x=1676409277; bh=toJ0aRISUtMBe2PAWCD05F6YdfjU
        mcb8gkQpLzyWDFw=; b=DUgZr8PVEUdHZRCNu7zsb4vbtDlv/0a7cJozEOie+2Zr
        hv5OQa2EZXwIZPaAo6lUNCWYucuuG8yT86uZSWshpxisF6/mXztB/M5zk9/x+2Au
        PTPzaKRRr4OFMHG/0lPFpHXRojVUz12l4cAv+/pDbSoKFWSH4lDgjMcXhYrdt6Pu
        SVkJU6sfLdXG6S1E8zzRsK4AOmc29RL+PLARJzgLug3nK7Lcp/lzrUafvAB13Kbc
        +4k6eTj/I4p5/c/RuqG9NVUbsFsSDoEuRNCcTLzBxKzLjhb8KwjmmY821Nonxb9u
        ymbqRiJJSe4j3cLVgDfqQTARFuBvrJEnsyldj1K9Zw==
X-ME-Sender: <xms:PKjqYwRTbD2CxRNZlNFzmwJ2aDHxeOz59BSfyxqxTGNS2lD5gLu3Bg>
    <xme:PKjqY9wMW8GMzFCyvkzmJIPOP3F5O5sGIXTrM5cMmflqs8_bWdzV1d9TLKW7N88Y1
    pmJdexwrOvUduERxj8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiuddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:PKjqY915grt_AWLaIRVg24BTPP0d7FS8L8PL9BgA8CXXr1bNgPnoow>
    <xmx:PKjqY0DdqVI9AK2B9eyyJgX8E2TsusZSKlng6YIAXP2ZD6SQmoXt1w>
    <xmx:PKjqY5h4XoJaWL0aARdkIMiLR28LeICoyHlT92iGADFY4_cl7PpOdQ>
    <xmx:PajqY8sA1w1sHDLzwVwSTDZkyY9WxEapXKhr0z6A0pwG2AtXU9_weg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 77F45B60089; Mon, 13 Feb 2023 16:14:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <8911829f-3f63-4b71-be70-2f3f6bafa2a8@app.fastmail.com>
In-Reply-To: <20230214075737.3de2f333@canb.auug.org.au>
References: <20230214075542.0cf88eba@canb.auug.org.au>
 <20230214075737.3de2f333@canb.auug.org.au>
Date:   Mon, 13 Feb 2023 22:14:17 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc:     "Olof Johansson" <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023, at 21:57, Stephen Rothwell wrote:
> Hi all,
>
> On Tue, 14 Feb 2023 07:55:42 +1100 Stephen Rothwell 
> <sfr@canb.auug.org.au> wrote:
>>
>> Commits
>> 
>>   51d0bdb1f7f9 ("char/agp: introduce asm-generic/agp.h")
>>   690422657cbf ("char/agp: consolidate {alloc,free}_gatt_pages()")
>> 
>> are missing a Signed-off-by from their committer.
>
> That is in the asm-generic tree, sorry.

Fixed now, thanks for noticing!

     Arnd
