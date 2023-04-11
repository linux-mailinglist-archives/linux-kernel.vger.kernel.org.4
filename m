Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB75C6DD975
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDKLeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDKLef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:34:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C45AE6E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:34:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so7674170pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681212873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFRxSw9GeugoPYgmgMFweC9gPDBVJGBlRNHmGv0SMrU=;
        b=BorMPk/Ttj6K4aCWnKR2l1ESJzaSE6yu0sztIjN2B+Be3+yl8t+Cx3Qqq9q6pZJEUH
         dLAAJ2wmTBpVgu2ZFISuZ2LS5VGbwgI6L8iGcj88fll2Ja8tD1W1JvYD4pNM6HRYRIa6
         KNM9zTyUH0XN2BsgOqjN5xuAAbbkyAIlnco2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681212873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFRxSw9GeugoPYgmgMFweC9gPDBVJGBlRNHmGv0SMrU=;
        b=aMTejhznBk+OVIXrgklf+i3TZDmCgcXb+q///Rw4URHXOHAfdAXV9/aIDnahzav/ht
         N2FIDdsjgp++U1rDS5L5ysyxQGKlO8bU3Lw3++TQKkY0uoerzwGfQ4ensPTYWrzDUozh
         ABTpsrz7Y0qcgqGhbjy6sBgfwAwIVrtKIegD/WVDQTktzOsVLtBr/KTU/n2HwkwXJFnm
         ziQL1yRcgUtTufn6fFRCvJhW+APLNFjJzMb8l5mqVvwWUSh/y0xIRazJG3uhETwmal2g
         kLf/fpHB19Wj0BFcaPF0rar2EggV1hO6N8LmzNe+HS95PPUacQPyWVAnUEX/h16hC2st
         l8qw==
X-Gm-Message-State: AAQBX9dU8xR7h5K42QReZ3XRJ6syNTIf8rb3NsfZFZkaviFJ++UwG1oh
        WljhTmcM7492dMiNw1/7frTFCw==
X-Google-Smtp-Source: AKy350YRHfT7dgJFe4ii+u0kDT7yLZE4Jh7HFrmkVjNFP/nzrurZe8GOm5Vy+ihBm7agrdBarB72UA==
X-Received: by 2002:a17:902:e892:b0:199:4be8:be48 with SMTP id w18-20020a170902e89200b001994be8be48mr16066526plg.19.1681212873496;
        Tue, 11 Apr 2023 04:34:33 -0700 (PDT)
Received: from ?IPV6:2401:fa00:8f:203:44a9:ac98:7606:2cd0? ([2401:fa00:8f:203:44a9:ac98:7606:2cd0])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902748400b001a52eadb3e1sm5350540pll.152.2023.04.11.04.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 04:34:33 -0700 (PDT)
Message-ID: <8abf9651-5ce1-7b73-6d14-04f42081a743@chromium.org>
Date:   Tue, 11 Apr 2023 20:34:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] media: vivid: Add webcam parameter for (un)limited
 bandwidth
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
References: <20230410063356.3894767-1-mstaudt@chromium.org>
 <20230410102350.382f7d02@sal.lan>
 <6aafad18-13a2-ef45-48a1-1f094554af31@chromium.org>
 <6ee01cf1-5a8b-081f-e218-8c7da39343bc@xs4all.nl>
 <c6d5be4c-42c9-b8fa-fbd7-108c5da694bc@chromium.org>
 <5649adcd-3afe-e413-2eac-a92c78427dc9@xs4all.nl>
From:   Max Staudt <mstaudt@chromium.org>
In-Reply-To: <5649adcd-3afe-e413-2eac-a92c78427dc9@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 16:45, Hans Verkuil wrote:
>> Do I understand you correctly, are you suggesting to simply update the FPS limits to a new fixed schema, and not have an option at all?
> 
> Correct.
> 
> The ideal solution is indeed proper bandwidth calculations, since this would
> be a proper emulation of actual webcam hardware. If you have time and are
> interested in doing the work, then that would be great, of course.

My patch suggestion is motivated by a test which expects higher FPS 
rates at large frame sizes than vivid currently provides.

If I have a choice, then let's keep this patch simple ;)


> But if you just want to increase the fps limits to be more in line with
> modern webcams, then that's much quicker and should be fine.
> 
> It might also be interesting to perhaps allow for 120 fps for the low
> resolutions (below 720p).

Coincidentally, this would solve the problem we have at hand, but only 
until someone wants to see even higher frame rates, and then we'd 
revisit today's thread. Hence the idea for a parameter to simply unlock 
all rates, depending on whether a test needs a vivid webcam with low or 
high "performance".


My rationale behind the module parameter is twofold:

1. To allow for higher FPS without touching the kernel code again.
2. To stay backward compatible to previous behaviour of vivid. Changing 
the FPS formula would break this.


Actually I have a new idea: How about renaming my suggestion to 
"webcam_limit_enable" - this way, we can keep the current design with 
the boolean value: Not setting this value would default to "enabled" - 
i.e. vivid behaves as before. Disabling the limit unlocks all FPS at all 
sizes.

And later, should the need for a more precise simulation arise, we can 
add a second parameter "webcam_limit_value".

I've removed the "bandwidth" word from the new suggestions, so if a 
numeric limit is introduced, it can be anything, even an arbitrary 
number like the current "remove 2 FPS rates per size".


Please let me know what you think.

Max

