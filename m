Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8AC61F43D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiKGNZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiKGNZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:25:10 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD097113C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667827509; x=1699363509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hlL+DfWEWMRR8orTzyWzhpO4GGMnYRYRp0nALpNPto8=;
  b=X7qAZPTYfUYF7ZpFotp6VmDpiGkvkYDQId5/CWOWVqRzYgLGQAD6qRcC
   af20o2zCoAjlqwDDAJZdjdBs/mfrVYzczm3t830BgeGtO+4Msa28dETdx
   4nxUuVVn/5BydJrvnlIsudA1GK0r1AMeuFddq8VfKfeIKebit/mL1VEee
   VlTHANS7wpfnQprnAGQ229iX9/nffruYqbNyT1K/oNO3Mp4c1/cKAuXkO
   Cv3farN5+PaVuoR+bxRYFZO1PFs5sWSqtiUqWEnSHVSYaNjN+/rD8cJF8
   dLk5t0AwjXK3FW73vg2XKSh3Dh8938ckYNGovQAFGfQsT72jE+3PT1uiu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="297899194"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="297899194"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 05:25:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="761093220"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="761093220"
Received: from joe-255.igk.intel.com (HELO localhost) ([172.22.229.67])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 05:25:05 -0800
Date:   Mon, 7 Nov 2022 14:25:03 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        John Hubbard <jhubbard@nvidia.com>,
        stanislaw.gruszka@intel.com, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiho Chu <jiho.chu@samsung.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [RFC PATCH v2 1/3] drivers/accel: define kconfig and register a
 new major
Message-ID: <20221107132503.GA3590860@linux.intel.com>
References: <20221102203405.1797491-1-ogabbay@kernel.org>
 <20221102203405.1797491-2-ogabbay@kernel.org>
 <Y2MMCIe5wND2XPqE@kroah.com>
 <CAFCwf13uLj=P6u6FAcY8M5qAXoaBdb+Ha-TYj0j2FAZnFAPFYg@mail.gmail.com>
 <CAFCwf12yRUG4593ozJMEwaaJBKyWqXTTCjef9O_fzWdQBxVrtw@mail.gmail.com>
 <Y2kAcCu4z2LUMN7u@nvidia.com>
 <CAFCwf10K-dTu455QfOK8i6thismY-FUN2Rws830EGiqOcGWFgA@mail.gmail.com>
 <Y2kDzPswkKyZyRpS@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2kDzPswkKyZyRpS@nvidia.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Nov 07, 2022 at 09:10:36AM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 07, 2022 at 03:01:08PM +0200, Oded Gabbay wrote:
> > I don't agree with your statement that it should be "a layer over top of DRM".
> > Anything on top of DRM is a device driver.
> > Accel is not a device driver, it is a new type of drm minor / drm driver.
> 
> Yeah, I still think this is not the right way, you are getting almost
> nothing from DRM and making everything more complicated in the
> process.
> 
> > The only alternative imo to that is to abandon the idea of reusing
> > drm, and just make an independant accel core code.
> 
> Not quite really, layer it properly and librarize parts of DRM into
> things accel can re-use so they are not intimately tied to the DRM
> struct device notion.

What do you mean by "struct device notion" ? struct drm_devce ? 

Regards
Stanislaw
