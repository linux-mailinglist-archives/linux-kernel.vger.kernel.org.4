Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA7870C305
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjEVQJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjEVQJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:09:55 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017FBB6;
        Mon, 22 May 2023 09:09:53 -0700 (PDT)
Received: from g550jk.localnet (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1F3C4C45E6;
        Mon, 22 May 2023 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684771762; bh=j+9Sowp0SyIyAf6o5+gomO/akh2Bz+qlDtR+/VCtwf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dIhZQFk4witdig6uWv1ICbqWIHUPodt3f0I80BcwyZY9lrocO/7OKp8f/fXmGjb8n
         /00OrYXDnd7Og3tMdYM84cAGFhWiRAssBK83U5rYoaPHs5yoe9s4c+g7jzxlxDCWV/
         J//M7zqPYkAcRAWXQ+ZS/5gUagWhZMN4YMatSdoc=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: qcom: msm8226: Add rpm-stats device node
Date:   Mon, 22 May 2023 18:09:21 +0200
Message-ID: <5673969.DvuYhMxLoT@z3ntu.xyz>
In-Reply-To: <20230520121933.15533-4-matti.lehtimaki@gmail.com>
References: <20230520121933.15533-1-matti.lehtimaki@gmail.com>
 <20230520121933.15533-4-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Samstag, 20. Mai 2023 14:19:32 CEST Matti Lehtim=E4ki wrote:
> Add device node for the rpm-stats pseudo device.
>=20
> Signed-off-by: Matti Lehtim=E4ki <matti.lehtimaki@gmail.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi
> b/arch/arm/boot/dts/qcom-msm8226.dtsi index cb4b4a6d0447..8644540f5aae
> 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -592,6 +592,11 @@ frame@f9028000 {
>  			};
>  		};
>=20
> +		sram@fc190000 {
> +			compatible =3D "qcom,msm8226-rpm-stats";
> +			reg =3D <0xfc190000 0x10000>;
> +		};
> +
>  		rpm_msg_ram: sram@fc428000 {
>  			compatible =3D "qcom,rpm-msg-ram";
>  			reg =3D <0xfc428000 0x4000>;




