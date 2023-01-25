Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD6367B821
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbjAYRM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjAYRMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:12:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C7FA244;
        Wed, 25 Jan 2023 09:11:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B05C5B81B4E;
        Wed, 25 Jan 2023 17:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689BFC433A7;
        Wed, 25 Jan 2023 17:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674666697;
        bh=RetSZbgsPvYqvv6AGDmz0Y2yuG9iulSs8DCbaH8Bt78=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CEyaH+bgf2lcwko+f741pV+QMy0dxz2Olo9d9xTL1WwCP+bkqbbWyzTq6ffTKyPzZ
         jFa3v1SPmDrBKh1SjsBi9LXYHRY+V77bNQ9rpqapfki/MThO8gURNUYAvpZIc3T57B
         nUkcF5ONSO62yv/l10IYayHhb+xuxx2mgi4/RZQ4H2132SpJtXoQvVtPOWqyN+hSwG
         oDpuewCjY0y3xKp4316s6VrfZge3SajjG03VP7LDYyyYsViAhfr7a39/wNTBe5nlZj
         ThtqLDUK8oBlq2rUD3m4Mr4MFat46rPa/t1vxd8iXs3K8CXLSDbNTnG6SbfEIcVrm8
         ZRTGUn67f9crw==
Received: by mail-ua1-f43.google.com with SMTP id e18so150147uax.2;
        Wed, 25 Jan 2023 09:11:37 -0800 (PST)
X-Gm-Message-State: AFqh2kogoWNEFf0cF2EJQUxCYaeVXCbpWJz0z+5WjjT+vNHRMinGpaIs
        harDr2h2FtSV1WHRGeiTKhtxNe4kxByUI+S+2Q==
X-Google-Smtp-Source: AMrXdXvkBeNWibWQ7iPb1UKnLnMwCQw9G4I7LpDrOPCqvmhVcacTBEc2M+BHEtbF4izLYj2eXZV0gKgfipYxi1WDLuQ=
X-Received: by 2002:ab0:5bda:0:b0:444:2123:f8df with SMTP id
 z26-20020ab05bda000000b004442123f8dfmr3758761uae.86.1674666696257; Wed, 25
 Jan 2023 09:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
 <20230123151302.368277-11-krzysztof.kozlowski@linaro.org> <167451486467.2795286.1299932821783618559.robh@kernel.org>
 <71fd9674-63a7-9887-d602-1f57ae3982aa@linaro.org>
In-Reply-To: <71fd9674-63a7-9887-d602-1f57ae3982aa@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 Jan 2023 11:11:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK7ZYe+PMXZ34WG746JzgGvaLanRpwF2x3sSGdsA7PCSA@mail.gmail.com>
Message-ID: <CAL_JsqK7ZYe+PMXZ34WG746JzgGvaLanRpwF2x3sSGdsA7PCSA@mail.gmail.com>
Subject: Re: [PATCH 11/13] dt-bindings: serial: restrict possible child node names
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     - <devicetree@vger.kernel.org>, linux-riscv@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Chester Lin <clin@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 3:05 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/01/2023 00:05, Rob Herring wrote:
> >
> > On Mon, 23 Jan 2023 16:13:00 +0100, Krzysztof Kozlowski wrote:
> >> The re-usable serial.yaml schema matches every property with ".*"
> >> pattern, thus any other schema referencing it will not report unknown
> >> (unevaluated) properties.  This hides several wrong properties.  It is
> >> a limitation of dtschema, thus provide a simple workaround: expect
> >> children to be only of few names matching upstream usage (Bluetooth,
> >> GNSS, GPS and MCU).
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/bus/intel,ixp4xx-expansion-bus-controller.example.dtb: serial@1,0: Unevalu=
ated properties are not allowed ('intel,ixp4xx-eb-byte-access', 'intel,ixp4=
xx-eb-cycle-type', 'intel,ixp4xx-eb-t3', 'intel,ixp4xx-eb-write-enable' wer=
e unexpected)
> >       From schema: /builds/robherring/dt-review-ci/linux/Documentation/=
devicetree/bindings/serial/8250.yaml
>
> Eh, this is not trivial to solve. The
> "intel,ixp4xx-expansion-bus-controller.yaml" bindings add properties to
> children nodes, just like spi-peripheral-props:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/devicetree/bindings/bus/intel,ixp4xx-expansion-bus-controller.=
yaml?h=3Dv6.2-rc5#n147

Yep, those properties probably need to go into mc-peripheral-props.yaml.

> Any node can be there:
> 1. serial, which was broken since beginning but errors not visible,

8250 only in all likelyhood.

> 2. flash, which work fine just because mtd-physmap.yaml allows it,
> 3. more?

I guess it is *only* external parallel bus devices...

>
> Existing DTS of this ixp4xx controller have different nodes, for example:
> flash, shared-dma-pool, ns8250, arcom,vulcan-gpio, maxim,max6369:

'shared-dma-pool' is odd.

So is max6369. Looks like that h/w was creatively attached.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm/boot/dts/intel-ixp42x-arcom-vulcan.dts?h=3Dv6.2-rc5#n40
>
> Probably we need expansion-bus-controller-peripheral-props.yaml and
> include it in every possible child. Does it sound reasonable?

What's the difference to mc-peripheral-props.yaml?

Honestly, this stuff is somewhat rare that I'd rather worry about it
later. Maybe ixp4xx will be removed by then... We could just comment
out the problematic parts of the example for now.

Rob
