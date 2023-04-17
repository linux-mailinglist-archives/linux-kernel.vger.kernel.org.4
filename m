Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BA56E4B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjDQOgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjDQOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:36:51 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E3AE8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:36:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 10FAD5C0109;
        Mon, 17 Apr 2023 10:36:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 17 Apr 2023 10:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681742210; x=1681828610; bh=V6
        gF/hCwvHh7uX1y3sZQKxUyqD0xU13BG/5C/+Q2/20=; b=WImvpDM8CdkDsuJn+r
        +xAsP+LB0EU7XC66HEolFa/X1iJxXRM9GPcWl+sgkauIyQlXn6Yp36c4BYnaSpln
        Ytcy4avWlaywi9sgEEZ6w4uOIRw4TGTvzyR1MqgafuXcjen+gd2gb1OsYGKRsgdP
        198zjToeAq7oULfEpmm4AlRNgm+Zhc8oJJDxCqBn8ajzd8i9hE3QqpYxkrc/ixiw
        f7yOpAPe83RByxbbr7FLLGvKVA2gwnzayl0okJtEzaq8uttEHDtRfroSrT9BJzHw
        +x4WO1IkanoQNCXuks9gkIbAVciiN4uF1ZYSmtMbS6EQlZukiRgOe0bZKQ3idyUs
        UiuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681742210; x=1681828610; bh=V6gF/hCwvHh7u
        X1y3sZQKxUyqD0xU13BG/5C/+Q2/20=; b=IhAlcNkapEAHkoz5fQ/XjqBcmWGez
        68uVZzM8rBD36OWMbDhR43gCvQ9KYu10JWKKIyiLLkVMkWuA5oU4JDIaNxl/jvpj
        BjKqHQDdIwel3y44HeqzBmyxaoK3WOZxcZ/jIxCaJc4Kl21uhomai+erQMLi5S3r
        qoFAXaDeoSvaOuFgaW3YC/XqaK/dhkU9S+HKKh0IsYWOMt8BfFAjBfj2SXZkwett
        pLILrTBZ79KI+ErlggG7p5G8F8ChrR4YGuPgq3FtCN0z+UWjmItTRJkGq/8i5rYj
        lYv/KaKZeqAqVUOjazqgpcujWrYidH2u9grUzFke9Wg3Pi3ZZs1BvEVsA==
X-ME-Sender: <xms:gVk9ZLQfO54IO1pVf9Q-YWGbjycVQkoiUDjWuXCnGPvvgmaNIL8JJg>
    <xme:gVk9ZMxTjhdetba9FUjZwLFg4jkh08cu1oUrDIPta2WFFvUQ8lNJrZED8lX40a4-Q
    kj2YphN4vyDbi-6wZk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gVk9ZA1OUwYDrL2si-LW3OM16hNlOq1krGY1Vx1U9jFVxT_x9-KgUg>
    <xmx:gVk9ZLBVdwhW5OzQdRzXbvVWlrX9g3Nx15VpPy4_Dmfd3_IUQPcPzw>
    <xmx:gVk9ZEhgT6y38Q9DMrgguytpamtJNbpALmYD8otdxshLPqprRigI_g>
    <xmx:glk9ZDTM401hdHlkFP3NKkOW_xfaeZZnLZDQWJv9r-6y17fjyBCh2Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EBD0CB60086; Mon, 17 Apr 2023 10:36:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <081b9317-214d-4879-bbb1-3e5d032a793f@app.fastmail.com>
In-Reply-To: <20230417132717.1990023-2-kamlesh@ti.com>
References: <20230417132717.1990023-1-kamlesh@ti.com>
 <20230417132717.1990023-2-kamlesh@ti.com>
Date:   Mon, 17 Apr 2023 16:36:28 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     kamlesh <kamlesh@ti.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Thierry Reding" <treding@nvidia.com>,
        =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, "Mark Brown" <broonie@kernel.org>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Andrew Davis" <afd@ti.com>, j-choudhary@ti.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Praneeth Bajjuri" <praneeth@ti.com>
Subject: Re: [PATCH] arm64: defconfig: Enable security accelerator driver for TI K3
 SoCs
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

On Mon, Apr 17, 2023, at 15:27, kamlesh@ti.com wrote:
> From: Kamlesh Gurudasani <kamlesh@ti.com>
>
> Enable TI's SA2UL driver to support security acceleration on TI K3 SoCs.
>
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---

The normal way that platform specific defconfig changes get merged is
through the platform maintainer tree, so in this case the k3 maintainers
would forward the patch to me.

Since it's simple enough, and I've already merged the other k3 patches
for v6.4, I've added this one directly to the soc/defconfig branch.

       ARnd
