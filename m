Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA9167326E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjASH0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjASHZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:25:24 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08FC611EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:24:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso556893wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aEd8ywzEyZqNLP8z3RvHNAWRLYCIYe43IS8HvDJaJlU=;
        b=dovgD9io5K1IKRnUJXgbCsePY8SoKt2zeVtMeGplnip4hXjRluS3V1kRANIT/yg9Eh
         sBvas0MtKInpFh2WvZMDZGD3Wj1BFr6wtUaddPf0CgiIaKIYj7DW0nHgw07EPLwsLICA
         /YJBb7XqcbVOnF3fundG0IU6TrVXPde3WKeX5zV1BBcjDyrGFy3iM6D+D+uv7AiN+wqi
         UFVV7L5wtOQ9bysrRQeFGXT1XaepbkupuX35grDiBrzR3MWI2DbH9jw8T4ZcyPq+JZjJ
         70f+uvBQcl+lUsT19ZpiEMJIrIVxdTD6vWqmoSPygRyzbGsdnT77i+EAURw0pdHZ6C7w
         GRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEd8ywzEyZqNLP8z3RvHNAWRLYCIYe43IS8HvDJaJlU=;
        b=fxIEtF9FSYV+BB+8BC3Eb0cSoe5GkVDgg8eNr5X3/X9z6aJ//EhuEsi7oe9BqVaSO8
         /F/OnE7t9lw+4CYqjjQvWxHGdVqmon3PVOQCyrnOlWzOonO51ketSQBMB+H8AakxTId9
         toYyX3hrYn3qge+UH+E0GsE6aXGml39lhySubBYogv78mMHJ9K40lOm6htPlXF228c3z
         7EmvNeuv07YYuJbyoZ9IV5FJsR8CjeRl543M8CPkutFoaCVHmuTu4iNAZFRcxbNuaAUG
         jIxtY3wuYvUzM0+lpE9ynngjegqKTkfeJJqm79+rNGNHBKIfLPlvm5Nx4edONuuItw0F
         PICQ==
X-Gm-Message-State: AFqh2kqDExYhErvR0hysuKiXVHILpnI7K5FZCDvIYZlvghgUE6+pYcu8
        yhLvK8A3mUUzKmN0k3Iww4o4Aw==
X-Google-Smtp-Source: AMrXdXuTtMWRoLVJs60XnsQgHoSm9apaQuv0n+Pfe2Ca847eT4R/09muekNZk/GQTSH5iTPhPianFw==
X-Received: by 2002:a05:600c:4928:b0:3d3:4aa6:4fe6 with SMTP id f40-20020a05600c492800b003d34aa64fe6mr9323563wmp.3.1674113093343;
        Wed, 18 Jan 2023 23:24:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:3936:d49c:4a01:ee1e? ([2a01:e0a:982:cbb0:3936:d49c:4a01:ee1e])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c468f00b003d9b87296a9sm4032602wmo.25.2023.01.18.23.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 23:24:52 -0800 (PST)
Message-ID: <a7a9d6cc-3602-7a41-86a8-c8be564c4062@linaro.org>
Date:   Thu, 19 Jan 2023 08:24:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH v3 0/3] drm/mipi-dsi: 16-bit Brightness Endianness Fix
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>,
        Richard Acayan <mailingradian@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Mentz <danielmentz@google.com>,
        Caleb Connolly <caleb@connolly.tech>
References: <20230116224909.23884-1-mailingradian@gmail.com>
 <Y8jtucG3MMk8Oqk8@ravnborg.org>
Organization: Linaro Developer Services
In-Reply-To: <Y8jtucG3MMk8Oqk8@ravnborg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 08:14, Sam Ravnborg wrote:
> Hi Richard.
> On Mon, Jan 16, 2023 at 05:49:06PM -0500, Richard Acayan wrote:
>> Changes since v2 (20230114010006.50471-1-mailingradian@gmail.com):
>>   - patch vtdr6130 to use _large (3/3)
>>   - remove Change-Id again (1/3)
>>   - change patch subject (1-2/3)
>>   - correct function name in patch description (2/3)
>>   - add Tested-by tags (1-2/3)
>>
>> Changes since v1 (20230113041848.200704-1-mailingradian@gmail.com):
>>   - move 16-bit brightness handling to new functions and revert API
>>     change (1/2)
>>   - remove Change-Id in compliance with checkpatch.pl (1/2)
>>   - separate panel driver changes (2/2)
>>
>> This series adds proper support for 16-bit MIPI DSI brightness and
>> cleans up existing panel drivers with 16-bit brightness.
> 
> The series is:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Neil - I hope you can land this in drm-misc.

Sure, done !

Thanks,
Neil

> 
> 	Sam

