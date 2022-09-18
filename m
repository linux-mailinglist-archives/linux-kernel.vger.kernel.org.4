Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6094A5BBD4D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiIRKA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIRJ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:59:43 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FF195B9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:59:41 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id p5so30612293ljc.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3ca7URV85yKrxkToGpu5yTV2JozZM+SddjYQgSu2cPE=;
        b=NOcdK9y/IjxvLB4AlRNbhchnxrCLfR6JPe46yDdIinRSWhtPe2DIGR+jViOuIdF9JM
         7Y82F9iTQixXrvZE1Gb8a3LYZMV2kSA76NMRrQRrdgR9CtYdHDv09+Z9FHoekSHSshHl
         V+0hh/FwUDRiuV/pCrfPWXWrxOxScvQj4+ACgX4p1+VmJCtM3Pf7QdVcC9uDf196BYld
         SvW9UxigPwEKACj833dwq8FgRAPr8ieQKqnL3dteFivX4taQIGE8vTNniNKK5pWKUd/0
         Z30zxc6cPQCdAgsZKNL+6X4ZQB1ko9AxFL4CbZ6pn2KQNRmvpNOPqmTZlK2eDTPQBcTz
         Zk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3ca7URV85yKrxkToGpu5yTV2JozZM+SddjYQgSu2cPE=;
        b=ShMbufgdkdNx8TF8G/955h6YvL+owp61EA0lNXnkfw3sLTYILabZ69w9U2Dao2Mam0
         EbPB4uYspMxQmiiORPPWvmTy2B31TBGk9wCiwjEsK3hTi9fm2HN4Vh86jZbDSByWLmc9
         UzJU/5qFtLQDAEBJc2GZrNqGpNVibAgx0xZQCbyR+hiDYeWGDTZ7Sd8JkdO2wnzxIbLx
         ao+cQvwDu7MGcAkRDu3uc9YE3ULkJupT7RAOP3hkQdMojdDsiuuWOZVWHEAGOX9J5CsE
         EzqRsaSCO2cbXHGE3WnJN6HXCNPmnkffeE+Or2D7z7wkMy7MGvHQl/57P0XctKca+P1H
         3ZhQ==
X-Gm-Message-State: ACrzQf0Bys9RNCx+x9YN6TPMuLXvcXVHcyE2hYhELvcV3KfPBAPgRRXC
        CxiJaK1viynHvo155t1CVGSJ9Q==
X-Google-Smtp-Source: AMsMyM6wA7xiTfhm8VgutQ4QQLmSyc5iFV5KfVuxKLS87itQMc+B2x5hO48lsJyXLMZ9mMrxMnGLAQ==
X-Received: by 2002:a2e:bf23:0:b0:26c:83e:b4d3 with SMTP id c35-20020a2ebf23000000b0026c083eb4d3mr3666235ljr.282.1663495179307;
        Sun, 18 Sep 2022 02:59:39 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id du7-20020a056512298700b00498f67cbfa9sm4580438lfb.22.2022.09.18.02.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:59:38 -0700 (PDT)
Message-ID: <e88739bc-b799-bb5f-cd5d-73e9e689cbba@linaro.org>
Date:   Sun, 18 Sep 2022 10:59:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH RESEND v3 2/9] dt-bindings: mediatek: Add gamma compatible
 for mt8195
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "zheng-yan.chen" <zheng-yan.chen@mediatek.com>
References: <20220912013006.27541-1-jason-jh.lin@mediatek.com>
 <20220912013006.27541-3-jason-jh.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220912013006.27541-3-jason-jh.lin@mediatek.com>
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

On 12/09/2022 02:29, Jason-JH.Lin wrote:
> From: "zheng-yan.chen" <zheng-yan.chen@mediatek.com>
> 
> mt8195 uses 10bit-to-12bit gamma-LUT, which is not compatible with
> current 9bit-to-10bit gamma-LUT.
> 
> This patch thus add constant compatible for mt8195, which means that
> mt8195 should only use specified mt8195 gamma driver data.
> 
> Also, delete related compatible from enum, to ensure that
> mt8195 will not accidentally get others' gamma driver data and thus
> cause fatal error.
> 
> Signed-off-by: zheng-yan.chen <zheng-yan.chen@mediatek.com>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
