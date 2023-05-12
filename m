Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F341700D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbjELQxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjELQxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:53:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FF6A275
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:53:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965d2749e2eso1508681966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683910386; x=1686502386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CN6pCJcBzZ51aATWk78TJrmoYzIoOv3jWdHbtYWFl7M=;
        b=UleUVIttaU4XHJvEB1+6GxxvA45kFC6nR72DdRpYznNa2jmdFVRDxIn86/suJca+1B
         tIGjCLwyVMCyPpPive1kMoRCAfLVtNELfcRIOO2H52H0HsKTUuOpT2/Zn7KQVyBasbDD
         6sJwRb+rB3jne30p9niet/wVvcQ7G4zoTy54k//kk8SVuL+i6WmGmUjpKVQ5lLA/3FoL
         30bQtM5bi+K1Om21XFzqcrOgtUZSNAZAKLWi0TNJzxoYuFsQw1MIFGOpeu19XhHinYrm
         Elph7pG9udbsnNfrx5/c2AJDFBZpmoG5h/KihNfm+tSIWTMkjzv8D4oeso2eDVY5eV/D
         fujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683910386; x=1686502386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CN6pCJcBzZ51aATWk78TJrmoYzIoOv3jWdHbtYWFl7M=;
        b=ZXAry3zw+9J+9Hl4rKbfwsf76/CNjDVJT30PfLAtijBBCdIOwvj4rDGMcoE8U5NGyp
         Bnp6H8eNVVqvhPEdFp6JsW+GIlFI8K/+ZokP6+61k8nMouVxLHdrrwIiPMs5gUxnk5gw
         6ZtB2S0Yk1HZb8S3i9iG+hgIUTMeuZjPnesa+PlBYRvKThwjEwNcchBQSN5SdgE8WkLm
         FqAOW3nN63ecfC+zZRUbCoBR6HYk0/gCVDtPnwL0nc5O0xAz9G2G8EZHjk3oh3PEmqJF
         HTaDvVdNGz19C+fp6XkV8cG4Aj08fS8MLZ0YYQqJeZmomvltvm9ZpgoVpMdQz/J7N+5i
         y7Vg==
X-Gm-Message-State: AC+VfDxcynn+4did+afZXAUJS6pjztGsrL1Sngs3R/y0NaeNvnkKws0S
        kZw+s2KQw7mVpvHGl9+WVkgJ3g==
X-Google-Smtp-Source: ACHHUZ5giuXLk5Ub8rO6/Ah0SRPh0XXQGplyCO3M/vAYmJSQY6vGyQZ23uiBcc2mrclTGnogm7Tq5w==
X-Received: by 2002:a17:906:4fcf:b0:94e:1764:b09b with SMTP id i15-20020a1709064fcf00b0094e1764b09bmr24949873ejw.45.1683910386031;
        Fri, 12 May 2023 09:53:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906328d00b00969f44bbef1sm4965177ejw.89.2023.05.12.09.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 09:53:05 -0700 (PDT)
Message-ID: <3a4abc55-971f-9e8c-692a-aa9acc4dd7ea@linaro.org>
Date:   Fri, 12 May 2023 18:53:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 3/5] dt-bindings: clock: qcom: Add RPMHCC for SDX75
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
 <20230512122347.1219-4-quic_tdas@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512122347.1219-4-quic_tdas@quicinc.com>
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
> Add compatible string for qcom RPMHCC for SDX75 platform.
> 
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

