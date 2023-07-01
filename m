Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C72C744B96
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 00:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGAWTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 18:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAWTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 18:19:24 -0400
X-Greylist: delayed 1507 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Jul 2023 15:19:23 PDT
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E6D1AC;
        Sat,  1 Jul 2023 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=xXXdlOkCWm65vKF5GsUiRqvKCb4A+LCa7xc5vezYfgI=; b=YakJMl/5lgW1CugbfVN4XcJLn/
        e3j0i7gOFSOdq54YHbS6MABE5Ahh94u+cHXUapba3iKESmpSRxB+rro3mxQ0UvDQRY0eqKhlxu2vN
        4DgnOJ/IK9S3+GFlFVuuNrYbEZYtB+X7ajce19jhQ7JDaCQ5rR2t8dlM21MBy4nObsl6eavwkV7Qv
        jU4x/tX+mOh3qQ3mNMoLbMvOuCKSM5Y7fJAbx6kUjvrTCDj6h7n1FKJPmO9Qcv7IudHi8jgS3pj4p
        9mTBEpIxhK9N9C5quB/t7aVTW16Hn2Zjh/yWm9rfxTUMjpy4pGUKH8z8AVj89kxXv54mkPZVF4Z4J
        hFNqhr0w==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1qFiXA-00F8ep-Bi; Sat, 01 Jul 2023 23:53:36 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1qFiX8-00FDHi-1D;
        Sat, 01 Jul 2023 23:53:34 +0200
Date:   Sat, 1 Jul 2023 23:53:34 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     jiajie.ho@starfivetech.com
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, olivia@selenic.com,
        herbert@gondor.apana.org.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kernel@esmil.dk,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 3/3] riscv: dts: starfive: Add TRNG node for
 VisionFive 2
Message-ID: <ZKCgXvcbWBGWZnsU@aurel32.net>
Mail-Followup-To: jiajie.ho@starfivetech.com,
        Palmer Dabbelt <palmer@rivosinc.com>, olivia@selenic.com,
        herbert@gondor.apana.org.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kernel@esmil.dk,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230117015445.32500-4-jiajie.ho@starfivetech.com>
 <mhng-348475f1-5880-4951-9692-78210a17acd3@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-348475f1-5880-4951-9692-78210a17acd3@palmer-ri-x1c9a>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-14 18:45, Palmer Dabbelt wrote:
> On Mon, 16 Jan 2023 17:54:45 PST (-0800), jiajie.ho@starfivetech.com wrote:
> > Adding StarFive TRNG controller node to VisionFive 2 SoC.
> > 
> > Co-developed-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> > Signed-off-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> > Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> > ---
> >  arch/riscv/boot/dts/starfive/jh7110.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > index 4ac159d79d66..3c29e0bc6246 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > @@ -455,5 +455,15 @@ uart5: serial@12020000 {
> >  			reg-shift = <2>;
> >  			status = "disabled";
> >  		};
> > +
> > +		rng: rng@1600c000 {
> > +			compatible = "starfive,jh7110-trng";
> > +			reg = <0x0 0x1600C000 0x0 0x4000>;
> > +			clocks = <&stgcrg JH7110_STGCLK_SEC_HCLK>,
> > +				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
> > +			clock-names = "hclk", "ahb";
> > +			resets = <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
> > +			interrupts = <30>;
> > +		};
> >  	};
> >  };
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

It appears that this patch has never been applied, although the rest of
the series has already been merged. Unfortunately it doesn't apply
anymore due to other changes to that file.

Could you please rebase and resend it?

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
