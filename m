Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F0D723C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbjFFIqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjFFIqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:46:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4660FFA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:46:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-976a0a1a92bso635405366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686041174; x=1688633174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhXwQM1axbZVP2R8OTg/nTjRF7LjBSXFyA1Pe1rgXwU=;
        b=rz3hnPVFfhJzaBCsj7KdnoW0gEFzBX+E4PmxU2fSGOXzX9Z736UZEzGJVbPU95rVXF
         yWbhRTdZQWTQUmRR6Al75izbMAIlNO/eI3RTB4MKzlhjY+6DitK2Ozp8ne9ElMAv8GKr
         Nqbb1sS5lku0wui9HJAOnwLD4DfDzzj2cM2j8VFtnMU/n90z0lAy1JNUb/KpNHxwz6cr
         cpCjh2bApJio4b/SQcgC5OixLa4idbENmrjA/k/8P+SxNnORYDSp6z3CCyhLWbBxpU9q
         MuDzunhAflP9gXTmwyPVs7k1gj01Z6Vth9HXUd9tAWbAIaJ0NFsaL3l2aIuDZb6VuQAM
         6f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686041174; x=1688633174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhXwQM1axbZVP2R8OTg/nTjRF7LjBSXFyA1Pe1rgXwU=;
        b=Nf91nFwRXq5DtOlraX8wpK/xd60o3tBKzqqgfCdhYyqJNMmChWPDkroEwwWoR8Q0JA
         fDIIJzOASnGEMLEiwhzVqwnnKhLj3fNsUwFrZgGdfpa/YBS+omSyc+3piMwCpibBTuIh
         m6GE/B6+Sz/MxwYcUcTpmX7mpodwDt7A2DXGckfD66ADZpL+YU2zTl0JoXFVLe1Xq/fo
         PW0wSGp8zKmtHuE6rl9TXegc7xFU5glnItWGIcEudk5tY0u/Ih8ojuwe6SjlI71DuxIS
         bjz/9TyZ3LBJe9Lc4IB+JODBvFC5VK750fJqNGt6Jp7fpS6tvWG+bjBtoRArf5A6fuPx
         VYEw==
X-Gm-Message-State: AC+VfDzUlgJSK58GJB2eoYn+I+dCxkDN+oBzeVaD03dSjDZB8fBTMCI8
        1RKt68y8JQ4pU2iINKd8ziDjeQ==
X-Google-Smtp-Source: ACHHUZ6XPMkYalRlyNWE2pAPL43aV20Dl8/aCIgapDRm3k9iQeuNZMX/aNkFgm3+1GqDSzEW+qa8mg==
X-Received: by 2002:a17:907:9496:b0:970:19a2:7303 with SMTP id dm22-20020a170907949600b0097019a27303mr1672203ejc.19.1686041173683;
        Tue, 06 Jun 2023 01:46:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906504400b0095342bfb701sm5455841ejk.16.2023.06.06.01.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 01:46:13 -0700 (PDT)
Message-ID: <2c3fa1f1-1859-0914-b39f-05f1f4186179@linaro.org>
Date:   Tue, 6 Jun 2023 10:46:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 2/4] dt-bindings: phy: qcom,usb-hs-phy: Add compatible
Content-Language: en-US
To:     Rudraksha Gupta <guptarud@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230606040529.122433-1-guptarud@gmail.com>
 <20230606040529.122433-3-guptarud@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606040529.122433-3-guptarud@gmail.com>
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

On 06/06/2023 06:05, Rudraksha Gupta wrote:
> Adds qcom,usb-hs-phy-msm8960 compatible
> 
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> index aa97478dd016..bdeffb52340b 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> @@ -13,7 +13,9 @@ if:
>    properties:
>      compatible:
>        contains:
> -        const: qcom,usb-hs-phy-apq8064
> +        anyOf:

Look at existing bindings how this is done. This should be enum.
Best regards,
Krzysztof

