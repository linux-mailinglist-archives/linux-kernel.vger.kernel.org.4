Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3F37347E2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 21:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjFRTLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 15:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjFRTLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 15:11:38 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898821B6;
        Sun, 18 Jun 2023 12:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687115492; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lQynQm4TBgm2oPzFgVhKTiDlfm5RqIGuhIDN8h1xeR0njFroEQGHuHLeiVWBAJpupP
    eS33rLTDtS893Gj9pW4C+YHTF4vrb5Q/zK+KxCvEX6h8Zmx2Ol0w0/r4hRUYurN/WhrY
    NKZ8Nn0nd2W3dob3OkPr1262Odw6MyQ6GofT5kCLviHyhpXgU+mdQrbLC/EAqAbJG/fQ
    KGbW2XTf5JCkIPCF6ckwuaBWqpFuU2RcW8OlHI01+LGWrQQP/bCdS0dBnfyHclXqan0h
    SWuQ60GzrX2TTFpyDycNRDGrCmrF5hdLqkynZUTSDdrodxhojwAczDcOVnxi91i2ym6D
    dcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687115492;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FJMWBLVxHgWe48faKZRs40upiT2yzn0xKgnw2MVIZWM=;
    b=hE67MlzWy6GMUIMCASjLk4ocMHGbl/nFQIi9hmUfe3P+Apv9l4VTDcRAnufN7lJwIl
    aMJA072Slf3hR63aSEF2xfJjvjCzj5pWv6FizIHVQ6ucwagV8lFQ5Y0ZaNaH3B/lQhPX
    vUVeujLRG1eZOH/CB5KrdsdFngzOqBkBTSJU5QciXz7IUQbHS4HOjSVQxQ+DVbaN5BUx
    K5jAE94bjkwytAIElot4XSOmJn85pNaqf5KTvkSYdkKJsQJ+7QeJ/1rEt+L0bwzAwcKF
    iW24CutL6/mP/JRHyIyV+oz+1oDYiKlL/LO3gfYXDTjDUxh1zQ/YXNLG+hwXwerXmq24
    qBjg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687115492;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FJMWBLVxHgWe48faKZRs40upiT2yzn0xKgnw2MVIZWM=;
    b=YbhDKRYKpFWVDUU2/MBK6STXwSjorBYv7xYEmS6a6yOGzkaTX/9zeJtMkcYndQ18c7
    iUv7YxoBOSLiTNYokZjyd4sf+JSuez0ggkAZckwQL+L/2Lkf1qQxq4xFkPeh178OCf7F
    yTyhDGCv5aUMI554B5knidfXNnxr6+yMbVG4PA6bjPlrodXSFGQSY5V/Zqp+R2TEvkQh
    thT7JJhq/8fQw0dS45qBRe+UEDbV2Z2apYLYW78qcOrc7wAdYNQCl5WEw9YboWDFITsU
    oZEpSrNI1axVP+PXWuYiRo7AHNR4aiDAhM3p5rLgGu/XU9Ajj1RBkAPXuVxY24chzbC/
    dNAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687115492;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FJMWBLVxHgWe48faKZRs40upiT2yzn0xKgnw2MVIZWM=;
    b=oF54QNymzT0Ibs4uevVULRe9zB9GwGr3yz6CddEyWCruKLzznt8IRe5aKPHvcgcJ1y
    gYTMNeJHYjqgNPXf7fDw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA+pvh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5IJBW9YU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 18 Jun 2023 21:11:32 +0200 (CEST)
Date:   Sun, 18 Jun 2023 21:11:29 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH RESEND] arm64: dts: qcom: msm8916-samsung-serranove: Add
 RT5033 PMIC with charger
