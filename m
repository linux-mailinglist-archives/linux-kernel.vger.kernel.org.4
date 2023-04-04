Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AF66D605D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjDDM3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjDDM31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:29:27 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38A610A;
        Tue,  4 Apr 2023 05:29:14 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EFBDA100003;
        Tue,  4 Apr 2023 12:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680611353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1s8oWqXZyH3J7vnCQRYvzoMuk5JY0jzBHnJpra4pFT4=;
        b=LEkYgQFJZRrGQY7HJb36jYtHL0Cs9mApMZhHebK3mUTfeinteLbMlDsHL3KSPbOlVgZoku
        EAe3a+QvGcBW1OSutA/vaI8wainzIOjfXEfdNBaFgDaOluu0PpQ7dtQzNWMq96pmCLyTye
        3DWfvAQXLIvvvtTauUovUmg5iNQ1k5eOgcWz6aGlSRe38adX2n3ZzRTqTIFsG+m4FqaNMv
        5oX7D8X+DELGEAknSKMXGaIx9c9yNGzWHHLhHLWv5Rx8t1Zp5ilrFQkacnLaJi6xfDgMw7
        UwVfaaAD9O56Sm2YSGKC7UKAT1is7oeV6jxFOLi49o+UBx5L3MQhHfbJFu/w6g==
Date:   Tue, 4 Apr 2023 14:29:11 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Message-ID: <2023040412291166c04438@mail.local>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
 <dd6f0842-519f-1bc9-f7f5-459863dc3dcd@linaro.org>
 <202304040710049c9cc01a@mail.local>
 <CY4PR03MB2488DFC99C23ADE16FF40E2F96939@CY4PR03MB2488.namprd03.prod.outlook.com>
 <1efdb870-cac2-f6ed-72b5-d0550dbb5257@linaro.org>
 <CY4PR03MB24883E0406C2A16E566DB39196939@CY4PR03MB2488.namprd03.prod.outlook.com>
 <202304041226162e231e78@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304041226162e231e78@mail.local>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 14:26:18+0200, Alexandre Belloni wrote:
> On 04/04/2023 10:35:53+0000, Tilki, Ibrahim wrote:
> > >>>>> +  aux-voltage-chargeable:
> > >>>>> +    enum: [0, 1, 2]
> > >>>>> +    description: |
> > >>>>> +      Enables trickle charger.
> > >>>>> +      0: Charger is disabled (default)
> > >>>>> +      1: Charger is enabled
> > >>>>> +      2: Charger is enabled with a diode
> > >>>>
> > >>>> 2 is not an allowed value. I asked to drop this property. It is coming
> > >>>> from rtc.yaml. I also do not understand "with a diode". So otherwise it
> > >>>> is charging with, I don't know, FET?
> > >>>
> > >>> No, what is not explained here (and maybe not unsterstood by the
> > >>> submitter) is that the RTC has an extra diode so, charging will always
> > >>> enable a diode, select a resistor and then have or not an extra diode.
> > >>> Figure2 of the MAX31329 datasheet is great.
> > >>>
> > >> 
> > >> That is exactly why I had "adi,trickle-diode-enable" property in previous patch.
> > >> So if I can't have "adi,trickle-diode-enable" and can't add an additional value
> > >> to "aux-voltage-chargeable", I am not sure how to add support for the extra
> > >> diode at this point.
> > >
> > > Ask the person who asked you to remove adi,trickle-diode-enable...
> > 
> > That was the purpose.
> > 
> 
> If the earlier submission was clearer my answer would have been
> different but note how I had to dig up the datasheet to understand there
> were two diodes. All the trickle chargers have a schottky diode so
> "adi,trickle-diode-enable" nor the commit log were explicit about the
> second diode (which is a regular diode).
> 
> aux-voltage-chargeable is enabling a diode on all the existing RTC
> drivers so instead of trying to make me look like the bad guy you should
> rather thank for taking the time trying to get better DT bindings.
> 

BTW, Krzysztof, you should focus more on how v5 of the driver is still
abusing the #clock-cells property to do pinmuxing after I repeatedly
explain to not do that.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
