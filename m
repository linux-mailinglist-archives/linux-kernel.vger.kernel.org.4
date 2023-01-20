Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72D3675847
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjATPQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjATPQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:16:23 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5698693;
        Fri, 20 Jan 2023 07:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674227781; x=1705763781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hurhgLmMEpOoTMnHRbWR4KK7xLUq1IkoBL6I3qiNu74=;
  b=cIrSYnYxozrpgK7ATmCjLlV7r/IfLIusMW8YjoTYDHoulyw9/SApK5Oa
   xeQRZUIBM9YnSVSSkpcZuF5sa8vh0JYi6eLgq0URDOb9FbXRiiVwp1cbY
   5oKsLkNbGnA4EBA3v43r9icRvqzDGRX22o1x6WkKcLl6GKpYY8leLN2Is
   da2RIglwHcLt2fnk/1SfSU72mBSED+mEl0wRmlsv9IbQgsKv9jfBfZ24e
   GLBPtUY4Mz5ctTmfhYpgaZrVpURFgvC76lBf8G4Y2GtHuXAGOimLIaDVA
   ksZ7kF/TAf4DaWXAB4JzuImKFE8v7dLkQnaizxyHg7Wcu7tqWd5sDWdgC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="325635682"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="325635682"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 07:16:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="768714651"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="768714651"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2023 07:16:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIt7o-00CHW5-1v;
        Fri, 20 Jan 2023 17:16:16 +0200
Date:   Fri, 20 Jan 2023 17:16:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Ellero <l.ellero@asem.it>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Input: ads7846 - don't report pressure for ads7845
Message-ID: <Y8qwQM2zLbboTeth@smile.fi.intel.com>
References: <20230120124544.5993-1-l.ellero@asem.it>
 <20230120124544.5993-2-l.ellero@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120124544.5993-2-l.ellero@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 01:45:42PM +0100, Luca Ellero wrote:
> ADS7845 doesn't support pressure.
> This patch avoids the following error reported by libinput-list-devices:

s/This patch avoids/Avoid/

(This rule is written in Submitting Patches documentation.)

> "ADS7845 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE".

Do you need a Fixes tag?

-- 
With Best Regards,
Andy Shevchenko


