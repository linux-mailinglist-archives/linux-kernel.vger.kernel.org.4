Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530956B5F90
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjCKSIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCKSIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:08:40 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ECE2E0F7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 10:08:38 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y4so3770907edo.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 10:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678558117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=px7FGPYfIZ94nlU1UqelVqsR2o/IJ1tQkvyb1RAfYos=;
        b=JATAngTG2WAcY9tmjNNxLSb/WOmJ0TMUJtpLjWrgt9RK8LedCE5gxHAYo47KJq0yYp
         Fxcn9cXJC0RUENvptu3z+Z1QSYyNWGUJq9rXYv8PBRliua2yS7yEc6B9dyYP/22gAYAX
         86JWAzGxHM+VMCLqTULniJr6O15i0lnXc3qMz/mieTz3QEENmpvdArCPrCKCPHUDzEfY
         DihVpUBQt/eTCe4BGrs79dtAT6HhK+tYhya4TQLzFcS3m42hi5zPKOWC88rRtQo+hRwL
         3KiIV13GuJfuOhg9oFR8MtguMOzldRYL5lZ8TwMoU2+otOU/+XuE1JtA3gvQn9Wtx8GM
         ACZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678558117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=px7FGPYfIZ94nlU1UqelVqsR2o/IJ1tQkvyb1RAfYos=;
        b=G4r0iC3ChR4/nOj3VOu/LLCM826Wdmr1LSaC9EeeBmaTxYurxYUKEChBop7RNMbBau
         G64abM36BFr+SVeOL8Vh4LlD/62atDKrd288dN2et9J6k5O4tK+rU6UWo3WZCJlBKsfg
         zue7+lel32FGzEIcUn4ZzvFcAw6AKf3S95ahNP67LKlgkCw0dKlHwr9sRDhcl9zJNY+f
         8yyPO7V+WI5lq/1ba3m/7jQSYuNZtl4AgkIHsvfuvPjgwydZu/uRhSkkHmFEgJritNCZ
         t7MHKaCur+wXPbaQvKQVVZ1OZAflrgSMliL5SJpuB6+xeXyyuzElZDJacojsxNW+ugn5
         PE1w==
X-Gm-Message-State: AO0yUKWs4nvHnIBib5sXN7clYna4Mf0alWEtbzAv9hepf/cUCsjUOusR
        BWWzTCdgfULJXfH6kT0RSimt+A==
X-Google-Smtp-Source: AK7set9OXOzqJIG07Dth/sljXDOnOfsuxMi1VLwWpjHdi47/1I5/6sZWv2qa3oiqUaRnZrduNtl/Dw==
X-Received: by 2002:a17:906:d9c8:b0:8e1:cc38:6ab0 with SMTP id qk8-20020a170906d9c800b008e1cc386ab0mr25990433ejb.16.1678558116822;
        Sat, 11 Mar 2023 10:08:36 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:6927:e94d:fc63:9d6e? ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id s13-20020a170906354d00b008caaae1f1e1sm1312972eja.110.2023.03.11.10.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 10:08:36 -0800 (PST)
Message-ID: <f14e1e9d-5265-355f-943b-3b0ed96dca46@linaro.org>
Date:   Sat, 11 Mar 2023 19:08:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] devicetree: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <640cc323.050a0220.8e83b.0e60@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <640cc323.050a0220.8e83b.0e60@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2023 18:57, Sergey Lisov wrote:
>> Why did you remove the subject? Please keep the mailing process matching
>> mailing lists. It messes with mailboxes, filters and reading process.
> 
> Sorry about this, I just wanted to get rid of those X-Something headers and
> accidentially deleted this one.
> 
>> Yeah, Rob acked it so I will let him to judge this. To me it looks like
>> unnecessary fragmentation - this looks like compatible specific, not
>> board. Anyway you need to resend to fix all the mailing mess.
>>
>> Best regards,
>> Krzysztof
> 
> Should I resend the whole patchset from scratch, as if nothing happened?

No, sorry, I was not specific. You need anyway v2 with all the fixes I
pointed already. Lack of commit msg is a no-go.

Best regards,
Krzysztof

