Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A57635BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiKWLci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbiKWLcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:32:33 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD12245;
        Wed, 23 Nov 2022 03:32:25 -0800 (PST)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 2E39D5F88F;
        Wed, 23 Nov 2022 12:32:24 +0100 (CET)
Date:   Wed, 23 Nov 2022 12:32:24 +0100
From:   Edmund Berenson <edmund.berenson@emlix.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: iio: adc: ad7923: adjust documentation
Message-ID: <20221123113224.5vxs2zmxf7z2bmvm@emlix.com>
References: <20221122161437.18937-1-edmund.berenson@emlix.com>
 <c96d84e9-44d0-a389-429d-91d8a7d747b5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c96d84e9-44d0-a389-429d-91d8a7d747b5@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:42:40AM +0100, Krzysztof Kozlowski wrote:
> On 22/11/2022 17:14, Edmund Berenson wrote:
> > - The ad7927 is fully compatible with ad7928 driver, add
> > documentation for device.
> > - ad7923 and ad7924 are treated the same in the driver, show
> > the relationship in the documentation.
> > 
> > Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> > Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> > ---
> >  .../bindings/iio/adc/adi,ad7923.yaml          | 26 ++++++++++++-------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> >
> 
> 1. This is a v5, what are the changes?
> 
The original idea was adding the compatible string into driver itself,
then it was suggested that I have a fallback compatible to 7928 as the
hardware versions are treated the same in the driver. After that it was
suggested to add deprecated flag to standalone compatibility, but doing
so I didn't want to add compatibility on driver side just to mark it
deprecated in the documentation, so I dropped driver side changes.
Finally I had some issues getting the documentation syntax into an
acceptable form, mainly const vs enum listing of compatibility stings.

> 2.
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions. However, there's no need to repost patches *only* to add the
> tags. The upstream maintainer will do that for acks received on the
> version they apply.
> 
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
> 
> If a tag was not added on purpose, please state why and what changed.
I did assume adding the tags was done by maintainer, I didn't knew I was
supposed to add it myself when resubmitting the patch. My apologies, I
will add the tags if I run in this situation in the future.
> 
> 
> 
> > ---
> >  .../bindings/iio/adc/adi,ad7923.yaml          | 26 ++++++++++++-------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> > 
> 
> 
> Best regards,
> Krzysztof
> 
