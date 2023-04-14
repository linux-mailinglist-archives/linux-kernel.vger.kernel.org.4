Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CD76E1E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDNImk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDNImh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:42:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0149D7284
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:42:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id c9so4955653ejz.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681461754; x=1684053754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nHq+EupaWK5MJtpxLFtvDP9vBRUE48Hn964Cl/uitPU=;
        b=Ep7aohUyYcWRl/kaTHamdzHff2u5f5xcZ4Iw5ooCnS7pkFckU+HODvocte84UBAcEj
         B1qq0r+9M6SeYwxDKaYx3kTNnUiqZkTtdf6EKjZLQ+BGWxs+5+723Emh57fV0rGZplgn
         4GFWscqRr2bPu4rdn+ro8jCf2djKEocC3bsBn5c0OvTSpj6m6fRuFtShyHyofArr4rn7
         GFodPaUxzuP4ddXKJeyzjJf05HpbEvZQADKGP+QROzeHGCg9nKHKcVKjss9jeuXdX/EB
         lUoQPyX61cB8TvYJD+YQlGsANyOJfOQ9urNlf2lJa9kLbGatI6BJw/9rezk8eUTv5NRC
         3H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681461754; x=1684053754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHq+EupaWK5MJtpxLFtvDP9vBRUE48Hn964Cl/uitPU=;
        b=dRR29J08rQVDIle9zVmXaTypbDY6VtZAJGdKFNr96UICup6QmZ9uwxhaA0QZtBHYti
         p92WAmHX/TSjyVGCvUmGUbpvbLjTXpLzD56w2r1lJL4mng0SCeUy7+sv92zUGrELhQMR
         8yJnC3tCFFQ4wfOrSBOTh+mHgz00OtlletjfV44Ywl/6WQ15AGiiJZ2ZyMDs2/WrI1Ns
         4Pu757LFLGU9kj3suPyWdud/xoAHSctpHx+sl1aONDnLo2lQpeLlhKaxDRaXr+fjMDUx
         IycpxDocy1dLdgUZygz3WhUaSw8IIVT/GfSNl4xRqOSbC92JA3/zZj3OTM1RrkQ20PvD
         a85g==
X-Gm-Message-State: AAQBX9cnWE3dYUoa9jHjlrOinaZb2Xtugm3c7M8BeHuZ8fuhZXyjRI2U
        MJqv9JIa1uOh6YzmVVznrYN6AQ==
X-Google-Smtp-Source: AKy350ZPDeveGvHXCmasWX26jHul6oEoRldmgbv23zwBWv8n/OHBKJ910AjH/aWaKTzDvBSS1nAuXQ==
X-Received: by 2002:a17:906:da8c:b0:94e:aa09:1b4d with SMTP id xh12-20020a170906da8c00b0094eaa091b4dmr4495805ejb.36.1681461754336;
        Fri, 14 Apr 2023 01:42:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7dbcf000000b00501d51c23fbsm1878762edt.6.2023.04.14.01.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:42:33 -0700 (PDT)
Message-ID: <759c3b60-07f8-99c8-6ac2-73256538370e@linaro.org>
Date:   Fri, 14 Apr 2023 10:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 2/6] dt-bindings: hypervisor: Add binding for MediaTek
 GenieZone hypervisor
Content-Language: en-US
To:     =?UTF-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        =?UTF-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?= 
        <Liju-clr.Chen@mediatek.com>,
        =?UTF-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?UTF-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        =?UTF-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
 <20230413090735.4182-3-yi-de.wu@mediatek.com>
 <8ace9b0f-742a-7ebc-555f-1f8be04a5955@linaro.org>
 <7b4492efa4a1becbdfb79d23a0a0c0fe11dba5f4.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7b4492efa4a1becbdfb79d23a0a0c0fe11dba5f4.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 10:35, Yi-De Wu (吳一德) wrote:
>> I don't know if we actually want to support proprietary hypervisors.
>> There can be hundreds of them, one per each SoC manufacturer, and
>> they
>> can come with many ridiculous ideas.
>>
> MediaTek, as a partner of Android, our GenieZone hypervisor has been
> one of the backend options under Android Virtualization Framework(AVF)
> now.
> Thus, we'd like to donate these patches for better supporting the
> Linux/Android ecosystem.

If it is proprietary, I don't have much interests in it. Make it
open-source. :)

Best regards,
Krzysztof

