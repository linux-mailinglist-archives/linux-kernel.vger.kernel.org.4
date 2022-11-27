Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70FA639D3F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiK0VXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiK0VXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:23:13 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11809DF3B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:23:12 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s8so14636502lfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khJGEcAxyToyXETE8fU9rz9l1LFJBw/cIsJPkm/f/PU=;
        b=tLOxS5Ju0F/5+WAGQpUjWLEhmoDnhhu4trZ5hwg/h6q/sdO7f5BoEFQKt4NZbsUE/P
         s+IMrtCQA6vniP29VFQ613uyVWf4e2YSqN44zj5mseK4rAqXh9p7r9TaTrSn6dczDfll
         hHg4TohE1h9BekBlgAdO8SOPsTKbrLib7ydnXqrDNBGgFshx6mxojYyeo+odYq1AV2KO
         GDiOZ9HRb6vxcVhE0eTSgEJEkqRvReaFisfwASY1iEq/+rOU1gqgtQIuPj0gwVXCt97m
         y8Mov2PpnqdZvC58gBmf5NvhKHjo/EegpxWFVkzAI8xkAQbpmMclskHktdR2rKJgfDMv
         V/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khJGEcAxyToyXETE8fU9rz9l1LFJBw/cIsJPkm/f/PU=;
        b=uNY/ZucmMMGlopSoWw11Ce5v/BMIF05RpQD1/LETnym2V4MvZ7f1oanJDcrnT1/z3L
         z96aHGArHGninr8sJ03kyLx0KIJE5Wfqga2vTR1gPK2BFxOUy9H9aI0IVEultWSqKYYo
         q9NvScBKSqJmAmbY1i55iT6jT0nchxT5jaoqOvkwvc+t/TrVrfvgsWIlPLsWNVlkN4NG
         WnpPFYuzv2G/ekEad4z18km8TirOXUmvywXiKnRXFXzuWRL1TxT7P1iZID+w2snMc4Ab
         xI6yPIrKj1oAMtPZzp8CvhvlRHXqa9ExkEykOMa5otCCHccGjlpu0SsTTxKsEpgMDA2v
         5A4Q==
X-Gm-Message-State: ANoB5pmM5VZUVLg9Qw+RqKecTCrryAXhgve/LJB6eZvZf1+CnsBs78kD
        +GlsCVfHV0HLggN4XI2QBOVqfA==
X-Google-Smtp-Source: AA0mqf6t6lVqGBUM3fhphf9PXX1lLQmeOhZsQx3OSGUmf9QN4gv7d0jST0PrcyJpl5QvhovvFvlyiA==
X-Received: by 2002:ac2:58d7:0:b0:4b4:fbce:606b with SMTP id u23-20020ac258d7000000b004b4fbce606bmr4678034lfo.27.1669584190487;
        Sun, 27 Nov 2022 13:23:10 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z14-20020a056512308e00b004abc977ad7fsm1413012lfd.294.2022.11.27.13.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 13:23:10 -0800 (PST)
Message-ID: <0c021610-6b3c-f6fb-915c-dcdab47fdcf0@linaro.org>
Date:   Sun, 27 Nov 2022 22:23:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/2] dt-bindings: mailbox: mediatek,gce-mailbox: add
 mt8188 compatible name
Content-Language: en-US
To:     "Elvis.Wang" <Elvis.Wang@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20221124075516.1669-1-Elvis.Wang@mediatek.com>
 <20221124075516.1669-3-Elvis.Wang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124075516.1669-3-Elvis.Wang@mediatek.com>
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

On 24/11/2022 08:55, Elvis.Wang wrote:
> From: Elvis Wang <Elvis.Wang@mediatek.com>
> 
> Add mt8188 compatible name.
> 
> Signed-off-by: Elvis Wang <Elvis.Wang@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno<angelogioacchino.delregno@collabora.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

