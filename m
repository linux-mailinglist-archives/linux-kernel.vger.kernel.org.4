Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137C45BCAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiISL1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiISL1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:27:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4CD2251B;
        Mon, 19 Sep 2022 04:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663586811; x=1695122811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JyPCRYvgmMfnN2Lq0Uq6Vyynty0vkNRyYp7K7s+7F30=;
  b=GOIMPALDGT6s0u7S5nonPmM0Aql6FCVhxBhos7bvNf4UnLljkPBUseJ+
   JY5U8lv1resotqodg85UAfsRbAKZU1OFHJBKhTj10EVvi/Ie0CSxiqgqJ
   NhrteaJY8zei0HuMjriAGEcZRcQ/9xAFNQW0ttbO6ZY51tb+UWyu2K6Ti
   agMDiXOYgWm8iYQvUDW/SEoPHD/uhtmFr3wU7O29Nac9395YV9J5CB5hL
   zamp6TnKw1eGSO/4D2Pd596VdNcQ9Fbuf9y+jgCmEOd2LCgdNFnxk+Z9H
   pj1z6icSH+wPxVqWyBth34kE5hR3K4e3p/bn9EATBc+0svDRFEmEUXHy9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="300748424"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="300748424"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 04:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="618454967"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by orsmga002.jf.intel.com with SMTP; 19 Sep 2022 04:26:45 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 19 Sep 2022 14:26:44 +0300
Date:   Mon, 19 Sep 2022 14:26:44 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Yadav, Arvind" <arvyadav@amd.com>,
        Arvind Yadav <Arvind.Yadav@amd.com>, andrey.grodzovsky@amd.com,
        shashank.sharma@amd.com, amaranath.somalapuram@amd.com,
        Arunpravin.PaneerSelvam@amd.com, sumit.semwal@linaro.org,
        gustavo@padovan.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [Linaro-mm-sig] Re: [PATCH v4 0/6] dma-buf: Check status of
 enable-signaling bit on debug
Message-ID: <YyhR9OGjWVwm31Rp@intel.com>
References: <20220914164321.2156-1-Arvind.Yadav@amd.com>
 <d2d81ffd-2269-bdc6-0daa-8f3a99306e46@amd.com>
 <33a16b15-3d3c-7485-d021-ee2a727e5391@amd.com>
 <691c421f-1297-cd08-ea70-6750099275b1@amd.com>
 <YyVmYXGCfTuYUsNb@intel.com>
 <c958d871-9a89-3490-f5e3-3a2441926074@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c958d871-9a89-3490-f5e3-3a2441926074@gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 05:18:40PM +0200, Christian König wrote:
> Am 17.09.22 um 08:17 schrieb Ville Syrjälä:
> > On Thu, Sep 15, 2022 at 06:05:30PM +0200, Christian König wrote:
> >> Am 15.09.22 um 15:02 schrieb Yadav, Arvind:
> >>> On 9/15/2022 5:37 PM, Christian König wrote:
> >>>> Is that sufficient to allow running a desktop on amdgpu with the
> >>>> extra check enabled? If yes that would be quite a milestone.
> >>>>
> >>> Yes, It is running on amdgpu with extra config enabled.
> >> In this case I will start pushing the patches to drm-misc-next. I'm just
> >> going to leave out the last one until the IGT tests are working as well.
> > ffs Christian. intel CI blew up yet again:
> > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_12146/shard-glk7/igt@kms_plane_lowres@tiling-y@pipe-c-hdmi-a-2.html
> >
> > The last time (some ttm thing) was just a week or two ago,
> > so it's really getting tiresome watching you push entirely
> > untested stuff all the time. Would be really helpful if you
> > finally started to do/require premerge testing.
> 
> Well first of all sorry for causing trouble, but as I wrote above I 
> intentionally left out the last one to *not* break the IGT tests.
> 
> The patches pushed so far where just updating a bunch of corner cases 
> and fixing the selftests.
> 
> Do you have any more insight why that should affect the IGT tests?

I have no idea. You have the oopses from pstore right there.
Did you even look at them?

-- 
Ville Syrjälä
Intel
