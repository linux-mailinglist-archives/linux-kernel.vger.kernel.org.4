Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E756F82DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjEEMYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEEMYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:24:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FA519D59
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:24:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc37e1525so3236744a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 05:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683289474; x=1685881474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+J3eJ9rAr0Anc7jTVTfZv8HQJ6Km2BEzdl+jDxdnjQ=;
        b=mpCXaWYjwVF9T60fJELXiXgOGrRUxFskLmWMmGjFsVr9pYVHGh41sHvSANfySraYPq
         FxjzoDK6hqOED6ZaAVZBINZ4balvN2lT5yS85N+DOg1fr1QfsLciGevJmi6gYk/oie6H
         LLzcBuyJ/IsYPvH72reKvHe+tR+PJyYjVL9Bcqt9IQsKeKRGCtNI8d9qudPm+zheV4Rv
         iosiPVoFfbjAgOewjWz8OZRSrXDPXgF7jM09jJULUtf6ZbQWrEkrot6xonH6/5Uo53kX
         fLXJp+2UGcaIrx3tDLvPOC3Gwj9n1hmnLqk7Jh55a+9Yps+CKv2Ab3NMKwmaVB8dT994
         023g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683289474; x=1685881474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+J3eJ9rAr0Anc7jTVTfZv8HQJ6Km2BEzdl+jDxdnjQ=;
        b=HhezNS4Z9KNnNMX/HYh4Hyy8wusGFga9qswl6kgGfqOv/f/JA1YZIYB94aww1QgQIj
         P5aTUka0a/ERclQoHQP26wzTuyN7zYq4KGnhqZj/MOZdYu/cdSKyopEJyWz9VERRVKhu
         vbvoaUMLCuNz87uKzdMdgFaEezXwsMDxuzlWGZP9Xuoku/woBfoud4o49ovUSKN1AxDR
         ARTKID8h6k+GlwvB/+TT7wijezo+3nT207xJ0mzfiYZbe3yVIZ1j2LUT7PqnetAdKhEu
         cFfB45yZPnW02XTbRh74oIVpwCJIhvs0BC+xHfgDHiX7OWntxNwqS+r6EumIUxD3NqoH
         dHxg==
X-Gm-Message-State: AC+VfDzO5JAqVeMuOq0AH/qfvBMVlTWd8abWpoWk6LKzFIDEmjs23Kfc
        XTnoSOtXgNkbro7fJ+VmkY00dA==
X-Google-Smtp-Source: ACHHUZ7XXQzqvBr/9IQJvWOwjqwXpa8SpSp8T8lg2RLLJpcPx3Ukf+D9VGZzyq30KdybZpFJrCr9Rw==
X-Received: by 2002:a05:6402:398:b0:50b:c4b7:ee7c with SMTP id o24-20020a056402039800b0050bc4b7ee7cmr1177934edv.36.1683289474481;
        Fri, 05 May 2023 05:24:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id n24-20020a056402061800b0050bd245d39esm2909078edv.6.2023.05.05.05.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 05:24:33 -0700 (PDT)
Message-ID: <ef7ab2dd-8f6c-a7f2-7aa6-90fe1caa96b4@linaro.org>
Date:   Fri, 5 May 2023 14:24:32 +0200
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
 <925bf170-bb54-b427-976a-87e0dca230da@linaro.org>
 <817b8919-e9dd-cf2a-41e0-9b50747ab4cf@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <817b8919-e9dd-cf2a-41e0-9b50747ab4cf@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 10:14, Jack Zhu wrote:
> 
> 
> On 2023/5/5 14:40, Krzysztof Kozlowski wrote:
>> On 05/05/2023 07:57, Jack Zhu wrote:
>>>
>>>
>>> On 2023/4/24 19:19, Jack Zhu wrote:
>>>>
>>>>
>>>> On 2023/4/13 11:55, Jack Zhu wrote:
>>>>> Hi,
>>>>>
>>>>> This patch series adds support for the StarFive Camera Subsystem
>>>>> found on StarFive JH7110 SoC.
>>>>>
>>>>> The driver implements V4L2, Media controller and V4L2 subdev interfaces.
>>>>> Camera sensor using V4L2 subdev interface in the kernel is supported.
>>>>>
>>>>> The driver is tested on VisionFive V2 board with IMX219 camera sensor.
>>>>> GStreamer 1.18.5 with v4l2src plugin is supported.
>>>>>
>>>>> Changes since v3:
>>>>> Patch 1:
>>>>> - Modified port@0 and port@1 properties.
>>>>> - Extended the port@0 example with appropriate properties.
>>>>> - Added 'port@0' for 'required'
>>>>> Patch 2:
>>>>> - Modified spelling errors.
>>>>> Patch 3:
>>>>> - Merged patch 5 into the patch with an explanation for compatible in
>>>>>   commit msg.
>>>>> Patch 6:
>>>>> - Asserted pixel_rst[i] reset in the loop after the err_disable_pixclk
>>>>>   label.
>>>>> - Modified Code Style for getting sys_rst and p_rst.
>>>>> - Renamed clk_name to name and modified the relevant code.
>>>>> Patch 9:
>>>>> - Added static for stfcamss_get_mem_res function.
>>>>> - Added static for isp_close function.
>>>>> - Fixed implicit conversion warning for stf_vin_map_isp_pad function.
>>>>> - Dropped unused variables.
>>>>>
>>>>>   v3: https://lore.kernel.org/all/20230331121826.96973-1-jack.zhu@starfivetech.com/
>>>>>
>>>>
>>>> Hello everyone,
>>>>
>>>> From the current review status, the patches related to the CSI module
>>>> have 'reviewed-by' tags. I would like to know if it is okay to add
>>>> patches 1-5 from this series to a PR first.
>>>>
>>>> Thank you!
>>>>
>>>> Jack
>>>>
>>>
>>> Hello Mauro, Laurent, Maxime, Rob, Krzysztof, Robert, Todor and Philipp,
>>>
>>> Can you give me some suggestions and comments on the previous request
>>> to commit CSI related patches first? Thank you for your time.
>>
>> You received very specific feedback, so know you decided to ignore it?
>>
>> No, implement what you were asked for.
>>
> 
> Hi Krzysztof,
> 
> Thank you for your comments.
> 
> I am talking about CSI-related patches 1-5, not including the patches
> 6-8. The CSI module is a relatively functionally independent hardware
> module. The CSI-related patches 1-5 already have 'reviewed-by' tags,
> and there are no unprocessed comments left. So, made the previous
> request. Please let me know if I understand something wrong.

You pinged also me, so we talk about bindings. You got comments to fix,
so if you are not going to fix them, the patches will not get accepted.

> I don't want to ignore any comments, I will continue to modify the isp
> patches 6-8 in subsequent versions according to your comments. The
> ISP-related patches are being prepared.

And how are these patches related to me and Rob?

Best regards,
Krzysztof

