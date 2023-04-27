Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6166F052F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbjD0LvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243506AbjD0LvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:51:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2685A8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:51:00 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94f32588c13so1250083366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682596259; x=1685188259;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/U8022l7mHUGcldCwvJeFjZR427WweXwOcu0tAZDrlc=;
        b=rxMH0o5jEoUqXw/uhwHEfcG1YgppYBA2BTBBKT4VoF648yJH/MNCrs5gvvrJeWAgqw
         JF1y/iPR9Pu4TUyeHq7wno2RrUvBrF8aIPAkvKToZ2+y5aTMPCa2LIpF3DscHQg2opwn
         1r3TnT70zud8Aeg6Ps+Gfj1tZufIPN4LjTauNhUcI941priHyYc1GZzTDsHuZ0XleLEJ
         CKdw1+fonH2GygA9GsFt77tmGE6S/2Vtp9x1+uaU1KTjDDEsLh7IQIHFiOHGBBW1A19P
         gfnzUbCUvkLoz+6LKBkHzMI+luoYDQZAHHKGKWuKK0kWAe/cOVN0YlkgycAhjCvP1KBp
         Yxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682596259; x=1685188259;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/U8022l7mHUGcldCwvJeFjZR427WweXwOcu0tAZDrlc=;
        b=RW1yR7cOLyZHEk0xx1Lb2Z8ayFBDb54N1P9iQyPPHdTtNtDLYs2YP5yhkOmvm70mxM
         ShHomkdqyrPVzoO91T+F3fboMQExNjmdSrzIZFCDGbWrmOdggIeNC5ycVkUyZ7yOmGBr
         ZhQEX/HJCDCQdKeQ/3OyAtzloxHyhZdDuOw8tQLPQWUmRZ9MRdh/EmrmVDtWmjLwdpCd
         Mp2kNLzEaDWR1Ur77Mx2r377oSYnumuo2f/5gfKeWxtsNzDzvyPPAstvCbGYA7I0PS6F
         R/rOBt2x975cDs9DgwZ8KboJncMZS0w5m4IFbf8iYMFDN7urGxpC24v39KFxypUSXQTY
         Jpgg==
X-Gm-Message-State: AC+VfDz2Mg7hKnP1uM5bbQXs/purQdXnTBJ7bY+1Uy7Ev1231sX5UTjJ
        iTOUHqYpJHSxejmdQoXtq3HmYQ==
X-Google-Smtp-Source: ACHHUZ7CMJEly2JPLzNjo5s0lu4TU4z9vQu1hHyYv5J9+qbzaDr8LaNU3GMb8fTnHm7lq5c1JJBSVw==
X-Received: by 2002:a17:907:970d:b0:953:45ef:1437 with SMTP id jg13-20020a170907970d00b0095345ef1437mr1574174ejc.31.1682596259126;
        Thu, 27 Apr 2023 04:50:59 -0700 (PDT)
Received: from [172.23.2.82] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709064a8400b0094ecf61289esm9594545eju.152.2023.04.27.04.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 04:50:58 -0700 (PDT)
Message-ID: <4a5ba8cf-5c24-2e76-4eb2-e05c7d8dfc72@linaro.org>
Date:   Thu, 27 Apr 2023 13:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: display: simplify compatibles syntax
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Xin Ji <xji@analogixsemi.com>,
        Thierry Reding <treding@nvidia.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230414104230.23165-1-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230414104230.23165-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 12:42, Krzysztof Kozlowski wrote:
> Lists (items) with one item should be just const or enum because it is
> shorter and simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Rebased on next-20230406. I hope it applies cleanly...
> ---
>   .../display/bridge/analogix,anx7625.yaml      |  3 +--
>   .../display/panel/sharp,lq101r1sx01.yaml      |  4 ++--
>   .../bindings/display/solomon,ssd1307fb.yaml   | 24 +++++++++----------
>   3 files changed, 14 insertions(+), 17 deletions(-)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Should I apply those patches ? Until now Rob finished by applying them.

Neil

