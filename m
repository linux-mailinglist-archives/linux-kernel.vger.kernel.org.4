Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3228D69420E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBMJ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBMJ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:56:53 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C20EB47C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676282211; x=1707818211;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8Cmx/LQ2iQBFDNX5V7Cm4moBxJn/aITOQ83cG6dksGI=;
  b=TeVf4sVDCqkWAu2CZOmGtWAwHtdGJPPu4IjHkndSky1EqgRCXU//q7R6
   EGDveqVhAge7FUCvfHnfkK+Mxpapw1uSTKCS/h2DnqRJaPfPYdlumjgay
   Fjbk6Ndaa0moVKT2c2z/EYzzxkiS46/VGcS+C1I2bcwWu/QRpXqjHnklN
   1mLmmZxwE+IGjavqAjmmEKUg5BshXrU7I30vgNX2xLhF1aL/2hAWI7wYO
   S7MftuW78xEWLpOoZE5zboJS8X7kfo1zh7hTxpVYBf/VKpX4x0ZOo82xG
   c0vakfos7Jcx2OszK33Xb0ndYwKpAlZ/GC+W27wiQiOW/soDIB9Y7ns7f
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="330861528"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="330861528"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 01:56:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="777779384"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="777779384"
Received: from tkatila-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 01:56:48 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Yaroslav Bolyukin <iam@lach.pw>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/edid: Add Vive Pro 2 to non-desktop list
In-Reply-To: <5d5a8183-aebc-6660-9cbc-03950f9b14b8@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220118170037.14584-1-iam@lach.pw>
 <5d5a8183-aebc-6660-9cbc-03950f9b14b8@collabora.com>
Date:   Mon, 13 Feb 2023 11:56:41 +0200
Message-ID: <87v8k5vqg6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2023, Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> Hi,
>
> On 1/18/22 20:00, Yaroslav Bolyukin wrote:
>
> Add a brief commit message, describing a user-visible effect of this
> patch. Tell that this change prevents exposing headset as a regular
> display to the system, while it will work with SteamVR.
>
>> Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
>> ---
>>  drivers/gpu/drm/drm_edid.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> index 12893e7be..fdb8f0a6f 100644
>> --- a/drivers/gpu/drm/drm_edid.c
>> +++ b/drivers/gpu/drm/drm_edid.c
>> @@ -200,9 +200,10 @@ static const struct edid_quirk {
>>  	EDID_QUIRK('V', 'L', 'V', 0x91be, EDID_QUIRK_NON_DESKTOP),
>>  	EDID_QUIRK('V', 'L', 'V', 0x91bf, EDID_QUIRK_NON_DESKTOP),
>>  
>> -	/* HTC Vive and Vive Pro VR Headsets */
>> +	/* HTC Vive, Vive Pro and Vive Pro 2 VR Headsets */
>
> Nit: I'd keep the original comment, or change it to a generic "HTC VR
> Headsets" to prevent further comment changes
>
>>  	EDID_QUIRK('H', 'V', 'R', 0xaa01, EDID_QUIRK_NON_DESKTOP),
>>  	EDID_QUIRK('H', 'V', 'R', 0xaa02, EDID_QUIRK_NON_DESKTOP),
>> +	EDID_QUIRK('H', 'V', 'R', 0xaa04, EDID_QUIRK_NON_DESKTOP),
>>  
>>  	/* Oculus Rift DK1, DK2, CV1 and Rift S VR Headsets */
>>  	EDID_QUIRK('O', 'V', 'R', 0x0001, EDID_QUIRK_NON_DESKTOP),
>> 
>> base-commit: 99613159ad749543621da8238acf1a122880144e
>
> Please send the v2 patch with the added EDID for Cosmos VR and the
> addressed comments. Thanks!

Yeah, we'll need to EDID to check that it doesn't have the Microsoft
VSDB to indicate non-desktop. See 2869f599c0d8 ("drm/edid: support
Microsoft extension for HMDs and specialized monitors").


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
