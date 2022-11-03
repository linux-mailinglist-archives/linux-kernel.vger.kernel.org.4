Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC8661828B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiKCPX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiKCPXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:23:22 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8401100C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:23:20 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x18so1336450qki.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7W935H1KbRw0Ag8QHM/Yn3lqfyL9ka2fjOWNd1WB1I=;
        b=c6nzyMKW9ZnRtwa3zp76mKQ0QUn6sfJTsCuR8G4mpyrAxY54i5HSj7n6qSXMzftZ17
         80m8TF5uOv4YXZFb5VC0HmjwMnd6inedHNSNgA/GcUaOnKei0IiD8BOi1vbZsOT3tCrI
         2rYW/hQUTMKwCfn/T+utoFWvmmllBQXjZ2ykiqhGEKoT+MMUr/5ktX6RzNjmD+Ui3/H9
         fy2n71ovs22yMfa2zo0wpjYYsPnfkDH99eq4X9KS1qirEdUCL8ckTwy/BMhKjCVuj5pf
         aQFXgOmQYassXRfNcYJx49mTSK1RIhc+rbvLzJdyLlYLDfmWSt5LntqoE0eIHTUc7aCs
         aKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7W935H1KbRw0Ag8QHM/Yn3lqfyL9ka2fjOWNd1WB1I=;
        b=UhlaYvpS/hoPt9VvYB0g8kMiMlwRo4axHI2IYJHss3Sy+GKAfcVZdShdEUysrjgSRB
         juYw3GtsfPiKKadslQEylH61Z9SkmhgcM9ijFtBR0lDs9L5Hf1MHfQDKRIPvcuqX7ZhO
         XZ0WZALFMBaUfmBVj69FRRvPkpX+PEbBDcDwgZ6iVmgmp5gpuD6aiUOK81vhwSuf65ia
         K7oVTqESkvRo7l8N0mfrEhQPkFt3U5Y6D1Cl/pZoJyshtOq7c2JWH66rHckg4ocyY4js
         hSDbq5hXGsQnEsxa2JEvLPVKib1o9piztGdUkntY+3LfvdHD3Z0p5Ghd0lQZ57RT85Ha
         +l8A==
X-Gm-Message-State: ACrzQf0JnFV42fr6BrG1e+pUllINrBjvw48x/yuPuGvZh6FfAaKY2b8j
        kEZlfmm0qQUsTrITxRwBJXeWIg==
X-Google-Smtp-Source: AMsMyM5I530rv1Yc4w34Zr+5MBIkr1bF9RF9uIG79s0fyenDsdb3MXMg/hmpxWiucjGppUIk5oaTNg==
X-Received: by 2002:a37:de03:0:b0:6ee:88a2:eb9a with SMTP id h3-20020a37de03000000b006ee88a2eb9amr22330615qkj.241.1667488999874;
        Thu, 03 Nov 2022 08:23:19 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id h6-20020ac85046000000b003a494b61e67sm675911qtm.46.2022.11.03.08.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 08:23:19 -0700 (PDT)
Message-ID: <a170e4e8-fc9d-9be1-35ba-733f24cb93e8@linaro.org>
Date:   Thu, 3 Nov 2022 11:23:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 06/15] dt-bindings: ufs: Add "max-device-gear" property
 for UFS device
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, dmitry.baryshkov@linaro.org,
        ahalaney@redhat.com
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
 <20221031180217.32512-7-manivannan.sadhasivam@linaro.org>
 <1fe8fd96-7770-0bda-c970-aa38d030ff3b@linaro.org>
 <20221103122850.GD8434@thinkpad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103122850.GD8434@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 08:28, Manivannan Sadhasivam wrote:
> On Wed, Nov 02, 2022 at 03:09:50PM -0400, Krzysztof Kozlowski wrote:
>> On 31/10/2022 14:02, Manivannan Sadhasivam wrote:
>>> The maximum gear supported by the UFS device can be specified using the
>>> "max-device-gear" property. This allows the UFS controller to configure the
>>> TX/RX gear before starting communication with the UFS device.
>>
>> This is confusing. The UFS PHY provides gear capability, so what is the
>> "device" here? The attached memory? How could it report something else
>> than phy?
>>
> 
> This is the norm with any storage protocol, right? Both host and device
> (memory) can support different speeds and the OEM can choose to put any
> combinations (even though it might not be very efficient).
> 
> For instance,
> 
> PHY (G4) -> Device (G3)

Yes and look at MMC - no need to define "max mode" supported by eMMC.
You define the modes supported by controller but the memory capabilities
are being autodetected and negotiated.

> 
> From the host perspective we know what the PHY can support but that's not the
> same with the device until probing it. And probing requires using a minimum
> supported gear. For sure we can use something like G2/G3 and reinit later but
> as I learnt, that approach was rejected by the community when submitted
> by Qualcomm earlier.

It should be then referenced somewhere as it might be a reason to accept
the property.

> 
>> The last sentence also suggests that you statically encode gear to avoid
>> runtime negotiation.
>>
> 
> Yes, the OEM should know what the max gear speed they want to run, so getting
> this info from DT makes sense.

Not really if it is auto-detectable. Just because things are static is
not the sole reason to put them into DT. The reason is - they are not
detectable by OS/firmware thus we must have them in DT to be able to
know it.



Best regards,
Krzysztof

