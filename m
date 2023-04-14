Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127C36E21D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjDNLM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDNLMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:12:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FA57698
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:12:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so7869602wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681470742; x=1684062742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SEnulhA5VA3I1e5UG7ov0nIRMdi2PjIGPK3ZiIECZ0Y=;
        b=hYaxh3J4LVdiZZ5grBlmO1PkwCItaOSHE9AcEhaKGDEXo6mHg6ZtWeai7jPoCYBCcu
         nQ2yfZAm6Pl75BLd+colZl5waBpHA5AVORT1OAUZXUrt1MoU0hIkd//gCfUq8xoLQKMx
         PXJZ962far8aZDjJgWE/Lst5AJVH47KAgPlrZ7p14WhwyGz2rXUENbUzR6cLN5ick+DK
         ICle8tBpEPheM+b4CHXSKgEfYuKGvgfKDeFLggzDiTFcV7MtDk1IOVxvqf5T5LK+eraR
         v0bxZYzJQcS2W9YG48YNsxEJTszWbalpBLhTAbukJ5VntykCnc0xmdemXf/p0qV9gfmI
         3cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470742; x=1684062742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEnulhA5VA3I1e5UG7ov0nIRMdi2PjIGPK3ZiIECZ0Y=;
        b=RfDYlDzLX012TFO3a/7a00/junMliKiP4mrHRyIImqFFf2lhlmsZsbueUNND+6RPzf
         UFYO41Dgg1PocZIEuontyAk5NNFk5Oh3l3gW3nqCa8IbVxE0d9LRkf23bi00msvilxOv
         yxVJI3qk0RMS8FpEeD+QC5RRmQH/fhZOJbzksEGkm0iKdZhq9UoKZrFEMKnAVjCx8LZj
         TK85rqlt9mMWkR/ZxlS3BRxJIzkCW9l2nK/G3pj0QOGy8eRvdRmKYmWZspuXnJd7QL/1
         677UFqvvF6bIh+E9xcfFBe0+lJ3allNOQ47Cew6Wa1MzkCB55qgXXz00cDt7OQKHmWmN
         rxCg==
X-Gm-Message-State: AAQBX9cyMpV/+Fta1tQDw60r4p6aEqxhpldxnSLEJygQ4rMc02ZQXpqz
        hGAoDhyD1oxxnhexp3OTpa9DNw==
X-Google-Smtp-Source: AKy350Y7QQKo8+o2lhPzSw/tJZXziB6QYAhasXiaK08d856PPVmWZGdiR+beC4O0oOyBfWYQd99BCw==
X-Received: by 2002:a1c:7209:0:b0:3f0:9565:3f3f with SMTP id n9-20020a1c7209000000b003f095653f3fmr4614563wmc.3.1681470742293;
        Fri, 14 Apr 2023 04:12:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7529:f7da:b8df:f1dd? ([2a05:6e02:1041:c10:7529:f7da:b8df:f1dd])
        by smtp.googlemail.com with ESMTPSA id c11-20020a7bc84b000000b003ed2384566fsm4098856wml.21.2023.04.14.04.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 04:12:21 -0700 (PDT)
Message-ID: <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org>
Date:   Fri, 14 Apr 2023 13:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V3] thermal/core/power_allocator: avoid thermal cdev can
 not be reset
Content-Language: en-US
To:     Di Shen <cindygm567@gmail.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, Di Shen <di.shen@unisoc.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, jeson.gao@unisoc.com, zhanglyra@gmail.com,
        orsonzhai@gmail.com, rui.zhang@intel.com, amitk@kernel.org,
        rafael@kernel.org
References: <20230320095620.7480-1-di.shen@unisoc.com>
 <6055bc39-5c00-d12f-b5c3-fa21a9649d63@arm.com>
 <CAHYJL4qL+nJuiN8vXGaiPQuuaPx6BA+yjRq2TRaBgb+qXi8-yw@mail.gmail.com>
 <637a3bb1-ba1c-e707-01b7-06c1358583ca@linaro.org>
 <CAHYJL4rnfVp+X3imbxWzUd9ixTFAPe4ioLyi-t50PwhL0y5v8A@mail.gmail.com>
 <da59b4ef-1532-1b3a-7a73-9a095d8c9390@linaro.org>
 <CAHYJL4qJwKHFsCPUvLzmUEAJtEfHDAO23D5=0zAXOYSCABJ8_g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAHYJL4qJwKHFsCPUvLzmUEAJtEfHDAO23D5=0zAXOYSCABJ8_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 10:40, Di Shen wrote:
> We have discussed this question in patch-v1:
> https://lore.kernel.org/all/f6aaa5f1-495d-a158-14d8-ddb2bffbd9c2@arm.com/
> 
> Simply put, we use the trip_temp in the Android System; set different
> trip_temp for thermal control of different scenarios.

The changes are dealing with the trip points and trying to detect the 
threshold. That part should be handled in the thermal core or thermal 
trip side, not in the governor.

AFAICT, if a trip point is changed, then the power allocator should be 
reset, including the cdev state.

It would be more convenient to add an ops to the governor ops structure 
to reset the governor and then call it when a trip point is changed in 
thermal_zone_set_trip()


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

