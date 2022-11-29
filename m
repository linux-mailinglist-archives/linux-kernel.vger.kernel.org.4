Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2543E63BB82
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiK2I13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiK2I10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:27:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7A55656B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:27:25 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id x17so20819427wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fC0Ojnx6/B78FbeaxNlNaS5gHEZKTLKTPBVMbnEU/Uo=;
        b=vqbla1SYWRt1WiOApwfF8a1m+eCPIDP40A9UnBLUW4pDWhEteS841d1Qsa+JFpEn5R
         Q6ScJdCUdlvzTUvV9sv1uL5V3IRYQ/YK77o2NtHM/ys2rRWuPW88u6PX1R4TFy57hx19
         WwK/wp/ARbrwPSBlq6jj16I6d+hz+nBGT1/hk9opG9zpfA2YXhCgeClf4lImIgW/JHkG
         /JbHYrmtGfmagdk1MKpd5f04ODZAewuoAinapLBvIVhlZ2WT5ZvaLWEj/Neo1Dt3h3vq
         f7HsntfUClDlrWqvgC8GH4TXLov4gWwZwZWOP3cSPET9LGi9j80tBXWcqWwLQ+1+ISbQ
         Zpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fC0Ojnx6/B78FbeaxNlNaS5gHEZKTLKTPBVMbnEU/Uo=;
        b=Rl+jrzfhteqC0U529YlnE3WdBKBgeE5tU8R1h2w/11AqLKRciQZ7YWFS8wBT4K/+RF
         rwLi8qEK66uSgqtSgxKCbvtL4TIb9K9nv3updnRg98mTFYW+ifHF6IYrYmCJc3IKeAYx
         AUCmIuoMTtfhzY5y1lKyC/3jc4AGnKdcC8c1wF1sxrxQ+oNbr8uRHB5jBvVBrjKagfPL
         wyIoH/tOyuX3K0sFMSngcwLJVO2PYHSwnMXOlRrRC3c+Piz/LQQyGV78/IX3u/GGcsvt
         qBYSFjCkbwKLnvOFr5qklG5T73374Xp9WBDYmzqnaauSU0JyGXFq7N6SyPB9vCyn7nHf
         xu/A==
X-Gm-Message-State: ANoB5pmxytNZFKX0u/lngIV1Ychs3fO3Dbn1rP719rRt4+SalaYdU+Wx
        9jn9fpzHOw0MExqd7HcPab2WGA==
X-Google-Smtp-Source: AA0mqf5sna9CUiSoFrFut2DuhcjOVxisdEhSsZ7ova8PCj0QwmiRq7tHLberlUIwj5EZnNdk85HROA==
X-Received: by 2002:a5d:6891:0:b0:22e:54da:a4f1 with SMTP id h17-20020a5d6891000000b0022e54daa4f1mr33612237wru.637.1669710444088;
        Tue, 29 Nov 2022 00:27:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2f85:a28c:5df7:9cd2? ([2a01:e0a:982:cbb0:2f85:a28c:5df7:9cd2])
        by smtp.gmail.com with ESMTPSA id 124-20020a1c1982000000b003cfa81e2eb4sm1187980wmz.38.2022.11.29.00.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:27:23 -0800 (PST)
Message-ID: <891304de-c216-fecf-00ee-d70d61c847b6@linaro.org>
Date:   Tue, 29 Nov 2022 09:27:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: reserved-memory: document Qualcomm MPSS
 DSM memory
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
 <5b1eb21c-92bf-59bc-25c5-f8c38c42b375@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <5b1eb21c-92bf-59bc-25c5-f8c38c42b375@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 14:57, Krzysztof Kozlowski wrote:
> On 23/11/2022 11:19, neil.armstrong@linaro.org wrote:
>>>>> We have already three of such "memory region devices" and we keep
>>>>> growing it. It's not scalable.
>>>>
>>>> If we want to properly describe this, we must then represent the MPSS subsystem
>>>> and associate this memory region.
>>>
>>> I don't see why. None of devices in your DTS reference this memory
>>> region, so it is purely to keep it mapped for Modem, right? In such case
>>> I still do not get why PAS/PIL, who starts and stops the remote
>>> processor, could not prepare the memory and share it with modem.
>>
>> OK you've got a point, but this is still an implementation detail.
>>
>> I got some more background about why this memory zone appeared, before it
>> was including in the modem reserved-memories, but for flexibility reasons
>> this is now in the hands of the APPS runtime (linux) to setup this memory
>> zone and share it to the MPSS subsystem.
>>
>> So the only requirement for the PAS is to make sure this zone is shared
>> before starting the startup process, not to actually do the share setup.
>>
>> The zone will need to be shared whatever the PAS state is (probe, startup, remove, ...).
> 
> I don't understand here. The memory region should be shared before
> remote processor start or before the PAS probe? If the second, why? What
> if your driver probes a bit later - after PAS probe? Then all is lost...

After offline discussions, I'll associate the DSM memory zone to the PAS MPSS
loader instead to make sure the zone is shared before startup.

Thanks,
Neil

> 
> Best regards,
> Krzysztof
> 

