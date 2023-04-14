Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F56A6E2760
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjDNPtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDNPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:49:46 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16361C647;
        Fri, 14 Apr 2023 08:49:26 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 79924D0C6C;
        Fri, 14 Apr 2023 15:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681487313; bh=gQLrJ2GzF9BgXS74O5aTTZWutfpFFW5QLaGMKa3LvgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=codrCFgkS0x3sCmSAS9eviU+MbyGLf1fSUsWFRoHm+QBoySpnDl4IioL+hwZykxDA
         n8/jkieiDtOPxk5cGJf4wDtMrc157ytPcWYAK2DKuMtkshMpgG8pDVz8YM3LDKfllv
         tVqU+uSkhU1PIdX+00LCRQLiCJcXyYkwha0378eg=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 8/8] arm64: dts: qcom: sdm632-fairphone-fp3: Add notification LED
Date:   Fri, 14 Apr 2023 17:48:32 +0200
Message-ID: <6048598.DvuYhMxLoT@z3ntu.xyz>
In-Reply-To: <ZDlF5ixavPw+J2fR@duo.ucw.cz>
References: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
 <20230414-pmi632-v1-8-fe94dc414832@z3ntu.xyz> <ZDlF5ixavPw+J2fR@duo.ucw.cz>
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

On Freitag, 14. April 2023 14:24:06 CEST Pavel Machek wrote:
> On Fri 2023-04-14 01:17:52, Luca Weiss wrote:
> > The phone features a notification LED connected to the pmi632. Configure
> > the RGB led found on it.
> 
> Could you document the usage in Documentation/leds/well-known-leds.txt
> so that all phones share the same name for the RGB notification LED?

This dts results in /sys/class/leds/rgb:status like (presumably) all of these 
existing in-tree users:
* qcom-msm8974-lge-nexus5-hammerhead.dts
* qcom-msm8974-sony-xperia-rhine.dtsi
* qcom-msm8974pro-fairphone-fp2.dts
* qcom-msm8974pro-sony-xperia-shinano-castor.dts
* freescale/imx8mq-librem5.dtsi
* qcom/msm8996-xiaomi-common.dtsi
* qcom/sdm630-sony-xperia-nile.dtsi
* qcom/sdm845-shift-axolotl.dts

However I can send a patch adding it to this txt doc since it doesn't seem to 
be there yet.

Regards
Luca

> 
> Thanks,
> 								
Pavel




