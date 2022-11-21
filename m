Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0733631E41
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiKUK0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKUK0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:26:06 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F10A65B7;
        Mon, 21 Nov 2022 02:26:02 -0800 (PST)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id C1B545FB8C;
        Mon, 21 Nov 2022 11:26:00 +0100 (CET)
Date:   Mon, 21 Nov 2022 11:26:00 +0100
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
Subject: Re: [PATCH v3] dt-bindings: iio: adc: ad7923: adjust documentation
Message-ID: <20221121102600.uwmgivssgy7oakxf@emlix.com>
References: <20221120153419.GA3094349-robh@kernel.org>
 <20221120170630.29354-1-edmund.berenson@emlix.com>
 <d83e9a3d-2482-4342-03c1-818a38bd4b7b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d83e9a3d-2482-4342-03c1-818a38bd4b7b@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:13:57AM +0100, Krzysztof Kozlowski wrote:
> On 20/11/2022 18:06, Edmund Berenson wrote:
> > - Add the ad7927 compatibility string, with fallback compatibility
> > to ad7928.
> > - ad7923 and ad7924 are treated the same in the driver, show
> > the relationship in the documentation.
> > 
> > Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> > Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> > ---
> >  .../bindings/iio/adc/adi,ad7923.yaml          | 26 ++++++++++++-------
> 
> Do not respond with new patch to some old thread. Each patchset starts a
> new thread.
> 
Sorry I didn't know this is the preferred way. I will send new patch
version as new thread in the future.
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> > index 07f9d1c09c7d..e553853e25d5 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> > @@ -11,7 +11,7 @@ maintainers:
> >  
> >  description: |
> >    Analog Devices AD7904, AD7914, AD7923, AD7924 4 Channel ADCs, and AD7908,
> > -   AD7918, AD7928 8 Channels ADCs.
> > +   AD7918, AD7927, AD7928 8 Channels ADCs.
> >  
> >    Specifications about the part can be found at:
> >      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7923.pdf
> > @@ -20,14 +20,22 @@ description: |
> >  
> >  properties:
> >    compatible:
> > -    enum:
> > -      - adi,ad7904
> > -      - adi,ad7914
> > -      - adi,ad7923
> > -      - adi,ad7924
> > -      - adi,ad7908
> > -      - adi,ad7918
> > -      - adi,ad7928
> > +    oneOf:
> > +      - enum:
> > +          - adi,ad7904
> > +          - adi,ad7914
> > +          - adi,ad7908
> 
> You already started shuffling the entries, so make them ordered. What's
> the point of changing the order from one non-sorted to another non-sorted?
> 
> > +          - adi,ad7918
> > +          - adi,ad7923
> > +          - adi,ad7924
> 
> Then deprecate this as alone compatible.
> 
> > +          - adi,ad7927> +          - adi,ad7928
> 
> Ditto
> 
> > +      - items:
> > +          - const: adi,ad7923
> > +          - const: adi,ad7924
> 
> I would expect lower number as fallback.
If I remove alone compatibility of 7924 and 7927 in the documentation,
I will have to remove explicit compatibility match on the driver side,
correct?
Just want to make sure I don't misunderstand you.
> 
> > +      - items:
> > +          - const: adi,ad7927
> > +          - const: adi,ad7928
> 
> Ditto.
> 
> >  
> >    reg:
> >      maxItems: 1
> 
> Best regards,
> Krzysztof
> 

Thank you and best regards,
Edmund
