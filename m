Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CFB5B9973
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIOLSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIOLSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:18:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2112760C6;
        Thu, 15 Sep 2022 04:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663240711; x=1694776711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nXQXpz1fBQ6NMUr8fUF06om1l4CftgGyuzoaQmQCFYw=;
  b=tnA1Z+7Ink/H2hPxN+qUVFWIZhUSMEOfGYuFkIAm6jXKg4JV+ue6yVSS
   eAeu4OYu2N8gxJulLPJdI6Ffb0k3H2dWcWBGJ5J6VTkZCFpmr3/D8Yq5Z
   HBlmVE5EZ8FiP14lMVoDIKwtpavhNm2IS4L0AJwoUXk/o7f73HKgkJJB0
   Py0yMXeY8SyhpkLAxoG1p14qbWteYsF6yZOyinrgw9PxTH8kEqfboGKyH
   TzFHoGM9eFHyrAUvPkYVGSQk0+PvdbYNjygNVCRPVoSH3WdvZQ4vSjRQ4
   mH3PcGJ66EzjFJdCNrKS/dt9uoWd2fr1eFWlzL3XPxo3SwMdb6zNnr2kd
   A==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="174003028"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 04:18:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 04:18:24 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 15 Sep 2022 04:18:23 -0700
Date:   Thu, 15 Sep 2022 13:22:47 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andy.shevchenko@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v3] pinctrl: ocelot: Fix interrupt controller
Message-ID: <20220915112247.fin7bb45plnr7cme@soft-dev3-1.localhost>
References: <20220909145942.844102-1-horatiu.vultur@microchip.com>
 <CACRpkdYWP4ASoO4wWSEgdCPbNLsx8fuHn_-oqnD+ff1TU84ieQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CACRpkdYWP4ASoO4wWSEgdCPbNLsx8fuHn_-oqnD+ff1TU84ieQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 09/14/2022 15:02, Linus Walleij wrote:
> 
> On Fri, Sep 9, 2022 at 4:55 PM Horatiu Vultur
> <horatiu.vultur@microchip.com> wrote:
> 
> > Fixes: be36abb71d878f ("pinctrl: ocelot: add support for interrupt controller")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> This v3 patch applied for fixes so we get some rotation in linux-next
> and get the Ocelot kernel in working order.
> Should it even be tagged for stable?

Thanks for applying the patch!

It would be great to go also in stable. I have tried to apply it on
5.19, 5.15, 5.10, 5.4, 4.19 but it failed on all of them because of
merge conflicts.
Should I send separate patch for each stable tree?

> 
> Andy had some further things to think about, consider these
> for possible further patching.
> 
> Yours,
> Linus Walleij

-- 
/Horatiu
