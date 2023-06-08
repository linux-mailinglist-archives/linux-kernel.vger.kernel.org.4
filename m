Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B167276F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 07:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjFHF6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 01:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjFHF57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:57:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4C41984;
        Wed,  7 Jun 2023 22:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686203878; x=1717739878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C6YIdimhhCSqB2aOCNA+4fKVost7ygPqKS7gSVJy1DU=;
  b=bL0ez5aOjxDMMDu1LoNdaYow8l2k6OzDe+GZ7eLV5azMUKp/dysw96oe
   0tfkomDwIPEAGBhHKtHS3zgqArdmfUTDbtQ9zXAwpd+U1BmbU36p4vuk9
   ySHKUr2F4/LSxyICduvqQ0AyarFEWZZQstsVmZvUrkRHAcvIhtqAQkg/J
   JGPHGZh0n3KZL2gWiTQXoNOuJeQ6XjXtSeaHdYS5IOHHARlVYPT0Z0Jhf
   9Ki8teyL10kOOhjFkE4ncDY8fWQQp0mrnj+hfq8vS50Wag/Hfm4hT46Y2
   AU1gnjjoQ8gUlMo6b4xTfC+8tZFj3MHyqs0xy+Ad8Ud00BH9wbyGtOtXw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="354703492"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="354703492"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 22:57:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="739563409"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="739563409"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 22:57:56 -0700
Date:   Thu, 8 Jun 2023 07:57:54 +0200
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] accel/ivpu: Use struct_size()
Message-ID: <20230608055754.GD324119@linux.intel.com>
References: <0ae53be873c27c9a8740c4fe6d8e7cd1b1224994.1685366864.git.christophe.jaillet@wanadoo.fr>
 <3475be3b-11d5-96fe-6bc4-26d0e3a270df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3475be3b-11d5-96fe-6bc4-26d0e3a270df@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 05:58:48PM +0200, Marco Pagani wrote:
> 
> On 2023-05-29 15:28, Christophe JAILLET wrote:
> > Use struct_size() instead of hand-writing it. It is less verbose, more
> > robust and more informative.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Marco Pagani <marpagan@redhat.com>
Applied to drm-misc-next

Thanks
Stanislaw

> 
> > ---
> >  drivers/accel/ivpu/ivpu_job.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
> > index 3c6f1e16cf2f..0a09bba8da24 100644
> > --- a/drivers/accel/ivpu/ivpu_job.c
> > +++ b/drivers/accel/ivpu/ivpu_job.c
> > @@ -289,15 +289,13 @@ ivpu_create_job(struct ivpu_file_priv *file_priv, u32 engine_idx, u32 bo_count)
> >  {
> >  	struct ivpu_device *vdev = file_priv->vdev;
> >  	struct ivpu_job *job;
> > -	size_t buf_size;
> >  	int ret;
> >  
> >  	ret = ivpu_rpm_get(vdev);
> >  	if (ret < 0)
> >  		return NULL;
> >  
> > -	buf_size = sizeof(*job) + bo_count * sizeof(struct ivpu_bo *);
> > -	job = kzalloc(buf_size, GFP_KERNEL);
> > +	job = kzalloc(struct_size(job, bos, bo_count), GFP_KERNEL);
> >  	if (!job)
> >  		goto err_rpm_put;
> >  
> 
