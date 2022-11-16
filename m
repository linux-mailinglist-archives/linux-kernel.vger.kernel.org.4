Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C423F62B78E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiKPKR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiKPKR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:17:56 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC66D120B4;
        Wed, 16 Nov 2022 02:17:54 -0800 (PST)
Received: from frapeml100005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBzQK2zl8z6H6tk;
        Wed, 16 Nov 2022 18:13:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 11:17:52 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 10:17:52 +0000
Date:   Wed, 16 Nov 2022 10:17:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Cosmin Tanislav <demonsingur@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: addac: add AD74115
Message-ID: <20221116101751.000059ea@Huawei.com>
In-Reply-To: <CAL_JsqLt6B73XSE8dMHMGuw1N9m1v1xwr3sOEEHonGgLAYya=A@mail.gmail.com>
References: <20221103094436.2136698-1-demonsingur@gmail.com>
        <20221103094436.2136698-2-demonsingur@gmail.com>
        <20221106154634.2286faf3@jic23-huawei>
        <c01b0e56563b2b6f8ef48ad90977646706a2c933.camel@gmail.com>
        <20221112154040.54dc5cf2@jic23-huawei>
        <c54200fb70d638c572a0596a78d956d9f61d89a4.camel@gmail.com>
        <20221115160724.00007460@Huawei.com>
        <CAL_JsqLt6B73XSE8dMHMGuw1N9m1v1xwr3sOEEHonGgLAYya=A@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Tue, 15 Nov 2022 12:16:41 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Tue, Nov 15, 2022 at 10:07 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 15 Nov 2022 14:43:53 +0200
> > Cosmin Tanislav <demonsingur@gmail.com> wrote:
> >  
> > > On Sat, 2022-11-12 at 15:40 +0000, Jonathan Cameron wrote:  
> > > > > >  
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > +    description: |
> > > > > > > +      Conversion range for ADC conversion 2.
> > > > > > > +      0 - 0V to 12V
> > > > > > > +      1 - -12V to +12V
> > > > > > > +      2 - -2.5V to +2.5V
> > > > > > > +      3 - -2.5V to 0V
> > > > > > > +      4 - 0V to 2.5V
> > > > > > > +      5 - 0V to 0.625V
> > > > > > > +      6 - -104mV to +104mV
> > > > > > > +      7 - 0V to 12V  
> > > > > >
> > > > > > For a lot of similar cases we handle these numerically to give
> > > > > > a human readable dts.  Is there a strong reason not to do so here (in mv)
> > > > > >  
> > > > >
> > > > > I used this approach mostly because it maps dirrectly to register values
> > > > > and because it's easier to parse. dts isn't exactly nice at handling
> > > > > negative values. I can switch it to mv array if you insist.  
> > > >
> > > > We have quite a few existing cases of
> > > > adi,[output-]range-microvolt so it would be good to copy that style here.
> > > >  
> > >
> > > With this:
> > >
> > >   adi,conv2-range-microvolt:
> > >     description: Conversion range for ADC conversion 2.
> > >     oneOf:
> > >       - items:
> > >           - enum: [-2500000, 0]
> > >           - const: 2500000
> > >       - items:
> > >           - enum: [-12000000, 0]
> > >           - const: 12000000
> > >       - items:
> > >           - const: -2500000
> > >           - const: 0
> > >       - items:
> > >           - const: -104000
> > >           - const: 104000
> > >       - items:
> > >           - const: 0
> > >           - const: 625000
> > >
> > > And this:
> > >
> > > adi,conv2-range-microvolt = <(-12000000) 12000000>;
> > >
> > > I get this:
> > >
> > > Documentation/devicetree/bindings/iio/addac/adi,ad74115.example.dtb:
> > > addac@0: adi,conv2-range-microvolt: 'oneOf' conditional failed,
> > > one must be fixed:
> > >         4282967296 is not one of [-2500000, 0]
> > >         4282967296 is not one of [-12000000, 0]
> > >         -2500000 was expected
> > >         -104000 was expected
> > >         625000 was expected
> > >         From schema: Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> > >
> > > As I said, negative numbers don't play too nice...  
> >
> > From what I recall we just ignore those warnings :)
> >
> > Rob, do I remember correctly that there was a plan to make this work longer term?  
> 
> Yes, but handling signed types is working now (since the move to
> validating dtbs directly).
> 
> The issue here is -microvolt is defined as unsigned. IIRC, I had some
> issue changing it, but I think that was just with the YAML encoding
> which I intend to remove. I'll give it another look and update the
> type if there's no issues.

Thanks!

Jonathan

> 
> Rob

