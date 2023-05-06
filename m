Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611E06F91D4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 14:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjEFMEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 08:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjEFMD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 08:03:58 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B43811B4B
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 05:03:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ac733b813fso30734301fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 05:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683374617; x=1685966617;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tULkpgt2x9nNYQ3ef7qoDxx5GJASjFLnUGSKrUazgGA=;
        b=VvAWn8j/KsyJjz04hzdwxfCFTSiMYAC8h6f3lE+C+zCdF5zUiyswVbGQPg8+9hDxK6
         Ch4KPBgazGntgUVD9jTtHm/UC0psc/mlnxHwJjwuieUyHBtfIX9lRQ9m3kL9YExQ84UE
         2VyKsbiyHRE4upGEfeIW9QjsXJG5gqkMaiOG1lagC7SV8/YntU3PD66D8C0Q+dC04Jku
         MB1SWxPakYqSFD5VoQPR/7KFnnafP0/lgPYmerDMoVb8Ce5oMQokS30WeCknwA97r3HF
         PXlGwt0Iwq+XPy4Z6ha8ZY2wfzbpJg8TxN7xzYkDop5Gf/RueLyyJoCzHUw41xLfdWx5
         g+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683374617; x=1685966617;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tULkpgt2x9nNYQ3ef7qoDxx5GJASjFLnUGSKrUazgGA=;
        b=RlxG7D2lACyGTXQRwt91Ou1ZHiRac751Vb9Lf0EPFobOO71iFBGGhlWMXJS5RIDTt1
         0l1I8Vyg4ubqrId4bjckSQUy+pIskUmmo21SxF+EMjsOHb0R7rHh1mIPhzaCMIyk3YEd
         OL7p2h+Ria0ZJYSVAK5LdoQpY72cvoK5yuxJz181J+MRqcY+UF5N2RXsQdbXz5dr8stJ
         P9+EF/yvJhmabjLfmcbsUULkjI9ysc+xMaiJXBRDXHUzSpM7r6N+jauipEoAaXk3O18X
         IqHwX/PHLCtlQbJVwmnb+yxcCOP+ueDnrRgW76BjfP0TR62txtqe535BiOB2rMSii2o9
         l33A==
X-Gm-Message-State: AC+VfDznRfHopx18r2kvNdi59mxkkZFHpgt653Eh8IiUxzDbXu7qYs7x
        j1H5WL0pZp5yRZsrS15d2Nl63w==
X-Google-Smtp-Source: ACHHUZ7tZ5uihbNR3knCgkgUnqBWgwbECpYX4LWtA9HJv579T4lYYG1gmnBZFIHKnxoL7TmvjZyXYA==
X-Received: by 2002:a2e:9a89:0:b0:298:aad1:5df0 with SMTP id p9-20020a2e9a89000000b00298aad15df0mr1114721lji.41.1683374617260;
        Sat, 06 May 2023 05:03:37 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id 15-20020a05651c00cf00b002ab309da60fsm350472ljr.103.2023.05.06.05.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 05:03:36 -0700 (PDT)
Message-ID: <14e56402-bc81-723b-1d0e-323072f05014@linaro.org>
Date:   Sat, 6 May 2023 15:03:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/8] PCI: qcom: Do not advertise hotplug capability for
 IPs v2.7.0 and v1.9.0
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com
References: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
 <20230506073139.8789-4-manivannan.sadhasivam@linaro.org>
 <870ea899-b405-8061-93fe-cf50de595808@linaro.org>
In-Reply-To: <870ea899-b405-8061-93fe-cf50de595808@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2023 15:01, Dmitry Baryshkov wrote:
> On 06/05/2023 10:31, Manivannan Sadhasivam wrote:
>> SoCs making use of Qcom PCIe controller IPs v2.7.0 and v1.9.0 do not
>> support hotplug functionality. But the hotplug capability bit is set by
>> default in the hardware. This causes the kernel PCI core to register
>> hotplug service for the controller and send hotplug commands to it. But
>> those commands will timeout generating messages as below during boot and
>> suspend/resume.
>>
>> [    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug 
>> command 0x03c0 (issued 2020 msec ago)
>> [    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug 
>> command 0x03c0 (issued 2048 msec ago)
>> [    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug 
>> command 0x07c0 (issued 2020 msec ago)
>> [    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug 
>> command 0x07c0 (issued 2052 msec ago)
>>
>> This not only spams the console output but also induces a delay of a
>> couple of seconds. To fix this issue, let's clear the HPC bit in
>> PCI_EXP_SLTCAP register as a part of the post init sequence to not
>> advertise the hotplug capability for the controller.
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@gmail.com>
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

