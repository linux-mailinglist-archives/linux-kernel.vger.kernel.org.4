Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E33860926D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 13:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiJWLJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 07:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJWLJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 07:09:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44765B4A1;
        Sun, 23 Oct 2022 04:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDB39B80D19;
        Sun, 23 Oct 2022 11:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEF5C433C1;
        Sun, 23 Oct 2022 11:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666523368;
        bh=hiZr0V8wLCVK725mDTsg+Vkx2ABBUDMJRSowxO1xsOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nzcbqZoukgqsGngCsoasbc3DUs/PIuJup7jsyBYc5ztDIvRUFEEGnst53E/LSwJ7m
         DQ6vj8QU/IM91WlLGg9JWICdYqqaY6VNRAwTjxiDUxDvkBB6OXWZplT0r47jddXyhO
         8o6AMrATI6a6iEnePYL0RHhgd/HIe7O5gOfDcTgpwcYNlyRxOK4bSI3Pm9WxhTLTAo
         e2/HQBthr4c8D6mm91FhQDrxLkuXwYdYLX3/J8XqUWV3+290By6AdJIzHc9Vjqy+Na
         QeSyXdPScNCtiOa2QrfeetG66hankx6k6a4l/WfPJ5KmTaoC1PeoAogd98SzCM+iOZ
         XIMdMubqJ/oGA==
Date:   Sun, 23 Oct 2022 12:10:02 +0100
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
Message-ID: <20221023121002.742bc48f@jic23-huawei>
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
Please give a fixes tag for this one as well.
The driver should never have been doing this.

Jonathan

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
> 
> Best regards,
> Marcus Folkesson

