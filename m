Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5205A71810C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbjEaNIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbjEaNIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:08:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0958E5E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:08:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f5d651170so195861366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685538485; x=1688130485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1R1Sj0tDi2ehLT48w+P4ulNbR96KWPz5ISY1Z775GFo=;
        b=SV4Uab3DVC7zDV7JKPV9GphVtB2lFxktAO5OYzfZKvEKlE3tscwKtT1w9JmOVhBvbC
         jVg447Fofo02GPQFR9WMCpuKzkHrCpBFNunhtg1BwcLmPn/tTD/dldikvQMQN1GssXCU
         hjbcVbsjii1QLWL4GOcpXxjOKaU42BcMFHXH3u4xkK9VQqSQRoqBlaKExuhPe+RAZkOC
         AlNCh2nHqwUCQV1Mz7CTXyrYY4eVx3MoZAt1/A0rhFdn6QrgLCK0YoH/cJuzZQ+0DVJp
         mt+fvgNgOxhqbybJ2eZLSm5TEPnxc1oORhtD2y1xRRgFEpF889Unba21uPF5JD31hn/x
         3w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685538485; x=1688130485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1R1Sj0tDi2ehLT48w+P4ulNbR96KWPz5ISY1Z775GFo=;
        b=PqLfa/osbgXK/G877WKKgC3IgclQY9Lvdx6eFUjh3f1/q7O26PSyBHK5QOIJJ2lBsk
         P1BlvIGF8cQ7bcniWZa2J48ooRL4SPaqgPVp2ncBckoaMQxeu4f+yjCX4f3YXzGvtLnB
         WvtXwJ1cIPCCy/aHXDT1qY/inE5+rqkTFUNTmRw04IzI7SHSrSazYSu5YbT30i7hJkYV
         eWv58vqDep2PLBsbV17z5zO5lg/aRCmVNzQBm+ndcoKrZhZO0WUy2bwnlNM9gvVwsK6m
         4fN9T0r5AbtPMPNXNH+PKIeMPlr619ht5UlI9n/vqUj+YJwtzMU+LcllurDOYAaEMEZu
         W6qQ==
X-Gm-Message-State: AC+VfDwor3JtEezpR4cTa3ptYQGLmS2+GwuwmcAQFu620GdPTJJSRLUZ
        QlS8q7Hj6xXyIdIro8CIFmSY/C3/wdGv/CA1Zhp9Gw==
X-Google-Smtp-Source: ACHHUZ7yi4O3Lr8N0xM2vV/dr4K11JP8UYtS7bQW8y7fQzKozQ/6LPXB7bmNsjtNT1vTVtAOoC2oEw==
X-Received: by 2002:a17:906:da86:b0:965:6a32:451f with SMTP id xh6-20020a170906da8600b009656a32451fmr5505298ejb.6.1685538484994;
        Wed, 31 May 2023 06:08:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id e10-20020a1709061e8a00b0094ebc041e20sm8821224ejj.46.2023.05.31.06.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 06:08:04 -0700 (PDT)
Message-ID: <b93b6804-64f9-f9eb-418e-dd4d03d61240@linaro.org>
Date:   Wed, 31 May 2023 15:08:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: thermal: mediatek: Move auxdac binding
 to yaml
Content-Language: en-US
To:     Matthias Brugger <mbrugger@suse.com>, matthias.bgg@kernel.org,
        rafael@kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20230530150413.12918-1-matthias.bgg@kernel.org>
 <80108a00-4416-a419-e45a-e5e4c1f111a8@linaro.org>
 <31f25021-aaf5-a6ca-049d-bb47f62936b4@suse.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <31f25021-aaf5-a6ca-049d-bb47f62936b4@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 14:42, Matthias Brugger wrote:
>>> +    soc {
>>> +      #address-cells = <2>;
>>> +      #size-cells = <2>;
>>> +
>>> +      auxadc: auxadc@11001000 {
>>> +        compatible = "mediatek,mt8173-auxadc";
>>> +        reg = <0 0x11001000 0 0x1000>;
>>> +        clocks = <&pericfg CLK_PERI_AUXADC>;
>>> +        clock-names = "main";
>>> +        #io-channel-cells = <1>;
>>> +      };
>>> +
>>> +      apmixedsys: clock-controller@10209000 {
>>> +        compatible = "mediatek,mt8173-apmixedsys";
>>> +        reg = <0 0x10209000 0 0x1000>;
>>> +        #clock-cells = <1>;
>>> +      };
>>
>> Drop both examples, not really relevant to thermal. It grows the example
>> with code already documented somewhere else.
>>
> 
> auxadc and apmixedsys are no examples. They are referenced by the thermal node 
> as described in the binding. Without them the example won't be complete.
> 

The example is complete, because you have phandles and that's enough.
the auxadc and apmixedsys have their own examples in their own bindings
- no need to duplicate them here.

Best regards,
Krzysztof

