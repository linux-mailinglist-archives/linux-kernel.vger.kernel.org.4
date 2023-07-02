Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD3744D04
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 11:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGBJhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 05:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBJhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 05:37:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039AFE4D;
        Sun,  2 Jul 2023 02:36:59 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qv3lv0XcTz6D9CW;
        Sun,  2 Jul 2023 17:34:03 +0800 (CST)
Received: from localhost (10.48.51.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 2 Jul
 2023 10:36:52 +0100
Date:   Sun, 2 Jul 2023 17:36:48 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 1/2] dt-bindings: iio: ad74413r: add binding for digital
 input threshold
Message-ID: <20230702173648.00006a1d@Huawei.com>
In-Reply-To: <075c8d01-5788-a3c4-44e0-36cb9318fc6a@linaro.org>
References: <20230623113327.1062170-1-linux@rasmusvillemoes.dk>
        <20230623113327.1062170-2-linux@rasmusvillemoes.dk>
        <20230623-casket-outer-2c9d2a0c4795@spud>
        <20230623215731.GB1216324-robh@kernel.org>
        <8176d552-9829-5442-3ce9-805744b8389e@rasmusvillemoes.dk>
        <075c8d01-5788-a3c4-44e0-36cb9318fc6a@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.51.211]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 10:29:22 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 26/06/2023 10:15, Rasmus Villemoes wrote:
> > On 23/06/2023 23.57, Rob Herring wrote:  
> >> On Fri, Jun 23, 2023 at 05:44:50PM +0100, Conor Dooley wrote:  
> >>> On Fri, Jun 23, 2023 at 01:33:25PM +0200, Rasmus Villemoes wrote:  
> >>>> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> >>>> index 590ea7936ad7..1f90ce3c7932 100644
> >>>> --- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> >>>> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> >>>> @@ -51,6 +51,14 @@ properties:
> >>>>        Shunt (sense) resistor value in micro-Ohms.
> >>>>      default: 100000000
> >>>>  
> >>>> +  digital-input-threshold-microvolt:  
> >>>
> >>> Should this not have an adi vendor prefix, similar to
> >>> "adi,digital-input-threshold-mode-fixed"?  
> >>
> >> Yes.  
> > 
> > OK. But I'm not really sure what the rules are for when such a prefix
> > must be added, so some guidance would be appreciated. There's
> > 
> > - DO use a vendor prefix on device specific property names. Consider if
> >   properties could be common among devices of the same class.
> > 
> > And my thinking was that a threshold for when a digital input should
> > count as high/low would be a rather generic thing, so not particularly
> > device specific.  
> 
> Then find some more users of it.

The hi8435 could make use of this, but it currently doesn't get these thresholds
from DT (despite there being a reasonable argument that these should be characteristics
of the board wiring etc) but rather from userspace controls.

Might well be something in gpio drivers?  Linus / Bartosz, any of the input gpio
devices really threshold detectors?  If so is there any precedence for a DT
binding to set the threshold?

> 
> > 
> > Also, this very binding has a shunt-resistor-micro-ohms, and the
> > individual channels have a drive-strength-microamp (granted, that latter
> > one is a recent one of mine and may have slipped through review?). I can
> > certainly understand that when a property specifies a raw value to put
> > into some register (or field), that's very specific to that chip (or
> > small family of chips) - the adi,ch-func properties fall into that category.  
> 
> Best regards,
> Krzysztof
> 

