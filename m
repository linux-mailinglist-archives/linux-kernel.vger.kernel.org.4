Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04287626A36
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiKLP2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiKLP2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:28:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E005D2727;
        Sat, 12 Nov 2022 07:28:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92576B8093B;
        Sat, 12 Nov 2022 15:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FD6C433C1;
        Sat, 12 Nov 2022 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668266908;
        bh=XPbsk0OfT62ZB9bSFoUUhiNlQ6C8M0NyQPR2OIt4XVg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gFKY2phJ6GZtVCyfTvO2TiyEPMewqJ1CaO5SBHYyA0rHSnWrnLFLl86FLrbMCDTNb
         CdQaXgQ8Ze/KoKMSE+pPKdnBI6xq0qUgLr6u/f/XyxeyrzfzhiqYcWNZEUr9rloH3F
         7Uj7EUkhsI3KONhzkGNX2x5zuMryGm6GBr3RmOS8iBDQmB07aTo6S+D0mQFlzfO8ol
         0NlKHjJ4Do2ZJTIlavMA7M+8v7htYVVYOkhsdLwKBQ4PpNQkVsFNDa4vbmla+tLEan
         DC5DPCYFzjPsgsYV8Kv8TAzKIhZEQnIW1ki0dG0qitgBut/x4HGfFswrjlD0l/P0hQ
         o+YMJ+HmQzvuw==
Date:   Sat, 12 Nov 2022 15:40:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: addac: add AD74115
Message-ID: <20221112154040.54dc5cf2@jic23-huawei>
In-Reply-To: <c01b0e56563b2b6f8ef48ad90977646706a2c933.camel@gmail.com>
References: <20221103094436.2136698-1-demonsingur@gmail.com>
        <20221103094436.2136698-2-demonsingur@gmail.com>
        <20221106154634.2286faf3@jic23-huawei>
        <c01b0e56563b2b6f8ef48ad90977646706a2c933.camel@gmail.com>
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


> >   
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      Conversion range for ADC conversion 2.
> > > +      0 - 0V to 12V
> > > +      1 - -12V to +12V
> > > +      2 - -2.5V to +2.5V
> > > +      3 - -2.5V to 0V
> > > +      4 - 0V to 2.5V
> > > +      5 - 0V to 0.625V
> > > +      6 - -104mV to +104mV
> > > +      7 - 0V to 12V  
> > 
> > For a lot of similar cases we handle these numerically to give
> > a human readable dts.  Is there a strong reason not to do so here (in mv)
> >   
> 
> I used this approach mostly because it maps dirrectly to register values
> and because it's easier to parse. dts isn't exactly nice at handling
> negative values. I can switch it to mv array if you insist.

We have quite a few existing cases of
adi,[output-]range-microvolt so it would be good to copy that style here.

> 
> >   
> > > +    minimum: 0
> > > +    maximum: 7
> > > +    default: 0
> > > +
