Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA65172C53D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjFLM5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjFLM5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:57:41 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68E9195
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:57:39 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-777b4560ae8so209395139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686574659; x=1689166659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mcs/mzLIm1WsqdeHjzGZbuX7KtKU1yS6rQCOIH1J8I0=;
        b=xqC6MKpngECoQvoYMSW33//Z/IKlUMIllTI83I+x158liBOcOl7RCaT7RULcYvp7Ph
         m+2/w5j/2GbjBdORnBj2KHO+dN9IJXC3j1upgDuHEpXaGEYJCI4ibKda0jN0ubmaa0Fq
         rxiLTZ6SUZsGYZ4H91fpDNokyCdWkS0gBl436W3T9kxDSOAea7eovYflrFEakmL/qkg2
         alAwlke7UkgcmKzfQZOgkbETVsxnSKwq3bnCrNm8NbwUJzJgWvUl//zSJnKzcnA9Jx8j
         rUoEgmIEphfcjVDijdVjk8/Tnky7TXrFqLA1ZG3kDtaBrB9RaBxvPYZdEmFIiJ2UwmKx
         6/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574659; x=1689166659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcs/mzLIm1WsqdeHjzGZbuX7KtKU1yS6rQCOIH1J8I0=;
        b=fW6DC9d7GLDBbEr6t9Avdw6cHOZhWFycR0z9KDLPkIZdxRVWF0eMKNwmp0yZCMAGR0
         cVqnRt7HKCiJ00uXote72zV/dYiOCOo7zFalJtQr0gdYXMaeG6+wzR4aCYXZh2bj5g+B
         WWFOk56knMpeFro2iP9z9FPZKuDPKLKZFy9uabA9uR5p4K8z9flwa9YD4CDvNNnWxmkA
         Z+WuXM/fJB+XWgePlmfBHwrvRJoMJLzvF60e7T5fwTk+e9zz+21feJTcobv/Z09BqTwC
         h9bUQkhKVrb1m006quAoPWZS96PEDFPE2ja84eF38yt/FumSJpXmcEFqFG6yKiUUJBLs
         +7Nw==
X-Gm-Message-State: AC+VfDyhCyUMdDJBITpduqHRhsESwcqGbYJD0eFTTiw1INyeLAsn79Lk
        qJ7rnXV31qHs3OUGWPbgtG8Lew==
X-Google-Smtp-Source: ACHHUZ4154bImSu2u2zX5xxEjDVt2RyADN5K86hrxC1hYjrP9agk1PMGoXyFm23au2IshSS0kJicBw==
X-Received: by 2002:a05:6602:1851:b0:76c:6c78:5144 with SMTP id d17-20020a056602185100b0076c6c785144mr8089910ioi.17.1686574659284;
        Mon, 12 Jun 2023 05:57:39 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id w1-20020a02cf81000000b0041675393f68sm2690066jar.6.2023.06.12.05.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 05:57:38 -0700 (PDT)
Message-ID: <31b88290-5e2b-5c13-338c-3a08ad1e02fb@linaro.org>
Date:   Mon, 12 Jun 2023 07:57:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 17/24] gunyah: vm_mgr: Add framework for VM Functions
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-18-quic_eberman@quicinc.com>
 <3dd82ec0-2a9a-3401-5385-965c624f9f32@linaro.org>
 <c625a138-d27e-bbcb-8056-25abefb75152@quicinc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <c625a138-d27e-bbcb-8056-25abefb75152@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 2:49 PM, Elliot Berman wrote:
>>> +static struct gh_vm_function *gh_vm_get_function(u32 type)
>>> +{
>>> +    struct gh_vm_function *fn;
>>> +    int r;
>>> +
>>> +    fn = xa_load(&gh_vm_functions, type);
>>> +    if (!fn) {
>>> +        r = request_module("ghfunc:%d", type);
>>> +        if (r)
>>> +            return ERR_PTR(r > 0 ? -r : r);
>>
>> Almost all callers of request_module() simply ignore the
>> return value.  What positive values are you expecting to
>> see here (and are you sure they're positive errno values)?
>>
> 
> I can ignore the return value here, too, to follow the convention.
> 
> I had observed request_module can return modprobe's exit code.

I actually like checking the return value, but if a positive one comes
back it's not clear at all that it should be interpreted as an errno.

Given that almost everybody ignores the return value, maybe the
called function should change, but blk_request_module() and
cpufreq_parse_governor() (for two examples) actually use the
return value to affect behavior.

If you check its return, and it's positive, I would return a
known negative errno rather than just negating it--and perhaps
issue a warning.  But it's OK with me if you just ignore it
like most other callers.

					-Alex
