Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA48631EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKUKpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKUKpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:45:36 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5862E7AF5B;
        Mon, 21 Nov 2022 02:45:34 -0800 (PST)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id C94BA5FB8C;
        Mon, 21 Nov 2022 11:45:32 +0100 (CET)
Date:   Mon, 21 Nov 2022 11:45:32 +0100
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
Message-ID: <20221121104532.dibxead6kiv3xqzw@emlix.com>
References: <20221120153419.GA3094349-robh@kernel.org>
 <20221120170630.29354-1-edmund.berenson@emlix.com>
 <d83e9a3d-2482-4342-03c1-818a38bd4b7b@linaro.org>
 <20221121102600.uwmgivssgy7oakxf@emlix.com>
 <3a50ba73-aab7-f6db-5e42-beb7e193c5bf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a50ba73-aab7-f6db-5e42-beb7e193c5bf@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:31:33AM +0100, Krzysztof Kozlowski wrote:
> On 21/11/2022 11:26, Edmund Berenson wrote:
> > On Mon, Nov 21, 2022 at 10:13:57AM +0100, Krzysztof Kozlowski wrote:
> >> On 20/11/2022 18:06, Edmund Berenson wrote:
> >>> - Add the ad7927 compatibility string, with fallback compatibility
> >>> to ad7928.
> >>> - ad7923 and ad7924 are treated the same in the driver, show
> >>> the relationship in the documentation.
> >>>
> >>> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> >>> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> >>> ---
> >>>  .../bindings/iio/adc/adi,ad7923.yaml          | 26 ++++++++++++-------
> >>
> >> Do not respond with new patch to some old thread. Each patchset starts a
> >> new thread.
> >>
> > Sorry I didn't know this is the preferred way. I will send new patch
> > version as new thread in the future.
> >>>  1 file changed, 17 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> >>> index 07f9d1c09c7d..e553853e25d5 100644
> >>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> >>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> >>> @@ -11,7 +11,7 @@ maintainers:
> >>>  
> >>>  description: |
> >>>    Analog Devices AD7904, AD7914, AD7923, AD7924 4 Channel ADCs, and AD7908,
> >>> -   AD7918, AD7928 8 Channels ADCs.
> >>> +   AD7918, AD7927, AD7928 8 Channels ADCs.
> >>>  
> >>>    Specifications about the part can be found at:
> >>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7923.pdf
> >>> @@ -20,14 +20,22 @@ description: |
> >>>  
> >>>  properties:
> >>>    compatible:
> >>> -    enum:
> >>> -      - adi,ad7904
> >>> -      - adi,ad7914
> >>> -      - adi,ad7923
> >>> -      - adi,ad7924
> >>> -      - adi,ad7908
> >>> -      - adi,ad7918
> >>> -      - adi,ad7928
> >>> +    oneOf:
> >>> +      - enum:
> >>> +          - adi,ad7904
> >>> +          - adi,ad7914
> >>> +          - adi,ad7908
> >>
> >> You already started shuffling the entries, so make them ordered. What's
> >> the point of changing the order from one non-sorted to another non-sorted?
> >>
> >>> +          - adi,ad7918
> >>> +          - adi,ad7923
> >>> +          - adi,ad7924
> >>
> >> Then deprecate this as alone compatible.
> >>
> >>> +          - adi,ad7927> +          - adi,ad7928
> >>
> >> Ditto
> >>
> >>> +      - items:
> >>> +          - const: adi,ad7923
> >>> +          - const: adi,ad7924
> >>
> >> I would expect lower number as fallback.
> > If I remove alone compatibility of 7924 and 7927 in the documentation,
> 
> I don't understand. 7924 and 7927 are not compatible with each other -
> neither in old code nor in new - so what do you want to remove?
> 
> > I will have to remove explicit compatibility match on the driver side,
> > correct?
> > Just want to make sure I don't misunderstand you.
> 
> My comment to which you responded was about order of items. Usually
> lower number means older device and usually older device is the fallback.
My response was meant to respond to both your comment to "deprecate
alone compatibility" and "lower number should be fallback"
Which I understood in the following way: because 7923, 7924 for one and
7927, 7928 are compatible with each other I will remove
7924 compatible string from driver and not add 7927 to the driver and
only add it to the documentation.
> Best regards,
> Krzysztof
> 

Thank you and best regards,
Edmund
