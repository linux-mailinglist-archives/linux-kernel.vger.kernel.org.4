Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F787189CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjEaTGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEaTGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:06:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBAD101
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:06:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51456392cbbso2823626a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685560002; x=1688152002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yR7IN/rJmbW/7sc8ydTiLPthUafqqH/Du1ORqrZgWWg=;
        b=o78KcazMr6xQ4rfYIG/MI2lJw3SPhYcP/anXxXwf/QirEg3eLc3JBqJEygjdozMb7T
         XMuj5WnUIXQWbN4bOrUXg89LTE5tOW/ueBje9/PlO/HCVoCoImvsiinSkYELAGzQ98fD
         Bjxs6XBXr1XXVIqtc4vHLr/UaV5Ye4W0GirbhdyWHMA2teayX/xQYH72cbQbjVdoCHSy
         dsbJsltwxpL1qnbq250cq/HzKvCtF7Fbr6Pg7/iHzFSMoRWOBGNfuJ33nyOyu2jDRwig
         IH4E+3idZlHhTmH2FQsN7NEvZv2e38wha9gZt9dSjToPxbHLyLZpxUNsI0fpArlzE8zs
         yiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685560002; x=1688152002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yR7IN/rJmbW/7sc8ydTiLPthUafqqH/Du1ORqrZgWWg=;
        b=Km3fk5dOl/ckHJp+rxjp0u8yYN9lypLEJZLo+/Y74OA8C12wvNqApxNBNVBYzsdqfj
         yIDx3SjurgSog1rin7Xnkjwd8/nyv0o/ymftwC26Pz2z3tnv7X7bJ4l2AW+W+GO+pMpG
         1+qXiCXdv89aoh0ikQ3Q4JeKq6FWhjkKNTtFGHxVD8usOt/Jrvc5hUtsS2oWHJbOozte
         NqFYN9AHjO9Qso6fR1bR4/FuULS50BFZP2coY5ru5ujLqjjgo6Iuyqm78/0ohOihcUp0
         pt7foE5J6SqGc0HhbQB2bbCAQ5tONEdOrmnv7k3o7BY4gs2VdzK6L3Mjjy7KQUWKF5fk
         /qKA==
X-Gm-Message-State: AC+VfDw0Iy3ZtHS6JT+xedKGQbglwgTrXvd2p4pQPNOnt4zGMQVW3euZ
        aNeJ8d+mKydb5y5Ti8z8pragzw==
X-Google-Smtp-Source: ACHHUZ6Gjg4u5HI2TPqwWF8w/xRRnBF6kJtCaMF4P1k+1aswfie5jogdRnQ0Qklx1CUCHyCnNq/pyg==
X-Received: by 2002:a17:907:2d27:b0:94e:4285:390c with SMTP id gs39-20020a1709072d2700b0094e4285390cmr6798209ejc.10.1685560002373;
        Wed, 31 May 2023 12:06:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id md7-20020a170906ae8700b0094edbe5c7ddsm9404066ejb.38.2023.05.31.12.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 12:06:41 -0700 (PDT)
Message-ID: <cfd657bc-59ba-e63b-beb9-1661b8195a95@linaro.org>
Date:   Wed, 31 May 2023 21:06:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/8] dt-bindings: display: mediatek: add MT8195 hdmi
 bindings
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mac.shen@mediatek.com,
        stuart.lee@mediatek.com
References: <20220919-v4-0-687f09a06dd9@baylibre.com>
 <20220919-v4-1-687f09a06dd9@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919-v4-1-687f09a06dd9@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2023 16:30, Guillaume Ranquet wrote:
> Add mt8195 SoC bindings for hdmi and hdmi-ddc
> 
> On mt8195 the ddc i2c controller is part of the hdmi IP block and thus has no
> specific register range, power domain or interrupt, making it simpler
> than the legacy "mediatek,hdmi-ddc" binding.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

