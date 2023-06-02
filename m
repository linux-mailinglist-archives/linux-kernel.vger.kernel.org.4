Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C0C71F73D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 02:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjFBAoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 20:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjFBAoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 20:44:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71541AB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685666646; x=1717202646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wJ/OSP0ckFfzwVnZAaDMF9t5J0/dICf1DZ8XGD9GwWg=;
  b=hyjiujliRRHzvNJUo+313zXTOSf7Y9xNtjqZgRYRgxPH5T/XugFVdBQp
   g4B7Tdy1YMKMFxhq1SKWNJTZZAZhJUgpFuzp0dcJ0q6uGTu8gjceZOHf3
   RTRnUvnMcBEvNpM6W5yKlqieGkgBVoGI3m4ep8uoy/r5mhL50+5acIzgQ
   Sv9C7YtgYiX9bTyDUws9LwLfaSfZfecZHewFMj3brt1UbnXqzFzRE2OP1
   uO8vqQdcom1YOmeOygOHZhZRWkdWQrNRpzBXlVea0g7DTAuI7Cu0uCDUO
   uBDHPFuVF/BMhiJlfAVdaJgTF/2cz8jdBDC+8d8DMdhbHijemD/RB8Qtg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="353222242"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="353222242"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 17:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="737318294"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="737318294"
Received: from gsavorni-mobl1.ger.corp.intel.com (HELO intel.com) ([10.251.210.46])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 17:44:00 -0700
Date:   Fri, 2 Jun 2023 02:43:56 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
Cc:     "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "arnd@kernel.org" <arnd@kernel.org>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/pxp: use correct format string for
 size_t
Message-ID: <ZHk7TIGDwjN3vcdu@ashyti-mobl2.lan>
References: <20230601213624.3510244-1-arnd@kernel.org>
 <a97c3bbb260587a352a6d8d228e65cc6ae8fd59e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a97c3bbb260587a352a6d8d228e65cc6ae8fd59e.camel@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Jun 01, 2023 at 10:00:27PM +0000, Teres Alexis, Alan Previn wrote:
> On Thu, 2023-06-01 at 23:36 +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > While 'unsigned long' needs the %ld format string, size_t needs the %z
> > modifier:
> 
> alan:snip
> 
> 
> > +++ b/drivers/gpu/drm/i915/pxp/intel_pxp_gsccs.c
> > @@ -143,7 +143,7 @@ gsccs_send_message(struct intel_pxp *pxp,
> >  
> >  	reply_size = header->message_size - sizeof(*header);
> >  	if (reply_size > msg_out_size_max) {
> > -		drm_warn(&i915->drm, "caller with insufficient PXP reply size %u (%ld)\n",
> > +		drm_warn(&i915->drm, "caller with insufficient PXP reply size %u (%zd)\n",
> >  			 reply_size, msg_out_size_max);
> >  		reply_size = msg_out_size_max;
> >  	}
> Thanks Arnd for catching this, although i believe Nathan sumbmitted a patch for the same fix yesterday and received an RB from Andi.

yes, the patch is here:

https://patchwork.freedesktop.org/patch/540272/?series=118593&rev=1

I'm waiting for full CI results to merge this.

Thanks,
Andi
