Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F0F6F5783
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjECMBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjECMBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:01:18 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF0E5275;
        Wed,  3 May 2023 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683115277;
  x=1714651277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ix7N5q3ZVqpzch8HgBmAf+2RPj4ErJP5ku/rS3Udqzo=;
  b=QqDjY6KvkSk1XMuKbnwQhp+uqFFWayRAnDO1RcdBff3rGtt+cwCAwe4r
   nEb150tN4CS9Ak+XwIY3pvj/KcbdQaoS7mw5i9EHG8oOnjbnbZgyANWVr
   w4mc56DUSUNlCw172TDeKZ2O4sl9nVgufSkVd18PBUPkBtwi1Jm52We27
   yZsXXaQN2jzVsHDvjud0g5jZbmPHffsU8s9YhhdJep614K35iB/uopD4Z
   oW2xxcR/v/GdC6nIDM74czDwFNTMCJ0pEyHDYLwNGdh/ATlfNdY5ORMM5
   BrsYNwnO7/IttKPR6ZDl54TjsxYeTTsJJgYz8JhcdbPjr2xh5NzjWsOzV
   A==;
Date:   Wed, 3 May 2023 14:01:12 +0200
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-aspeed@lists.ozlabs.org>,
        <linux-realtek-soc@lists.infradead.org>,
        <linux-arm-kernel@axis.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <chrome-platform@lists.linux.dev>,
        <linux-samsung-soc@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        <linux-sunxi@lists.linux.dev>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-actions@lists.infradead.org>,
        <linux-unisoc@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        <kernel@dh-electronics.com>, "Olof Johansson" <olof@lixom.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Message-ID: <20230503120112.GC19396@axis.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 02:40:19PM -0500, Rob Herring wrote:
> On Tue, May 2, 2023 at 3:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
> I've dusted off my script and made a branch[1] with the result.
> There's just a couple of fixes needed after the script is run (see the
> top commit). The cross arch includes are all fixed up by the script.
> dtbs_install maintains a flat install. I compared the number of .dtbs
> before and after to check the script.
> 
> I think the only issue remaining is finalizing the mapping of
> platforms to subdirs. What I have currently is a mixture of SoC
> families and vendors. The most notable are all the Freescale/NXP
> platforms, pxa, socfpga, and stm32. It's not consistent with arm64
> either. Once that's finalized, I still need to go update MAINTAINERS.
> 
> Here's the current mapping:
> 
> vendor_map = {
> [...]
>     'artpec' : 'axis',

Looks good for our platforms also, thanks!

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
