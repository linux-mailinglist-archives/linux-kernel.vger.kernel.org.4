Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324137255BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbjFGHcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbjFGHb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:31:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634DC4498
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:27:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5147f7d045bso727029a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 00:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686122865; x=1688714865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrbBiasFytk1Nckd/DEhj6S74ay42QVWNjVsOI0QOaU=;
        b=ga5a6+ukcKvhCnCPtrFzfCApYNa14klTsW9G8sLRCTHvPthZP3P8YCyGxcTksH8lzG
         53OYquxkw+acOpZHWdq2fcXeAWcMYhPtbGx6X9PcRFYydCAPZ8RfjD8GTPhfqtXY136+
         PRISb+AEWJEpljPJo9v+j9597drXfOhcuCBtHQPSNL5YuuBMVrKB7Oa+OTodJd8/G7TY
         YDCpvHD6XruCv4jeMkhp1Hwc+H8RxYRGNZhMwXl+ivy/9fD5DfzvE5Y6VRsNF1M4Vfc+
         G5vFnA9uObVtDCBhvrTqt57LmtX42e+eO98EGw3Il8U2GqqzkNd/ZuhyvV509Fre0Z8f
         RivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686122865; x=1688714865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrbBiasFytk1Nckd/DEhj6S74ay42QVWNjVsOI0QOaU=;
        b=I+uzEFsn0MvegAR7RzxWDiklU2MIRhRWSn6u+riSPrESoixApdDI5IBHuZAYcc0TU8
         S3L7wNGyb8T6lNrrMSDwmL65DMXy6AAMM/X1hp41lkSKjQnt4QO4wnw65WqAQvTdi3qf
         aMsfSEbOgYQgMnX7QvsVInfTDwUp3LHC9d7usod8oAp/aywYhiblvSttPxiuE9j+ceTu
         gKr5UPpR8D7yK87Qq2uzvBnoOFW6GChq4HvhDPl3NYgGfGRMGgPEbvYHfG/NgAaRyobK
         jnAOfax/gLn0uQNvppg3o0p4gpQdCRACE2SGygaN58dp2JhXNec7fFhp9qxv0Za+JXJ6
         ZARg==
X-Gm-Message-State: AC+VfDwuLO0nV7J7ll5iye4DvG/2zH1cIMBoY8oYxAtNCSlWSuQbCX4p
        7SsOg3DjoeUEeRRzoXoNBUvcYw==
X-Google-Smtp-Source: ACHHUZ4HJUTQNoMCxDs0ERIn2tW+n96xfANYG3S01OWKfCvbG1Af6Z1YzmJVLqK8u+vpuyUSG8iYTg==
X-Received: by 2002:aa7:d54e:0:b0:50b:c77e:b071 with SMTP id u14-20020aa7d54e000000b0050bc77eb071mr4135216edr.18.1686122864819;
        Wed, 07 Jun 2023 00:27:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p20-20020a056402075400b00514c4350243sm5748879edy.56.2023.06.07.00.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 00:27:44 -0700 (PDT)
Message-ID: <93eb3e7d-eff5-b040-5290-2de13699ed95@linaro.org>
Date:   Wed, 7 Jun 2023 09:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 2/6] dt-bindings: reset: mt8188: Add reset control bits
 for VDOSYS1
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Fei Shao <fshao@google.com>
References: <20230607061121.6732-1-shawn.sung@mediatek.com>
 <20230607061121.6732-3-shawn.sung@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607061121.6732-3-shawn.sung@mediatek.com>
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

On 07/06/2023 08:11, Hsiao Chien Sung wrote:
> Add reset control bits for  MT8188 VDOSYS1.

Double space -> one space.

> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8188-resets.h | 12 ++++++++++++

This should be squashed with patch adding compatible.


>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mt8188-resets.h b/include/dt-bindings/reset/mt8188-resets.h
> index 377cdfda82a9..439a9a25ca19 100644
> --- a/include/dt-bindings/reset/mt8188-resets.h
> +++ b/include/dt-bindings/reset/mt8188-resets.h
> @@ -33,4 +33,16 @@
> 
>  #define MT8188_TOPRGU_SW_RST_NUM               24
> 
> +/* VDOSYS1 */
> +#define MT8188_VDO1_RST_MERGE0_DL_ASYNC         9

Indices start from 0.

> +#define MT8188_VDO1_RST_MERGE1_DL_ASYNC         10
> +#define MT8188_VDO1_RST_MERGE2_DL_ASYNC         11
> +#define MT8188_VDO1_RST_MERGE3_DL_ASYNC         32

... and are continuous.

Commit explains here nothing that it is for existing reset, so you got
such review.

Best regards,
Krzysztof

