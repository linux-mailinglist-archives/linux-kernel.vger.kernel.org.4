Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555645BF8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiIUIWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIUIWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:22:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A3D5F5E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:22:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a8so7876538lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=sB76DvFVE7IoDtHgGLfADV4D3rsHaGzCUZQyyMAbRJ4=;
        b=I+4l9Es944m1QBpXCsvmQvEV/hnSjHG1mHw/gswSIsmekL9qx5vJ/D9XjVL/iLlZ6G
         qQvOi/U/5S8MSX0fcRj7MJE9Ue01fVMisGHnd1sFm/RiNNQPJQA+gABA4WOOYpQvZw00
         Al6X3eahOdURAtG18Mw9h0fqBRTemBIlQUe3jzogV+oYXhHwYlbLpMiy2Z7mAK+HCSA4
         rDueUD9b4ahZN/UmD6avo6cv6vWNVqen1s9aGtZchNSbMd0wN9XZLwH9oNRu2DHSb1DB
         dqFfH7BjGjKtDr23fbGS08woQ2gbTmrZWcTJwjyagr15FVeEgQiQh3djkJj679cKr9tl
         nWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sB76DvFVE7IoDtHgGLfADV4D3rsHaGzCUZQyyMAbRJ4=;
        b=h1nwejL2naoIfUcDhl7i1dnbVYiG2QCDVtH+AAJ5rXQSlcx6aVoDVVk1k/U0JBv1Qw
         2DXyy54+GYSsv83p0wNc/8XChVGJofDUR4DHGhMryvJ/csMmIhtT2+s8qwAJGzr9TFi1
         IOTTMg9SzPUSod7JMU0ewW+a1A9MV99cPLx2zTANoFh1ZzQwXjKHUomu+yNvRl9UuT6+
         Czpnr7N4qMgNnsJ7OClNKWBe3z5gHl27VmkoD90iw9S/BZueies/ECYpCSLvMbThKeo2
         aE5mxProcQxAt1w6KrmmMg5bPbsidlUrkbeIb9JdMEj34JgrXlviZOXe52iqJAWEzZ7F
         JTLA==
X-Gm-Message-State: ACrzQf3ENPF8eCuuudzGfVZiG+smK3K/uS0likhBMN3Df6ylj3ZfaquT
        Huei4VHlnVzQHF5dZl77dLUeigbri/N86g==
X-Google-Smtp-Source: AMsMyM6JwwU18E3xHzfxTzTabWpYuZyhkSkwuHDOwJS7/6E0M0rElGOe+Kp6p6P+Lxy5jlM9m+G1FQ==
X-Received: by 2002:a05:6512:32c6:b0:49b:9680:5a78 with SMTP id f6-20020a05651232c600b0049b96805a78mr10053136lfg.397.1663748532701;
        Wed, 21 Sep 2022 01:22:12 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b0049f9c732858sm325068lfg.254.2022.09.21.01.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 01:22:11 -0700 (PDT)
Message-ID: <82b246bc-86c5-2395-44a3-535d4f022dcc@linaro.org>
Date:   Wed, 21 Sep 2022 10:22:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/2] dt-bindings: net: mediatek-dwmac: add support for
 mt8188
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
        linux-mediatek@lists.infradead.org
References: <20220921070721.19516-1-jianguo.zhang@mediatek.com>
 <20220921070721.19516-2-jianguo.zhang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921070721.19516-2-jianguo.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 09:07, Jianguo Zhang wrote:
> Add binding document for the ethernet on mt8188
> 
> Signed-off-by: Jianguo Zhang <jianguo.zhang@mediatek.com>
> ---
>  .../devicetree/bindings/net/mediatek-dwmac.yaml        | 10 ++++++++--


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
