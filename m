Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC626D6589
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjDDOiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDDOiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:38:17 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB36211C;
        Tue,  4 Apr 2023 07:38:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F05C5C01F2;
        Tue,  4 Apr 2023 10:38:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 10:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680619090; x=1680705490; bh=uc
        91/CUruYStRNWVXvGcBM2haHyPK49E7hmhbx44+wQ=; b=cr0ak/ax73X0U2TZ/N
        9Ci5ykJxDy0hlOzJtXExxSCWO3PuxVfKOKGuLKslCwfwlQE7o6vaxxGI35y7vnKk
        0HmoutwA2iPF/yO0dxZY3CtVvVsIy0nOKlx7UlfM0hffCG0gtsfAC9QXfh6mqu0o
        7YDlxxT2sWQYJuOeWHuD/SVp9QjOIyS51TmvsSfE1Jzc7kHN/ScfUrEiwZOovasf
        2oh/SbrtPy9L7YKSQl73shqwI/F+TchUx1IBcm1MrgIqGpvgBLkYo6fIHUJ20xU1
        TU72CLnBo8hu+AJgxlmkSKBIe40myzVvTKSDTFUf5LbeOak05alma1QYO1gv8V/3
        R7jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680619090; x=1680705490; bh=uc91/CUruYStR
        NWVXvGcBM2haHyPK49E7hmhbx44+wQ=; b=nK2a2FeGhuOK4K6LGxGOQdxc4kSkY
        lTOTdIJ2iIL6CFwURxfqYxflM3xnv8BCXbRytBxjWb7Pp1O8W1PqGzo7/GGLptbG
        TtexyI4qf6D2miSvYcsEn5rmnP+tl8bAG5cGNE6mDiNqOIgLQOVutoXpPejYaYHl
        4kApjuilw6zYHJQNhlfF/UfZ64JPeFfHG2DN2uXSFd98nPb+ILoE8eiskeN6AnX8
        Rti0VBgdthoB1B35T36suxClYvM6evdCgsgTSuflMvcmrAjWlVcovNg70EI9Abvh
        5+ADlMerGqSEi8g92Ew31UyLfRm/BOTY1u0AhApKN0/nXy0aKX2cyvsTQ==
X-ME-Sender: <xms:UTYsZBLorW3tY1zvMVXFZ3cesNHjStT3_cAERzTNsPh-RuGoCaQwog>
    <xme:UTYsZNIXGsY7cUMXDMq6OUsdUkmDQ40Df7xp551uroEON2zAPdvVNV9AUPjjxR8NS
    EaKHeZnVuXntXX29q0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:UTYsZJsoe9PDD-rYNjFgQI2PDvcryRL0jjSxURUOU9l3PKBlaJLTyQ>
    <xmx:UTYsZCb4ss_ynHnXy58sM82agjBS7wtX0LULG8LN3ki3bL7Ob_yx7Q>
    <xmx:UTYsZIaQcS1DusLJtm20XsqyRjnID-_wHaEdYN19p1stfERLI0b2Qw>
    <xmx:UjYsZFRQFboUXJEt3Cflxf20i3V5-mgACuvv0DbqkAts1zPrlYp7Zw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8B3B8B60092; Tue,  4 Apr 2023 10:38:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <86d63038-e3f5-4c03-b904-a26761b0578d@app.fastmail.com>
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
References: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
Date:   Tue, 04 Apr 2023 16:37:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Olof Johansson" <olof@lixom.net>, soc@kernel.org,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Russell King" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Daniel Golle" <daniel@makrotopia.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RFC v2 0/4] ARM: oxnas support removal
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023, at 09:42, Neil Armstrong wrote:
> With [1] removing MPCore SMP support, this makes the OX820 barely usable,
> associated with a clear lack of maintainance, development and migration to
> dt-schema it's clear that Linux support for OX810 and OX820 should be removed.
>
> In addition, the OX810 hasn't been booted for years and isn't even present
> in an ARM config file.
>
> For the OX820, lack of USB and SATA support makes the platform not usable
> in the current Linux support and relies on off-tree drivers hacked from the
> vendor (defunct for years) sources.
>
> The last users are in the OpenWRT distribution, and today's removal means
> support will still be in stable 6.1 LTS kernel until end of 2026.
>
> If someone wants to take over the development even with lack of SMP, I'll
> be happy to hand off maintainance.
>
> The plan is to apply the first 4 patches first, then the drivers
> followed by bindings. Finally the MAINTAINANCE entry can be removed.
>

I merged all four into the soc tree now, thanks!

     Arnd
