Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EC46F4343
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjEBMFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjEBMFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:05:46 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01D8E46
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:05:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 66D3E32009DD;
        Tue,  2 May 2023 08:05:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 02 May 2023 08:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1683029142; x=1683115542; bh=Sg
        EEF1Ed99DfJhcBgngkH7JRzC3zhjOufn7XPWeIqLQ=; b=g2pL/3Gb+tZy2OUc/I
        Wl1cQDOEhdlq/ndBBZJPM6nlfX/Fa9rmWEJ1vzCHsEir835hDzaT6Vh2rISx+60q
        XJj8hcNzWYgMkqLVLpGIzOTsCn4YofBppgN2/EjTpLv9ZHh1WdXqozeg7v3kA3ph
        BSoMybVEFJqW6/8TzeEfbIae6+jV5690qbvrhBIhpIyF9qERVnBZv0rL7SoWqCjh
        oY6f7hoghVGTsx2WKoNTqfTnxQsX+vR9uVvZm1QAQide5xbP8b8HoRIQZyJG3S+P
        r2a25F1A1GRfM4TW90BK116hpY1EGOdx+zPuXGNNbPZ7aAlZTOdudLHkMLZjymY7
        HHPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683029142; x=1683115542; bh=SgEEF1Ed99DfJ
        hcBgngkH7JRzC3zhjOufn7XPWeIqLQ=; b=XJreOdkyz2C1rKsMR8odSyB27tVm4
        7rYpMq1ppWmIh8kw+mwvgua5ohKN1viLEm1jBhzREZEoFngK3KqvbBUn21tzNYtG
        xds+y+Sbkr2dDe6/jwtA7OHYrjRikkKeBpQZUfqjAP9omM2R+IXIFIH3HFVb4hcO
        C6hSXaMyKDeXJVXEbs2velVjY6FgWbQT6EpOmtEwCyzpx1HQsnIstJKGfgpf9NKG
        iPY4GsIBcwih0SkW5ythXZZOUne+L+tGp/7SCBQbEYi+zdFbmPXfzu0yHjJhyhZa
        hKTrH08fGIOWS5m1K3u/6qe04PbQ2y/zZYzRkhHVbbbdMc4t92PQEndrQ==
X-ME-Sender: <xms:lfxQZCmK7pP4u8a7CGIEXIwN2W5ggluAAUuKkgzLYH1Vn1POPoDbvw>
    <xme:lfxQZJ3Fc4B1Q9BXNPqlCdHrCJxuV7_kkvEf6WqOHqxK9C1Vq-nAe0WMT7AFeFLOQ
    V_UFrdfrRcHDaRL-Tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedviedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:lfxQZAqK8v53oM4Ey59oYaJTih-k8_-J1gD6cab0CzqCSaJf46mQew>
    <xmx:lfxQZGkuZacdxFxDG244PkTpH2xPTfUU8kNNbQYZTF8vKHPfBCmYlA>
    <xmx:lfxQZA3d1kAlSMIppgH1VH8i9cy0sjMKXNnghv1r8gn1B0h0Tx4diA>
    <xmx:lvxQZN89YnNcoWQn_XY7YPTD3s-I1S5BECOJhARZzV8DW6nAq-mC-A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5B90FB60086; Tue,  2 May 2023 08:05:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <91d6bb75-ff8b-4c61-b336-6f2fec3b5d49@app.fastmail.com>
In-Reply-To: <20230502102050.1418417-1-p.zabel@pengutronix.de>
References: <20230502102050.1418417-1-p.zabel@pengutronix.de>
Date:   Tue, 02 May 2023 14:05:20 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Philipp Zabel" <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     "Emil Renner Berthing" <kernel@esmil.dk>,
        "Hal Feng" <hal.feng@starfivetech.com>
Subject: Re: [PATCH] reset: starfive: select AUXILIARY_BUS
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023, at 12:20, Philipp Zabel wrote:
> CONFIG_AUXILIARY_BUS is not a user-visible symbol, replace 'depends on'
> with 'select'.
>
> Cc: Emil Renner Berthing <kernel@esmil.dk>
> Cc: Hal Feng <hal.feng@starfivetech.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
