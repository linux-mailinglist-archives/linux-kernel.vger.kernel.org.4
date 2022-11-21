Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0016322C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiKUMpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiKUMpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:45:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14204BF826;
        Mon, 21 Nov 2022 04:45:22 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NG6Rr5TYYz6H6q1;
        Mon, 21 Nov 2022 20:40:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 13:45:19 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 12:45:19 +0000
Date:   Mon, 21 Nov 2022 12:45:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Edmund Berenson <edmund.berenson@emlix.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: iio: adc: ad7923: adjust documentation
Message-ID: <20221121124518.00000da4@Huawei.com>
In-Reply-To: <20221121104532.dibxead6kiv3xqzw@emlix.com>
References: <20221120153419.GA3094349-robh@kernel.org>
        <20221120170630.29354-1-edmund.berenson@emlix.com>
        <d83e9a3d-2482-4342-03c1-818a38bd4b7b@linaro.org>
        <20221121102600.uwmgivssgy7oakxf@emlix.com>
        <3a50ba73-aab7-f6db-5e42-beb7e193c5bf@linaro.org>
        <20221121104532.dibxead6kiv3xqzw@emlix.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 11:45:32 +0100
Edmund Berenson <edmund.berenson@emlix.com> wrote:

> On Mon, Nov 21, 2022 at 11:31:33AM +0100, Krzysztof Kozlowski wrote:
> > On 21/11/2022 11:26, Edmund Berenson wrote:  
> > > On Mon, Nov 21, 2022 at 10:13:57AM +0100, Krzysztof Kozlowski wrote:  
> > >> On 20/11/2022 18:06, Edmund Berenson wrote:  
> > >>> - Add the ad7927 compatibility string, with fallback compatibility
> > >>> to ad7928.
> > >>> - ad7923 and ad7924 are treated the same in the driver, show
> > >>> the relationship in the documentation.
> > >>>
> > >>> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> > >>> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> > >>> ---
> > >>>  .../bindings/iio/adc/adi,ad7923.yaml          | 26 ++++++++++++-------  
> > >>
> > >> Do not respond with new patch to some old thread. Each patchset starts a
> > >> new thread.
> > >>  
> > > Sorry I didn't know this is the preferred way. I will send new patch
> > > version as new thread in the future.  
> > >>>  1 file changed, 17 insertions(+), 9 deletions(-)
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> > >>> index 07f9d1c09c7d..e553853e25d5 100644
> > >>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> > >>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> > >>> @@ -11,7 +11,7 @@ maintainers:
> > >>>  
> > >>>  description: |
> > >>>    Analog Devices AD7904, AD7914, AD7923, AD7924 4 Channel ADCs, and AD7908,
> > >>> -   AD7918, AD7928 8 Channels ADCs.
> > >>> +   AD7918, AD7927, AD7928 8 Channels ADCs.
> > >>>  
> > >>>    Specifications about the part can be found at:
> > >>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7923.pdf
> > >>> @@ -20,14 +20,22 @@ description: |
> > >>>  
> > >>>  properties:
> > >>>    compatible:
> > >>> -    enum:
> > >>> -      - adi,ad7904
> > >>> -      - adi,ad7914
> > >>> -      - adi,ad7923
> > >>> -      - adi,ad7924
> > >>> -      - adi,ad7908
> > >>> -      - adi,ad7918
> > >>> -      - adi,ad7928
> > >>> +    oneOf:
> > >>> +      - enum:
> > >>> +          - adi,ad7904
> > >>> +          - adi,ad7914
> > >>> +          - adi,ad7908  
> > >>
> > >> You already started shuffling the entries, so make them ordered. What's
> > >> the point of changing the order from one non-sorted to another non-sorted?
> > >>  
> > >>> +          - adi,ad7918
> > >>> +          - adi,ad7923
> > >>> +          - adi,ad7924  
> > >>
> > >> Then deprecate this as alone compatible.
> > >>  
> > >>> +          - adi,ad7927> +          - adi,ad7928  
> > >>
> > >> Ditto
> > >>  
> > >>> +      - items:
> > >>> +          - const: adi,ad7923
> > >>> +          - const: adi,ad7924  
> > >>
> > >> I would expect lower number as fallback.  
> > > If I remove alone compatibility of 7924 and 7927 in the documentation,  
> > 
> > I don't understand. 7924 and 7927 are not compatible with each other -
> > neither in old code nor in new - so what do you want to remove?
> >   
> > > I will have to remove explicit compatibility match on the driver side,
> > > correct?
> > > Just want to make sure I don't misunderstand you.  
> > 
> > My comment to which you responded was about order of items. Usually
> > lower number means older device and usually older device is the fallback.  

Oldest in which sense?  I think it should be oldest in order of having
a binding defined, not in order of part releases (and ADI seem to scramble
part numbers fairly randomly so definitely not generally the case that
ordering of numbers has anything much to do with age of part).




> My response was meant to respond to both your comment to "deprecate
> alone compatibility" and "lower number should be fallback"
> Which I understood in the following way: because 7923, 7924 for one and
> 7927, 7928 are compatible with each other I will remove
> 7924 compatible string from driver and not add 7927 to the driver and
> only add it to the documentation.
> > Best regards,
> > Krzysztof
> >   
> 
> Thank you and best regards,
> Edmund
> 

