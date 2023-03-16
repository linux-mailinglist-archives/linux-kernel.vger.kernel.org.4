Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25506BD26D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCPOcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjCPOcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:32:51 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EDC525D;
        Thu, 16 Mar 2023 07:32:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3234A5C0102;
        Thu, 16 Mar 2023 10:32:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Mar 2023 10:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678977170; x=1679063570; bh=7i
        jgDLmeD93wpp+M55EYZJS5ULGYTFy+YLaAjY5QCeg=; b=ipcazilBXEO0ZY6s1W
        9WuRMl/4v/E6eQQC71UmnrLZtozKVeban5Rh678kB1G4H8vw8F+xPKIURPWzB03k
        njVVIoTJwK1ZCp4bv+xj5S7Hov3vQaJI26ybjsQRjFtbqNsyBfcgdyoLnb8lAWZD
        ghMsZi6OhqU3VbW3NeOil/HLNpXLSUluKkKSa9ye4/6FJaq4V3rZe57liIqOecX/
        nAxjp3b1T8/XjoMpfjN6OLBGRme+MoefdBfmjYnec52LFGs5DOp12D8klrDxhHFo
        WdgWjssHtFDhKFgsTu91+PYt6+yx6KCk5FwkHPGeryXVQ0itjYV/NwfgMR/k/8Jy
        uU0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678977170; x=1679063570; bh=7ijgDLmeD93wp
        p+M55EYZJS5ULGYTFy+YLaAjY5QCeg=; b=StR/rei+APjw5flVCNJNOHwtDB/2J
        JZSyTHAXTiTVonUxXgRHQAbz/leve8o/WT3UX5S//khmPU6hHk/Ee/rwENThT1Ce
        FclrG9F2GteA9N2dO13RewnRv4Vv7Us1DPKeYlIvJ94ecanyfvVUMlYEffdBd0XR
        Wv1RWGXbKL3LSjOHSlOgrC8Ugknt6NHJ5nZ1bLYEFfUVVZdy8oRl7qA5aPxcqphS
        7nLbnYchav8x/ma05Qza7PpHcx7rTeyB/aBEVmavyyOP8W6T3YwUu2H+rA6NiTjT
        HgoDxnk2S7V0oCPplLIgqH2bbTHyEyXhalJQrNmSdbtGIY7Mwv3ueoh3w==
X-ME-Sender: <xms:kSgTZPU0vxEOGguKyhWR-y6yTqbicRbDFJ6ZEPhRAedFETwveavCmw>
    <xme:kSgTZHnGz-fBMfXDnTgWPVCe9XgjY-EJDTuLw6mPOK5fKV-ng3GdKSh2njm5F3f4j
    YDX1VFU8gD5aC866xc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kigTZLaPtDxlQBy5FunB_zqckRha-lfISqU_tZm0EJjNrdWD_7leow>
    <xmx:kigTZKUgqqaCJax5KdYEF3izN02GjJnLMkrkXlt5jlRETJdttw5dCw>
    <xmx:kigTZJnoIzrgTkXn2BQ5SWiwEqgWPnA3Mf6LCDjdVSraNRd3J9E23w>
    <xmx:kigTZLkM2Lwr7pPMVD4Tmtz60u1_hTXzKnpK0prhnhgFrlyWLb4A2g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EAD3DB60086; Thu, 16 Mar 2023 10:32:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <235fcb71-9e96-4f28-bb8c-6843d4d85cea@app.fastmail.com>
In-Reply-To: <f8b323b4-fd07-f5fd-70cf-31450e9ef204@linaro.org>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-8-ychuang570808@gmail.com>
 <f8b323b4-fd07-f5fd-70cf-31450e9ef204@linaro.org>
Date:   Thu, 16 Mar 2023 15:32:07 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Jacky Huang" <ychuang570808@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH 07/15] dt-bindings: arm: Add initial bindings for Nuvoton platform
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023, at 08:33, Krzysztof Kozlowski wrote:
> On 15/03/2023 08:28, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>> 
>> Add binding for ARMv8 based Nuvotn SoCs and platform boards.
>> Add initial bindings for ma35d1 series development boards.
>> 
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>  .../devicetree/bindings/arm/nuvoton.yaml      | 30 +++++++++++++++++++
>
> And what is npcm for? Why it was made an directory?
>
> All these should be just one Nuvoton.

npcm is an unrelated product line, so I think it would be best
to rename the npcm directory to nuvoton and move the new
file in there, though I'm not sure about the name or what the
other chips are called.

My impression is that this one is more closely related to
the older Arm9 nuc900/w90x900/n9 chips that we dropped from
the kernel a while ago, while the npcm family has a different
origin.

    Arnd
