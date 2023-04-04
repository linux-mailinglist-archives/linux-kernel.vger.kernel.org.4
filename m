Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A1C6D6020
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjDDMUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjDDMTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:19:37 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01194212;
        Tue,  4 Apr 2023 05:18:26 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6E70AE000C;
        Tue,  4 Apr 2023 12:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680610705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=idxg46PJrgEwv3et0Ba7k6n0WCU6ehn7TgJBbU48I/s=;
        b=E94tMJxzKGiYVp8ri2bSvuc+X1IGk/jXm/x0achkW9xvBhbgNi83PENO9Zt1gs7TTJiOn1
        zXnvjLzdPpWTyeh1FuTyvxZ2e2jjOCDr1GIuHVaq03G0sZJaMPHViqAIv1l9op40KHDU/0
        J+RWaoAwlzxWF6LDrzVDnY302Lvn3gPOskmmxRCdy+1AxP7ZHAAdpP8IyVyHb932gaHZJJ
        p5FTqlyW8aGQvvZrcCur/R6hT/17bIsANIROwAXjHd47GdnOzi7EzQRvks2tEBMmJjncq9
        veT3tg/V2tvQyStIT4v1M/0z71FK6/r0GyTADIHQs6BnYpTlzvT779KxZu1Xhg==
Date:   Tue, 4 Apr 2023 14:18:24 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, a.zummo@towertech.it,
        jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Message-ID: <2023040412182450fc4fd1@mail.local>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
 <dd6f0842-519f-1bc9-f7f5-459863dc3dcd@linaro.org>
 <202304040710049c9cc01a@mail.local>
 <996b49ab-5e2e-76bc-efb1-38c6384871f6@linaro.org>
 <2023040407444619bf5596@mail.local>
 <0fd972bd-c5e7-65cc-6992-09c4c3e88f95@linaro.org>
 <202304040956056c59af98@mail.local>
 <847cc6c8-e097-aa3a-2cd7-a6929bec18e9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847cc6c8-e097-aa3a-2cd7-a6929bec18e9@linaro.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 12:06:14+0200, Krzysztof Kozlowski wrote:
> On 04/04/2023 11:56, Alexandre Belloni wrote:
> > On 04/04/2023 10:14:33+0200, Krzysztof Kozlowski wrote:
> >> On 04/04/2023 09:44, Alexandre Belloni wrote:
> >>>>
> >>>>> charging will always
> >>>>> enable a diode, select a resistor and then have or not an extra diode.
> >>>>> Figure2 of the MAX31329 datasheet is great.
> >>>>
> >>>> So the diode is in the max313xx? Then why enabling it is a property of
> >>>> DT? Either this should be inferred from compatible or is even a policy,
> >>>> not a DT property. Just because device has a register for something, is
> >>>> not an argument that "something" should be in DT.
> >>>
> >>> Well, it depends on the battery that is installed on the board so it
> >>> makes sense to have it in DT.
> >>
> >> OK, that would be a good reason, but I wonder why? Why choosing diode or
> >> not depends on the battery? Wouldn't you always want to have the diode?
> >>
> > 
> > It limits the maximum current used to charge the battery or supercap to
> > not exceed what is allowed.
> 
> and I still wonder why someone would like to allow exceeding what is
> allowed. IOW, what is the use case to disable the diode?
> 

The battery or supercap is the part defining the current limit. why
would you want to limit the current if you can charge faster?


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
