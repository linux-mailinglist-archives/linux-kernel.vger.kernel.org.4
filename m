Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC5D617F95
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiKCObI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKCObE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:31:04 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6EFF5D;
        Thu,  3 Nov 2022 07:31:03 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id p127so2101156oih.9;
        Thu, 03 Nov 2022 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTr6gc/qL3/cvufhP664wBsVqSVnACz7cyfjWA6pJ/A=;
        b=inEVvhjX66DeMO1AjWgK9izci/93Si0haRH+O02Xndneum6cFm49kmaOrUGUUxKJqO
         lGq+ITuxZHEN8pV5mQBAofz07U0AStDDR0AztGlLRFALigFRhIhtGWKlbjyefVCZpPU0
         MlFVxEnlgqY8A2SoyoGcz1ToGr1SysyXMgHvr7f1quTkQokhds1LRRNaLZh2X3wofiPQ
         HRPDK+iHw8/H/037UV2x+YJ6ijcgTQgrzxA0NHL22dOnnj9MkI3lVOZ/FV3wPX1teER3
         mPtZNuEQzmGuhXoOeXzYARJFxID/jfhanw9oWrzFCJk9AjtxhFoIKisjmGZG7w5cP/mX
         8Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTr6gc/qL3/cvufhP664wBsVqSVnACz7cyfjWA6pJ/A=;
        b=lDmg2AZDrq0CxtRaogRpl1EonEoOBz5h+auusZTydGklAJCUMXjyRwX2uMOfZmk/tH
         bZ+2nTR18bLcg2NxH+bdOV30wPiBwKcT/Yxaab+bYcX2DlvOouwVuk3EAFEbRb9cFkmR
         mtMN6VFGCC/HAcf3XR59xzYpWmcUoK6IcyxPeDkvvCz54EBSh96tGwBYxHbLmFX2RPi0
         /gmw/CQYuRWt6qqG/dzDyHF3f4KxIauLPbrQKBSynfCNPSPlVRFG78cIjNRshffn+2zM
         4o3rO3M5FSk6nskUBpcZP4kQx2SjWE0a1M8jNoWO0uGEu19KZk2IuMyvrL9NV5wCTbp8
         VpUA==
X-Gm-Message-State: ACrzQf1uhBvIP50GVbrIob1reG2r0s8xYqSGSuXup51qYczXFSa86rya
        H/P7ZsoLGfAXGbe0mDOrZhw=
X-Google-Smtp-Source: AMsMyM6kiE1p+72Nbb5v+BVoVNZhakWQwxVmLMnU2jpvd+wAruwzA58msN/e0z+ahu5+6GQaCdfr+A==
X-Received: by 2002:a05:6808:19a6:b0:355:3ac8:8386 with SMTP id bj38-20020a05680819a600b003553ac88386mr23002209oib.229.1667485863264;
        Thu, 03 Nov 2022 07:31:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w9-20020a9d6749000000b00660e833baddsm387598otm.29.2022.11.03.07.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:31:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 3 Nov 2022 07:30:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "garnermic@meta.com" <garnermic@meta.com>
Subject: Re: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
Message-ID: <20221103143059.GB145042@roeck-us.net>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-4-billy_tsai@aspeedtech.com>
 <20221101131456.GA1310110@roeck-us.net>
 <271C521D-8F20-4C86-B3DA-9C0AD74242D4@aspeedtech.com>
 <20221102170138.GA2913353@roeck-us.net>
 <F1166366-99CC-4A36-A0A2-4965C787E60B@aspeedtech.com>
 <20221103043034.GA2113834@roeck-us.net>
 <E9E92BC7-CB1A-487F-9E5D-2A403A01CB17@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E9E92BC7-CB1A-487F-9E5D-2A403A01CB17@aspeedtech.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 05:40:44AM +0000, Billy Tsai wrote:
> On 2022/11/3, 12:30 PM, "Guenter Roeck" <groeck7@gmail.com on behalf of linux@roeck-us.net> wrote:
> 
>     On Thu, Nov 03, 2022 at 03:52:59AM +0000, Billy Tsai wrote:
>     > > 
>     > > Can't I use a min/max RPM to let the driver know a reasonable timeout/polling period when
>     > > the driver is trying to get RPM?
>     > > Beacause that our tach controller have the falg to indicates the hardware detected the change
>     > > in the input signal. I need the proper timout to rule out slow RPMs.
> 
>     > If the chip measures the fan speed continuously, why would that ever be a
>     > problem, and why wait in the first place instead of just taking the most
>     > recent result ?
> 
>     > Pretty much every other driver is doing that, so I really don't understand
>     > why that would not work here.
> 
> When the fan speed drop from a very fast RPM to a very slow RPM. Especially when it is close to stopping.
> The most recent result will be no meaningful value. The slower RPM needs more time to sample it. E.g., If
> we want to measure the fan with 600 RPM, the controller needs at least 100ms. During this time period, we
> will always get the wrong value. So, our tach controller have the flag to avoid this problem:
> TACH_ASPEED_VALUE_UPDATE: tach value updated since last read
> This flag will be set when the controller detected the change of the signal and clear by read it.
> In order to use this flag, the controller needs the proper timeout based on minimum RPM to avoid waiting forever.
> 

I am not going to accept this patch as-is. If userspace wants to have
values accurate down to ms, this kind of approach is just wrong. Users
will have to live with the fact that measurements may be a bit (in the 
< 1 second range) out of date. Many older drivers even implement code
which avoids reading registers again for a second or longer. Older
temperature sensors may take several seconds to provide new readings.
That is not a reason to block userspace until a new value is available.
I do not see that as a problem. In my opinion it is much more of a
problem if the driver returns a completely bad value such as 0 or even
an error code because its software parameters did not match reality and
the driver didn't wait long enough for a new value. That would be _much_
worse than providing a value which is a few 100 ms out of date, and your
code is vulnerable to that problem.

Besides, for a fan to reduce its speed that quickly, it has to be manually
stopped. Normally fans take several seconds to stop if power is taken away
completely. Your code is adding a lot of complexity (and unnecessary
attributes) for no good reason.

Guenter
