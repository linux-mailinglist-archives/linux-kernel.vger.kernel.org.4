Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D2862A28B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiKOUKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiKOUKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:10:49 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB45A17058
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:10:47 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id r2so7990232ilg.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rb7jBGXbzGyxffcDNwboMY2DzDKCBnatY7WqspaVRkI=;
        b=A/6V3WqOc5LiuT2BWj4xJGbmK8TaNUt3i2Uzdh6QY0DvRyDxCX0R6k/xAOzrho0zgc
         ih7j8ji5WWqxf0DYfUzXUPrF+uvGD8SqkqTQ6S5u9gM4/PuxRJhEDCSbomcaLoHXNLEP
         OMEtcOhFBHOH7obD+S0hiUNgxoHY2IadZtJks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rb7jBGXbzGyxffcDNwboMY2DzDKCBnatY7WqspaVRkI=;
        b=sIIAojOxM79Rs+i3v530eT3oKmV7xzxWbCoXe+CacOCoxbRDtkf1mMBIcYGZgwnAbL
         57+bNisP1wZuLE1GA1D50a3NPwQZ2LlCSqgd7WYCD2OwKe3AxTdV8gnIJrHrV2vVZnQM
         5GbpP4i0OfDy/xDGHQh9dNFGiC2F5t1b1IRUltYfXQFxEQPwCk5kvA0AF4q3hXyOBcZ4
         mYKtvbP2VmsrjKlU7At+9b6hPmr0pDBFyqMfUQKVSymj96hwPgTETE4q95a3hGQYgT41
         R8dQO2vbh9xnneyfslatxwPo0gRJ1gcE+k3UimbLgxXD708jq3MoNj+7xi1fm8ggCgNX
         Pj/A==
X-Gm-Message-State: ANoB5plZTyhDHuQcxjd1CFjlH0FlmHdU7a1wLTb3kMWoww1xD8Ali0KH
        qxk1dASVRi5TONgSsUTYzAcO9RvcthgZ1Q==
X-Google-Smtp-Source: AA0mqf76lOK+KSl53+gEBcVW/o6FRM+XDnbBp6Wwh7l0FISCD1Nws+PS61elFQDW8Iq/xklmNwtcXw==
X-Received: by 2002:a92:dd0d:0:b0:302:47e0:e08 with SMTP id n13-20020a92dd0d000000b0030247e00e08mr8376255ilm.83.1668543047194;
        Tue, 15 Nov 2022 12:10:47 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i11-20020a02cc4b000000b00375e136bf95sm5053681jaq.127.2022.11.15.12.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 12:10:46 -0800 (PST)
Message-ID: <7b864479-e7c6-cabe-e363-a8268f7ce2f2@linuxfoundation.org>
Date:   Tue, 15 Nov 2022 13:10:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests: rtc: skip when RTC is not present
Content-Language: en-US
To:     alexandre.belloni@bootlin.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Shuah Khan <shuah@kernel.org>
Cc:     Linux Kernel Functional Testing <lkft@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221115200422.2306194-1-alexandre.belloni@bootlin.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221115200422.2306194-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/22 13:04, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> There is not point in failing the tests when there the RTC is not present,
> simply skip the test.
> 
Could be rephrased to read:

There is no point in failing the tests when RTC is not present.

I can fix them when I apply the patch or send me v2


> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Tested-by:  Daniel Diaz <daniel.diaz@linaro.org>
> ---

thanks,
-- Shuah

