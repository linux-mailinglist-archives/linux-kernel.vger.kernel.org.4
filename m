Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2FF68289E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjAaJWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjAaJWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:22:35 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7971BF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675156953; x=1706692953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0T9JnpMnofgA14nTnYkQJMBylZvmsrtKlxmjhK44Yxw=;
  b=KbFUAdGt5SEIl+Ke6yL+txPNwhjwpk3Wio6R2XwwRrVng8MbvP3BRk6t
   Q/DfIccdk1/8NzUZEJNd0I7mXBT/XakEvJPf10XUTpx4efdRiz+aNWY58
   VLyZJfaQ8PTyp1v7pFWrW914Gb3Nqq0A+tSzrSjTtYc6roadwHNeosZ1J
   hNzbzU0tLf+U+o/6AOUKdKu+NpDm65K346QaRXJiXc3jTJuDYCLCbzxIv
   g0Ulkqkd9qjxXOl6CookPzRq4t6Ro8tVGOj8JUyaNsywi1L5mSrxx5KTg
   VpIzUS2LS0Up9eBpx9pjkb7Sn+2pOktaakn4Z1+80yXf6nsH34Cy/Mno8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="390155141"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="390155141"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 01:22:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="909839409"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="909839409"
Received: from jlawryno-mobl.ger.corp.intel.com (HELO [10.237.142.112]) ([10.237.142.112])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 01:22:17 -0800
Message-ID: <a7a36fa5-c48e-438e-f7fd-141ab6278bab@linux.intel.com>
Date:   Tue, 31 Jan 2023 10:22:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] accep/ivpu: PM: remove broken ivpu_dbg() statements
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
References: <20230126163804.3648051-1-arnd@kernel.org>
From:   Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230126163804.3648051-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.
Thanks.

On 26.01.2023 17:37, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_PM is disabled, the driver fails to build:
> 
> drivers/accel/ivpu/ivpu_pm.c: In function 'ivpu_rpm_get':
> drivers/accel/ivpu/ivpu_pm.c:240:84: error: 'struct dev_pm_info' has no member named 'usage_count'
>   240 |         ivpu_dbg(vdev, RPM, "rpm_get count %d\n", atomic_read(&vdev->drm.dev->power.usage_count));
>       |                                                                                    ^
> include/linux/dynamic_debug.h:223:29: note: in definition of macro '__dynamic_func_call_cls'
>   223 |                 func(&id, ##__VA_ARGS__);                       \
>       |                             ^~~~~~~~~~~
> include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
>   249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~~~~~~~
> include/linux/dynamic_debug.h:272:9: note: in expansion of macro '_dynamic_func_call'
>   272 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
>       |         ^~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
>   155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~
> drivers/accel/ivpu/ivpu_drv.h:65:17: note: in expansion of macro 'dev_dbg'
>    65 |                 dev_dbg((vdev)->drm.dev, "[%s] " fmt, #type, ##args);          \
>       |                 ^~~~~~~
> drivers/accel/ivpu/ivpu_pm.c:240:9: note: in expansion of macro 'ivpu_dbg'
>   240 |         ivpu_dbg(vdev, RPM, "rpm_get count %d\n", atomic_read(&vdev->drm.dev->power.usage_count));
>       |         ^~~~~~~~
> 
> It would be possible to rework these statements to only conditionally print
> the reference counter, or to make the driver depend on CONFIG_PM, but my
> impression is that these are not actually needed at all if the driver generally
> works, or they could be put back when required. Just remove all four of these
> to make the driver build in all configurations.
> 
> Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/accel/ivpu/ivpu_pm.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
> index 553bcbd787b3..a880f1dd857e 100644
> --- a/drivers/accel/ivpu/ivpu_pm.c
> +++ b/drivers/accel/ivpu/ivpu_pm.c
> @@ -237,8 +237,6 @@ int ivpu_rpm_get(struct ivpu_device *vdev)
>  {
>  	int ret;
>  
> -	ivpu_dbg(vdev, RPM, "rpm_get count %d\n", atomic_read(&vdev->drm.dev->power.usage_count));
> -
>  	ret = pm_runtime_resume_and_get(vdev->drm.dev);
>  	if (!drm_WARN_ON(&vdev->drm, ret < 0))
>  		vdev->pm->suspend_reschedule_counter = PM_RESCHEDULE_LIMIT;
> @@ -248,8 +246,6 @@ int ivpu_rpm_get(struct ivpu_device *vdev)
>  
>  void ivpu_rpm_put(struct ivpu_device *vdev)
>  {
> -	ivpu_dbg(vdev, RPM, "rpm_put count %d\n", atomic_read(&vdev->drm.dev->power.usage_count));
> -
>  	pm_runtime_mark_last_busy(vdev->drm.dev);
>  	pm_runtime_put_autosuspend(vdev->drm.dev);
>  }
> @@ -314,16 +310,10 @@ void ivpu_pm_enable(struct ivpu_device *vdev)
>  	pm_runtime_allow(dev);
>  	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
> -
> -	ivpu_dbg(vdev, RPM, "Enable RPM count %d\n", atomic_read(&dev->power.usage_count));
>  }
>  
>  void ivpu_pm_disable(struct ivpu_device *vdev)
>  {
> -	struct device *dev = vdev->drm.dev;
> -
> -	ivpu_dbg(vdev, RPM, "Disable RPM count %d\n", atomic_read(&dev->power.usage_count));
> -
>  	pm_runtime_get_noresume(vdev->drm.dev);
>  	pm_runtime_forbid(vdev->drm.dev);
>  }
