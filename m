Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C8B5BE043
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiITIeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiITId4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:33:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18032AC45
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:33:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o5so1356608wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DDvHFif3dFTR0CWMe4Ai+rYlHPHZLRltJS+vFmlP5No=;
        b=VXCTQifRXw6kfUxHtI7WbJnmbGYT+s3Ic+hzocExD/aDX1138mFGazPKzg7tZbTSXN
         x4o6AHOrLh9ds3yqSdLCO8UlOAYJ/4ra5YpvIFELCruCVr3jEXicKvkHtXRVEHAEGgEi
         TXfVW4tR89tx4IvZicvtE9LzOBvwVPVgHDX2+oXOXy/hruotaG4+bKLWFAJ7thykcIsV
         mfiX0p4RvOWGxZBNojBWbC+MBbz4DI30tw8/rgNbbywu9MSWpa31KogvulZ5BytiDfT5
         n0AbiLPnhzjT/5wG6qlQiTNAAjK9R7MAPFBFOU03rPy6fZx8akvyzNeqVdrF/KHSDfOq
         MOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DDvHFif3dFTR0CWMe4Ai+rYlHPHZLRltJS+vFmlP5No=;
        b=FBBtWxXXyxZbe6HbJwMvlz5ma0axq4Q5t6ADf9oPLtZ0WktaD2m6WKh3BjXHuqpru4
         axCvP2CbhAm2L+bZWVRsoY1i3/ZDt+JJtQ6gl7MC9vehtyndCzmB9tFtkAE0fMdvnynv
         XW68/WOOjoAbnTDpWnDiV9KOCYV6xKm9dCDjYigPdEc+HAo0cejFYqZHREI5ej4gKJ5Z
         hf+eP9xi8tpY9Km0fJmSjDit22lg/ChV0DWkJ7wyFCvIgiXWU5cuJsBU+urRGVKMultV
         +2PChSQ3SDBKpB0S3/GZKf181o68V2L3TgGLcA4/R8yUwx2bJG8vPBOd17Ad6zPBrnw4
         BZ4w==
X-Gm-Message-State: ACrzQf1bFr6KKi9iRUQCp48McQMkQlone1gBBMnNJWhrU66qAe2xxuc4
        MgB7LK6JhPEvnOqLnTP/oJ34Tg==
X-Google-Smtp-Source: AMsMyM4LLer0qmdu4SnYGqev0qGFxoxrnBhQOmXLw2SOcTltdFV/PmGI525n82G/Se0tfnqb3r939Q==
X-Received: by 2002:a1c:f002:0:b0:3b4:dda4:b58f with SMTP id a2-20020a1cf002000000b003b4dda4b58fmr1432461wmb.184.1663662833415;
        Tue, 20 Sep 2022 01:33:53 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a8-20020a5d5088000000b0022a839d053csm902278wrt.98.2022.09.20.01.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:33:53 -0700 (PDT)
Message-ID: <1ee2cb91-ad05-5ed6-70b4-a48791989c5b@linaro.org>
Date:   Tue, 20 Sep 2022 10:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] clocksource/drivers/arm_arch_timer: Fix handling of
 ARM erratum 858921
Content-Language: en-US
To:     Oliver Upton <oliver.upton@linux.dev>,
        Kunkun Jiang <jiangkunkun@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220914061424.1260-1-jiangkunkun@huawei.com>
 <YyGqZmO9vibRmd8n@google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <YyGqZmO9vibRmd8n@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 12:18, Oliver Upton wrote:
> On Wed, Sep 14, 2022 at 02:14:24PM +0800, Kunkun Jiang wrote:
>> The commit a38b71b0833e ("clocksource/drivers/arm_arch_timer:
>> Move system register timer programming over to CVAL") moves the
>> programming of the timers from the countdown timer (TVAL) over
>> to the comparator (CVAL). This makes it necessary to read the
>> counter when programming next event. However, the workaround of
>> Cortex-A73 erratum 858921 does not set the corresponding
>> set_next_event_phys and set_next_event_virt.
>>
>> Add the appropriate hooks to apply the erratum mitigation when
>> programming the next timer event.
>>
>> Fixes: a38b71b0833e ("clocksource/drivers/arm_arch_timer: Move system register timer programming over to CVAL")
>> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
>> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
