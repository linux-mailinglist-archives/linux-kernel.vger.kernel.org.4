Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8925F626A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiJFIRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJFIRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:17:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A716A77543
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:16:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m19so220314lfq.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 01:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=FfDc+hEkZ6RwsaJ4+0A43rieR6v2jH+WTZvfAnZBz1Y=;
        b=VY5EY1z4bbWvQXGas+BbfF2JQm5bmRSHtb1XKkt64fbrhSp6hulWrZnHh/r7teY+p9
         +G5qYPBCmVMc5i6u1kHpqWaGS4CRnjO/7YXZ1fjDK4pjhCNzONFh8nOwmARzSFNKVfeg
         iUCW6RMzluXWlsBIkkFMXJZ1xBf2ixJLbak9i5qGWXuHR1vwA22EoeyEkQB8lllCQFI3
         K41PIq3ivmz3jf/QLe63dTa7awGdMJ61F8hKfQ9C63xF8QxgqsjTYAAGCpt6PcNTyfjz
         xBuRYy4US5IpZsdC/1rb/QQDyDi7MII3DTx00pfjYu8N+PC3hHt/paXZWqNOnqnZNgUW
         eeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FfDc+hEkZ6RwsaJ4+0A43rieR6v2jH+WTZvfAnZBz1Y=;
        b=2JtCbNkVR32lEW8OacGbK9cVV3r1BJzO1+3/bKnOsSUVKUkrrv8Uo1OpF8ST0t99LE
         UQy7D82YMIWLRFOk+VmWXG7pZcLOY6kBHizYjAdbQF87G7Iq/wf7nuE51HZLlQ0r8p7Y
         bHX5of2VpYK0ngjOWzywVhuzGlihXV15Ce9FoGfPxKPcqbau4+0wsgIasbYNsdWsWTZV
         O7pAOrB6WycLGuht4756/yzRFMVwdkSog++EIN8iBWJ5geBYd13Vp+i6QJgpsDT4wSoX
         OyuddjicUhPMy6lSIvUl2UpVYEeKv0XKta3YbjK1MwO/mCzvG8ogpr7kdvMIKErFqBMc
         URKg==
X-Gm-Message-State: ACrzQf0KJdaa8tvsDijsnh0y2XKy4OgWlGr2Dtk050ez4+Im7IqFZ3W5
        zbl2jc/k23aOLCB4b+9QNT920g==
X-Google-Smtp-Source: AMsMyM7GpuGlUY84ykYp+oEDm2ZghpfDWhH+LgsZpb9xJ2vsDcx500yy62Ye1D2zhYbdCgSKUMhbJA==
X-Received: by 2002:ac2:4c8d:0:b0:4a0:559c:d40e with SMTP id d13-20020ac24c8d000000b004a0559cd40emr1340565lfl.508.1665044216972;
        Thu, 06 Oct 2022 01:16:56 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y13-20020a19750d000000b00497a1f92a72sm2617457lfe.221.2022.10.06.01.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 01:16:56 -0700 (PDT)
Message-ID: <94c660bc-b7eb-1aea-8ae2-0ee7993091fd@linaro.org>
Date:   Thu, 6 Oct 2022 10:16:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
Content-Language: en-US
To:     allen <allen.chen@ite.com.tw>
Cc:     Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221006020444.15823-1-allen.chen@ite.com.tw>
 <20221006020444.15823-2-allen.chen@ite.com.tw>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221006020444.15823-2-allen.chen@ite.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 04:04, allen wrote:
> From: allen chen <allen.chen@ite.com.tw>
> 
> Add properties to restrict dp output data-lanes and clock.
> 
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
>  .../bindings/display/bridge/ite,it6505.yaml          | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> index 833d11b2303a..f5482a614d05 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -52,6 +52,16 @@ properties:
>      maxItems: 1
>      description: extcon specifier for the Power Delivery
>  
> +  ite,dp-output-data-lane-count:
> +    description: restrict the dp output data-lanes with value of 1-4

Drop "with value of 1-4" because it is redundant, but instead explain
what this property is about. "Restrict output" is not yet enough.
Restrict the number? Or choose specific lanes? Why it cannot be
data-lanes from video-interfaces?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 1, 2, 4 ]
> +
> +  ite,dp-output-max-pixel-clock-mhz:

Test your patches before sending.

Best regards,
Krzysztof

