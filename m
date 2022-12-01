Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFF563F33F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiLAO5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiLAO5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:57:38 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C9D1089
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:57:34 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id c1so2871943lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6gDey1QcyUJtE0gdjIn+yYcI9Q8I3srect9H/M5C0+M=;
        b=xkF4CdSRbPtytSRO8iCSQTLhpsr/M1LQ9iHRANnnu71nvlD0FIRoYiaPiP6h0oImsW
         3Zrd4M4WjopjOo6dPN0JkeCc1SIxZqOA/67QiTd3jkZGLwr9FjUCBKjtlANhFnT0hmlY
         zjO/M/t4PHoiMDqDP3e4ZtC6Uh6EQ7Ji7/3wOmfuS5reAYnVh4OU4rsVVSJWVeGfX1Be
         PaWcLnhPgcySuWcJqidr0xM+wavkHhER6LYi15egsu2rfYYZfgaeBrXa2YKc5I9Ei2f5
         ziC08FSuEHCq1nxZnZiY9RsXfGNXt991k2uRDs/bSwjabNpyBuSaWTq+ev8Mrn24Fazw
         FgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gDey1QcyUJtE0gdjIn+yYcI9Q8I3srect9H/M5C0+M=;
        b=orjbQWXMJAJhM8YFdssgXvur6+wuAUmanc3KKOGnp5wXYnpmAh7nl7Ytf6YZ74qb5J
         aGqEWAqCdWXxSrtpzpyeSNsocDU33QdV17unG1uE9t22lO2+ne9QTygTrhOuSxFp8WBF
         ON3nWlfw+d2uSFkEl5EDGwsocCealRD4NVoveJyLJ4DNBnKveau82Vj1XAHrrjZwyFAo
         suVsJ062LaqQNSes4sFkrTh3hAEp/tSMCIeRl/UIlxfIywznYHmTFLJa9XfkNd1A7pfB
         O0S7Vo8IlZijWcQJeF6nlm1CPYLo2T1uuvXyUhoLedRw3tbVsd9PnNUCWMJRAi317nZI
         wPTg==
X-Gm-Message-State: ANoB5plpDe4p08xdsCHvSfM43XYXGxnRxAbReabWZFBil/OWE7K5KQJ0
        E/s+D1IOhK4LEcGrW8TrlseQfg==
X-Google-Smtp-Source: AA0mqf79xWBWw5nVZ8PmmAX+p2VT6QA4I6tMDRpFZ8gxkPdes8JPwZNUZYPGSj/c335E68jPA24ZpA==
X-Received: by 2002:a05:6512:b17:b0:4b4:b90a:69a1 with SMTP id w23-20020a0565120b1700b004b4b90a69a1mr22139089lfu.76.1669906653202;
        Thu, 01 Dec 2022 06:57:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q15-20020a2e914f000000b0027706d22878sm406024ljg.94.2022.12.01.06.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 06:57:32 -0800 (PST)
Message-ID: <3f824d80-fb5a-c8af-67c6-7a9be6ca7e66@linaro.org>
Date:   Thu, 1 Dec 2022 15:57:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 1/3] media: dt-bindings: media: mediatek: Rename child
 node names for decoder
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yunfei.dong@mediatek.com
References: <20221128143832.25584-1-allen-kh.cheng@mediatek.com>
 <20221128143832.25584-2-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128143832.25584-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 15:38, Allen-KH Cheng wrote:
> In order to make the names of the child nodes more generic, we rename
> "vcodec-lat" and "vcodec-core" to "video-codec" for decoder in
> patternProperties and example.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../media/mediatek,vcodec-subdev-decoder.yaml | 60 ++-----------------
>  1 file changed, 4 insertions(+), 56 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

