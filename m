Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633095B6EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiIMOAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiIMOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:00:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E36C13E9B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:00:32 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so906042wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=YTIg1OEXQ1/dcwcVxi+ZGuAdkeMfYekXYmzBim0nPwo=;
        b=hrDCYLEP1zzGWYMHHDLGYWIigPeQSwQMzhJFuPFlSGf/ZedgoAtZUQ67l9GsBD10oq
         LQ61+//hDPef+UROY1UFHL/IOKC/t1jMkimOMibMBfwcZBes9tc6Ob6qRVGzPVanIcBI
         OnmMgK6IwI1Dr2T4JN8Ws4DTyPkEBvP7DFYGYHnS+NYHZbiZfNkxeWDaO5RVgG9ytyJD
         2tGLX4UxKzZHQCifoq23qSC4Awc828J+PUfR7b7l7yFgAzVzE0urmluDMBkLWwrqUKNY
         yHrlr+dJ/gaeIefR5sn07jQualrsm48m9IFNGNHrAs0f8WqdV/XWQHvIMC1LXKnU33W1
         fdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YTIg1OEXQ1/dcwcVxi+ZGuAdkeMfYekXYmzBim0nPwo=;
        b=LQajrBWE+32nEGcrDxth6xhyjupguuS8GyTVt7LIJlpVu8wL4pUMnCfOoP3Ld38Qkm
         AXuyf6lOZA92MnqcTJE0wTsfEAX3MoSaWYHlHvlZYXibw3TUizlzHg9fVWprGBFgySUq
         3iyH/5l0E/9I798EO2wTvNynaN14HeVtw11tp5DZefRwdbG8dJqz9m+17HLPGtyXodmq
         MnDhwCFED2v+CBTPvQtxKdOMMPvr2nyCYb+nhGHH/yo4EeTCiKulhGgzMq9w1VhLyPcd
         CB7U8PX6djeBV0WxMreLeUSiVJDKjviwy3xqnfYW20heFsNAHAtT2Ie6EaumNozKj5yf
         2qpg==
X-Gm-Message-State: ACgBeo0eBpHKLEIbe/2hVpV8dYxLnSONrx2PO5wbYyTgQHhX8FBs0Nj6
        LGgu2Q0tLwWmLDD8hx9C845uMQ==
X-Google-Smtp-Source: AA6agR6eb5yCW6EoZ0KxQRuBsKpwheJjnMgMzi9W9LXmWNAhnASIkVMi98VWdxKNTTbBTWXhTT3Usg==
X-Received: by 2002:a05:600c:1e10:b0:3a5:4f31:3064 with SMTP id ay16-20020a05600c1e1000b003a54f313064mr2490080wmb.136.1663077630890;
        Tue, 13 Sep 2022 07:00:30 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.67])
        by smtp.gmail.com with ESMTPSA id c1-20020a7bc001000000b003a5ffec0b91sm13123005wmb.30.2022.09.13.07.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 07:00:30 -0700 (PDT)
Message-ID: <affc47aa-a11f-d18b-7c6c-a3698d97b3b4@linaro.org>
Date:   Tue, 13 Sep 2022 16:00:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 1/3] dt-bindings: mediatek: Add bindings for MT6795 M4U
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, joro@8bytes.org
Cc:     yong.wu@mediatek.com, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        Rob Herring <robh@kernel.org>
References: <20220913122428.374280-1-angelogioacchino.delregno@collabora.com>
 <20220913122428.374280-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220913122428.374280-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 14:24, AngeloGioacchino Del Regno wrote:
> Add bindings for the MediaTek Helio X10 (MT6795) IOMMU/M4U.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Rob Herring <robh@kernel.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
