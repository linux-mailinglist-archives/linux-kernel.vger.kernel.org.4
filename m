Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3D56CB758
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjC1GmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjC1GmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:42:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EAB19B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:42:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x3so45266472edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679985728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=451j44+6MRrjjocPev25db4ORq+gaZ4ABjFTXWHPHzM=;
        b=Qe8/nJ97su7uPLmdIjcVPCheqGdN7PQfAi4CTS73IRaZ0u66bA0GBLRqfvZky48jcR
         DqvGguKXS5TUPzEmjpceIrMqMgqalZ45c3gG0ji4aYvZghRtrkiTDKHmt6Qwyzi6vRVt
         BHVbWc3BARQZM2ciJBh5+7S5w2Yf4/efHb/5Z9qjP87Hh5kiH/5Qz28Pcy661mzeaL2H
         LnH01tuYR8Lp6tcdJiyD+4SSXQveH6YTiZpmhCErptaMJeXmTVTM0LHwpwqjL/alt11G
         d5n2HW5FSRp+0RPS1a2oxGNS4skGS2ObBRIww+Ho96KRn+GOgiViEFtQbmlvmqY6BVkL
         wW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679985728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=451j44+6MRrjjocPev25db4ORq+gaZ4ABjFTXWHPHzM=;
        b=KAer0AbiPb9zsHyU0BD9LYzeZk53/8IuafFXFJ4QlGn1ZSUmcGtaeteE3NaLY5kQix
         i23QY/Gr3ZoKizokzyzkBhVSO9cvZSlKAw9Pt8UtvhdWyHwrgt7B72tLvYqgjoYe5lNp
         IuATNPw9fDd2GDGGEM2N/lNToZ6rgvI4mwFufdcg0o1u1mKbj7Of9hjigapFyigwz9zz
         rq62riD+/T6517PXGXiy1ShWSL45L00KD4HCYvoC9iBN8KSF37Kx6Tw0dSRHdM5ANOWu
         3tbHrH4xsyMY5/HNR6qBoU4fWYRzExg1jDrfSAj3LpbC3pzrvB8DPekozmU+KF8F9+AH
         lLLA==
X-Gm-Message-State: AAQBX9foSJKYeym3zBV3Df4+0vK3D+heRGhJRNtSViXj+zRxJ+4H9SwS
        Nw7lv0V8SZ6Pe8QF1vwCmWNPRg==
X-Google-Smtp-Source: AKy350bPobP7mxNYomM7mTnUP+KR0VKgYBLm04hWoARq4akmXfxUlUHc7yIwq5WmnLYkEcUIdmxlTg==
X-Received: by 2002:aa7:c90d:0:b0:4fd:1ff0:2291 with SMTP id b13-20020aa7c90d000000b004fd1ff02291mr13811380edt.18.1679985727914;
        Mon, 27 Mar 2023 23:42:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id s30-20020a50ab1e000000b004c5d1a15bd5sm15403339edc.69.2023.03.27.23.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 23:42:07 -0700 (PDT)
Message-ID: <acb67dc8-0186-695b-5986-6f1d91a0108c@linaro.org>
Date:   Tue, 28 Mar 2023 08:42:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: rng: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230327170153.4105594-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327170153.4105594-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 19:01, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

