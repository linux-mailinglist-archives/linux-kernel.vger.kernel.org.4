Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469C5627868
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbiKNJCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiKNJCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:02:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95625FFE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:02:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63ED360F43
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D153C433D6;
        Mon, 14 Nov 2022 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668416525;
        bh=CXZ0/2nhiYqIGqu1mR9DOErXugt1W7PJgF1lQ8bJ27s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0CoZGT12x+2pRIBqktpQRQZ6Rp1p4jL+zSzQSqB4bzYGRCrjHRmrh4hFFqAsFOLS0
         TmkUA1XGHjmEHRJrMQdhjc8kpmZ38w767Y2f43EqtMZ1TlmUPJ8AoXKmNxNUm1ZFs3
         L57jIt0ki1v/mROYjlTYhbsD9XupqgZDwFVsSci0=
Date:   Mon, 14 Nov 2022 10:02:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] mfd: vexpress-sysreg: Fix resource compound
 literal assignments
Message-ID: <Y3IECjcu4IjHySnA@kroah.com>
References: <20221113191027.2327-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113191027.2327-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 09:10:27PM +0200, Andy Shevchenko wrote:
> Since DEFINE_RES_*() macros were converted to provide a compound literal
> the user doesn't need to repeat it. Moreover, it may not be compiled.
> 
> Fixes: 9c973ce7f9cf ("resource: Convert DEFINE_RES_NAMED() to be compound literal")

Wrong git id, I have no idea where that came from :(

I'll go fix this up...


greg k-h
