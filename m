Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F22E669671
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbjAMMIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241163AbjAMMG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:06:59 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983AD49141
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:58:12 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id cf18so45415142ejb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJfnZs4jo54Kgz5HLGIY/C94TyuqRX8gh4vXaqx8qwc=;
        b=xz/7KR/nbYYYhHj/GgARzVka0RWlZgXvR8KL/EWM+Dqqnk4bAhFX/oRMaOU/zthcVn
         r8j1WHiNXLTpC6LtFX8mmYWnIUgZ+2Cx3Bh0YujgJVTcVoKpBSQ8Vdqn0mGz2M0MCZOB
         GUcxSAWuUsOzj4fXr7ztt+Fx4SWBJPdgodoJYpx0g+eJOXv0dJmRm/vkIkWvwzYNI85e
         ozQh57PYlC7FzFkdwrkcnv8s1nKArYmrFsj+kpfMokUQRPcpY6T2hrriGCEwf9ctWHp9
         AkQr2hgyDja6oq/l9KdyithNXDba+O0KX58P/p8Hs36aKQmTQK5pFglh1ieuACzpbgQh
         KZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJfnZs4jo54Kgz5HLGIY/C94TyuqRX8gh4vXaqx8qwc=;
        b=4MSZWV5Tk9N6oK8RP122w4I4I1caaIGbG/i2CAenrkD8TtirvwA+vorznZGpwsIeut
         tNKtxHz9nXBZDdJCFmVyIeOJ7Z5wNqn4KRa+9cLE0xHSZqKiF1utWKONnGhIFsJAIH4F
         WvpV1TagnR6ZDu2q7pBwPeFZlGRIkZ6JXvLAUYHLt1AWabbpObDn9thraj6Mup0BNgzq
         e8Ytxy98IQXRT/qxv2uKFzqF2qC+0THADQ/qVoI/0oOqCVa8f5dzT4Je3Rkg3Mk60xgX
         JONen9RGV1ps3Z5Pao5TCKYoNWXE9ZQPXrfSXpXkCviqzxXXEYM0tBkY5Lup/bsDOgqy
         Sh3g==
X-Gm-Message-State: AFqh2kqjdWVOC5qlcypvYAZpiAFwWmd8LSl5ekYT9JWHA9Vmji+Llaxf
        na8ksyFZdagO35dNBoMlcdKdDA==
X-Google-Smtp-Source: AMrXdXtPh9NG2bS51YWCcldtb0iT3Z5psXpa553yTDBZpJtjglNIRpUJFcZBAJrCFSxgoYo+c07TxQ==
X-Received: by 2002:a17:906:5202:b0:7c1:4a3:10b6 with SMTP id g2-20020a170906520200b007c104a310b6mr67094493ejm.53.1673611091238;
        Fri, 13 Jan 2023 03:58:11 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ku26-20020a170907789a00b0084d46461852sm6153963ejc.126.2023.01.13.03.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 03:58:10 -0800 (PST)
Message-ID: <329aed63-4522-9859-4359-2a450c46dcc0@linaro.org>
Date:   Fri, 13 Jan 2023 12:58:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 01/10] dt-bindings: arm: mediatek: migrate MT8195
 vppsys0/1 to mtk-mmsys driver
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230113054304.21841-1-moudy.ho@mediatek.com>
 <20230113054304.21841-2-moudy.ho@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113054304.21841-2-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 06:42, Moudy Ho wrote:
> MT8195 vppsys0/1 should be probed from mtk-mmsys driver to
> populate device by platform_device_register_data then start
> its own clock driver.

Unfortunately I don't understand why this justifies removal of compatibles.

How do you propagate or instantiate devices is not really connected with
 the hardware description.

Best regards,
Krzysztof

