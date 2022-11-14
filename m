Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BD8627B78
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbiKNLGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiKNLGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:06:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A94F1EEEF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:06:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26FFD60FEA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4180EC433D6;
        Mon, 14 Nov 2022 11:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424007;
        bh=yTs1DCbQpEvpaSb6sIJyiPtJFp9Rg25/Yh3uUpgx1XI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKycaxqduGNwzsSLmTvqET4IOT9OVkFhkKIGE49Pkxo05E1a3uxAU3OIwtD5IvxhI
         LgzHHmbgiwYDTpD4YqUn2yKaw1gFOZgxyI9i4/I6O3edYpMlr3qOMR/Sq1dgmsv1pp
         FNyY9Xx+Jv7P75MvGubDK2AZgZD6rjbh8Ph1JMOYH+8BL1IZbmqVzhTJWa7HLtnu5P
         FpMHRG7cxvBEMWrYkeOUyQKDeZx3O/IpVYr9UZEh3Vk2Encp/Ur58TlaKjof9SkE9p
         8BXpUSonV2j1M9uhcbqS40AuJuewICRmIEwGWibCO7rsSXhtS0a+OWrNOo34vpmk7F
         lIHY0uSMaVrxQ==
Date:   Mon, 14 Nov 2022 11:06:42 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] mfd: vexpress-sysreg: Fix resource compound
 literal assignments
Message-ID: <Y3IhQvMIfvgvkBO7@google.com>
References: <20221113191027.2327-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221113191027.2327-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Nov 2022, Andy Shevchenko wrote:

> Since DEFINE_RES_*() macros were converted to provide a compound literal
> the user doesn't need to repeat it. Moreover, it may not be compiled.
> 
> Fixes: 9c973ce7f9cf ("resource: Convert DEFINE_RES_NAMED() to be compound literal")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Should go via Greg's tree where ioport.h has been changed.

I'm fine with it if Greg is:

Acked-by: Lee Jones <lee@kernel.org>

>  drivers/mfd/vexpress-sysreg.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

-- 
Lee Jones [李琼斯]
