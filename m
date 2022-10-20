Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFA960637C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiJTOrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiJTOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:47:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFE314BB56
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:47:42 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so2538573wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNLw0g9aW4DViYegUYXRGvm/PASw5WNRrmtJ1qb1e6w=;
        b=M0Q26zKHwnoa5C4gpwRkznGLdTFUNIrn4NezGvAcNwQkGpFUfvs8mod8m5PfHumNhO
         FjJdyIhNJkmPnMFP4RYImzSHTM6xaFNHkVv3TlPCJ2NB+4wUEmZMkUChqAzhEU0k7Hbs
         +w73BJAmT5QgDqmkas3cRE1uxnOtTFm2R6TNpiggzBdGv+/WPa9+mfs2jr8rqGmF8mLo
         eLwSMwCyX0r3sSiu6YubXY4kAdzk0m4UaUsBwz+qEwbb0LzPJrUH1Nq0uNdCN+Xtbmub
         J8WId3sby5tyTTyP3bKiZtYYWjtRafFp/t7SNKXO8Dq2ZkocycKHnntJqmhBnVV4q7Wr
         Ec4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNLw0g9aW4DViYegUYXRGvm/PASw5WNRrmtJ1qb1e6w=;
        b=qqptbWRrsn0+Zvi+iQSOogxAlARG+vaUCORp3gpzcxCxwVHwbZUMY67hrH6lYazUmZ
         oeYv/NqVAYkdOpUylyaKeXuQgAVdDi/kxXwD/udZHs4qe2kO5KwynL5sYXZPR5JJM1Dy
         6mbpHtQDpfvlbNM26Xw9zwQH+TYqSlD0Kq7O7PFsXkCaD+kGANYX4HdtUBNP4K1tObrg
         qLpAWyX4imXf0/OaVXZqvZ8bCij+/cJtopZP3Q4ngZqrUPirCXlEUTLA2oM/zPvqiKyd
         2oGFTbgeyKEYxbX0ltXjs3ywcoyZtHlEykDxX/1FCskGZjLeLP+RZVM5Ij5AikufpcO0
         5JHA==
X-Gm-Message-State: ACrzQf0l718nJxQ8zCg652HvvnQEsqz+y1b771G8kKcwzepp0PVyhmUF
        OauTQALMicDqQ7hwefC/cK1nmw==
X-Google-Smtp-Source: AMsMyM5XvMCvfeePE6gNiP9NaRupMSx/FrsALgVK+S06GitZYBks1Xp1wq80uP/M7ZboZh5SsKucfw==
X-Received: by 2002:a05:600c:1912:b0:3c6:e3cf:4335 with SMTP id j18-20020a05600c191200b003c6e3cf4335mr24163995wmq.81.1666277260344;
        Thu, 20 Oct 2022 07:47:40 -0700 (PDT)
Received: from [10.35.6.130] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id l35-20020a05600c1d2300b003b477532e66sm6663310wms.2.2022.10.20.07.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 07:47:40 -0700 (PDT)
Message-ID: <72d561c9-e2cd-83b7-bd47-ebba5ad571f0@sifive.com>
Date:   Thu, 20 Oct 2022 15:47:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5 06/10] pwm: dwc: split pci out of core driver
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20221005221242.470734-1-ben.dooks@sifive.com>
 <20221005221242.470734-7-ben.dooks@sifive.com>
 <0c7e6208-307e-3788-e864-b79647c8b2a1@linux.intel.com>
Content-Language: en-GB
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <0c7e6208-307e-3788-e864-b79647c8b2a1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 11:39, Jarkko Nikula wrote:
> Hi
> 
> On 10/6/22 01:12, Ben Dooks wrote:
>> Moving towards adding non-pci support for the driver, move the pci
>> parts out of the core into their own module. This is partly due to
>> the module_driver() code only being allowed once in a module and also
>> to avoid a number of #ifdef if we build a single file in a system
>> without pci support.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>> v4:
>>   - removed DWC_PERIOD_NS as not needed
> 
> ...
> 
>> --- a/drivers/pwm/pwm-dwc.c
>> +++ b/drivers/pwm/pwm-dwc.c
>> -
>> -#define DWC_TIMERS_TOTAL    8
>> -#define DWC_CLK_PERIOD_NS    10
>> -
> 
> Actually DWC_CLK_PERIOD_NS is still used here. Only the next patch 07/10 
> is removing usage of it so this patch is not bisect safe.

Ok, will fix for v6.

