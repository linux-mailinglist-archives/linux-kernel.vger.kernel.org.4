Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5261663509
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbjAIXQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbjAIXQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:17 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222792DFE;
        Mon,  9 Jan 2023 15:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VZOuenxf0fran8WbzZ3dqItE5pbiY4GG647n81NLsis=; b=Ei763lhn0X+krVNSqLA/I9N+31
        wqxYC6nO3n9ZCZ4yR+JUCqpgZkqyV3KpzQgnBxn2aOxfP5pcrIkE1MmovutWQU5w8ke0k4m10k70y
        P81NU532ttThN5vd12qxh6zXOdRNYqa5fFE1yp/Gh6oEjEZzEKvFIiEWyd/przV5psOZ6smk1MpUe
        payClQlsdQNtOuBh7AGtCAybWrnbAvI27C82K2144GYLbX8MkrHv48pnc3AjNjplnwQtEt5Yzg776
        IRIllf/+A6bqI82clUzOG76+t43bYP/kheGyUIfBjJHMbAOuErHDnwn8SyMym0Irfx5OE7exBhXwW
        8xyw1MaQ==;
Received: from p200300ccff06a2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff06:a200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pF1N0-0003Zo-9l; Tue, 10 Jan 2023 00:15:58 +0100
Date:   Tue, 10 Jan 2023 00:15:57 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        ulf.hansson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: allow more compatible
 combinations
Message-ID: <20230110001557.204dd5da@aktux>
In-Reply-To: <20230108224633.GA353691-robh@kernel.org>
References: <d7c407dc-0a6c-97d5-a06f-b432a923d74d@linaro.org>
        <20230106203358.14878660@aktux>
        <967cc7b7-f0bb-de37-52b9-7bfab05eadd7@linaro.org>
        <20230107144336.2ecff4f9@aktux>
        <123d1a56-8134-dc75-8b2a-b3836e727d4a@linaro.org>
        <20230107150740.0ba34aa1@aktux>
        <0ab84fb8-6173-54e0-abad-a0e0e4ba82e7@linaro.org>
        <20230107160105.66df4136@aktux>
        <e1b1450b-9421-3732-2d74-50c47b5afb0e@linaro.org>
        <20230107165457.30f4dddf@aktux>
        <20230108224633.GA353691-robh@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Sun, 8 Jan 2023 16:46:33 -0600
Rob Herring <robh@kernel.org> wrote:

> A is either compatible with B or it isn't.

I think English and many natural languages allow to use the adjective
in a non-black and white way to express things. So there can be things
more compatible than others with certain levels of "gray" in between.
But "compatible" in an artifical language like the devicetree can of course
be more restrictive, so there needs to be a certian level of gray where the
limit needs to be defined.The definition you give below.
Thanks for that.

> You can look at that from 
> the h/w perspective and client/OS perspective. From the h/w side, is the 
> h/w interface the same or only has additions which can be ignored? On 
> the client side, the question is whether a client that only understands 
> B could use A's h/w without change. Looking at the match data is a 
> good indicator of that for Linux.

It seems that from a Linux client perspective that is a no in different
cases, so B is not compatible.

> It's also possible the answer is 
> different for different clients, but we only need 1 client that could 
> benefit from compatibility.
> 
On U-Boot side things seem to look different, since high speed modes
are not enabled at all and pm is not done that much, so no quirks needed
for that.
Looking at recent mainline u-boot.
       { .compatible = "fsl,imx51-esdhc", },
        { .compatible = "fsl,imx53-esdhc", },
        { .compatible = "fsl,imx6ul-usdhc", },
        { .compatible = "fsl,imx6sx-usdhc", },
        { .compatible = "fsl,imx6sl-usdhc", },
        { .compatible = "fsl,imx6q-usdhc", },

So U-Boot will benefit from that additional compatible for fsl,imx6[su]ll-usdhc.

The first list of compatibles in U-Boot commit (96f0407b00f) was:
       { .compatible = "fsl,imx6ul-usdhc", },
       { .compatible = "fsl,imx6sx-usdhc", },
       { .compatible = "fsl,imx6sl-usdhc", },
       { .compatible = "fsl,imx6q-usdhc", },
       { .compatible = "fsl,imx7d-usdhc", },

So replacing imx5X fallback compatibles with imx6something might be
helpful for that old U-Boot. But I cannot fully jugde that,
so I will not touch. 

Well, I could also delete entries of this list and push a bunch of U-Boot forks
somewhere, so creating a large number of different clients, which would then
justify a long list of compatibles ;-)

But what initially worried me would be that there could be a client out there
knowing only "B" and using all features but missing the in that case needed
quirks for "A". Then adding "B" would cause harm. But apparently that is nothing
to worry about.

I will send a reduced patch with just the things which are 100% clear to me.

Regards,
Andreas
