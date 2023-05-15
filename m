Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B2F7032D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242669AbjEOQW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbjEOQW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:22:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536A61708
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:22:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3078aa0b152so6914634f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684167774; x=1686759774;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L/BFaR2bXmYV85aZ3VRwxHXRXyNTTuSJM62QQ7kJk14=;
        b=XobnY8dEDD5WdDsk8tbcbCChwsRbJjuhaQcAVTQG6QA4fd8oGxrcXKJ1AgPzDHF4YF
         iuFoC+kO9NnOf4NjasgKbvGzdkx3vkK8Vq3z5lpynoTjyuR6lI9Wlh5JrwXm9ki5bFUa
         lvU4eBabnuZjU1+dgRWwwJuO54dZGOF5z31g2iCiTDMwzccWs0cGGRjNZR1rGlMg57za
         fAt81vYy5OUbGayVg5t4ljnYrTMa20FH+fdAh7okT3u+OZP+B5LNYEG5nyGV/U915VHL
         ILtJEcIOXMFzppP2iokbEhnB+qHCcr8HCYzYwbQ5eoCcBoJTw1ZMppByQhzC10RLlXj2
         aVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684167774; x=1686759774;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/BFaR2bXmYV85aZ3VRwxHXRXyNTTuSJM62QQ7kJk14=;
        b=DNA2CUQ5vpN2R207st3qr86p8U7rYvOw23/jIj/tmyOI4J9/OqirzFNJSl/yyIwMae
         4UWO4+Ev016uXB6uGPJvkEAVJkuvhKdaa54ACH49nj4ixdqANuYkMDTyaAih43p7Ckah
         TxLOdGoAwCKTAKB9p4X1YoETa2w24CBW/7flYnfMf2WNWMXnaMbru2Mp8fqhZDo0fXqe
         g9ClRElnxe5tQ2mZAicSdsEWeVcjgRY6/LMlT0DDVRnmcnLlkKtJbymu5hF+qrO2K0Z4
         44wqaNbr969PLcgd1MuDsxfS1IMFb53eemGMzjaE/jWU3Zz8J7ml+OhwuiVlV+fHAGjF
         evcA==
X-Gm-Message-State: AC+VfDxxheXusrBtOzdeWC5AJZW/VmF5eT6urlM8dVcq9n2+QMtwihmZ
        uIGWK4yqlr+5jLz/MDmt1G3b9g==
X-Google-Smtp-Source: ACHHUZ45LY914ONoEcieAp+9ip6x5dmqMig4lZWDIrIooklY3Q93vho3dB48zUvDlbhW6BuZmPpLZw==
X-Received: by 2002:a05:6000:1b8f:b0:306:2b31:5935 with SMTP id r15-20020a0560001b8f00b003062b315935mr19815654wru.55.1684167773728;
        Mon, 15 May 2023 09:22:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ee7:a396:6195:bb56? ([2a01:e0a:982:cbb0:ee7:a396:6195:bb56])
        by smtp.gmail.com with ESMTPSA id u19-20020a7bc053000000b003f09d7b6e20sm37425314wmc.2.2023.05.15.09.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:22:53 -0700 (PDT)
Message-ID: <9cba6384-123b-1cd1-ed02-08365a0ed529@linaro.org>
Date:   Mon, 15 May 2023 18:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 01/13] dt-bindings: clk: g12a-clkc: export VCLK2_SEL
 and add CTS_ENCL clock ids
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-1-2592c29ea263@linaro.org>
 <5cb38be4-a27f-dc1a-cbb9-c195505a9e7c@linaro.org>
 <9fa0662e-8854-05f9-da7f-ec8e08d2badf@linaro.org>
 <d5c030f9-2f4d-25cc-b922-d00f5033ac37@linaro.org>
 <6228670c-3e06-3061-f304-a2c641962ffa@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <6228670c-3e06-3061-f304-a2c641962ffa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 18:15, Krzysztof Kozlowski wrote:
> On 15/05/2023 18:13, Krzysztof Kozlowski wrote:
>> On 15/05/2023 18:06, Neil Armstrong wrote:
>>> On 13/05/2023 20:28, Krzysztof Kozlowski wrote:
>>>> On 12/05/2023 15:11, Neil Armstrong wrote:
>>>>> Expose VCLK2_SEL clock id and add new ids for the CTS_ENCL and CTS_ENCL_SEL
>>>>> clocks on G12A compatible SoCs.
>>>>>
>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> ---
>>>>>    drivers/clk/meson/g12a.h              | 1 -
>>>>>    include/dt-bindings/clock/g12a-clkc.h | 3 +++
>>>>>    2 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> Bindings must be a separate patch from the driver changes. If this
>>>> causes bisectability issues, this means entire solution breaks ABI and
>>>> is not appropriate anyway...
>>>
>>> This is basically how we handled CLK IDs on Amlogic clk bindings for the
>>> last years, the amount of changes is very low and rather exceptional
>>> compared to early development stage.
>>
>> The commits with bindings are used in devicetree-rebasing repo, so we
>> want them to be separate.

A lot of commits changes the bindings and other part of the kernel source,
it was solved with git filter-repo a long time ago.
While I understand in an ideal world those commits should only touch
Documentation/bindings, it's sometime not possible.

>>
>> Meson is the only or almost the only platform making such changes. I
>> don't get why, because the conflict could be easily avoided with using
>> different names for defines in bindings and local clock. Approach of
>> having bindings strictly tied with driver commit is never desired.

If we did it now, we would have make it differently and expose all the clock
IDs on the bindings like on Qcom, be sure of that.

> 
> Also one more argument maybe not relevant here but for other cases -
> this makes literally impossible to include the clock ID in DTS in the
> same kernel revision, because you must not merge driver branch to DTS
> branch. SoC folks were complaining about this many times.

Actually we handle this very simply by having such patches merged in a immutable
branch merged in the clock and DT pull-requests, it worked perfectly so far
and neither Stephen or Arnd complained about that.

> 
> Best regards,
> Krzysztof
> 

