Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DA66E650C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjDRMzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjDRMzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:55:36 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B40E128
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:55:35 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-32ad0eb84ffso2405435ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681822534; x=1684414534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ssndSN5/o6nxurAGdS8hKVXc9nslJH1ECG3jl8AZs3g=;
        b=HngOU7vPHlC3qt1Fwhdc650hW/qZ0bzxdTRqxAI57zc5sCbyH3qm9vEDvEbA46rq+3
         F/GckehCydgrudvQd9tDi+43knstriujkywRcpuqtUb3hUD1B7IB0uJtAenHmYZlsugF
         OYeVzVttfxjxf6fyq9Ig4re6btJ+sK8d5Kuc3VfNRk1Ut+hUPI0r+mIB0FybuHf/MeCa
         2cQ5tx6CTWBVR1uxVvk8BdnqSshHGJIRSs+wlZYRCI8zPu5VVHzwFdEz62/de/rNWiXQ
         NItAHEaMzoAwnyVtIGmNXP5kCGsslKtll8KAJnDgtJGihJPUH1xhIbhaCzHrHVwQbUco
         yofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681822534; x=1684414534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssndSN5/o6nxurAGdS8hKVXc9nslJH1ECG3jl8AZs3g=;
        b=Ybe3Nm94o1u0pN3o6+/dxso8p48S7Y7cJVx/vWaXd4UM3m59/qv3aHa0sCtQuviGEU
         2txENO6KjM38KrhapvkLN83XQbco5oW9bF6J2nSf1ZYFgcjeyyc1Sm5gkH95rrrV9vME
         +vcHUFSt6+RD8vrxSqhYd2ebHg7pnB03LSDDb2luESRwasGeCtfmZWFm0ZX8CozprUL2
         JnEtsUEDKgsA8okJhQuHZrIzpfAiuOLI2I2QI7EeAjFvyAbDrY49GqrFXCRcsaHNTaBZ
         RnoVmb5MGk3uidcRdhZ/EdBJUJO0ghQ5+B5Z6GB9zEtRTyWl47EwA4xA9hSoVukskl3d
         YfPg==
X-Gm-Message-State: AAQBX9cbOTviYkSckjqisuXha7+ohQ/yghab1nwCnMlcLTHajxpZYv98
        kXEWaBt93pOk7MrYA3JYlF/ZOQ==
X-Google-Smtp-Source: AKy350aDjJnh8fM6l7KL4hLO4WISexCSqu7Hj4ikESAdghF/ET0l9snlZhpZbINx6FrqtLzq4PmNdQ==
X-Received: by 2002:a92:d801:0:b0:32b:8bf:4d71 with SMTP id y1-20020a92d801000000b0032b08bf4d71mr5226237ilm.9.1681822534475;
        Tue, 18 Apr 2023 05:55:34 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id l5-20020a92d8c5000000b003158a3455bbsm3564604ilo.78.2023.04.18.05.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 05:55:34 -0700 (PDT)
Message-ID: <35e383da-2d4a-686d-5492-2ad3b8b4a039@linaro.org>
Date:   Tue, 18 Apr 2023 07:55:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v11 24/26] virt: gunyah: Add irqfd interface
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
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-25-quic_eberman@quicinc.com>
 <a8dc6572-0a48-f772-2d8c-6329d632e0b4@linaro.org>
 <c8e95fd5-5761-b9aa-2877-6a8827a76f21@quicinc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <c8e95fd5-5761-b9aa-2877-6a8827a76f21@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 5:55 PM, Elliot Berman wrote:
>>>
>>> +struct gh_fn_irqfd_arg {
>>> +    __u32 fd;
>>
>> Should the "fd" field be signed?  Should it be an int?  (Perhaps
>> you're trying to define a fixed kernel API, so __s32 if signed would
>> be better.)
>>
> 
> It looked to me like some interfaces use __u32 and some use __s32. Is 
> one technically correct?

Good question.  It depends on how you use it.

It's a file descriptor, so it should be an int, and it appears
that's always a 32-bit signed (for 32 and 64 bit machines).
So the size seems to be right.

Whether it's signed or not I think depends on whether you
ever save an error value in this field.  I doubt you do,
but if you do, it should be signed.  Otherwise, the largest
value will never exceed INT_MAX/S32_MAX; and in that case
either is fine.

Will Gunyah ever run on a 32-bit machine?

					-Alex
