Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A28E682D02
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjAaMwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjAaMwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:52:13 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845D34E512
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675169517; x=1706705517;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6bmhDvv4ZeGdpWzIo7dtVDn5+MD2AlT6GxJia3cLkPg=;
  b=DYtu8vz0y3za3YR8N9DhvYisZVxsGLrfFS6sz7l/9aJv/254E/7aVmoZ
   331djcmbob0yDAHOYTn512xpA+c3SUgoq8BTbd+wez9W2VIrLeOv+Bnlk
   Vnt6wjgP7k6gbmSD94pIYTHrjdgZ/iWB2BhZEQ19sXj0R/4HtL9QZ+rj+
   0gXKhrqdoiTfSZU4M7XfziShyCzyHGjIIDSPEGPFBkP2JGV3xvzFClI7F
   aOKs0DfwkTqyp1Nmg+nO/AfB/IzZpRj37OGHZDhTXGra4hN23N1yRC7bk
   sApu0/MiD3PSvANcGnCHXyJh29HuHSYZ3AO6nua9bam3ZNRoqsmL+6KRo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="311451347"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="311451347"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:51:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="666490940"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="666490940"
Received: from jlawryno-mobl.ger.corp.intel.com (HELO [10.237.142.112]) ([10.237.142.112])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:51:39 -0800
Message-ID: <864f6835-ceff-a124-2631-70203d8461e1@linux.intel.com>
Date:   Tue, 31 Jan 2023 13:51:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drivers: Restore alignment and newline in Makefile
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230124104145.3962497-1-geert+renesas@glider.be>
From:   Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230124104145.3962497-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.
Thanks.

On 24.01.2023 11:41, Geert Uytterhoeven wrote:
> The introduction of drivers/accel/ broke alignment, and removed the
> newline at the end of the file.  Fix all of that.
> 
> Fixes: 35b137630f08d913 ("accel/ivpu: Introduce a new DRM driver for Intel VPU")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index f0972e2226c97cb5..9ea6eb3b5d7b7f17 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -189,4 +189,4 @@ obj-$(CONFIG_COUNTER)		+= counter/
>  obj-$(CONFIG_MOST)		+= most/
>  obj-$(CONFIG_PECI)		+= peci/
>  obj-$(CONFIG_HTE)		+= hte/
> -obj-$(CONFIG_DRM_ACCEL)	+= accel/
> \ No newline at end of file
> +obj-$(CONFIG_DRM_ACCEL)		+= accel/
