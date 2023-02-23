Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD96A0BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjBWOSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjBWOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:18:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4845940F;
        Thu, 23 Feb 2023 06:18:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82A2FB81A3C;
        Thu, 23 Feb 2023 14:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF94C433B0;
        Thu, 23 Feb 2023 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677161895;
        bh=Bv7Cxd7ZsIFicSLCsjlUNUcRpLgT2IlLYkN8Sp1WQrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XU09QVgded3xQtT6HXvRfFY14EaOFb/+1fvijGlRV3IU1AUTWFKEsl8qxEF99Cc+0
         ha4pXMN4iJB5lg+vLcS1JzMdRKfuHIU1F9SyLodfMjQDO8O3pfpbJOYgqMoiLaaCTH
         rnbJVgcjjBOMdaIXgs1p4qjUloTNpxGAfHVyiFLl8qKeMf9tBoSXRy6qf9J1CAVvsz
         mN1aqt9+gDdAwCNQK9qyoEgjhHA9A5yrKGu0tMVrlYBl3CC9DG0ZIpuS4qvnaA8zx9
         IOaVHPDK6RzBrKvExyQjTorntT+aCG1UfdyQ/J+zh7d/kyJoVTxDvUTP3Yum9adljB
         priCJCT6nVcJg==
Date:   Thu, 23 Feb 2023 14:18:10 +0000
From:   Lee Jones <lee@kernel.org>
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: s5m: Drop S5M8763 support
Message-ID: <Y/d1omGzBMFqjQx+@google.com>
References: <20230131183008.4451-1-virag.david003@gmail.com>
 <20230131183008.4451-3-virag.david003@gmail.com>
 <Y/d1DY/mXe7R5q8W@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/d1DY/mXe7R5q8W@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023, Lee Jones wrote:

> On Tue, 31 Jan 2023, David Virag wrote:
> 
> > The S5M8763 MFD has no device tree compatible, and since board file
> > support for it was removed, there's no way to use this MFD. After
> > removing the remaining code for it from the MFD driver, also remove
> > support for it in the s5m RTC driver, and all remaining references to
> > it.
> > 
> > Signed-off-by: David Virag <virag.david003@gmail.com>
> > ---
> >  drivers/rtc/rtc-s5m.c            | 82 ++------------------------------
> 
> >  include/linux/mfd/samsung/core.h |  1 -
> >  include/linux/mfd/samsung/irq.h  | 50 -------------------
> 
> Acked-by: Lee Jones <lee@kernel.org>

Actually, looks like this should probably go in via MFD, so I need an
RTC Ack.

> >  3 files changed, 3 insertions(+), 130 deletions(-)

-- 
Lee Jones [李琼斯]
