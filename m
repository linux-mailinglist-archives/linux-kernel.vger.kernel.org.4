Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC671F10F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjFARpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjFARpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:45:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE1519F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:45:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5147e441c33so2643120a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685641527; x=1688233527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBRDIKv9pFHHAnzSCCPWxz8E2s9GC4jBbWRxKZHWfIc=;
        b=u+Y5wfCebXA7ka7woUFCIcXqRRZJnjDVXm+r6UIoZoD6rYdgUmg6RTJk98psKqP/Sk
         1FpJk99QsDASd9QZNZQEpAYASYc8cNOYZv2Bf9mNMH2nHjQ41+nDmFXY4R8CIDrLcPPl
         gRDmuhrvnZzyXAh6HL5uaXSCOHO8LYUHBKZgHXm8+ee7nufTlW9g4bvSW9v1FIlSB1eX
         H4hZwftzd+dxrjJs2/n1B5/SkrqKb7ZpDXV4KNF3zu5DJNXOci9nwrhSsKjYRADxkcPI
         teBDJVf/u36rvJ1j0Jwdc5QdqUPysrkdwcXOHgwPAeOzj+ly2LDU7VZpZgVABuH4gS0W
         QkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685641527; x=1688233527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBRDIKv9pFHHAnzSCCPWxz8E2s9GC4jBbWRxKZHWfIc=;
        b=DC3aaxncmNutH3VrZUdWWItymD7Ui3Ep3an5I99wpfzXjJydCrHU4n7MAy+DvL7H0S
         z9+sOLzK+u66Of6In6i66RidEsATwfOC2Ga/jhhxJPvBZ7QzmO87X4O4zX0hpf3vYmIP
         1vWlB2KV0AVO581V13Kf3hHLp0HVWYMRAsalOTFB3vVRc5HEDs61/au5SD0mP8avPOsd
         8FH1ITha2q7x8SG7+0cEf3inPdxtyd69HOkVgOq92kIsNUOaKbMC/5L4PAhjRFcN0vEu
         POS0yLRTqEu++HALlgF5I4ZuiFsANavAa6F59ArGvRvj8H7Ts/GHg8liHhBtaSWsKxm+
         J6MQ==
X-Gm-Message-State: AC+VfDxNX8gXDSMIcBmBHHigy+h280kXFztQPcOG41yv6lc9Xp4+00Rc
        lEws/CcSxlnkHZ+dbbtabAqtGA==
X-Google-Smtp-Source: ACHHUZ7Unk95/39P64w6MIuE0m9e+mNxNCBz6qY02E+GST/o0s5lxoRIlH/bV7R9zajjnFD7YNu7aQ==
X-Received: by 2002:a05:6402:3582:b0:514:a5cf:745b with SMTP id y2-20020a056402358200b00514a5cf745bmr637933edc.3.1685641526752;
        Thu, 01 Jun 2023 10:45:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id p16-20020a056402045000b005147f604965sm7519209edw.24.2023.06.01.10.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 10:45:26 -0700 (PDT)
Message-ID: <bd257ed0-71a7-0504-0bfe-14775ac93571@linaro.org>
Date:   Thu, 1 Jun 2023 19:45:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: display: bridge: Add NXP i.MX93
 parallel display format configuration
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
References: <20230531093206.3893469-1-victor.liu@nxp.com>
 <20230531093206.3893469-2-victor.liu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531093206.3893469-2-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 11:32, Liu Ying wrote:
> NXP i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register which
> configures parallel display format by using the "PARALLEL_DISP_FORMAT"
> field. Add device tree bindings for the display format configuration.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v1->v2:
> * No change.

How did you implement Rob's comment?

> 
>  .../display/bridge/nxp,imx93-pdfc.yaml        | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/nxp,imx93-pdfc.yaml
> 


Best regards,
Krzysztof

