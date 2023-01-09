Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAB066305C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjAITam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbjAIT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:28:17 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9D87D1E4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:27:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r2so9289504wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AatgqnKq1CxFV2DrkoIsHDbH5JbnnXUvQ3qRmHwP/LU=;
        b=dEc6RlClcIs6wxNbRR3NVwyC94tdcHcu82YVCTo9dv0trlIfh/WEhb1krw/nw2/j9c
         2kHySNIRXWXb8Xgd0FyDm8s6Fl3wk5TA1OY+B3zTeZmkRL0FufQUP81/VVZ4iRzJbDhO
         uRZ74GPWm9R1DaPcA1L7MRGR4o/NkotKEE+KrrfWP2lB4SLaDr/1pf7si/UFGIc0uhPd
         +jk+rfp0N4N+DZJX1laAL3WlI1au2sH017wil9IODKL5TsSV26u5zLCFtGJr8YIcZqYb
         +38fW0lmLUDFCws0L0qBGeY87k2iYe/nyNrOgJihAnKZJK3I+kHVXLK0wiM1sBLOY28B
         uZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AatgqnKq1CxFV2DrkoIsHDbH5JbnnXUvQ3qRmHwP/LU=;
        b=IbUijFMu2Y/vi3hvEnUPsgboGF0+oo7MxKzNl+Dmlvy2r/JyxbRoqWlDA4dg6pHA1w
         w9FnifNxeN+UlGbL/jhOuoFjW0g6QnMpZUIY8axi5onesPqg6nw87U+Mg9Q71lx3qYxQ
         KhPdPd/RujzOtBt6QNsWpGxhtDevUh4+7is9JDtOvXsM1X/G1u4XjxMASSKmzIgAOe9t
         qPrszPZUl7IqRyy9uh452OcYDFGWYvpKvTiUVvKBXotuF8ZYuELXBpS0HFyagCipeuxL
         /RvbrC1IG8cd7jDvSP4m1h54azeMMjJvtlOJGrKn0Udp1CHZYKfkclITBXh2O/ybxiof
         A7+A==
X-Gm-Message-State: AFqh2kok6Pl4GbzZe49wYCPE+bH4e3AlA4suiw7JB7eINt1f3vF9xyJa
        /ypCwhnAGoCzqmXB6Z8rg/G3Ag==
X-Google-Smtp-Source: AMrXdXtKuWYWcHD9ct5AJC0r/ItSFbWSkVrTGs9jFFFYd1KOZItI2ChrrMAwigq/S5gyc1pMuUbDoA==
X-Received: by 2002:a05:6000:18c9:b0:242:88af:d88b with SMTP id w9-20020a05600018c900b0024288afd88bmr42003097wrq.43.1673292438489;
        Mon, 09 Jan 2023 11:27:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:d3bb:5fe9:fe57:33a2? ([2a01:e0a:982:cbb0:d3bb:5fe9:fe57:33a2])
        by smtp.gmail.com with ESMTPSA id z8-20020a5d6548000000b0028df2d57204sm10880416wrv.81.2023.01.09.11.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 11:27:18 -0800 (PST)
Message-ID: <e707be74-29d7-6649-9595-144314829503@linaro.org>
Date:   Mon, 9 Jan 2023 20:27:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: document the Visionox
 VTDR6130 AMOLED DSI Panel bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-vtdr6130-panel-v2-0-dd6200f47a76@linaro.org>
 <20230103-topic-sm8550-upstream-vtdr6130-panel-v2-1-dd6200f47a76@linaro.org>
 <4b7458ce-18cf-8222-b5c7-349e07dc6b87@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <4b7458ce-18cf-8222-b5c7-349e07dc6b87@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 13:15, Krzysztof Kozlowski wrote:
> On 09/01/2023 09:49, Neil Armstrong wrote:
>> Document the 1080x2400 Visionox VTDR6130 AMOLED DSI Panel bindings.
>>
> 
> If there is going to be resend:
> 
> Subject: drop last, redundant "bindings".

I'll fix it while applying, thanks

> 
> Best regards,
> Krzysztof
> 

