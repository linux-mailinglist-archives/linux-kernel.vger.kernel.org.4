Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A27E6417F8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 18:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLCRIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 12:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLCRIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 12:08:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E111140;
        Sat,  3 Dec 2022 09:08:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72CBA60CA4;
        Sat,  3 Dec 2022 17:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B89C43147;
        Sat,  3 Dec 2022 17:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670087282;
        bh=ppRGsAuveB/mzFObi0kSfA/m3eGVTINv0aX2P7vrwlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ge70MXN73OfY8Bqlh4c4Zaiyhrur6sB9auQEbY7511NDKxTl6EQR7PS3+CVIdBTqX
         UmMplOqzQm5BN+uuCoFVOZn6s6Z0Uw2myZS+qYOJSOjDkI0hz1nICxSuIb8ryB/zno
         rc6cT9aPSMeefhFEJ66M7rcyzoexjdSNbTvKxEPT4cKB5A5i76CVoBqm0bjZfRbrk3
         iInksGyW5gW5l0iI8RRH1eIOEi6XszPVV4cPQU4SpFtduyoq+zEwKxHHNKCcXHPJ1k
         +HiFJwBbmoge82ITfsRUfuKXQxEDaE4vT/z6JhxlEVcvB0BySrf/2Mp/M0dxf6WdrP
         CsjMYE2P2Jxzw==
Date:   Sat, 3 Dec 2022 17:20:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v6 3/3] iio: magnetometer: add ti tmag5273 driver
Message-ID: <20221203172047.2792343e@jic23-huawei>
In-Reply-To: <20221201072220.402585-4-gerald.loacker@wolfvision.net>
References: <20221201072220.402585-1-gerald.loacker@wolfvision.net>
        <20221201072220.402585-4-gerald.loacker@wolfvision.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Dec 2022 08:22:20 +0100
Gerald Loacker <gerald.loacker@wolfvision.net> wrote:

> Add support for TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor.
> Additionally to temperature and magnetic X, Y and Z-axes the angle and
> magnitude are reported.
> The sensor is operating in continuous measurement mode and changes to sleep
> mode if not used for 5 seconds.
> 
> Datasheet: https://www.ti.com/lit/gpn/tmag5273
> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> +		case IIO_ANGL:
> +			/*
> +			 * Angle is in degrees and has four fractional bits,
> +			 * therefore use 1/16 * pi/180 to convert to radiants.
typo. radians

I'll fix whilst applying.
> +			 */

> +}
