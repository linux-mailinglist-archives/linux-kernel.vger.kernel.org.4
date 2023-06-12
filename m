Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8806772C9E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbjFLPYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjFLPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:24:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D281726;
        Mon, 12 Jun 2023 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686583419; x=1718119419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SmiJCS5joe51N0yUALJhmfOkcL+YhYEdzxMbyAfp1SY=;
  b=Yq9JjEnv7GW2NQj2X6ZLMEd5mi1EFge8WZo3WZP9YmeT8xsYsflEAlEU
   zFOMmENKIaVhC9qAHAxdiky4upr3GXsZWDJ2DAFXDLs6+AdGXAskWX4T9
   w3EZBsE3dit1ls9lS+hQx6fzvhLIldQPPyuGL5Tvrf4N69MxPKYpfBQHq
   jA/p2M+JrqNz72M83YCUTocAgUpQ5PxIco51YqsgNK34j3ubB7yYASDne
   Jv6UMrMejiyVp/g9VZnrwh/IYiVzue/A0Fxm3+94/tma04A71epdFsyqb
   zpqPbb9dHcThMXwowXsIA4QAi7o4437z3IAZ42jdqr0Mx49rjRXJqBKEs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="356959166"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="356959166"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:22:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="801058897"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="801058897"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2023 08:21:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8jMi-00398o-2t;
        Mon, 12 Jun 2023 18:21:56 +0300
Date:   Mon, 12 Jun 2023 18:21:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 1/3] ACPI: Move ACPI_DEVICE_CLASS() to
 mod_devicetable.h
Message-ID: <ZIc4FH/OgIA9vN+D@smile.fi.intel.com>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
 <20230609154900.43024-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0i29u7RUnhatOANBgjdrH4uoWK_8VCHWK2UO7RS8L3H1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i29u7RUnhatOANBgjdrH4uoWK_8VCHWK2UO7RS8L3H1A@mail.gmail.com>
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

On Fri, Jun 09, 2023 at 07:32:53PM +0200, Rafael J. Wysocki wrote:
> On Fri, Jun 9, 2023 at 5:49 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The data type of struct acpi_device_id is defined in the
> > mod_devicetable.h. It's suboptimal to require user with
> > the almost agnostic code to include acpi.h solely for the
> > macro that affects the data type defined elsewhere.
> >
> > Taking into account the above and for the sake of consistency
> > move ACPI_DEVICE_CLASS() to mod_devicetable.h.
> >
> > Note, that with CONFIG_ACPI=n the ID table will be filed with data
> > but it does not really matter because either it won't be used, or
> > won't be compiled in some cases (when guarded by respective ifdeffery).
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> or please let me know if you want me to apply this.

The first patch can be applied independently. But it may be better to apply
all three via one tree (linux-pm was mentioned in the cover letter) as it
shows the point.

-- 
With Best Regards,
Andy Shevchenko


