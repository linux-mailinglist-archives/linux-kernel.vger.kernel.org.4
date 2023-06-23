Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C637273B142
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjFWHXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjFWHX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:23:28 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6229DE6E;
        Fri, 23 Jun 2023 00:23:26 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B6ED95C00E0;
        Fri, 23 Jun 2023 03:23:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 23 Jun 2023 03:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687505002; x=1687591402; bh=WT
        jIiOkTBrWjbSYdwb4Oig2FLWCY148eHYPjU36J8ng=; b=m+wkR2E2kNNlsPhJx+
        CnlPrjl9csGk0S/dORKQ2YDt2ODS8TTiOqsJjuzP4kM3rty2s8PiaTOZUC6cBDpr
        SoHberqOX9o/6EfmWXEcBWgXIF28KPKLgsptxUF1UPgdZFvxSEW4/z6bDFSpaC0d
        Aw9FEKWF0srzisIDETDpTPTolb3I21WLDJF1QZluyr6jbBxr/5zKC6lYuaw/Lcng
        XC4xw/KNTqetAQKNaoXzjjxy9i7FpgCW4VcBUe4qsT/KVilPc+6S7ABW3r2SRsZd
        E3a4NsRXd55fWeJLfyWdgM8dhKKhGkj4YOOXb3IyNZ8vr5NR4NMelwbBz57SkRpm
        VQxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687505002; x=1687591402; bh=WTjIiOkTBrWjb
        SYdwb4Oig2FLWCY148eHYPjU36J8ng=; b=g6aGnzSaymHIQc5boBKcnyjJKp5j0
        WUqSsZS42DwAuE3fdIhh3kOZQ+7OGREscQ2fPkrLdqJXJuL52Wl6oK3jpANvKa/F
        NmeHOGJXiE54ghxjOT754JKUd+pW76pBC0pHqtpc9Zkv78/BCE8Bv1NB+uV8vfQC
        AGI3h4C2bSBg/yjegoHCPw6PU3lRvQ6Scc8sMyGiX746b4eMQj2d0+h4Yj7BqJzs
        d7SGzEhA0jrPcza2uWtmQeEQeDXhS65V1112IF6bqcTjvb6UBT8L/T7Cwwy4kQuY
        nxwMRQbj3tMozRFGrN5sg5KOuL9pWgx49eaTyxXswSwgtAnbJiQ6jbZgA==
X-ME-Sender: <xms:akiVZNa5mKdaiSNshbIGADp9XbqUErTUrpUycpe0tguwhTSIElrfpw>
    <xme:akiVZEaAO8Aa36p_aBBTeh8ZeX0YvBs2a50LxIYz82YgeKhWB-OCcxjy8JkNIl_mI
    Qs5Cc6Gr5_-k_pATDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:akiVZP_ZfDrLjolZHqOd3daqUQikkSAFq-3d3nZul3qR-DeznrNjZg>
    <xmx:akiVZLpX-3BFrQRIVUb-ovnw6OMHGjIIeic7Znlpbf5U0-qqG1mkBA>
    <xmx:akiVZIo6kVNdNTGQyBtzxGa5VVzsUHEZcMBGUxod6g6PQryono7ZKw>
    <xmx:akiVZEdAonLulufwfN6GE9eqZg-OUag4_WXT9sZOMXJ6HSoWCby4lA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2BE84B60086; Fri, 23 Jun 2023 03:23:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <adf2429f-8d60-4cab-873a-a08530e5ce69@app.fastmail.com>
In-Reply-To: <CA+G9fYuvBN7Wb3hvmKemxMw1jTjG3-fgMwiQCWH6=fsTddU+xQ@mail.gmail.com>
References: <CA+G9fYuvBN7Wb3hvmKemxMw1jTjG3-fgMwiQCWH6=fsTddU+xQ@mail.gmail.com>
Date:   Fri, 23 Jun 2023 09:22:19 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org
Cc:     "Anders Roxell" <anders.roxell@linaro.org>,
        "Abel Vesa" <abelvesa@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>
Subject: Re: next: arm: drivers/clk/imx/clk-imx1.c:13:10: fatal error:
 'soc/imx/timer.h' file not found
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023, at 08:51, Naresh Kamboju wrote:
> Following build regressions noticed on Linux next-20230623.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
>
> Regressions found on arm:
>
>  - build/clang-16-imx_v4_v5_defconfig
>  - build/gcc-12-imx_v4_v5_defconfig
>  - build/gcc-8-multi_v5_defconfig
>  - build/gcc-8-imx_v4_v5_defconfig
>  - build/clang-nightly-imx_v4_v5_defconfig

Thanks for the report. I found the missing patch at

https://lore.kernel.org/all/20230328100531.879485-2-u.kleine-koenig@pengutronix.de/

and resubmitted this. It's probably best if Daniel picks
it up into the clocksource tree, which accidentally broke the
build by picking patch 3 of the series before patch 2.

     Arnd
