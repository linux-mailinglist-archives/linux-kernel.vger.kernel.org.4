Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4BA6FCCD8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjEIReb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjEIRe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:34:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9759340F6
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:34:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so9853866a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 10:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683653667; x=1686245667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PTIXvNfkjKtQpq2XXehsu1HsxnxlaQ3xo7+7zAhkXmM=;
        b=cjuLOKiLOLR5pxhcOONPCcRtANMQJPb7Ys5gU0dApU0RVfMZFEblOjNdA93VkQFzcj
         jxpWKED0Is/hmNFyamWI9aMCNa12qIT49oboP04JLFbvoufEMS51I2/l0o0K9S23lMuo
         hNTxRQXKfVP/WTK+9xs0q7FSlaVvk4QVXHgX2HLfOmR8Z6W2i1RzEFgJpLuxO0/zDU21
         LbZZyxaKjDjj86O7xQ0IE5F/SnNdWng1/LzX/OH6WDLTYh8Bb/9GBTpDjx5V8e9uao0u
         DWG9nrGjQe0bBXmQIodsUSN8PVK6TTr4QSuauRrRI7mXw9RK9lZFM1ghJ8vJXhG2YtaE
         ZQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683653667; x=1686245667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTIXvNfkjKtQpq2XXehsu1HsxnxlaQ3xo7+7zAhkXmM=;
        b=hWMrDP3rR/i0tPMM1CB2Gc2JrircUE+FR/xSYCGBa8Qt1m/8JGTR7VASilR5l6jOIf
         9SFMd6BSq/lia3HVoJU067lEnx9IXdoTml/L1PC1ZRI420JAfAogvBqYo9ylI3C6X+H/
         XJZEzYHDsV4srwxSV1Zi9fhMjH6AXMraxIGwvzZdQyXH2EthWQP1CJbkpuUIQTeVAT+V
         KNHq7ZrQXtokoVNXVM6yNmECh1WDOJf5AXNWVOXyix6OctO+EmXhRxA1varWJ2G7rJZ2
         aUo60zXsv9ozojCN4xpQKCEWqOCWuL3h855GvL9yVwdv9lBS+06iMbiaWAN/7oiMFUXf
         zwpQ==
X-Gm-Message-State: AC+VfDx7nde6IAWOfrJPmzLi8Se5F3av8V49ZNtJQsR6u7Epn6QCHoP+
        9Z7Ihw0BMOYGB60AloM102QShQ==
X-Google-Smtp-Source: ACHHUZ52VLIsGVBxlWMBxKgxRB6TwF7U/leNeBlqOqPe5hD3rEhEZf0pg4QMHZDcKhoItqXLTlJHaw==
X-Received: by 2002:aa7:dbc8:0:b0:50b:d305:3788 with SMTP id v8-20020aa7dbc8000000b0050bd3053788mr9734570edt.11.1683653667038;
        Tue, 09 May 2023 10:34:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id h10-20020a50ed8a000000b004c2158e87e6sm981825edr.97.2023.05.09.10.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 10:34:26 -0700 (PDT)
Message-ID: <12be228b-b898-f793-5609-db52b287279c@linaro.org>
Date:   Tue, 9 May 2023 19:34:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: potentiometer: Add the Renesas
 X9250 potentiometers
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230509160852.158101-1-herve.codina@bootlin.com>
 <20230509160852.158101-2-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509160852.158101-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 18:08, Herve Codina wrote:
> The Renesas X9250 is a quad digitally controlled potentiometers.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../iio/potentiometer/renesas,x9250.yaml      | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

