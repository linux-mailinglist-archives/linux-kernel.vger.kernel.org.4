Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1BC700D66
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbjELQwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbjELQwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:52:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4203B1982
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:52:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso18004575a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683910359; x=1686502359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=taY6vqOnlwfgSEUKM+GvHWsmve6rMezjk03XxW2GBtM=;
        b=YB7mprcJ1M7cWZosUXrcU9KX6AhR1MPra/gLlGmxOPlwn3zgfK5TSnI41JqGAf66p3
         sthhLP/TYi6Q5EHDYoU0U8tbi0Y0qwrljREJAl0PCaZ8948HKD8WcBe6VUFJA1/LcQQy
         VU5qmAXELTaZX2VqCkK7ZUBM/hW3JCzs+16ilzayFqwgTPBg5d++VKyinAwkiWMoTeOD
         v7BAEHU+R4HPKVzfeDWTCy9JWjr/NUTAqSh8UpbRSpgK7bY0A6Et8xcbuCnfjJufh0NN
         XVjnnjPrWiMlILwDzxOaBk38HCut10BeQFCgvr9+5qdtZx4p5e0bmP3Dh5rPFrI8SDew
         JbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683910359; x=1686502359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=taY6vqOnlwfgSEUKM+GvHWsmve6rMezjk03XxW2GBtM=;
        b=WnpY1Dcyl0AbFSo6nji+trGINyTSh+6sH+Fe6qo507Mz/If+R3DqbUwpPw0Zb5Paw/
         yuPB8JKzTjfxcsY+LBri6GrM3Jnzjgkry1bMMe4nCrOGVbA9P2fcfcUZ9i08CxMFsrBQ
         cCfZZPt3GKZPkeV6RWo7GSOtmK7PNpLZgDbPC219+h0v7ruyRyEusC9XoyryFK+jIz8c
         LgHnjR2xFINeEGp+QkHLJsIUAVGRSmfhAKDJ8fMJJa60+XEUhQc+iiKlJ4JQy5wL+U0x
         uQcBFzhrE7kZXpV9uyYn1QYbb+EdW3V3OSyRyKplJ6W3lGG/hoivmIRYn6jG5yF7EWV0
         GApw==
X-Gm-Message-State: AC+VfDwpaKxCNLK4bC0QxsUBNepBYujBiY3jwA5CVAXeo/Q7Ro8bX8Ay
        38Ks8G1sfkYQcYWhoVYe06i5Gg==
X-Google-Smtp-Source: ACHHUZ59eFhWe1aXjkUV2GDKtKNfDQ9z13JZWV+UAdinGaGhOsxQrTLgqX2nVUOz8lj6XNB/0/btDw==
X-Received: by 2002:a17:907:2d0c:b0:966:5c04:2c5a with SMTP id gs12-20020a1709072d0c00b009665c042c5amr18475819ejc.69.1683910358651;
        Fri, 12 May 2023 09:52:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id y18-20020a170906525200b0094f7acbafe0sm5694243ejm.177.2023.05.12.09.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 09:52:38 -0700 (PDT)
Message-ID: <e3c36382-f768-bb4d-4a32-dfac079cfd3e@linaro.org>
Date:   Fri, 12 May 2023 18:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 2/5] dt-bindings: clock: qcom: Add GCC clocks for SDX75
Content-Language: en-US
To:     Taniya Das <quic_tdas@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, jkona@quicinc.com,
        quic_rohiagar@quicinc.com
References: <20230512122347.1219-1-quic_tdas@quicinc.com>
 <20230512122347.1219-3-quic_tdas@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512122347.1219-3-quic_tdas@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 14:23, Taniya Das wrote:
> From: Imran Shaik <quic_imrashai@quicinc.com>
> 
> Add support for qcom global clock controller bindings for SDX75 platform.
> 
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

