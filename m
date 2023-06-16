Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4A97330A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjFPMA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjFPMAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:00:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1972695
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:00:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-978863fb00fso90109266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686916852; x=1689508852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDCe91zm7YmyOaAZfZp3EHNeU5kWqQS/89EQtd2WHpA=;
        b=NUG3x5oIcex1Dw2boCEKRRbeMyl/mlY+J99DscASf6fie9n4t/aBah8G97NkSKdvsL
         yV3nLBvBUTJUIyatcDwvj6CcD5Q3GLuredDhzY6+BvEv4lNjnS1sjsdJ3mE2tO+c8Zpb
         gW7DN0mo+/G9h4VW2lGC+B2h9k4A6WCW8J+yEGT+mlKzlEFStKg5e4sG8NRpb85MVdiw
         fUM7xA20tzBNQQdfhSxXQJqw3reSJutlpGjiT7O1mRrV+gCt/J/VQ60qPf4zW4OTgcX8
         pocpfKDb2z4L9iYL2/0qkt0uJUFjinOQvtZoNiNOzpZ0kafehIxrK9uXG6W2mLIGBd+e
         JQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686916852; x=1689508852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDCe91zm7YmyOaAZfZp3EHNeU5kWqQS/89EQtd2WHpA=;
        b=AUK3hs97Wy/oZZkUcK2LSuMOjkrtUutY+Gz4MIUI+W3mLHkz4UXRvxQrS4Hd4isUKv
         /NY7zKkXx0rI56F703Ey0PDv+nZq3b1r1BuM9YPn75RpGcsLCcA4m/UKZ9HqnW3aZKX0
         zT/rSQjHCcVSrSprKnSdmema4bpGfC5Y03YXaUkMOBmNlKIbRCveC/rc9ZCTBXD8l3nd
         Ay/uGylpZgD6By0HABcA0k7xXaN3LcM1aMB90vRYOdynMVPrF7pek58m79CgfLoZLfxK
         HgFTFyLjyYX2+o4ccOOsJU7NL0LM4oMPmJTjBA01XZev+niKH/Er9WxlY7YQnwQvGPIt
         bS4Q==
X-Gm-Message-State: AC+VfDz9XGjDSmAX8zgjHmNplVAZMDgIpg6hLLfL/SeOgeOaN2VLwELJ
        QI9BlqMebAMBim9B0LfzjVV4yQ==
X-Google-Smtp-Source: ACHHUZ65FEJFWoXcDToLirDxlNYRxN9nA9zuG18GONfZRsAXdwpwpWqNH/wNEI7NFBOCphKe9dwKSg==
X-Received: by 2002:a17:907:847:b0:977:d53e:4055 with SMTP id ww7-20020a170907084700b00977d53e4055mr1546239ejb.58.1686916852435;
        Fri, 16 Jun 2023 05:00:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id q15-20020a170906940f00b00977eb9957e9sm10711382ejx.128.2023.06.16.05.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 05:00:52 -0700 (PDT)
Message-ID: <30c913bb-fd8b-9290-65c6-4d757135b731@linaro.org>
Date:   Fri, 16 Jun 2023 14:00:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 02/13] dt-bindings: display: mediatek: mdp-rdma: Add
 compatible for MT8188
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230616114111.17554-1-shawn.sung@mediatek.com>
 <20230616114111.17554-3-shawn.sung@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230616114111.17554-3-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 13:41, Hsiao Chien Sung wrote:
> Add compatible name for MediaTek MT8188 MDP-RDMA.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---

So you ignored the tags everywhere? I am not going through the patches
again, it would be a waste of my time.

Best regards,
Krzysztof

