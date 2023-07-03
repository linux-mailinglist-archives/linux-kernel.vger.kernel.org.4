Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D4E74558A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGCGjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGCGjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:39:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1105EBA;
        Sun,  2 Jul 2023 23:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688366375; x=1719902375;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=VEPPs6PRXRXZJGTgO3/KJayUKcYVwZta2AKwtkQcJmk=;
  b=Z6B6ZCGs43isQGBRGexiB8YUIcILXNgGdTy7NjSKfw6C0Io1e9DGSMzz
   Ypek5mV6ZvO71CMnqfqjJ3eL+TV+lWHPk4MyzjZqlEgraxq/gTCohna8L
   quwlVkBzJebEWLiKOMNQOUPNFDnTz/afpZGokczCkejFQqTNbmkVk0v1m
   LOwjW5vMuE+iswwLIfjyn/dIbeG3exJ+lugs3KANhz0a2I+SgjEmRSunw
   H4J/29uMXlHuabjUJaifiVaKNVgqQg3zACrk1TpqAQAFXGMW4a2D3fZgq
   xcoTka3SyHfCEHa19L2+uDvDe4ocfZwalpfti1SJOLa8CnvRIKxCQeAuM
   g==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="159601256"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2023 23:39:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 2 Jul 2023 23:39:17 -0700
Received: from den-dk-m31857.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Sun, 2 Jul 2023 23:39:15 -0700
Message-ID: <c9e8aef3b052fe51711eab258db3279bebbc4856.camel@microchip.com>
Subject: Re: [PATCH 2/2] ARM: dts: microchip: minor whitespace cleanup
 around '='
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 3 Jul 2023 08:39:14 +0200
In-Reply-To: <20230702185108.43959-2-krzysztof.kozlowski@linaro.org>
References: <20230702185108.43959-1-krzysztof.kozlowski@linaro.org>
         <20230702185108.43959-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-07-02 at 20:51 +0200, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> The DTS code coding style expects exactly one space before and after '=3D=
'
> sign.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> =C2=A0arch/arm/boot/dts/microchip/lan966x-pcb8290.dts | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/microchip/lan966x-pcb8290.dts
> b/arch/arm/boot/dts/microchip/lan966x-pcb8290.dts
> index 8804e8ba5370..3b7577e48b46 100644
> --- a/arch/arm/boot/dts/microchip/lan966x-pcb8290.dts
> +++ b/arch/arm/boot/dts/microchip/lan966x-pcb8290.dts
> @@ -28,7 +28,7 @@ &aes {
> =C2=A0&gpio {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 miim_a_pins: mdio-pins {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* MDC, MDIO */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pins =3D=C2=A0 "GPIO_28", "GPIO_29";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pins =3D "GPIO_28", "GPIO_29";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 function =3D "miim_a";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>=20
> --
> 2.34.1
>=20
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>

BR
Steen
