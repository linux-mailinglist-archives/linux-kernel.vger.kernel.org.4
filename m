Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F059263F031
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiLAMKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiLAMKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:10:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4227494911;
        Thu,  1 Dec 2022 04:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669896646; x=1701432646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9JuKEDFgjles0FxGNHO8qhS4PPisXJ14oKVEED3D0Eo=;
  b=nU7TFGIVHQx4gZ0Xomc8gB/px/o9VASnlR9L5svzs1RJQMlR1qSaFA6t
   8E7fQ7ECn/6cDLAZpDpSIvSdkAKk78uwQ4BvsYiu3VXjoZF40HrtLHprf
   IKYCU1BhyYdTG36mTQJJc8rYjLm9p4rvPO/0VZhsoo+ZOXB6VB2EEb8La
   gTeHV4Ruev3fwK9oIdbfLs7pXWAespjpntFBOyHnqaVHzXM2auC1lhbdQ
   9uc43awiksY5Cd0yPKz9QmwN3/OiuSXM5Cyk5F/F+IKtFWhey/wfRwINm
   CMhaV6kSpF9w5NrqGlUOy5jYrMnXSW1/KnQaHOzp0uhu93QN8wIMkDUAI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="296026196"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="296026196"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 04:10:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="889708485"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="889708485"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 01 Dec 2022 04:10:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0iOk-002mAX-0G;
        Thu, 01 Dec 2022 14:10:38 +0200
Date:   Thu, 1 Dec 2022 14:10:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk,
        jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, lukas@wunner.de,
        UNGLinuxDriver@microchip.com, colin.i.king@gmail.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v6 tty-next 1/4] serial: 8250_pci: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Message-ID: <Y4iZvZkNc3OwKw/G@smile.fi.intel.com>
References: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com>
 <20221201045146.1055913-2-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201045146.1055913-2-kumaravel.thiagarajan@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 10:21:43AM +0530, Kumaravel Thiagarajan wrote:
> Move implementation of setup_port API to serial8250_pci_setup_port

We refer to the functions as func().
Moreover the grammatical period is what each end of sentence should have.

> +EXPORT_SYMBOL_GPL(serial8250_pci_setup_port);

Make it namespaced from day 1.

SERIAL_8250_PCI would be good name for symbol namespaces.


-- 
With Best Regards,
Andy Shevchenko


