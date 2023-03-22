Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235576C4838
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCVKu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjCVKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:50:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF197637C3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:49:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v25so13048737wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679482149;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DtazAy5ZBr6/UsaCHvXzNZIVTK1+Lw3Zmf5vXwd6UW8=;
        b=TeJU+m39p1LJTsyatJZX39zHQY+azvG5cNB8UkHlNt44ynGeVVujIZrl1EbqcjHMP3
         xwfy6kRQhgzl+XoZz0K9ffDNFk15ChYBWcYMhzPAgtn0kj1noxnOhfm+UGC8aUtLWc4Y
         NtYTc/oKxM90c65mGj2nijp0fn7SClIZ4RUS3pwBNx3QWQVldxY5ZtKM3jfdSGmF8b7a
         5rZM1LNndashS/11eHwMWg424JDkSbJhTW/Jk2nlctZzevEdYCh2QmTUBq6DCJ7J5eaq
         5QxvyPvOOk82QyWVE6vJBb7WzgujXkNbGw0IqXj+9QpFwPGO55s8ELTj/SC4Jq1r/jQQ
         lvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679482149;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtazAy5ZBr6/UsaCHvXzNZIVTK1+Lw3Zmf5vXwd6UW8=;
        b=Gkke7Lo9FIsZcLyEt+TAoACO9YnfhfXcMKu6fuaCfu7RZtJLYTCqh8iSBjNTO7RRyj
         kpedbloMm8PjiPXUt927+142sXbKwSpq81YugM1IlajuCvYWsq9gJqcw6X2bQvOtqxm3
         abrLhmW1YTllsMsI6NYDrOOMFH+pwGmo08c1tele2xBcL5alCgFgm+5yJdXYiZyaxxcw
         D75CtHmwEfUadnd+k54qUjkEMwelr6x3M54kyOvcNK/f1XPve4rckM1xQQWj3wOzicpo
         hWTnNJq9L1KroFmIZjQdwgp5RJu/l6XkvIA6evOyjgKMr1jeRislgo3GaUKx3y2zGay4
         Q9mw==
X-Gm-Message-State: AO0yUKXYxNCecjP6yMQpp9J2tRI1XLtbPms4E/rU4+rU28fQzO2+4utN
        63XJZZRRoAqIrTFAIM+ELN+Rgw==
X-Google-Smtp-Source: AK7set+2D6IK/mOn0v0700qQcCXrBEpJ6MI97aLA0wGLOC01QTc21OkrUob9mXzfNg7l2i80ksL3eQ==
X-Received: by 2002:a5d:56d2:0:b0:2d7:452f:79ec with SMTP id m18-20020a5d56d2000000b002d7452f79ecmr5062020wrw.7.1679482149187;
        Wed, 22 Mar 2023 03:49:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3606:a601:f273:994a? ([2a01:e0a:982:cbb0:3606:a601:f273:994a])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d4d52000000b002d1e49cff35sm13549283wru.40.2023.03.22.03.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 03:49:08 -0700 (PDT)
Message-ID: <b669be41-0b8e-6f69-2aeb-a79334a90e94@linaro.org>
Date:   Wed, 22 Mar 2023 11:49:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: Fix panel mode type setting logic
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Jianhua Lu <lujianhua000@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230314114451.8872-1-lujianhua000@gmail.com>
 <CAD=FV=X7K2KQoRCsr17kj-DWiPs7h_zfcYxK_cdBVnC0wR1NwA@mail.gmail.com>
 <ZBEJdX6WVZ3Kqdo0@Gentoo>
 <CAD=FV=VgWSvrpCdi2pRr0JctHxcq1-qNJSMAxEVva6nEnv3e_g@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAD=FV=VgWSvrpCdi2pRr0JctHxcq1-qNJSMAxEVva6nEnv3e_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/03/2023 01:23, Doug Anderson wrote:
