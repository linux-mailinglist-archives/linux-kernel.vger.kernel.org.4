Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B446D1C87
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjCaJfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjCaJeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:34:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D99ECA1D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:34:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q16so28079473lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680255240;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ai/1YpnrQGMFVrnQJeZGVLCmWTY7Fz7OsSb9rllfA/A=;
        b=bXr2Xm5tyW+sglpq+sV+BJ/VlJIXrkWrlavLQftfI12wsd+i87DDKbAWpw4fLK6JJu
         TuQxBQoXbC1FkMaIY+osrvcF3Uo0DCrkn3YlroowTyOUQG/JSyf6j/Qz+I362/qyYvpb
         vW6KmvooSBlZETfBQhFqLfrwMnKhsD6CKuXTJSHMyLqfhVSWqUkipTrRX4+H1aIBby9R
         GQjkOO6fVn/Uj6ZYHIQ1W2VZ/5THM/Di45QsRBw5En6fFKaqB4iH78ULxJoSB9XUuBWD
         ZoCGLcg00OVTS5tUOQj+fKV4Bn5a+6UTbGLmfWBY8vvvv/UVBZm72g6kMFqLpvHwPGXK
         i2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680255240;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai/1YpnrQGMFVrnQJeZGVLCmWTY7Fz7OsSb9rllfA/A=;
        b=gZDVh6MgnC0QFHCJ6/sBjPzQV/5SRrwrnZkW1KixV4TkjEDO/iewrWigOEt3+i0HK/
         eUv0hmqgA1ulKCG4Kgm+MOQpmGMtvHCOVCjGub41NqJyQ8xl9H9q+/CvzrPiiL9XKech
         re2EeXegNbKEqkwQQeUDKcf7mRVpag8YrLS3Y2Lw3Mi5wd1xon/ClAwaqXt0s1BPhZkK
         fDedYiPww8YfyomT7+LruN4a/nHjgJ6kpVhUCct2Pml1BgtSH9ETVTQkizJTxUivdwK4
         o9e/bsuljlZR6yF8JORPyIjIt58A18qpoUcA/Japj6w+RBN6rqb/N/I7Zo2BbZiHWG9l
         NFog==
X-Gm-Message-State: AAQBX9c0w1v4V+fewEkSq4BZOR8fAhxrLKjSqXJLSRu0fOEWMHJCp7bz
        Q3FqrbUphmHKmoZL96ggscCUZw==
X-Google-Smtp-Source: AKy350Zw3AEl/l1nQ2UFiIHwCfWmha0LEvbnsktucmxS1dk8XV4DbUPsuRtguW7IZ5SHImNMhoNXQw==
X-Received: by 2002:ac2:5318:0:b0:4e9:b64a:b87d with SMTP id c24-20020ac25318000000b004e9b64ab87dmr8522538lfh.9.1680255240307;
        Fri, 31 Mar 2023 02:34:00 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l14-20020a2e99ce000000b0029f7d27b78bsm285041ljj.110.2023.03.31.02.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:33:59 -0700 (PDT)
Message-ID: <f224159b-a5cd-e2f3-c34a-acc1de343cf8@linaro.org>
Date:   Fri, 31 Mar 2023 11:33:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 2/6] dt-bindings: display: bridge: toshiba,tc358768:
 Add TC9594
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20230330095941.428122-1-francesco@dolcini.it>
 <20230330095941.428122-3-francesco@dolcini.it>
 <ff88e5d3-4c31-7698-b8d1-8a03b9fea643@linaro.org>
 <ZCaoTDjvAUZJYP3s@francesco-nb.int.toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZCaoTDjvAUZJYP3s@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 11:30, Francesco Dolcini wrote:
> On Fri, Mar 31, 2023 at 10:42:40AM +0200, Krzysztof Kozlowski wrote:
>> On 30/03/2023 11:59, Francesco Dolcini wrote:
>>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>
>>> Add TC9594, from the software point of view this is identical to
>>> TC358768 with the main difference being automotive qualified.
>>>
>>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>>> ---
>>>  .../devicetree/bindings/display/bridge/toshiba,tc358768.yaml | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
>>> index d6dac186ac59..8f22093b61ae 100644
>>> --- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
>>> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
>>> @@ -4,19 +4,20 @@
>>>  $id: http://devicetree.org/schemas/display/bridge/toshiba,tc358768.yaml#
>>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>  
>>> -title: Toshiba TC358768/TC358778 Parallel RGB to MIPI DSI bridge
>>> +title: Toshiba TC358768/TC358778/TC9594 Parallel RGB to MIPI DSI bridge
>>>  
>>>  maintainers:
>>>    - Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>  
>>>  description: |
>>> -  The TC358768/TC358778 is bridge device which converts RGB to DSI.
>>> +  The TC358768/TC358778/TC9594 is bridge device which converts RGB to DSI.
>>>  
>>>  properties:
>>>    compatible:
>>>      enum:
>>>        - toshiba,tc358768
>>>        - toshiba,tc358778
>>> +      - toshiba,tc9594
>>
>> If it is the same, why they are not compatible?
> 
> I assume I am not understanding something very basic ...
> 
> The register description and SW functionality of all these 3 parts is
> identical.
> 
> How should be the compatible described in the DT schema in this case?

Look at any board compatibles for example.

> 
> 
>> I got only three patches out of six, thus I cannot check by myself.
> 
> Here the whole series: https://lore.kernel.org/all/20230330095941.428122-1-francesco@dolcini.it/
> 
> Do you want to me to send the whole series and not just the DT binding
> next time? Happy to do it, if you prefer.

So NAK on 4th patch. Don't grow device ID tables needlessly.

Best regards,
Krzysztof

