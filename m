Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548E8669168
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjAMIoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjAMIn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:43:57 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BA2574F4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:43:53 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id tz12so50676528ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zB+Yx7ZN+t7edTSSom9Kj39XMeVTKD+ND0VCe3SN4Xo=;
        b=T0mlgn8SoCNdoXKYzWPoS6UZfF4bzgKg38/V/2QqDRoLC8pHUYv6ZiFwbPYy3kJjyf
         gOZ0KTVHs9NjUAqYjo+BNTiT809LbyGIQaQ2tRv9TBNw9x+NOWfWunTvDHWn/hYiMhgX
         ks/HSCZqpbrt3g/tYDo5xacZQ6Kg7EwNxgCCMBRCuvCeIiHQgoAL1mKgyBroSxKB1P3P
         lI1FulipNUMrGHzrKS7Kzotv+wldtlp4dc4iHAVOOaTOKrwpQtYW2GEF8mX1YQanjtYQ
         qHCOiL942qC1P2KpmkiocIEW7RF6lZS3RKqBF2l9C1joEWR2MoG8QlBAGvmi1BL1mqo4
         94EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zB+Yx7ZN+t7edTSSom9Kj39XMeVTKD+ND0VCe3SN4Xo=;
        b=I9rBdSzHo9NoR1h8CEI4WuyTduGCB60a+dcpkFHPMiLsc9fQXqphg1hfcN8yqfeabd
         iRvXs+uckUZW2OcIxSHgeJpCLtIVjvAlc+vZ6Sq4g8o2MgICFZgGeTxrL02q5hWIx5gS
         ve0d3c3s5sGEzxK2k9glRiViKcNob0XF+2CUirHkIbx7zx7eNBnREqisn9CTD2jmp4r6
         aSZ8PC3t/rx679b+Ieff7lhLunZX/+c0T1ZmoO0rff0h4miBCxWJsRv5kMN6McyQ3Yfr
         PbeD08wOhu9Eq7DdbQUHkkAUlRtXMpGJXR/+XtR+BNKtO5gfcKcrrJBHYc42v/T6V/Mt
         hvJg==
X-Gm-Message-State: AFqh2kqSazOuGiBk5ftiNTQpfSYw60ySBHk8HNWgT6ybv6+Ikl+E7aiw
        kqHgc8JeydYg8v/Bte/tr/CR9A==
X-Google-Smtp-Source: AMrXdXtxzKO66Ep+oG3JB08FrDupgVqkcya4/5xLrZ8ij7hNjKIxPF0yY8p0tpEqRM+R6h/+bYJM8A==
X-Received: by 2002:a17:906:5fd0:b0:862:11f6:a082 with SMTP id k16-20020a1709065fd000b0086211f6a082mr6581682ejv.17.1673599431999;
        Fri, 13 Jan 2023 00:43:51 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906768b00b0084d242d07ffsm7979277ejm.8.2023.01.13.00.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 00:43:51 -0800 (PST)
Message-ID: <04e90058-606e-9f0d-3e1c-844595b36fb1@linaro.org>
Date:   Fri, 13 Jan 2023 09:43:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 1/2] dt-bindings: clock: Add QDU1000 and QRU1000 GCC
 clocks
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230112204446.30236-1-quic_molvera@quicinc.com>
 <20230112204446.30236-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230112204446.30236-2-quic_molvera@quicinc.com>
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

On 12/01/2023 21:44, Melody Olvera wrote:
> Add device tree bindings for global clock controller on QDU1000 and
> QRU1000 SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/clock/qcom,qdu1000-gcc.yaml      |  51 +++++
>  include/dt-bindings/clock/qcom,qdu1000-gcc.h  | 175 ++++++++++++++++++
>  2 files changed, 226 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,qdu1000-gcc.h
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

