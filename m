Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D006D9DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbjDFQic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbjDFQia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:38:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9777ABC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:38:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sg7so2825435ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680799108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7beKVksHh0nuqXKI8x1Oe0LmhdDO/0yuJWUU6Y7ML8=;
        b=ixzSfaKnVl4Zry5hvhbU9WS+HySfFiNR4HSiiatv9wN9W8vloLPgDru/SOOH/YLhA5
         hasOv1T3gLTGi6tfchaKhOYr0lEMze7UyXyOeXVqhdN06OP5JhQn+Ur6EOXtHMFcE92z
         apU3SBocjFebi9NM8IJJmY0YQzK+rSOMHSgND9n+nYq/du5mcnjId2XCXFtgQE3PtmoT
         Pte540fEURgy0GHLw/vabbw7wjFCQnA/9zgFk1v8WTtiu/Xt2AM3xLYLwwB2aIZxDt9f
         ubbf17Z3Z0pLO1Ag4ArsSZbdgRxcLEpnKOKKEEQEXcE6h+QIhC9K1Y7zgQ96jDTogQsE
         Gduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680799108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7beKVksHh0nuqXKI8x1Oe0LmhdDO/0yuJWUU6Y7ML8=;
        b=hKVgZ0StvqN3HhcL+7rde76+ymZTlSoe5qWcM1v5tQM5bOKh+b3meIaWc0NFcRN64W
         KAnAikYcu9MU0pF9kyVlOZZONMFO/6MZ4ImpEL4R2ZnlwMakwr/BGZqd3EcCd904Tez9
         2TejvI1bMQzI7dV1vmVV5Vug0o39ZN04qJscupQyKv1IcVFEx2y6yy6Tb28wpH4HvU7y
         ykUltXAW/dPDqrSifRBjvjuZm1B/EeaUKcBd9xLl0wmsdQtaYvyw8YARzEYo0bjO7ds/
         5hneCVaYy2MEpf5vUp0s3cmqBa95DAQaoLk6YIoO09pal92WMzfr+Z7gSzrOhxYsxF8b
         4yfQ==
X-Gm-Message-State: AAQBX9dlpIHE2Tm+JxWsGjfNyTpt1leSAD1xJx+ag0z+5LPVdPytBjRy
        DmpqTxOOU+k6kHWOPPqpsMg6BA==
X-Google-Smtp-Source: AKy350a/1Ikxa58vdjDR4zcjMubuTa657E4gklxEi9I2kxSttoORXIf0C4IE81YUPBA3UZ9oTG3oQQ==
X-Received: by 2002:a17:906:5383:b0:939:4c86:d47b with SMTP id g3-20020a170906538300b009394c86d47bmr6915462ejo.19.1680799107771;
        Thu, 06 Apr 2023 09:38:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id h3-20020a1709067cc300b00947f4e2b2b5sm999938ejp.127.2023.04.06.09.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 09:38:27 -0700 (PDT)
Message-ID: <94ebc965-e4c4-496c-5642-da6f6cff7b3e@linaro.org>
Date:   Thu, 6 Apr 2023 18:38:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 1/3] dt-bindings: Add Marantec vendor prefix
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230406154900.6423-1-cniedermaier@dh-electronics.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406154900.6423-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 17:48, Christoph Niedermaier wrote:
> Add vendor prefix for Marantec electronics GmbH.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

