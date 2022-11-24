Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A798E637ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiKXN7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiKXN7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:59:32 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D2C2AE02
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:57:41 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id c1so2666875lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q5oSl8B7L6BC8GSJPM/Z+z56L4i6cKlrSnS6RqlUdYM=;
        b=s9Gs/VugBK4fpok4ZbGQ12Y6VrhqTgfEXKG0ACpeR2JhGO8y5iKKCpOAzvOYeLZkS7
         KI6LRw7+3LA0ReiCukWCx+OeIeoZ2mv0hC0ewFWOWSOh1T/3ILNP52pF3gJOgeA2z1Ly
         MUQHLx9AyvD8h48/k4Q594Zsj0iibBh1i9VC98U7SyjsbuaDQm+VIyZNEmJf20WUf2RJ
         84Xsj0Upw8qyQJjUWrPHpAhZKM4h6d7JfX2EhnK/mMAobjP073SqXT8XyFltPnyjx+ka
         5ViWIMk3KADy0/aeYKZiAZPmGxvx8rESCLXUezmHabf1641Hmf6mCDD4aANE9SLv6TQl
         5VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5oSl8B7L6BC8GSJPM/Z+z56L4i6cKlrSnS6RqlUdYM=;
        b=3SRxv5SdFXd3GyPITMXE1L3HafFYxtNmKI4amtxnOVgdI5f+2SgkrQAiA5lpr1d1H5
         sYikWt3gmkD4x+B+GJRXnudndWHOeBklFGzAkxW8igBFuKAsmQ+en+ZYvuiUfYRsx13H
         ELEOvgPwxZmuDo0tHr4hOx4gFWwUqZ6O1QaSLmrY5rct/Ij8dpxfLCgTQm7Qv9D740Tt
         BismJ/8YpLwmY+PneaJY/Kotqiep0w1ZXRQJfY1qdfKpj2OKcVgHWMPPeHpS1Mf75K8d
         eV6AzT0+1dhSkJ8Llk6Z0t4swuAfwEWoHGAH5ZzzUj83ktnbIFHW6Pbfs0WgLxdVdvF2
         Befg==
X-Gm-Message-State: ANoB5pku6FM4B+SES3zTFouC+h0oW4ZNVgb7KnHKWJqC0XEP2QYNwjbX
        YBBrQLqMJd6aVMggadqxtoRADw==
X-Google-Smtp-Source: AA0mqf7xsK+DfKJ8GG7VQpCM3hA/7TDQvT74TF8g3crjG73OEttWF3ZhounvpBeGfVboa+VRsJjiNw==
X-Received: by 2002:ac2:52aa:0:b0:4b1:fc9:429f with SMTP id r10-20020ac252aa000000b004b10fc9429fmr11800803lfm.84.1669298257800;
        Thu, 24 Nov 2022 05:57:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o15-20020ac24e8f000000b00492dba3c85asm127747lfr.220.2022.11.24.05.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 05:57:37 -0800 (PST)
Message-ID: <5b1eb21c-92bf-59bc-25c5-f8c38c42b375@linaro.org>
Date:   Thu, 24 Nov 2022 14:57:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] dt-bindings: reserved-memory: document Qualcomm MPSS
 DSM memory
Content-Language: en-US
To:     neil.armstrong@linaro.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-0-158dc2bb6e96@linaro.org>
 <20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-1-158dc2bb6e96@linaro.org>
 <38fff21b-3e75-13f9-664e-a115bc527b67@linaro.org>
 <9aa23650-6ae1-3844-7cf3-6812dc023c11@linaro.org>
 <dfec6a0b-86c6-fb61-51f6-d1e400a6f5ef@linaro.org>
 <ad9d2e4f-1d60-15e7-dc2d-e7e32b0ec855@linaro.org>
 <7b3356a9-8f2b-49de-7ad3-b01c3279eac0@linaro.org>
 <eb577577-d4c9-1d68-f8f5-f42729155536@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <eb577577-d4c9-1d68-f8f5-f42729155536@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 11:19, neil.armstrong@linaro.org wrote:
>>>> We have already three of such "memory region devices" and we keep
>>>> growing it. It's not scalable.
>>>
>>> If we want to properly describe this, we must then represent the MPSS subsystem
>>> and associate this memory region.
>>
>> I don't see why. None of devices in your DTS reference this memory
>> region, so it is purely to keep it mapped for Modem, right? In such case
>> I still do not get why PAS/PIL, who starts and stops the remote
>> processor, could not prepare the memory and share it with modem.
> 
> OK you've got a point, but this is still an implementation detail.
> 
> I got some more background about why this memory zone appeared, before it
> was including in the modem reserved-memories, but for flexibility reasons
> this is now in the hands of the APPS runtime (linux) to setup this memory
> zone and share it to the MPSS subsystem.
> 
> So the only requirement for the PAS is to make sure this zone is shared
> before starting the startup process, not to actually do the share setup.
> 
> The zone will need to be shared whatever the PAS state is (probe, startup, remove, ...).

I don't understand here. The memory region should be shared before
remote processor start or before the PAS probe? If the second, why? What
if your driver probes a bit later - after PAS probe? Then all is lost...

Best regards,
Krzysztof

