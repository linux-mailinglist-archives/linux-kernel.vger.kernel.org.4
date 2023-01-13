Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D093E66967D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbjAMMI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbjAMMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:07:38 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59A1FE0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:59:52 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mp20so5186067ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lM60jB5CeQGfmEnmDWStP3rhRDC4AugryFBW67wjBxI=;
        b=XaEEC5PZdtcHMQ7EV4jsUpXyAKWlZi1l4EUZI2/t0KdEhJEZf2pRJWdFEIkdkcDAWS
         hNEV7yYATrN8TE65cpXj9S2cI4rY3lprGDk7RPsbQOJksOYrf1rgDlUaMEFheiLIi4OD
         gWtrHp+p+t2y56+Yea4IE2kMNDXtC70yZeClRBMZlYzJtYebnmDQ4bQhCF1b4G2wsRz/
         G380H320AapWZ74/58MqNsqQ+fk8UBx12uOW6598WiU94HbxImN/oMGdjBUgiOBt8ayG
         uhtGX2OEQrV7eSCTy1NKbMMxVouHv2gLlXeJpaDffQ+hpsNJGXloKDm3l4SNRRp/uCGE
         IvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lM60jB5CeQGfmEnmDWStP3rhRDC4AugryFBW67wjBxI=;
        b=TZKsxeV6xUuorf9F8mLdkfFApvRkhQV3lcapIBjTSXyLo79EqtpeiOZ9FHj1sQdCT+
         kxn5+BFMJmK6BzK29NULRkHs0TXUeh7iemnUeA315n08lWG3kA+U5x12SVVEK+8iOFf1
         LDlF3jQ3gwAAf0wed/jdOZLErfK5H0ss6ADnTHlU6/lMR2nnpUgkpr3JN3seGnL5j2U+
         ly/AiwgIgY8U2ZmW7O3qVbdgSlB94nhgEH6Rpg5gyFv/QclCf3WQq0ghnS7+4jXb5FCd
         jkjqSrpLPKzcyLwfWYNNbec4QDWyyULvAwsEPyshGQFqomv5eAD5BGJVVppZj1e5BCgq
         +0Bw==
X-Gm-Message-State: AFqh2ko6r48lNpgF3rsIaUz+XDckWUMID2R0EXJQ1cncougF/G4qejMc
        TLpuCdaHvN/CwTyZI6iGChZBFQ==
X-Google-Smtp-Source: AMrXdXvHFuBXHMVk0hBzhEM99tOU+VIvQ/ZKfYPQVI98WQOjRvcco+YhoSpAcYKvIxwXWJifbqXL3g==
X-Received: by 2002:a17:906:99d1:b0:7c1:12ef:bf52 with SMTP id s17-20020a17090699d100b007c112efbf52mr63943919ejn.3.1673611191261;
        Fri, 13 Jan 2023 03:59:51 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id kr12-20020a1709079a0c00b0084d44553af9sm6417588ejc.215.2023.01.13.03.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 03:59:50 -0800 (PST)
Message-ID: <d16ed246-86b3-7837-845d-ba33dd61b482@linaro.org>
Date:   Fri, 13 Jan 2023 12:59:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 02/10] dt-bindings: arm: mediatek: mmsys: Add support
 for MT8195 VPPSYS
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230113054304.21841-1-moudy.ho@mediatek.com>
 <20230113054304.21841-3-moudy.ho@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113054304.21841-3-moudy.ho@mediatek.com>
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

On 13/01/2023 06:42, Moudy Ho wrote:
> For MT8195, VPPSYS0 and VPPSYS1 are 2 display pipes with
> hardware differences in power domains, clocks and subsystem counts,
> which should be determined by compatible names.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 84de12709323..27d2631d43d3 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -34,6 +34,8 @@ properties:
>                - mediatek,mt8188-vdosys0
>                - mediatek,mt8192-mmsys
>                - mediatek,mt8365-mmsys
> +              - mediatek,mt8195-vppsys0
> +              - mediatek,mt8195-vppsys1

That's broken order and I did not ack something like this. What's
happening with these patches?

Best regards,
Krzysztof

