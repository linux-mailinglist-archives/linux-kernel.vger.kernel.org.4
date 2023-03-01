Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1306A693E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCAI4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjCAI4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:56:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091A128D2C;
        Wed,  1 Mar 2023 00:56:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96E3461254;
        Wed,  1 Mar 2023 08:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B49AC433EF;
        Wed,  1 Mar 2023 08:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677661011;
        bh=8o/qEmUZeq3CS88LJJhl8I4SiIGxhxTJFc5HiEIcKHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SgMGQQVGjhwZHL+rwWCJFtoFUR/wn9crHR6aQMdFafpBEZ4KFGjXYUZgc1lFiVrsN
         mGiOREiQKB5Dxal/wozV2D+J6h48VOzzAVVNonP6DaSW7lzTlb/gjRKP/qOxbthrab
         kWsa73pPSljAA+j7H8/RFIP91L3bZHx2qNQkyZIIWdKIN4b8v8qLuAb8fpWYzsRRTb
         MmejvP4kpBBoTw/3UWR0RdGg/iY9ZCP8IpFgbRggXRtNZNrBHS8BHPgZ35PQZCri6s
         oCExO0cltCKgAYPxInpmQoV2KGxquxREpGl70mlCBMso3JDu+EKi+J39bpraFl3aCY
         b/IqajPaQhUyA==
Date:   Wed, 1 Mar 2023 08:56:45 +0000
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v2 2/2] leds: add aw20xx driver
Message-ID: <Y/8TTRtoFMJhMWV1@google.com>
References: <20230228211046.109693-1-mmkurbanov@sberdevices.ru>
 <20230228211046.109693-3-mmkurbanov@sberdevices.ru>
 <Y/5xBGFC3b9Chdtb@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/5xBGFC3b9Chdtb@duo.ucw.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023, Pavel Machek wrote:

> Hi!
> 
> > +config LEDS_AW200XX
> > +	tristate "LED support for Awinic AW20036/AW20054/AW20072"
> > +	depends on LEDS_CLASS
> > +	depends on I2C
> > +	help
> > +	  This option enables support for the AW20036/AW20054/AW20072 LED driver.
> > +	  It is a 3x12/6x9/6x12 matrix LED driver programmed via
> > +	  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
> > +	  3 pattern controllers for auto breathing or group dimming control.
> 
> I'm afraid this should be handled as a display, not as an array of
> individual LEDs.

Just for my own information, where do we draw the line on this?

Is 4x4 okay?  How about 6x6?

-- 
Lee Jones [李琼斯]
