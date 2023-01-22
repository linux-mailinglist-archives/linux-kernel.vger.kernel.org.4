Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD3E6770BC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjAVQrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjAVQrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:47:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2392E1C30E;
        Sun, 22 Jan 2023 08:47:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B17BF60C71;
        Sun, 22 Jan 2023 16:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D688C433EF;
        Sun, 22 Jan 2023 16:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674406048;
        bh=SvajHjiCSIBlcZUdVxMgRSWO0gJsGtBYT+mr1EHeu0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HJZbJrnWcLLnDqOiDRQFyTuKeSBq7CbUfFHZzlhHwR68aZIpTBcnnH7lrVDHATIJ5
         w/Mzn1otM7LO+JhZgcF1eRjNkHrIX6kH73HUxsbtJpGx+ipM17Qa0hyxxMfQoix/Tf
         r1748utHDH2gwfl5+RJVcuDS4ArHPfoVaxwDRawNux1S9sdh2RCaapXMO7IYw2RywK
         8xy5xC0S7ec1wTzznrVHpd5sWmDaTKeuBj9DX4zXAVFJbGtMB2BbVg9U+46uDVAwvb
         mW3+T17DR98iKb/CTcKr2rU5fUJe4wEpXkmpsi/iTJG+Z0//Kr2KoAJJpvWkIqgRKh
         kv6ZWW4lNc7Nw==
Date:   Sun, 22 Jan 2023 17:01:05 +0000
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
Message-ID: <20230122170105.6a1a9766@jic23-huawei>
In-Reply-To: <45b9b378-6619-c47a-b5ea-6b6b7edca785@linaro.org>
References: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
        <20230118184413.395820-3-krzysztof.kozlowski@linaro.org>
        <20230121171709.5eb75e94@jic23-huawei>
        <45b9b378-6619-c47a-b5ea-6b6b7edca785@linaro.org>
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

On Sat, 21 Jan 2023 19:31:23 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 21/01/2023 18:17, Jonathan Cameron wrote:
> > On Wed, 18 Jan 2023 19:44:11 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >   
> >> Do not use underscores and unneeded suffixes (e.g. i2c0) in node name in
> >> examples.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---  
> >   
> >> diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> >> index 6c5ad426a016..12f75ddc4a70 100644
> >> --- a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> >> @@ -42,7 +42,7 @@ examples:
> >>          #address-cells = <1>;
> >>          #size-cells = <0>;
> >>  
> >> -        heart_mon@0 {
> >> +        heart-rate@0 {  
> > 
> > These are both heart-rate and pulse oximeters so measure more than just
> > the rate (oxygen saturation in the blood). Reality is they actually
> > measure light absorption over time, but you can calculate an estimate
> > of both rate and oxygen saturation from that.
> > 
> > I don't really mind simplifying that to heart-rate, but wanted to
> > call this out for possible discussion.  
> 
> They could be heart-mon. The fix is mostly around the underscore. I
> don't have any arguments for changing it to heart-rate, thus we can go
> with whatever you prefer.
I'm fine with either and as we have a patch with heart-rate that wins
currently. I'll just let this sit for a little longer than
normal to see if we get any other responses!

Thanks,

Jonathan
> 
> Best regards,
> Krzysztof
> 

