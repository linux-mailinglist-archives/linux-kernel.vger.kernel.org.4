Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F251B64181A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 18:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiLCR2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 12:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiLCR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 12:28:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5BE18368;
        Sat,  3 Dec 2022 09:28:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70819B80689;
        Sat,  3 Dec 2022 17:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85765C433D6;
        Sat,  3 Dec 2022 17:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670088521;
        bh=Vm/dFScHRJYKtLUS2m5pS75eqxLJqj2NxY0Mif7YMhM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jeaCqdsD3UXHITYuv9Pw3ohxk711VrVUvWcQzVqJViZFGC6aMldsBwIDAtDSymBR3
         yZ4PW+cuz/ocYPcu+cA/OaiFXYpdcdcvpTuvZqKPrvOlK3okc+qxFW3mHNfGiqyae8
         AjKm+W+plNyszdPSii4ivq0ySWisAF64/FkRKxoUGSuQYprwKu7rvCTmHR74AXL+cw
         x+tFM5NPE6zcXQxmULbb27An5Sj6g5aaPBwa7w18+1ZlkX6SM3abGP6+tn8TkDwbX8
         DYVglORVQSx4x4TqAT5U/7IQINIfCkfCCDcF6MsxMg8Upre26jS1GIfDjAi6Snd4Hv
         16qkZYscayYJw==
Date:   Sat, 3 Dec 2022 17:41:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,adc081c: Document the binding
Message-ID: <20221203174125.28e1bfbf@jic23-huawei>
In-Reply-To: <ef692f82-61c3-b812-b846-64bde04c8bb3@linaro.org>
References: <20221125220903.8632-1-samuel@sholland.org>
        <ef692f82-61c3-b812-b846-64bde04c8bb3@linaro.org>
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

On Sun, 27 Nov 2022 22:09:52 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 25/11/2022 23:09, Samuel Holland wrote:
> > Linux has a driver for these ADCs at drivers/iio/adc/ti-adc081c.c, but
> > the compatible strings were undocumented. Add a binding for them. The
> > hardware has an alert interrupt output, but existing ti,adc081c users
> > do not provide the 'interrupts' property, so leave it as optional.
> > 
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> >   
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, but now we are so close to merge window, I'm queuing things
for 6.3.  Obviously wouldn't really matter for this, but it is too
late for other things in my tree to get enough time in linux-next
etc.

Jonathan

> 
> Best regards,
> Krzysztof
> 

