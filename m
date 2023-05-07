Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF3E6F9813
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 11:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjEGJvJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 7 May 2023 05:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjEGJvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 05:51:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AB984C01;
        Sun,  7 May 2023 02:51:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AFBC2F4;
        Sun,  7 May 2023 02:51:49 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A8D73F64C;
        Sun,  7 May 2023 02:51:02 -0700 (PDT)
Date:   Sun, 7 May 2023 10:50:45 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/5] dt-bindings: spi: sun6i: add DT bindings for
 Allwinner R329/D1/R528/T113s SPI
Message-ID: <20230507105045.085fa058@slackpad.lan>
In-Reply-To: <835082fe07b77db8598aebabe98a74c2c5ac47d1.camel@aosc.io>
References: <20230506232616.1792109-1-bigunclemax@gmail.com>
        <20230506232616.1792109-2-bigunclemax@gmail.com>
        <835082fe07b77db8598aebabe98a74c2c5ac47d1.camel@aosc.io>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 May 2023 12:06:58 +0800
Icenowy Zheng <icenowy@aosc.io> wrote:

Hi,

> 在 2023-05-07星期日的 02:26 +0300，Maksim Kiselev写道：
> > Listed above Allwinner SoCs has two SPI controllers. First is the
> > regular
> > SPI controller and the second one has additional functionality for
> > MIPI-DBI Type C.
> > 
> > Add compatible strings for these controllers
> > 
> > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > ---
> >  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml   | 7
> > +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-
> > a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-
> > a31-spi.yaml
> > index de36c6a34a0f..807dde457e3b 100644
> > --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-
> > spi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-
> > spi.yaml
> > @@ -21,6 +21,7 @@ properties:
> >      oneOf:
> >        - const: allwinner,sun6i-a31-spi
> >        - const: allwinner,sun8i-h3-spi
> > +      - const: allwinner,sun50i-r329-spi
> >        - items:
> >            - enum:
> >                - allwinner,sun8i-r40-spi
> > @@ -28,6 +29,12 @@ properties:
> >                - allwinner,sun50i-h616-spi
> >                - allwinner,suniv-f1c100s-spi
> >            - const: allwinner,sun8i-h3-spi
> > +      - items:
> > +          - enum:
> > +              - allwinner,sun20i-d1-spi
> > +              - allwinner,sun20i-d1-spi-dbi  

This construct doesn't cover the three compatible string case, since we
only get to choose from one of the enums, and always have two strings -
hence my challenge to find the shortest sequence ;-)

> In this case I will prefer to list all 4 compatibles if backward
> compatibility is used:
> "allwinner,sun20i-d1-spi-dbi", "allwinner-sun20i-d1-spi",
> "allwinner,sun50i-r329-spi-dbi", "allwinner, sun50i-r329-spi", in case
> if we were gaining support for either quirks of D1 controller or
> SPI_DBI controllers.

I see where you are coming from, but that order doesn't look right,
since we go back from DBI to normal and then back again. And
"allwinner-sun20i-d1-spi" is not a super set of
"allwinner,sun50i-r329-spi-dbi".
In case we will need a D1 quirk, we could key this to the D1 DBI
compatible as well, I think, so this three string version should work.

Cheers,
Andre

> 
> > +              - allwinner,sun50i-r329-spi-dbi
> > +          - const: allwinner,sun50i-r329-spi
> >  
> >    reg:
> >      maxItems: 1  
> 

