Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1D5E76D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiIWJXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiIWJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:23:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B61E10A8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:23:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a2so18847655lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6KRGHi5QO3WPnDzOkycHTFaQ6rn1LlFLCXaq4LIPA2o=;
        b=nr19Q9adKvfDHJX1/MuKtdcCmb+W2G4kH9i+60wOK18TE2mFjrQb+Zhxkd4iaZDLYw
         UljVVMKI9OZEOTsuDxxGAT5c/UFL8XR67rS6OWaaw9r4B8Qgmujg/irw+c6WkX8QZbyS
         uc4dhF5ciBcdB6NnytStFtuQlGW/MCd6onKxK6cu8Ue6qxkAAec6dFtEW27xIKGPCGf+
         RJUnMQeiGSrQ6DmPFstmf9gOAdikqtf/ykVZrUAvavkQBmcQrXPZk3kubgEHf9sxAbjQ
         KYQt8AkzYu1LGEoaUIe2emDFYd9Atk9KwGWgew5BnOESRBgIDVIrqORDZrcToYmUVGlb
         5d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6KRGHi5QO3WPnDzOkycHTFaQ6rn1LlFLCXaq4LIPA2o=;
        b=E1dmb2yL0gNgpRh4/cSzxQ3CILUlUPBBTE9DXINKVEaINfWb9QTfupCu396PMFVmfY
         XQRo07rVUyT2+FvDkT1Kj4Hn100eVY4p5+IO6zdepReLZTTjsMZnscg9Ivx9LYOPTT4A
         hsfdioqROrG7ozAffWU63lF2QpGKcpb/oY2yU3h7M3uiKlIvSfps2I8WW4Bs7G5G585h
         vMXvSJUqATRmCVq4aUCmHtHq+hKUc/4TL9CVdmLm8vAx2RvSdv8i63uk40Avpy3epeo4
         WXb9AbNu6CCvHqmBWRV3y7XnTYXwk/cnHH9+3WZx3jzyLXaWY57FnND1km0V3r2jMfBW
         QCGA==
X-Gm-Message-State: ACrzQf0kHdTKKZ5BGOdtSsjg//hHibL49vYEy+7n7fZnbwcKrR2vg918
        zarrkeE9gAJmM2wNShdio4Tvsw==
X-Google-Smtp-Source: AMsMyM5CQWggSmYXQq0F3Di+/pXRM3IYsH2YikO+/Bi2/zu7pZyr6nxphxgrV9sWndQW0zsNvXqCvQ==
X-Received: by 2002:a05:6512:1320:b0:488:8fcc:e196 with SMTP id x32-20020a056512132000b004888fcce196mr2715533lfu.602.1663924994025;
        Fri, 23 Sep 2022 02:23:14 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f4b000000b00499b1873d6dsm1349862lfz.269.2022.09.23.02.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 02:23:13 -0700 (PDT)
Message-ID: <29f9fbd3-a266-e947-5dad-27181d3945e3@linaro.org>
Date:   Fri, 23 Sep 2022 11:23:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [resend PATCH v4 2/2] dt-bindings: net: snps,dwmac: add clk_csr
 property
Content-Language: en-US
To:     Jianguo Zhang <jianguo.zhang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Biao Huang <biao.huang@mediatek.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Christophe Roullier <christophe.roullier@st.com>
References: <20220922092743.22824-1-jianguo.zhang@mediatek.com>
 <20220922092743.22824-3-jianguo.zhang@mediatek.com>
 <04b9e5ef-f3c7-3400-f9df-2f585a084c5d@linaro.org>
 <8007b455dd18837c06ab099a6009505e7dddc124.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8007b455dd18837c06ab099a6009505e7dddc124.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 03:48, Jianguo Zhang wrote:
> Dear Krzysztof,
> 
> 	Thanks for your comment.
> 
> On Thu, 2022-09-22 at 17:07 +0200, Krzysztof Kozlowski wrote:
>> On 22/09/2022 11:27, Jianguo Zhang wrote:
>>> The clk_csr property is parsed in driver for generating MDC clock
>>> with correct frequency. A warning('clk_csr' was unexpeted) is
>>> reported
>>> when runing 'make_dtbs_check' because the clk_csr property
>>> has been not documented in the binding file.
>>>
>>
>> You did not describe the case, but apparently this came with
>> 81311c03ab4d ("net: ethernet: stmmac: add management of clk_csr
>> property") which never brought the bindings change.
>>
>> Therefore the property was never part of bindings documentation and
>> bringing them via driver is not the correct process. It bypasses the
>> review and such bypass cannot be an argument to bring the property to
>> bindings. It's not how new properties can be added.
>>
>> Therefore I don't agree. Please make it a property matching bindings,
>> so
>> vendor prefix, no underscores in node names.
>>
>> Driver and DTS need updates.
>>
> We will rename the property 'clk_csr' as 'snps,clk-csr' and update DTS
> & driver to align with the new name in next versions patches.

Thanks!

Best regards,
Krzysztof

