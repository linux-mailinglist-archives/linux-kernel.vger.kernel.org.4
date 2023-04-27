Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061536EFEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 03:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbjD0BFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 21:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbjD0BFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 21:05:22 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C321E5;
        Wed, 26 Apr 2023 18:05:19 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B763E5C0190;
        Wed, 26 Apr 2023 21:05:18 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Wed, 26 Apr 2023 21:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682557518; x=1682643918; bh=E9
        N8YXlvDEdxrAOzpWB07e0HpA0cgLPwCCuN0JGi1NE=; b=nB/JtY4tdwNaRwdn30
        rBNDNdsx8g3kHsfY86zbAbzLE/JC40Hgr61iYVa1H572SY+Sdz6FlUWHP0WIR1wn
        ryrOMeFD0DQpU0lfgOyAAmjgcKUTm4SSNhKAmIGFU0QaBsWt+QcXrzLPc90CI3m5
        jzJQvQRy9vLIZDbMnHiqH43uPkWiraRsHXwfdtrM+C/PoIzH7e/eA6jYgsZ+ywVm
        ZggLwSRHdaQCgci+TjUZ4qauNLYqvsZ4q9OPBjm5wCXO5zchTXOO4ZWK8rUx9/bh
        E27VYXcQI2Tps54W3bkbteJW/GUCss3n3WHKlXdwksQVvN110U2Ae0lIqGKJIuZU
        +H8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682557518; x=1682643918; bh=E9N8YXlvDEdxr
        AOzpWB07e0HpA0cgLPwCCuN0JGi1NE=; b=NV1MVCS/4myadOVfRl5KdVqYuveNt
        JFhxl+imGNCLBr1qldWO/81lc+nZ3J8PvPriJMvmuxNehxt/w/I97PN26hJl3QvP
        XQH481miT3v0iMWiGclLjJmqhX3sE08XRxwtiZSRaWSvaflHAvxJqJImhcYsCD/f
        qSYgLR5JXLVBQdlp24l8alS8+NCYAFF9/QhwSfOd2X4GDli6gvvWDJSREvy2mvul
        va75OR0qg3Gc2z56behqTgE6ev4p5/rZX80gNbCgQFpE37VkMk/vxwKDQBynsO+/
        CUvqfKw7iDd4wATe1rGzNrIyuViKwl41tprh7C9mJIEfboxl91EkiL8lA==
X-ME-Sender: <xms:TspJZKW4lxEmrBKUN_gnGKh8m0ihYrYKph-v-_ji1e4Q-kn98au7xQ>
    <xme:TspJZGn4j2PFHPuT9X9uynjIzveH0P0E5g9h_RpeSx1pvSpU7BCQzHyhvOBLg9zfv
    _CJbGvNeEZu8KGc9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduhedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:TspJZOZyp8Mjj7ZuEBWQbdxRPf8fYEtuZ3ZMpSs4sT-FjE2iKiCHaw>
    <xmx:TspJZBX8cWRChpTzxvVd8iVSTZGtUz8C62vVoyL1Xbx9IilQT35RkQ>
    <xmx:TspJZEn3ogIWhJwlx5nekNiCI41A2SLfPSiU0SAyO1eytXUFTWUqEA>
    <xmx:TspJZCaRKN0afJqzH40ZgARZbvdL1jW9Stpc5BuJ73gCxXFe0JiYxA>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7CF681700090; Wed, 26 Apr 2023 21:05:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <f5c261ff-7901-434a-aa2f-3b2f684cb4a7@app.fastmail.com>
In-Reply-To: <20230425065715.21871-5-chanh@os.amperecomputing.com>
References: <20230425065715.21871-1-chanh@os.amperecomputing.com>
 <20230425065715.21871-5-chanh@os.amperecomputing.com>
Date:   Thu, 27 Apr 2023 10:34:43 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Chanh Nguyen" <chanh@os.amperecomputing.com>,
        "OpenBMC Maillist" <openbmc@lists.ozlabs.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: dts: aspeed: mtmitchell: Add MCTP
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Apr 2023, at 16:27, Chanh Nguyen wrote:
> Enable MCTP driver on I2C3 bus for MCTP transaction
>
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts 
> b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> index 0b5ea8620063..33e06eafed31 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> @@ -366,6 +366,13 @@
> 
>  &i2c3 {
>  	status = "okay";
> +	bus-frequency = <1000000>;
> +	multi-master;
> +	mctp-controller;
> +	mctp@10 {
> +		compatible = "mctp-i2c-controller";
> +		reg = <0x10>;

This needs to be `reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;`

Andrew
