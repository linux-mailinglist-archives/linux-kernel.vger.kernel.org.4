Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ACD60453E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiJSM1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiJSM1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:27:02 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B65183B3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:02:54 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id o22so10483625qkl.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqgGJo+VkrEIB31JMhwIvUVH55mGBmWPF4DgCtb++g0=;
        b=DVREBeEKvhlzvvX56d43ecksMYNM3qThPtqGMqwrV8spZOnkS0bJU0XPOG1/bf9Ujt
         SqI/cCXib3NmgVpQ3cph3UAtMGpWtydgg8MbzOH4Ra8dhrhdVbPlsuglqE2ztpXErRSz
         Wf/UmkfEEvZj1UYguJ3ym2ZuzqslRfsY8Aq128ELaqDGyP+TOjHte/pcc0IrymT+HdSb
         aOACZUsWPidqEVa9WtBawByhkGH5fr3dyIkiaykInrPVsS9buXDiQh4l002UIqm+1jwB
         EE/4LmfDi74Fc7c+q/MeXMhnaaoEBVuL7zfodm0gAvXJLB6BrQScULP2Ds0YeynTzCg7
         EqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqgGJo+VkrEIB31JMhwIvUVH55mGBmWPF4DgCtb++g0=;
        b=D0S3kCDdpo5946GU5MPyGBWJChhSwF6C9ef6s1zoBONE9pK6iXb7DVj+28cWTSdhtQ
         vhX/XfDyx1i4RdDnYYBUDGg/tGArJn7bn/+cSodNREZs8fZtGqdqvgw1C/167e9pJybh
         85KjK2DEvpb96a1XHSKSZwL8xnu2zWN36JmhjKREH4fBaI88ZCZ/Z7BkjXuRs9OJbYqF
         pGVVfXVkmwBdexolO+iOpecnZGApVDDmXrFKQyWdG16al0mYMBc7oD5BFKMGE/2+A6pz
         7D8VrYkIf85kOZ1zNyfvBGuW2VIImFfVZMFqZ64yCsJpImERc08AyqEiLx5aschtygPc
         NDPg==
X-Gm-Message-State: ACrzQf0fbpngiK7EzimbVUjdwuARerWDxAmY1mRX5orVKb00pKmslW0N
        LjNVtUHCZVUYDA6D35fQr5A4Xg==
X-Google-Smtp-Source: AMsMyM4jnGJcsPoJ/eCogq9FIATpFpf3xU7k5A3woo4fSySkfin24aNZ+hLF2WZaPTvYMQFqnYlBMA==
X-Received: by 2002:a05:620a:4015:b0:6ed:a8db:32c0 with SMTP id h21-20020a05620a401500b006eda8db32c0mr5321214qko.656.1666180766976;
        Wed, 19 Oct 2022 04:59:26 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id bz12-20020a05622a1e8c00b0039a1146e0e1sm3951343qtb.33.2022.10.19.04.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 04:59:26 -0700 (PDT)
Message-ID: <e52eeddc-1562-05ff-de3b-c28655c7b550@linaro.org>
Date:   Wed, 19 Oct 2022 07:59:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v7 2/2] dt-bindings: thermal: add loongson2k thermal
 binding
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20220930021054.22387-1-zhuyinbo@loongson.cn>
 <20220930021054.22387-2-zhuyinbo@loongson.cn>
 <21717466-63f9-09b0-e666-61b98ab808f4@loongson.cn>
 <48b246c7-2af0-9d0d-3252-274b369af703@loongson.cn>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <48b246c7-2af0-9d0d-3252-274b369af703@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 04:53, Yinbo Zhu wrote:
> 
> 
> 在 2022/10/14 上午11:47, Yinbo Zhu 写道:
>> Hi thermal maintainer
>>
>> Are there any other suggestions about this patch? If not, please help
>> merge this patch to upstream.
>>
>> RRs
>> Yinbo
> 
> Any updates?

You sent the patches just before merge window and since then you keep
pinging. No, it does not work like that. It was a merge window.

Best regards,
Krzysztof

