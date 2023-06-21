Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9727386C1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjFUOW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjFUOWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:22:50 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1731BC5;
        Wed, 21 Jun 2023 07:22:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8C24F5C00AB;
        Wed, 21 Jun 2023 10:22:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 21 Jun 2023 10:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687357359; x=1687443759; bh=uq
        h8tuCqF2dKU/vlVkQ8edaMsCAAwNBeUvu46sx3Vr8=; b=n/k1xIatpSiHzZ/KiJ
        /Kn+e6auwMeIvQud6Vykz3TW8nFUpbyjf0bXEE7w05GD9shcMK3OKVAX1H25HTh2
        Ibihj5rpbIv8kjIX5EnTP5HtHObp1Z5l079DTY1DTqU8t+ylqhhsTeU/Fl+cimZZ
        a60vKPDZHc95/GGR1TZRvj3Tdp44obNMuiRQQqXjN9O7VzxHgRvd5F7YbEN7gx+c
        VcDIEgcFIGw/MSb0nOqUZNCaWAaQaAtld9uuFgOwWcp2lSJ87J14N5NohrWsU9b4
        1P104rKiiOwXEJ8pR4hlAe13FTCaUKJ5KNuVTDgUAfZCCyJ51pYhNJDhZAd5/khz
        ePgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687357359; x=1687443759; bh=uqh8tuCqF2dKU
        /vlVkQ8edaMsCAAwNBeUvu46sx3Vr8=; b=JvqS126TUMtYNG2bnXKUnqMMIaO4L
        Zq1sOfPQ7X74qemER9BF0sTdhDfzM7zN463Lbjx5O90kcd4IzT3S9hDDoqdp61eA
        SwV/CENSELEJeDzijTa8XZLbf8cBjWzGbDPvE1Ly/o5jwU2AUhYLuvG1MKwtVAzA
        oqZEI2ImOkXI+4h1mLECJenCoIVJDD59YZ6MiQ+CwwCPz4i8NLAU//tNWa8iACaw
        9YfSCkwyjyTQVHLOQOjEkcqIIXTH27A+E7GADA0DIQ41RjS9A0Emdhlhk9IXjCeq
        1zFhMBs8NXY75pRdV8t+GidD4m/uoNeKUyzfJZIBZn/F8wt5FIz2UOwEw==
X-ME-Sender: <xms:rgeTZGX6TK4gsWNg77bFFhp-eu9JRUSO0wZ09ZOuGQeKu6aeldyF_w>
    <xme:rgeTZCl3zxINr-BuPzVw2jR782RWB8or-rtbUXd9CXkOn7_Z7goIt2pIwx9zGeea6
    YYWJmYI6yiepJObtDM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefkedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:rgeTZKbqkMb9v6aiDvqKfoWEa6ip6RMn6glshY_t3QTc9Ei1-olfVQ>
    <xmx:rgeTZNV4cEhclxHcVvKPC5uXSTEXaNxH1g8P5ZysTWQk8O2gPMKyFg>
    <xmx:rgeTZAmVEjsTGrmVKsmfLvac3RY1fSAaFa2pYWAtpK0ghr0VIzgZlg>
    <xmx:rweTZK7Ih1fRiAVcBsixMaOHBXXccPA8sDrGMrEm512ZIWMDiXWBbg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B68BAB60089; Wed, 21 Jun 2023 10:22:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <69c742e5-3270-4b1c-be31-1552d877677e@app.fastmail.com>
In-Reply-To: <20230621031605.234149-2-ychuang570808@gmail.com>
References: <20230621031605.234149-1-ychuang570808@gmail.com>
 <20230621031605.234149-2-ychuang570808@gmail.com>
Date:   Wed, 21 Jun 2023 16:22:18 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, schung@nuvoton.com,
        "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH v2 1/2] clk: nuvoton: Add clk-ma35d1.h for driver extern functions
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

On Wed, Jun 21, 2023, at 05:16, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
>
> Moved the declaration of extern functions ma35d1_reg_clk_pll() and
> ma35d1_reg_adc_clkdiv() from the .c files to the newly created header
> file clk-ma35d1.h.
>
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>


>  #define PLL_MAX_NUM		5
> @@ -20,19 +22,19 @@ static DEFINE_SPINLOCK(ma35d1_lock);
>  #define REG_CLK_PWRCTL		0x00
>  #define REG_CLK_SYSCLK0		0x04
>  #define REG_CLK_SYSCLK1		0x08
> -#define REG_CLK_APBCLK0		0x0C
> +#define REG_CLK_APBCLK0		0x0c
>  #define REG_CLK_APBCLK1		0x10
>  #define REG_CLK_APBCLK2		0x14
>  #define REG_CLK_CLKSEL0		0x18
> -#define REG_CLK_CLKSEL1		0x1C
> +#define REG_CLK_CLKSEL1		0x1c
>  #define REG_CLK_CLKSEL2		0x20
>  #define REG_CLK_CLKSEL3		0x24
>  #define REG_CLK_CLKSEL4		0x28
> -#define REG_CLK_CLKDIV0		0x2C
> +#define REG_CLK_CLKDIV0		0x2c
>  #define REG_CLK_CLKDIV1		0x30
>  #define REG_CLK_CLKDIV2		0x34
>  #define REG_CLK_CLKDIV3		0x38
> -#define REG_CLK_CLKDIV4		0x3C
> +#define REG_CLK_CLKDIV4		0x3c
>  #define REG_CLK_CLKOCTL		0x40
>  #define REG_CLK_STATUS		0x50
>  #define REG_CLK_PLL0CTL0	0x60

This part of the patch does not relate to the decription, it
looks like a minor cleanup that should be a separate patch.

The actual change looks good and required, but I can't apply it
if it's mixed with unrelated changes like this.

    Arnd
