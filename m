Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EC766DA17
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjAQJft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbjAQJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:34:23 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA0A44A1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:34:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h16so29905610wrz.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rX5JGMpRLSr6DyBFjd77gBFqw7Vo35bbpQ09gyhlp0U=;
        b=FJ049QbAnCTiGRLIjlmEziGk4eIz6jz3pOGm9YuOvlW2f8KT5rmAVf4vWKwMYGCuLf
         dVcDc3TQAXqArMifxpgyfhRbEoYc+zzQtQ8envHiJFJv89OJTo+OzDg7fHjmGoDUzLGz
         aeQXrlB/T9L73p/RRJG7UZURoN0qtXf1uy4aVJrvjcZMQTdFWpVYhQHN4glGaJk6f+WO
         kQEIWVtpB3y3U9KvKyz3Cf2pwr2e9I7cGoFmOgYIHePHct2vZSFNG1VLfdOgVrkhaH8S
         a6O4wIDr9x8dNsffrXy5eMxbXijRU4W4cL6QcN7EyQbj/0uX+LEuE5PcxgrDi6qjvsfr
         nkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rX5JGMpRLSr6DyBFjd77gBFqw7Vo35bbpQ09gyhlp0U=;
        b=xDOKzJ21+l1HRveWYCMVV+DyV0kubIBdmgNuGjkoy7ALSvxk9eSjt38mxHdza3XXrc
         sjB/OtwnGKiGxGTumYokm6uHC3je4PwLIWIBNSObWvxWRwmXZh+6HkpFUTZIBV6bGweg
         5nEz5rGYEkks6QPGLFJOlHu3LKFSduTb6aYJSIMBgWdu115TKuIk6aDZ2shVxhrivNm2
         aKPAKw3UrVzDwlzeopTMP5yY0fQtnmPfYLa5NFjq+TLBK7C3cXekEMmBSSmUm0p4ATWs
         tYmDnQk5p1lpth5EXgcw44rjWj23mg6Dc2rlpybkHkG2vxFpVVdyZwo3I3ouLa+/CK/a
         PvyA==
X-Gm-Message-State: AFqh2kqe23ux++JD94iKmzrR2BmUGWQsqq8OesmuV8w+kuw2iSkFnQ10
        5jMMqWOIZtgIQ9GtPQXXmWY2Kya7bSj63cHh
X-Google-Smtp-Source: AMrXdXu5vmi3AuRfaLAf41Fb7sh43Xw5WWXe/+T+X8bVCMz4p06E09DnIFM+MyK3syIVIT2qSsG9hg==
X-Received: by 2002:a05:6000:98d:b0:25f:8ead:96cc with SMTP id by13-20020a056000098d00b0025f8ead96ccmr2053341wrb.70.1673948053511;
        Tue, 17 Jan 2023 01:34:13 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n16-20020a5d4010000000b002bbed1388a5sm23090463wrp.15.2023.01.17.01.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 01:34:13 -0800 (PST)
Message-ID: <30dc15d9-2377-e51c-f8c6-f63ddfdfdad2@linaro.org>
Date:   Tue, 17 Jan 2023 10:34:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/4] powercap: idle_inject: Export symbols
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
References: <20230117020742.2760307-1-srinivas.pandruvada@linux.intel.com>
 <20230117020742.2760307-2-srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230117020742.2760307-2-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 03:07, Srinivas Pandruvada wrote:
> Export symbols for external interfaces, so that they can be used in
> other loadable modules.
> 
> Export is done under name space IDLE_INJECT.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

