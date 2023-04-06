Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB696D9EA8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbjDFRXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbjDFRXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:23:23 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B98A5F4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:22:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-93434918b67so111411066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680801708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=145yGzODgxY+rJbwAEpe0vSJYcWx7FkVo4x57vw/2Ds=;
        b=J3QonWmOAxHMqJ1EOSUj4Rs4updaQcuUihcgcTFNhvmsCy6vBtmalIIUSokDtx0F3o
         6nHdCIpzrLSH+VxgApjJ8P2UKckkNOkxX/fwqeuvB1cGopdBPEPwOnwC0KJ3GsZyHB2W
         lszpadIv4hDgi03TskBGJpV3t+bDZsTEL0pGZgx1pl2e+DHeJwKaUvIFHVjPHSxHNkqP
         jZtZPk3HiuFjSs3/9EMd2Q1h/dPqJqn3uopp1XusIxh+cfVVyR84rP6A1HeFr3Huklb5
         JjnpiK3qXY8wlTF4ziKCllgSkJV7EMH3nOtGeRVKFnwORSESnC2LfbhneG+9pO1Bz2WS
         sPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680801708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=145yGzODgxY+rJbwAEpe0vSJYcWx7FkVo4x57vw/2Ds=;
        b=u8Li2/A5pQhtYD7TgEZk5i+5X5KBWTMo71i95qxV4QjlRxfX4bXpy4MItofcdpO4Yg
         3TCtjPHhjZm4Dd2hBHw5r0YyTn2b1IhFNMoZR2eAsLlso0W4SQi26L3BaQ5KjXkD9anO
         qPslnKkVky1/HbuMD5Sj45EjFNC0p6lX9x87LndbRDXNbTmAekD2s3XRJqdD3WzgNGGH
         N5j9c3FGrxcgcMsds2Il4JCkFH0Exi8p7qqDJKpN7lZQTmWwHDfwjjXzNtoCgWCP0tGg
         Zq38nSFeqaAn9Qg0Mw9QX2WhFhSVRY8aA5iCfs4ww2gszhzBSXiucXzYd/zD85BFnRT9
         I9dA==
X-Gm-Message-State: AAQBX9eW6/V2ZyBo8kQZf0RMEDIMbEZOOCVHgXMyjlMpKo8vo6z4dC8r
        mnUkvjrf0B+e13LurVxC6bVHng==
X-Google-Smtp-Source: AKy350YRBx7KoZyPvNoeZ4w8rpaupgS8OEN5BdZpbF0ZP0CslF/6SZi49GUb5ys+HM8ofDMXceerJw==
X-Received: by 2002:a05:6402:344:b0:502:246e:6739 with SMTP id r4-20020a056402034400b00502246e6739mr235993edw.27.1680801707878;
        Thu, 06 Apr 2023 10:21:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id jr3-20020a170906a98300b00933356c681esm1046545ejb.150.2023.04.06.10.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:21:47 -0700 (PDT)
Message-ID: <c79ca1c4-d7d7-50f5-ee2c-1c1ff459c429@linaro.org>
Date:   Thu, 6 Apr 2023 19:21:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/5] dt-bindings: Add Blaize vendor prefix
Content-Language: en-US
To:     Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "soc@kernel.org" <soc@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>
References: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
 <20230406102149.729726-2-nikolaos.pasaloukos@blaize.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406102149.729726-2-nikolaos.pasaloukos@blaize.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 12:22, Niko Pasaloukos wrote:
> Blaize, Inc. (www.blaize.com) is a SoC manufacturer with integrated
> programmable Graph-Streaming-Processors for AI and ML.
> 
> Co-developed-by: James Cowgill <james.cowgill@blaize.com>
> Signed-off-by: James Cowgill <james.cowgill@blaize.com>
> Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
> Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
> Co-developed-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>

Four people were working on one pattern in vendor prefixes? I have
doubts, because this is very trivial patch.



Best regards,
Krzysztof

