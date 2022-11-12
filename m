Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4015C626A74
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiKLQJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLQJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:09:43 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D9A101DA;
        Sat, 12 Nov 2022 08:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668269383; x=1699805383;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NhaN+BDPmF2eKeW73xN887VbxSfqdp+cpLWncxJ2vNc=;
  b=iVNEQdLKv0t0COw8Qymo/ys6AoF0ETsefTamudeWdCwb7GXxPCWHPXQU
   1lnbZQBF4c6c4WuxGJM1e+fUbBRUvQcdJy3M4agHqQvlUf2y8/7YtSBeW
   EBIttmkzPetCbrP+zR0ChcxK+UKfpfMWefA4u0sG2SStesNH0qAqMWRT1
   tq28R1c36hMGZ8x9bAtttZYGAz1kIPvZg0u4UA9p+I2sc3droak39ETdv
   VdMkq15s+5rjh8aYHem7kv5FHa6aSyMwtrpUv5I+SLkffmdoeoDhD4gKn
   5SRMmrYobZ3rr9exNCmK8PEyAatZdkjl7o6UQWXNUnUVmG6jJQEzW3zeD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="373867466"
X-IronPort-AV: E=Sophos;i="5.96,160,1665471600"; 
   d="scan'208";a="373867466"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 08:09:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="615762209"
X-IronPort-AV: E=Sophos;i="5.96,160,1665471600"; 
   d="scan'208";a="615762209"
Received: from shambhav-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.251.12.9])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 08:09:42 -0800
Message-ID: <386734b3660eb3298cfbd5245f18994777a3296c.camel@linux.intel.com>
Subject: Re: [PATCH] HID: hid-sensor-custom: Allow more than one hinge angle
 sensor
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Jiri Kosina <jikos@kernel.org>
Date:   Sat, 12 Nov 2022 08:09:42 -0800
In-Reply-To: <20221105223422.417316-1-jekhor@gmail.com>
References: <20221105223422.417316-1-jekhor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-11-06 at 00:34 +0200, Yauhen Kharuzhy wrote:
> Some devices has two sets of accelerometers and the sensor hub
> exports
> two hinge angle 'sensors' based on accelerometer values. To allow
> more
> than one sensor of the same type, use PLATFORM_DEVID_AUTO instead of
> PLATFORM_DEVID_NONE when registering platform device for it.
> 
> Checked on the Lenovo Yoga Book YB1-X91L tablet.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/hid-sensor-custom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> sensor-custom.c
> index 32c2306e240d6..a6fc89ee1287c 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -862,7 +862,7 @@ hid_sensor_register_platform_device(struct
> platform_device *pdev,
>                 return ERR_PTR(-ENOMEM);
>  
>         custom_pdev = platform_device_register_data(pdev->dev.parent,
> dev_name,
> -                                                  
> PLATFORM_DEVID_NONE, hsdev,
> +                                                  
> PLATFORM_DEVID_AUTO, hsdev,
>                                                     sizeof(*hsdev));
>         kfree(dev_name);
>         return custom_pdev;

