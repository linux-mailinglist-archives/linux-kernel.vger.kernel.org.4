Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48306611D37
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJ1WHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiJ1WHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:07:20 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BF324D894
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:07:19 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id j6so4945290qvn.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l4Zjzz+NmO6ZHHFaizEHCjrG04Xj0VbUFmDsHVrZ9aU=;
        b=c4nDWMablbhQJCxDEPvgkxypSIQLq4xcT3gmYe+nK6OTGhNY2Zs7Bgsqtm4O/X4ARV
         yyIfgh3doG28AvK52GL9kW1jyEs5Y/yCN9afEoKZ/sXD/M4/L96Idojf52gCL86lqnzi
         ilK/0+BQGchPX2PRvQMgnbaryCSBhc78Jf+rHpsR1PlHxuAh4DxSV+YvqMd3NNR5kldW
         Ij+Ffn3jV7ZGomF3l7PRSZLyzmsdl/pPCblv8Fr4gWHOZa0x1k2lvwugbULp/Z+MkJWw
         smF6wiUEMmDg7MguA6JBrvarjDBgF4+oVgVYE9o24y+bmYUWgrV5sYpiIXJbrVjkMuKi
         Fixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4Zjzz+NmO6ZHHFaizEHCjrG04Xj0VbUFmDsHVrZ9aU=;
        b=ZfETVZ87uUHCczeRHRMgNJCyN15vSCEaZ9V2S0jXpT4xktH/K0G27DhAWdkwZ+o8TK
         jbGqrVLAQnUA7p0psmeKblEYnvQi7LaAHeIV0tRQZfVk3WVFR+vP99Y+A2E5t/pY07dL
         GGbTbVxhzZJlLV2Buhxu1fibZSmOoX4kbLWs/2LfDvU2U0Ou8aR2my8tyqaD1V4zRnJq
         pnOJaoioSN537KpLWBab7Y/ah7p0L1YAoQRIRY5dxJACoz1guPPWfmxqHnun/Sn4esT1
         T5s8pRzmxE7fptlCyC5wypdEuUgQdx7NVRoRmE/pJU0RexKS7KU5sMRpmG28zx5u3Lw8
         eCYg==
X-Gm-Message-State: ACrzQf0apjiMIPAbnmfQ3tVeBUdN33krmoIkhaA6antBgUEKktINmLCc
        9HFFS3jE/vhD/vqC/B6AXH/+Iw==
X-Google-Smtp-Source: AMsMyM7qdsCaCR3n2UT1c8MifaiLfbwiITEqLguFAdOAnkkneQ5LNEJtabdAtXUtryo2KVicgQHefA==
X-Received: by 2002:a05:6214:c2a:b0:4ba:170c:1929 with SMTP id a10-20020a0562140c2a00b004ba170c1929mr1435139qvd.21.1666994838746;
        Fri, 28 Oct 2022 15:07:18 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id br16-20020a05620a461000b006bbb07ebd83sm3701555qkb.108.2022.10.28.15.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 15:07:18 -0700 (PDT)
Message-ID: <34c4037b-d152-412d-e551-dd3ea27b6b46@linaro.org>
Date:   Fri, 28 Oct 2022 18:07:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] dt-bindings: leds-lp55xx: add ti,disable-charge-pump
Content-Language: en-US
To:     Maarten Zanders <maarten.zanders@mind.be>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028133501.95833-1-maarten.zanders@mind.be>
 <20221028133501.95833-2-maarten.zanders@mind.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028133501.95833-2-maarten.zanders@mind.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 09:34, Maarten Zanders wrote:
> Add a binding to disable the internal charge pump for lp55xx.
> 
> Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
> ---
>  Documentation/devicetree/bindings/leds/leds-lp55xx.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> index 7ec676e53851..9eb8d1017402 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> @@ -64,6 +64,11 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  ti,disable-charge-pump:
> +    description: |

Drop |

> +      Disable the internal charge pump.

Does it mean that it is enabled by default?

Best regards,
Krzysztof

