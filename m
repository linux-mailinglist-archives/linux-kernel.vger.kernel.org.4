Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB4B5F532C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJELNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJELM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:12:59 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E66F5853C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 04:12:58 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id ay36so10557001wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 04:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=t1ThCMtIlOl2e97/yXK+5iHjNgmjBxSye7iwzGPGngs=;
        b=7/KMdWIXFvGcOi3wh9myJCKiToAc0J/q9QJUintmi2T1YBcR/bmDDX1hlVD4SHRBo0
         Vk7aTKELGaGVnejSMQhz3BMtUGQuQSE4WtEiFpY4foqgumI1XiuPgBOoDUA6l24B9Br6
         8W3/M0W6BxzveGxYuy39v2IK8PpNetKjATWX1G6xVJdqOh6VJEea9TO9l5vZ97cxivQW
         cqLZB7tiH4hkbLmD3dsF6r6haVrjoI5D7Yhj2WbI9YUvaktPX6WHcofi3JQOrG+tiEjn
         5kIDVR7pWDEVcMR27CCbDVKbAinOXJDj1ssYnOv1H1wNtOvIfucRWwPcy99kn2vWgV+g
         gVtw==
X-Gm-Message-State: ACrzQf2cfe18aK8ZXhaBzrvM7Kh+xbZmKM900jHReiIirElMyca+tKN5
        jM4OQ6nB3/pI/mJtTwE37bxQvAOma40hHg==
X-Google-Smtp-Source: AMsMyM73x5uaR1ERkn+qLdJBUt1pb+jaKAOV2fib5CFUsrIiqVGRyw4g5sJOjQS0m+GGqdda+mE1CQ==
X-Received: by 2002:a05:600c:214e:b0:3b4:709b:b0d with SMTP id v14-20020a05600c214e00b003b4709b0b0dmr3027359wml.4.1664968376613;
        Wed, 05 Oct 2022 04:12:56 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b003b4a68645e9sm1647697wmo.34.2022.10.05.04.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 04:12:55 -0700 (PDT)
Message-ID: <4f54267f-a643-348c-ad71-4745e86d7fe1@kernel.org>
Date:   Wed, 5 Oct 2022 13:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] drm/i915/display: fix randconfig build
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
References: <20221004102837.12181-1-jirislaby@kernel.org>
 <87mtabuahz.fsf@intel.com>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <87mtabuahz.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 10. 22, 12:52, Jani Nikula wrote:
> On Tue, 04 Oct 2022, "Jiri Slaby (SUSE)" <jirislaby@kernel.org> wrote:
>> When DRM_I915=y and BACKLIGHT_CLASS_DEVICE=m, the build fails:
>> ld: drivers/gpu/drm/i915/display/intel_backlight.o: in function `intel_backlight_device_register':
>> intel_backlight.c:(.text+0x5587): undefined reference to `backlight_device_get_by_name'
>>
>> ld: drivers/gpu/drm/i915/display/intel_backlight.o: in function `intel_backlight_device_unregister':
>> intel_backlight.c:(.text+0x576e): undefined reference to `backlight_device_unregister'
>>
>> To fix this, use IS_REACHABLE(), not IS_ENABLED() in backlight. That is,
>> with the above config, backlight support is disabled.
> 
> So I don't want this. I'll take a patch that fixes the dependencies to
> block DRM_I915=y and BACKLIGHT_CLASS_DEVICE=m. Nobody wants that combo,
> and IMO using IS_REACHABLE() is a workaround to hide a broken config
> under the carpet.
> 
> The right thing to do is
> 
> config DRM_I915
> 	depends on BACKLIGHT_CLASS_DEVICE || BACKLIGHT_CLASS_DEVICE=n.
> 
> We're selecting BACKLIGHT_CLASS_DEVICE because almost everyone else is
> too, and a combo of selecting and depending leads to circular
> dependencies. But depending is the right fix.

