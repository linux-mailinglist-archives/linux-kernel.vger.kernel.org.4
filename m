Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F34060471C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiJSN3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiJSN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:29:15 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A508F1DEC30;
        Wed, 19 Oct 2022 06:16:25 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout3.routing.net (Postfix) with ESMTP id 52353604B1;
        Wed, 19 Oct 2022 09:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666172173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mVNYk8Vdw4aAhhCQKszm0+c9Pkl9JnTakpEnR19atF8=;
        b=JXVqYusBRIyNB+wKF2YAh7PaC83HGvBJkSUpOLsltS11pvKdYAc8mDtWi03eVHaqM5F5mc
        XvQ5dxvKBHbJOAjFuZjrBi7YhD1ELw7RKRU23AGdldqn4Izq/dIgHm24PMgWY+WuC5b0MJ
        3tdDOMqeuhmcRZsiD2Xb1XNGDT+5jjI=
Received: from [127.0.0.1] (tmo-105-196.customers.d1-online.com [80.187.105.196])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 42E10100352;
        Wed, 19 Oct 2022 09:36:12 +0000 (UTC)
Date:   Wed, 19 Oct 2022 11:36:07 +0200
From:   Frank Wunderlich <linux@fw-web.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
CC:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_v1_02/12=5D_dt-bindings=3A_PCI=3A_?= =?US-ASCII?Q?mediatek-gen3=3A_add_support_for_mt7986?=
User-Agent: K-9 Mail for Android
In-Reply-To: <97916360-a24b-0e7d-cc86-9b801fadf869@collabora.com>
References: <20221017104141.7338-1-linux@fw-web.de> <20221017104141.7338-3-linux@fw-web.de> <97916360-a24b-0e7d-cc86-9b801fadf869@collabora.com>
Message-ID: <C1FA3856-F874-4A13-A0E3-922B745958D6@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 8bc0a8f8-5856-4d54-aa98-5d53cb6e65c2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19=2E Oktober 2022 10:28:59 MESZ schrieb AngeloGioacchino Del Regno <ang=
elogioacchino=2Edelregno@collabora=2Ecom>:
>Il 17/10/22 12:41, Frank Wunderlich ha scritto:

>If this SoC has a different clock tree=2E=2E=2E then you should add bindi=
ngs for this
>kind of clock tree=2E
>
>CLK_INFRA_IPCIER_CK is *not* a peri clock: "peri" means PERICFG, which do=
es not
>seem to be present in this SoC=2E=2E=2E so no, you can't assign it to "pe=
ri_26m", nor
>you can assign it to tl_32k, as that's not a 32KHz clock=2E
>
>CLK_INFRA_PCIEB_CK can be a "top_133m" clock=2E=2E=2E as it is gating "sy=
saxi_sel",
>which is a topckgen clock=2E
>
>CLK_INFRA_IPCIE_CK is your "tl_(something)" clock, as that's effectively =
gating
>"pextp_tl_ck_sel" (which is the PCIe Transaction Layer clock mux)=2E
>
>CLK_INFRA_IPCIE_PIPE_CK seems to be parented to "top_xtal", frequency =3D=
 40MHz,
>so I don't see how can this be a pl_250m? Looks like being a 40m clock an=
d I
>wish we didn't have clock frequencies specified in the names, as "pl" wou=
ld fit,
>but "pl_250m" does not=2E
>I wonder if we can change the clock names and reflect the changes to the =
mt8192
>devicetree (mt8195 does not have any pcie node yet), and if that would be=
 a good
>idea right now=2E
>
>=2E=2E=2Eand I've left the first for last, because=2E=2E=2E
>
>CLK_INFRA_PCIE_SEL: I have no datasheet for this SoC, but if you're sure =
that
>this clock is selecting the source clock to CLK_INFRA_IPCIE_CK, then the =
clock
>driver is wrong=2E=2E=2E
>
>Right now, I see the following:
>
>static const char *const infra_pcie_parents[] __initconst =3D {
>	"top_rtc_32p7k", "csw_f26m_sel", "top_xtal", "pextp_tl_ck_sel"
>};
>
>GATE_INFRA2(CLK_INFRA_IPCIE_CK, "infra_ipcie", "pextp_tl_ck_sel", 12),
>
>MUX_GATE_CLR_SET_UPD(CLK_INFRA_PCIE_SEL, "infra_pcie_sel",
>		     infra_pcie_parents, 0x0028, 0x0020, 0x0024, 0, 2,
>		     -1, -1, -1),
>
>=2E=2E=2E=2Eso if you're right, we should instead have:
>
>GATE_INFRA2(CLK_INFRA_IPCIE_CK, "infra_ipcie", "infra_pcie_sel", 12),
>
>=2E=2E=2E=2Ewith this meaning that adding CLK_INFRA_PCIE_SEL in devicetre=
e is useless=2E
>
>This clock tree looks a bit unclear (because again, there's no datasheet =
around),
>but that's what I understand with a rather fast look in the clock drivers=
 and
>with some experience on other MTK SoCs=2E
>
>Then again, if this tree is effectively incompatible with the one from MT=
8192 and
>MT8195, you should have different clock names=2E=2E=2E and just as a fast=
 idea:
>
>clock-names =3D "axi", "tl", "pl", "top";
>
>with clocks, in order:
>CLK_INFRA_PCIEB_CK, CLK_INFRA_IPCIE_CK,
>CLK_INFRA_IPCIE_PIPE_CK, CLK_INFRA_IPCIER_CK=2E
>
>=2E=2E=2Ebut feel free to reiterate that :-)
>Hope that was helpful=2E
>
>Cheers,
>Angelo

Hi, thanks for digging into the clock-driver=2E Currently i have mapped it=
 like this (see comment to  part7)

clocks =3D <&infracfg CLK_INFRA_IPCIE_PIPE_CK>,
				 <&infracfg CLK_INFRA_IPCIE_CK>,
				 <&clk40m>,
				 <&clk40m>,
				 <&infracfg CLK_INFRA_IPCIER_CK>,
				 <&infracfg CLK_INFRA_IPCIEB_CK>;
			clock-names =3D "pl_250m", "tl_26m", "tl_96m",
				 "tl_32k", "peri_26m", "top_133m";

Mtk says it has same IP block and except missing clocks it is compatible w=
ith mt8xxx gen3 pcie driver/binding=2E Pcie driver only enables the clocks =
in bulk without names,but binding requires the names property so mapping ne=
eds to be correct=2E

regards Frank
