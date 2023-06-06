Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4517243C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbjFFNI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbjFFNIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:08:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F2F170F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686056915; x=1717592915;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=EGypTDkiiflKHYna6oC/dC9BQiC2e9SaCPgHT4ONrUQ=;
  b=HuuuH8UalcIaVBXkDeVDDr5dzhozbp2jx3OM2CafOpBYcyzU6LH1gJnm
   Z2jVzcy3VQkXzLXVA7jUnBLYW/I4AI8MpB8lE0Q27bbFWrAM0hU3ZOCLQ
   Gs2A+PXqiQ9TGYwSKet3ioRC6r+jwX/LvAwEvQQ8OHlEI8MJDL3tllsWp
   uXxq7oroJA47llteKIJ5xu/x//Mr5OqbFqFfEPoNkWcSf1AF+NBUvfPsk
   HiXpYwi+tFqiqv9WZugd8ABSxxwsafWNu7WIVjAQUPVS5nlwF+IIiVqJP
   plt3qdBrysvZ/GwB0CEmQlrtz54HvbZ6x6Tf67w2/vuOSHvsmG3bP81aK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="443041112"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="443041112"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 06:07:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821626227"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="821626227"
Received: from abobyr-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.59.4])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 06:07:53 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Siddh Raman Pant <code@siddh.me>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Suraj Upadhyay <usuraj35@gmail.com>
Subject: Re: [PATCH v9 1/8] Revert "drm: mipi-dsi: Convert logging to drm_*
 functions."
In-Reply-To: <20230606125537.GC25774@pendragon.ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1686047727.git.code@siddh.me>
 <bff523677c65a4a6b1c06152b154cf5651f51d68.1686047727.git.code@siddh.me>
 <20230606125537.GC25774@pendragon.ideasonboard.com>
Date:   Tue, 06 Jun 2023 16:07:47 +0300
Message-ID: <87pm68u4bg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2023, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> Hi Siddh,
>
> Thank you for the patch.
>
> On Tue, Jun 06, 2023 at 04:15:15PM +0530, Siddh Raman Pant wrote:
>> This reverts commit 1040e424353f5f4d39f6f3aa8723eb3bd6ea6446.
>> 
>> It used an incorrect way to use drm_* functions. Only drm_device ptrs
>> should be passed, but the mentioned commit passed mipi_dsi_host ptr.
>> It worked by accident due to macro magic.
>> 
>> Reported-by: Jani Nikula <jani.nikula@linux.intel.com>
>> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>> Signed-off-by: Siddh Raman Pant <code@siddh.me>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> Any chance we could prevent this from happening by turning the macros
> into inline functions ?

Patch 2 adds static inline struct device *__drm_dev_ptr(const struct
drm_device *drm) which should tackle this.

BR,
Jani.

>
>> ---
>>  drivers/gpu/drm/drm_mipi_dsi.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
>> index 3fd6c733ff4e..a37af4edf394 100644
>> --- a/drivers/gpu/drm/drm_mipi_dsi.c
>> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
>> @@ -33,7 +33,6 @@
>>  
>>  #include <drm/display/drm_dsc.h>
>>  #include <drm/drm_mipi_dsi.h>
>> -#include <drm/drm_print.h>
>>  
>>  #include <video/mipi_display.h>
>>  
>> @@ -156,18 +155,19 @@ static int mipi_dsi_device_add(struct mipi_dsi_device *dsi)
>>  static struct mipi_dsi_device *
>>  of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
>>  {
>> +	struct device *dev = host->dev;
>>  	struct mipi_dsi_device_info info = { };
>>  	int ret;
>>  	u32 reg;
>>  
>>  	if (of_alias_from_compatible(node, info.type, sizeof(info.type)) < 0) {
>> -		drm_err(host, "modalias failure on %pOF\n", node);
>> +		dev_err(dev, "modalias failure on %pOF\n", node);
>>  		return ERR_PTR(-EINVAL);
>>  	}
>>  
>>  	ret = of_property_read_u32(node, "reg", &reg);
>>  	if (ret) {
>> -		drm_err(host, "device node %pOF has no valid reg property: %d\n",
>> +		dev_err(dev, "device node %pOF has no valid reg property: %d\n",
>>  			node, ret);
>>  		return ERR_PTR(-EINVAL);
>>  	}
>> @@ -202,21 +202,22 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
>>  			      const struct mipi_dsi_device_info *info)
>>  {
>>  	struct mipi_dsi_device *dsi;
>> +	struct device *dev = host->dev;
>>  	int ret;
>>  
>>  	if (!info) {
>> -		drm_err(host, "invalid mipi_dsi_device_info pointer\n");
>> +		dev_err(dev, "invalid mipi_dsi_device_info pointer\n");
>>  		return ERR_PTR(-EINVAL);
>>  	}
>>  
>>  	if (info->channel > 3) {
>> -		drm_err(host, "invalid virtual channel: %u\n", info->channel);
>> +		dev_err(dev, "invalid virtual channel: %u\n", info->channel);
>>  		return ERR_PTR(-EINVAL);
>>  	}
>>  
>>  	dsi = mipi_dsi_device_alloc(host);
>>  	if (IS_ERR(dsi)) {
>> -		drm_err(host, "failed to allocate DSI device %ld\n",
>> +		dev_err(dev, "failed to allocate DSI device %ld\n",
>>  			PTR_ERR(dsi));
>>  		return dsi;
>>  	}
>> @@ -227,7 +228,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
>>  
>>  	ret = mipi_dsi_device_add(dsi);
>>  	if (ret) {
>> -		drm_err(host, "failed to add DSI device %d\n", ret);
>> +		dev_err(dev, "failed to add DSI device %d\n", ret);
>>  		kfree(dsi);
>>  		return ERR_PTR(ret);
>>  	}
>> 

-- 
Jani Nikula, Intel Open Source Graphics Center
