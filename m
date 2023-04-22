Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886E46EB95A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 15:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjDVNX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 09:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDVNXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 09:23:55 -0400
X-Greylist: delayed 424 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Apr 2023 06:23:44 PDT
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 658BC1FED;
        Sat, 22 Apr 2023 06:23:44 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 34C5140A03; Sat, 22 Apr 2023 13:22:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 34C5140A03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1682162550;
        bh=Ii2LxPiMXmjmzfkCcsyLVLNBXvLfF8tTgwZi1LaNQRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8/8ylASz/AorxRyuNxlecsO+KRPJRHJ3EEE/4vOU8kDMAjP3eMg5CJxEF2XyM6o0
         WtuRdx9yYgBOJiKYU1ATHcsynFret0nscZad/nxWh3VqTdlJwsDX3MbhuKeqS+a9ZU
         LY0EpaHeMr+YbfXI4P1TYP5OSTVMwwZ2OJpfPFnY=
Date:   Sat, 22 Apr 2023 13:22:29 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: s3c2410_wdt: Use Use
 devm_clk_get[_optional]_enabled() helpers
Message-ID: <20230422112229.GA23896@www.linux-watchdog.org>
References: <20230304165653.2179835-1-linux@roeck-us.net>
 <20230306091048.mfrpexle24t6nwzy@pengutronix.de>
 <20230418065603.rzpiazzw4upitynt@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418065603.rzpiazzw4upitynt@pengutronix.de>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

> Hello,
> 
> On Mon, Mar 06, 2023 at 10:10:48AM +0100, Uwe Kleine-König wrote:
> > On Sat, Mar 04, 2023 at 08:56:52AM -0800, Guenter Roeck wrote:
> > > The devm_clk_get[_optional]_enabled() helpers:
> > >     - call devm_clk_get[_optional]()
> > >     - call clk_prepare_enable() and register what is needed in order to
> > >       call clk_disable_unprepare() when needed, as a managed resource.
> > > 
> > > This simplifies the code and avoids the calls to clk_disable_unprepare().
> > > 
> > > While at it, use dev_err_probe consistently, and use its return value
> > > to return the error code.
> > > 
> > > Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> This patch is in next now as b05a2e58c16c47f3d752b7db1714ef077e5b82d9.
> My name occurs twice in the tag area, once it is mangled as
> 
> 	Uwe Kleine-K=F6nig
> 
> I would welcome fixing that (i.e. s/=F6/ö/). When this commit is
> touched, you can also do s/Use Use/Use/ in the Subject.

Fixed.

Kind regards,
wim.

