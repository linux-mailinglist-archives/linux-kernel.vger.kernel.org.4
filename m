Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957445B2F80
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiIIHMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiIIHMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:12:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4510B2CE9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:12:01 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s10so126567ljp.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QOGLHZxJ3ehuwDP9HL0oLd7ufIS2rSRxC4FcV3nNb7s=;
        b=BWyXu++1uPwlKzxQQu+DxoxMeR/JrBSuK9lG6Z9QndN/sYkYtdJDhOaHN+s02etnn4
         OL3wW5pNwdxnhZHVAHt2/Vu/SkuOdEwcfO+mvG1g8/txQSDyPKe7zG6vHylL7omUjsHt
         sVCs87b7Yi/DcC/lyE6FsOEClx+iOGX+8QrBqSh1fMDxBuawlPraG4oZom4seGwsfryU
         IdUZE5aQq2EWHir43pvP0Qc0MJUvfMDTpfOl8s2yHolA970UkuJNpfhNMwr365Tw1I3h
         /bgH/n22xSXSryutBPlgdQrOhtfEYi0nEmzX0VKSnDKiZdiKN3/MZfEBC+Xj6GEXrVnR
         O56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QOGLHZxJ3ehuwDP9HL0oLd7ufIS2rSRxC4FcV3nNb7s=;
        b=J3uUIE1zKkNUv5D3WPKZfycOvgdgEG50dZ7swvaZuRVlj/fH39mywc2rG5x643Eppy
         FOpYsdLREh4Yi6whj77rxFoXPsaBv8Uh93qP7/sioOCwkqs94w8BhkYHS/WHl4+i1wVq
         Sx9jNTPVEg6rf1MDtpGGjjDY7IUduVzpWTuo12iFUmDGACPQpp58uoj46oXoFBrIhAt7
         2kse07WjiFh9yhvy1C9gqIGbPTxyAZ5xXcnYioZ0ZQNoCHDrnLlzWRyGWZKea8n/AkyP
         Dcxx9Wv5YtSKX0d2pXK6XnA6XMMp+JgcrkO4ivkA6tMWA3DbSyNbkWI+3TKiXTVemvaz
         6q7A==
X-Gm-Message-State: ACgBeo3pRoVb0p23RHvaYbllsUEVR1dNzDtbPUaOZ6dIb3tFCQ+EelbU
        X+p8rVBhXyZNwFqfhV0r21PBWfebfXGRDQ==
X-Google-Smtp-Source: AA6agR5O2hfbFRKJ4pK/M7SIHVCeEmYbk7TXkg8QE0//OgIRJ37GSP2kOJFWCJOE92oCam0WI8m9sw==
X-Received: by 2002:a2e:2f03:0:b0:261:cb0e:c329 with SMTP id v3-20020a2e2f03000000b00261cb0ec329mr3277972ljv.106.1662707520203;
        Fri, 09 Sep 2022 00:12:00 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m5-20020ac24245000000b00498f36bce07sm150242lfl.214.2022.09.09.00.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:11:59 -0700 (PDT)
Message-ID: <d7fc281e-64e7-239f-8c53-1d494eaa69cd@linaro.org>
Date:   Fri, 9 Sep 2022 09:11:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/7] dt-bindings: phy: mediatek,tphy: add property to
 set pre-emphasis
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20220829080830.5378-1-chunfeng.yun@mediatek.com>
 <20220829080830.5378-2-chunfeng.yun@mediatek.com>
 <d1f49935-b465-7495-d345-f35bf4dea9f9@linaro.org>
 <d30353e4dbb785c3ce31ef54b791bfe3d23df904.camel@mediatek.com>
 <82576790-9fb0-ee1b-2308-fbe292068bd9@linaro.org>
 <113219ac80cceaa4a39434e4370db821e26a5275.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <113219ac80cceaa4a39434e4370db821e26a5275.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 05:07, Chunfeng Yun wrote:
> On Wed, 2022-08-31 at 09:02 +0300, Krzysztof Kozlowski wrote:
>> On 31/08/2022 06:14, Chunfeng Yun wrote:
>>>> These bindings are expected to be
>>>> usable/applicable on several devices, so units, not register
>>>> values
>>>> which can change between devices, are the proper and reliable way
>>>> to
>>>> describe a feature.
>>>
>>> I prefer to use exact level values, but not the inexact values with
>>> units (e.g. -percent, -microvolt).
>>
>> What stops you from using exact values - bp?
> See reply for the first series, thanks

Not in my inbox anymore.


Best regards,
Krzysztof
