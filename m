Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8C07211BB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 21:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjFCTKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 15:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFCTKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 15:10:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B96E18D
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 12:10:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977c8423dccso100331266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jun 2023 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685819401; x=1688411401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/1fXZdlFrD4ZTMnSyIek5ravNGSg+bm7NeK4UcfZ5I=;
        b=XGWSGPhc+xt9lfYE3ElzKDuGrJr3WUc1F9NreSgchCvhk9+TGEXaB0X+FKeFhLa4Ul
         dBWwVA0PU7u3A9Gb/r9/YacGuXlVlqHEu42aPrlpEXXDzJscOc1SF0ShHSQse0Oj/chT
         QLovyIjmr92pscaSYQIt6uY5CA4K46N++1MwTW+XvEsqSbFTIBJVPKBUnQcFshqSmfQK
         AlKleHL2WPQjWo13ySdvQFAtO3k6DRkLK4/THrSTOZf+p2O7ixH3ctDfYqgLUS+Hg85I
         68k9+su4xAFbe2lICX5JB6tswOOT4SmDCXRpHWHpjtOEseiVoM9V54Gs8SlVtQ7YAqlA
         6tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685819401; x=1688411401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/1fXZdlFrD4ZTMnSyIek5ravNGSg+bm7NeK4UcfZ5I=;
        b=g+8eh7XFBDFDn8gvYrcEuJHwB0b6sH0VJc7Eq7T1TYlIsBdlOvqO6xVvO/s6lH6hC8
         yOfOG5egtQJY6RlZtMisgm8wlpLeA4PW4zptyVP3RKaFZABh+3vnGbaeS7yi3IE4ev3Z
         o0ITuS/E9LAfhDcscTctFMIcfo7eSmHwVXR6uGOxbVFR7gadq0H0jh0W3FvZG5ri/QTB
         kSuKGMv8OlJ41vWfO9AH0LsqacoLRwoDMjWTfKN3jOm+Za56s12ctVddePiMYEUnp/oP
         YezxR+H8yQu3BX0e57lqhpkVztXIe96XU4gy6ZcGUcJpjvoLMSZUax/yG86X34/ArjbE
         nWSA==
X-Gm-Message-State: AC+VfDy3t3Y3hZXaAX6b67l4V3YGt/e6WpA7WD7T7IMg5W9x4sa/NWpU
        wcF+xO9+WjHDELvL4IAz7pJVCA==
X-Google-Smtp-Source: ACHHUZ4RopHcJJ7GF3SSU2ePLu5DlX+l9IkWhVj+EuFjvR5yyF0baMdpGCWtH8xOXILm4qx46Z8pUw==
X-Received: by 2002:a17:906:5d0a:b0:974:5bd2:1807 with SMTP id g10-20020a1709065d0a00b009745bd21807mr2096976ejt.24.1685819401691;
        Sat, 03 Jun 2023 12:10:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id bi1-20020a170906a24100b009664cdb3fc5sm2218126ejb.138.2023.06.03.12.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jun 2023 12:10:01 -0700 (PDT)
Message-ID: <d354734e-c8d1-2d75-fec4-e91bb322bbe2@linaro.org>
Date:   Sat, 3 Jun 2023 21:09:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: add PHY_TYPE_CDPHY definition
Content-Language: en-US
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     mkorpershoek@baylibre.com, khilman@baylibre.com,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
References: <20230524083033.486490-1-jstephan@baylibre.com>
 <20230524083033.486490-2-jstephan@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230524083033.486490-2-jstephan@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2023 10:30, Julien Stephan wrote:
> Add definition for CDPHY phy type that can be configured in either D-PHY
> mode or C-PHY mode
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  include/dt-bindings/phy/phy.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
> index 6b901b342348..a19d85dbbf16 100644
> --- a/include/dt-bindings/phy/phy.h
> +++ b/include/dt-bindings/phy/phy.h
> @@ -23,5 +23,6 @@
>  #define PHY_TYPE_DPHY		10
>  #define PHY_TYPE_CPHY		11
>  #define PHY_TYPE_USXGMII	12
> +#define PHY_TYPE_CDPHY		13

I don't think there is CD phy. It is D-PHY or C-PHY. This is not for all
possible combinations but just types of phy.

Best regards,
Krzysztof

