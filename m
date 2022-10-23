Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42416092AD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJWMg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJWMgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:36:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46385FF56;
        Sun, 23 Oct 2022 05:36:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8115E60D29;
        Sun, 23 Oct 2022 12:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAF4C433D6;
        Sun, 23 Oct 2022 12:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666528613;
        bh=TlatSqRfmWj6SvyrETxoNuLar38YhNpt1XsCCEbNmmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WYMRIe0ZhfIrWP4jxLDfTCDQeoYqxFXboaTMSYB6SVsj801iZvaiBqk4XfLGokVAE
         KaKNTfZJW3sxHyfroiLF7UZiBmnWXrou7OX1+ICq/WOaRmZqp3027Hhye2Q5YxoULa
         78LnHUWyaG65OtXTl5MDtwECGsK18s1Tvd+c1m3yBMloZ3gIDSV9weT21qjLuIidVY
         0ujqsMKlOORp7fDyfyqyDEr8oepomsu3WUgxGyaN0dzzVRTyshu5g9LNzpT2SCyMi/
         cN4CRkfp3n2FeRXcHE8Grbfjp8aa9MvSQUNvpKdOW/E5lvOGCEx6DIURp9q5QzABDF
         nqzoAsXRgGx1w==
Date:   Sun, 23 Oct 2022 13:37:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Deepak R Varma <drv@mailo.com>, outreachy@lists.linux.dev,
        lars@metafoo.de, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: Re: [PATCH] staging: iio: frequency: ad9834: merge unnecessary
 split lines
Message-ID: <20221023133728.35b6ef26@jic23-huawei>
In-Reply-To: <alpine.DEB.2.22.394.2210170909430.2965@hadrien>
References: <Y0z2/qFe3kW96MTs@debian-BULLSEYE-live-builder-AMD64>
        <alpine.DEB.2.22.394.2210170909430.2965@hadrien>
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

On Mon, 17 Oct 2022 09:10:15 +0200 (CEST)
Julia Lawall <julia.lawall@inria.fr> wrote:

> On Mon, 17 Oct 2022, Deepak R Varma wrote:
> 
> > Improve code readability by merging unnecessary split lines that are
> > well within the code-style guidelines post merge.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>  
> 
> Acked-by: Julia Lawall <julia.lawall@inria.fr>

Not a huge benefit to readability, but as this is in staging, fair enough!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if we missed anything.

Thanks,

Jonathan

> 
> > ---
> >  drivers/staging/iio/frequency/ad9834.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> > index 2b4267a87e65..285df0e489a6 100644
> > --- a/drivers/staging/iio/frequency/ad9834.c
> > +++ b/drivers/staging/iio/frequency/ad9834.c
> > @@ -331,11 +331,9 @@ static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9834_write, AD9834_REG_PHASE1);
> >  static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL, ad9834_write, AD9834_PSEL);
> >  static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
> >
> > -static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
> > -	ad9834_write, AD9834_PIN_SW);
> > +static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL, ad9834_write, AD9834_PIN_SW);
> >  static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL, ad9834_write, AD9834_RESET);
> > -static IIO_DEV_ATTR_OUTY_ENABLE(0, 1, 0200, NULL,
> > -	ad9834_write, AD9834_OPBITEN);
> > +static IIO_DEV_ATTR_OUTY_ENABLE(0, 1, 0200, NULL, ad9834_write, AD9834_OPBITEN);
> >  static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
> >  static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
> >
> > --
> > 2.30.2
> >
> >
> >
> >
> >  

