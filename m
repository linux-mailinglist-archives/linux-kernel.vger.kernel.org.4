Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEB06DB3AF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjDGSxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjDGSxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:53:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6105AFF00
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:50:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l17so10257440ejp.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 11:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680893395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u29Ba3A0btMM/Efd0jQfFxdcE+1OqKc3tXksWr+mPkI=;
        b=oLosmmGjsDVZsw4n1UPDv7gcUuB3AGv12Lr41gdR0QsSFA6+t09rDFFaXR0mggzPdt
         cpUI8QklvqOAIsCUOlBnoIPGBksqXhaBsqQ7fG1o0CRpQbk/3n6OeU2Wq23SpX9ERTG0
         pzBO4oAnNw1RsPUl+jQ/C3rjOxk3pr0XhH1Fz9d1pkRCv2Uwl0z8KuxTuSD341jhexSl
         oxk/E4CatmwVokAVISinDpli+aKphx7YRwzgr0Wp7g9U0Uh4q55iuLI8XVixw8jjeopn
         cV3IGQRhKsgn5cWWH1jRLqWpjImdDLqhouNJEx+W4ky8zs8nS/yevr65/fQO5m0KtAYC
         hx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680893395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u29Ba3A0btMM/Efd0jQfFxdcE+1OqKc3tXksWr+mPkI=;
        b=RV7P9GAlpVkW236vZKdAKwOAt6gfaNLWe05+1VrtgNxurh6QNHOTCyjclniyqA6d2J
         XvR6js4G7hnT+yh0fqq5z4ggdP/YXq5YV1g7Ap33aWG3a4OyM9F+PCUlLlbsDy/Of+oR
         woa4yrgaNCgCPFmtL4uyHLirehF9EN5tx648l7C1MLYlWqIFmYzF5HlLgm1xoopuzcQi
         cuVUU/45glEDu2neGc5wqcCE0/xzuc/b7QSsGybG//XUSwkOrPSSsRCCqJBZUXdCW5g+
         htqArzIuZk9boqp/XK34ztOMSM9dW7ubPiXFe6DR5KLX5k/p7UxiF/0FDmcRU7eSQTNG
         QCEA==
X-Gm-Message-State: AAQBX9fC5m3fFYA6dwQSkY4QblI+LVFgl5NoCM6QCkE6yaMJ1LfPtN/k
        4cKTcwHxTBEpAMnQ2n17yC3ZnA==
X-Google-Smtp-Source: AKy350YTwzJR8lBmYxKZMMC4/3TaxSz87x/xBEz7SeY88Vs1xsTZzSx2evDp9ZBzSus6HOsdufzG4Q==
X-Received: by 2002:a17:906:6d3:b0:8b1:2c37:ae97 with SMTP id v19-20020a17090606d300b008b12c37ae97mr366112ejb.43.1680893395164;
        Fri, 07 Apr 2023 11:49:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b20f:8824:c926:8299? ([2a02:810d:15c0:828:b20f:8824:c926:8299])
        by smtp.gmail.com with ESMTPSA id a4-20020a17090680c400b009495db4787esm2293272ejx.222.2023.04.07.11.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 11:49:54 -0700 (PDT)
Message-ID: <bb4f40e7-fd06-1e94-02ab-b26d1418e782@linaro.org>
Date:   Fri, 7 Apr 2023 20:49:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ufs: hwmon: constify pointers to hwmon_channel_info
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
References: <20230407150137.79947-1-krzysztof.kozlowski@linaro.org>
 <59929dca-6d70-c3a2-292b-91f7274dd12e@acm.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <59929dca-6d70-c3a2-292b-91f7274dd12e@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 20:30, Bart Van Assche wrote:
> On 4/7/23 08:01, Krzysztof Kozlowski wrote:
>> -static const struct hwmon_channel_info *ufs_hwmon_info[] = {
>> +static const struct hwmon_channel_info * const ufs_hwmon_info[] = {
>>   	HWMON_CHANNEL_INFO(temp, HWMON_T_ENABLE | HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LCRIT),
>>   	NULL
>>   };
> 
> A nit: to me the use of whitespace in this patch does not seem to be 
> compliant with the Linux kernel coding style.

You mean it should be:
	hwmon_channel_info *const ufs_hwmon_info
?

I think the pointer * is tied only to variable name, but not to const.
Majority seems to choose similarly:

git grep "\*const" | wc -l
2763
git grep "\* const" | wc -l
16204

But if this is more than a nit, but your preference, I can fix it.

Best regards,
Krzysztof

