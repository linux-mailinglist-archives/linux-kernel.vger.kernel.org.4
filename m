Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA254602960
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJRKeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJRKdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:33:52 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5412EB4483;
        Tue, 18 Oct 2022 03:33:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A4F285C00CD;
        Tue, 18 Oct 2022 06:33:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 18 Oct 2022 06:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666089230; x=1666175630; bh=urMCChgCu1u+56jJGaeezcXuErkz
        0/nAyptCtTcKAcc=; b=EW+G5ucp3HiQ0siiSTUhTA4p8V2d8zcFZpKXOP3CzkRr
        A04oWt1tAIiyOkHSazLT/ot/liLe4rhjuQUsnjQduyUwOhyHq6wSDRPJDg7F6f2D
        AQIPeqRQQFKydjwF6qfPe5Hcd6TdGfuwXL4rOcxdYckg8S0eShQgg3UhT1IFuamZ
        UieemhI47uDsk5pAGY7gB0s7ffrDin53lWz6/1WOXXFckL7SmJpQ166PALbIVjE/
        TqwQ21BEPZ/SGTfJWIdBR35ugKolRvGm7XtPwh5+34JLZQafEeUMIWnOF0YyAnlS
        88khAbGuyjmbdF1yCadsxvEYJCgN8bmnkKG4gLbRLQ==
X-ME-Sender: <xms:DoFOY9NG_H_uSEcMfkaE43bD6AGuDA7hZnQzpElG_maclGjFGKCa6Q>
    <xme:DoFOY__VhbILrmFQuP2XUj9VNOa5S3dnOECHjogetN1gwkn1t7YdJYIxX1K4WlBxv
    MBg0gT7ZAN6iOw>
X-ME-Received: <xmr:DoFOY8SPs6H39l3Jhoi5yrwAxlBe4Kaj8VvkB1NOKQReTKim9AQDporhxDrUPSuYc1pTcziwl8t6aJUdkMuJhtomCS6aug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:DoFOY5u6MfKuGtDUc-v7zORUgfBNwfPbsW4GtXYnSBJJwYCuUyqSfA>
    <xmx:DoFOY1d6-3mXqAAhsytAIw2n1_fRiGYcvBU_Y1v68UXJ3x7rBAca5w>
    <xmx:DoFOY13dF5tQfP2qVddc5U-7PKGAaRUQmjcihXv0oR2ERkHfGyS4UA>
    <xmx:DoFOY8pE1725d-CmP5gN2yfkMaePDCefVP9oR8DSmV2G9uSn_17Obw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Oct 2022 06:33:49 -0400 (EDT)
Date:   Tue, 18 Oct 2022 13:33:45 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com, lukasz.luba@arm.com,
        broonie@kernel.org, damien.lemoal@opensource.wdc.com,
        heiko@sntech.de, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, talel@amazon.com, thierry.reding@gmail.com,
        digetx@gmail.com, jonathanh@nvidia.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, baolin.wang7@gmail.com,
        f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        mcoquelin.stm32@gmail.com, glaroque@baylibre.com,
        miquel.raynal@bootlin.com, shawnguo@kernel.org,
        niklas.soderlund@ragnatech.se, matthias.bgg@gmail.com,
        j-keerthy@ti.com, Amit Kucheria <amitk@kernel.org>
Subject: Re: [PATCH v5 01/33] thermal/of: Rework the thermal device tree
 initialization
Message-ID: <Y06BCSh+jq5Ztf+3@shredder>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220804224349.1926752-2-daniel.lezcano@linexp.org>
 <Y05/8JUU+3kLCZvb@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y05/8JUU+3kLCZvb@shredder>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:29:04PM +0300, Ido Schimmel wrote:
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index d4b6335ace15..43d55c29a29a 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -604,13 +604,15 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
>         if (IS_ERR(np)) {
>                 if (PTR_ERR(np) != -ENODEV)
>                         pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
> -               return ERR_CAST(np);
> +               ret = PTR_ERR(np);
> +               goto out_kfree_of_ops;
>         }
>  
>         trips = thermal_of_trips_init(np, &ntrips);
>         if (IS_ERR(trips)) {
>                 pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
> -               return ERR_CAST(trips);
> +               ret = PTR_ERR(np);

Sorry, should be:

ret = PTR_ERR(trips);

> +               goto out_kfree_of_ops;
>         }
>  
>         ret = thermal_of_monitor_init(np, &delay, &pdelay);
> @@ -659,6 +661,8 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
>         kfree(tzp);
>  out_kfree_trips:
>         kfree(trips);
> +out_kfree_of_ops:
> +       kfree(of_ops);
>  
>         return ERR_PTR(ret);
>  }
