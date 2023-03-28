Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC886CBBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjC1KH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjC1KHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:07:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C5172A4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:07:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y4so47387060edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679998020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZPljhKeSnuSGlSWfKaLNDMSdJrVY6lMlRIxToWIHSE=;
        b=vgTGHg8fA3BZsk9LUPzWlrSQZGnASPGPFuZqfImemSFhHCJj5lrtNpJl1qhJaeaYPE
         leDREJVTlbajzM8RI1c/JJjEonQftsvxksAxwpBnCXhjUjMQyZCY4O7SkHN3OBwzks9Q
         bSr5gSOwPFoaT1eeMkd5r80jXAD5DRr7hRbPRW9rD8V9QLlHdLS6qaVN7LXketIv2oGr
         aUCy2skJ6KxoLOyx9EuzZc6uSN/bxCuCJjKG7VExpH/QuwU/f09lG+YfT/ojSHZl4qh5
         XyE2kG1yPMFqjfQgNc0IQHuEDp6GG1mNDOzZOWLy0yK0OsdVuG6AogQkCxaEJ5VYdtiH
         4Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679998020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZPljhKeSnuSGlSWfKaLNDMSdJrVY6lMlRIxToWIHSE=;
        b=q7ilFYjLQ/ivaofIXoik7LNizZ+0hrbqjcCsklwMqNg1NuO34b5uKevuIRvkG/jd8n
         s/BHDtgn5Dsr7lmc72SiQ4tm7inGJxLN90/8KgSWWvShC5uzPb3lW28YI1yyXkkj/ihm
         jYzs4WmRHBfJDFEGPUUVX3M3MVQdmM9MWNswmSghxHqrT0JwnFCx+VIQtLeM6uIS47W9
         bFt7GHMmcOje8Vc51K0VBF3gopSSWncXRfoYCHyU1tJbz3R+RDH1N0/rBddanlyeqUzg
         GQ/Yd7SPVaJ5Ul85fBLaVaKI3SbFzLqe5b/YBCP5dTpNhebAH9JostVVySR7tfGCIkjF
         IB9A==
X-Gm-Message-State: AAQBX9ecNpyWBrydtEk645Xnyg9pSgA64YGxxinW+dfWl2lnMdVJaX0i
        /v8LZRLyv2D/GzqB5M+vWuDpew==
X-Google-Smtp-Source: AKy350ZFYyOvQbIZ2wc5ylrWhyV44C9OKuB3cjIa2tHpjn0Dm3C5pFk/kZSkKlTmHvKCSly/UXuydw==
X-Received: by 2002:a17:906:9244:b0:939:4c86:d492 with SMTP id c4-20020a170906924400b009394c86d492mr14400048ejx.5.1679998019965;
        Tue, 28 Mar 2023 03:06:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906b10700b0092f38a6d082sm15071729ejy.209.2023.03.28.03.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 03:06:59 -0700 (PDT)
Message-ID: <81fad553-e8c1-f387-4df2-70c91a6ebc33@linaro.org>
Date:   Tue, 28 Mar 2023 12:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next] devfreq: exynos-ppmu: Use
 devm_platform_get_and_ioremap_resource()
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Yang Li <yang.lee@linux.alibaba.com>, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, cw00.choi@samsung.com,
        alim.akhtar@samsung.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230328053853.23159-1-yang.lee@linux.alibaba.com>
 <8779217b-bd70-37a4-c779-139690048d4d@linaro.org>
 <20230328095337.sr6s3klmhiyz63pr@intel.intel>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328095337.sr6s3klmhiyz63pr@intel.intel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 11:53, Andi Shyti wrote:
> Hi,
> 
> On Tue, Mar 28, 2023 at 09:19:01AM +0200, Krzysztof Kozlowski wrote:
>> On 28/03/2023 07:38, Yang Li wrote:
>>> According to commit 890cc39a8799 ("drivers: provide
>>> devm_platform_get_and_ioremap_resource()"), convert
>>
>> I don't understand why do you reference this commit. There is no bug
>> introduced there, there is nothing related to this driver.
>>
>>> platform_get_resource(), devm_ioremap_resource() to a single
>>> call to devm_platform_get_and_ioremap_resource(), as this is exactly
>>> what this function does.
> 
> I've seen Yang has sent many of these cleanups, perhaps he can
> write something like:
> 
> "
> Commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()") introduces the
> devm_platform_get_and_ioremap_resource() function which combines
> both platform_get_resource() and devm_ioremap_resource() into a
> single call.

I don't think we need to reference that commit at all. It does not
matter when the API was introduced and just makes commit msg unnecessary
long. Instead the commit msg should shortly say why this change is
needed or even worth accepting.

> 
> Update the code to use the new combined function instead of the
> separate calls.

Best regards,
Krzysztof

