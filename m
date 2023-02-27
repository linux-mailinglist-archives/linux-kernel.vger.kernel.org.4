Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100A76A4EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjB0Wua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjB0WuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:50:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FD729143;
        Mon, 27 Feb 2023 14:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677538211; x=1709074211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A+Ha+ND5XRehgc+ZqYZINluNko4KIow1fu2x1wXOwBs=;
  b=WMrRzuYWodQhi6CMNwxpmvFGhto4qqr+uJajPzffjDqTG/utI7zxBXAR
   bISBLLqo6bxPoSNBWnzvbO0WcZkha97RlRyXAEsIdehrZrbeNS9jWqkh1
   eUV9JhG8NYDdqBFChqh9E9eOj0rhm6CspbQp2meEKjJDa0x8FZRT5jfUE
   g6D0OQJUDtvfgSe4YqR9/i39lpJLyZHLcJIm7y4oZbxsrLrJBMNzsmwn8
   n5ykOSKtzppfvBQSx9l6QNey7GoS+IophstaD051vZq0shdd7hfLniZDl
   7sOmKLi/P7I16a0vjfy+77DIVSbdRHy4c10WKxUppu0Z1ZDPFqtaGLx/5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="331462883"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="331462883"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:50:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="673905178"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="673905178"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 27 Feb 2023 14:50:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pWmJq-00D21r-3C;
        Tue, 28 Feb 2023 00:50:06 +0200
Date:   Tue, 28 Feb 2023 00:50:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Improve the kernel-doc of iio_trigger_poll
Message-ID: <Y/0znth++tPsptKs@smile.fi.intel.com>
References: <cover.1677520155.git.mehdi.djait.k@gmail.com>
 <219496d4d21755937a40c2c7dfbeca64660c9258.1677520155.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <219496d4d21755937a40c2c7dfbeca64660c9258.1677520155.git.mehdi.djait.k@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 07:00:38PM +0100, Mehdi Djait wrote:
> Move the kernel-doc of the function to industrialio-trigger.c
> Add a note on the context where the function is expected to be called.

...

> + * This function needs to be called from an interrupt context.

> - * Typically called in relevant hardware interrupt handler.

These are not equivalent. Can you explain in the commit message why we move
from hardware to any interrupt context?

-- 
With Best Regards,
Andy Shevchenko


