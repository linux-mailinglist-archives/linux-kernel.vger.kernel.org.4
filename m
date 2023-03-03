Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0512E6A96B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjCCLt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCCLty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:49:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60FD3B21C;
        Fri,  3 Mar 2023 03:49:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E226617B4;
        Fri,  3 Mar 2023 11:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29830C433D2;
        Fri,  3 Mar 2023 11:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677844192;
        bh=0UXeGYnLoWvJV4L8O45twO8zDh/1/FqCRlgMkHoKprY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j++GBT0NlIzpJtQHwc3E68Lk+eztar2U37VJ6gyQmk4ECm4A+JfuGq1mysck0nv4e
         pyk6k/lnv6r6qvIIH795PfKLDsI2L1Sp9AKCXu9X7ql/3UgIs5Tq46h5y+cJjnjlpu
         WSPmjVh/q58nGnDwcKq5hlatk8kr5hul/maVuF2UmfNz2SSEGXcMCPDIeRKM/b25C9
         NoAJjpa1wp0MTQsgGqH5FpfEnfEWVAqpe3KXLsSJwCIDj0k0xmCa6aJT/uvRuKPMHY
         g7zzBn4bND/m6hq58WoM8EfvYWkqTOx0l81WaYkk76upZ0DAJIfFHuThXiKA2R8QtC
         g1iOdV6Ux6gNQ==
Date:   Fri, 3 Mar 2023 11:49:48 +0000
From:   Lee Jones <lee@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Johannes Berg <johannes.berg@intel.com>,
        Richard Purdie <rpurdie@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: Fix reference to led_set_brightness() in doc
Message-ID: <20230303114948.GG2420672@google.com>
References: <20230218-typo-led-set-v1-1-3c35362a2f2d@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230218-typo-led-set-v1-1-3c35362a2f2d@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Feb 2023, Thomas Weißschuh wrote:

> The referenced function led_classdev_brightness_set() never existed.
> 
> Fixes: 5ada28bf7675 ("led-class: always implement blinking")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  include/linux/leds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
