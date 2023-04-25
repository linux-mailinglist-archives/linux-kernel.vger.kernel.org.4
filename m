Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623296EE167
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjDYLzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjDYLyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:54:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B859B13C05
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:54:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-2fa47de5b04so5448723f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682423668; x=1685015668;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yI1TPR9O8Wn13PLfmt3B7Vg1j2zRFGIPi65gxOuaq/Y=;
        b=3nlr/BU9pJfmnVhoKeKK1Gca00UCWqM4C1wadITfww0QPAIukFk5VSU9ouJ9F1CVcb
         cqXl4mjge8YEnco5+X7metyV9AOpF/xXwLNFLWlttnMOl+nk5GZybJObRoXvBDQnfkPc
         2pLOv3wma4WagQCIEjUBhibYZyV57MbSX8ZU/CcfCOTXaaXv3Hd6SwD+s/EAN1pD9fi2
         b8pAlkxoBoxWjyPA9PoRxtPJfYVSx5x1VshuKq2LNMZtJY3S9wAYJiZ2k6Ok2NhV7j6i
         sgM/M+AOKle0zyLGDLo2uDjL1io4JogdtEP7vpoZ+j8Dsa3VxrOStICnoS5cxHZnN+Tg
         VNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682423668; x=1685015668;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yI1TPR9O8Wn13PLfmt3B7Vg1j2zRFGIPi65gxOuaq/Y=;
        b=RAsMhRSluBhl2QpjA0yHOL3LESrZqohnxQn/rxhPdp4OLLbMAAe9QTGAYVCkZmRtnn
         9FELWhvYfmv2RefI0mgo7ZikZCWHy6qQxQyGXSqhRLk7K7422GsJocE1Gvp87C+7R5TD
         vLnfH3NZlJHuQkUYclakXpZ3GIdVzMAYNYgtd+5CewpliJtLAYNsadpPzAnvpi/W0Ee5
         rtLJVvQwMP3Zl1Y0ABlUCiZ90lbf4GCvtl9Md1csZIWzCNDnbUrRVlnq4e/roe5+nv0p
         mlYlHejlBt73j8QjB0NdoXJlRgOnahdEvU48v9VprXRjVw5Bm4Kr6tHx8j1feRDqJXwP
         2KeA==
X-Gm-Message-State: AAQBX9cc39NSs8iY0YYx1b14kxYn9LX3+h9jNPGHno13d/XRojTPPhId
        IeM8qK7NPAt0B4+IdDCdiDHm2A==
X-Google-Smtp-Source: AKy350YCwqDUNA8w+A+W4tuYIK6NweEAGlyiUZKepVtxB1ipt8FUsK3pDf48E+Y+4hASBI4VwAmAJw==
X-Received: by 2002:adf:e4d2:0:b0:2f2:7a0e:5cc9 with SMTP id v18-20020adfe4d2000000b002f27a0e5cc9mr12124465wrm.19.1682423668174;
        Tue, 25 Apr 2023 04:54:28 -0700 (PDT)
Received: from [10.101.1.6] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t12-20020a5d460c000000b002f6962ee703sm12948252wrq.61.2023.04.25.04.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 04:54:27 -0700 (PDT)
Message-ID: <202f71ef-5e95-9fef-bac6-18ab8d0c4fe3@baylibre.com>
Date:   Tue, 25 Apr 2023 13:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ARM: dts: en7523: add missing cache properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230423150824.118430-1-krzysztof.kozlowski@linaro.org>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230423150824.118430-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2023 17:08, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified and cache-level properties to fix warnings like:
> 
>    en7523-evb.dtb: l2-cache0: 'cache-level' is a required property
>    en7523-evb.dtb: l2-cache0: 'cache-unified' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Regards,
Alexandre

