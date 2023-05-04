Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A966F6647
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjEDHtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEDHto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:49:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C06810B;
        Thu,  4 May 2023 00:49:43 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8CC1B5C04C2;
        Thu,  4 May 2023 03:49:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 04 May 2023 03:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683186580; x=1683272980; bh=n2
        GbdBfIgCBE58XNSQRg32j+lkULH8rlZExOFkhoATU=; b=NpUQT61PnuCvxpZQ9L
        r2vJRK57pFzOadLeneWmS2d6J4S92NYySlykPB+NcFW4/D41FN/JidU9ZWZQCDhl
        WQWmeaz088E5ZL6nxKqiBPjSDoBoL1CPrpPO/L5V62rCaLs7adI6zTc0A4DospA3
        QP+IZR01f4h8c4VXzvqAaM659ePEdj6Z65qfNVSSE7vFCNzz9nDitxw9ezWzJsKM
        dkuuUi8teR17JYF9k7dxZ/EvJaKN4nT4Mx+d8qEgPynSQN7i+w/WOFE2YGNwBOmq
        REe9KiXlsc8HQ/w75+7ukdYqEtqp0oiT2MBmJWOXsmKwmO2iaCna4MwG8TU9d1k3
        cWeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683186580; x=1683272980; bh=n2GbdBfIgCBE5
        8XNSQRg32j+lkULH8rlZExOFkhoATU=; b=N3QH6uoTp8OfXd8qt5f6/4cDDN0DI
        PxWGyiuu1mKeeWmUs9X7Xf0eGqASgfFfyUMzKoO7e58rozalESbgKn7vMy8WYuWw
        1y9Tvsswqp4OMJoTeOXnwuHz2BX1/YaAtMyKL3PO3vkkAlmxO/vNzRKMJs23BqNJ
        8Ie47owE0UCJkRmHwY2XTkooXBxlklqVPdqNa8tuXdtzJDomuXyb0t/rwuWWpMWv
        b/Qn5PwZS2XBLCy1yiggWO0z96HmO9N0kKJHbjdcBdlT9eOYYiEV4yYCYo6tp014
        awIshPQL8YyOq175Et/1wVi3xpB9UM8iNJBJqQVxFqXfDaXPGh6yrkDsw==
X-ME-Sender: <xms:k2NTZM11WBehmDrimYGaqmhPSp308g9IgJD5creEfGc5y6pRXulydg>
    <xme:k2NTZHFychF0oAlEkWHEqNvZvCTM0CkrDdO-HHvSyTE2WxjLnlDxmB0BFpNB3agB0
    wB7AfIiaI-LpIIHSxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvledguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:k2NTZE6YGLbMnzjjS5plkNa9c1zOIA3NRPUWgolCm-U_TXd75oI7Hw>
    <xmx:k2NTZF1ZGvLWlA2AEbmfAz8qUPKu1yBw1pA2AuQECvqWIWefH_o4GA>
    <xmx:k2NTZPFegQWsoS2rsdthHljjLQNRYsrvuU9V_j0yocmlAtBrRTKLkw>
    <xmx:lGNTZN9Ro-vGT1NvHngo5BI70ovDiID5EG2K00a7QXgU8m0UJj2QhQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BCC33B60086; Thu,  4 May 2023 03:49:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-386-g2404815117-fm-20230425.001-g24048151
Mime-Version: 1.0
Message-Id: <c99babb3-532a-4d00-876c-3c316b456325@app.fastmail.com>
In-Reply-To: <8ce93998-84c3-0640-a6e1-76ff17b3953c@linaro.org>
References: <20230504033726.93-1-ychuang570808@gmail.com>
 <20230504033726.93-2-ychuang570808@gmail.com>
 <8ce93998-84c3-0640-a6e1-76ff17b3953c@linaro.org>
Date:   Thu, 04 May 2023 09:49:18 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Jacky Huang" <ychuang570808@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Tomer Maimon" <tmaimon77@gmail.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, schung@nuvoton.com,
        mjchen@nuvoton.com, "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH v9 01/10] arm64: Kconfig.platforms: Add config for Nuvoton MA35
 platform
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023, at 08:32, Krzysztof Kozlowski wrote:
> On 04/05/2023 05:37, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>> 
>> Add ARCH_NUVOTON configuration option for Nuvoton MA35 family SoCs.
>> 
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>  arch/arm64/Kconfig.platforms | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 89a0b13b058d..c1f277c05569 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -236,6 +236,15 @@ config ARCH_NPCM
>>  	  General support for NPCM8xx BMC (Arbel).
>>  	  Nuvoton NPCM8xx BMC based on the Cortex A35.
>>  
>> +config ARCH_NUVOTON
>
> Either this should be ARCH_MA35 or you should integrate it with NPCM.
> ARCH_NUVOTON means all Nuvoton platforms.

I'd go with two separate Kconfig options here (ARCH_MA35 and ARCH_NPCM)
for arm64, but keep the shared arch/arm64/boot/dts/nuvoton directory,
I think that fits most closely what we do on other targets, and there
is apparently very little sharing of IP blocks between npcm and ma35,
if any.

      Arnd