Message-ID: <ZI9WjmWhkUh_bdz6@gerhold.net>
References: <20230617002934.39408-1-jahau.ref@rocketmail.com>
 <20230617002934.39408-1-jahau@rocketmail.com>
 <ZI2_565RFDtR3Sa-@gerhold.net>
 <ab3e475f-27ae-e718-60bd-cb22f5070942@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3e475f-27ae-e718-60bd-cb22f5070942@rocketmail.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 06:49:16PM +0200, Jakob Hauser wrote:
> On 17.06.23 16:15, Stephan Gerhold wrote:
> > On Sat, Jun 17, 2023 at 02:29:34AM +0200, Jakob Hauser wrote:
> 
> ...
> 
> > > +		regulators {
> > > +			safe_ldo_reg: SAFE_LDO {
> > > +				regulator-name = "SAFE_LDO";
> > > +				regulator-min-microvolt = <4900000>;
> > > +				regulator-max-microvolt = <4900000>;
> > > +				regulator-always-on;
> > > +			};
> > > +			ldo_reg: LDO {
> > > +				regulator-name = "LDO";
> > > +				regulator-min-microvolt = <2800000>;
> > > +				regulator-max-microvolt = <2800000>;
> > > +			};
> > > +			buck_reg: BUCK {
> > > +				regulator-name = "BUCK";
> > > +				regulator-min-microvolt = <1200000>;
> > > +				regulator-max-microvolt = <1200000>;
> > > +			};
> > 
> > The "regulator-name"s here don't really seem useful, since they're just
> > the same as the ones already declared in the driver. Can you drop them?
> > Alternatively you could assign more useful board-specific names, such as
> > the CAM_SENSOR_A2.8V that was used downstream.
> > 
> > Also, I think it would be slightly clearer to prefix the regulator
> > labels (safe_ldo_reg, ldo_reg etc) with rt5033_. Perhaps
> > "rt5033_ldo_reg" or "rt5033_reg_ldo"?
> 
> ...
> About the "regulator-name"s I wasn't really aware. I don't have a strong
> opinion on this.
> 
> With the downstream names, it would look like this:
> 
> regulators {
> 	rt5033_reg_safe_ldo: SAFE_LDO {
> 		regulator-name = "RT5033SafeLDO";
> 		regulator-min-microvolt = <4900000>;
> 		regulator-max-microvolt = <4900000>;
> 		regulator-always-on;
> 	};
> 	rt5033_reg_ldo: LDO {
> 		regulator-name = "CAM_SENSOR_A2.8V";
> 		regulator-min-microvolt = <2800000>;
> 		regulator-max-microvolt = <2800000>;
> 	};
> 	rt5033_reg_buck: BUCK {
> 		regulator-name = "CAM_SENSOR_CORE_1.25V";
> 		regulator-min-microvolt = <1200000>;
> 		regulator-max-microvolt = <1200000>;
> 	};
> 
> Dropping them would look like this:
> 
> regulators {
> 	rt5033_reg_safe_ldo: SAFE_LDO {
> 		regulator-min-microvolt = <4900000>;
> 		regulator-max-microvolt = <4900000>;
> 		regulator-always-on;
> 	};
> 	rt5033_reg_ldo: LDO {
> 		regulator-min-microvolt = <2800000>;
> 		regulator-max-microvolt = <2800000>;
> 	};
> 	rt5033_reg_buck: BUCK {
> 		regulator-min-microvolt = <1200000>;
> 		regulator-max-microvolt = <1200000>;
> 	};
> 
> I would rather drop them. The first name "RT5033SafeLDO" doesn't add much
> information. The other two I'm not fully sure if they provide the cam sensor
> only or if there might be other users as well. Also it add an additional set
> of names. When dropping them, the generic names SAFE_LDO, LDO and BUCK are
> taken from the rt5033-regulator driver.
> 
> Unfortunately, I added the example in the dt-bindings with the generic
> names. So this question might come up again when someone else adds
> rt5033-regulators to another device.
> 
> For the phandle labels I'd go for rt5033_reg_..., I already changed them in
> the examples above.
> 

Sounds good to me, thanks!

Stephan
