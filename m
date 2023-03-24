Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019956C8381
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCXRm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCXRm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:42:57 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3657EBB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:42:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A3BD25C00D5;
        Fri, 24 Mar 2023 13:42:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 24 Mar 2023 13:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679679775; x=1679766175; bh=sH
        7uL5bU/wL+6E1za/KT0CvZeA/pT+eHTJ4Ye3y2xts=; b=kBjZibWpAqxrzaYVo8
        ADQXK7VJItOdB1nCyANr89VtnIgF/ZQUhIygF8UBO1WLn6FBPOp9qzUP/xYaAcxb
        pVeOLII+vcXgrhoL6cztG8WiCmqjZPZiO6zr67GhpcjY/2SdXGBO4A2x8RAMx63E
        ITJaVprpZrixR+YKOIRF/N8M7GBBYkuc8HF7cnaluTC5Ryg+y8HNtMDkN0TgGjMz
        pPr9/dDbFdgRsUMEaAIQLPZkAOkUwwcudfKg2N30HfHuR+ZABim1C/X7m8fuwbmY
        yQmGcxVfAp27KnBO9n5uYS0C8dZRpdqcShdzrkbRVClfN6VeKyUXM3wBz/f4dNci
        fM2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679679775; x=1679766175; bh=sH7uL5bU/wL+6
        E1za/KT0CvZeA/pT+eHTJ4Ye3y2xts=; b=F0vUOfB3XuRkNe3DGK1jngbsBxtkd
        bBJd00qcxvirpwuEJkTJLR86k5o3xHKtAXRQnFS4O3JBcBspurITMnA9+b6iKnlb
        rnlnP0FS67Y3Ma9YdRBIB7lhnLOWg7b+jTBB88y4GrfWNP+qLLHwBBIjrvtejE/9
        KM6d3NUTGK0C8m/VNucwcTs9XUiH9JMw2BLoTsvtCFLMok0bOFL1dh+ZM8GxAXWi
        lBGG6YRKKj8S/AVsEfxVbzdzcrn+D5KjDGHE3BG6JLvbWpcidbTzljtcRVmicPmG
        2vtlqYWeNG+XLOzuupZLOgA1PjtJu/N8f2cIj7tv+VeJpRuugkS19yvPQ==
X-ME-Sender: <xms:H-EdZHTCyIH4Kt9ArBDOqHXibI0rJ6FcJBIhqh-a992xeX5LI8LAqg>
    <xme:H-EdZIwfFcQn7LD5ssskcuiTMtWe3QWk99s7LdKn-bQdEQkrDf3ijZR5o_bkWuYyg
    nNEJ1uR8AHW4NVGmmY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:H-EdZM2OxusTHKWukLeQ23vM6elHRAb-zqf_YtZYy0HVtWOrxoMa4Q>
    <xmx:H-EdZHBntncxlzEWmXRXroTXV6Sc-10JVxIMUxFkiOeqE9XoxcFRqQ>
    <xmx:H-EdZAhvHJHGilDmwdxN-MHZziNRYO-NT8gC12OSmcHeOWJE7dN9UQ>
    <xmx:H-EdZDNE9M3Wa88dj3VsWMU2B5ebruaNtIrvB20FaSgCCSGB4IVpSg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0867CB60086; Fri, 24 Mar 2023 13:42:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <775ec9ce-7668-429c-a977-6c8995968d6e@app.fastmail.com>
In-Reply-To: <20230324072443.395080-1-b-kapoor@ti.com>
References: <20230324072443.395080-1-b-kapoor@ti.com>
Date:   Fri, 24 Mar 2023 18:42:33 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Bhavya Kapoor" <b-kapoor@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, "Mark Brown" <broonie@kernel.org>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH v3] arm64: defconfig: Enable CAN PHY transceiver driver
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

On Fri, Mar 24, 2023, at 08:24, Bhavya Kapoor wrote:
> Enable CAN PHY transceiver driver to be built as a module which will
> add support for generic CAN transceivers used by TI K3 specific SoCs.
>
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>
> Changelog v2->v3:
>  - Modified Commit message to be more descriptive
>
> Link to V2 : 
> https://lore.kernel.org/all/20230323113324.361991-1-b-kapoor@ti.com/
>

Applied to soc/defconfig, thanks

    Arnd
