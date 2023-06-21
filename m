Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678E1737B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjFUGRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjFUGQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:16:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49681FCD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:16:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9887ebe16d0so454742366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687328191; x=1689920191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fixAEq2fesQspEmY/rSbt0mS+POR0uhtDQXTB9EXkGI=;
        b=NpxPkoKNn9bqutXKY1SBLdUxStfUPsyabnbNYlyXj/CSxvX8YRakf1YcxvkPym68OU
         uleZrV+XAig33EJif7Qvmraqps3YpE6lkGPJzBc6pl0+AFJ6qZc4L30GLooj10JXEgwI
         RHRwEBrsfYW1QcR6xSkmZUWHIR8ky34PXZ7M/nALttf1GEmkBA+D3LWISl1oa3fVePgx
         nis5yrEySKBCUZKGviIM69tzlmJo5c5yaVetc3WSHWNx+12VrSXDTGJKzsBksrNwn67v
         xR1OOAa0XN8sNNBjOd7g6AcorZduTDuFSYDaADcrRoL+/DIaszZ4Y5aTA1GxF6beFC1z
         PXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687328191; x=1689920191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fixAEq2fesQspEmY/rSbt0mS+POR0uhtDQXTB9EXkGI=;
        b=hww9Hc+T0YWDY9mXsvBkgb3YUe4e/MMahgYyC6dr9Lxn1ef3HdIb7oI44qCdWMYhG7
         GRdzv5IJdwOSaIUMvNTRmeSChu0oqLlaLHaa8mv47PfJdGcZtXtCVIGabi3LR/htLEe8
         4MeIqDdvGqyuoub+NrJnedNB26iuxaa+AoaJ0iVrPmC9ml9R5EjhzvJTmPOJmX4zpuEH
         zxZj6GA56gk2Rn33enbAkFoy1dgvv55CVCzy8QfBFwBPdSvGGC6uHsc2spbGrejOQc0u
         9hdOo5RmBhT/KMOgrmZjw8T25a0oMuGfXf9wkciHQ1quoPqBZkM2YqS+r3VoMlo+en7D
         WBsg==
X-Gm-Message-State: AC+VfDzc4X36luwF89zJkh6mpl0B9Pb8+5MgUHbLH7/XjUThcGKnFuA1
        Jl/uMd2aL/7M8785AK9TuCv8uw==
X-Google-Smtp-Source: ACHHUZ7KYUf7HH9290LpEYW9xsmzd0YHZYDWGwFzt/9TTjq+OQoCHiaGT7Xbj3QSYV6YPUX9ryqAnA==
X-Received: by 2002:a17:907:7249:b0:975:bbd:d205 with SMTP id ds9-20020a170907724900b009750bbdd205mr13202505ejc.9.1687328191605;
        Tue, 20 Jun 2023 23:16:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709062f9100b009885a03467csm2532646eji.31.2023.06.20.23.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 23:16:31 -0700 (PDT)
Message-ID: <9d85c828-1be2-6b6a-099b-fd997304339b@linaro.org>
Date:   Wed, 21 Jun 2023 08:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: bus: ti-sysc: fix typo
Content-Language: en-US
To:     Mans Rullgard <mans@mansr.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230620200917.24958-1-mans@mansr.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230620200917.24958-1-mans@mansr.com>
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

On 20/06/2023 22:09, Mans Rullgard wrote:
> Fix typo (period vs comma) in list of valid clock names.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  Documentation/devicetree/bindings/bus/ti-sysc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

