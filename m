Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DCE701589
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbjEMJRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEMJRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:17:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31D635AD
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:17:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so8504985a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683969449; x=1686561449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTLR4PogscnMBTZBkvB7RGFYHJau0v0cejPxr/vN9k8=;
        b=xfAQOgPxcH7wwlTuNghJXHOy2DcAeT1kRE54vhf5sitauk1Ir7xfUMQghRstvMyX2T
         /j/hWlmyscrzHx5WGswLA4UR7AyoC9R8zsw2IKGaeiDdqbJ1Mq/lCMvkgwbyykFo/1kx
         wSjWykIuL8zp5WIl4XlfnvocjaoYzdO5Zxk+6mu/FWFemKrwgUKmii2IyHOp72wMTmU9
         SB8Wi1SyubekVVGqrqHqvhZcRMhaD/yRt9qkt0Vrhjn79VHBTWclkIrtzYW3HvGET0dF
         CcGvhv41bYlzUTKAd88UAduIhh2b6yyQCOLaHHKaZt63nnjWNJ9o3Jlp0YGSIzCtmDmG
         hCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683969449; x=1686561449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTLR4PogscnMBTZBkvB7RGFYHJau0v0cejPxr/vN9k8=;
        b=CyAIbrvLqQ8BsRys30G33FlhX8LNRAEBs7R3f/hkAkyBNXxdl9cYBsOKtoMMt37qv3
         GqJypEh4wQCCTRfawIYJHftj+75NMbSP79xxGDTUHXv+pLOPQhQ59CrQ4tiwk+BC/wxn
         vOXvCu++YljVLqvj5T9Ms3ZMBpgEqAZYij3P4nRW7VHlpCQ6K/1VzufLt/4mCII3+h5E
         ugkDwDVv6jigM3k6nAf7J17y4Dw6XH/rnjFiAmv0440JarXIrHvXnYtY/fIU/vGXKjaM
         9l3WTZI6d2VTrbe3DPte7K8rdZeqm/ecCVjLgQ0CiYIBp7DoYug35j1EajgGmvyGTpDP
         /IDw==
X-Gm-Message-State: AC+VfDyGzMCQOJRKH2ewFJyrp0t7NHrXyk7enOXCBIbPmw05DQ5TpSc7
        5kF2Mv2WWK77YahV2RhGVSUj3Q==
X-Google-Smtp-Source: ACHHUZ69QEjwE+BynXYVDyAFSfxIlXaZcKvg5b1ZrXCXlBQoNPvTXq66y08Oz9VquhUbC3bpukcr5Q==
X-Received: by 2002:a50:ec8a:0:b0:50b:c275:6c56 with SMTP id e10-20020a50ec8a000000b0050bc2756c56mr22337584edr.16.1683969448948;
        Sat, 13 May 2023 02:17:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1d0:810a:586c:c5ba? ([2a02:810d:15c0:828:1d0:810a:586c:c5ba])
        by smtp.gmail.com with ESMTPSA id f8-20020a056402068800b0050bc9c38fb4sm4634967edy.69.2023.05.13.02.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 02:17:28 -0700 (PDT)
Message-ID: <ff7aa7b6-dc45-25ba-9636-058c2bb73a6d@linaro.org>
Date:   Sat, 13 May 2023 11:17:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R2C Plus
Content-Language: en-US
To:     Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230513065228.25971-1-cnsztl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230513065228.25971-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2023 08:52, Tianling Shen wrote:
> Add devicetree binding documentation for the NanoPi R2C Plus.
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>

subject: missing prefixes (arm: rockchip:)

Drop "doc for"

Subject: drop second/last, redundant "doc". The "dt-bindings" prefix is
already stating that these are bindings and it is documentation.
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

