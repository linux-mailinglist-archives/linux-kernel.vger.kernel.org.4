Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9BE676791
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjAURDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAURDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:03:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2498B298D7;
        Sat, 21 Jan 2023 09:03:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1C2AB80816;
        Sat, 21 Jan 2023 17:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6A7C433D2;
        Sat, 21 Jan 2023 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674320612;
        bh=KDw/+vNJAi/mknOa0WX6Ng3Q/0RA2pHOSwGQq7+EYNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HuAvhLjB/S0zc04GEtF9VGWcCB7qG5XdOX/vEN1tGnJurqUyU5Va8pjleX2BpqDMx
         1DBYEjVEnjBFx5TMJxCJXI7zrpQMWIMOexR1+df1B4bLny8/4vt2pzpJZmJyEfGgpQ
         VaalUoUBfg8Dg4BGmjUOzfEOW1RNNXiRf2hG+bdlbc+nqCoVFoQYaZC7SIcN3wQKYS
         vl/n8mO8rxnNzKFz6fOMO41bk802GYjzq+d/1MlwM8VFj0YnJsDTSbb/R2tuxHnaxy
         qtLkTzSJsB5UF4h5o5eq5Uixb94jhF7dkj3tZNB291jWt2N+6/jKr2Cl253RK7dQIq
         Y9ouSKjMPjr8g==
Date:   Sat, 21 Jan 2023 17:17:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Robert Yang <decatf@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Alexandru Lazar <alazar@startmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Stefan Agner <stefan@agner.ch>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Harald Geyer <harald@ccbib.org>,
        Eugene Zaikonnikov <ez@norophonic.com>,
        Phil Reid <preid@electromag.com.au>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH 3/5] dt-bindings: iio: correct node names in examples
Message-ID: <20230121171709.5eb75e94@jic23-huawei>
In-Reply-To: <20230118184413.395820-3-krzysztof.kozlowski@linaro.org>
References: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
        <20230118184413.395820-3-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 19:44:11 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Do not use underscores and unneeded suffixes (e.g. i2c0) in node name in
> examples.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

> diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> index 6c5ad426a016..12f75ddc4a70 100644
> --- a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> +++ b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> @@ -42,7 +42,7 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        heart_mon@0 {
> +        heart-rate@0 {

These are both heart-rate and pulse oximeters so measure more than just
the rate (oxygen saturation in the blood). Reality is they actually
measure light absorption over time, but you can calculate an estimate
of both rate and oxygen saturation from that.

I don't really mind simplifying that to heart-rate, but wanted to
call this out for possible discussion.


>              compatible = "ti,afe4403";
>              reg = <0>;
>              spi-max-frequency = <10000000>;
> diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
> index c0e815d9999e..b334f3e356ad 100644
> --- a/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
> +++ b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
> @@ -39,7 +39,7 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        heart_mon@58 {
> +        heart-rate@58 {
>              compatible = "ti,afe4404";
>              reg = <0x58>;
>              tx-supply = <&vbat>;

The rest are all fine.  If no one comments I'll pick this up as it is in a few
days.

Jonathan
