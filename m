Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157F07398AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjFVH52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjFVH50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:57:26 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C7419AB;
        Thu, 22 Jun 2023 00:57:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 08C2E5C00B2;
        Thu, 22 Jun 2023 03:57:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 03:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687420645; x=1687507045; bh=Gk
        KZ59lQ593WQfkM2Ne32UUdJV1b5jkhK8Vh4H1Zzd8=; b=3QIUvH519S7xyxVwHe
        t4OjA4EnxuqZcAvkAAyjlbzZGsvXllDD/qPYz/3rUESwqTHTgA3RLkvg2r1pQefz
        +8f1GWsbXk3MiZw8s+XFTPTVvcP7e+p6jN5dN7ZXoeMj/CJf4KRJHNJfT4v/DURC
        uWiu+mEgGx+sN62dmZw4bkUc1VNLPdIp1JVuBbK6OpdHNnJ54Ecum70/3u2XSXKW
        Ry6XMjlpls2wy2lL59sxfZtHWrCTemuRgq28HFLQEAQLEQj/0F6T1dL0Z5cVvzDo
        Jm2u04mOjkA9oBZXFdbPSiOEfPYnE4Iw2GCbDvFA7AnhV7TgRezHSeZMwf/YVw14
        TDyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687420645; x=1687507045; bh=GkKZ59lQ593WQ
        fkM2Ne32UUdJV1b5jkhK8Vh4H1Zzd8=; b=BPSsm07+RlhpSIFyYJ4wNWomqf3Zy
        0LEnJ5+TGP099pVOZDS/NIDaL0iX4oYy3jP8lv6nL4TKOBqIzgq0v8qBI2pYUdyE
        rK4TbM3cl0ZAl4noq2NIAuT+97JUvDSOJAGJo2jAxKt2M+DBSvrbRYvXdg3EqAwP
        WW6O36IIzQdykvbVWv6kvVPVeZ3w9wDJnXa3MFATVSQ0QMDTu8L8s9VjJ5ZccFwj
        DF6LM/O8So01hgbs5gB2AC9Kjbgi606nbw8Iwwm7xt8KOYPvpqNHABR6CoNgsFXq
        5jIoJ1lTbx7A/93MjueHqD1ZGBTF62Jie4rN7E7ZRceaaboo2xhsmrs1A==
X-ME-Sender: <xms:5P6TZAnLvQmm-88vFK30Qq-3F3-RBrJYNCa5ajPBSQ-hENzahoWllQ>
    <xme:5P6TZP2ke-wfLwwI6WDkhAdluGe0w1mT4pf8iV_VjsU3e0PeMvxMDBcp8sE7Tp1Pf
    Tglq4z9b2A0xQuhGpk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegtddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:5P6TZOrlfD17IHkZf9NvgbSqKsIORpiR3O-4CTYXB9wxDiXSexpTNw>
    <xmx:5P6TZMmMWYkJtNmEmbQazf6cQP-n404fDkUOfVf0FD-1znuODexKRg>
    <xmx:5P6TZO1LLUOSnybP5kWX1LEq-hF0lNl69UWYhcJHzmT2gabZtmW4DQ>
    <xmx:5f6TZB34Fpjv_gKy09J7s47__5-Q8NL-Vrq5-k3HIudombGwGYVQHg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4D1E3B60086; Thu, 22 Jun 2023 03:57:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <6d7d1f99-02e3-4e13-ae50-96e8b38a6bb0@app.fastmail.com>
In-Reply-To: <6d3c01d0-c809-b420-335f-551c98956493@foss.st.com>
References: <20230602132859.16442-1-alexandre.torgue@foss.st.com>
 <20230602132859.16442-5-alexandre.torgue@foss.st.com>
 <24e9c526-4128-4e63-8d28-c4ef1647f886@roeck-us.net>
 <6d3c01d0-c809-b420-335f-551c98956493@foss.st.com>
Date:   Thu, 22 Jun 2023 09:57:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Arnaud POULIQUEN" <arnaud.pouliquen@foss.st.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, "Olof Johansson" <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] arm64: introduce STM32 family on Armv8 architecture
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023, at 09:50, Alexandre TORGUE wrote:
> On 6/22/23 02:57, Guenter Roeck wrote:
>> 
>> On Fri, Jun 02, 2023 at 03:28:53PM +0200, Alexandre Torgue wrote:
>>> Add a dedicated ARCH_STM32 for STM32 SoCs config. First STM32 Armv8 SoC
>>> family is the STM32MP25 which is composed of STM32MP251, STM32MP253,
>>> STM32MP255, STM32MP257 SoCs.
>>>
>>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>>
>> 
>> This patch (or patch series) results in the following build error when
>> trying to build arm64:allmodconfig.
>> 
>> Building arm64:allmodconfig ... failed
>
> Should be fixed by this patch:
>
> https://lore.kernel.org/linux-arm-kernel/9ebb9a5a-7bc8-da67-529f-5193b9352b23@infradead.org/T/

I added that patch to my the soc/newsoc branch now.

    Arnd
