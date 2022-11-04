Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC616191C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiKDHXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKDHXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:23:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40A96364
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 00:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667546618; x=1699082618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jNIWc97tS6wGon8k/Fw7hFZDoAAsSFUxCPMc9Hd2YGc=;
  b=cnTjMS9u82vG5NUjcORoWNegxrRtEMchCkZlL3G7zMHvWD1vxoSuS1oh
   zRk2UkEvYEGTLDbplrtzIJ0EO2XsZ56P8wwjJwHA3HY4cokVq1cOzjo6w
   fHHHCFELwA4gPyI6eKyHik48omLwx9VhVxFYC4VTl5/OD5jzHwUaizZ2M
   nnD/TpM10oF7DAzayVmA9deCSIn4IZ2f3xgxClHKLrZsDyMm0SGV3A9ic
   5F7j9o0beXA0IgoT76MplZAVnXjzDqGD7UjYch04EwPWvlD6XOFDotRaS
   ar9PgnroXYMF6En6D4dfxaj0k0IwV62lWAm11ERDGJCxMbgMmaNrgM6Pe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="309893426"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="309893426"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 00:23:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="880200009"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="880200009"
Received: from joe-255.igk.intel.com (HELO localhost) ([172.22.229.67])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 00:23:34 -0700
Date:   Fri, 4 Nov 2022 08:23:32 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jiho Chu <jiho.chu@samsung.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        stanislaw.gruszka@intel.com,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Kevin Hilman <khilman@baylibre.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [RFC PATCH v2 1/3] drivers/accel: define kconfig and register a
 new major
Message-ID: <20221104072332.GA3149018@linux.intel.com>
References: <20221102203405.1797491-1-ogabbay@kernel.org>
 <20221102203405.1797491-2-ogabbay@kernel.org>
 <Y2MMCIe5wND2XPqE@kroah.com>
 <CAFCwf13uLj=P6u6FAcY8M5qAXoaBdb+Ha-TYj0j2FAZnFAPFYg@mail.gmail.com>
 <CAFCwf12yRUG4593ozJMEwaaJBKyWqXTTCjef9O_fzWdQBxVrtw@mail.gmail.com>
 <d5630f32-208a-77d2-91ed-58ef526ed086@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5630f32-208a-77d2-91ed-58ef526ed086@infradead.org>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 04:01:08PM -0700, Randy Dunlap wrote:
> >>> Module name if "M" is chosen?
> >> Will add
> > So, unfortunately, the path of doing accel as a kernel module won't
> > work cleanly (Thanks stanislaw for pointing this out to me).
> > The reason is the circular dependency between drm and accel. drm calls
> > accel exported symbols during init and when devices are registering
> > (all the minor handling), and accel calls drm exported symbols because
> > I don't want to duplicate the entire drm core code.
> 
> But DRM is a tristate symbol, so during drm init (loadable module), couldn't
> it call accel init code (loadable module)?
> 
> Or are you saying that they only work together if both of them are builtin?

Yes, with current state of the patches, we can not build code as modules.
There are symbols in accel that are from drm and we use accel symbols
in drm. This could be fixed by separating symbols accel requires in 
separate module i.e. drm_file_helper.ko, however Oded proposed to make
CONFIG_ACCEL compile option for DRM and all accel code will be
build in drm.ko . I think that ok, since accel is not big. 

Regards
Stanislaw

