Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3746DAA4D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbjDGIlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjDGIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:41:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B40B4EE8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:41:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qb20so6965150ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 01:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680856877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxVjcV3h63tndOVUPeb3nRlZ/9fXaEF82W2eqSGSLJI=;
        b=R4vL4QJOQ1cGCQO9T+0MVXBYjYxyf3KITR1VUF58mYUadl7VF95KYHZJINZd5QZakD
         n2b4QtJK7tf5fCO0CLMqDPigIV+EeUaw5nWkiUGvlxWaNiWE1hM7D0YjT3IiCDzwkcX8
         B0etLIRNSDonqDBGouJ2pQ08lBrZ19FKu2duqQ5BHczRa29YbE9x4XBaUZ3ELfpef//0
         5Lu37rhrOoZmwtbaEL4UHQxzhhi4NTK9mYMBAIJLoZKaMYmE+6LXtQfPjVjdQz/ikk8e
         8ziZ6pfIlEOKjxd5uI5z8puNYCIuU/PepteNcmjWuxKNDqYTq1HuH+m35mH0ctedhStG
         am5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680856877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxVjcV3h63tndOVUPeb3nRlZ/9fXaEF82W2eqSGSLJI=;
        b=s07WF7QiVoUZYyXH9qFJ0p/iEdvu0prZx/NVdTlEhvIiTkHCBluRNLLcSKcC27x55j
         lXlQxgj4O2qBuAz5fgzoQ3J2mYa5cES1bDSC1vt9FN/RUstlon3bHKLXg/YykqkhkHri
         Oqb/YiATXgDW+/V4mVKuHyMYfNVxmmXEAdMWZ1SWK+Y49vzIOI6CFODRElJNq2SQapkR
         8fkmirvDYoHd7zjXFCjORl0Se0DdkBnzFLcCeLj71Xxa5xNlQHFajsUiJatdkbUyFtKz
         LvI9QRPUikq493Cdf0SIKEBguTZOMn/RzgDcpIsPl/jjidaFxEiJQQW04Tr9HIiZu6IF
         DEAA==
X-Gm-Message-State: AAQBX9eZ8zr72c7C/FtjL1mmv73D8I3bAFUdYVj7afKAcBEXNwZB3ha5
        vAiJVhITvQY/dSXd5zrs4JqlWQ==
X-Google-Smtp-Source: AKy350bSWSwQScmsM/h8LpFJejXu9MfCeZuNuD/EyAwGkUUbUfkJUnsF4OXo/c1V7p+WZdaiDjNCQg==
X-Received: by 2002:a17:906:eec5:b0:906:4739:d73e with SMTP id wu5-20020a170906eec500b009064739d73emr9789990ejb.2.1680856876985;
        Fri, 07 Apr 2023 01:41:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:14a3:366:3172:3c37? ([2a02:810d:15c0:828:14a3:366:3172:3c37])
        by smtp.gmail.com with ESMTPSA id e13-20020a170906844d00b0090e0a4e1bacsm1814294ejy.159.2023.04.07.01.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 01:41:16 -0700 (PDT)
Message-ID: <796300c0-19e9-2c22-8385-1b33a92bf02f@linaro.org>
Date:   Fri, 7 Apr 2023 10:41:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] memory: mtk-smi: mt8365: Add SMI Support
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230407-smi-driver-v1-1-036d6d8e8993@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230407-smi-driver-v1-1-036d6d8e8993@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 10:39, Alexandre Mergnat wrote:
> Add MT8365 SMI common support.
> 
> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
> This serie add MT8365 SMI common driver support only because, to be
> bisectable and avoid issue, this driver change and the related change in
> the DTS should be applied in the right order (driver first).
> 
> Here the related DTS change: [1]

1. Where are the bindings? They always come with the driver.
2. Where is the changelog? What happened with requested changes? How a
review tag can appear on v1?


Best regards,
Krzysztof

