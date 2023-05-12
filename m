Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E3970014F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbjELHVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240230AbjELHUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:20:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32762133
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:20:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-965ac4dd11bso1901050566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683876005; x=1686468005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlguJbcdCNMathxuQaT8K1ShmJFBrwncaunh1gm2DMA=;
        b=zjZZlcSx9bRLm7NbRTThmkTzkg6bZAe2fzIMzQG7yK9ZQxEGgMdJ8YRXv/ExXqGGy8
         53J76c6RZ01PDztd4+wRS0qnQSuOAU4EuKqJXt7v7XxfFaW+rKLUMg4AQKIYwxzeo3yf
         87d0MBoshdRtjOD17HdXHQyXlDgAfPceSbwvKHR6ObXMAuwkpXdQ8E9ktapySertXzwO
         3m8tZUo6x+WYJNmmUet/uYBaikJHufa3SwQpXD4fxDJJlaYSzvlupAKQsgjUs7hxK3ZW
         rPR4Knx4coKMiNgrZM6ex39R8Ka2NvwFNjQNYHniVJRt5zP5Nj+om9GAh9I6DS7787HX
         1d2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683876005; x=1686468005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlguJbcdCNMathxuQaT8K1ShmJFBrwncaunh1gm2DMA=;
        b=Hg0VceTr/U6hWzQRPFpiBMf400jvDTpKi76yVKHBnm9SWunNonz7+Iskk17oINAR2x
         kNk4VSLjn8splvYDHjRkx6XUyXCTNVhPlQlL9+RcbVDMBXAOPi2NF5w3dwPRE/VhHUrn
         0Eg3rAj/SNcXNipGpv17s1n6ITiw8HK2cQdx59LYq4+roIe6Ju/5E//NqwFdd//Bm3Eg
         4lJjc6alL3BjitP9/y5q+/uBTtrxfae//hnqkGzpHgqx5jaI4qTZ25KpWlhDVO/xGJ6z
         CFP7WVPv04VY25vaW2ULcY3nzViwdO7STtrsXOFTzMCLIiUUKaFJA69DWpS+dpUsMxCS
         K+rg==
X-Gm-Message-State: AC+VfDzIiRaiZWf1Xg2JEcECOY+eu/6LZLZVv/oxHdzQ0DOn1eyl3AtQ
        heERe42GTw9MW+CROnyGTbui8rbZt0GNDau+css=
X-Google-Smtp-Source: ACHHUZ6kHpYm/ztsDr4Tt/aKxMxZJ/ipvJtZl7+U0eec21VCikd5eB6PtaLIK6EKdEJz94Ji8ssSxA==
X-Received: by 2002:a17:907:94d3:b0:96a:58a:6cd8 with SMTP id dn19-20020a17090794d300b0096a058a6cd8mr11609156ejc.9.1683876005348;
        Fri, 12 May 2023 00:20:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906c29000b0094f3e169ca5sm4998094ejz.158.2023.05.12.00.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 00:20:04 -0700 (PDT)
Message-ID: <cdcd5656-2c7f-23bf-d016-fff79a279ebb@linaro.org>
Date:   Fri, 12 May 2023 09:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] dt-bindings: touchscreen: add virtual-touchscreen and
 virtual-buttons properties
Content-Language: en-US
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v1-2-5ae5e81bc264@wolfvision.net>
 <280ab18d-bbfa-9920-5f1b-d069fd866e1f@linaro.org>
 <18526d2a-ac5f-2b26-9ed3-5a82f20cac86@wolfvision.net>
 <a7261bc1-902d-99f9-aa3e-2c90dd264c8d@linaro.org>
 <eb3f40e6-a604-39f2-eb49-8b41590a65d4@wolfvision.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <eb3f40e6-a604-39f2-eb49-8b41590a65d4@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 09:08, Michael Riesch wrote:
> Hi Krzysztof,
> 
>>> These buttons are actually physical i.e. printed and with a given
>>> functionality, but still part of the touchscreen as the physical device
>>> is not aware of them. Therefore they only make sense in the touchscreen
>>> context.
>>
>> So basically you still have the same touchscreen under the buttons and
>> these are not separate devices. Whether someone put a sticker on
>> touchscreen, does not really change hardware behavior and it's up to
>> system to handle this. What you are trying to do here is to create
>> virtual buttons through Devicetree and DT is not for that.
> 
> I have already addressed a similar statement here:
> https://lore.kernel.org/lkml/20230504042927.GA1129520@quokka/t/#m1a93595c36535312df0061459a1da5e062de6c44
> but let me extend this comment a bit.
> 
> The notion of "someone putting a sticker on touchscreen" does not really
> reflect the use case we have in mind. We are talking about devices that
> are shipped from the factory in a particular configuration, e.g.,
> 
> +-----------------------+---------+
> |                       |  power  |
> |                       |  button |
> |   touchscreen         +---------+
> |   (behind: display)   |  return |
> |                       |  button |
> +-----------------------+---------+
> 
> Here, the real touchscreen is larger than the display. The display is
> behind the "touchscreen" part. Behind the buttons there are symbols
> engraved in metal or printed foils or what not. I just would like to
> make it clear that these symbols are not going to change.
> 
> We believe that the engraved or printed symbols actually define the
> (expected) hardware behavior. Of course there is a virtual notion to
> that, and of course it would be possible to let the power button work as
> return button and vice versa in software. However, the user sees the
> engraved or printed symbols (which are not going to change) and expects
> the device to react appropriately.

OK, I actually missed the concept that display is not equal to the
touchscreen ("screen" actually suggests display :) ). In your case here
it sounds good, but please put some parts of this description into this
common binding. The sketch above is nice, especially if you can point
where the virtual origin x/y are. Picture is thousands words.

> 
> Now if you suggest that the system (that is user space, right?) should
> handle this, then the question would be which component is supposed to
> handle the touchscreen events and react accordingly. I don't have an
> answer to that and hope I don't need to find one. But independent of
> that, a configuration file is required that defines the area of the
> virtual buttons etc. Wouldn't this be similar to the (mostly) beloved
> xorg.conf containing the definitions of input devices?

If the case was a bit different - e.g. display is everywhere - I could
easily imagine that on the device rotation you want to move
(re-position) the buttons. Or if user has some accessibility option
enabled, you want bigger buttons. Then it would be a prove that it must
be configured and managed from user-space. How, I don't know.

Best regards,
Krzysztof

