Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F475F5B55
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiJEVAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJEVAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:00:33 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F7A80F5E;
        Wed,  5 Oct 2022 14:00:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A8DAA58042F;
        Wed,  5 Oct 2022 17:00:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 05 Oct 2022 17:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665003629; x=1665007229; bh=TsI02B3sVh
        QFKOVk9keaf6ReQTAWUpnqUMBU0gDCsKo=; b=ZfXYeIiQfqotQD9UYVd1ADllex
        ZcKI/ME+E8BnDEeC7Uyk0EfebWGcsqBgfUwspGkHnUYF/5yqAmHMWbmDFnfEOqSl
        Af2L5RjStJdNCf16q9UC/sXQ3Z45+wV0IniaMQaj14s1KxRlR/yej+tdp5Cxkre6
        JmenQyIcjlLYjczhbeEOflo2DxRCIehNXukUDSklJQSwkNt9QpdjxUnEHSl/PigD
        W3urFP4w/03Szc8AIyLlnye0c2gPRv8Rqzx6NmSKcpO98VT9+gvNbEGzqqVsVAKB
        tIR/55XxKHTlzanIxwooyWcaqYgAMqwQHvPv1k8PmmGyvVsS/GHYTSD+Decw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1665003629; x=1665007229; bh=TsI02B3sVhQFKOVk9keaf6ReQTAW
        UpnqUMBU0gDCsKo=; b=LUSBUNMySfpRFCaT3bDv2jAXpEbZTjVcfi/fzv/VOWTy
        sy/lpl/u07TOPIHmvqOnQuuuaKqvu43M5WLlMSpSomYPnzbIAgpEZ4d2D9wdTQSk
        Cwy/9jq6L4ICcHDEIiu6Dy1YdIJWwGIkAGicFOnSvb/GfXqxzoaBKTG8FDIJedHI
        YRC21dnKN8H8iiCMm3/CiRD4C5jAk4UqPLg7ilF11mQnRWQ6Lpoe30Fkyg4JyO/K
        Uh49Nx0qGQnyB3KMLzs9usanQ9uuu6lafuSIgVtiBjoRrGtf1xJvY2PGWJaaRYbG
        plgELycl+0Fki2ZtrarjXlDlyai45qpp74otDle/1A==
X-ME-Sender: <xms:bfA9Y4Qq_ZIUQVd0D3cL8GaCDgUHL2g1Q_do6apVEhaqjRSc7vQZnQ>
    <xme:bfA9Y1zOo_tkDKWyF34r8IStGqzMptvQ79hA-qAyCkctdlE3Vl1n2yNBlbI_tTnCW
    BgYgHVqjPfbw7cOESI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeifedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:bfA9Y13dVUzq07ASpYteds6eLmf-QmwR9DyTcezfVFbnS0Db8bx2oA>
    <xmx:bfA9Y8A6EKLT0u8H91K1DTIB5r8DqIl8JvSmDTiZN0HHpt7YzhYoeA>
    <xmx:bfA9YxhI9XpXul5uNYfPWMYaFv_3fts3JadyysFm8BHu6h2EgyGUbQ>
    <xmx:bfA9Y5inTSB5K1uuyplw4g7smGzUgTpVZj-6Rz9aWbW_qOeXW0SrXQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 27340B60089; Wed,  5 Oct 2022 17:00:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <9527fd97-41d1-4f68-aa9e-8a4424fa94f1@app.fastmail.com>
In-Reply-To: <DM4PR84MB19274B41DEE65D882D4C8F27885D9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220728161459.7738-1-nick.hawkins@hpe.com>
 <20220728161459.7738-4-nick.hawkins@hpe.com>
 <DM4PR84MB19274B41DEE65D882D4C8F27885D9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Date:   Wed, 05 Oct 2022 23:00:07 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Mark Brown" <broonie@kernel.org>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 3/5] ARM: dts: hpe: Add spi driver node
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022, at 10:33 PM, Hawkins, Nick wrote:
>
> Was there a particular issue with this patch? I just realized that 
> patches 1,2, and 5 were accepted but not 3 or 4.

It looks like you sent the patch to a lot of people, without addressing
anyone in particular. I certainly did not expect to pick it up like this.

When you resend the missing patches after 6.1-rc1, please send the
ones you want to be merged through the soc tree to:soc@kernel.org,
with reviewers and mailing lists on Cc, but nobody else as the
recipient.

For the SoC tree, I usually have separate branches for code
changes (usually just Kconfig and MAINTAINERS entries in case of
arm64), devicetree changes, defconfig changes and driver (typically
drivers/soc, but could be others that have no separate subsystem
maintainers), so ideally you send a set of patches or a pull request
for each such topic branch.

      Arnd
