Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301056A5BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjB1P25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjB1P2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:28:54 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F031025B8C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:28:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so6106967wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677598016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RjwqNYuTFMG2IO0+Vd14lDNGU8DWJ7+GpSDnYJ8/gg=;
        b=E927HRfOT6XUhwBALhxCrjyI1lY38itoPCunu2w0rN+d0h+qI32uNfgLJ88VNeMGkq
         Wwp+rXgPQ/WGa71qdKocJfWHvL40Ugt2DFcVDErkek9e6erdE8Oi8inivbI7poQ03qSa
         Eqcij1pvywZt4SuVB6FXfgLDc6RpttKk041buTStmbKlZoQ+aGV1W21KHkR9HaVf5omB
         sL2rkOAUSvduV7yQi6wgohQOnHYeeJEahDgF/pnW89PRDR2h3n67ai0gpyM47UULuDwa
         GMukIvVQscq0BB1jbQIIhOvVtzykGlmDvGX+4k9ILdX/q5gGFchZGWkY1K1LlYCPGgT9
         Ri9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677598016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RjwqNYuTFMG2IO0+Vd14lDNGU8DWJ7+GpSDnYJ8/gg=;
        b=0wpUwREAWTKNKen7OUSlgvHTOMMotFFung5dM6dsmjNqzQR9MXhroEyc57coiFfmuK
         tEPni+YAxe1+uCp6YRemlUz2vEHxJzFjts96SE0VSrkhCX3rq2DHxm721+MwinjbqtcV
         +VhB7ZFN9Tz7rIgUMwQxdkaw3S1q6zTAeWk+Y7mzne3WfIZLdAQXnlFnNENcxVXeBMhJ
         D2MyLc/2rgPxuqkwmu6BgjgizyUs10komrQPYb86Ukarir5GkrL0JIZWaAL5/bHR4Pnx
         JdXgu7OnMwBde7eQ4M6lcBiaIc0bIOcYro4mLz1IHAOyAqWkokcZ+/w/J327mr/EJwzZ
         Slgg==
X-Gm-Message-State: AO0yUKVuZgFjtHzwdVzEQH9LXg6MbL6Y/GEZXpoMdw2kxa5l8VclBCVl
        cuc8TQ0+Z0nAbJj7AviNg6rXuQ==
X-Google-Smtp-Source: AK7set8OIbj0DAiNzhatg5Ye0rStDXxLNYfJfRC6kJEwO1mD6qKQuz2vH3Uqrk1N7ZHJUoLnxg04xg==
X-Received: by 2002:a05:600c:3c8a:b0:3ea:c654:acf1 with SMTP id bg10-20020a05600c3c8a00b003eac654acf1mr2559133wmb.3.1677598015793;
        Tue, 28 Feb 2023 07:26:55 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id ja6-20020a05600c556600b003dfefe115b9sm13008760wmb.0.2023.02.28.07.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:26:55 -0800 (PST)
Message-ID: <99eeebc6-69aa-c6ba-139b-92672c299747@linaro.org>
Date:   Tue, 28 Feb 2023 15:26:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/18] media: venus: hfi_venus: Set
 venus_sys_idle_indicator to false on V6
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-1-58c2c88384e9@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230228-topic-venus-v1-1-58c2c88384e9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 15:24, Konrad Dybcio wrote:
> This call does not seem to have been cast on any kernel with support
> for VPU-1.0 or newer (and by extension, HFI6 and newer). 

We tested this on sm8250

Restrict it
> to V4 only, as it seems to have been enabled by mistake and causes a
> hang & reboot to EDL on at least one occasion with SM6115 / AR50L
> 
> Fixes: 7ed9e0b3393c ("media: venus: hfi, vdec: v6 Add IS_V6() to existing IS_V4() if locations")
> Signed-off-by: Konrad Dybcio<konrad.dybcio@linaro.org>

Right. This may indeed fix it for you on SM6115, could you test it on 
RB5 and verify the above statement ?

---
bod
