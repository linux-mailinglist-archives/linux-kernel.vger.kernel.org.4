Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C6D63239D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKUNcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiKUNbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:31:48 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC663C1F62;
        Mon, 21 Nov 2022 05:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669037497; x=1700573497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ceh0DaFQWSL4oJtGHDPdZNHSDLWu93eSVmt8Lic6F1g=;
  b=ewhX5ChfqTTl1JC6IyEneuv3Xp+pbVKu1UXsm6kOSxB+weNb3NDEW7WE
   wlMrx8cqrAFM37U7cvaESaHXgi/VxgOYo+WyKGcPZd+7/GCtql0CPPAyr
   bCFPGko2+iKQOC2h3YMUDMgMVwDwxc/cDjq0+E5Nm5WO/FOErmw76UZAZ
   E1qgibuavC6l8NITcQ1t7Grqf1gT8nhB1Uv/SYJJW+8bLOIqP8DS7Ov0N
   R4lJ9IAtA0h7PiAfz5OlMyydJjpnOoNLkkWgVa+zS181ts18mxHOTfx/y
   WG3fE2E+tZ/O1i0/VG9xs6rJiuAuPyAD7Qzs2U6ix0rvDAROAc3bffNdw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="314703135"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="314703135"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 05:31:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="643320284"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="643320284"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2022 05:31:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ox6tY-00FI8e-2N;
        Mon, 21 Nov 2022 15:31:32 +0200
Date:   Mon, 21 Nov 2022 15:31:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] atomisp: Make bds_factors_list be type of struct
 u32_fract
Message-ID: <Y3t9tNlXZCHcw4jd@smile.fi.intel.com>
References: <20221118184309.60834-1-andriy.shevchenko@linux.intel.com>
 <837c5412-5019-c78a-d890-7fedd4064a9e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <837c5412-5019-c78a-d890-7fedd4064a9e@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 02:21:30PM +0100, Hans de Goede wrote:
> On 11/18/22 19:43, Andy Shevchenko wrote:

...

> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> I've added this to my media-atomisp branch now and will
> include this in the pull-req which I will send to Mauro after I've
> run some quick tests (tonight or tomorrow).

Thank you!

...

> >  	res->sc_bayer_origin_x_bqs_on_shading_table =
> >  		((left_padding_adjusted_bqs + bad_bqs_on_left_before_bs)
> > -		* bs_hor_ratio_out + bs_hor_ratio_in / 2) / bs_hor_ratio_in
> > +		* bds.denominator + bds.numerator / 2) / bds.numerator
> >  		+ bad_bqs_on_left_after_bs;
> > -	/* "+ bs_hor_ratio_in/2": rounding for division by bs_hor_ratio_in */
> > +	/* "+ bds.numerator / 2": rounding for division by bds.numerator */
> >  	res->sc_bayer_origin_y_bqs_on_shading_table =
> > -		(bad_bqs_on_top_before_bs * bs_ver_ratio_out + bs_ver_ratio_in / 2) / bs_ver_ratio_in
> > +		(bad_bqs_on_top_before_bs * bds.denominator + bds.numerator / 2) / bds.numerator
> >  		+ bad_bqs_on_top_after_bs;
> > -	/* "+ bs_ver_ratio_in/2": rounding for division by bs_ver_ratio_in */
> > +	/* "+ bds.numerator / 2": rounding for division by bds.numerator */

While reading this code again I just realized this is open coded
DIV_ROUND_CLOSEST(). But, thinking more, I believe we may rather introduce
the FRACT_DIV_ROUND_CLOSEST() macro in the math.h and take struct *_fract
as a parameter. In any case, it's for the future improvements.

-- 
With Best Regards,
Andy Shevchenko


