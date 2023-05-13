Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3827015B1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbjEMJap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbjEMJal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:30:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706705FDD
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:30:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc22805d3so16382090a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683970235; x=1686562235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhRme26woaE0QLjWxrcWAlz/7S0SNVKgtvSiagJnvc0=;
        b=GysXJ5S3JWP71IaR2cLteiizuQ68yHsRh9aUhgVnxfaGGMXflReAasQRQsDnV9X6bk
         vYztN6B9Vrhn3f3WaYVEURw/CppRpi7n2AzeAyyjCZhZCVg4r6/Ye7fRthjm5rcXrabW
         BQv+fR0fwS9PUaAprkXl+N616pk2xieLI4CiQC6PdxuEjoU+uWp1P0xAdqKgj4lP4WdZ
         oGHwjwtiIFzY9IsyCNMVqS70SWAdnkUK2xXX4bMLgA67dKhus+1/tBjgXMQ8lYmQNq2s
         Y5mUY9+lw/8JNNDGgiBvgC8Ww+k163cXRRYnOgSBm+cw4CcziZgePEHEpBEJDsTH6Qks
         Jn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683970235; x=1686562235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhRme26woaE0QLjWxrcWAlz/7S0SNVKgtvSiagJnvc0=;
        b=EuZ/wbd0fBPJdl2MkHaF94TpDTrKLEzwdvwBG+UzIVYBa4lcVxC13go5xK70BS2ofY
         3P2jT7EVR9xPwpyTs7XQnn2FI8D6hK3fbAfSSZuBd7rw6SF/yHFh45ZU2F4xGYD1B7gj
         93cPPjYosIsKdOVm06IcH6sOUn0b1NEUpoTohbcv/QTXepKDt/vN6RzjFcJftgpopKkR
         zWkzc8QG5Hdmg9vui1XtykTvADtHwArj5kYdsdKbADgxL1TPUVSFugq9Qdaml+k5mM+H
         SJHzWOseKBgDBPTu2G2CBKtz3TVkR1A/7LTQR3gSAd69c1q1F3496mp06OWILUihUBpx
         CIOA==
X-Gm-Message-State: AC+VfDzY3ZuJomBnkWoutEl4eIk+sez7/mSYYFYCj+2CJGfoO4UEv+T2
        yjQqh+oayjg0M5iyaW/WpYYjlw==
X-Google-Smtp-Source: ACHHUZ7XuZam+xQ4Qz3NmieRw8oqJ4cXve9jQjRUs9dnsS5DXTPFnWEy7s2YqOvYmbNCNh7mMvBqTw==
X-Received: by 2002:a17:906:5d08:b0:96a:ca96:3e49 with SMTP id g8-20020a1709065d0800b0096aca963e49mr2472966ejt.13.1683970234925;
        Sat, 13 May 2023 02:30:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1d0:810a:586c:c5ba? ([2a02:810d:15c0:828:1d0:810a:586c:c5ba])
        by smtp.gmail.com with ESMTPSA id qh20-20020a170906ecb400b009655eb8be26sm6597895ejb.73.2023.05.13.02.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 02:30:34 -0700 (PDT)
Message-ID: <744b499a-36f5-b9da-bb26-56e1616351f4@linaro.org>
Date:   Sat, 13 May 2023 11:30:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 09/10] arm64: dts: qcom: qdu1000: Add
 LLCC/system-cache-controller
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
 <20230512122134.24339-10-quic_kbajaj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512122134.24339-10-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 14:21, Komal Bajaj wrote:
> Add a DT node for Last level cache (aka. system cache) controller
> which provides control over the last level cache present on QDU1000
> and QRU1000 SoCs.
> 

Must be squashed. It's difficult to spot the changes against original code.

Best regards,
Krzysztof

