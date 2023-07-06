Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871BE7499A4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjGFKpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjGFKpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:45:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727501BE2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 03:45:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so3241169a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688640303; x=1691232303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pD6hZ44MFbYt/UszAkJfIYSV5b+f9zyLL4y7Cfkx3Ak=;
        b=CWWaS3ZTaVXEJM660tBgvPnZ+4k4euGT2xUzWummv7IyL9vXhsKkmB7ue+fU8ZnJC/
         dYV3dDC2AkZJnT4Cgy7x05GjRiKFGxzuydT8DQu55WTzIC5etUxaV8/ofWRTF8YeNeoJ
         zPNb2/yY9xgmRJ9/7KK9FTUAEGGzysWktq2E4abOid6QrFlaxV/QfZFl7LWIWmZ1ZJaV
         0EP7Dv8B5pARaGz01OhWnQ9WFFwhIAXtle145P1pYAej0PVGq5BXF1KROGduDPOUwJWy
         kDL+FNT+UyzBlPkdZ+F6o6Hre2G4d/eoDYSnvG2RBunB0MlI7m4fNCZPiS2khvLc2NFX
         cGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688640303; x=1691232303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pD6hZ44MFbYt/UszAkJfIYSV5b+f9zyLL4y7Cfkx3Ak=;
        b=Fica1K4cfNQLoEsJ2VYGGcYYmcRgNlCFC92YdfSMNutD/s710QINKIqqElpUCODv0K
         GAcQUphqTbDH6uPneIh7FCbyAMsR0pykwDSjBA/ZfqdaWCF/tCLpR6LygfvSHt0HHxXK
         7D01KHOWjsSuGobeGcVV7a0idQI1U5e9uVykF4KgmPIWmZ3aJq8xkTph7a3WzDd7DJlz
         SH9T3/4w80gtAh7I+gm8vtPi9iXNlbINTgx7GCFxRSVVYrKRoCTxYWjyiUWBfg6bB7iX
         wfiTPPXVtPqYMeF1AtcEOS1NMZT1wVE0zcXxSrY/mbMpXYPFNLEqoGRoNEKsFjUyzsaJ
         dNQQ==
X-Gm-Message-State: ABy/qLZnFXtdDURDL+aZ4Q7kGVIISob+kwHiM0yYstwwK5+eeaW4+td6
        eIS6zz/QPZHjGz9oyUclAIBjZA==
X-Google-Smtp-Source: APBJJlG++mgKMQOJPcz/Iqpz4Kiz/jgPDOca3K9+Z53sqFbFwbHXoXykLAyHbLnxyojCXVAQQP5H9Q==
X-Received: by 2002:a17:907:6e07:b0:98e:1c4b:10e2 with SMTP id sd7-20020a1709076e0700b0098e1c4b10e2mr4822166ejc.20.1688640303548;
        Thu, 06 Jul 2023 03:45:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id o26-20020a17090608da00b00992f1a3b9bfsm648074eje.170.2023.07.06.03.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 03:45:03 -0700 (PDT)
Message-ID: <318ab229-f29f-e6aa-16b8-79fa09013794@linaro.org>
Date:   Thu, 6 Jul 2023 12:45:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt-bindings: power: rpmpd: Remove the SoC specific
 entries
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1688635218-23779-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688635218-23779-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1688635218-23779-2-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2023 11:20, Rohit Agarwal wrote:
> Remove the SoC specific entries and add a generic set of defines
> that can be used by all the SoCs. This will remove the duplicate
> entries among SoCs.
> The arrangement of the defines is done according to the frequency
> used in SoC specific entries in the driver to avoid wastage of
> memory.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Please compile kernel with this commit and tell us what is wrong... Even
if bindings were not an ABI, but they are, this would not work.

Best regards,
Krzysztof

