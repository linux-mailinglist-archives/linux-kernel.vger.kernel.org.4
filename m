Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC324609270
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 13:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJWLMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 07:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJWLL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 07:11:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8769171BE6;
        Sun, 23 Oct 2022 04:11:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 220FBCE0EA9;
        Sun, 23 Oct 2022 11:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E706C433D6;
        Sun, 23 Oct 2022 11:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666523508;
        bh=PRvB53cA0BIluFQSUcreDKe67RMSVT8jvBYFm8OQYfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N8zjEReDEKEkoEbGBZIvz0AuPxdQ3uwuVLWinRlYpGPM/vDQtwUPMQy4oZT4Oogck
         EHVhoLehe2I7BO45lN8jlz72T7oZeYfqHEVPHv/srGXDIt6P19DNUwUjfyq7muOhCx
         cGxdWuEmawK7+p+P+uEf8jBRmZr5hkP2uogIOJX7DCZpaKbGjAS5r6oMZtTRqh+tHQ
         1dbCwh185LIu9srzj3z31Rd7h48uuB8SSt2Z9e9gDKwtVI8mRGo9MWdDLAqKtiwN8O
         /k+NhxM3VsuepmCb+r/m7Z68ij7B+Xo/bnsytNNX+t44tw11mZQYw0KUhn8iqOV0YQ
         uY+Zvbb3oFpNQ==
Date:   Sun, 23 Oct 2022 12:12:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Mitja Spes <mitja@lxnav.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: pressure: ms5611: changed hardcoded SPI
 speed to value limited
Message-ID: <20221023121222.5fe4a743@jic23-huawei>
In-Reply-To: <Y1K7hWKl0siEtaAl@gmail.com>
References: <20221021135827.1444793-1-mitja@lxnav.com>
        <20221021135827.1444793-3-mitja@lxnav.com>
        <Y1K7hWKl0siEtaAl@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 21 Oct 2022 17:32:21 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Hi Mitja,
> 
> On Fri, Oct 21, 2022 at 03:58:21PM +0200, Mitja Spes wrote:
> > Don't hardcode the ms5611 SPI speed, limit it instead.
> > 
> > Signed-off-by: Mitja Spes <mitja@lxnav.com>
> > ---
> >  drivers/iio/pressure/ms5611_spi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
> > index 432e912096f4..a0a7205c9c3a 100644
> > --- a/drivers/iio/pressure/ms5611_spi.c
> > +++ b/drivers/iio/pressure/ms5611_spi.c
> > @@ -91,7 +91,7 @@ static int ms5611_spi_probe(struct spi_device *spi)
> >  	spi_set_drvdata(spi, indio_dev);
> >  
> >  	spi->mode = SPI_MODE_0;
> > -	spi->max_speed_hz = 20000000;
> > +	spi->max_speed_hz = min(spi->max_speed_hz, 20000000U);  
> 
> max_speed_hz is a limit, and the max frequency the ms5611 support is
> 20MHz.
Hi Marcus,

I'm not following what you are commenting on.. Perhaps give more
detail?

Thanks,

Jonathan

> 
> Best regards,
> Marcus Folkesson

