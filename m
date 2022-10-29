Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1805B612378
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJ2OIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ2OIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:08:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DC45AC5C;
        Sat, 29 Oct 2022 07:08:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C859B80CAC;
        Sat, 29 Oct 2022 14:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9D2C433C1;
        Sat, 29 Oct 2022 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667052488;
        bh=JGr+Uek3PMDWEIMIEQSiZHwBUR9OPiTO+sTXsCWYxp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tX+/PuYOQHi0dp8WGTAiCYnLLP46gNUvisLWgJMMAHcrU7Q1ml1dzNcDRBtjp6JHs
         f2Odj2PoCWLy5PC1ZOHKp02n75XjTQIx3Ze9+eYBDs40+L8MUQMom8FYqxar0ixx6r
         oeXXlRpUoc1xvNTfbuZSvt8F9h/kF6X2JoHIjgwXZDjPUwpiX+8QDc6wEJSxnA3MXk
         7ziiLPaCxERGHwpX1vY67u7Pk+dYlPiqBuazc+1TxjjTcR0+M/4NyTz6U3cxEu+bd5
         7zRfi+OdiMOeWpEYfLj5wMuiqU8AA2Vs6SlK6okD9b+AOMR9FBuh1gS8ceqgjkKv4Z
         CDWqbJM+usLdw==
Date:   Sat, 29 Oct 2022 15:20:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] MAINTAINERS: Add KX022A maintainer entry
Message-ID: <20221029152001.5ba70261@jic23-huawei>
In-Reply-To: <7895435f7fd31a3b576fc6a59b01eb3202c85d36.1666614295.git.mazziesaccount@gmail.com>
References: <cover.1666614295.git.mazziesaccount@gmail.com>
        <7895435f7fd31a3b576fc6a59b01eb3202c85d36.1666614295.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 15:40:58 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Add maintainer entry for ROHM/Kionix KX022A accelerometer sensor driver.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Whilst scripts will pick up the subsystem entry, I think it is
also good to have an L: entry for linux-iio@vger.kernel.org
for anyone reading MAINTAINERS directly to figure out who to email.

As such I've added one whilst applying.

Jonathan

> 
> ---
> v4 => v5: After discussion with Joe Perches
> - change myself to a maintainer
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf0f18502372..63cae24a74a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11435,6 +11435,11 @@ F:	drivers/mfd/khadas-mcu.c
>  F:	include/linux/mfd/khadas-mcu.h
>  F:	drivers/thermal/khadas_mcu_fan.c
>  
> +KIONIX/ROHM KX022A ACCELEROMETER
> +M:	Matti Vaittinen <mazziesaccount@gmail.com>
> +S:	Supported
> +F:	drivers/iio/accel/kionix-kx022a*
> +
>  KMEMLEAK
>  M:	Catalin Marinas <catalin.marinas@arm.com>
>  S:	Maintained

