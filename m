Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E9364B0A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbiLMHy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 02:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiLMHyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:54:53 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A8C13D67
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:54:52 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id b9so2479091ljr.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cPlI4nlgNU5D40TkG6JLt33HBjBE3G2bPLlqKNxnC2s=;
        b=DyvuGOSvZI2+HP78j91KXO3eokTzSKut3RdwodSApwdLcp+W5acFS2brKCLVuNOe7w
         GbqcutpzzyFqJtybUl6JirI6bMfNqIAQbg9oHGVoGrqmNC3IkAIrOjTW93fSwyPoUPdh
         bu62dwq2DKnFCoSfK2Y2FlQ7LjcLxD7+ZzGugZPZGB41tUb7gY+UMcWuBp/elFWB4/II
         EMBjY/Dekj3DZAtJFmeuIqAOTPf9ORwlBaGh/vwGl2nsJo0hFMpwwnO+yNRSaaGo0zLn
         I4Zpt4clSj6JSzupzHC6aRVUT2LVyQt0wb9cJE4cwbeRutKQt1GG/ny7pQ0v9e1hBXoJ
         U16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPlI4nlgNU5D40TkG6JLt33HBjBE3G2bPLlqKNxnC2s=;
        b=eYfxJDwhtyHl5UsqBmZqaUjkMi22XMhwSynuroPrAwOlLpvkQBte9RgqEcX0bLe6rj
         Pd7pzZUw+oLO22c8Fd3kqy2auPd3vcMYapPAg0h/vpq9cnC70YJmdEOcL+zlNPBYO9di
         dBjvXJJgRS19x90mPMM2tf9jiNHQPB3iGoFPRWZJE0XjlavTK++EgRWSM+IKfTH9pfiW
         Zkmgqh+Lf7oFYKwTTWdi/eOiDiV1Gtrmuh2i+J6K8m88j0jkDboW+L2LqehfZria33oA
         hoRaoFcuagr0pSB6SjNNnBsQUFnTNj+14bEymqEY+tuEyIzclUL52eMpt5droNY7AHql
         KqBQ==
X-Gm-Message-State: ANoB5pl3krwFzqHyjqS6euY/ljN3h7Z+2fz9GcxQZnENhLxrzNPcSRn/
        auolG87/OfGIKgMg0UwlEUu4zg==
X-Google-Smtp-Source: AA0mqf6X75BsRDFFYxwoazI89K+C/eYmF/NLNxBu/O0+JyHlvp4tQZXsmEPzbUUd1dJ8nZ/x9U1mZw==
X-Received: by 2002:a2e:a809:0:b0:277:8a19:25c2 with SMTP id l9-20020a2ea809000000b002778a1925c2mr4544621ljq.4.1670918090833;
        Mon, 12 Dec 2022 23:54:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a22-20020a05651c031600b0026bca725cd0sm170830ljp.39.2022.12.12.23.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 23:54:50 -0800 (PST)
Message-ID: <e0e6960d-0aac-ddd7-0a6c-2695f3bf3e61@linaro.org>
Date:   Tue, 13 Dec 2022 08:54:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: rename AOSS QMP node to pmu
To:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221212133303.39610-1-krzysztof.kozlowski@linaro.org>
 <20221212133303.39610-4-krzysztof.kozlowski@linaro.org>
 <CAE-0n50y4N76Y-EEQ1sjT3Q_HnOLfFTw=qmus1X0CbD9Nt0v8w@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAE-0n50y4N76Y-EEQ1sjT3Q_HnOLfFTw=qmus1X0CbD9Nt0v8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2022 20:08, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2022-12-12 05:33:02)
>> The Always On Subsystem (AOSS) QMP is not a power domain controller
>> since commit 135780456218 ("arm64: dts: qcom: sc7180: Use QMP property
>> to control load state") and few others.  In fact, it was never a power
>> domain controller but rather control of power state of remote
>> processors.  This power state control is know handled differently, thus
>> the AOSS QMP nodes do not have power-domain-cells:
>>
>>   sc7280-idp.dtb: power-controller@c300000: '#power-domain-cells' is a required property
>>   From schema: Documentation/devicetree/bindings/power/power-domain.yaml
>>
>> AOSS QMP is an interface to the actuall AOSS subsystem responsible for
>> some of power management functions, thus let's call the nodes as "pmu" -
>> Power Management Unit.
> 
> Isn't 'pmu' a performance monitoring unit?

No. PMU is whatever you call it... ARM calls it Performance Monitoring
Unit, Samsung and Rockchip (and maybe others) call it Power Management
Unit. It's just an acronym.

Best regards,
Krzysztof

