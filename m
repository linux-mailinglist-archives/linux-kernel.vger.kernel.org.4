Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76616E20D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDNKbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjDNKbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:31:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E8F55AB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:31:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94a9606518cso293264866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681468300; x=1684060300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1720p3siIfGtX4Ig+Z8rM9FJYarwB+pzhTTSt4MACL8=;
        b=P4W8iZ2w1Gh7w85Jw+AojjPgK8APjJ7qSz1fTCyoPkCa8pfiyXaWxx90phdGQQOHuu
         bPac1TD/9gNZKaxRbz72Wunu/xHXHKFL4Cjd+Kbo52qxYaxOIcxUROS9Zy3LzFzKcr5I
         vrNiZB9B8jI3QK3Thuhu/5A0m1jUs5B6xfgGgfbTJB7LU72BfxDmi6sw0t1l9pGk3YQp
         jJ05crgXl9OPB3wfvTnJ0+FiJaAaNf5r2bwoioghBIUqWem/txWIR74BMuNN6nnS29eV
         FGQJ/+bVKmWcbBYbm982gzUtSJCvXphxxoWHiJskFaVd/XvHtsbTh68neo11aAgkcmFw
         tzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681468300; x=1684060300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1720p3siIfGtX4Ig+Z8rM9FJYarwB+pzhTTSt4MACL8=;
        b=FClmi+d9DcX2nf6penDWuAGxtdijTJATU7MlY2+/moPQddtgnNwNAJq41m3EivgMhW
         HqY+kfOEpJBx16QcsRmzfxwvMLi/AzCidAGtO2Ek+a2xM45Z6FAXc4X0UeraIKEd55o6
         Ks2iVUuo1q8Q1Kqht7CC27Ku8izegrVkOPeVRLA0FhKUGXH6L2OcKGE3XcA3j5+iN/ps
         Ar5FlcKk8ioGO21IiOGjQjudx1jPuJPWR7K8b7EQe9Teb2f1+lagyPappi9Nq3cwA3Kx
         Q1k2v+dths599IIeQvsCCd2dom1MQXlUt0i21QEc7zZy/iXI840je0dpeq9fRAwDoBBL
         6yaA==
X-Gm-Message-State: AAQBX9dlhKSHAsy1Mr3nkTF8dw6LR69Ka7SMR9sqhNSlYc7O/KIjh0KC
        UPwTvTtPeLwWM6mka20g+v+ehQ==
X-Google-Smtp-Source: AKy350ZIjMP6TMSw+k6xUakCFEXrjNxzNtDnPVbQjujlC0FIdzUT/htNABiisXWE6rAig7qQ68+/Ig==
X-Received: by 2002:aa7:d947:0:b0:501:cf67:97f3 with SMTP id l7-20020aa7d947000000b00501cf6797f3mr5612068eds.25.1681468299842;
        Fri, 14 Apr 2023 03:31:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:40b9:8c57:b112:651d? ([2a02:810d:15c0:828:40b9:8c57:b112:651d])
        by smtp.gmail.com with ESMTPSA id d25-20020a05640208d900b004fa99a22c3bsm1949428edz.61.2023.04.14.03.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 03:31:39 -0700 (PDT)
Message-ID: <eea67985-261f-6ce0-031e-2acf0e682375@linaro.org>
Date:   Fri, 14 Apr 2023 12:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/27] dt-bindings: pwm: Add compatible for MediaTek
 MT6795
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's display PWM
> block: this is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

