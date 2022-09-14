Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84B15B8512
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiINJfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiINJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:34:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845406FA2D;
        Wed, 14 Sep 2022 02:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663147824; x=1694683824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=T5jnO+Ie7Vt0jOGwvqFmCe1MFW3TbQr61mse3YdukZo=;
  b=eGDE03LHGAbn/tcfCVuye7GpCSt8hYlsxf4v1NktlWtsPyr35v8rPRFp
   KpGO1MtQWqQ7CLLVB+5Dz30tfQt1iFZ+LhWWJUJhrMWeZ8um49IxeGngT
   a8maUVicoCxR7PJQT15HNCq/Mez7AFAn52W5FECxjvZbaPffzfFp8g04Q
   LHFCqhEX8FgwM8LTiBvUecjqCWq9fJ5fPbJkd32pOKOJRy48VbzNEXA4Z
   cj5GfixH+A7nwYW+DEUx+1oExDwDwAnotGT28C13umxixj23FSkOkMcer
   1S4B7imSe5dm9lqnCCi5p1EimihDX0EEXCOWUnrGWWkUXAfVWkupjDWt4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="297113161"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="297113161"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 02:30:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="861879636"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 02:30:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oYOio-0028Sm-1M;
        Wed, 14 Sep 2022 12:30:18 +0300
Date:   Wed, 14 Sep 2022 12:30:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/9] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <YyGfKhXCH6TPj8Ut@smile.fi.intel.com>
References: <cover.1663025017.git.ang.iglesiasg@gmail.com>
 <f1da2a2f1bc5bb083f318335c23b4f3d9bb8e536.1663025017.git.ang.iglesiasg@gmail.com>
 <YyCz7HR+0xsyw21M@smile.fi.intel.com>
 <00db702daded3ba25efe4cd44c5a79ffb735434e.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00db702daded3ba25efe4cd44c5a79ffb735434e.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 11:19:37PM +0200, Angel Iglesias wrote:
> On Tue, 2022-09-13 at 19:46 +0300, Andy Shevchenko wrote:
> > On Tue, Sep 13, 2022 at 01:52:13AM +0200, Angel Iglesias wrote:

...

> > >   *
> > > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP180-DS000-121.pdf
> > >   *
> > > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP280-DS001-12.pdf
> > >   *
> > > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS001-11.pdf
> > > + *
> > > https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp388-ds001.pdf
> > >   */
> > 
> > Shouldn't it be based on your patch to fix the links?
> > 
> I thought of adding the patch fixing the links as a prerequisite commit, but in
> the end decided to keep the patchsets independent to avoid codependencies.

I see, then whatever Jonathan decides.

-- 
With Best Regards,
Andy Shevchenko


