Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F7B5BDABE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiITDPL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Sep 2022 23:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiITDOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:14:52 -0400
Received: from ipmail03.adl2.internode.on.net (ipmail03.adl2.internode.on.net [150.101.137.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B3B86375
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 20:14:46 -0700 (PDT)
X-SMTP-MATCH: 1
IronPort-Data: =?us-ascii?q?A9a23=3AfFSx46iTVFuokU3YwQikc0bKX161nBEKZh0uj?=
 =?us-ascii?q?C45NGQN5FlHY01jehtvDGyOaKvbYmT3fNAiaI+wpx5UvcLRx4NiQQZqqno8R?=
 =?us-ascii?q?CkU8cSfX4iVJE6uNnmfIJyZQhxu5p4VYYXMcZhpFiTVqz6gY+PrxZVe/fjYH?=
 =?us-ascii?q?uCmVIYoGczQqTeJ+07NsDo78wIEqtcAbeaRU1vlVeza+6UzCHf9s9JFGjp8B?=
 =?us-ascii?q?5Cr8XuDj9yq0N8shWHSUNgQ1LPoe9j5O7pETU25ByOQroC5hYdWTc6bpF2y1?=
 =?us-ascii?q?juxExvAlrqYfrjHnk0iGtY+PCC90yAJHfDk2l4bk0Te0I5icqNANgEG0nPQw?=
 =?us-ascii?q?IoZJNZl7PRcTS8gJLHMhf5bVhBCCCFWPKta9aXBJnSy98uViUvLbxMAxt00X?=
 =?us-ascii?q?BhubNJCqr8f7WZmr6dGcFjhdCurjua70L62V+Jsi94LI8ziPYdZsXZlpRnpD?=
 =?us-ascii?q?PAmXJGFe6zMzdZd0HE7gcUmNf/ffc4YZDZHaBXGfg0JO1p/IJs6kfehgHXya?=
 =?us-ascii?q?XtUpU+epacty2HWwEp6172FGNPQdpmFS9V9mkeDunmA8X70Dx0XL9+DziLD9?=
 =?us-ascii?q?Wij7sfGgDnyUoMUGLr+7v9uhFSS7mUWBFsdUl7TifK5kE+lR9NWLQoX/Scor?=
 =?us-ascii?q?Kca/UmnCNL6WnWQrGSF+xIRRddUO+k78x2WjKTO7guVC3MHUjlZLts8u6ceS?=
 =?us-ascii?q?iYn21mHmNTBGG019rCIIVqS67yUsDX0MigYK0cLYCNCRgwAi/HjqYQhh1TKR?=
 =?us-ascii?q?9ZtF6mnptTwFXf7xDXihCw/gagDyM0GzaO2+XjZjD+24JvEVAg44kPQRG3Nx?=
 =?us-ascii?q?hh0bYi9bpGswVPb9/FFLZucCF6bsxA5d2K2+LhbSMjV0nSZGbBVWum9vaPdd?=
 =?us-ascii?q?myD2gV7RMx5sWm5pCubd4REuWkrfAMxJq7oYhewJhaP5kUAvdkKYyHCUEO+W?=
 =?us-ascii?q?KrpY+xC8EQqPY2NuijoU+dz?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A50ELeaAJr/gAkfjlHemg55DYdb4zR+YMi2?=
 =?us-ascii?q?TC1yhKJSC9Ffbo8/xG/c5rsCMc5wx7ZJhNo7q90ey7IE80lqQFg7X5X43SPz?=
 =?us-ascii?q?UO0VHARL2Kr7GD/9SKIULDH4BmuJuIP5IRNOHN?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CaAQCULyljAKxbkwENTYEJCYFGhH2?=
 =?us-ascii?q?EToJijjWLKpF6gWgLAVMEAQGFBQKEayY3Bg4BAgQVAQEGAQEBAQEHBBABOVK?=
 =?us-ascii?q?MOAEBAQMjVhALDQcEAgImAgIhNgYOBYJ9gm4Dq2l6gTEaZ4cpDWeBZYERLYF?=
 =?us-ascii?q?lhRmEaYQ8N4FVRIEVJw8Ngmc+giCCAgEBBxmDVjiCLgSEBZR3OAMaKx1BAwt?=
 =?us-ascii?q?CNBgDFAMFJAcDGQ8jDQ0EFgcMAwMFJQMCAhsHAgIDAgYTBQICTTgIBAgEKyQ?=
 =?us-ascii?q?PBQIHLwUELwIeBAUGEQgCFgIGBAQEBBUCEAgCCCYXBxMYGxkBBVkQCSEcDho?=
 =?us-ascii?q?NBQYTAwoWbwUKOw8oMmsrHRsKgQwqKBUDBAQDAgYTAwMiAhAqMRQEKRMSLQc?=
 =?us-ascii?q?rcwkCAyIEYwUDAwQoLAMJQAcoJjwHWDoBBAMDECI9BgMJAwIkWnk3ExUFAw0?=
 =?us-ascii?q?ZJggFIxYdBAg8AgUGmiSBFYE+BJQjCpBhnW86NAeDWYFBBgyYW4YJIwuDdox?=
 =?us-ascii?q?QhksDjAGFb5Q0glaEA40cmD2BfzMaLm8BgjxRnShlAjkCBgsBAQMJin0BAQ?=
Received: from unknown (HELO [127.0.0.1]) ([1.147.91.172])
  by ipmail03.adl2.internode.on.net with ESMTP; 20 Sep 2022 12:44:42 +0930
Date:   Tue, 20 Sep 2022 12:44:25 +0930
From:   Arthur Marsh <arthur.marsh@internode.on.net>
To:     Alex Deucher <alexdeucher@gmail.com>
CC:     Xinhui.Pan@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, aurabindo.pillai@amd.com,
        christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        greenfoo@u92.eu, guchun.chen@amd.com, hamza.mahfooz@amd.com,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org
Subject: Re: [PATCH] drm/amdgpu: use dirty framebuffer helper
User-Agent: K-9 Mail for Android
In-Reply-To: <CADnq5_Py+dgAxa5Y1tzbWx6xRt1g2LQ1JsiJD6ewYYTzjjaPcw@mail.gmail.com>
References: <CADnq5_O0W-ipCCy3hsub5GwirjDTM76Xn3kAxgyZT5V+vDguSA@mail.gmail.com> <20220918120926.10322-1-user@am64> <CADnq5_Py+dgAxa5Y1tzbWx6xRt1g2LQ1JsiJD6ewYYTzjjaPcw@mail.gmail.com>
Message-ID: <EB4E527C-84AA-464D-9B14-CA8D9E116750@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, the patch applied against 6.0-rc6 kernel worked and the amdgpu module loaded and works on my Radeon R7 250 (Cape Verde) GPU.

Arthur Marsh. 

On 20 September 2022 2:03:54 am ACST, Alex Deucher <alexdeucher@gmail.com> wrote:
>On Sun, Sep 18, 2022 at 8:09 AM root <arthur.marsh@internode.on.net> wrote:
>>
>> Hi, I recently experienced lock-ups that only responded to magic sysreq
>> reboots when the amdgpu module was loading on my pc (Athlon II X4 640 CPU,
>> with Radeon R7 250 - Cape Verde).
>>
>> .config has:
>>
>> CONFIG_DRM_AMDGPU=m
>> CONFIG_DRM_AMDGPU_SI=y
>> # CONFIG_DRM_AMDGPU_CIK is not set
>> # CONFIG_DRM_AMDGPU_USERPTR is not set
>>
>> kernel command line has:
>>
>> amdgpu.audio=1 amdgpu.si_support=1 radeon.si_support=0 page_owner=on \
>> amdgpu.gpu_recovery=1
>>
>> Bisecting lead to:
>>
>> commit 66f99628eb24409cb8feb5061f78283c8b65f820
>> Author: Hamza Mahfooz <hamza.mahfooz@amd.com>
>> Date:   Tue Sep 6 15:01:49 2022 -0400
>>
>>     drm/amdgpu: use dirty framebuffer helper
>>
>>     Currently, we aren't handling DRM_IOCTL_MODE_DIRTYFB. So, use
>>     drm_atomic_helper_dirtyfb() as the dirty callback in the amdgpu_fb_funcs
>>     struct.
>>
>>     Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>>     Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> index c20922a5af9f..5b09c8f4fe95 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> @@ -38,6 +38,7 @@
>>  #include <linux/pci.h>
>>  #include <linux/pm_runtime.h>
>>  #include <drm/drm_crtc_helper.h>
>> +#include <drm/drm_damage_helper.h>
>>  #include <drm/drm_edid.h>
>>  #include <drm/drm_gem_framebuffer_helper.h>
>>  #include <drm/drm_fb_helper.h>
>> @@ -496,6 +497,7 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
>>  static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
>>         .destroy = drm_gem_fb_destroy,
>>         .create_handle = drm_gem_fb_create_handle,
>> +       .dirty = drm_atomic_helper_dirtyfb,
>>  };
>>
>>  uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>>
>> After doing a git bisect reset, git pull and reverting the patch above, I
>> rebuilt the kernel and am successfully running with the amdgpu module loaded
>> and using the Radeon R7 250 GPU.
>>
>> I am happy to supply any further configuration details.
>
>Does the attached patch help?
>
>Alex
>
>
>>
>> Arthur Marsh.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
