Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77676E6BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjDRSCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjDRSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:02:41 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585EF61BA;
        Tue, 18 Apr 2023 11:02:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f1728c2a57so21287485e9.0;
        Tue, 18 Apr 2023 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681840959; x=1684432959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dq1XDLxilwUbRdN2NKx0IAo9lxfpPYiUEXJI1fFrVu0=;
        b=BuyxldTXbucsx62EFsiScrzThNIX0m+NcsbtdxeiOSQpufd77ss2oho1H1Cxey9a+y
         4hqMr8pzk3HxS3cPiYBvO5UmddlMxpW4dvw35iv3PKPnXVAg6kn8hvxcK9QXGnAfsKfN
         Lm0uMZHHkGAwwbW0iqmlTNZ2a2Z5Q/Jm14GxYs49YdCYdGHzdgFu+YvRRqB9p5Ro82j6
         hkhStFuALXFHpsTakvF4Y3GvsrOQCKDrBpu4A7RGmZ1Fld2rnw+RKGjs4CmpP7j0fTWz
         //9BDnAoAlZmOIwB5gS9gfVj51ri4m+aoSbq+T+2tqYVkM4YS4GcymAkpUWQsYhrGhdd
         q3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681840959; x=1684432959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dq1XDLxilwUbRdN2NKx0IAo9lxfpPYiUEXJI1fFrVu0=;
        b=VSVTap2zj5j1aB0tjxiXDUIabXY8DfHs3xPLwWiJjhR5jTFCDY2ZfeaPEkBcJDQtgK
         rkR249UaAxzD/0WMr/Io6UjVs7j3NrP285qJstdLkr6zLhGBu+GUTHb+BHjJJIZzUrfB
         BFmd7m3mg5p5h05EOfBW/nwtRS0EoYnstAzgiBEPKbY3xqK9gFUnoBY8yKuySB/A8zpu
         MqTuogMyfiUTxrUCnhCrsbiq3jrmHYvQr6mHt1oGnsrHM25VaRexSYFqtTapsRB2NuT9
         edne5AAtTzabf5IExn5Gt1kmY179LQoasi634AM1CZ8XPguieouUKnFgwmgwzpHD1xgW
         RIFg==
X-Gm-Message-State: AAQBX9dTPKO+WQnhaLk5U5kUJpxqE+HzejGBoMwqhNOKMxtwNR3VRKmL
        ETU0AUCvyIG+by+qAACChsA=
X-Google-Smtp-Source: AKy350bcOoocdidKn1c/bC+dVipSJtRDm24yqfKPnERXZZIxB81yRoRfcgQB2SuJ83eRc0ODohf6Qw==
X-Received: by 2002:adf:f2c9:0:b0:2ef:b052:1296 with SMTP id d9-20020adff2c9000000b002efb0521296mr2699430wrp.22.1681840958643;
        Tue, 18 Apr 2023 11:02:38 -0700 (PDT)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4d01000000b002e5f6f8fc4fsm13611818wrt.100.2023.04.18.11.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 11:02:37 -0700 (PDT)
Message-ID: <f19562fa-a8c6-4870-e413-7593419b800f@gmail.com>
Date:   Tue, 18 Apr 2023 20:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: input: goodix: Add powered-in-suspend
 property
Content-Language: en-US
To:     Fei Shao <fshao@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org
References: <20230418124953.3170028-1-fshao@chromium.org>
 <20230418124953.3170028-2-fshao@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230418124953.3170028-2-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/04/2023 14:49, Fei Shao wrote:
> We observed that on Chromebook device Steelix, if Goodix GT7375P
> touchscreen is powered in suspend (because, for example, it connects to
> an always-on regulator) and with the reset GPIO asserted, it will
> introduce about 14mW power leakage.
> 
> This property is used to indicate that the touchscreen is powered in
> suspend. If it's set, the driver will stop asserting the reset GPIO in
> power-down, and it will do it in power-up instead to ensure that the
> state is always reset after resuming.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> 
>   Documentation/devicetree/bindings/input/goodix,gt7375p.yaml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> index ce18d7dadae2..942acb286d77 100644
> --- a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> +++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> @@ -43,6 +43,12 @@ properties:
>         itself as long as it allows the main board to make signals compatible
>         with what the touchscreen is expecting for its IO rails.
>   
> +  powered-in-suspend:
> +    description:
> +      This indicates that the touchscreen is powered in suspend, so the driver
> +      will not assert the reset GPIO in power-down to prevent power leakage.
> +    type: boolean
> +
>   required:
>     - compatible
>     - reg
