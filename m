Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C40B6D56C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 04:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjDDCdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 22:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjDDCdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:33:12 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8041FD7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 19:33:10 -0700 (PDT)
Date:   Tue, 04 Apr 2023 02:32:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1680575586; x=1680834786;
        bh=3nDH2D2gZWk3PxPEgj9RNM8Ufiko6BkiGlNqFRgeZIo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=YmWrCnPNa4OwZh+kUi7OOUQ3rSPOv7wowoSidd4RDgeJ8slNabMfWjBRXlezARAMW
         P4nM8klaV8dvjBDQbig3GZzBRDbH1eWshJ7f3+DIqbZlGXrKEXVbQmlR5BRJb/HGIM
         FUbGoZtS3EK3m1K3sf7wnQ+FqpZB8+KT2ZGtvPA/2/X5+kLCvrSsMvdD3pLsUJvurD
         q4t4fgs9hsy8EU2Jgj0Uu4QZbrpOxRljeuLUvBUKJRPBdDuYoCxFfeO7tQo9GzLamY
         mH9jNZh3wvwRG3gX30JQJoIZiU8ExiOJJlC6agvjm33eSf+vql107GaRYtdB0KJcZl
         J0G6kwHlqOa6A==
To:     Om Parikh <hack3r-0m@proton.me>
From:   hack3r-0m <hack3r-0m@proton.me>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Olof Johansson <olof@lixom.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: alphascale-asm9260: convert to DT schema
Message-ID: <WaJw8WW0_x3pP2NOWf11aNOJx0xB-gZuE9bMTmydhniI0kSNa5M2oJkCp5PNZR9O1ySeV7RRLRf8rkpfiqd_P2udBHGf58x9bHSUZ7Vl4vU=@proton.me>
In-Reply-To: <20230404022015.754177-1-hack3r-0m@proton.me>
References: <20230403004138.326482-1-hack3r-0m@proton.me> <20230404022015.754177-1-hack3r-0m@proton.me>
Feedback-ID: 58440162:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        TO_EQ_FM_DIRECT_MX autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback, I have incorporated the fixes in the patch. Warnin=
gs generated from `checkpatch.pl` script seems to be false positive in this=
 case.

------- Original Message -------
On Tuesday, April 4th, 2023 at 7:51 AM, Om Parikh <hack3r-0m@proton.me> wro=
te:


> Makes alphascale-asm9260 dt bindings adhere to the dt json-schema
> by replacing txt file with yaml file.
>=20
> Signed-off-by: Om Parikh hack3r-0m@proton.me
>=20
> ---
> .../watchdog/alphascale,asm9260-wdt.yaml | 73 +++++++++++++++++++
> .../bindings/watchdog/alphascale-asm9260.txt | 35 ---------
> 2 files changed, 73 insertions(+), 35 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale,=
asm9260-wdt.yaml
> delete mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-=
asm9260.txt
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/alphascale,asm926=
0-wdt.yaml b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-=
wdt.yaml
> new file mode 100644
> index 000000000000..ceee5f086e4a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.y=
aml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/alphascale,asm9260-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Alphascale asm9260 Watchdog timer
> +
> +allOf:
> + - $ref: watchdog.yaml#
> +
> +maintainers:
> + - Oleksij Rempel linux@rempel-privat.de
>=20
> + - Olof Johansson olof@lixom.net
>=20
> +
> +properties:
> + compatible:
> + enum:
> + - alphascale,asm9260-wdt
> +
> + reg:
> + maxItems: 1
> +
> + clocks:
> + items:
> + - description: source clock, used for tick counter
> + - description: ahb gate
> +
> + clock-names:
> + items:
> + - const: mod
> + - const: ahb
> +
> + interrupts:
> + maxItems: 1
> +
> + resets:
> + items:
> + - description: phandle pointing to the system reset controller with lin=
e
> + index for the watchdog.
> +
> + reset-names:
> + items:
> + - const: wdt_rst
> +
> + timeout-sec: true
> +
> + alphascale,mode:
> + description: to specify the reset mode of operation
> + $ref: /schemas/types.yaml#/definitions/string
> + enum: [hw, sw, debug]
> +
> +required:
> + - compatible
> + - reg
> + - clocks
> + - clock-names
> + - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> + - |
> + #include <dt-bindings/clock/alphascale,asm9260.h>
>=20
> + watchdog0: watchdog@80048000 {
> + compatible =3D "alphascale,asm9260-wdt";
> + reg =3D <0x80048000 0x10>;
>=20
> + clocks =3D <&acc CLKID_SYS_WDT>, <&acc CLKID_AHB_WDT>;
>=20
> + clock-names =3D "mod", "ahb";
> + interrupts =3D <55>;
>=20
> + timeout-sec =3D <30>;
>=20
> + alphascale,mode =3D "hw";
> + };
> diff --git a/Documentation/devicetree/bindings/watchdog/alphascale-asm926=
0.txt b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
> deleted file mode 100644
> index 75b265a04047..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -Alphascale asm9260 Watchdog timer
> -
> -Required properties:
> -
> -- compatible : should be "alphascale,asm9260-wdt".
> -- reg : Specifies base physical address and size of the registers.
> -- clocks : the clocks feeding the watchdog timer. See clock-bindings.txt
> -- clock-names : should be set to
> - "mod" - source for tick counter.
> - "ahb" - ahb gate.
> -- resets : phandle pointing to the system reset controller with
> - line index for the watchdog.
> -- reset-names : should be set to "wdt_rst".
> -
> -Optional properties:
> -- timeout-sec : shall contain the default watchdog timeout in seconds,
> - if unset, the default timeout is 30 seconds.
> -- alphascale,mode : three modes are supported
> - "hw" - hw reset (default).
> - "sw" - sw reset.
> - "debug" - no action is taken.
> -
> -Example:
> -
> -watchdog0: watchdog@80048000 {
> - compatible =3D "alphascale,asm9260-wdt";
> - reg =3D <0x80048000 0x10>;
>=20
> - clocks =3D <&acc CLKID_SYS_WDT>, <&acc CLKID_AHB_WDT>;
>=20
> - clock-names =3D "mod", "ahb";
> - interrupts =3D <55>;
>=20
> - resets =3D <&rst WDT_RESET>;
>=20
> - reset-names =3D "wdt_rst";
> - timeout-sec =3D <30>;
>=20
> - alphascale,mode =3D "hw";
> -};
> --
> 2.40.0
