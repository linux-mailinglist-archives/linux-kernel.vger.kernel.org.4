Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EC06A0C74
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjBWPDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjBWPDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:03:34 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339B318A9A;
        Thu, 23 Feb 2023 07:03:28 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A8567E0011;
        Thu, 23 Feb 2023 15:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677164607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iLYq/uFh1WwRyFSP8xuCQe3qJOCZMyMiNoGaOmifBgg=;
        b=AdZ2h3OCVx6ATvEgQydwDu1A6kPELbLKeaENuJAz3Nb5utXw0CSrrdYEizM6x7GkXRF8bU
        AYiwiDBNYzT1DJLHLJSJSPHemaCcjLaqeV2RcaUqroYXNxAKZe+VcEGRYEwWbYR9MNIbBe
        bx37Mn3aLPzAg0ID27m8PpQadPK4ORSnkTvmnlv/hL9EQHOAScK9f/4XuhFh6mRdnUYvc/
        0XzUJ72sgduUpcNwiRaZGl6E10YeENSsi/uv10GEHtg/JNTrKv59SS57/6j/gySVGJszLw
        wGM9jUY7Qzt79aThEXT8nbNGCdT96IVl6Q+sqOUUc+Ss5ZWydvKx/mfMXd6xNQ==
Date:   Thu, 23 Feb 2023 16:03:25 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lee Jones <lee@kernel.org>
Cc:     David Virag <virag.david003@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: s5m: Drop S5M8763 support
Message-ID: <Y/eAPXwdv0kclEVA@mail.local>
References: <20230131183008.4451-1-virag.david003@gmail.com>
 <20230131183008.4451-3-virag.david003@gmail.com>
 <Y/d1DY/mXe7R5q8W@google.com>
 <Y/d1omGzBMFqjQx+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/d1omGzBMFqjQx+@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 14:18:10+0000, Lee Jones wrote:
> On Thu, 23 Feb 2023, Lee Jones wrote:
> 
> > On Tue, 31 Jan 2023, David Virag wrote:
> > 
> > > The S5M8763 MFD has no device tree compatible, and since board file
> > > support for it was removed, there's no way to use this MFD. After
> > > removing the remaining code for it from the MFD driver, also remove
> > > support for it in the s5m RTC driver, and all remaining references to
> > > it.
> > > 
> > > Signed-off-by: David Virag <virag.david003@gmail.com>
> > > ---
> > >  drivers/rtc/rtc-s5m.c            | 82 ++------------------------------
> > 
> > >  include/linux/mfd/samsung/core.h |  1 -
> > >  include/linux/mfd/samsung/irq.h  | 50 -------------------
> > 
> > Acked-by: Lee Jones <lee@kernel.org>
> 
> Actually, looks like this should probably go in via MFD, so I need an
> RTC Ack.

There were comments on 1/2 so I was expecting a v2.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
