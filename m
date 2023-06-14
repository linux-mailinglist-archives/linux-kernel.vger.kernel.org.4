Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F9672FEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244667AbjFNMkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244756AbjFNMkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:40:06 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50029195;
        Wed, 14 Jun 2023 05:40:03 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 0A3783EBC2;
        Wed, 14 Jun 2023 14:40:02 +0200 (CEST)
Date:   Wed, 14 Jun 2023 14:40:00 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8250-edo: Panel framebuffer is
 2.5k instead of 4k
Message-ID: <kdu6apwgp7nu6mwqatufhxvnbunwodr4iu2uaqjacbjgbmmy5y@zh53imtpqfgs>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>, 
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
        Martin Botka <martin.botka@somainline.org>, Jami Kettunen <jami.kettunen@somainline.org>, 
        Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
        Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
        linux-kernel@vger.kernel.org
References: <20230606211418.587676-1-marijn.suijten@somainline.org>
 <974f68dc-b667-c9a7-94c4-1023ef271fab@linaro.org>
 <a69ddadd-8d59-e784-ddce-16c83a7f13a6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a69ddadd-8d59-e784-ddce-16c83a7f13a6@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-07 09:15:08, AngeloGioacchino Del Regno wrote:
> Il 07/06/23 00:52, Konrad Dybcio ha scritto:
> > 
> > 
> > On 6.06.2023 23:14, Marijn Suijten wrote:
> >> The framebuffer configuration for edo pdx203, written in edo dtsi (which
> >> is overwritten in pdx206 dts for its smaller panel) has to use a
> >> 1096x2560 configuration as this is what the panel (and framebuffer area)
> >> has been initialized to.  Downstream userspace also has access to (and
> >> uses) this 2.5k mode by default, and only switches the panel to 4k when
> >> requested.
> >>
> >> This is similar to commit be8de06dc397 ("arm64: dts: qcom:
> >> sm8150-kumano: Panel framebuffer is 2.5k instead of 4k") which fixed the
> >> same for the previous generation Sony platform.
> >>
> >> Fixes: 69cdb97ef652 ("arm64: dts: qcom: sm8250: Add support for SONY Xperia 1 II / 5 II (Edo platform)")
> >> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> >> ---
> > And so I derped again.
> > 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> I would've liked more to see a commit saying "replace simple-framebuffer with xxxx"
> (where xxxx is DSI panel, etc) but that will as well do for now... :-)

Fwiw we could keep it around as MDSS "gracefully" takes over when it
probes a little bit later with fbcon over DRM/KMS, and it sometimes
helps reading what is up when something fails before or during MDSS
probe.

- Marijn

> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> > 
> > Konrad
> >>
> >> Changes since v2:
> >> - Rename griffin (copy-paste from related patch) to pdx203 in comment.
> >>
> >>   arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi | 7 ++++---
> >>   1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> >> index 3d22be747f042..8f867f841cb83 100644
> >> --- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> >> @@ -54,9 +54,10 @@ chosen {
> >>   		framebuffer: framebuffer@9c000000 {
> >>   			compatible = "simple-framebuffer";
> >>   			reg = <0 0x9c000000 0 0x2300000>;
> >> -			width = <1644>;
> >> -			height = <3840>;
> >> -			stride = <(1644 * 4)>;
> >> +			/* pdx203 BL initializes in 2.5k mode, not 4k */
> >> +			width = <1096>;
> >> +			height = <2560>;
> >> +			stride = <(1096 * 4)>;
> >>   			format = "a8r8g8b8";
> >>   		};
> >>   	};
> 
