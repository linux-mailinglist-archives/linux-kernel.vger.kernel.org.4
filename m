Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF996F4FEE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 08:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjECGHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 02:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjECGHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 02:07:46 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 262A535B0;
        Tue,  2 May 2023 23:07:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9436280EB;
        Wed,  3 May 2023 06:07:40 +0000 (UTC)
Date:   Wed, 3 May 2023 09:07:39 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Julien Panis <jpanis@baylibre.com>, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] arm: dts: Add am335x-boneblack-pps.dts
Message-ID: <20230503060739.GM14287@atomide.com>
References: <20230428105453.110254-1-jpanis@baylibre.com>
 <8e1ee169-603f-4aa4-9f02-68520d708d57@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e1ee169-603f-4aa4-9f02-68520d708d57@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [230428 13:50]:
> On 28/04/2023 12:54, Julien Panis wrote:
> > From: Lokesh Vutla <lokeshvutla@ti.com>
> > +		compatible = "ti,omap-dmtimer-pwm";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pwm7_pins>;
> > +		#pwm-cells = <3>;
> > +		ti,timers = <&timer7>;
> > +		ti,clock-source = <0x00>; /* timer_sys_ck */
> 
> Why this is hex? Should be just 0/1/2?

I think the ti,clock-source can be left out now, this can be done
with assigned-clocks and parents instead. Please grep for some
examples in the current mainline kernel dts files.

Regards,

Tony
