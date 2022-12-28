Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DE665870F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 22:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiL1Va4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 16:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiL1Vaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 16:30:52 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB93C140BC;
        Wed, 28 Dec 2022 13:30:50 -0800 (PST)
Received: from g550jk.localnet (2a02-8388-6582-fe80-0000-0000-0000-0005.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::5])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 8ACF1CB42D;
        Wed, 28 Dec 2022 21:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1672263049; bh=R5soxCa2nbRONnnIoOyx6lQyz71J9M+o4tRpsv7zD70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kDJwpTiEItwDlltv01z04XOJQnmOabmI9wvG/eEMAN0HjL3svfwbEBXbgJWEhFCKx
         wbCU0NO8S3i8xoDJX9Ysf6WQ3E0hVvHs1Jr1E4XCC5TaAGgvkDYxQML0n/avhcQ/U+
         UADXhM+hVuGOMiBiFYZCDPJWC71khov49SiLfN4I=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] regulator: dt-bindings: qcom,usb-vbus-regulator: change
 node name
Date:   Wed, 28 Dec 2022 22:30:47 +0100
Message-ID: <12119366.O9o76ZdvQC@g550jk>
In-Reply-To: <20221031173933.936147-2-luca@z3ntu.xyz>
References: <20221031173933.936147-1-luca@z3ntu.xyz>
 <20221031173933.936147-2-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 31. Oktober 2022 18:39:32 CET Luca Weiss wrote:
> usb-vbus-regulator is a better generic node name than dcdc to change the
> example to match.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Bump? Can this patch be picked up please?

> ---
> Changes in v2:
> * New patch
> 
>  .../devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> index dbe78cd4adba..b1cff3adb21b 100644
> ---
> a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> +++
> b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> @@ -33,7 +33,7 @@ examples:
>       pm8150b {
>          #address-cells = <1>;
>          #size-cells = <0>;
> -        pm8150b_vbus: dcdc@1100 {
> +        pm8150b_vbus: usb-vbus-regulator@1100 {
>              compatible = "qcom,pm8150b-vbus-reg";
>              reg = <0x1100>;
>          };




