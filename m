Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CD56FB1D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjEHNjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjEHNi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:38:58 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073CE348AE
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:38:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so48872850a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683553105; x=1686145105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woKzPWZT/bQSuEEeDupLjbOBc2IuLWiAC/fQ+9W0OtI=;
        b=kGzUI9TQxP4vUqGf/83SQ5eteFqkoIq0DD3BYuMSzAXrkrAWNXLTJ2yx/CQv+JOL0M
         ZbJqouOliaaIy0PARFAkl50UN3mMJwpO+QmPJJfwqVTkLlStTUz0JpJRuvtKGsk5Si4r
         pgGgOJ8uOCf/N2vf0wVVf3uENMeFdNmZlk/ymyynW2WiZI4WAhjZFWyA11Kwc4vwqkaL
         tVVvPz6ylKNWs6Hj8Wy1PWcOYNE4eKeYz8Gv00dP7xeoRq+OgSmudCLfQLC2MuBr/hGe
         PDTUo3HbUtZVy+qgdug9jTtahc+mbeW5bQ1vfuh+d5sDZiRh5BePysFJRG8TmqqWeXHf
         jNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683553105; x=1686145105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woKzPWZT/bQSuEEeDupLjbOBc2IuLWiAC/fQ+9W0OtI=;
        b=ChvfejPg98XdD0YrqLzHnJLK/JtzgGB7dJl7rWjxVL5QAsiCG4iAyTo+78+GDXu23z
         DSS+sj5aERANZdIK6WTml+1sCL+VwNB1nxEs99a6Eas39MhLMEz/ps9pfIYaZRAhOio8
         rJRbuIyXWSvdyKrcGzWwwvf3tZi955lUDuspnaTgaUXZPuOW021+0zpHbQrs4VMyX8pH
         4F01NYhzexw24Cx0jgakVdIVgh5hHJWkoivrrh9ROlVYILW/JcymW+1Yl6RnXCJXcq2b
         NbjdBL+p4Lt6XsVGqEnIJaH4se6InmhakNUWsB89vC4Qv8Ls7FEOUKPt9By2wgNxY9qv
         rQUg==
X-Gm-Message-State: AC+VfDy1Hx7dpaBb5RJx6s0bSsYqoT0M0tva5a4uFZDooldUEOs3m1Rl
        e+Qw7JFHzI3aVxbPg5Vo/kkQPQ==
X-Google-Smtp-Source: ACHHUZ7BnzceJki9gY6p43DrLwhLeql78EWxr7Z52cBHEZ9rzdtRloV/MTGFSk9tsxJyym80qdPtdw==
X-Received: by 2002:a17:907:1691:b0:94e:b3a1:a3d5 with SMTP id hc17-20020a170907169100b0094eb3a1a3d5mr9651469ejc.21.1683553105062;
        Mon, 08 May 2023 06:38:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090686cd00b00965bf86c00asm5048403ejy.143.2023.05.08.06.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 06:38:24 -0700 (PDT)
Message-ID: <0e46c212-28a3-e8dd-db38-6233176b699e@linaro.org>
Date:   Mon, 8 May 2023 15:38:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: Add bindings for TPS6287x
Content-Language: en-US
To:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@axis.com
References: <20230502-tps6287x-driver-v3-0-e25140a023f5@axis.com>
 <20230502-tps6287x-driver-v3-1-e25140a023f5@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230502-tps6287x-driver-v3-1-e25140a023f5@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 15:14, Mårten Lindahl wrote:
> Add bindings for the TPS62870/TPS62871/TPS62872/TPS62873 voltage
> regulators.
> 
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
>  .../devicetree/bindings/regulator/ti,tps62870.yaml | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

