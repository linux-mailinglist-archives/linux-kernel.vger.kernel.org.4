Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF65669518
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbjAMLNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240463AbjAMLMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:12:39 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ECA167FE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:06:29 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso12746945wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=baUaOu9qP5RXCY+qNKVUaTtZhgFMNu4zdAgDA96eroc=;
        b=ALtzJ+I3+Muk1YK3hL0wvctWAGMfq3YL1bXKFM4wRo2Xp1DyByr4pYxbEoReVRDhER
         AuTUaPjEBGaNH0keGjK3RmgQzxOJtjdUM8Tw9v8mhOEetCV5G7AREtaasHFibidNcdoz
         GoYgDC1ox99KIxbYC8myPW/LJBNQ4t2FT1/OCDBBuW9CCM3kIcUGaAcwmmbYQ4LzWmEv
         2TFqePHhKgDJy1/BmLT4Uiczv46mKz5UE49DX2FAnhwklmqSH6W0EuhekQNMTIosWwZG
         ZPT/Po7birPfRabkdf9sk3axZq7i4VAQJhUgbv5KHoXxj+rcwxTKYmzkOrq/wvYuzB8U
         /IYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baUaOu9qP5RXCY+qNKVUaTtZhgFMNu4zdAgDA96eroc=;
        b=y3Q2A0aWeMSzsJe23qiQqGeGrpdKRCHChyOoZcyLWMt0z2tHmLJz/tf4U0vigf6WTB
         yGbKxuoCikRdinXkjthQBChYLUqsF/vPCPrFFS46uUGxxtTvRBfxYazxDQg8cq2blW/V
         wKTsZs2uk3aYXfp4pdW98fcdJhJZ2Y+teBMaRRHTVdox/Nwtns0FlFDqKmr21m2YunrN
         LUPfVO84HhSsqv8RpzpkEIJoqYQD4ir4LFCMdUqtGyMLXB/pp7aRRLmvW5tsB/k5UmZt
         d/gH7bqsRda0a40SOEX0aZSzb6d9qVrWRva934gHo1/2hxJMGu+BXIjiWWk5u/WIYoQO
         SghA==
X-Gm-Message-State: AFqh2kqnDGtDIEsohvlO5S6mDu6l0W1XdUppgxCupa3GjfdiPL8AGjLL
        YxMuSo/xeiwD1smRghImv3g=
X-Google-Smtp-Source: AMrXdXs9NaNsyb4zGRdAf7rmsXjTJE347Gie0wJOE/NQTFjr4ARkg1Igb7ii7i5eTLK0gDgZNJnRuw==
X-Received: by 2002:a05:600c:3550:b0:3d9:ed30:6a73 with SMTP id i16-20020a05600c355000b003d9ed306a73mr15217554wmq.9.1673607987538;
        Fri, 13 Jan 2023 03:06:27 -0800 (PST)
Received: from [0.0.0.0] ([134.134.139.85])
        by smtp.googlemail.com with ESMTPSA id j18-20020a05600c191200b003d9dee823a3sm26796714wmq.5.2023.01.13.03.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 03:06:27 -0800 (PST)
Message-ID: <cb28a1e1-b9fb-a4a2-9b03-47bb34b16aa1@gmail.com>
Date:   Fri, 13 Jan 2023 13:06:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: juhapekka.heikkila@gmail.com
Subject: Re: [Intel-gfx] [PATCH] drm/i915/display: Check source height is > 0
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Drew Davenport <ddavenport@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Juha-Pekka_Heikkil=c3=a4?= 
        <juha-pekka.heikkila@intel.com>
References: <20221226225246.1.I15dff7bb5a0e485c862eae61a69096caf12ef29f@changeid>
 <Y8BRUwiznxA/tns7@intel.com>
Content-Language: en-US
From:   Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
In-Reply-To: <Y8BRUwiznxA/tns7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.1.2023 20.28, Ville Syrjälä wrote:
> On Mon, Dec 26, 2022 at 10:53:24PM -0700, Drew Davenport wrote:
>> The error message suggests that the height of the src rect must be at
>> least 1. Reject source with height of 0.
>>
>> Signed-off-by: Drew Davenport <ddavenport@chromium.org>
>>
>> ---
>> I was investigating some divide-by-zero crash reports on ChromeOS which
>> pointed to the intel_adjusted_rate function. Further prodding showed
>> that I could reproduce this in a simple test program if I made src_h
>> some value less than 1 but greater than 0.
>>
>> This seemed to be a sensible place to check that the source height is at
>> least 1. I tried to repro this issue on an amd device I had on hand, and
>> the configuration was rejected.
>>
>> Would it make sense to add a check that source dimensions are at least 1
>> somewhere in core, like in drm_atomic_plane_check? Or is that a valid
>> use case on some devices, and thus any such check should be done on a
>> per-driver basis?
>>
>> Thanks.
>>
>>   drivers/gpu/drm/i915/display/skl_universal_plane.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
>> index 4b79c2d2d6177..9b172a1e90deb 100644
>> --- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
>> +++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
>> @@ -1627,7 +1627,7 @@ static int skl_check_main_surface(struct intel_plane_state *plane_state)
>>   	u32 offset;
>>   	int ret;
>>   
>> -	if (w > max_width || w < min_width || h > max_height) {
>> +	if (w > max_width || w < min_width || h > max_height || h < 1) {
> 
> I liked this one best so pushed to drm-intel-next with cc:stable. Thanks.
> 
> In the future we might want to move some of these checks to an earlier
> spot to make sure we don't hit any other weird issues in some other
> code, but for the moment I think this will do.
> 

Look ok to me. Tests which I had written to try different ways to cause 
this issue are now returning einval as expected. I'll polish my igt test 
for this issue and send it out bit later.

/Juha-pekka

>>   		drm_dbg_kms(&dev_priv->drm,
>>   			    "requested Y/RGB source size %dx%d outside limits (min: %dx1 max: %dx%d)\n",
>>   			    w, h, min_width, max_width, max_height);
>> -- 
>> 2.39.0.314.g84b9a713c41-goog
> 

