Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AF2686BB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjBAQbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjBAQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:31:08 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C669022;
        Wed,  1 Feb 2023 08:31:07 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 988485C00B9;
        Wed,  1 Feb 2023 11:31:06 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 01 Feb 2023 11:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675269066; x=1675355466; bh=HBe0UtsXWE
        KmleB/OWz3sMDKkkgpg1BX+68MaU0SEBs=; b=BgEykYgt3EfWbM4WGaLUMb016P
        RTGFI21UU7aall2YT+f6gQBnDRqc127KATh6Ui7mAvZBbC79GKCS6MlpVcZBgFG0
        xWysUxEBnVFElROTqa5Yt+U76zqiWBPxXcLQKqQ9YqF2BGjZ3+3DlaHj7sHMgo2Y
        dKd8pX9KHZ+et55LVd0an7IKlEZCcoLifo/1+pCECkrvjbPuLjJnhIcIU+TN8oyY
        e35RyTyyhRn/c3hKzM1FMAsjgQaHeNlOIjQ2afyieZmdlPiZEvJr0DJKo24Wve6E
        X/66+GYyDJWHJtXU3XVn+WtrTlw5DYezSXOt8O8O0dnLqUtjJWBymX9RTO7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675269066; x=1675355466; bh=HBe0UtsXWEKmleB/OWz3sMDKkkgp
        g1BX+68MaU0SEBs=; b=EPSIGyzi7heEz9Rd/kHd3Puz/5GFWMhXB0h3kKEbGjHd
        PKlVE47RSxYF4CF8Bu5klMvzrQNN0e7e2kDokrVB+eUIJ1lftagFewNf1C/IeQTd
        DaI/1vUlEp+Ol0CUCLhSdiCwB1QLZLZLsXTJp/f2F2LitLycZaWZ3dmHD8+TSqsN
        0x5kAlTEVCXx94PFmXanUeeakw3dfWoEDk40b72+yNAPT1tRUes9ISiz/X40Gp9l
        M+G+LGItHn8CSWOTqMI3yj2/18AsH78/P+oFg9qmNtXcq8RIkWtx3I+0OLTH/zUS
        Rpykg7DK51jvPxc56EtUvMNafS5q2rpvJ4/DBhAdEQ==
X-ME-Sender: <xms:ypPaY14fY_MYAwx_r-v7811qnBr5eopUZ76ZbcPYX4i2e6ryFPetag>
    <xme:ypPaYy7rAGY8NEKrQdqYApFx73yEGMOLW_x9RQx3X5P7CTXyEsV1LDEDJAq52Nvtd
    OanvtFmeEPfZnMVBWI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefiedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ypPaY8fOd-sIKfjxsaVCPMYGobR-wgG7V8q9OvXdb8oqDHRaZ5qCbA>
    <xmx:ypPaY-JAIVwYEDuY7wh9YaCWIj4-CFW7KStFAtXQMwVzhvQZkdJStA>
    <xmx:ypPaY5JwDyNkS8WAui3SMLW2DQz1bIpXczAEAWAk18kgnegZDsWZgw>
    <xmx:ypPaY3jGlmGWrXV4NHCoWHzMLaQb9AS518f4nspYubr3oqSWnoi-Ow>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 09DFBB60450; Wed,  1 Feb 2023 11:31:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <4c625a02-f500-4a49-b5b5-b5de57f5b612@app.fastmail.com>
In-Reply-To: <Y9OaE6M9CaGYvVZD@google.com>
References: <20230127161233.5c21c04f@canb.auug.org.au>
 <Y9OaE6M9CaGYvVZD@google.com>
Date:   Wed, 01 Feb 2023 17:30:46 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lee Jones" <lee@kernel.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the backlight tree
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

On Fri, Jan 27, 2023, at 10:32, Lee Jones wrote:
> On Fri, 27 Jan 2023, Stephen Rothwell wrote:
>
>> Hi all,
>> 
>> The following commit is also in the arm-soc tree as a different commit
>> (but the same patch):
>> 
>>   6e9b5cad13f0 ("backlight: Remove pxa tosa support")
>> 
>> This ia commit
>> 
>>   9041bd1aff23 ("backlight: remove pxa tosa support")
>> 
>> in the arm-soc tree.
>
> This should be removed from the arm-soc tree.

I had hoped I was done with the rebases, did one more pass and
removed this one.

    Arnd