> Hi,
> 
> 
> On Tue, Mar 14, 2023 at 4:55 PM Jianhua Lu <lujianhua000@gmail.com> wrote:
>>
>> On Tue, Mar 14, 2023 at 10:12:02AM -0700, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Tue, Mar 14, 2023 at 4:45 AM Jianhua Lu <lujianhua000@gmail.com> wrote:
>>>>
>>>> Some panels set mode type to DRM_MODE_TYPE_PREFERRED by the number
>>>> of modes. It isn't reasonable, so set the first mode type to
>>>> DRM_MODE_TYPE_PREFERRED. This should be more reasonable.
>>>>
>>>> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
>>>> ---
>>>>   drivers/gpu/drm/panel/panel-abt-y030xx067a.c     | 2 +-
>>>>   drivers/gpu/drm/panel/panel-auo-a030jtn01.c      | 2 +-
>>>>   drivers/gpu/drm/panel/panel-edp.c                | 4 ++--
>>>>   drivers/gpu/drm/panel/panel-innolux-ej030na.c    | 2 +-
>>>>   drivers/gpu/drm/panel/panel-newvision-nv3051d.c  | 2 +-
>>>>   drivers/gpu/drm/panel/panel-newvision-nv3052c.c  | 2 +-
>>>>   drivers/gpu/drm/panel/panel-novatek-nt35950.c    | 2 +-
>>>>   drivers/gpu/drm/panel/panel-novatek-nt39016.c    | 2 +-
>>>>   drivers/gpu/drm/panel/panel-orisetech-ota5601a.c | 2 +-
>>>>   drivers/gpu/drm/panel/panel-seiko-43wvf1g.c      | 4 ++--
>>>>   drivers/gpu/drm/panel/panel-simple.c             | 4 ++--
>>>>   11 files changed, 14 insertions(+), 14 deletions(-)
>>>
>>> Can you explain more about your motivation here? At least for
>> This demonstrates a bad way to set DRM_MODE_TYPE_PREFERRED for panels
>> with more than one mode. It mislead the future contributors to send
>> a patch with this piece of code. There is also a discussion for it.
>> https://lore.kernel.org/lkml/904bc493-7160-32fd-9709-1dcb978ddbab@linaro.org/
>>> panel-edp and panel-simple it seems like it would be better to leave
>>> the logic alone and manually add DRM_MODE_TYPE_PREFERRED to the right
>>> mode for the rare panel that actually has more than one mode listed.
>> I think we can order it to the first mode if the mode type should be
>> DRM_MODE_TYPE_PREFERRED, It's also same.
> 
> A pointer to the original discussion would have been super helpful to
> be provided in your patch description.
> 
> Personally, I still stand by my assertion that I'd rather that
> DRM_MODE_TYPE_PREFERRED be placed in the actual data instead of being
> done like this in post-processing. To me the old check for "num_modes
> == 1" is basically saying that the people creating the "static const"
> data in this file were lazy and didn't feel like they needed to set a
> DRM_MODE_TYPE_PREFERRED when there was only one mode listed. Thus, we
> can add it for them. When "num_modes" is more than 1 then we shouldn't
> allow the people making the "static const" data to be lazy. We should
> force them to set one of the modes to be PREFERRED rather than for
> them to have to know about this magic rule.
> 
> Thus, for me, my order of preference would be these (note, I've mostly
> looked at panel-edp and panel-simple):
> 
> 1. Leave the check as "num_modes == 1" and document that we're
> basically allowing the people writing the "static const" structure to
> be lazy if there's only one mode. Manually add the
> DRM_MODE_TYPE_PREFERRED flag to the small number of cases where there
> is more than one mode. Possibly add a warning printout if we end up
> without a PREFERRED mode. I'd give a Reviewed-by for this.
> 
> 2. Fully get rid of this logic and add DRM_MODE_TYPE_PREFERRED to all
> of the "static const" data. I guess maybe we can't do that for the
> "timings" in panel-edp and panel-simple. I guess for those I'd be OK
> with just setting PREFERRED on the first timing like your patch is
> doing. I'd give a Reviewed-by for this.
> 
> 3. Your patch. I won't NAK it since it seems like this is what other
> (more senior) DRM folks were suggesting. ...but I don't love it. I
> won't give a Reviewed-by for this but won't object to someone else
> doing so.

I'm aligned with Doug's analysis, I don't have a strong opinion on
what to do, but 1 or 2 would be OK.

Neil

> 
> -Doug

