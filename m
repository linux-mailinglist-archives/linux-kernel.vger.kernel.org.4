Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58945677658
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjAWId0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjAWIdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:33:19 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB751E1DD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:33:12 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A1ACB5C00A9;
        Mon, 23 Jan 2023 03:33:11 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 23 Jan 2023 03:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674462791; x=1674549191; bh=35oGXOOcBJ
        wDepYJF+I4CBZito2op2uRGMqfGXqedqA=; b=MFCruWtfo6yGtbmCcL9ugAYTIj
        Y0VxDs3bSwbH45t5G3MmTkd+x8iTeJg+tU5ux9256oPDXD5Ay97zUS+vuQcF6hSP
        eFAPFRzaxeCceJDde1+Ki47itIwQr0IidoizDdA7Rmj/Iz1adBJyNBvOmTOtvh9D
        m1/bXPuzkerFG8UILfHun3F5JKOe+XwNIR+8OBNUhXwOiMaaKob5hK+YZFqzW1gE
        RoEeTapSjht2D3nCTtfNKuTYd/R21Pzt8iHa6Wp2ujf8GHQ07KDe/iRHGV1Pwv69
        d1EfXQpzOzGwzzg7pJGbGgZImmligAWdzQB1uuzKA+9XkAFmptqfDiM48xUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674462791; x=1674549191; bh=35oGXOOcBJwDepYJF+I4CBZito2o
        p2uRGMqfGXqedqA=; b=NpQqZCXrrwGqifIcJWF6JuepHPJUVOLsDvAEJmTFwQu4
        NVyJohpmNAQ4AEaYAT0Wikr0Tw6soOqkc3ACjQDTTeYgKp21Yy2t6tnb91XwDZFM
        YZUAifvflc1RziS43uR8pnzqIarkFgcNhUEGUrV8YuG7YM3X1QiSQmEfHy+ciFPG
        2ss+BdmDVD0JskQm3wHUAXuheacvSmWQuVbSTqgXjeDe5OZpKal7ChtB6NpxpMMY
        tjvxPGETjW+ob/2TxfWzDzop1dPWQkpuV7sOcXyVwh/2Wy3HI8ZNYVr7pODSeLh2
        Anw1K9ht1sTIJrLJEa7tlrXWWaUovC/CULecYVyQWA==
X-ME-Sender: <xms:R0bOY92mj9BDpOpB08jVqnDMTDkyyHTxHWZTWPxdq4cLHMOxmk7j0A>
    <xme:R0bOY0G2xp5i1EKnZBJgjY2gpC-pnaeKIqmLOvjMsGr2yrJ4k8QL6XMuwvNnXrdqQ
    8MxNThHae_a7gZV1yU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddujedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:R0bOY95XpntYV5PJ5GwXxdDxinTBfi58ZLf4R0Y1nYltvxuGKwXpTw>
    <xmx:R0bOY61JUOJjAGwXka-_uYtjy96pY67YflSAHQzE6s4U67-cOajYCg>
    <xmx:R0bOYwGRIKyumaeAWww3TRI5Kqlqq2uXSmE9Zb6JmngKRaAgg3MOsw>
    <xmx:R0bOY1RdMrs31V0qaKzXDbVSbgLt9dRW8bJev_8830-6ax0IWjmNsg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6027CB60086; Mon, 23 Jan 2023 03:33:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <348ea511-6862-4e40-a98f-f71c8a91e097@app.fastmail.com>
In-Reply-To: <20230123073305.149940-6-lchen@ambarella.com>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-6-lchen@ambarella.com>
Date:   Mon, 23 Jan 2023 09:32:52 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Li Chen" <lchen@ambarella.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
Cc:     "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/15] arm64: Kconfig: Introduce CONFIG_ARCH_AMBARELLA
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

On Mon, Jan 23, 2023, at 08:32, Li Chen wrote:
> +config ARCH_AMBARELLA
> +	bool "Ambarella ARMv8 SoC Family"
> +	select PINCTRL
> +	select PINCTRL_AMB
> +	select RATIONAL
> +	help
> +	  This enables support for Ambarella ARMv8 SoC Family starting
> +          from s6lm.

The patch is ok, but drop the "ARMv8" from the "bool" prompt,
we are removing this from all the other entries as well.

     Arnd
