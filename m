Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB1C72233A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjFEKRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjFEKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:17:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFCA100
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:17:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f50470d77cso5674223e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 03:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685960232; x=1688552232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TL8FrjBvLOB0J2ckzU5zDN3LDIwLONem+iih3uE7XWU=;
        b=ebkFPWdYNLaMUho9qkYIBITcTiBJ2nApjX+DQB0ZJVhlPjub8qj1PnFJA57FRIbhTh
         Z7Wg1ON57LiP5SF4kl0tH4W3es3l5CoZ/SNPFRmm189Z84uxrT68h0WxfQlGEyUT8Vc1
         BDMYxXGo/IzdFNVayXgK5Yrn3yfwgDaxWCxsN/GLhtUDy/+FnO0F6gTrbOn5banDbteP
         rFYM2TsS5omPUt3Rb9qjv/YrvC1YtrCWDZ8vB6cSf7hZE7RP2t62jTmTGCxCAYbOkZ18
         uzVi3DTe5rusrudnAQqcVkLSNnZWUtKQlyZMQ1AeRYAxdqHHQjjY4RfCm6Fhn2ZmaOjf
         H17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685960232; x=1688552232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TL8FrjBvLOB0J2ckzU5zDN3LDIwLONem+iih3uE7XWU=;
        b=WhvPNdncDfEaJIlum/9aIttiJB85guWLKAGCyWlq6QNsSHwjbpwNFW5Y+17QAC2QA3
         8tLzIvcpRCr288HPaypl+kAtyb2DH8eM3cbfR8n1f1vsJq4JRQdemYFdPpmO3OJUdlrc
         gwANM+2sF1IQbHvrdKKIGXDRiUFUAX98R7MXy43wAMsy2aGWDIAtzXA6PHZkfE5GtRpm
         QzGOLSkaAtAAqHByrZkPcN6TgdQOPmB6mg/nAjTxU7QWN8mE3LWikrVuPnSJYeU85dzt
         M6TKB0UsHdNi+4hkH+r3gH5RW2strBGLak9hy5Ib3BEwqYdkXubJ7mUrnxQe5R1i8ZWW
         q6vA==
X-Gm-Message-State: AC+VfDwgnTa/trcxx91jHg1z5xQ5xYD1NuJkhBTH7uWM+sRM+m5VnN3W
        vWUJqEwFu3aAQfR+prxDLD73YYR75nfyA8XIYEs=
X-Google-Smtp-Source: ACHHUZ5f5CSb1CXsNeNN9VuNkuNB/1isot/4az07Iw1a4lCB2CL9zour0PLPocTC3rUSKLr/qvO9fg==
X-Received: by 2002:a19:ac02:0:b0:4f3:b222:1eed with SMTP id g2-20020a19ac02000000b004f3b2221eedmr4624466lfc.2.1685960232283;
        Mon, 05 Jun 2023 03:17:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bm11-20020a0564020b0b00b00514b2717ec6sm3766757edb.28.2023.06.05.03.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 03:17:11 -0700 (PDT)
Message-ID: <f24981d8-e384-e02e-8257-4b03b37e6c0e@linaro.org>
Date:   Mon, 5 Jun 2023 12:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [REGRESSION][BISECT] perf/core: Remove pmu linear searching code
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>, jolsa@kernel.org,
        irogers@google.com, bp@alien8.de, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
 <ZH2KVyyC5oMr+Vk2@FVFF77S0Q05N>
 <20230605092731.GZ4253@hirez.programming.kicks-ass.net>
 <20230605101401.GL38236@hirez.programming.kicks-ass.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605101401.GL38236@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 12:14, Peter Zijlstra wrote:
> On Mon, Jun 05, 2023 at 11:27:31AM +0200, Peter Zijlstra wrote:
> 
>> That said; given that this commit has been tagged twice now, I suppose I
>> should go revert it and we'll try again after a more thorough audit.
> 
> I'll go queue this then...
> 
> ---
> Subject: perf: Re-instate the linear PMU search
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Jun  5 11:42:39 CEST 2023
> 
> Full revert of commit 9551fbb64d09 ("perf/core: Remove pmu linear
> searching code").
> 
> Some architectures (notably arm/arm64) still relied on the linear
> search in order to find the PMU that consumes
> PERF_TYPE_{HARDWARE,HW_CACHE,RAW}.
> 
> This will need a more thorought audit and clean.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks.

Best regards,
Krzysztof

