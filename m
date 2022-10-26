Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAAB60DDDF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiJZJTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiJZJTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:19:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151A01B788
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:19:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o4so17055472wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vvLMd9vnkZI8EzpD9XjigLCKktXXyr3j+Ca9tW6zSc=;
        b=Os3CANdZlXG2loOTmbB8GVV0kux7vtMLUrM6BXvveJ1XmAGULocAcl04MTbfQtgKHZ
         ZogXwPfXcyuUoE8fhJosJMlabM5JN1sDQftzcdN06ukbYROVYK+DVBU47D+YyGx5ocK5
         wuhRtq0iSQQxLpllqZAJP0F3NBycKOZe7yhJxhyHBPgzUjzRv6n1wmf7iyoVnJQ1mEOw
         QP6JjocO5+YT1ZcUzHp2thVVWx7q/4ul2IFZHMoN5zRrDi6UuutfO9AtMMyzbmDGiNRH
         py2swijRZbkDaqrS28X33rCiTGpEj6KHQpgD8WfnnZ7sVEvR1xQbwtiPpf+XNfliKqF8
         D1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vvLMd9vnkZI8EzpD9XjigLCKktXXyr3j+Ca9tW6zSc=;
        b=AtZQWSMm8MGb77VQprBTEwk+oATwq1Cf2Bxy0NQNOEynChiONw6b5A1/6pkagmvwdG
         tm7UWQyox8EEFBM+3HVleZFdDO3vDkYV3SfNMUn8L1nslrjbR2dErTwqz55px4tFvVpz
         BBkGJyUYoTZjwHHno46q4jFvp2baOMhy1SvRd8SYq+AtoBIW5aASuj28IEuiQx9ajt+A
         oZ1MyakVvrRtUk2Q0GG5txXRqt+A8qmVkFzh4MArmSFEl+JUAJSyAkyvyMNAUMMWhXEI
         tAHHaH3bj7VXqvatW0ha6FULL8uO670nsEmuCwZoGhiaO+3cDceC5cQ4DHSxTHofDgdf
         NB2Q==
X-Gm-Message-State: ACrzQf2IuNS/IoTaTSkIPhA1T1+5mxxtZyCMyp5sBwBqkvJErsM7HBPq
        0mq3+8UKCEGd6C0WrL8Zo+xh5Q==
X-Google-Smtp-Source: AMsMyM4ERMKN8mXF1n7JYQJq8K3dGg1HUzsKsTY9L1ZoG3ILEkjuCGg4X927odxJLccu51fROJeatw==
X-Received: by 2002:a5d:6d0d:0:b0:230:1b65:a378 with SMTP id e13-20020a5d6d0d000000b002301b65a378mr28987089wrq.406.1666775986311;
        Wed, 26 Oct 2022 02:19:46 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j31-20020a05600c1c1f00b003c701c12a17sm1378685wms.12.2022.10.26.02.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 02:19:45 -0700 (PDT)
Message-ID: <4d2fcabe-291a-9f8d-ca48-eaf52e00695e@linaro.org>
Date:   Wed, 26 Oct 2022 10:19:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/9] ASoC: qdsp6: audioreach: topology use
 idr_alloc_u32
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        tiwai@suse.com, lgirdwood@gmail.com, bgoswami@quicinc.com,
        linux-kernel@vger.kernel.org
References: <20221021165207.13220-1-srinivas.kandagatla@linaro.org>
 <20221021165207.13220-2-srinivas.kandagatla@linaro.org>
 <35f55696-c4c5-1f00-dc7e-b5c7dcf0a091@linux.intel.com>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <35f55696-c4c5-1f00-dc7e-b5c7dcf0a091@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre,

On 21/10/2022 18:09, Pierre-Louis Bossart wrote:
> 
> 
> On 10/21/22 11:51, Srinivas Kandagatla wrote:
>> SubGraph and Module Instance ids take 32 bits, so use idr_alloc_u32
>> instead of idr_alloc to able to accomdate valid ranges.
> 
> typo: accommodate.
>
will fix it in next version

> Also worth checking https://www.kernel.org/doc/html/latest/core-api/idr.html
> "The IDR interface is deprecated; please use the XArray instead."
Thanks for this hit, this looks really good and specially lookups 
without Locking, this could cleanup the code a bit.

Having said that I would still like this patch go as it is with idr for 
now, and I can plan to rework on converting idr to xa later, as there 
are few more Qcom Audio drivers that have usage of idr.

thanks,
srini

> 
> 
