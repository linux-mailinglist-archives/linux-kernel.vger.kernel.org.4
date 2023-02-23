Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680386A04AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjBWJVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBWJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:21:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49958521C3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:21:35 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r7so9923945wrz.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJSCygSyqymwVM3qv58bXIOQ/QMwS9A0T2gOwos2ANI=;
        b=fegQtyEWhTqmEAd0iw7X7HKpXLywzYFPBBzCm5qOIC8lDXtvSvWPLxRK1SHoHx4D8F
         cX9nYfRK96054nl3FKHZATG+FapB5e23HntdNfvK5fJTrpOIQaNkPh/xOf2q2H/h43Se
         U8P0v8yKtozY/YP3KYye8WS9wsVTR5g4NxnbpZFKLDDujNez4IvzyNE8MDGdtipvuMQS
         QGoU+osQ2ysbPKou87uCJADJSCZH3B8NHlV4LoKYB+YXGLZL07eCv71HXiKC1ZUz4wsZ
         G9TUCri7cQOq+twOG6pqmE/sgiTL2VcQhWorwnarYl22GecZP4GL0w3WTLmc7eegOgEH
         Aq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJSCygSyqymwVM3qv58bXIOQ/QMwS9A0T2gOwos2ANI=;
        b=T+Y1SGA9na2+XCbmYUogJRywi/27NqjRQxvVMfRsWQ5IaF/rb132xe+0pwQU0QawdG
         4u/K7F0Nr29CgjAFPxHWZ+Yghwdsh5mfl80HtV+6OtP4plsbFmcPUM/hNS34ff/bTZhH
         Tzy1zg2vsWLUAbSQuJtU0MgXglNsu1qMBMTUtvZLCXIiwDrrFFwrQ2rCLXhfHI9BHOMk
         sm/BNWgr5anzV+11z3HuWMif4InLqZTmEdhFnT1Edi9qhUm1p7TiLi4jR2AQSrhfFrJ6
         eYxq4/xHZ22UE3PQUTxGUKhXM9QSXz1rl69e+m+Oi7amK1/hs3ToqflFo1JWro96ByK5
         k2sg==
X-Gm-Message-State: AO0yUKVAup7dO6JLEowsN7mPC2KVXoBrUUtLbadt4psTDgEJsr2UX/uu
        CJwUXSi/Rs8oZjbggiemCKrAcw==
X-Google-Smtp-Source: AK7set+KT38k5JXdqB9gWpe020J1FzMkLGn2pF7mw7ss+GUQRXzcwUsyPn/SBCWmwFh5a4SSTvcWZA==
X-Received: by 2002:a5d:6a03:0:b0:2c7:84e:1cfa with SMTP id m3-20020a5d6a03000000b002c7084e1cfamr5709487wru.40.1677144093790;
        Thu, 23 Feb 2023 01:21:33 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id v17-20020adff691000000b002c70e60eb40sm2038217wrp.11.2023.02.23.01.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:21:32 -0800 (PST)
Message-ID: <e9fc3d3e-173c-6e8b-3f1f-187b1c72ff6c@linaro.org>
Date:   Thu, 23 Feb 2023 09:21:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 13/26] gunyah: vm_mgr: Add ioctls to support basic
 non-proxy VM boot
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
 <20230214212427.3316544-1-quic_eberman@quicinc.com>
 <1080339c-608e-6df8-8eee-b8f3bb7f396d@linaro.org>
 <320d42a0-9889-43ae-5d62-0c4cab3434c5@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <320d42a0-9889-43ae-5d62-0c4cab3434c5@quicinc.com>
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



On 23/02/2023 00:50, Elliot Berman wrote:
>>>
>>> +
>>> +    mem_handle = mapping->parcel.mem_handle;
>>> +    dtb_offset = ghvm->dtb_config.gpa - mapping->guest_phys_addr;
>>> +
>>> +    ret = gh_rm_vm_configure(ghvm->rm, ghvm->vmid, ghvm->auth, 
>>> mem_handle,
>>
>> where is authentication mechanism (auth) comming from? Who is supposed 
>> to set this value?
>>
>> Should it come from userspace? if so I do not see any UAPI facility to 
>> do that via VM_START ioctl.
>>
> 
> Right, we are only adding the support for unauthenticated VMs for now. 
> There would be further UAPI facilities to set the authentication type.
We have to be careful, please note that you can not change an existing 
UAPI to accommodate new features.

There are two ways to do this properly:

1. Design UAPI to accommodate features that will be part of this in very 
  soon or in future. This way the UAPI is stable and does not change 
over time when we add support this feature in driver.

In this particular case, vm authentication type is one that needs to 
come from user, rather than kernel assuming it, so definitely this need 
to be properly addressed by passing this info from userspace.
Or rename this IOCTl to something like VM_START_UNAUTH_VM to make this 
more explicit.


2. For each feature add new UAPI as and when its required, which is 
really the only option when we failed to design UAPIs correctly in the 
first place.

--srini


> 
>>
>>> +                0, 0, dtb_offset, ghvm->dtb_config.size);
>>> +    if (ret) { 
