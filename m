Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C50723F36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjFFKTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFFKTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:19:40 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9F5EA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:19:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 938CB5C01A6;
        Tue,  6 Jun 2023 06:19:38 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 06 Jun 2023 06:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686046778; x=1686133178; bh=mdblDDucProdb4TCrg2Jqmy8piF8wY58xX8
        vkEnKa8w=; b=xOq7b3qnKMXUZ4HlmZo2K+o9ys3OPm2gdXLhPZ1v50pVV2L2dhT
        y/BMkJjqh1id5dj7HWNyI2bU/Q/WmuFqCC4RrOhia2f+QX4tPRg8D5VZvYSt8YAR
        r2SW2OhVxvNoLDgfJgT3o4/ebjuZbjKUpQexSnVmP0Iuqic448KlbqM1+uqLDqs/
        08GzkKcvakhYL8vIwXcsfrpeUXZqntcHOQgBhH6OI1ptN+CI/k0W0GzwlD3exGe0
        e4hZu17eDlmqRu05nGjbjDhR7geXl5O4Z8OLmKt9YDsJpz+gg+CgzyLRcg0p+dfA
        wlylCfNP9Yo/E9kKkKlsOxer2JXq63de7vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686046778; x=1686133178; bh=mdblDDucProdb4TCrg2Jqmy8piF8wY58xX8
        vkEnKa8w=; b=nYO+gH1YbRXPiQBoXqbLtpF6p+FVvpFTgA/y49DwtmHv38Foq94
        V2FblCl1oTExyFhIwgYTpBzgR9ZLHJDURpd+wV28AGOtNneL/1foTQWEbMoALL26
        K0J7QgBrFvmeA0O/EuLo8eG/NPB290th6BBV5PsbTCSHiSBa86eRhSOht4B5gXJ8
        dQDGQvCptx8M+MGg+0RKoSup47+IvSbn26sxvJHsG4/zD2UEzmexQ+EkcjZh54Xc
        /EBsl5GxWs2Lhm7Pnpm94jpzGMXGolXNfskQUHzVg1r8nYz9iMHiIGsyiM6S9BSD
        8AdCLNQIjBT97oRuA8KuBHeo6OgvaAC8q8A==
X-ME-Sender: <xms:Ogh_ZFwPjnQFiVVEEjH9MHk9BckRuWvTtgrdyS67D60N3qcptyOTvA>
    <xme:Ogh_ZFROD3sf4PsRGqvA8epy_aLk6CKjvgSxHxM0OgJyyaIhxq5oRFUn_y9X2zl4O
    o9tzWRBTyEEq0epMz8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Ogh_ZPUptCo4sEUGFyrvamdfA-w17vmYWwrxQ3L0XjVlO9LMYVw8jQ>
    <xmx:Ogh_ZHhnJ3Whgq-EXH4hgOpr0vtszZezk0u0Ze7WmeUT5US0m1XSug>
    <xmx:Ogh_ZHCioPfLUfugUc5fm8Z2HnT3tNmPe09pSRAjZLxgnMkkGsYlZg>
    <xmx:Ogh_ZOPJVnaFkOipXEvNqvY1MkHiGqX4e_iDZAbUxuLHCMiujPpgyg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E9645B60086; Tue,  6 Jun 2023 06:19:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <6c1a5f7d-36a9-46a2-9050-eff6ce6bc3a4@app.fastmail.com>
In-Reply-To: <6f9587b0-85df-6f80-8dc5-b27fbf11645@linux.intel.com>
References: <011578db5fc4426d7df5d8ce2cf5ac09b7080531.1686045287.git.geert+renesas@glider.be>
 <6f9587b0-85df-6f80-8dc5-b27fbf11645@linux.intel.com>
Date:   Tue, 06 Jun 2023 12:19:17 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc:     "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Jacky Huang" <ychuang3@nuvoton.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reset: RESET_NUVOTON_MA35D1 should depend on ARCH_MA35
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023, at 11:59, Ilpo J=C3=A4rvinen wrote:
> On Tue, 6 Jun 2023, Geert Uytterhoeven wrote:
>
>> The Nuvoton MA35D1 reset controller is only present on Nuvoton MA35
>> SoCs.  Hence add a dependency on ARCH_MA35, to prevent asking the user
>> about this driver when configuring a kernel without MA35 SoC support.
>> Also, do not enable the driver by default when merely compile-testing.
>>=20
>> While at it, fix a misspelling of "Nuvoton".
>>=20
>> Fixes: e4bb55d6ccf0f774 ("reset: Add Nuvoton ma35d1 reset driver supp=
ort")
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Applied on top of the initial patch, thanks!

    Arnd
