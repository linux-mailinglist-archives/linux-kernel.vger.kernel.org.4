Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F237864EA21
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiLPLTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLPLT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:19:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F27711829;
        Fri, 16 Dec 2022 03:19:26 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h7so2159930wrs.6;
        Fri, 16 Dec 2022 03:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=My8aHx62G4PVWoCSRnX4jTy0TXnCzM6wwrdyv/Uk+ro=;
        b=CoGWAaBk3rrs7FoMpj4BRthumWNKxG7U8nWWbtuPsg3sfMIRlCqQJTAUoIKmT9slxs
         ameuFgnccTJBYodXKtMeBKw4s+YpeCw09yTcgJcDW+8Z/OXBJApr84gNZPrLnJGWawEc
         sclV1oAAUh7m5u0X6WTVsCMxKFvKW1Yivlgkn77yCqanvrQDn0NH+D9Sl9nj3vwFCMVR
         SN2bbWBJBdM9OV+h0foPWfEtqx1FRddVnC/qwgTDfLbaowMBOJ0eO8djQyAqzzblCncO
         +NiU+pHpsdhfThAIuse7xTN4kWfSISoDaQIdMC6wMjLz8C8+k8JoDc1l+jbD46iKhos6
         0PZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=My8aHx62G4PVWoCSRnX4jTy0TXnCzM6wwrdyv/Uk+ro=;
        b=y/aWdkF//c9L2oWdL3VTiyPQlPKR1vRCGvK1xliz98AoRAYlPaOGQQuHBHkhHzJbLp
         sFl9toDSyB3nKbUjwUsHnRSFBJ8kV02GOVWbQEXft1ueepKD9/c6jsdbUAJ7goPp8oB4
         OjaiKG3DLbpMmH12O/aqp2EClFh1xGlACN8kiy61AhLFBSvDMTqKtAQdDjw9y/uheuBd
         jJTkjpWPWwEbnbuaDQkn8Poa60kEUyb0QMLM+mxxmRJA4nyuL85lOLuHO5+OT52QIDz+
         etl3pi5Oe13TUZJt8rQ2O7JOR0y/pva0Hf2clzUYvwnUX4tBDrnS9GO60dOJFdk3GH9d
         e+Ag==
X-Gm-Message-State: ANoB5pntsWWUM1+RSvroMuDZ1p3G+biw3QzZKNSjg5rSZJvMhqJohTI5
        +HRqEEAemLwNpZPMRwrb54A=
X-Google-Smtp-Source: AA0mqf6FKkSeIrjm/bY5RymEDP7r7g2Cp/xUOFjN0g7joFhg3HnQcgDfVnSp98htIaDAF9Gt9VZ/jw==
X-Received: by 2002:adf:ea8f:0:b0:242:70f1:2134 with SMTP id s15-20020adfea8f000000b0024270f12134mr28573974wrm.60.1671189566058;
        Fri, 16 Dec 2022 03:19:26 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d5387000000b00241e4bff85asm1965790wrv.100.2022.12.16.03.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:19:25 -0800 (PST)
Message-ID: <3c2eacc7-79d3-b961-a472-34938f1d88db@gmail.com>
Date:   Fri, 16 Dec 2022 12:19:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 2/7] dt-bindings: irq: mtk, sysirq: add support for
 mt8365
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
References: <20221213234346.2868828-1-bero@baylibre.com>
 <20221213234346.2868828-3-bero@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221213234346.2868828-3-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/12/2022 00:43, Bernhard Rosenkränzer wrote:
> Add binding documentation of mediatek,sysirq for mt8365 SoC.
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> index 84ced3f4179b9..3ffc60184e445 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> @@ -25,6 +25,7 @@ Required properties:
>   	"mediatek,mt6577-sysirq": for MT6577
>   	"mediatek,mt2712-sysirq", "mediatek,mt6577-sysirq": for MT2712
>   	"mediatek,mt2701-sysirq", "mediatek,mt6577-sysirq": for MT2701
> +	"mediatek,mt8365-sysirq", "mediatek,mt6577-sysirq": for MT8365
>   - interrupt-controller : Identifies the node as an interrupt controller
>   - #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
>   - reg: Physical base address of the intpol registers and length of memory
