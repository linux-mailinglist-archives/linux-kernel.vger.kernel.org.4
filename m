Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B724D6A063A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjBWK3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjBWK32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:29:28 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6672CC61
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:29:26 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l2-20020a05600c1d0200b003e1f6dff952so9736783wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKc6y021FHBN+LrR2vkeYuDgxpGOSK9TOESkAOOS40g=;
        b=MSle8iSbfDKnGj+DESFAgoxCe7S1XWAzXDqXieuC2nduiLZtUbpte2AAM7V5Q2WJ7C
         3M7MtTxqzcWoSOW3Gb2NlBoYXOZVwl9P269yiCLckSBxg/zxybz5Jr9W00ZYf4UpmqPA
         rSD7OkH2aMUPXgJjduf0nE5K3xZksEFRZ81NY+pR3a1U+zaMQk+ko0GZz/jJDPOmBLu+
         ocJwnczeXPqyKUGt6ywnHCuwRQGc8wZtlsjlip3jqHIexlB07we2vgF835BdMU6JOF1D
         cVKrctmZxTJXCUOU043OHyFXyP3HEl+hN3W1oyi0kk+IV/tKAckfMJwY1++9V2GDamai
         zyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKc6y021FHBN+LrR2vkeYuDgxpGOSK9TOESkAOOS40g=;
        b=EPqfPSiiNMP8weBvmnMgHliof488HT+cqeWt6uR2jplg56Kt/SNoFYq/HfWY8Tn/IQ
         U1GDybFMnAljRN0DztfC3QjCnTaAX/r2ua7aNx6UMTFGpFESyJvTdC3hOuDueEjEbS6y
         z32serf4SXER+TuszNJhEtv6/glsdPG6oeuhd8GJEu3d6PVmsgWs6XVyKx5MMSkBImnD
         84abNZQjwo7urfrMJIatHbmtW/1gZ5puR80d9vQhE3zZFQyZRC7pi96BhijmUqy9Jthm
         T3HHXG2g91IyMk88d11gdUVvij7EnOIEt8vd3AGwxzV1TXUwaPFBp5vSOtdgXVUxE8dD
         mafA==
X-Gm-Message-State: AO0yUKVBJcw2fzH2w4o0IINZmaETB5q2uCdLOvdS2iOAc56yxF2REM2M
        vTQ9C7gFv8mZLOrY5zBdYesCwA==
X-Google-Smtp-Source: AK7set/DuYj5W4k5F3QFJwDnJAJ3FKK5euZhS7JWUpdW8R6uN/+e1dKH4fcozE/UQmRBX+gaCwo5aw==
X-Received: by 2002:a05:600c:6001:b0:3e7:772d:22de with SMTP id az1-20020a05600c600100b003e7772d22demr6847506wmb.30.1677148164513;
        Thu, 23 Feb 2023 02:29:24 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m17-20020a05600c3b1100b003e896d953a8sm6516457wms.17.2023.02.23.02.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 02:29:23 -0800 (PST)
Message-ID: <44a59ea4-da6e-e96a-5e89-dfd41db72823@linaro.org>
Date:   Thu, 23 Feb 2023 10:29:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 08/26] gunyah: rsc_mgr: Add resource manager RPC core
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212327.3310128-1-quic_eberman@quicinc.com>
 <d69f9699-b4d9-7a3a-71b1-7e6fe72c4f82@linaro.org>
 <94ebe2f0-0baf-21c0-45d5-c5bc4df9ad94@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <94ebe2f0-0baf-21c0-45d5-c5bc4df9ad94@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/02/2023 23:18, Elliot Berman wrote:
>>>
>>> +EXPORT_SYMBOL_GPL(gh_rm_notifier_unregister);
>>> +
>>> +void get_gh_rm(struct gh_rm *rm)
>>> +{
>>> +    get_device(rm->dev);
>>> +}
>>> +EXPORT_SYMBOL_GPL(get_gh_rm);
>>
>> Can we have some consistency in the exported symbol naming,
>> we have two combinations now.
>>
>> EXPORT_SYMBOL_GPL(gh_rm_notifier_register);
>> EXPORT_SYMBOL_GPL(get_gh_rm);
>>
>> lets stick to one.
> 
> done.
> 
>>> +
>>> +void put_gh_rm(struct gh_rm *rm)
>>> +{
>>> +    put_device(rm->dev);
>>> +}
>>> +EXPORT_SYMBOL_GPL(put_gh_rm);
>>>
>> ...
>>
>>> +
>>> +static int gh_rm_drv_probe(struct platform_device *pdev)
>>> +{
>>> +    struct gh_msgq_tx_data *msg;
>>> +    struct gh_rm *rm;
>>> +    int ret;
>>> +
>> How are we ensuring that gunyah driver is probed before this driver?
>>
>>
> 
> Which driver?

Am referring to gunyah.ko

TBH, gunyah.c should be merged as part of resource manager, and check if 
uuids and features in probe before proceeding further.


-srini

> 
>>> +    rm = devm_kzalloc(&pdev->dev, sizeof(*rm), GFP_KERNEL);
>>> +    if (!rm)
>>> +        return -ENOMEM;
>>> +
>>> +    platform_set_drvdata(pdev, rm);
>>> +    rm->dev = &pdev->dev;
>>> +
>>> +    mutex_init(&rm->call_idr_lock);
>>> +    idr_init(&rm->call_idr);
>>> +    rm->cache = kmem_cache_create("gh_rm", struct_size(msg, data, 
>>> GH_MSGQ_MAX_MSG_SIZE), 0,
>>> +        SLAB_HWCACHE_ALIGN, NULL);
>>> +    if (!rm->cache)
>>> +        return -ENOMEM;
>> new line here would be nice.
>>
> 
> done.
