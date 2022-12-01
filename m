Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA263F715
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiLASEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLASEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:04:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E933B5DB1;
        Thu,  1 Dec 2022 10:04:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACF50620A3;
        Thu,  1 Dec 2022 18:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CB5C433D6;
        Thu,  1 Dec 2022 18:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669917849;
        bh=WZatvnz+QOr1Ir2g+HfL56qhA6VFEJRpPV2/ZJbog/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1GcIvhsLwG8OflIApxBP0BGhBjbKkxusBOBYU+eUci5BagGExkIaqsOJqYVlqbjW
         hMZmt/iuKfySH6DWl4Fxv1HmAW3OPZD0xp0wSUvRX91a5HMxzO/cca+oHFA+bt4BS/
         jtZRslsgJHsLIDVChwFIthKxhyVdIam8a/qYl9kt9ysUTYlVG+PuXb0k8pk+dbjYHn
         vsZ/5sXusz+2b6ERv8t76MbqIn/88cQPHYOOzAKk101TvcvYU44QDy++9mT+4pVpk+
         GF7Kmo1fBfNtsMh5BJ9haY8U6FOaQtGip58H9iMjVHBfZvgEXop0w+xG44IyLXOgVW
         JYq07JRXWF59g==
Date:   Thu, 1 Dec 2022 18:04:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     JiaJie Ho <jiajie.ho@starfivetech.com>
Cc:     "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 6/6] riscv: dts: starfive: Add crypto and DMA node for
 VisionFive 2
Message-ID: <Y4jslJfTVtQ9cIGm@spud>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
 <20221130055214.2416888-7-jiajie.ho@starfivetech.com>
 <1673ef8b-179e-3b03-b3f8-8d347c70d8c3@microchip.com>
 <4ddddceba3dc437daca27374dd2f6fd7@EXMBX068.cuchost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ddddceba3dc437daca27374dd2f6fd7@EXMBX068.cuchost.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 06:17:26AM +0000, JiaJie Ho wrote:
> > -----Original Message-----
> > From: Conor.Dooley@microchip.com <Conor.Dooley@microchip.com>

> > Hey Jia Jie Ho,
> > 
> > On 30/11/2022 05:52, Jia Jie Ho wrote:
> > > [You don't often get email from jiajie.ho@starfivetech.com. Learn why
> > > this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > > the content is safe
> > >
> > > Adding StarFive crypto IP and DMA controller node to VisionFive 2 SoC.
> > >
> > > Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> > > Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
> > 
> > Out of curiosity, what was Huan Feng's contribution to this patch?
> > Did they co-develop it, or is there some other reason?
> > 
> Hi Conor, 
> Yes, Huan Feng co-developed this driver.

In that case, the SoB block should look like:

Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>

Similarly for any other patches they may have co-developed :)

> > >
> > > diff --git
> > > a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> > > b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> > > index 450e920236a5..da2aa4d597f3 100644
> > > --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> > > +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> > > @@ -115,3 +115,11 @@ &tdm_ext {
> > >   &mclk_ext {
> > >          clock-frequency = <49152000>;
> > >   };
> > > +
> > > +&sec_dma {
> > > +       status = "okay";
> > > +};
> > > +
> > > +&crypto {
> > > +       status = "okay";
> > > +};
> > 
> > In what scenario would you not want to have these enabled?

> These drivers are always enabled.
> Is everything ok with the dts node entries?

If the hardware is always present, why not drop the "disabled" in
jh7110.dtsi & these two entries marking them as "okay" in the .dts?

> > > diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > > b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > > index 4ac159d79d66..745a5650882c 100644
> > > --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > > +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > > @@ -455,5 +455,41 @@ uart5: serial@12020000 {
> > >                          reg-shift = <2>;
> > >                          status = "disabled";
> > >                  };
> > > +
> > > +               sec_dma: sec_dma@16008000 {

> > > +                       status = "disabled";

> > > +               };
> > > +
> > > +               crypto: crypto@16000000 {

> > > +                       status = "disabled";

> > > +               };
> > >          };
> > >   };

Thanks,
Conor.

