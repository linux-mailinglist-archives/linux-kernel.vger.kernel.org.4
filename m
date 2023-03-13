Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97606B6D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 03:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCMCU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 22:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMCUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 22:20:24 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C946B3251A;
        Sun, 12 Mar 2023 19:20:21 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0A1E820002;
        Mon, 13 Mar 2023 02:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678674019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RUwXbYnksL+nMUTh6tFpMBtQrBc+4TuCw6h4lOTsxR4=;
        b=EXO09eSq5srtLUwf6XxAXIIjKBGlJDJ/M/ybbgLRcDnjNqR9MF5GUo4m9Oto+TFdCnjtzw
        WVDee2b3JQ0VFHAjGUn63PLcVBE1rnCfiF/+daqO75n31hnqtdbcxj2DRbWaHIEMQftZj1
        BIifpnESbz8PZM+xjXHBtV1Ko+edMo7dRjtPu2EBqTlNypoJ0tAmdm2hbb73GWRl0Wg5UM
        I3mA5KvUIOL0q+hltuMf9GMAK2brj2UMJp5BebAu5bJ6KyH+n0SDo1wvPJoLLZSvwGAcH+
        fTQDXzllSHGzbQzEwxQV8thygHMro2ONJsI/P9L7zqWU8gwiae1SxuK55XG0WQ==
Date:   Mon, 13 Mar 2023 03:20:17 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
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
Subject: Re: [PATCH v3 1/2] drivers: rtc: add max313xx series rtc driver
Message-ID: <20230313022017afe9a8fe@mail.local>
References: <20221108122254.1185-1-Ibrahim.Tilki@analog.com>
 <20221108122254.1185-2-Ibrahim.Tilki@analog.com>
 <68ddb833-f38e-a05b-82c4-ce12330410a5@alliedtelesis.co.nz>
 <CY4PR03MB2488B54E722831F0375430CA96A19@CY4PR03MB2488.namprd03.prod.outlook.com>
 <52382400-5abd-b473-6cf7-333e7deab2d4@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52382400-5abd-b473-6cf7-333e7deab2d4@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 13/03/2023 02:15:26+0000, Chris Packham wrote:
> Hi Ibrahim,
> 
> On 18/02/23 04:17, Tilki, Ibrahim wrote:
> >> Hi Ibrahim,
> >>
> >> On 9/11/22 01:22, Ibrahim Tilki wrote:
> >>> Adding support for Analog Devices MAX313XX series RTCs.
> >>>
> >>> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> >>> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> >>> ---
> >>>    drivers/rtc/Kconfig        |   11 +
> >>>    drivers/rtc/Makefile       |    1 +
> >>>    drivers/rtc/rtc-max313xx.c | 1070 ++++++++++++++++++++++++++++++++++++
> >>>    3 files changed, 1082 insertions(+)
> >>>    create mode 100644 drivers/rtc/rtc-max313xx.c
> >> What is the current state of this work? I see there are some comments on
> >> this v3 iteration from late last year and I couldn't find any newer
> >> iteration on any mailing list. We've got some new hardware arriving soon
> >> that will have the MAX31331 RTC and I'm keen to see this patch series
> >> land. Is there anything I can do to help it along? I can't be very
> >> specific about when I'll see the new hardware (who can these days), the
> >> last update was "boards are due in March".
> >>
> >> For the maintainers on the Cc list once the dust settles how would I get
> >> this supported in a LTS kernel (we're currently using the 5.15 series)?
> >> Or is totally out of the question because it's not just a new device id?
> > Hi Chris,
> >
> > Patch v4 is on the way, I will be sending it in a few weeks.
> > It is hard to tell when it is going to land but I expect to be more responsive
> > to reviews after patch v4.
> 
> FYI I've now got some boards with a MAX31331. I've given v3 a quick test 
> and it works for me.
> 
> Are you also looking at a u-boot driver? If not I can port your driver 
> across reasonably easily.
> 

I'm curious why would you need an RTC driver for u-boot?


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
