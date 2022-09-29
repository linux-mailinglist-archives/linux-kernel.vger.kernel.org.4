Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171F75EF58B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiI2MhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiI2MhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:37:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA14BEBD54;
        Thu, 29 Sep 2022 05:37:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id cc5so1981388wrb.6;
        Thu, 29 Sep 2022 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6Wu49/9oCmVJqWjYHFvdZgUkugLJmnwyVSJYmbaTsak=;
        b=h6X2gpN/qqak2l9MaA5Wwjk1FX/cZ65M4lTsmyeyL4pd7ptt3a38nLWeXPCbqHOTdo
         113Mfcy8wqBL7LDYV9O3izk/Z+b3W0NOglKRBIoihov03gx/9ACd9BD2DiLeHKNjfj4o
         pPLnAkAczGoHjZ4BUHInuINSAxarDQ0l/1M2CTHzqJ8TSTl6kBlbLsBaYRM9hsqryjJ+
         78Z+mzgrL/xz5csMSrK0MVg1eRH2EfxHbl4QZOgxFZlP6f0yhhnFk/vYCHUHaO0uB362
         C7HV9n5u2LZAgfQsnlPQG0xBC5wxPk3mJ0cmA2dKRM7dHKBtxkFGj/kiCVM5Obl4UTG2
         7ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6Wu49/9oCmVJqWjYHFvdZgUkugLJmnwyVSJYmbaTsak=;
        b=Stycl1gQExWV3NSVJNi1jmLi5EMfek6wqyM0AI2lVDxAnXX6GrKgTk7id2Jo+g+5w/
         xiZ7RbI57+Q93eFAWmIGUqIvnbC+A0nv6eemgPvYHVDRbzpBep8zZ1nchnWwhxu+WLdx
         ASRS3/QJ8FvCw3Wq2LVnNeaB7y1TqHwSZzQ9/oJK2XNifU5I2Z0z5iOoQZ3GQEZ8KpXJ
         tN2dyNf/rxC9VZ3lrX92YF8YIXfASLNBFob/UjzTZ6F3nj6X1u20QlnvcEFJLfH4pdbC
         Ib0gB54wwXD04KySUATKmXiyIvQf3ccywf8MC/eO3vVKjANTdV5arEekaXRVTeAY8Aun
         8jhQ==
X-Gm-Message-State: ACrzQf2hG8I5xLH8mVJVZQsDfdgD1KrA3gViP2/jzmsVQE9tS/BukcAN
        bNnl/J1xjHyUAmc7wIQyqf+b4pS9w8Y=
X-Google-Smtp-Source: AMsMyM6npaeOsc2MEuSPEwbp4GF99lIRn/lRvFdzFxWdNs9dbc2dPgyYlu1ChjODxsT78YunWammtQ==
X-Received: by 2002:a5d:59a5:0:b0:22b:52:1c9f with SMTP id p5-20020a5d59a5000000b0022b00521c9fmr2179232wrr.576.1664455035335;
        Thu, 29 Sep 2022 05:37:15 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id bi16-20020a05600c3d9000b003b4de550e34sm4097629wmb.40.2022.09.29.05.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 05:37:13 -0700 (PDT)
Message-ID: <5b9e5ac9-b05b-b039-4aac-387b9f24a73d@gmail.com>
Date:   Thu, 29 Sep 2022 14:37:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH,v2] dt-bindings: pwm: Add compatible for Mediatek MT8188
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jitao.shi@mediatek.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@list.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1663915394-30091-1-git-send-email-xinlei.lee@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <1663915394-30091-1-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/09/2022 08:43, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of pwm for MediaTek MT8188 SoC.
> 
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> index e4fe2d1..2dd93e8 100644
> --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> @@ -27,6 +27,7 @@ properties:
>         - items:
>             - enum:
>                 - mediatek,mt8186-disp-pwm
> +              - mediatek,mt8188-disp-pwm
>                 - mediatek,mt8192-disp-pwm
>                 - mediatek,mt8195-disp-pwm
>             - const: mediatek,mt8183-disp-pwm
