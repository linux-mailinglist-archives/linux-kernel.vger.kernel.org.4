Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939E6606597
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJTQTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiJTQTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:19:36 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE2A2AC70
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:19:35 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id i12so3681qvs.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JcnPN6pOymsF6TuFZ7F3+kHPVPEANExbnJVMCV93EB8=;
        b=wtMyoidNDlc6CXkOIF48tG23OkrzjobXGaBGAeQxYLoX+/YrniIr8r8CuA4naE0ggr
         egJI4JwS3HR/Z1zTs8DGA2jpvUXFJ3Pa3Gn0ScUdUBakgCjcAQohQ6iI3f5C2nnZLGzn
         vH6TgDpcxcnqfFceAI+pdV2U4VDRbWogolEQY+R6tOEM9Imx7fBeRZjLd94CMcvNnkwJ
         /Blt2ZZd5flcx11b+MFkYd/vCewUXmTqpA9NGS6/iJYKySlX27cyst93kh8GxViPaQBP
         V4+VD4aw6rnQw+q8IXonQnSKgEFTjkTm71OJ1n9DMGWaHZPlGoMeXVrVuQE9Y80TR+g8
         j4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcnPN6pOymsF6TuFZ7F3+kHPVPEANExbnJVMCV93EB8=;
        b=72AgYCXpG8zdmuutm5Tn5JATVKbZkXMdtfP/6DSLhgHB3Qrh9Z0YqxH+yFiBNUVGcL
         hTm8hz7O4RdGezr6rIN+QzRrN+IR+zFxzxmMct/rejKz5GNG5hLwaedBWoS6aKjfBHjT
         oTcpmskyjcCyunN620QADzlvmbcm2NkmT/KPR9wX01Ut4GUZSHdBE9NGz2nd41Wd7VWR
         Qby/iLDh7+qnvbq8afCnYoKYkcucUCTsztI676pIHqbjxYz0MJ3vTm/4PcsH0zD/kpSq
         NnpXxBJopYouNlS+XxCUzMFG8FgNfEbioEAIZEDr3HM4XftU3cW2Ma72e0uOR/Ie+x6F
         S5ig==
X-Gm-Message-State: ACrzQf056aKHahCqv7kC4PY2j7QyKdSHXxMnXdL4WIs/z6sK7RXPIzbJ
        3GoY3HhEKPTtiuSlYWtVgIQB9A==
X-Google-Smtp-Source: AMsMyM6mw4at8h/UUnFkUKaYGcNXsz9P2DbQdh3eDc++FhkVB22bdeyzYFFEjleWs4HEZBCi4MI2bw==
X-Received: by 2002:a0c:e552:0:b0:4b1:86f0:89d5 with SMTP id n18-20020a0ce552000000b004b186f089d5mr11896504qvm.97.1666282774259;
        Thu, 20 Oct 2022 09:19:34 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id r17-20020ac87951000000b0039cb9ef50b5sm6277793qtt.26.2022.10.20.09.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 09:19:33 -0700 (PDT)
Message-ID: <972de6c1-c844-7581-efed-cb6c4d826c33@linaro.org>
Date:   Thu, 20 Oct 2022 12:19:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/3] dt-bindings: soc: mediatek: pwrap: add MT8365 SoC
 bindings
Content-Language: en-US
To:     fchiby@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Sen Chu <sen.chu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221020130957.25197-1-fchiby@baylibre.com>
 <20221020130957.25197-2-fchiby@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221020130957.25197-2-fchiby@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 09:09, fchiby@baylibre.com wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add pwrap binding documentation for
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>

Ah, and one more issue - your SoB is missing in all patches.

Best regards,
Krzysztof

