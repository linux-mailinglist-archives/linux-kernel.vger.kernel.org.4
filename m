Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AE8678166
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjAWQ3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjAWQ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:29:27 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDD02A160
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:29:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so9001664wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYip9GWskfVHIBBIoQtRteznfCeGMiqZdAOh3LjIB6s=;
        b=LkJyAX769ok4E4JcUot0k39R/d3fRhsW10FeUM4Fhaq8LlkBbeyO7096L6rUWrxJQa
         pakmJ9NsfDOd05w1H6OAEO3m3lT0LqWgIrNFHJL0thqciB1uvcvjAU27I75LNW/Rdf2j
         5KUfr4Y2KeQj7HXLtLy+0Sub5t4aixhmVouHmJBJYvEBA8mjM+itXZQJDzTigc2xfs6y
         U/hj7oe6riWg0H6qAtGLwdxk5pfzkQ8nBbjoY1fiz5KoWC8spGyAxi7bIkOp/EiVLtaM
         rSOO5a2VJ6emEHmnD6pwvhb6i/GXJ4Q5W7R8POgtu6CLR5mN6bKtRtIwA41BhhOvQLhs
         f9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYip9GWskfVHIBBIoQtRteznfCeGMiqZdAOh3LjIB6s=;
        b=ydA4npiWFzpbwKU62G/1Hf93JRElsd9j2mU6w9oUkVrjG7Lwaz02+wHLp6KvMwwqRp
         HsCVm2igNTV/08IS1ho9g/kYhgYaC3I7uftYziMGcv989LPca9b2cRsKWazTXIsG/PZq
         1ExxYK3eMl/yWHYYcxdqsFt2qTuqHEM9VnYd395hjgGfWIQLtWA0FwCOuKt9U9TCOWuE
         osWsOsB2w3IeP2KUZ8NsdVszYhCyosPYssA/YO/IjhjHhdQEW8JI7HK61/h3uheqxiQo
         WGpUjnfCRg9wg1GfEzHmOvs0HFrZgTYgrIKCZ7ZPoj7o4aia3tw33uMH1nxnwg7c36VI
         coPg==
X-Gm-Message-State: AFqh2kqSmm4gz7038MFn4RS6kWtBRWLpQqhejKNP3K4JCFM8rJ3e/Fih
        tZtBs83F+jiJvbnl3VO1hSwL5A==
X-Google-Smtp-Source: AMrXdXv71ESHVd++xiEU9uJkWLd5EhllxUfMLaUnU9IfMpqFXrhhLKO7UvbJiWMBQmhyBzmBvpryMg==
X-Received: by 2002:a05:600c:1c1f:b0:3db:2d7e:1204 with SMTP id j31-20020a05600c1c1f00b003db2d7e1204mr14480788wms.27.1674491364524;
        Mon, 23 Jan 2023 08:29:24 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b003d9fa355387sm10797513wms.27.2023.01.23.08.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:29:24 -0800 (PST)
Message-ID: <d8e750ac-aeb7-0d49-5d48-2591727ba4c5@linaro.org>
Date:   Mon, 23 Jan 2023 16:29:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 0/6] Add MSM8939 SoC support with two devices
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <42baa874-c926-9111-b0b3-2df2562d8de6@linaro.org>
 <Y86CPmgvAi+kChQI@gerhold.net>
 <133139cd-b8e4-3865-ddbf-9fa7d244ddef@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <133139cd-b8e4-3865-ddbf-9fa7d244ddef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 16:21, Konrad Dybcio wrote:
>> Please change it to VDDMX (without _AO). It will most likely not make
>> any difference
> Wouldn't it make wake-on-wifi-with-cpus-off possible?
> (obviously given the wlan chip supports it and can ping
> the cpu etc etc)
> 
> Konrad

WOWLAN is done via SMD not by raising of an interrupt between WCNSS and 
APSS directly and we do hit VDD min with AO in 4.19.

So, so counter-intuitively so long as the SMD interrupt is unmasked in 
suspend - not a specific WCNSS interrupt, we will wake on WLAN.

Its a complete tangent but, the WCNSS firmware has an SMD RPC call 
called "wake-on-wlan" or somesuch which *would* wake the system via 
interrupt but, appears to never have been implemented...

Anyway.

---
bod
