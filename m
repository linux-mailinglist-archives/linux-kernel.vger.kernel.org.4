Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177A7656276
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiLZMPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLZMPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:15:02 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0E7632D;
        Mon, 26 Dec 2022 04:15:01 -0800 (PST)
Received: from g550jk.localnet (2a02-8388-6582-fe80-0000-0000-0000-0005.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::5])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 064D9CC3AF;
        Mon, 26 Dec 2022 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1672056900; bh=KgKsT5vm0lVa5rMGzBoUPs4kRQ/QJtx1eq+pNS8Vc7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dzUZR0h5G75rpeVIp0uzXiP8T3QArelvK6KgZzfJPXbcC3AHHqKKdiJKiw32JJKes
         rDUI9FqcGLQVv5mfRAobpJfxQxoKoV/0xub5rLmf2/wVoV41mRCDrx0A4iPku51hK1
         ML+pNZVJAYcxBfKwWA949u7+KSobgkw6QYLE62rY=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayyan Ansari <rayyan@ansari.sh>
Subject: Re: [PATCH 3/3] ARM: dts: qcom: pm8226: add IADC node
Date:   Mon, 26 Dec 2022 13:14:59 +0100
Message-ID: <4448368.LvFx2qVVIh@g550jk>
In-Reply-To: <20221223193403.781355-4-rayyan@ansari.sh>
References: <20221223193403.781355-1-rayyan@ansari.sh>
 <20221223193403.781355-4-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rayyan,

On Freitag, 23. Dezember 2022 20:34:03 CET Rayyan Ansari wrote:
> Add a node for the current ADC (IADC) found in PM8226.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  arch/arm/boot/dts/qcom-pm8226.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi
> b/arch/arm/boot/dts/qcom-pm8226.dtsi index 403324a35cf5..82470549f240
> 100644
> --- a/arch/arm/boot/dts/qcom-pm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
> @@ -88,6 +88,12 @@ adc-chan@f {
>  			};
>  		};
> 
> +		pm8226_iadc: iadc@3600 {

Make this adc@ to conform to qcom,spmi-pmic.yaml docs

> +			compatible = "qcom,spmi-iadc";

Make this "qcom,pm8226-iadc", "qcom,spmi-iadc" and add to docs to conform to 
qcom,spmi-iadc.yaml

Regards
Luca

> +			reg = <0x3600>;
> +			interrupts = <0x0 0x36 0x0 
IRQ_TYPE_EDGE_RISING>;
> +		};
> +
>  		rtc@6000 {
>  			compatible = "qcom,pm8941-rtc";
>  			reg = <0x6000>, <0x6100>;




