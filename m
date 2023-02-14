Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E814E696FED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjBNVkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjBNVkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:40:07 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B7828D31;
        Tue, 14 Feb 2023 13:40:05 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DD9E960003;
        Tue, 14 Feb 2023 21:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676410804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UQzQSgnN9o1LOREIuibj1ZFyAx16UG7jYybKa3UpZ6Y=;
        b=K6EdBLbg5UiHwV5SrxM16Ghhup6DyBZVdCMFUAfTPQb7dLjZypNRU0eL/dAwjL8aMzzk8H
        XPQnEcJ6iPH0bIMyqGQBknC4J5+i6yHrz3HBHDH6n5A/mwQxRtU8pCSyt3I9jad5JlfFeK
        2a9ZN7xBvYhlRW/xIikeMrt2gci4quq1IhFnQ09MpoDyEB0LEz10qkxF1yQOpyK4Y1bSL0
        Pe/V0uMrrXEqO839CQak/T9bsuhCIRaD/posrw2jacdDLTgq05aCWdyp86EU3L42PUquOS
        mh5Z+TChWJE7M1xrKaUBma6bEoNLrItaEyz2/b4i9EDB2hGwYUULhgBMs3JaYg==
Date:   Tue, 14 Feb 2023 22:40:02 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
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
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v3 1/2] drivers: rtc: add max313xx series rtc driver
Message-ID: <Y+v/suob0EN1REX4@mail.local>
References: <20221108122254.1185-1-Ibrahim.Tilki@analog.com>
 <20221108122254.1185-2-Ibrahim.Tilki@analog.com>
 <68ddb833-f38e-a05b-82c4-ce12330410a5@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ddb833-f38e-a05b-82c4-ce12330410a5@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 20:28:05+0000, Chris Packham wrote:
> Hi Ibrahim,
> 
> On 9/11/22 01:22, Ibrahim Tilki wrote:
> > Adding support for Analog Devices MAX313XX series RTCs.
> >
> > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> > ---
> >   drivers/rtc/Kconfig        |   11 +
> >   drivers/rtc/Makefile       |    1 +
> >   drivers/rtc/rtc-max313xx.c | 1070 ++++++++++++++++++++++++++++++++++++
> >   3 files changed, 1082 insertions(+)
> >   create mode 100644 drivers/rtc/rtc-max313xx.c
> 
> What is the current state of this work? I see there are some comments on 
> this v3 iteration from late last year and I couldn't find any newer 
> iteration on any mailing list. We've got some new hardware arriving soon 
> that will have the MAX31331 RTC and I'm keen to see this patch series 
> land. Is there anything I can do to help it along? I can't be very 
> specific about when I'll see the new hardware (who can these days), the 
> last update was "boards are due in March".
> 
> For the maintainers on the Cc list once the dust settles how would I get 
> this supported in a LTS kernel (we're currently using the 5.15 series)? 
> Or is totally out of the question because it's not just a new device id?

This will not happen, you will have to update to the next LTS (which you
should do anyway)


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
