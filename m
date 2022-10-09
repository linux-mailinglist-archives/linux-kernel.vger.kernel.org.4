Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CCC5F8B31
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJIM0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJIM0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:26:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C597A2B24E;
        Sun,  9 Oct 2022 05:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6203F603F3;
        Sun,  9 Oct 2022 12:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B15C433C1;
        Sun,  9 Oct 2022 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665318410;
        bh=tvAq+25whh50Iv33Ti7+LWbk6IcWHxOAd8TzRCQzNEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=awWA6hiJMQOarJ25aOMu20UQHHWfwn92afrfirRbdH+FEZvmY18ZE8Ks9NbMwRGNI
         LojMQBK9HU5pDJpzpZjz0fjFqlejMhhH8jK6AuIda1uRBQfMoX7t8KapNEnrn9Rgq7
         YtPKCpZTKFa7oAS3VBIrJRxrW+/q9SMqxrGcke+//13i5HExIefo/ROA8LZ7YCComx
         ZxQXobNiUcRLRBrwOEa+8UkK10egEYCuzKH+s5IdmiupqTvknxNOkxNZ9H4X80YOfY
         KcS/T83vqdXWeUZ0oMvU8g1Ibo9H+28tKBmeJLEOckWxhXXjFk7b/ioE8NKKi2ID7b
         QVLF4tyeqreEA==
Date:   Sun, 9 Oct 2022 13:27:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/5] dt-bindings: iio: Add KX022A accelerometer
Message-ID: <20221009132711.16055354@jic23-huawei>
In-Reply-To: <7bbc0c04-04a8-f2c6-0436-3be0fc1013c7@gmail.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
        <80fa42040f385eb47f4f3c71b9b02f643a643e38.1665066397.git.mazziesaccount@gmail.com>
        <fc7c064f-074a-e66a-07b3-541f2ad56804@linaro.org>
        <7bbc0c04-04a8-f2c6-0436-3be0fc1013c7@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu, 6 Oct 2022 18:32:22 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi dee Ho Krzysztof,
> 
> On 10/6/22 18:23, Krzysztof Kozlowski wrote:
> > On 06/10/2022 16:37, Matti Vaittinen wrote:  
> >> KX022A is a 3-axis Accelerometer from ROHM/Kionix. The sensor features
> >> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> >> tap/motion detection, wake-up & back-to-sleep events, four acceleration
> >> ranges (2, 4, 8 and 16g) and probably some other cool features.
> >>  
> > 
> > Thank you for your patch. There is something to discuss/improve.
> >   
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: kionix,kx022a
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  interrupts:
> >> +    minItems: 1
> >> +    maxItems: 2
> >> +
> >> +  interrupt-names:
> >> +    minItems: 1
> >> +    maxItems: 2
> >> +    items:
> >> +      enum:
> >> +        - INT1
> >> +        - INT2  
> > 
> > This allows any order, which I assume was your intention.  
> 
> Yes. I don't see real need to restrict ordering - besides, with my 
> yaml/schema skills it'd took eternity to find corrct example(s) ;)
> 
> My intention is that the user can give either one of these - or both. 
> Order needs naturally to match the order of IRQs - but this we can't know.
> 
> > However maybe
> > at least fix it a bit like:
> > minItems: 1
> > items:
> >    - enum: [ int1, int2]
> >    - const: int2  
> 
> If you say so XD
> I can fix this for v3 :)
If my limited understanding is correct, one advantage of this restriction
is that we can't have

"INT1", "INT1"
though that may be prevented elsewhere...

There is no loss of useful flexibility in how Krzysztof suggested doing it
so looks like a good suggestion to me.

Jonathan
