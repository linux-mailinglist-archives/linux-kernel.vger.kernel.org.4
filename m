Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198EE6736E2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjASLbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjASLbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:31:22 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4101F71F1C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:31:21 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso1020070wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3ZTBN7fSAUMaz82Hi5VrNDhCAvZbbtMflPWHkxeOik=;
        b=I5NVKVgNc/iUIM7MlSLIA10YiTh38S3mcLJZhJgNyV9cwuvOhWeOZ6byochkq0BsRQ
         Ojt5GbMuTei6PzdYImxqg5P/zrCEBthS9cJTsYEBNJq30cj6XiBYL+1waaTYopUgxjsV
         4JscuBdazeTxyZRPwFUKuHdl6pVWl1iabaFi00t7Pzpnz2UxVsissYoispNbQIokY7cp
         GBWl+AQ/hE6vD//8uqGPyKFfEaHiG/k2vMhb4Fsaz3v2KyrKP/nINlAOGKfnkylTX5TI
         CQAh/Vh+uHXwX1Ogf7+PWNYTVC6jEJdFFUg3Ul3leW/RX++dH1dvuqGzywnr5fLdGbF/
         6DTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3ZTBN7fSAUMaz82Hi5VrNDhCAvZbbtMflPWHkxeOik=;
        b=Jk6iUTq8Tcxt5Sb2wzkfplg2oqn6KQj8b83dTylO89xBe/beNlfncL3CC0BS3RFrYd
         3YjC68JB/9pHkrHyF/kStPzgaeTOP1uBM1MP86WCPfke1bL3bHl5uHUpnpuqmj4V7Ubc
         jmQFpBsBY9Xft7pgWh+tdhylsnmKcLuTH497xc9RLofdI0sFVfWhwZNs3FAGEikAayv/
         uct/D81AcEl9ISpPtpIVuUG+iEm798cANKeYpjHgR/7ApAyIB82X160REoFofDHbmVHZ
         n3gWQsT9jMpVyGh3bjTLDaaT1OCwDV0yxawfMOWjbe7oeKOGVE3MHfGnatkklXneTMBH
         KFwA==
X-Gm-Message-State: AFqh2kqdU/A/YBEcIG7o8pTZsvWO7qf9wTaDcsApQKloNeW5RNdXuiES
        KKAVCg0vU29WIJ3cBSpzPLz11Q==
X-Google-Smtp-Source: AMrXdXtHDyJv+UOpa8CElUCnrximtQLkqWyP13CQ/drVDl83UuE5R5zbbFV2+zH4/wZuH5Us1si6pg==
X-Received: by 2002:a05:600c:1e1f:b0:3db:2063:425d with SMTP id ay31-20020a05600c1e1f00b003db2063425dmr1802624wmb.2.1674127879761;
        Thu, 19 Jan 2023 03:31:19 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d58ce000000b002879c013b8asm33350308wrf.42.2023.01.19.03.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 03:31:19 -0800 (PST)
Message-ID: <0f3f231f-feb2-74b1-c3c4-35e481ca2af9@linaro.org>
Date:   Thu, 19 Jan 2023 12:31:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v7 1/3] dt-bindings: mfd: x-powers,axp152: Document the
 AXP313a variant
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Martin Botka <martin.botka1@gmail.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230118210319.464371-1-martin.botka@somainline.org>
 <20230118210319.464371-2-martin.botka@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118210319.464371-2-martin.botka@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 22:03, Martin Botka wrote:
> The X-Powers AXP313a is a PMIC used on some devices with the Allwinner
> H616 or H313 SoC.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

