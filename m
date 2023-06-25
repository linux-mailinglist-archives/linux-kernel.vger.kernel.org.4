Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC9473D360
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 21:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFYTnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 15:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFYTnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 15:43:33 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B17197;
        Sun, 25 Jun 2023 12:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687722205; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lyr+MVDZcsfVoEXpC4aAQ2aMCrmhAtXDzQ5h/A/vH8P9gOuHYRB8Ibey526rwem87i
    5+7ih6+suuq8KZxTyi/K5IhWxzm/av95dsNAqSHXMWk2vv1CI23PtnqCLvBQ+Isw26ry
    77RfODnVwpY8YEXumpfbZHt6FZYKG2XRsd8LgvUBy3sp1OWiJjJWBnDPKgmHLsCbXLgX
    MvHJaajm5Uj5sBUMH1zW8tlZHALTGrON7sELkjZ8d8vdq8c7IjczsqQPi3q5sPNgToGe
    HEf3Y2ZCe9PIwn7V709ufhDlA9UIEEIEgNLzINHzCe9ge/CQb+aFgpxbFjtd5c7Mr9N2
    4O6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687722205;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=UI27lRKAueTvziqJ95PkSeucNdhluZtMajGokLChPdY=;
    b=RGtd8ukcv/cg3dkX4ojjKeEA+XJdPyAbPYHQrgpFYOymwaZSVx7s+NwTvFsKBajYAp
    gWTVi03eiVM43+bX0dftR/eG4W1f31ZbEhpl10Q8mrPmKeJS2JMMugjP1aypyOr+NCJN
    LvxsD7/DseyK3q/Js26KZnN8JvMEnVfYXLQj+05H7ExWcEkg7O4hWgXSvzyDwxJUlHNi
    Q34FPBjZtxiymKXf5CfKPdEKahHuYCHdd+JgvNb1qxbP3KkgTDwqOKHGbaz+N9MZv2BQ
    NwJzP6d7Y++nI7x/4pP1eOEPdoztXwAkC5rIuy7poFef1kbSxWeG6WisAvhRfAO7skNP
    nkuw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687722205;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=UI27lRKAueTvziqJ95PkSeucNdhluZtMajGokLChPdY=;
    b=q2QP911BfcXSe0EojVM+Jg60bU2brgnx4BAoSHQIhSRtCw0YOfa/qSaGRcVBP4Osdw
    zKhAGi0Yl7J3eFad2HlFFcDrDDZ5qsI9vaBoCkTBvmnSjigrlCJhcVn7aMef4xVHosVN
    GugtT3LPiVxl0UR6EZI3pogZCNffjNb34WkqHJnZnAWrvcVQoHHYPoH/L1n0oysB6nbH
    6gHLm9wGaIW4/jpX3/W/m0AnN50bHsVVhtXXx5dTJswif8lcW24tDB+Sh+1gcg+l+GDA
    316nWL+rliUK7Rd7RTv56PfzF2u1vVRJ/zLOTpN2XF3GlaBZxVaeyOdfFnE165d2glJj
    zs1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687722205;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=UI27lRKAueTvziqJ95PkSeucNdhluZtMajGokLChPdY=;
    b=Ph7GomV+U4Dddof6kVQaGIjo4oX0bbvsd8+b1zGLyrz2CJZjcWxmfHOG7sVhXrWree
    QwAN4R+R6VIeB35wmEAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266H5F2OxJAdLOdLjE="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id D0d0a8z5PJhNVnY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 25 Jun 2023 21:43:23 +0200 (CEST)
Date:   Sun, 25 Jun 2023 21:43:16 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>, agross@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nikita@trvn.ru, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: msm8939-samsung-a7: Add initial
 dts
Message-ID: <ZJiY1PYtfeIN13ZG@gerhold.net>
References: <20230623100135.5269-1-linmengbo0689@protonmail.com>
 <20230623100237.5299-1-linmengbo0689@protonmail.com>
 <5fbba4e8-a8d9-0e99-e112-31b5781c1648@linaro.org>
 <20230623104647.5501-1-linmengbo0689@protonmail.com>
 <71ae3799-4668-891c-c32d-d36da655d56d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ae3799-4668-891c-c32d-d36da655d56d@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:52:25AM +0100, Bryan O'Donoghue wrote:
> On 23/06/2023 11:47, Lin, Meng-Bo wrote:
> > On Friday, June 23rd, 2023 at 10:27 AM, Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:
> > 
> > > > +++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
> > > > @@ -0,0 +1,495 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "msm8939-pm8916.dtsi"
> > > > +
> > > > +#include <dt-bindings/gpio/gpio.h>
> > > > +#include <dt-bindings/input/input.h>
> > > > +#include <dt-bindings/interrupt-controller/irq.h>
> > > > +
> > > > +/ {
> > > > + model = "Samsung Galaxy A7 (2015)";
> > > > + compatible = "samsung,a7", "qcom,msm8939";
> > > > + chassis-type = "handset";
> > > 
> > > 
> > > Will the downstream bootloader accept this dts without
> > > 
> > > // This is used by the bootloader to find the correct DTB
> > > qcom,msm-id = <239 0>;
> > > 
> > > qcom,board-id = <0xEF08FF1 1>;
> > > 
> > > 
> > > ?
> > > 
> > > https://github.com/msm8916-mainline/lk2nd/blob/master/dts/msm8916/msm8939-samsung-r01.dts#L10
> > > 
> > 
> > Similar to A3 and A5, and the other msm8916 devices, with lk2nd,
> > "qcom,msm-id" or "qcom,board-id" are not required in mainline to boot
> > this dts.
> > If I understand correctly, lk2nd will attempt to boot an image with any
> > qcdt appended.
> > 
> > https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
> > https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
> 
> I understand.
> 
> IMO the upstream DTS should work without depending on lk2nd.
> 
> I'd add the board and msm id to the DTS for that reason.
> 
> If not then I'd put a comment into the DTS explaining the dependency.
> 
> For preference the upstream dts should *just work* as much as possible
> without requiring churning of bootloader.
> 

Is it really worth it to support a half-working bootloader though?

No one will ever be able to use this properly without fixing the
bootloader. SMP doesn't work with the stock bootloader, many devices
need display panel selection in the bootloader and on some Samsung
devices there is not even USB and UART without special fixes in the
bootloader.

In most cases it's easy to just add the qcom,msm-id/qcom,board-id but
there are also some cases with particularly weird bootloaders that are
more complicated.

I would just like to avoid forcing everyone to waste time testing with
the half-working or entirely broken stock bootloaders. We could add the
(guessed) properties without testing but I'm not sure if that's useful.

Thanks,
Stephan
