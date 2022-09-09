Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245BC5B31FE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiIIImb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiIIIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:42:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC95121135;
        Fri,  9 Sep 2022 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662712947; x=1694248947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zza+1RX+YBCgJ51RC0Jc8aCx0Iz4g15+5WlRpgh9dpk=;
  b=Cg5QmF5gHH/4q7nQMRR2oL05qHo9M+nBxz7VOuuZB6Wzu5Ga+TW7RgWd
   FTqgphiHPfsNYSvuiE3CH8l1l/F5hRx6ESUu4CQYJWD9A6Ug8nvqMgHur
   aVyTBeW0KBhJr6ZH3GhyNOLvLTj+lmAjhw/iQSSqXM2AjtOESYNrGL8N1
   tNiGNMQgyxrlHrlm+E84OoRS+NNjxg4WSwRJjk/XTuIRve+Y+z5hAW8Ee
   xXBoJYoxIYAekar4QZ1PFEvmEZT3WmFhfRSndZ21zhodz8lHRS/OhofuS
   q+63/ZaIFtFL5fbWJbFbdATEy/niM7Wy/8BNCzY7eVzBo64U1THBLIV5g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="359153808"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="359153808"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 01:42:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="683561687"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 01:42:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWZaL-00AU95-1s;
        Fri, 09 Sep 2022 11:42:01 +0300
Date:   Fri, 9 Sep 2022 11:42:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pinctrl: cy8c95x0: Use 'default' in all
 switch-cases (part 2)
Message-ID: <Yxr8WYfRT+XKEKGK@smile.fi.intel.com>
References: <20220908142134.59068-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdYHWSc-kVUdr_YJ-YvMEc-LqrgDj0D62F2WKdA1H5Uvrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYHWSc-kVUdr_YJ-YvMEc-LqrgDj0D62F2WKdA1H5Uvrw@mail.gmail.com>
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

On Fri, Sep 09, 2022 at 10:02:51AM +0200, Linus Walleij wrote:
> On Thu, Sep 8, 2022 at 4:21 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Move the default values to the 'default' case in the switches.

> Patch applied!

Thanks!

...

> >         case CY8C95X0_DRV_PP_SLOW:
> >         case CY8C95X0_DRV_HIZ:
> >                 return true;
> > +       default:
> > +               return false;
> >         }
> > -
> > -       return false;
> 
> Clearly this is better style, I wonder if we could teach checkpatch to
> look for this? Or cocinelle?

The latter I believe. But I'm too busy and too lazy to go that road.

-- 
With Best Regards,
Andy Shevchenko


