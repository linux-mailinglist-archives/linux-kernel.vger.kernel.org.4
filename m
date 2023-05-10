Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213F26FDE30
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbjEJNBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbjEJNBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:01:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119A210D0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:01:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so11307128a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683723704; x=1686315704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTSuq3NDt/ME5bHplyIBYepiTrQPylK+sN6AsuBQf6A=;
        b=oZK42tAASjykp4YJHKVYTt3oaxs41CaF0OIVE1F4Om8O4zLHe91PLR5gxO07TGavZ2
         NMdt0uOapM98MAyDB3SLxF6zH7TtvM0Gl9qnzZJ60V6MW2J/d0eJAF98PrMU/kRAE56f
         vblCyWgM2XJcxQY9URMUpav4f0Yg9Nsl4URpQ2vOq9QId3SScddN0HtniSQ1+b772y1s
         att+x7HxqWwA5Yl6RBzACLo+XZl8GAxE1QJgjp4uzVYor/HpPKrHNGJVyTRMppEsGr1c
         gqh0kffHA0fHkQjeUg7wK/xCKAo/XJZ1XO9xu6twU2l1/lKvSGdrVWGj7+NLGMzY4vee
         kpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683723704; x=1686315704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTSuq3NDt/ME5bHplyIBYepiTrQPylK+sN6AsuBQf6A=;
        b=UlZi64+fN7muLFtoEcijr+/dG1uwncNo5+kMzxO1n5VfHSVcMshAcCg30z44sbWCjT
         3GF3F6arVCyzeE+Dg3HQmMSIA2OW566LLje3IIBDwpcJqJp80ymBAzWsAF1vfsmL82pm
         LHJ29GXPtZOJWNRXp9nzyeY3pdIciN5wrrbmY+8eRPJjiMU6y4BA1srbP+Cf1rA+mBAg
         SJ2aKL61mj58ogws0N+U5qs9mdNvLkhbixH/FnmjTe+ag10bSeytmnAVtSbM+9YUJDvJ
         ORd0Ji2uwdkF4u9gi52vhmbd2lDKngOafNEoQGu8O17QSDqouLmwP1hbuptDUq0iNWA6
         G12w==
X-Gm-Message-State: AC+VfDyx7qvwgfUPtinak4YUXRWV/GwrocVzetkGyMr8OM315EglpRTd
        hbzKJQ1FS8UA090bLJnxGPgoTQ==
X-Google-Smtp-Source: ACHHUZ6lzwGt3UDUWKA3fG12lk99noxQscMcbWE+8p4YpZFMpd6LwjH8FGT4TEsQFjWkSJroZKY0nQ==
X-Received: by 2002:aa7:c7da:0:b0:50b:5211:446f with SMTP id o26-20020aa7c7da000000b0050b5211446fmr12505526eds.6.1683723704251;
        Wed, 10 May 2023 06:01:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7c24c000000b0050bf7ad9d71sm1854442edo.10.2023.05.10.06.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 06:01:43 -0700 (PDT)
Message-ID: <538a009b-d5b5-da72-f775-9ec89b34afda@linaro.org>
Date:   Wed, 10 May 2023 15:01:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: fsl: Enumerate Emtop SOM
Content-Language: en-US
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Markus Niebel <Markus.Niebel@tq-group.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230510112347.3766247-1-himanshu.bhavani@siliconsignals.io>
 <20230510112347.3766247-3-himanshu.bhavani@siliconsignals.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510112347.3766247-3-himanshu.bhavani@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 13:23, Himanshu Bhavani wrote:
> Add entries to the list of imx8mm boards denoting
> the Emtop SOM from Emtop.
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 442ce8f4d675..06eb2c790f90 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -884,6 +884,7 @@ properties:
>                - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
>                - boundary,imx8mm-nitrogen8mm  # i.MX8MM Nitrogen Board
>                - dmo,imx8mm-data-modul-edm-sbc # i.MX8MM eDM SBC
> +              - emtop,imx8mm-emtop          # i.MX8MM Emtop SOM-IMX8MMLPD4 SoM

No real improvements. Still not change in compatible - neither naming
nor additional compatible.

Instead of adding some random changes, please describe in commit msg
what is this exactly and then use compatibles matching it.

You already got two times the same comment that board called "emtop" so
the same as vendor "emtop" looks wrong. You never responded to these
comments. Don't ignore feedbacks, but either respond or implement them.

Best regards,
Krzysztof

