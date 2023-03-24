Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A436C85A8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjCXTNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCXTNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:13:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FACD1E5CE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:13:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y14so2820646wrq.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679685200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDkUXRm6ebBc/QHvz8cNntbon0PvzQ0AKnhQ2g7v5QA=;
        b=rooZAbRs2MFRJmiyw+SXReNh5WT1x8mEzMt14Bke64nSL7GDOGC+bbvjDW7K5GiVCT
         S7solNiEwVIk509smEZzokLht2sB6pDN614z/HcVs7KTMahyKyKpI2Nj2+sK5t2+WthW
         Tzdd7p0p/fAFEsBJDnIuLGXFq+yRxxsIs2Rp7NbfKKL02wQHoE9ZJbMGoBm/jFB6Jdq9
         peNmE8zjqXILzRM9XObFaNbDh0SStjpKqIbNHhBg08pbvu8/+A6+8fWPvsJ3UT9V6CuY
         ERMSZXGDohg7QP192lyoGs9mwA70895/dvF04FCA28cOz3gpz5szx7c2E0bdMCtKDd/n
         FhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679685200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDkUXRm6ebBc/QHvz8cNntbon0PvzQ0AKnhQ2g7v5QA=;
        b=kBy/JziG25gXtdO+vFJBC9B5/f1FVa39/7zUgktArFdDXqkTSqodRpUTjDbdmGNAI1
         NChFe5J6lRFyV9aawpta5TlQbTyAJ8udgJGHt1xu22pOOpJ1l5r6hqhXfIzvSZlQPrOd
         jxFOsUSu1enEkp5dEYTKAAA9Z92Ve9CDRZfU/+xPURNRxY5A6S+Z6tOF093dle0JGu2v
         xKngbes5JRksNwQjMATpXlTZWcdriZE9oWGhMplBqAQ5AufFZrQzeSUCtIC9KIO0U7OE
         7hkKrntygR0VU08uHZEYGoryHDCMtgHiYIS0HnGK4o9++Obkk6gZDPC/saxp6lxU2CcA
         SypA==
X-Gm-Message-State: AAQBX9cgiVIs0CDOAs2uC9lVDUt+ZfkgHqwlKNE5uO8uLzilxIMwHxqo
        d85ZM03O+XgK2GAkAuHs/f5Z4w==
X-Google-Smtp-Source: AKy350YHCF5U9GYrRAZFMNkr/n6h0lYGicNAZN7Hv0BODu2wqpIsKo8emK19gJHVRUVjHbfF+4Lv9w==
X-Received: by 2002:a5d:538a:0:b0:2cf:f454:95d2 with SMTP id d10-20020a5d538a000000b002cff45495d2mr2808206wrv.12.1679685200010;
        Fri, 24 Mar 2023 12:13:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:537:dd40:8b9b:575d? ([2a01:e0a:982:cbb0:537:dd40:8b9b:575d])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6802000000b002cfe687fc7asm18883280wru.67.2023.03.24.12.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 12:13:19 -0700 (PDT)
Message-ID: <fb2d333e-c459-f394-a299-533083b83596@linaro.org>
Date:   Fri, 24 Mar 2023 20:13:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] drm/panel-edp: Add B133UAN01.0 edp panel entry
Content-Language: en-GB
To:     Doug Anderson <dianders@chromium.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20230324165909.131831-1-vkoul@kernel.org>
 <CAD=FV=UJepzmKczemVGB8NacjyvLDqXiRoc81s1tJ=u5+HAeqg@mail.gmail.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <CAD=FV=UJepzmKczemVGB8NacjyvLDqXiRoc81s1tJ=u5+HAeqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/03/2023 à 18:04, Doug Anderson a écrit :
> Hi,
> 
> On Fri, Mar 24, 2023 at 9:59 AM Vinod Koul <vkoul@kernel.org> wrote:
>>
>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>> This panel is found in Lenovo Flex 5G laptop, so add the entry for it
>>
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>> ---
>>   drivers/gpu/drm/panel/panel-edp.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> ...assuming nothing distracts me, I'll plan to land this Monday to
> drm-misc-next.

If you get distracted, I'll apply it!

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
