Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91108627A13
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbiKNKJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbiKNKIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:08:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 400932DEA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:08:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 594BC23A;
        Mon, 14 Nov 2022 02:08:10 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22D023F534;
        Mon, 14 Nov 2022 02:08:01 -0800 (PST)
Date:   Mon, 14 Nov 2022 10:07:59 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] mfd: vexpress-sysreg: Fix resource compound
 literal assignments
Message-ID: <20221114100759.oxrob7ulnbw4yw2p@bogus>
References: <20221113191027.2327-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113191027.2327-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
> Reported-by: kernel test robot <lkp@intel.com>

If not too late,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
