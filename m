Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAA66B045E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCHKbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjCHKbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:31:02 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E648FB952E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:30:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u9so63812781edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678271427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HkSL1BKs8qQuXssQmsoT72r/3xC/fwXVehYN3PusxSU=;
        b=evWB+d0e1Uquo8dr4r1VC6OHOejb7gAMsxkMIxPvgiJPtCZT5Gxmr2GExahMWkdOyx
         4ZZIOntnqQ19JU7niWQbOtTTV2rXyV/uin4GHBcSD7HdbiHT1jgzk2g3yXllsRbZ2PMe
         d7njlA4+DBtaN+Vtz4VeXb/fg9BA51+j2UhSFTK3rNKawVvkrYAxIP3a4v0Jf+1VE0uT
         +mh5L+6CGTwEIMtSrxGe1X9Fc/jZ9r8GjxGzVs4/O6vH28wjU+xxU+84H4FDT83P2bQ8
         RuSv15+h8llbX9Xscl0vCD/xInzDWptKuzcY/c2BzuuPMoXG36L5f5ydGxoETsygekxK
         DSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HkSL1BKs8qQuXssQmsoT72r/3xC/fwXVehYN3PusxSU=;
        b=c2K5Wr+zP01DjMLDMD4+zXRqBqUkug5oOxdRzifukUOquWNI7pwYa9LWpfiAL/UvcZ
         4UPNJbbwdbbgV71T/d9wu9kiBZqMFbk3oOuNHLO0R1RzJkhMtRPM6Een9gQdZkgro58j
         dz9iwLOY5ZKtBvgOpKa2JniqH6wYAIpy+OvmucWdLGVcVWioufPDaUrnfJTd7NUMx4tp
         jIkLK9GkzRCj3SxAcfYvfYrKo3ynoaNZVHEVChghFkGHbzgVJgjJ1Vw2mUexkl8voaad
         B7ls5bHxz0GrIWw0jkO6KR8dlVB0RqWUbPa+Mk9WEGIHuwkn3ky6pPx3W2Ywbhl9cT/M
         fy5w==
X-Gm-Message-State: AO0yUKXw0Tj8/H8iURhq+2pbEZBhU8frK2YXBURgRNxgZNb36EHC0CJY
        Ke7Hap3LCl/f7H8PuJy/75NRpw==
X-Google-Smtp-Source: AK7set/koDWIG8PwDaLODojT1e2g5Y13QtDF0LLxtW/sFTuh+svu9dDc9LTmiiyY6ii+2GE5BgIEpw==
X-Received: by 2002:a17:907:a054:b0:884:ab29:bd0b with SMTP id gz20-20020a170907a05400b00884ab29bd0bmr15871656ejc.69.1678271427688;
        Wed, 08 Mar 2023 02:30:27 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id qw15-20020a170906fcaf00b008d57e796dcbsm7259615ejb.25.2023.03.08.02.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:30:27 -0800 (PST)
Message-ID: <4dba4db2-60da-02fe-6237-c5893fdf2e14@linaro.org>
Date:   Wed, 8 Mar 2023 11:30:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/6] dt-bindings: memory-controllers: mediatek,smi-larb:
 add mt8365
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20230207-iommu-support-v1-0-4f0c81fd52c1@baylibre.com>
 <20230207-iommu-support-v1-2-4f0c81fd52c1@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207-iommu-support-v1-2-4f0c81fd52c1@baylibre.com>
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

On 07/03/2023 14:46, Alexandre Mergnat wrote:
> Add binding description for mediatek,mt8365-smi-larb
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml     | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> index 5f4ac3609887..aee7f6cf1300 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> @@ -34,6 +34,10 @@ properties:
>            - const: mediatek,mt7623-smi-larb
>            - const: mediatek,mt2701-smi-larb
>  
> +      - items:
> +          - const: mediatek,mt8365-smi-larb
> +          - const: mediatek,mt8186-smi-larb

You need to fix the allOf:if. It expects single item, so you need to add
contains like for mt2701.

Best regards,
Krzysztof

