Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4806E75E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjDSJBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjDSJBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:01:01 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69C812C96
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:00:58 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51f597c97c5so1235149a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1681894858; x=1684486858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Ri0q2/V4tp17Jo0FXn5qCoZ/hu41lgkAXDj8GUCjG4=;
        b=e6FJpg1/lSg6Fzj64vBbsl3hJAjBsz1G6UqWuw88c4fCh0Ew+10L4n3OelrDuC/FYl
         T9bPIjDBNkK8VJgcBXm/Y44QI7KGymGCU8jRiql7yqxtIn6E5UtgM9PN2lBQQ35k6Hii
         MxFmS5MtHJzoqeTTkVde59z2lr+YDlX1hvdSMPFsG2qt6rJmJ/IKVwnRYVMalzsQMndr
         WfvI7BkSiEvkIKby0wY4PP407ZIZfBlD+SilDCXTaVRheNk19wY8jBX7r4u1M0WeeoRp
         Lqp/1jduTdNNC2GmwNkkWoktbumIo8+SLEGDZeLo2Df88eg2DxTrKyykm4Zv7/JnMJ5R
         MZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681894858; x=1684486858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ri0q2/V4tp17Jo0FXn5qCoZ/hu41lgkAXDj8GUCjG4=;
        b=fYJGE04NFwG5oibPl/8HZcgsB1eCzNJr+LPo5SiXL4H35YCwBIJFbky9ocUjKrMnVH
         FuKppTgzH4RvT0rhiBGdS1UmVC+sNxqGoKep2j2HTTINC27K/RO7LxDYdmuPj96Se/3N
         Gmv8DdmSJS0hEEc6JplLdsa4pzUHQs8NOwytAdvuqVJaGTEM3RiHMca6DMaxMSLIdlr9
         ZWU+w9BsWMoPnxZcYDcRpoQTcupJCS1w4/UZthCCFE/dcuixUOIt3ZfTgn7bEWzAR6GC
         QqvWckRpHLudErMjdugqP0xzIY1OdilzcPEcvafvYLhFPhF/1bpg29qhiKhfjEWq7taI
         6/Nw==
X-Gm-Message-State: AAQBX9cTOje26Jjug39ZSvqMkOLZlUOJT5zyvVXMPHauDVBWBRx0MqnJ
        W0SuHj4aALTiDuKcz2srHo5Tww==
X-Google-Smtp-Source: AKy350b6IXvh1v6ck6A/sCyMXZ3FN45V2eFT0zulVRY/vapMyIBlskFX9zTC4ovnUc9DmdwJuOK7Bw==
X-Received: by 2002:a17:902:f683:b0:1a9:20d6:3c3f with SMTP id l3-20020a170902f68300b001a920d63c3fmr631660plg.55.1681894858066;
        Wed, 19 Apr 2023 02:00:58 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001a19f2f81a3sm10976492plb.175.2023.04.19.02.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:00:57 -0700 (PDT)
Message-ID: <e63bba13-05f0-7d1b-bf11-04ef5eda3afd@9elements.com>
Date:   Wed, 19 Apr 2023 14:30:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add binding for max6639
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230418113217.781524-1-Naresh.Solanki@9elements.com>
 <742f546b-3952-32f4-9f20-3a355785d162@linaro.org>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <742f546b-3952-32f4-9f20-3a355785d162@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krysztof,

On 18-04-2023 09:47 pm, Krzysztof Kozlowski wrote:
> On 18/04/2023 13:32, Naresh Solanki wrote:
>> Add Devicetree binding documentation for Maxim MAX6639 temperature
>> monitor with PWM fan-speed controller.
> 
> Subject: drop second/last, redundant "binding for". The "dt-bindings"
> prefix is already stating that these are bindings.
Ack
> 
>>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   .../bindings/hwmon/maxim,max6639.yaml         | 55 +++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>> new file mode 100644
>> index 000000000000..20b28cd36555
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>> @@ -0,0 +1,55 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +
> 
> Drop blank line
Ack
> 
> This is v9. Where is the changelog? Where is previous authorship? At
> least some parts of it? Why this has less properties than old one? Why
> this has more mistakes than the old one? Go to previous patch... or fix
> everything which was already fixed.
This patch is to add basic dt support only hence no additional properties.

> 
> Best regards,
> Krzysztof
> 
Regards,
Naresh
