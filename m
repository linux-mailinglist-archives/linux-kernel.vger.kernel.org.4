Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634725BB982
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiIQQoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIQQoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:44:10 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7250330575
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:44:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a21so13153012ljq.7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UbxD44FPA9DVBAsyCFB9m2FQF9UnRo8mDIy+zUITRpw=;
        b=Jx8A6xM8SaI0quutSVP01509NbtuHSj37nlV4FU5pwhc8sV4KdlaJGaumBMWtXSdAE
         156zHV36OtQn1HI+eFk6IDdNPJIXge2fJ/MoVQMrjex6X5BjPk33jivYYGemR5lJVe4x
         xnClZmExuuebw9f6xMjPUntiY5xNhX8Tua8wYK9QW7RXRbt5z0jJwlry19kiBro3P0Vs
         kYNHA9RJqSv3C+wxvIeqsFRqewIHJ1+whL9cxKlgaErSXDWW5yfKcDR3RR9kXS4LAR5P
         oH45OGvDm9l8Kg7AuBG7RUYEzRDRepODs9MJyj99RDo0ZCSDZtB9jcHvm5ZXTBmcjdfm
         ccfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UbxD44FPA9DVBAsyCFB9m2FQF9UnRo8mDIy+zUITRpw=;
        b=0+1eaVw2NwkejMArSiKac+PLZnOfIq+PJl5/egQnzE9qmQ/Y5YMLmAMRT+dxzWXEcP
         924yPEhUOrxezJJa0ThZj8Mwj0L3rI+WqXsk8XGn1MT+Cao6znqPIfC2RUbxcqzfMaPp
         BEHvmutSMP+9uOxVNc2xnnxSocRmTjU5OMl86JBKKvY2cyVDiKaDxbN5iw9FH8No/JFk
         oi4MWcgTEtmrSxifCpt1A3nq7UtZAIkggE/oWJlioto8yBuhLeraQFKpUU1Vyd7eSbmf
         fvCMTj/GDwlRNQlKlzKh53VZx1uA5DBjSjEDjcNTvp31Q6qjZXgSG9d/vga/DK0R4GJY
         lyHQ==
X-Gm-Message-State: ACrzQf1H10WoQBc6QCmUO03kaXb080uW2TJxAl2EMUC8/gP4nWIuP96z
        jyAQEPcHUzNgHT4d3Yq7AEa7jw==
X-Google-Smtp-Source: AMsMyM6xblNCEEfv6RFhjTD8iiEgEa3hrGAlGuvgStgrjjgaoC4xpWOURFcj4JwUqepmyF/AuGyLtw==
X-Received: by 2002:a2e:8917:0:b0:26a:a520:db52 with SMTP id d23-20020a2e8917000000b0026aa520db52mr2737478lji.289.1663433047835;
        Sat, 17 Sep 2022 09:44:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 12-20020ac25f0c000000b00498f51af149sm4162572lfq.308.2022.09.17.09.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 09:44:07 -0700 (PDT)
Message-ID: <e20375a8-4496-315e-67f8-feb8ddfd6d3e@linaro.org>
Date:   Sat, 17 Sep 2022 17:44:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: mfd: dlg,da9063: add missing regulator
 patterns
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20220916190009.2292223-1-conor@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220916190009.2292223-1-conor@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 20:00, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Commit 5621d3977e29 ("dt-bindings: mfd: Add missing (unevaluated|
> additional)Properties on child nodes") exposed a flaw in the original
> binding, where "merged" versions of some regulators were missing,
> leading to warnings on the HiFive Unmatched Devicetree.
> 
> Add the missing patterns (and merge some of the trivial ones).
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I opted not to include a fixes tag for the conversion since it just
> converted what was already there. I figured the original text binding
> is just incomplete rather than "broken", but if you don't agree the
> fixes tag would be:
> Fixes: c7f15d43a5c5 ("mfd: devicetree: Add bindings for DA9063")
> 
>  Documentation/devicetree/bindings/mfd/dlg,da9063.yaml | 2 +-


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
