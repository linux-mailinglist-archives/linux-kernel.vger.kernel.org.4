Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8245B636AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbiKWUOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbiKWUO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:14:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF4B32B96;
        Wed, 23 Nov 2022 12:14:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E969FB8246D;
        Wed, 23 Nov 2022 20:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2512C433C1;
        Wed, 23 Nov 2022 20:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669234465;
        bh=LaRDL2OmP0vXU9Ym+ZEb1uU+N810RPxDyOiEfxHdpPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WeIhEk02Oil2/M94b2szlpyxepvEMUiZ81uZuUGLr4PdtUFm8vd2AfQp15PHO/cKt
         e7bWJwlQXbNRUZKfFE4wnN/qL5XgHduUU7CFpW5ryaIJx900RymyjgNLggBpRn34//
         MqmbN0SKCvIW6+GLAk93zXO9iVpFyX0exvgDrq4u/Qbyiek+DzOFyds97LNyF+gOoC
         ox3WojsXGN1r3gkCmsWNHEcOtvFnXq1wYIC0Ut5QsW7ybfHHJ7SPgQZcOGUf9VzzT5
         paj5w5Ffy49dhuLY084X1utr3LTH2Df9ez6L83ZJ72oyXo+6i5q6AhlsofrRh/+Cj8
         SPEsh6fvg7mGQ==
Date:   Wed, 23 Nov 2022 20:26:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Edmund Berenson <edmund.berenson@emlix.com>,
        Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: iio: adc: ad7923: adjust documentation
Message-ID: <20221123202657.7dd8f5b3@jic23-huawei>
In-Reply-To: <4d62d7e9-5454-4d1c-b3bb-4ba1fd7a31d6@linaro.org>
References: <20221122161437.18937-1-edmund.berenson@emlix.com>
        <c96d84e9-44d0-a389-429d-91d8a7d747b5@linaro.org>
        <20221123113224.5vxs2zmxf7z2bmvm@emlix.com>
        <4d62d7e9-5454-4d1c-b3bb-4ba1fd7a31d6@linaro.org>
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

On Wed, 23 Nov 2022 14:01:30 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 23/11/2022 12:32, Edmund Berenson wrote:
> > On Wed, Nov 23, 2022 at 11:42:40AM +0100, Krzysztof Kozlowski wrote:  
> >> On 22/11/2022 17:14, Edmund Berenson wrote:  
> >>> - The ad7927 is fully compatible with ad7928 driver, add
> >>> documentation for device.
> >>> - ad7923 and ad7924 are treated the same in the driver, show
> >>> the relationship in the documentation.
> >>>
> >>> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> >>> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> >>> ---
> >>>  .../bindings/iio/adc/adi,ad7923.yaml          | 26 ++++++++++++-------
> >>>  1 file changed, 17 insertions(+), 9 deletions(-)
> >>>  
> >>
> >> 1. This is a v5, what are the changes?
> >>  
> > The original idea was adding the compatible string into driver itself,
> > then it was suggested that I have a fallback compatible to 7928 as the
> > hardware versions are treated the same in the driver. After that it was
> > suggested to add deprecated flag to standalone compatibility, but doing
> > so I didn't want to add compatibility on driver side just to mark it
> > deprecated in the documentation, so I dropped driver side changes.
> > Finally I had some issues getting the documentation syntax into an
> > acceptable form, mainly const vs enum listing of compatibility stings.  
> 
> That's a bit too long for a changelog. Keep it short but still
> descriptive. Anyway - this must be in the changelog place, so after ---
> 
> 
> Best regards,
> Krzysztof
> 

Given it won't get picked up by git anyway and all the info is in this thread
(plus we are right at end of the cycle and I want to pick this up).

Applied with Krzysztof's tag from v4.

Thanks,

Jonathan
