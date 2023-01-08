Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB23661588
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 14:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjAHNlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 08:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAHNlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 08:41:13 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22EABCBD;
        Sun,  8 Jan 2023 05:41:11 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A73295C0099;
        Sun,  8 Jan 2023 08:41:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 08 Jan 2023 08:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673185268; x=1673271668; bh=pzHAbdQL+W
        AHy+4O5PrQB6Gr0C7YcxjNyQrc/0x2zps=; b=Xa60G+rAC3iidMuZ8dtIXstRWH
        Qx5c+WT240uC48PQfQMNI8+0MAGnGwQmQfqUbbAz+wzI9BDMGSzPWf+D/zVPRzPw
        F2Iu+jB0pwqLfON9lnzcoQrcLKIsZNHXfZj6hi+CGRFZXON3992NLMnIJnuL2wrN
        g1pZI/k/72M3XHUMf0ZgmFwr/0Fa49KLJe6nunUkxBPk9cosv+mYzVy1eRdvM7Co
        9LAZdLzqth0xPEIQOCM2OoItmHQy7IoTH+FznjWcrFAr1UrTmp0TeS2WVbwt6fjr
        LJE5V1DzUPkvjyZ/+L7PjxPvSgi8WnBb1mR669kQQXo1iWjuCIbjfDSJ4xcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673185268; x=1673271668; bh=pzHAbdQL+WAHy+4O5PrQB6Gr0C7Y
        cxjNyQrc/0x2zps=; b=loQ54YCdSXJiSI9Kv2X090IUbTDQrvox1ery1xh/0BA+
        2MFmALo/stswBhFe5HEahH12k1CTXZI9RvBH3e4+k6IespOTCnsxrlKN8BriPnVU
        F4pD6Qx9fDrn5VDpAjfEBsozSaj9s57lUJBk/ZW0JWAEInRLe9hlvgy9Dd5weB7E
        neGKSM4YqPWy4glkgHnwpDGl8ursUViECbhKubs37ejTWL6hPr481CuIQM3XaIoT
        +4Jx4EnFn5OpwqlckzbO1HAHUKTPybi+1mnhsSNTIapC/v4I0l+n5os56nsnThB6
        +tUEJoUBdBSvAFezHQxsS4gGdVUzkNh7JKQv3MByCw==
X-ME-Sender: <xms:9Me6Y8Sa5-Hm01QBr92QnMfE4XDevhMmcSSkkQyXs7JdE_CN1abBTA>
    <xme:9Me6Y5wZTzFcbjWJ0qwZirJan6nV7zUZP3tX_SklTpIdphp4VTl53wdLtph8ozXZa
    PMS6OY1fLYic1ve9nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeggdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:9Me6Y51n4OrHfZe-hh-e-ZOVlAqkHwyYa-McpmAwsARQ0xkOANfF8Q>
    <xmx:9Me6YwCYQo66qrLhIxD34OOuvT14sTN25j4EwWw1PUEL5cMJKHUFYA>
    <xmx:9Me6Y1h8LsPyPO251o6t5mM1TfzXHyVGEr8eN9Kb6jNcKSCUwFa2vQ>
    <xmx:9Me6Y-ZumOpxlL0Jv3IWIl8XxzlJUWhs-KuDStSvLqxzrDdK-YKpfQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 23398B60089; Sun,  8 Jan 2023 08:41:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <2d085660-41a2-492c-a343-7df80d510a59@app.fastmail.com>
In-Reply-To: <m2sfglh02h.fsf@free.fr>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-5-arnd@kernel.org> <m2sfglh02h.fsf@free.fr>
Date:   Sun, 08 Jan 2023 14:40:47 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 04/27] ARM: pxa: drop pxa310/pxa320/pxa93x support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 8, 2023, at 09:49, Robert Jarzmik wrote:
> Arnd Bergmann <arnd@kernel.org> writes:
>> There is currently no devicetree support for any of these three
>> SoCs, and no board files remain. As it seems unlikely that 
>> anyone is going to add DT support soon, let's drop the SoC specific 
>> code now.
>
> Hi Arnd,
>
> Here you're dropping pxa variant support. For the currently 
> "partly" working boards in devicetree, such a zylonite, this
> will break their current support.
>
> For example the zylonite I have which is working on DT has a 
> pxa310 variant.
> The cm-x300, which also works in DT, has a pxa320 variant.
>
> What these boards need is their IO mappings and cpufreq to still 
> work after
> your serie in DT. What bothers me are the changes to :
>  - drivers/clk/pxa/clk-pxa3xx.c
>  - drivers/cpufreq/pxa3xx-cpufreq.c
>
> Here the clock changes will probably remove the clock provided to 
> specific
> pxa310/pxa320 drivers for example.
>
> I don't know how you want to proceed, yet this change will break 
> some pxa3xx platforms.

Hi Robert,

Thanks for pointing this out, I thought that I had caught
all the missing dependencies ones after you pointed out
the AC97_BUS_NEW that I fixed in patch 14.

From what I can tell, commit b5aaaa666a85 ("ARM: pxa: add
Kconfig dependencies for ATAGS based boards"), the
PXA310/PXA320 DT support became dead code because
MACH_PXA3XX_DT only selects CPU_PXA300, so if it worked
before that commit, it now needs CONFIG_UNUSED_BOARD_FILES
and CONFIG_EXPERT as well as enabling one of the legacy
board files with the corresponding chip support.

If that's all you think is missing, I can add this
trivial patch as well and rework the series to not
drop code that depends on PXA310/PXA320:

--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -45,6 +45,8 @@ config MACH_PXA27X_DT
 config MACH_PXA3XX_DT
        bool "Support PXA3xx platforms from device tree"
        select CPU_PXA300
+       select CPU_PXA310
+       select CPU_PXA320
        select PINCTRL
        select POWER_SUPPLY
        select PXA3xx

Can you have a look at the other patches to see if there
are more removed drivers or platform bits that are currently
dead code but are actually required?

     Arnd