I'm not sure what should I do now. If I do:
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -4,6 +4,7 @@ config DRM_I915
         depends on DRM
         depends on X86 && PCI
         depends on !PREEMPT_RT
+       depends on (BACKLIGHT_CLASS_DEVICE && ACPI) || 
(BACKLIGHT_CLASS_DEVICE=n && ACPI=n)
         select INTEL_GTT if X86
         select INTERVAL_TREE
         # we need shmfs for the swappable backing store, and in particular
@@ -21,7 +22,6 @@ config DRM_I915
         select IRQ_WORK
         # i915 depends on ACPI_VIDEO when ACPI is enabled
         # but for select to work, need to select ACPI_VIDEO's 
dependencies, ick
-       select BACKLIGHT_CLASS_DEVICE if ACPI
         select INPUT if ACPI
         select X86_PLATFORM_DEVICES if ACPI
         select ACPI_WMI if ACPI

I get:
drivers/gpu/drm/i915/Kconfig:2:error: recursive dependency detected!
drivers/gpu/drm/i915/Kconfig:2: symbol DRM_I915 depends on 
BACKLIGHT_CLASS_DEVICE
drivers/video/backlight/Kconfig:143:    symbol BACKLIGHT_CLASS_DEVICE is 
selected by DRM_FSL_DCU
drivers/gpu/drm/fsl-dcu/Kconfig:2:      symbol DRM_FSL_DCU depends on 
COMMON_CLK
drivers/clk/Kconfig:21: symbol COMMON_CLK is selected by X86_INTEL_QUARK
arch/x86/Kconfig:633:   symbol X86_INTEL_QUARK depends on 
X86_PLATFORM_DEVICES
drivers/platform/x86/Kconfig:6: symbol X86_PLATFORM_DEVICES is selected 
by DRM_I915


Those dependencies are really cumbersome :/.

> Documentation/kbuild/kconfig-language.rst:
> 
>    Note:
> 	select should be used with care. select will force
> 	a symbol to a value without visiting the dependencies.
> 	By abusing select you are able to select a symbol FOO even
> 	if FOO depends on BAR that is not set.
> 	In general use select only for non-visible symbols
> 	(no prompts anywhere) and for symbols with no dependencies.
> 	That will limit the usefulness but on the other hand avoid
> 	the illegal configurations all over.
> 
> 
> BR,
> Jani.
> 
>>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: intel-gfx@lists.freedesktop.org
>> Cc: dri-devel@lists.freedesktop.org
>> Reported-by: Martin Liška <mliska@suse.cz>
>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>> ---
>>   drivers/gpu/drm/i915/display/intel_backlight.c | 2 +-
>>   drivers/gpu/drm/i915/display/intel_backlight.h | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
>> index beba39a38c87..c1ba68796b6d 100644
>> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
>> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c
>> @@ -825,7 +825,7 @@ void intel_backlight_enable(const struct intel_crtc_state *crtc_state,
>>   	mutex_unlock(&dev_priv->display.backlight.lock);
>>   }
>>   
>> -#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
>> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
>>   static u32 intel_panel_get_backlight(struct intel_connector *connector)
>>   {
>>   	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
>> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.h b/drivers/gpu/drm/i915/display/intel_backlight.h
>> index 339643f63897..207fe1c613d8 100644
>> --- a/drivers/gpu/drm/i915/display/intel_backlight.h
>> +++ b/drivers/gpu/drm/i915/display/intel_backlight.h
>> @@ -36,7 +36,7 @@ u32 intel_backlight_invert_pwm_level(struct intel_connector *connector, u32 leve
>>   u32 intel_backlight_level_to_pwm(struct intel_connector *connector, u32 level);
>>   u32 intel_backlight_level_from_pwm(struct intel_connector *connector, u32 val);
>>   
>> -#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
>> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
>>   int intel_backlight_device_register(struct intel_connector *connector);
>>   void intel_backlight_device_unregister(struct intel_connector *connector);
>>   #else /* CONFIG_BACKLIGHT_CLASS_DEVICE */
> 

-- 
js
suse labs

