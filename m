Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8085B734D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjFSINY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjFSINV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:13:21 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD87AF;
        Mon, 19 Jun 2023 01:13:19 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D5F135C0091;
        Mon, 19 Jun 2023 04:13:18 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 19 Jun 2023 04:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687162398; x=1687248798; bh=ac
        mQm0nuxCyr0NIKr6vJjBR8GRwKxrYohjffNuU8ThI=; b=jSf0Dn1cNRjWCPqBp/
        tmQZzNRdUPVbsfRpFhe4brf3D6W8oWhX7R/kba0c2bdIfpHuioIPd+GAaTGuQQMS
        JejO5C+VGa75RTFv/tGXYBNjhMX9zDV6DWD680ak+HG2ufngtLABDMK8bAP3mmGf
        iKIiJ1bc+wkBe320cg4NLxrfcUc0rA9mHGm3dSaP64B4lzE11awVDRpfrLOD0OvS
        BLO6jKPG1lDXy1Re+bQbocQBuvmZGIXnzyAH3peknh3DlaI5lhyCUGQHpFwT0cHR
        QW+/0joER771++ZsU8/NZK8LXDJC5izVBQqCTsMovWTC2t5TqfS3ZkeUtH1EScdb
        Opqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687162398; x=1687248798; bh=acmQm0nuxCyr0
        NIKr6vJjBR8GRwKxrYohjffNuU8ThI=; b=FFGWsIVeXBmDhzlMRAfZjj3K2eiwR
        v0Bd6yvnCFsXK7oYvg118CsfDxw27jjWlwL2aRHzHx6S5VYTWiCK1fBRpbzwjp1t
        681ZuaiQc1d2lkVP/ZOhlMuO2kkOI0SPJIRM9s+gf7idnKhG++vzwbSj5VLANeLH
        6JR50eJMDDOdwzyIRsF5f7qLFCuBBL1fmWN5w2BzgSeb2u6LJFAF7Ah6A1LFQJ+d
        INj+Hv143hG8dlqTXlhlJ4p3n5UhXCQ1feV1kWgrgtsYLxSfKL4czVSfCRCmGuDk
        U2dJinyRCawabNBZBrg5Rqf4ecqcV+g8mlv6U2aNVUmak3wfG0GdLRAHA==
X-ME-Sender: <xms:HQ6QZHudSZcr99XCGAwT8aexgY-5xPnlBrnMRPhHxX3M_KLtiUhGPw>
    <xme:HQ6QZIerLq1unp2hy-1fvpPA3Si46dm91um9J5xJwV9O5OVoWqzV63c-uypohthH1
    4W0shxPNhSWefEavyc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefvdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeetffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggv
X-ME-Proxy: <xmx:Hg6QZKyqztS5u4jssAhWLeO90hrurtwGAZK24v5IXmDaggara6lybg>
    <xmx:Hg6QZGOfyAy2G09L8c5M7pjUCnGIxCooHD4r4H8-EFH1PHulm6_iyg>
    <xmx:Hg6QZH-TJrb7_qIrOl-SxEH7hfAU1cMNiShpH_cXFHQ8Df1Hnmvsqg>
    <xmx:Hg6QZGjya9-5i6kyAcYL4gA-4Ns_yms7_IzDbRXRLzt2KIkoGQ2OZg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D61E5B60086; Mon, 19 Jun 2023 04:13:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-496-g8c46984af0-fm-20230615.001-g8c46984a
Mime-Version: 1.0
Message-Id: <f3f9bd5c-b4bd-461c-a6e1-b310cdaa0595@app.fastmail.com>
In-Reply-To: <20230619033041.233921-1-ychuang570808@gmail.com>
References: <20230619033041.233921-1-ychuang570808@gmail.com>
Date:   Mon, 19 Jun 2023 10:12:56 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Tomer Maimon" <tmaimon77@gmail.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, soc@kernel.org, schung@nuvoton.com,
        mjchen@nuvoton.com, "Jacky Huang" <ychuang3@nuvoton.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v15 2/2] clk: nuvoton: Add clock driver for ma35d1 clock controller
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

On Mon, Jun 19, 2023, at 05:30, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
>
> The clock controller generates clocks for the whole chip, including
> system clocks and all peripheral clocks. This driver support ma35d1
> clock gating, divider, and individual PLL configuration.
>
> There are 6 PLLs in ma35d1 SoC:
>   - CA-PLL for the two Cortex-A35 CPU clock
>   - SYS-PLL for system bus, which comes from the companion MCU
>     and cannot be programmed by clock controller.
>   - DDR-PLL for DDR
>   - EPLL for GMAC and GFX, Display, and VDEC IPs.
>   - VPLL for video output pixel clock
>   - APLL for SDHC, I2S audio, and other IPs.
> CA-PLL has only one operation mode.
> DDR-PLL, EPLL, VPLL, and APLL are advanced PLLs which have 3
> operation modes: integer mode, fraction mode, and spread specturm mode.
>
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hi Jacky,

Since I have already picked up the previous version of this patch,
please send a diff against the version I merged please.

     Arnd
