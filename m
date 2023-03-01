Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D93B6A6E4A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjCAOWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCAOWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:22:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C52242BCA;
        Wed,  1 Mar 2023 06:21:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DCAA0CE1D27;
        Wed,  1 Mar 2023 14:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6774CC433EF;
        Wed,  1 Mar 2023 14:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677680476;
        bh=LkAQpIOnX82DcTebIxvOrPKo19MZbz+lB6IaMv+saCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myJyJNPMemrsQWd1NKkP6tMoIrBVeCwoKGlwfm8FecJ0JbuHkN8C0kQWgldarQMIU
         gIdvyTg4oTx2h3oOF6CFasB7BD9bl9f1UHcExcCAaIxIx0pEzUDZMcxJvnPnG8RNO0
         TpHoBvQR7j8NLcz8ZngArJgKXKwByz55wRNpSeIOIlhhaVoMtf3CZ8oom/i72ZqN3D
         ujJ29IBaFsazpVP8l8MvQ9aEY3K28Lbq91UYUXMuA4kKf/KS8NDsCuWXv2XFXGTazY
         STpVmTmYHN7QzWXFphqofngDd6txNHXkrwDeDC3QTGd3oD+6ENkOPppbZBlaHyqzc7
         x1Yo6F18OdZ1g==
Date:   Wed, 1 Mar 2023 14:21:11 +0000
From:   Lee Jones <lee@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 4/8] leds: TI_LMU_COMMON: select REGMAP instead of
 depending on it
Message-ID: <Y/9fVzOO17TBgPnX@google.com>
References: <20230226053953.4681-1-rdunlap@infradead.org>
 <20230226053953.4681-5-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230226053953.4681-5-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023, Randy Dunlap wrote:

> REGMAP is a hidden (not user visible) symbol. Users cannot set it
> directly thru "make *config", so drivers should select it instead of
> depending on it if they need it.
> 
> Consistently using "select" or "depends on" can also help reduce
> Kconfig circular dependency issues.
> 
> Therefore, change the use of "depends on REGMAP" to "select REGMAP".
> 
> Fixes: 3fce8e1eb994 ("leds: TI LMU: Add common code for TI LMU devices")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: linux-leds@vger.kernel.org
> ---
>  drivers/leds/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
