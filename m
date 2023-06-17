Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141487342BE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346416AbjFQRnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjFQRnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:43:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FE8B2;
        Sat, 17 Jun 2023 10:43:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B8BE60D57;
        Sat, 17 Jun 2023 17:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF2DC433C8;
        Sat, 17 Jun 2023 17:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687023797;
        bh=VdxeWrS9KUt+iCyOClhABBxKy/yryWkURfy+fP0gp7s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qFOCh0uVR/ZdkbKIJNd1b7IBWc1M3gz6miI09igZbyPOr/x0P4ybNt53/sa/89Wyc
         IzNHzzhn8my0fodbYycoP5ZdxCTidEHRiPE8+XWONQ0J/G6uKzi7MBA5jQPT3ceQUZ
         9ogjKK+03wGtNrhndWa0K4aYOCa8jNQ/UV5eyOkn/1peQ0X7zOxGBnNplnCfd+7wGK
         FccTqmzWsD9DbRjS6t8Y5FbNtEztlnuLhyHID1Jb1X5M1RezOIpgHtnchctB2hvaSh
         KhxBBOQzqwcJ+8MGRL4IBQ5neDXqyE6wo2o/HXH29inKgbkgkhIY0+aBOJ8Fx9Paqp
         1xCX69rIKVzEQ==
Date:   Sat, 17 Jun 2023 18:43:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 06/13] iio: inkern: Fix headers inclusion order
Message-ID: <20230617184307.3afe7631@jic23-huawei>
In-Reply-To: <20230615152631.224529-7-herve.codina@bootlin.com>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
        <20230615152631.224529-7-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 17:26:24 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Fix the mutex.h inclusion order as it seems to be the only one
> misplaces.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/inkern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index ce537b4ca6ca..71d0424383b6 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -5,9 +5,9 @@
>   */
>  #include <linux/err.h>
>  #include <linux/export.h>
> +#include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> -#include <linux/mutex.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/iio-opaque.h>

