Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7B7237A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjFFG1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjFFG0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:26:44 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9727F1BD8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:25:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9745d99cfccso734766466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 23:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686032733; x=1688624733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AmuejoJeHN8EldA6gQK9in2sBXKsFxRHE2nxemHliVA=;
        b=H2t73c/MUrxYkiy6d/FXdt7ZLMZLAIM5COmSQl9zxydRjd6AepsMfAOtmnHik0Guc+
         rc9lNjHORqxoWdA7OblI2Oh8ysIHBtk/ekXpSqOxhz9AwPM37E/EpwXMc9Rg2PAQ0fWP
         dt8sAQHbxrtWkt5rhaxxi3jikHAuLmpn1aEneZArnesqQ0udnbFF6+87Po4UVUFNEFo8
         JMb8FWrTp3MozQX+jopYovc9bd5nsUv0X2c8cZVL4drEWsc6hMgTRZrMZRQ6xAsdo+eq
         K9rJ66YB4yXOi2TFheMJ2yMNzloMpPx4EduS9AltjqxXW9OuLTeY5I/LqvOyTVl/v6Lh
         TxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686032733; x=1688624733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmuejoJeHN8EldA6gQK9in2sBXKsFxRHE2nxemHliVA=;
        b=VoIwR6gahzj6ftIAZDX5hEaRuHnsPO2jhoSrTJTbHXKp8EwP/B4vO1etSGSQr+ZsiV
         aTLACkE0rHi+bG675hcnYPS9jFGHhO9SXCf8mVj1SeHXBw4m2drujXCefd6c64P6iWiI
         2Qd2yfgxd/sGqv6f52A91qN6weLiFzmVFZDbfxRT8WAyVzJyYm3/KTOYk64izgIBiPtz
         0yzRgNX/uHu74U4yLzlKBoa2la/MltXXSKgyTjL+oiGvektxKgyBvP9/qMkamgjFqzS8
         A9RNBHF3GZJ3Bv+GjoyoQM9MdXK829/nVmGkA1Wv7bBw6GS+J10sdr/GM1FmiO6N2p0C
         ZU/g==
X-Gm-Message-State: AC+VfDwN82Vg+WYZl869vWH2CX8ahIsy2yK1MGjyl0ZC9LmY4ut4rZiv
        7PyvxH+Zh3kKXxCxPwce4HXzZA==
X-Google-Smtp-Source: ACHHUZ5L6idkzO3bEQLABFvgweINi4eaoibE5pbJn7hFTY2jsvzdv0qJjx8fzYBbg9thOKHgpDVh3A==
X-Received: by 2002:a17:907:80c:b0:974:218d:c048 with SMTP id wv12-20020a170907080c00b00974218dc048mr1441420ejb.26.1686032732482;
        Mon, 05 Jun 2023 23:25:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id d10-20020a170906640a00b00965e1be3002sm5157877ejm.166.2023.06.05.23.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:25:32 -0700 (PDT)
Message-ID: <d2313558-c25d-ed58-c508-dac574183d08@linaro.org>
Date:   Tue, 6 Jun 2023 08:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 01/14] dt-bindings soc: qcom: smd-rpm: Fix sort order
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-1-e0a3b6de1f14@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531-rpm-rproc-v1-1-e0a3b6de1f14@gerhold.net>
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

On 05/06/2023 09:08, Stephan Gerhold wrote:
> Some of the enum entries are not properly ordered, fix that.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

