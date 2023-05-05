Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABFE6F7D0C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjEEGkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjEEGkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:40:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A97115EC5
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:40:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-965a68abfd4so253933466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683268807; x=1685860807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aTyxP1vj9LhqUkDcFtKF0jIyEwscl+LdksMcxhoHIX0=;
        b=G0z6pdfLLcpRXBMfXu84fwOiLH0bYZ8N7aA7FRIkIs0vmuL5QK+Hg79DyL5CSrXb5V
         pDi6+8ung1wbRWg4QD9/iahFef2T8Fw5inu/rt85I9j9MZb3MQYjV1WBLLGxkayID4Q+
         9y/RD2zLE2X7Qxcb1qMa3PVbD1JRwS1mNiSx8327nKJJDeK8GE7jBN6pKMsJYCCn4wAy
         3IlDplqBMPEgFJVRHOu5aGcqkLm1pjC4wXuE6UApKlM6foHQ+MlQFPJ8TUpivm+ZJ8ea
         zMhL/XQhIod4bPJfcGEWa016dW+/WsPBzztT8vbMfGKHLolZ6QN+rsOU7eBE05dnJEws
         Y7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683268807; x=1685860807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTyxP1vj9LhqUkDcFtKF0jIyEwscl+LdksMcxhoHIX0=;
        b=b6FR1R347glAkAW473OFT132NXIiETOBKKMOs1vwYwDoOo/vIA72l4ZeIgtGUtj093
         hYCwUH5Ivukmuzzw7iyuINQRyvRtSZNIQJIeArJ1bz5exIryzPQHDtW/1j8lZL/nd9eT
         r8DXLXIFlACKJfwQTMcSqPSm3dSCl+0xmTygworCluZso3n/0xnEeYoE5oy58KNFRSwF
         JTKwFNiVwE/YkIRs02E6hmfhWinOEahgmuqxuUWqTwJMFs4+kiIDRcbLzmaK8vWarr54
         D9ub2XXRQp7n9kguOzTANfcfselSMR+3aJEI5bqHzPKREZo9CFbJ8OoX4bJKSEXu6wCC
         Q4kg==
X-Gm-Message-State: AC+VfDzujTePMR9fKF1mNBdXkMx0PEUUnUpJ8zuenLwS8tsv4mVvWVZ5
        A3ykYLxn+wk9WgIoi1CJ/IKg7g==
X-Google-Smtp-Source: ACHHUZ60yiXciR7c56Q3PWRYkZepdVsaqppKAlJGiNIex8+MxKDx3TzcHvQ6hw7Gfdaj7zjLGfntrA==
X-Received: by 2002:a17:907:6d1f:b0:94e:f1b9:e933 with SMTP id sa31-20020a1709076d1f00b0094ef1b9e933mr236593ejc.53.1683268807573;
        Thu, 04 May 2023 23:40:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id ak19-20020a170906889300b009545230e682sm522940ejc.91.2023.05.04.23.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 23:40:06 -0700 (PDT)
Message-ID: <925bf170-bb54-b427-976a-87e0dca230da@linaro.org>
Date:   Fri, 5 May 2023 08:40:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 0/8] Add StarFive Camera Subsystem driver
Content-Language: en-US
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230413035541.62129-1-jack.zhu@starfivetech.com>
 <14c06503-621f-2477-7b15-b17f1890ecfe@starfivetech.com>
 <7bd29805-11e7-68ee-aa47-68bae2a2fb38@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7bd29805-11e7-68ee-aa47-68bae2a2fb38@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 07:57, Jack Zhu wrote:
> 
> 
> On 2023/4/24 19:19, Jack Zhu wrote:
>>
>>
>> On 2023/4/13 11:55, Jack Zhu wrote:
>>> Hi,
>>>
>>> This patch series adds support for the StarFive Camera Subsystem
>>> found on StarFive JH7110 SoC.
>>>
>>> The driver implements V4L2, Media controller and V4L2 subdev interfaces.
>>> Camera sensor using V4L2 subdev interface in the kernel is supported.
>>>
>>> The driver is tested on VisionFive V2 board with IMX219 camera sensor.
>>> GStreamer 1.18.5 with v4l2src plugin is supported.
>>>
>>> Changes since v3:
>>> Patch 1:
>>> - Modified port@0 and port@1 properties.
>>> - Extended the port@0 example with appropriate properties.
>>> - Added 'port@0' for 'required'
>>> Patch 2:
>>> - Modified spelling errors.
>>> Patch 3:
>>> - Merged patch 5 into the patch with an explanation for compatible in
>>>   commit msg.
>>> Patch 6:
>>> - Asserted pixel_rst[i] reset in the loop after the err_disable_pixclk
>>>   label.
>>> - Modified Code Style for getting sys_rst and p_rst.
>>> - Renamed clk_name to name and modified the relevant code.
>>> Patch 9:
>>> - Added static for stfcamss_get_mem_res function.
>>> - Added static for isp_close function.
>>> - Fixed implicit conversion warning for stf_vin_map_isp_pad function.
>>> - Dropped unused variables.
>>>
>>>   v3: https://lore.kernel.org/all/20230331121826.96973-1-jack.zhu@starfivetech.com/
>>>
>>
>> Hello everyone,
>>
>> From the current review status, the patches related to the CSI module
>> have 'reviewed-by' tags. I would like to know if it is okay to add
>> patches 1-5 from this series to a PR first.
>>
>> Thank you!
>>
>> Jack
>>
> 
> Hello Mauro, Laurent, Maxime, Rob, Krzysztof, Robert, Todor and Philipp,
> 
> Can you give me some suggestions and comments on the previous request
> to commit CSI related patches first? Thank you for your time.

You received very specific feedback, so know you decided to ignore it?

No, implement what you were asked for.

Best regards,
Krzysztof

