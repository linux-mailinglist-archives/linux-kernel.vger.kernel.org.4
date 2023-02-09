Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB42690FEA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjBISHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjBISHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:07:09 -0500
Received: from out-50.mta0.migadu.com (out-50.mta0.migadu.com [IPv6:2001:41d0:1004:224b::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A78D60D64
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:07:07 -0800 (PST)
Date:   Thu, 9 Feb 2023 19:07:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1675966025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P7c9K+8/4m//eJSNTI6ncUiLZQ8YPwaOIUaA6JqGkjI=;
        b=jbkjTuH6grLhWH/L3ADa9qoHjkeqyHhy4SL033DUd8+oA45pex/yHeicPPNzlTCRCRhFow
        gFLxyE2MgrJ4YBNCuTjoyK4xUN0UHXWXaHlKSZ4JEKx37DnTxP9A9H32Ok4nO0+nXVOfk4
        aYK577n0vIW4znYLNurQSte/iludBn4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Henrik Grimler <henrik@grimler.se>
To:     David Virag <virag.david003@gmail.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        m.szyprowski@samsung.com, jenneron@protonmail.com,
        markuss.broks@gmail.com, martin.juecker@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Valentine Iourine <iourine@iourine.msk.su>
Subject: Re: [PATCH v2 2/2] ARM: dts: exynos: add mmc aliases
Message-ID: <Y+U2Rcc8Xo7JzRo2@L14.lan>
References: <20230128133151.29471-1-henrik@grimler.se>
 <20230128133151.29471-3-henrik@grimler.se>
 <CAL_Jsq+y2_aHXsxj4sx0KPATDi9-7mujruowpbq2kxro4e13zg@mail.gmail.com>
 <9e42dec3978c535d6bee6a8bd0c4137a23b70998.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e42dec3978c535d6bee6a8bd0c4137a23b70998.camel@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 09, 2023 at 04:22:48PM +0100, David Virag wrote:
> On Thu, 2023-02-09 at 09:06 -0600, Rob Herring wrote:
> > On Sat, Jan 28, 2023 at 7:32 AM Henrik Grimler <henrik@grimler.se>
> > wrote:
> > > 
> > > Add aliases for eMMC, SD card and WiFi where applicable, so that
> > > assigned mmcblk numbers are always the same.
> > 
> > What does WiFi have to do with mmcblk?
> 
> Some devices use SDIO WiFi, which is usually on mmc_1.
> An example of this that I could find is in exynos5250-spring.dts.

Maybe message can be written more clearly: WiFi will not have an
assigned _mmcblk_ number, but its number in for example
/sys/class/mmc_host/ will depend on the alias.

I will re-write for next version, thanks.

Best regards,
Henrik Grimler
