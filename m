Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDB56FF842
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbjEKRT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbjEKRTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:19:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B6A269E
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:19:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-966400ee79aso1156219166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683825590; x=1686417590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eunIQ03uNZjUU2GkkuhvFo5I2GT1qog2Ume87o9OM5M=;
        b=HaumjRdP6lA4BZ5nCiBzjsNDxJ1qrMwBoLqM4b7X4VwIlV648PTpjLnuScQKcuuRZL
         T8MGY+f97IVeBDXbjbA34NTwsEy6ll9ygrmnbh/qPIyvwqILrAbZIuqcEvWQWCEgHxtT
         qTZSBWtb5M5L6ZFlIGdSPjDt3pj6da5beKYgz9RLN0jYgQk/pB1SxB4YX3S14rQUBL6I
         xgk6Ir7yFuAJTzcz1QpFmSgH+BgYZO4vZhqK77SG3JWBH4OWOb6mOOCsBjpb6Q5hA6V8
         0cAWu/HcyplFC6LNIReza+LWRp0i9dprJMt8/lYDzcTmwM6EDIIbxyslkF8ZB89RnlEQ
         WvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825590; x=1686417590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eunIQ03uNZjUU2GkkuhvFo5I2GT1qog2Ume87o9OM5M=;
        b=lein4VDFGnvT4owOUzjsss5D0kaSbOlURT+aMp3Y5jh573SKnKizsvQv0BNP1quYIa
         IPAmYFmdiOSFtSotnd6k9EkkfjK2sX+gxJ4ALy1CRx+pbZcBK+13PYWcyiJ/72JzU56f
         cyze21J+d2bzrxPvi4dBtVCJktDf5UNEC2uwU8W4Ry5BS5iZatMvk0I4Dp4FsgpkNU2x
         hHMw4/6Pu/jrXz/j7jZ3/zr/cufwsJC3tZg5kK1U4GhwaGogvxSBOEFNMQbetDtxQcP9
         X9ddpmT+eWTG+2Rh6rRZvAOvPpdPaipG9BRZW66x/0nwOqQeS9Zfjl1OX5VEu+KcVPr8
         pH0Q==
X-Gm-Message-State: AC+VfDz9J1/ueh3eEzmsXhuYcBPE/JYNTq24YehZLDo5753XbSJtQSsH
        GZlBz6JlN6h65AMhL8rEefKrSg==
X-Google-Smtp-Source: ACHHUZ7R4pHJhmNN2+07FyfWKchnPUBZBSfm6dp68EGDXfCd14VPWm83cTsaUv8dX7FfwolNT++EVQ==
X-Received: by 2002:a17:907:a41:b0:965:b493:59e0 with SMTP id be1-20020a1709070a4100b00965b49359e0mr17574176ejc.15.1683825590369;
        Thu, 11 May 2023 10:19:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d7cd:1be6:f89d:7218? ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id kt18-20020a170906aad200b00965cd3a037fsm4233193ejb.112.2023.05.11.10.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 10:19:49 -0700 (PDT)
Message-ID: <1c0d5ab4-e3d0-54b3-d0b3-d576d0241913@linaro.org>
Date:   Thu, 11 May 2023 19:19:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add Gateworks i.MX8M GW7905-2x
 board
Content-Language: en-US
To:     Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230511171041.4011087-1-tharvey@gateworks.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230511171041.4011087-1-tharvey@gateworks.com>
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

On 11/05/2023 19:10, Tim Harvey wrote:
> Add DT compatible string for a Gateworks GW7905-2x board based on
> the i.MX8MPlus from NXP.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

