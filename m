Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E520D7245A3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbjFFOT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbjFFOTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:19:22 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC41E79
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:19:19 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f736e0c9a8so23819885e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686061158; x=1688653158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLJFbQYmxrTDG5LviuU11MzRe1assIVdj7KuflZnNpY=;
        b=d8pNyDvcbPPK3+UQuLCrl1UfrOPi3S135bTZSRUrILBjQTiKVUcA1SiYN+5fnX4gBE
         qoxxa/gItEoI9UlBr956sauyXrVJ1ILJLjrId6VvZPKpLK/b9sPll9GWY70qjkgtcPr9
         fZMwzmyClilRGb2X8g4eYarNaODaDsgc/fsfZZ92DlwiwAkzUankwrSrNe9IY2Op6T3v
         JLVQ95QkqsGVjxF7Pt1DZWsCO/R+OVf415IvCr4Ze78BRObScUjwAhby4HTdycy8VQoH
         S660ICJva1urzKd4hpb9lBjxahzMw64pWuMFQD7uSQaL7EBXKTA01jvEUyzWHAnupqGp
         C9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061158; x=1688653158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLJFbQYmxrTDG5LviuU11MzRe1assIVdj7KuflZnNpY=;
        b=O2tS/FI5D3WABEhZfUIyZICfsX9p9/PkDSDdVc/eWZ/1aTSmDIKdbYoHo0skjKSQ13
         xOdGyaVksamLhVE93t52UAaLlwXeRSitbbumftCleAh3AEYAkTtumxksELibsIDSn7wm
         7GBoZGdjH5E1Tb1Svk2+mqvfOS7Yz9UzUa+TeEuqW8tWkZRE4KAM0BuhpNWXT2JeYIOL
         04RkIax0gZTFEJxiET0mejsiqqAdny44gmKeZyPdnK7SFm4yNno3UnJCNI/gKrt//x5R
         McQQqY/3XZEvxNyepiyHRqLJY2VunWXw+Fp8o+jFMDTZYZLrMVre7LSnYP1F4tyTsoPs
         6cJA==
X-Gm-Message-State: AC+VfDwVTR24/XGl+PZh417EJrSENDjCTpJxRZTxTsi2kBSEtsPoqIlY
        oxVYb5gt0ISYPyL9TrHS4LaPkw==
X-Google-Smtp-Source: ACHHUZ7tMz1e7peVOgjwE3ohW3F0yZCcAJE40qZ3YvbzRfKex+sTAxn9BgF5iKNHfpSa9OMAMW9GGw==
X-Received: by 2002:a7b:ce09:0:b0:3f7:b1dd:954b with SMTP id m9-20020a7bce09000000b003f7b1dd954bmr2207090wmc.31.1686061157879;
        Tue, 06 Jun 2023 07:19:17 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003f727764b10sm13928677wmd.4.2023.06.06.07.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 07:19:17 -0700 (PDT)
Message-ID: <c8cde297-d713-cb18-eccc-18d6d486c5a1@baylibre.com>
Date:   Tue, 6 Jun 2023 16:19:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 6/7] iommu/mediatek: mt8188: Add iova_region_larb_msk
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        jianjiao.zeng@mediatek.com, chengci.xu@mediatek.com
References: <20230602090227.7264-1-yong.wu@mediatek.com>
 <20230602090227.7264-7-yong.wu@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230602090227.7264-7-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2023 11:02, Yong Wu wrote:
> Add iova_region_larb_msk for mt8188. We separate the 16GB iova regions
> by each device's larbid/portid.
> Refer to include/dt-bindings/memory/mediatek,mt8188-memory-port.h
> 
> As commented in the code, larb19(21) means it's larb19 while its SW index
> is 21.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

