Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796EC6BE975
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCQMih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjCQMid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:38:33 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8E11CF56
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:38:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y4so19861204edo.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679056693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ieazCt2VSnmnZGU95p6J0fsPaC9JLJVb1N3OVs1/cl0=;
        b=wWm92anBEh5LJKqIt11EWk8LOC6uQMCTPlNDhESr9AByn7qv7i10LEhfT2+27ABv4X
         oVhyfgQFosdO3SGAKXDB4xLIbhIp1DAXDFNu9+vDlKHisyMVe/MVX4wlteE21O4IdHyF
         2MaDQ6NoVjZVSvDAJEuinunyBkf9JCEqu1L4rUiO55egC0EqoUrH+jwa2T9YsSOmyxM6
         e6egpVHFb57LQ2q/8w1CPNPJYjwIQBBTI5FuVR7YR+y3o9XEigW32n/pgJPj3J8TdZ6+
         4/1fY4SXxgu4fwsN93Jee/F6x/S2n78zutVYPRUvmp9MJ6qNvaYPvYAk/iv6orVy0Wg9
         tJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679056693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieazCt2VSnmnZGU95p6J0fsPaC9JLJVb1N3OVs1/cl0=;
        b=uB8i3QWyEOlF9a+NMXybohLb+928Rr5kdlFI7YYDrY5x1vGHpL/6A6uCkhrKLax7M/
         tHLTKACAQYsNsFBR/WDDJWHVK5JU+WM3YOTFhqssZ8eu3W68YdayTqunOYuZ+aRgtYhB
         dkqaeISYbwulT3/IGQ4+bnjiEpkgWpG7UGBtKjZZOILzCYfUa72OD0ro9z1l9/DHKjr9
         VZ57mPiXrqCmSsmaqv/f4PS+0abVgoKkUi0x3QsyV5gTxkx86xUS2WqppMo2v3eCaxoy
         170HNyc10tWOsT2mA2iyoV4NAC8ZdTAJWkZPlsN8vgoR+0F8TcRzIUYfbhMdjjB+KBV/
         KYLQ==
X-Gm-Message-State: AO0yUKX78SRu6XB9XXzjbcplLtxNnB85tlRntb0LyPwVQQd52srGcu7K
        OwPOJ35/zpSSBNM2nfiRrb48BA==
X-Google-Smtp-Source: AK7set+1PvvGYbX0zTdWZ0gf0CuuqjXnelxeVybKsKLfgomNgbJ0antRXviNxYHV7QkozPwqUu1Hsg==
X-Received: by 2002:a17:907:c304:b0:8ae:e724:ea15 with SMTP id tl4-20020a170907c30400b008aee724ea15mr13960431ejc.76.1679056693686;
        Fri, 17 Mar 2023 05:38:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d013:3eeb:7658:cec? ([2a02:810d:15c0:828:d013:3eeb:7658:cec])
        by smtp.gmail.com with ESMTPSA id v6-20020a170906b00600b0091f58083a15sm936500ejy.175.2023.03.17.05.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 05:38:12 -0700 (PDT)
Message-ID: <dbc43c09-f8ec-f877-598a-adff47d44b0e@linaro.org>
Date:   Fri, 17 Mar 2023 13:38:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: Add no-hpd property
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sam@ravnborg.org,
        jani.nikula@intel.com, tzimmermann@suse.de, javierm@redhat.com,
        ville.syrjala@linux.intel.com, r-ravikumar@ti.com,
        lyude@redhat.com, alexander.deucher@amd.com, sjakhade@cadence.com,
        yamonkar@cadence.com
References: <20230316140823.234263-1-j-choudhary@ti.com>
 <20230316140823.234263-2-j-choudhary@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316140823.234263-2-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 15:08, Jayesh Choudhary wrote:
> From: Rahul T R <r-ravikumar@ti.com>
> 
> Add no-hpd property to the bindings, to disable
> hpd when not connected or unusable
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  .../devicetree/bindings/display/bridge/cdns,mhdp8546.yaml   | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> index b2e8bc6da9d0..69d381195218 100644
> --- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> @@ -57,6 +57,12 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  cdns,no-hpd:

There is already no-hpd property.

> +    type: boolean
> +    description:
> +      Set if the HPD line on the bridge isn't hooked up to anything or is
> +      otherwise unusable.

It's the property of the panel, not bridge. Unless you want to say that
bridge physically does not have HPD? Does it follow the standard in such
case?

Best regards,
Krzysztof

