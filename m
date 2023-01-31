Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A5E682E90
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjAaOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjAaOAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:00:13 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DD84B77E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675173610; x=1706709610;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0oIxRLpksNU+vzluJm3n5ZxLGPzCv+NyMfa7IMvHzBg=;
  b=bBjI2dKkAA7Inbn985IKrwZxoJ8wNgNEJpFzu/FA/s8DMMYGnnir9yY+
   mdurTPE5IOV9RRmHyjYIDrqhM8DEYWDWGqU49d6s8/TJznUcf7WNOlMcv
   EpkzOhauNaQOfJOvoTQ7aQS6wRydR5BQZ4HxPg6/8FSowEDbulLiNU7DI
   g+7BhUgpF3vHqE9I5KDTx49B8e8mM3WW3AmqSSfXGdM/KXGgrY0xmvpui
   LN2FbO7fjV6fjyUsklzTggssYGzihokkNtGgXzxat5lUxjjUcd6MICh/f
   Z/k3slGYpaG5SSaLmKV1JANdtDNHZVOGlm42oMUssIQaIY+FpwmYN8VVw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="329115525"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="329115525"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 06:00:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="772982150"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="772982150"
Received: from jlawryno-mobl.ger.corp.intel.com (HELO [10.237.142.112]) ([10.237.142.112])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 06:00:07 -0800
Message-ID: <92f5faec-7fd5-4205-0b0f-1ed15626c30b@linux.intel.com>
Date:   Tue, 31 Jan 2023 15:00:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] accel/ivpu: avoid duplciate assignment
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
        dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
References: <20230126163804.3648051-1-arnd@kernel.org>
 <20230126163804.3648051-2-arnd@kernel.org>
From:   Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230126163804.3648051-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next. Thanks.

On 26.01.2023 17:37, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With extra warnings enabled, gcc warns about two assignments
> of the same .mmap callback:
> 
> In file included from drivers/accel/ivpu/ivpu_drv.c:10:
> include/drm/drm_accel.h:31:27: error: initialized field overwritten [-Werror=override-init]
>    31 |         .mmap           = drm_gem_mmap
>       |                           ^~~~~~~~~~~~
> drivers/accel/ivpu/ivpu_drv.c:360:9: note: in expansion of macro 'DRM_ACCEL_FOPS'
>   360 |         DRM_ACCEL_FOPS,
>       |         ^~~~~~~~~~~~~~
> 
> Remove the unused local assignment.
> 
> Fixes: 20709aa9435b ("accel: Add .mmap to DRM_ACCEL_FOPS")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/accel/ivpu/ivpu_drv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 2bc2f1b90671..a29e8ee0dce6 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -356,7 +356,6 @@ int ivpu_shutdown(struct ivpu_device *vdev)
>  
>  static const struct file_operations ivpu_fops = {
>  	.owner		= THIS_MODULE,
> -	.mmap           = drm_gem_mmap,
>  	DRM_ACCEL_FOPS,
>  };
>  
