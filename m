Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69CD63C738
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbiK2Scc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbiK2ScX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:32:23 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ABC68C6E;
        Tue, 29 Nov 2022 10:32:20 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D6176C7D94;
        Tue, 29 Nov 2022 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1669746709; bh=xI6kMiCf4Tsqu4BZfjhWwUhGCtpCyijEZHJ1c16Hm8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=rYg1wZXp2d2ADKVSmTfn7SCKk0IHjoZ/9J6vaRQR8xWiYIbZGV2GtRqsBxl7p0s1X
         rcmOTLT1uOfN9f5yptEZFr4YifrmqQQJuf7rJ03EezmzSur3k/3yhSjavwysZ2vRnf
         M4H8tqYMCrPVLkJ91VJfLrLCuharuwnbzEcV20DY=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/2] arm64: dts: qcom: sdm632-fairphone-fp3: Add NFC
Date:   Tue, 29 Nov 2022 19:31:47 +0100
Message-ID: <3134585.5fSG56mABF@g550jk>
In-Reply-To: <b20432e8-115c-407f-2480-6dd429ce5c25@linaro.org>
References: <20221128173744.833018-1-luca@z3ntu.xyz> <20221128173744.833018-2-luca@z3ntu.xyz> <b20432e8-115c-407f-2480-6dd429ce5c25@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 29. November 2022 14:29:36 CET Konrad Dybcio wrote:
> On 28.11.2022 18:37, Luca Weiss wrote:
> > Configure the node for the NQ310 chip found on this device, which is
> > compatible with generic nxp-nci-i2c driver.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > RESEND to fix Cc
> > 
> >  arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> > b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts index
> > 2920504461d3..fde93cbcd180 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> > @@ -63,6 +63,21 @@ touchscreen@48 {
> > 
> >  	};
> >  
> >  };
> > 
> > +&i2c_5 {
> > +	status = "okay";
> > +
> > +	nfc@28 {
> > +		compatible = "nxp,nq310", "nxp,nxp-nci-i2c";
> 
> Unless there was some binding change (that was not emailed to me with
> this email, I only got 2/2), only "nxp,nxp-nci-i2c" and
> "nxp,pn547", "nxp,nxp-nci-i2c" are allowed.

Yes, I've added the double compatible to the yaml.
https://lore.kernel.org/lkml/20221128173744.833018-1-luca@z3ntu.xyz/

I'll try to work on my Cc-script setup, currently it adds the output of 
get_maintainers.pl for each patch (and adds all for the cover letter), which 
is based on some script I found a while ago online.

Is there like a recommended way to put all people in Cc for a series, I'm not 
aware of anything at least...

Perhaps I'll look into b4 for sending patches, that seems to have some goodies 
there.

Regards
Luca

> 
> The node looks good though.
> 
> Konrad
> 
> > +		reg = <0x28>;
> > +
> > +		interrupt-parent = <&tlmm>;
> > +		interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +		enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
> > +		firmware-gpios = <&tlmm 62 GPIO_ACTIVE_HIGH>;
> > +	};
> > +};
> > +
> > 
> >  &pm8953_resin {
> >  
> >  	status = "okay";
> >  	linux,code = <KEY_VOLUMEDOWN>;




