Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01056FEF0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbjEKJpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjEKJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:45:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28455BAE
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:45:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96652cb7673so823017166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683798331; x=1686390331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVklFj7U6Us5/5iCgZWUpMAaVr3nHAvDuh0XewUtxGE=;
        b=DZA64C0XJqlT5OqY+mlCVW3VVuLSI560yLFNsvc/luowPAKQYcEOEw0+FQ6KYVRdcZ
         58iIgYc46qtqNwSxyKE6XXuMMTD3Q/D1ILKZ/DH9PCMsD65xZpaRFQuwjjVQAVQ6lYYR
         UxILuyn+SeEdE50fIKIfm7ipNJnGIXz8pvmrnIm0IGC3mPwlKYATbz0C7ZzkgUDhjvvM
         0K23Chm0xe/8IDInmULumOYMfmPZd4PBxHGLz6Xg/HC4h8gKxdYcv9OMwGu134+tWRYT
         aL+bLt6oDQ7K5+PYKqQO5Pc4MxG/0GgXHEBdmeLtNyBCWjlrr1ojA81Hm84dk2y6m6dl
         Uiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683798331; x=1686390331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVklFj7U6Us5/5iCgZWUpMAaVr3nHAvDuh0XewUtxGE=;
        b=b3q12K2G+J094eKsVT34VVX1dCY14qKDJPi4tcq2XQ10u7CfEYmjLYlYiMaqETfi/P
         zqA2uyv1Q5uec1vRarx6+zuvPYDKcH9b6Xj2RR40v8yHxGfEYmY1WC9/g721feE8uwy7
         O+LQsC6mu6QuPJGnuHfJP5qxRWz4yAnRNpsU8+jYJqzhuD4daJxid3QDPs3m3yDghbtG
         6lHxR5IymZsMhGRXGdhyqI/40iQE4/oubqLJv0ZtCu5n1vm+ovuWea/M26JIfU3lUEX4
         lcJRQAs7idDzL8VaqT4RnER45KiwRSaKSpLTP8p5AMDgKmOdbWpowDcJRGCGTNdqxVV4
         EEZA==
X-Gm-Message-State: AC+VfDzp0Q2kUqSKGxNEGzWp1GYo3xaMKynaewTm8E3s5tUMfCI0Tm3/
        ACGVTLmJucbAVcYHncpVgi257A==
X-Google-Smtp-Source: ACHHUZ5puz34l6mf5xAAvpQpPZm3VVXafZedBH60KNs+c4WzTDBh5xyLKx0lYqv5/c0qjsjW5pGJIA==
X-Received: by 2002:a17:906:5d16:b0:960:f1a6:69df with SMTP id g22-20020a1709065d1600b00960f1a669dfmr22528551ejt.36.1683798330968;
        Thu, 11 May 2023 02:45:30 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7e61:f14a:c3a4:809e? ([2a02:810d:15c0:828:7e61:f14a:c3a4:809e])
        by smtp.gmail.com with ESMTPSA id v16-20020a170906381000b009545230e682sm3772276ejc.91.2023.05.11.02.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 02:45:29 -0700 (PDT)
Message-ID: <280ab18d-bbfa-9920-5f1b-d069fd866e1f@linaro.org>
Date:   Thu, 11 May 2023 11:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] dt-bindings: touchscreen: add virtual-touchscreen and
 virtual-buttons properties
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v1-2-5ae5e81bc264@wolfvision.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v1-2-5ae5e81bc264@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 15:50, Javier Carrasco wrote:
> The virtual-touchscreen object defines an area within the touchscreen
> where touch events are reported and their coordinates get converted to
> the virtual origin. This object avoids getting events from areas that
> are physically hidden by overlay frames.
> 
> For touchscreens where overlay buttons on the touchscreen surface are
> provided, the virtual-buttons object contains a node for every button
> and the key event that should be reported when pressed.

Hm, I don't understand - are these separate physical buttons? If so, why
would they be part of touchscreen? Where do the wires go?

> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  .../bindings/input/touchscreen/touchscreen.yaml    | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 

Best regards,
Krzysztof

