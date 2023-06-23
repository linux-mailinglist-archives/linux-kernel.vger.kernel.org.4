Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2980273B258
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjFWIJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjFWIJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:09:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2972105
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:08:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9875c2d949eso38632866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687507737; x=1690099737;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61hnG3yUipEfgXuHCHhviz9DgCyYNvHGYoGPWJLkt/M=;
        b=erVJdjwtwrJVStyE4E6L/LQ7dXXdbhaZpYTLFOPE5MP/FrFoqWsvDKNv1ZaVYZhBeY
         8F0Ado+HM0ImBANx1Ix83OyqMUQUgfUILLke5lZaFPsZ0K+7ioCg1HIP9nyoTNqxHB3U
         cbeHHcS0xow0A27FGCoHnzj0DthAj8z3Yt5hV8TOMgLTJ1bUWo2J1tyRE0BjeQJn8eLK
         MziKEInTKThFdGKGiM81SC+3jYev2Dpg25Hn68yMzJZcrFtU0hwMCLyO/IHMgtE3Shb0
         nMwho1uUPNvP6bdcWwHdQKUk/noVTXSwrlZyFogs0KXtyF+3G+16fCv2y9xvXhxUEpMd
         Nrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687507737; x=1690099737;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61hnG3yUipEfgXuHCHhviz9DgCyYNvHGYoGPWJLkt/M=;
        b=YAEl9KPTFdMBSP4emaPY3Izu63ybtEDTyqxbjc1pdoxnuvtqU7x89ntvqJZgO5m1yA
         +KeE6oPkbmKJPQ+vGmiWSG7s/uBrtRG5xG1azCTUWmwEuZSXtj1wJTllKcSR0sRSy+YW
         Wx8mjGbI2Rwf4lf+ZZ6j7oOrSfgNCp98jbGnAfY8akUWGUF/Ki+VBD8kiGdotjZbXGy3
         vbVjKuXrGG+7B2BzIC0VO+2opTJI8NIaH1ZMK/GN0gAhjg8Sfszg8uTd36atQCWdPRQA
         HE8wt4/nHNNvFTiRfiKFq4XlKNOohwxsAOWrdx8FvTFDQVx2VfTL8S6QFulJYUyLydlz
         zhpw==
X-Gm-Message-State: AC+VfDx+LxdPcVu7W7Pg2fZ31Tdt5aTuVxTBP0/ctO0xvoX82HSFW5kF
        W8iqbaf0M4bD0J18nFT3XI80IA==
X-Google-Smtp-Source: ACHHUZ5fEluowmDvQcOv9Mfk479MA+dnDrPOx6btNBBr0J7FqLU5b9fcKOilyObJt2z9EU0JqRmjfg==
X-Received: by 2002:a17:906:da84:b0:988:f307:aea7 with SMTP id xh4-20020a170906da8400b00988f307aea7mr11442363ejb.7.1687507736928;
        Fri, 23 Jun 2023 01:08:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709064c4100b0096f7cf96525sm5747617ejw.146.2023.06.23.01.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 01:08:56 -0700 (PDT)
Message-ID: <dd12208c-baec-8628-163f-828575bf10b1@linaro.org>
Date:   Fri, 23 Jun 2023 10:08:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/6] dt-bindings: phy: qcom,m31: Document qcom,m31 USB
 phy
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_varada@quicinc.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1687414716.git.quic_varada@quicinc.com>
 <4f4136a91b24d3ad35fa12bd19fe14b83da9affe.1687414716.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4f4136a91b24d3ad35fa12bd19fe14b83da9affe.1687414716.git.quic_varada@quicinc.com>
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

On 22/06/2023 08:22, Varadarajan Narayanan wrote:
> Document the M31 USB2 phy present in IPQ5332.
> 

> +description:
> +  USB M31 PHY found in Qualcomm IPQ5018, IPQ5332 SoCs.
> +
> +properties:
> +  compatible:
> +    items:

Also drop items.

> +      - enum:
> +          - qcom,ipq5332-usb-hsphy
> +


Best regards,
Krzysztof

