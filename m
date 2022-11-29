Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB663C515
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiK2QZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbiK2QY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:24:59 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122AF2FC02;
        Tue, 29 Nov 2022 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669739097; x=1701275097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tfOPt0/8vnd2HXG1tje5DwkqZdiyQw9mab0Jlv1doiM=;
  b=l3yzxuVhKO6Ub9kAPNI4BmK/NZMdvXzrwDdEhvz5cR5mWo0JBfCCkPul
   BPlXijObPZdvoYxEmVlETpScx0ImMP1IKZ4abcwO9c00ijirYRY0arfxp
   /3v+k37xySl+TwrGEN73+afvNURal3sC5R283MygHgLFM+AFkuWccKFhL
   UGgAMrphwB9Q1e+tZJ5MdwF4F+r3PGtKoLIegnzK7d/btS1WSpH3sV87e
   TnW5uF990qN/llVvZb14AbM1hNiEjTDlQXkZkx2qtU3JvwnvcAvCQZpls
   HR+8AtfGs8Er7Shp9WoVcnIztmKqwEB5CE1zReoe37clX/Va7n0/lffAB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="294849789"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="294849789"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 08:24:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="712427616"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="712427616"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2022 08:24:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p03Pg-001mcP-0E;
        Tue, 29 Nov 2022 18:24:52 +0200
Date:   Tue, 29 Nov 2022 18:24:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Ellero <l.ellero@asem.it>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ads7846: don't check penirq immediately for 7845
Message-ID: <Y4YyUyxoTxGscU3G@smile.fi.intel.com>
References: <20221129151959.26052-1-l.ellero@asem.it>
 <20221129151959.26052-4-l.ellero@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129151959.26052-4-l.ellero@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 04:19:59PM +0100, Luca Ellero wrote:
> To discard false readings, one should use "ti,penirq-recheck-delay-usecs".
> Checking get_pendown_state() at the beginning, most of the time fails
> causing malfunctioning.

Same comments as per patch 1.

-- 
With Best Regards,
Andy Shevchenko


