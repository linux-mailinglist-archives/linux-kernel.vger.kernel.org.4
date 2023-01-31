Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1D2682BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAaLz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjAaLzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:55:22 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03F627D56;
        Tue, 31 Jan 2023 03:55:17 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso10389977wmq.5;
        Tue, 31 Jan 2023 03:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7T2E7YGZUxnQitNuZE0hLv5dl+y4GpbNZv5kH0Kb700=;
        b=QCtUdV+nxVMdpJAnGPdQSvt5DtG9XwOeCRtncRoCxjAXUus2HMQc1Ao+U8Vnzo2xJZ
         TfQIEx5H2H0Aga7AXpeStNtqBRad+adVwfggxMC1VO9I8saFhOhw8Gr9R97ijwYK8UFz
         1pFUd+WzT66AAlg+M2/xQJh9mHu1TwJGhqR3/TVDO5wOV27DC2mF9BswtlUAzzD9x4aF
         oeyCM2CctTa4BGNAUD0+TZms15Suu/QtaBqB1NgaZGBUQt4oii63RG894XaJXcjU1042
         sibft0fM0CHnHPhHXK6HH282KEPa8Dx6zjDvoa8DLURhUe6rgNR4dh4odk8yQmIu0Vad
         4NCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7T2E7YGZUxnQitNuZE0hLv5dl+y4GpbNZv5kH0Kb700=;
        b=WZC4qhnQSNla18ekb1/YcGWYsl9H3UaIiLYGTWN6TWnmM9bHPY1LOf97Kt3/MALys3
         0IPgE9cfuJZMUx1j7Ra4xcKiI8X7CQwIVZo9NBUA1vO1KxM0ApUnuaupyl/O1/CF843d
         U0vXTt7KCKNb+WehQwaY+jN6d3FR6viw11g8CrxFEgVelLjLdfLvEksRhxDp7ovCbNlC
         Pqk4C4HBEuatGAYU14LJiKzgRF+mM2PRw70eBDE7w/MxgM3SmiXQnBtkDeo5ltq/0NcD
         oRGAQ2LMyIvjiNPrnNZB2kuvD7EhMME81alj6A8fiWwHJKmL9nf4tJhRkEjKp2EYJXmX
         j9/w==
X-Gm-Message-State: AFqh2koCQEsCwhXvG+G/Rkrlzr+LJUtOzTyPjCHUwqJU6eVXFe8D5z3C
        yFfAAg/6ZxVly/dumehbiYM=
X-Google-Smtp-Source: AMrXdXvQTDWtQ2BfIU2sS6xGo/Q/5VUOHWqRtF42ZHbBXU1Lw+xJrn6/r0acAJZllhbPgT+JbH/Uww==
X-Received: by 2002:a05:600c:a4c:b0:3dc:d5b:5f6a with SMTP id c12-20020a05600c0a4c00b003dc0d5b5f6amr28617250wmq.30.1675166116306;
        Tue, 31 Jan 2023 03:55:16 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b003dc22ee5a2bsm17949467wmo.39.2023.01.31.03.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 03:55:15 -0800 (PST)
Message-ID: <c78e2725-0be7-caa8-40db-2f355cc2cdec@gmail.com>
Date:   Tue, 31 Jan 2023 12:55:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/5] arm: dts: mt7623: mux phy0 on Bananapi BPI-R2
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        frank-w@public-files.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
References: <20230120205318.519493-1-arinc.unal@arinc9.com>
 <20230120205318.519493-5-arinc.unal@arinc9.com>
 <9A7BD95A-F026-4EAB-96E1-12B1B0C6AAA4@public-files.de>
 <cf7d3247-4d21-98f0-819b-7653153ee4c0@arinc9.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <cf7d3247-4d21-98f0-819b-7653153ee4c0@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/01/2023 17:54, Arınç ÜNAL wrote:
> On 25.01.2023 19:41, Frank Wunderlich wrote:
>> Am 20. Januar 2023 21:53:17 MEZ schrieb "Arınç ÜNAL" <arinc.unal@arinc9.com>:
>>
>>>         switch@1f {
>>>             compatible = "mediatek,mt7530";
>>>             reg = <0x1f>;
>>> @@ -199,11 +208,6 @@ ports {
>>>                 #address-cells = <1>;
>>>                 #size-cells = <0>;
>>>
>>> -                port@0 {
>>> -                    reg = <0>;
>>> -                    label = "wan";
>>> -                };
>>> -
>>
>> This will break existing userspace setups using wan as interface name.
> 
> Yup. The OS being used will have to either rename the interface or adapt to the 
> new name, eth1.
> 

In that case please explain in the commit message why this is needed. We are 
trying really hard to not break userspace by a device-tree update.

Regards,
Matthias
