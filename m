Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F1766C3C6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjAPPY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjAPPXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:23:46 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E183233DC;
        Mon, 16 Jan 2023 07:21:39 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NwbMg14v1z6HJMX;
        Mon, 16 Jan 2023 23:21:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 15:21:36 +0000
Date:   Mon, 16 Jan 2023 15:21:35 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        <hvilleneuve@dimonoff.com>, <lars@metafoo.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: adc: add Texas Instruments
 ADS7924
Message-ID: <20230116152135.0000175c@Huawei.com>
In-Reply-To: <20230115151139.4056356363b5fcff6c42f3ea@hugovil.com>
References: <20230113194959.3276433-1-hugo@hugovil.com>
        <20230113194959.3276433-3-hugo@hugovil.com>
        <dee8fbdc-5399-d5ce-8d01-2c48e85e2919@linaro.org>
        <20230115112205.e46ab8d017b99dd987d003e4@hugovil.com>
        <20230115164326.7f03f6d9@jic23-huawei>
        <20230115113250.d8a0ec5a2638e24c1208539c@hugovil.com>
        <e30a869a-5585-901b-6a56-3e327e0cf60a@linaro.org>
        <20230115151139.4056356363b5fcff6c42f3ea@hugovil.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Sun, 15 Jan 2023 15:11:39 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> On Sun, 15 Jan 2023 20:17:24 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 15/01/2023 17:32, Hugo Villeneuve wrote:  
> > >>>>> +    required:
> > >>>>> +      - reg
> > >>>>> +
> > >>>>> +    additionalProperties: false    
> > >>>>
> > >>>> You are not allowing anything else from adc.yaml. Is it on purpose?    
> > >>>
> > >>> I am really not an expert with this Yaml stuff, and reading the documentation makes me probably more confused than before reading it :)
> > >>>
> > >>> But one thing that is for sure is that these other properties in adc.yaml are not used in my driver:
> > >>>
> > >>>   bipolar
> > >>>   diff-channels
> > >>>   settling-time-us
> > >>>   oversampling-ratio
> > >>>
> > >>> So is it Ok then to use "additionalProperties: false"? I think so, but what is your recommandation?  
> > >>
> > >> Makes sense to me.  Whilst there are lots of things a channel can support, most
> > >> of them are hardware related and not universal.  
> > > 
> > > Ok, I think I am finally beginning to see the light here :)
> > > 
> > > So I will then leave "additionalProperties: false".
> > > 
> > > I will send a V4 soon with all the latest changes.
> > >   
> > 
> > Just to clarify - we talk about hardware, not your Linux driver. What
> > your driver uses or doesn't, should not matter here that much.  

Indeed. The hardware does not support bipolar inputs, differential channels
or oversampling ratios as all of those require specific silicon that
is not in this particular device.

Technically you could emulate oversampling but there is no reason to do
that in kernel and no drivers do so + then it would not be a feature of
the hardware anyway so wouldn't belong in DT.

> 
> Hi,
> the following properties are definitely not supported by the hardware:
>     bipolar
>     diff-channels
>     oversampling-ratio
> 
> does this means that we should add these lines?
>     bipolar: false
>     diff-channels: false
>     oversampling-ratio: false
> 
> as for settling-time-us, I am not sure of its usage and if its related to this hardware.

That's used for devices that will delay their ADC sampling if there is a mux that is changing
which pin is being internally connected to a single shared ADC.  It requires hardware
support, which isn't present in this device.

Jonathan


> 
> Hugo.
> 
> 
> > Best regards,
> > Krzysztof
> > 
> >   
> 
> 

