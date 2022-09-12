Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2700A5B5640
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiILIcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiILIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:32:40 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE6F38BA;
        Mon, 12 Sep 2022 01:32:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 99DB22B058BD;
        Mon, 12 Sep 2022 04:32:38 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 12 Sep 2022 04:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662971558; x=1662975158; bh=f04RNX58Kb
        0f1nFb12vzifdPrEWrRbzdTP3s0T8Dxlo=; b=AP1i/J1llld1d8jEPzfbm+bbZQ
        fE97cqRr0I+GAF4YiJNZMifuj8Z4TggwXAodLZC0yvsY4A6i4QLYlkaauh9HcAUO
        TY5P0lh5jGpEoK8wAMUGbElrxpnEH8PcyYn9Wh7VB4CKYbf9a5Au3L3EOycoKAEj
        X57h+vtd4GYTqaL5nscF/7GtQpmMbAOoJF3v9ZFMPGVuWsAXmQOqoAlwQa3R+/s/
        Jd7J/ROinDE6H8Jfw52hB1zzMB0xsTV8FTPVN0hVAzUOTFYK+NzOy1TMsaeXGMFn
        koeDBzCY+Sy0QGHha03SqGu02ClGCNCQOvZnlolJC7niOpATIC53Vn6kLp2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662971558; x=1662975158; bh=f04RNX58Kb0f1nFb12vzifdPrEWr
        RbzdTP3s0T8Dxlo=; b=0MM+4kus2VsEh7yNA3SaRBbLWkwhKFneKnfzeL6vYXj1
        OREDX+hQwVPONk11ewwMTPha4qHasnyoIWqIEaOgL76nxiEs/HKoniuotxVLL3Ca
        5e4F2anqOcJgyAvwQqqrjpuef1QUqCOWRqPjvXkkcp4lO9/7vC972dNfnhf9wEKc
        GshCtbxr4jx1PLVL/+MQL2PyV6TOIOQOD0CD3H5xqNJkKreBemozS1O+36T0O5tR
        cPsqn6OYj9tFs6n441jM7RVMdWnU6xXQRcsAUtOabveELem0Fm98p58NZ19jfPyQ
        JyqoNnn2dLcRBxUfst8BDLHz+6d1KGExwMEAnNjbwA==
X-ME-Sender: <xms:pe4eYwVkr33qaKRPjj-MrATL69Ekj4rNvbF10EhAkAvzMSDCcxCuuw>
    <xme:pe4eY0kwHOpxHzdqXr_0eLJ95VwS808Xra3bT9i2C2TlPAiPrhFUXiGtdYk5wKvRJ
    Dnln7PvAaSaGGSCW4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduvddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:pe4eY0Z9DspUj9Fx_Dr8kUpoPx5wflgwVbaRSLjAvrDzUzcspcc-wA>
    <xmx:pe4eY_WmI4IYxEy0RvmQTz86sT312ow9650WA7M15sTv1N-fEUHA6A>
    <xmx:pe4eY6n4TQ0aUCF4on6EhIENrX7KfYg4nHX2jIstLDGbRrQgg4mAaQ>
    <xmx:pu4eY4bUASaAEW-iJns6jOJnpaRDWnHegq33PppJnWx0OPkahu_YKpe8Xds>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D2892B60086; Mon, 12 Sep 2022 04:32:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <2a386281-5a49-4df6-bafe-ef9de0fb0ca5@www.fastmail.com>
In-Reply-To: <20220912071511.1385-3-hayashi.kunihiko@socionext.com>
References: <20220912071511.1385-1-hayashi.kunihiko@socionext.com>
 <20220912071511.1385-3-hayashi.kunihiko@socionext.com>
Date:   Mon, 12 Sep 2022 10:32:16 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kunihiko Hayashi" <hayashi.kunihiko@socionext.com>,
        soc@kernel.org, "Olof Johansson" <olof@lixom.net>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] ARM: dts: uniphier: Rename usb-phy node to usb-glue
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

On Mon, Sep 12, 2022, at 9:15 AM, Kunihiko Hayashi wrote:
> Actual phy nodes are each child node. The parent node should be usb-glue
> node. This applies to the devicetre for Pro4 SoC.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  arch/arm/boot/dts/uniphier-pro4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi 
> b/arch/arm/boot/dts/uniphier-pro4.dtsi
> index a53b73ee93e9..cf62821c69ca 100644
> --- a/arch/arm/boot/dts/uniphier-pro4.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
> @@ -376,7 +376,7 @@ pinctrl: pinctrl {
>  				compatible = "socionext,uniphier-pro4-pinctrl";
>  			};
> 
> -			usb-phy {
> +			usb-glue {
>  				compatible = "socionext,uniphier-pro4-usb2-phy";
>  				#address-cells = <1>;
>  				#size-cells = <0>;

Not sure about this one. What hardware does this node
actaully represent? I don't see any other soc dts files
refer to node names as 'glue', so there is probably a
better name for it. In the binding document, it's called
"usb-controller", but I'm not sure that is the right name
either.

      Arnd
