Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2036F0B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbjD0RvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243982AbjD0RvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:51:22 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFC210D;
        Thu, 27 Apr 2023 10:51:21 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id DD897CCBE1;
        Thu, 27 Apr 2023 17:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682617849; bh=NIY1N6khezq9+ZTcdf4CI2PZJx2zYchLwM1fp6lZo0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aXEMnvun3ENv8iPHd1MiLBtsE5FXHEqngQMklwv+OslGFTyAdx9vqOnq8xShhCEg8
         +0cqiUeamn2INSEdAz7NDlFZU70J9NNbqnAuwo/H2kbdGg2ph3hEco01xg0Qs4Wtnr
         2WXv4VZNp1i33nchNq6wUl9EyUd3WxUh4R8YyEEk=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Lee Jones <lee@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 8/8] Documentation: leds: Add "rgb:status" path
Date:   Thu, 27 Apr 2023 19:50:47 +0200
Message-ID: <5823752.MhkbZ0Pkbq@z3ntu.xyz>
In-Reply-To: <20230427160559.GC50521@google.com>
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
 <20230414-pmi632-v2-8-98bafa909c36@z3ntu.xyz>
 <20230427160559.GC50521@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 27. April 2023 18:05:59 CEST Lee Jones wrote:
> On Tue, 18 Apr 2023, Luca Weiss wrote:
> > The path /sys/class/leds/rgb:status is already widely used with the
> > qcom-lpg driver and others. Document it.
> 
> Where is this used?
> 
> $ grep status drivers/leds/rgb/leds-qcom-lpg.c
> <no results>

This is set in devicetree, e.g. from qcom-msm8974pro-fairphone-fp2.dts[0]:

    color = <LED_COLOR_ID_RGB>;
    function = LED_FUNCTION_STATUS;

And then something in the LED core sets the name based on that, I'd have
to dig to find where exactly.

Regards
Luca

[0] https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts#L105-L106

> 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > 
> >  Documentation/leds/well-known-leds.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/leds/well-known-leds.txt
> > b/Documentation/leds/well-known-leds.txt index 2160382c86be..439d4dac4472
> > 100644
> > --- a/Documentation/leds/well-known-leds.txt
> > +++ b/Documentation/leds/well-known-leds.txt
> > @@ -58,6 +58,7 @@ LEDs on notebook body, indicating that sound input /
> > output is muted.> 
> >  * System notification
> > 
> > +Good: "rgb:status"
> > 
> >  Legacy: "status-led:{red,green,blue}" (Motorola Droid 4)
> >  Legacy: "lp5523:{r,g,b}" (Nokia N900)




