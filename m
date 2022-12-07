Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445ED64589B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiLGLKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiLGLJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:09:56 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831B2F3F;
        Wed,  7 Dec 2022 03:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670411387; x=1701947387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nU9rp5jPyY8+mI11cKJ1NzPBmuYJiOn2HvINnV2bBUQ=;
  b=ndfz1yXvgYOhjf8HytMq71gs05FAF6fMiktpbv8AuQxQxlNWWcB1jboV
   xHpb8Pyf+T9tJI18ix8qR0GwX/o/IhVXGEjN3KVZeVFF/bkLuYLQFKvgz
   4FRsPHbopD+IRXKeNNLP1uGlcYyCvcR2GWiob+hi7cGvGw75wlg5lNlUe
   neRBKQEOLHfaHcU+KYHM9AekM1kZh5RZ0uqco7omRNqBpIRNFvCrdJnkQ
   mkm5zPT1sgZzjhaioEyv5GQZgqDJ168tUbsj0Egu5dD1BGI1J1ehOt0Jj
   shkiEQlVkrjRWpcstxOfvsOea4OW/nUupCC9he2IpWJXsVsz6QQSs6//z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="343895791"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="343895791"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 03:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="753052960"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="753052960"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 07 Dec 2022 03:09:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2sIw-005jbc-2U;
        Wed, 07 Dec 2022 13:09:34 +0200
Date:   Wed, 7 Dec 2022 13:09:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     outreachy@lists.linux.dev, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: drivers: mfd: Add MAX77541 MFD and related
 device drivers
Message-ID: <Y5B0btPjY6nHhYRm@smile.fi.intel.com>
References: <20221207090906.5896-1-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207090906.5896-1-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 12:08:39PM +0300, Okan Sahin wrote:
> This patchset adds mfd, regulator and adc driver and related bindings.The patches 
> are required to be applied in sequence.

You have an indentation / wrapping issues in the above text.

Nevertheless, why staging? What does it mean?

-- 
With Best Regards,
Andy Shevchenko


