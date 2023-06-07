Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2789C7257CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbjFGIed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjFGIea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:34:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE851707
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:34:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977d4a1cf0eso523707766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686126840; x=1688718840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NHYmPirAe/9yvPI0Un/v2zVHDoxK5QiPyOUyzdkadvI=;
        b=U2hVnnnQHDbTv1gfXtWS8Pqlo7XQNgezPdGgIOH15eBZc69fe4DzqxB+O0KT+AwOd0
         U/ONfqGQEzf+j24bGuDllsF83FLGhDWc19JJWKjOeDe4bNSvAtGmeBPYHdMjrZsakqcD
         NaiGPG6Ts0znHSVO4WYEQVESzMF8KM4qlRZPKL6QCxWPRecPCQsKEZJmLaHIs0QWtwv9
         XGOG4DtNMaj67xC4rdSipeUjR4h+PxN9m4SGyy9kc3xrSsLiR7l2EaHPO94FL2RT8xwf
         aTQMXrc1m90PqKIfLUJr3psB9ASdlkyuH2y+nqiyxMkhx1sgmXUBP5Sk8XiFZ/fbeGj8
         djDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686126840; x=1688718840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHYmPirAe/9yvPI0Un/v2zVHDoxK5QiPyOUyzdkadvI=;
        b=Y1E9avo6uQO1F9Itvp0q5XvXVs0gQg+mcd74n2r5iYk0S624z8wPvtfyhJtRJZo3qo
         KHc28jhQ6F56QEXeKIoLpRXycaZ1s+Ux2k5elrosOXRH2JCbVPow+Qg6ULlgB5tvJkW8
         9BnUmeX/39UeBNWEqU5oVqWiAIavmUgFwPKcw+0FQU270clDgEEi8zdxrpbnN4JE9l5P
         QpOCNWIciPB/yvgnw6G0RwuEdINZzFfkzF3YWlucST1rb5SwBlAZ9+dCg0M0IgzSARkN
         EXmy01bOFuXEDwRtueSCLBIY9dt+N6FjUkWe9gAb9OaaaiM/gfYsIqFqRDEsv0jN3oIF
         Q/vw==
X-Gm-Message-State: AC+VfDwD62IrL0+UHWP6WroOgVIy0CQA2uN4c62YaBE27wA75HuUb16S
        PoQwsEE0fhrrXEVNIGymewOTuw==
X-Google-Smtp-Source: ACHHUZ6h6766vJMwn/tNHn3JSBfjpWgC88xarXppxRZ+ze1TywPShnS202vrMK1Xo6zB8ufvs3B7nw==
X-Received: by 2002:a17:907:e8f:b0:978:8925:7a00 with SMTP id ho15-20020a1709070e8f00b0097889257a00mr266294ejc.15.1686126840620;
        Wed, 07 Jun 2023 01:34:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ci17-20020a170906c35100b009787ad3157bsm823497ejb.39.2023.06.07.01.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 01:34:00 -0700 (PDT)
Message-ID: <2af1bc5b-0be6-46cc-3155-307f13fbba11@linaro.org>
Date:   Wed, 7 Jun 2023 10:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v5 3/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        Patrick Williams <patrick@stwcx.xyz>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee@kernel.org" <lee@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-4-billy_tsai@aspeedtech.com>
 <35bf0a69-bcf6-ae35-eb3c-e74cfcf9c571@linaro.org>
 <ZH89fXknZlhGmM_H@heinlein.vulture-banana.ts.net>
 <c28f963e-d13c-6b5c-c389-996e986f81d5@linaro.org>
 <SG2PR06MB33652E18980E9CF8E4F0894D8B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <742d3161-3a4d-ea77-7bd4-85f6636bf400@linaro.org>
 <SG2PR06MB33657063A2E3239AD0A21F718B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SG2PR06MB33657063A2E3239AD0A21F718B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
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

On 07/06/2023 10:32, Billy Tsai wrote:
> Ok, I got it. I will remove usage of the simple-mfd and parent node in next version of the patch.
> Thanks
> 

1. Whether parent node stays or not, depends on the hardware. Please do
not make random changes which do not correspond to the hardware.

2. Implement all, *all* the comments from previous discussions, not only
this one.

Best regards,
Krzysztof

