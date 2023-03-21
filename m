Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783856C34C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjCUOwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjCUOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:52:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9379C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=70/OM02lQCra3OnSiPxk9Khoao4iKy6odWQlLyOQNu4=; b=ZpcL6QEIcMhbm4WXXOwK+09043
        /v0WK/Bc4OVkq767sNF5M+jK/nT8vJVVZ1KXgQJywvRkOtHfMxZHbT+Ilm4+8wF64xTQqWZEhnrIq
        i6rkrHnHHZgRwR0VorFZjI614OOtDl/TS+ljL58uEc9Wbl+6owK9ytEgjAVcRKfmdBrRO7oC4JwtF
        KXy1I6W8jeplmj/XnTDulCnT1JZQu0NMdOaH9v/NqXjyKk/bQGohnHYuXJz3t42gYGiD4uf4ZJt1T
        rYj6cAJxS5GuzyX3JGM2ruYmOBrjZUuuFtxtoXx3/YbLF9iGtdv5SZNIVHYzlO+K0xa2/Bac+VvkZ
        BhtH+9jg==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pedL9-00CoOf-2L;
        Tue, 21 Mar 2023 14:51:55 +0000
Message-ID: <6515b323-59ed-5524-846e-90782654259f@infradead.org>
Date:   Tue, 21 Mar 2023 07:51:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/37] drm/vkms/vkms_composer: Fix a few different
 kerneldoc formatting
Content-Language: en-US
To:     Melissa Wen <mwen@igalia.com>
Cc:     Lee Jones <lee@kernel.org>, dri-devel@lists.freedesktop.org,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        linux-kernel@vger.kernel.org, Melissa Wen <melissa.srw@gmail.com>
References: <20230317081718.2650744-1-lee@kernel.org>
 <20230317081718.2650744-7-lee@kernel.org>
 <20230320234639.va6an7gton3u6eke@mail.igalia.com>
 <23fe0765-fb3b-9bf4-ecb4-507e6f3edefe@infradead.org>
 <20230321094940.ndf5nhvfr2y67d3x@mail.igalia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230321094940.ndf5nhvfr2y67d3x@mail.igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/23 02:49, Melissa Wen wrote:
> O 03/20, Randy Dunlap wrote:
>>
>>
>> On 3/20/23 16:46, Melissa Wen wrote:
>>> On 03/17, Lee Jones wrote:
>>>> Fixes the following W=1 kernel build warning(s):
>>>>
>>>>  drivers/gpu/drm/vkms/vkms_composer.c:41: warning: Function parameter or member 'frame_info' not described in 'pre_mul_alpha_blend'
>>>>  drivers/gpu/drm/vkms/vkms_composer.c:41: warning: Excess function parameter 'src_frame_info' description in 'pre_mul_alpha_blend'
>>>>  drivers/gpu/drm/vkms/vkms_composer.c:72: warning: Cannot understand  * @wb_frame_info: The writeback frame buffer metadata
>>>>
>>>> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
>>>> Cc: Melissa Wen <melissa.srw@gmail.com>
>>>> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
>>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>>> Cc: David Airlie <airlied@gmail.com>
>>>> Cc: dri-devel@lists.freedesktop.org
>>>> Signed-off-by: Lee Jones <lee@kernel.org>
>>>> ---
>>>>  drivers/gpu/drm/vkms/vkms_composer.c | 6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
>>>> index 8e53fa80742b2..41668eedf4272 100644
>>>> --- a/drivers/gpu/drm/vkms/vkms_composer.c
>>>> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
>>>> @@ -22,7 +22,7 @@ static u16 pre_mul_blend_channel(u16 src, u16 dst, u16 alpha)
>>>>  
>>>>  /**
>>>>   * pre_mul_alpha_blend - alpha blending equation
>>>> - * @src_frame_info: source framebuffer's metadata
>>>> + * @frame_info: source framebuffer's metadata
>>>>   * @stage_buffer: The line with the pixels from src_plane
>>>>   * @output_buffer: A line buffer that receives all the blends output
>>>>   *
>>>> @@ -69,11 +69,13 @@ static void fill_background(const struct pixel_argb_u16 *background_color,
>>>>  }
>>>>  
>>>>  /**
>>>> - * @wb_frame_info: The writeback frame buffer metadata
>>>> + * blend
>>> As we are already here:
>>> * blend - blend pixels from a given row and calculate crc
>>
>>  * blend: blend pixels from a given row and calculate CRC
>>
>> preferably.
> 
> Hmm.. I didn't get the colon suggestion. This first line is a brief
> description of the function blend(), so I understand that a more
> accurate doc standard is:
> 
> blend() - Blend pixels from a given row and calculate crc
> 

You are correct. My bad. Sorry for the noise.

> 
>>
>>> Reviewed-by: Melissa Wen <mwen@igalia.com>
>>>
>>>> + * @wb: The writeback frame buffer metadata
>>>>   * @crtc_state: The crtc state
>>>>   * @crc32: The crc output of the final frame
>>>>   * @output_buffer: A buffer of a row that will receive the result of the blend(s)
>>>>   * @stage_buffer: The line with the pixels from plane being blend to the output
>>>> + * @row_size: Size of memory taken up by row data (line_width * pixel_size)
>>>>   *
>>>>   * This function blends the pixels (Using the `pre_mul_alpha_blend`)
>>>>   * from all planes, calculates the crc32 of the output from the former step,
>>>> -- 
>>>> 2.40.0.rc1.284.g88254d51c5-goog
>>>>
>>
>> -- 
>> ~Randy

-- 
~Randy
