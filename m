Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660EB6EAEA0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjDUQC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjDUQCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:02:55 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E786813F83;
        Fri, 21 Apr 2023 09:02:49 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:02:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1682092964; x=1682352164;
        bh=s7clfCNoIQVJvWOf4u9l4ZWIS1sr2kMZRsQ0SC1x9pY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Hy9QtStWSLNw1oqg3r69lKx9QEkqL/14Gu++LOg2xcZwkwhFoT9F6dd7qVZYiljlD
         +rJn1gG0vwKxCIUkqrDpkGEQRmUWjjowonIN+lM6d3joIBsMwZ+gSXoWXXS7X+azNt
         DXti8JaxV+qYf8SjHwEhdiSObu3pq0phTEppb4wk=
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Maxime Ripard <mripard@kernel.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sdm845-shift-axolotl: update focaltech touchscreen properties
Message-ID: <853c694f-c3d3-f61c-2e5d-0b9b8fd2a326@connolly.tech>
In-Reply-To: <20230415020222.216232-6-joelselvaraj.oss@gmail.com>
References: <20230415020222.216232-1-joelselvaraj.oss@gmail.com> <20230415020222.216232-6-joelselvaraj.oss@gmail.com>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/04/2023 03:02, Joel Selvaraj wrote:
> The touchscreen nodes were added before the driver patches were merged.
> Update the focaltech touchscreen properties to match with the upstreamed
> focaltech driver. Also, the touchscreen used is in axolotl is fts5452
> and not fts8719.
>
> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>

Reviewed-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  .../boot/dts/qcom/sdm845-shift-axolotl.dts     | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm=
64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index b54e304abf71..70286e53e000 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -474,23 +474,21 @@ &i2c5 {
>  =09status =3D "okay";
>
>  =09touchscreen@38 {
> -=09=09compatible =3D "focaltech,fts8719";
> +=09=09compatible =3D "focaltech,fts5452";
>  =09=09reg =3D <0x38>;
> -=09=09wakeup-source;
> -=09=09interrupt-parent =3D <&tlmm>;
> -=09=09interrupts =3D <125 0x2>;
> -=09=09vdd-supply =3D <&vreg_l28a_3p0>;
> -=09=09vcc-i2c-supply =3D <&vreg_l14a_1p88>;
>
> -=09=09pinctrl-names =3D "default", "suspend";
> +=09=09interrupts-extended =3D <&tlmm 125 IRQ_TYPE_EDGE_FALLING>;
> +=09=09reset-gpios =3D <&tlmm 99 GPIO_ACTIVE_LOW>;
> +
> +=09=09avdd-supply =3D <&vreg_l28a_3p0>;
> +=09=09vddio-supply =3D <&vreg_l14a_1p88>;
> +
>  =09=09pinctrl-0 =3D <&ts_int_active &ts_reset_active>;
>  =09=09pinctrl-1 =3D <&ts_int_suspend &ts_reset_suspend>;
> +=09=09pinctrl-names =3D "default", "suspend";
>
> -=09=09reset-gpio =3D <&tlmm 99 GPIO_ACTIVE_HIGH>;
> -=09=09irq-gpio =3D <&tlmm 125 GPIO_TRANSITORY>;
>  =09=09touchscreen-size-x =3D <1080>;
>  =09=09touchscreen-size-y =3D <2160>;
> -=09=09focaltech,max-touch-number =3D <5>;
>  =09};
>  };
>
> --
> 2.40.0
>

--
Kind Regards,
Caleb

