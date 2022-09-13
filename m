Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52745B6A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiIMJDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiIMJD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:03:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A4121815
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:03:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id e18so2813224wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=u0+/4DOaKm+4ffSLNzqiW9x1Gxog4OJEqiqEoF/yw7Y=;
        b=qryssQyWeKIu75ubPUW0iHm/yVERj0n+y/zNXGQpiKNxdOmJ6aLs0sfq5V+r5W5cG0
         YnaD4AIP7RH4D0c/emc4G3RHaEOlxsBi25NxT2/cQAW5xdIZpv9SzHIyb13EPBFcGYpb
         N8mUAjMOLFE76eY99ClSpFtga+lyDQCtIf/kDAVB7AvaEGboJfYWrzEqzWS4w+keXTsO
         X0kckQAqwsbSA1GQcLjrsMrSy34tokQ9mo77t4cF95/4v3CG5ZYLws6WmqnrliZ/UnZH
         lYGZKE/8HSYKQ4AtouJnerf31WsPtjfscnS2fDGLGoMzReS4ib4G2IBY+7b/z1ExfSWX
         8T2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=u0+/4DOaKm+4ffSLNzqiW9x1Gxog4OJEqiqEoF/yw7Y=;
        b=NkY8wdKGS9SQeAsfQ3EbQIxyzs4LNZQMjkoULuQwJsk8JuKzkS8Bl3nNxtFkrFDiN2
         rW3LSmzcq6kPwr3dHP8eMq7MbBQgelQ/S4YLjcE0u19G2NlcRHFl8qiA4DqzxnOrYKj6
         fpC/Y2jxepS1OisZkfsdI+e6RPVVBKHUBnjf4WOswQ3+mOiRfVCczB9ds6Kzpz5dowm0
         YfZudpM2k9PAcU9DeXid8QRGkAkqSNnwby9DYz2+n7u5P5tdzwCsgo97rbh6Qw2QzGZg
         LAzVXE5ZD9NcwfdWwvIVAqZvaD2F03N+PB5sr5xyziKif2f3S987nVkSCLGeaVbhjWxH
         jPZg==
X-Gm-Message-State: ACgBeo1hRM+sc2PdLTw78tl+CJg/2zpui9TwPQmjBtzgiimnKwJb1Dsj
        3P1r1yRWF+IbAVrrNPf2Dd7MkA==
X-Google-Smtp-Source: AA6agR6tgHbM7dxYDRZ789TFmI5oqqZizaFVPdsBuEzXTii3bjLRA2QLQp236Cr6ae5gSL9m/8Oupg==
X-Received: by 2002:a05:600c:1e08:b0:3b4:8fef:d63c with SMTP id ay8-20020a05600c1e0800b003b48fefd63cmr1569107wmb.158.1663059804794;
        Tue, 13 Sep 2022 02:03:24 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.70])
        by smtp.gmail.com with ESMTPSA id n42-20020a05600c502a00b003b31c560a0csm12943776wmr.12.2022.09.13.02.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:03:24 -0700 (PDT)
Message-ID: <c931b0f7-9ce6-b270-d11e-9bcf3f304218@linaro.org>
Date:   Tue, 13 Sep 2022 11:03:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
Content-Language: en-US
To:     allen <allen.chen@ite.com.tw>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
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
References: <20220913084835.78490-1-allen.chen@ite.com.tw>
 <20220913084835.78490-2-allen.chen@ite.com.tw>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220913084835.78490-2-allen.chen@ite.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 10:48, allen wrote:
> From: allen chen <allen.chen@ite.com.tw>
> 
> Add properties to restrict dp output data-lanes and clock.
> 
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
>  .../devicetree/bindings/display/bridge/ite,it6505.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Thank you for your patch. There is something to discuss/improve.

You already sent it. Please version your patches (git help format-patch)
or mark them as RESEND (it's nice sometimes to explain why it is being
resent).


Best regards,
Krzysztof
