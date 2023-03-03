Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DEC6A917C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCCHMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCCHMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:12:17 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6671F33462
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:12:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ay14so2902545edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 23:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677827534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xi3e3zf8Klpq1iRcEdmcSTKwBOu4pz/Ei0EPeIx1fZY=;
        b=EZLxu7Y+iizjsoeGeUbmzPxbTlnTsVxbNP5WplEQkHBNoOsLzB62obZ9C7HjJdud77
         56/49ai23BGpoS36DG6EcSbmf63qfNq5oJWGrjeCcUiiqcP5s7T2Mro0aZ/J/j8ksgeI
         +bg2Y9ZjHQdv3oumc/D705agQ/kTIHtIJYSd3isGNZ021cdwZsiNraxSgOkprbG1/VSs
         Jy/A3i7jQicgkpkM9EZeoKOzBEgUtXQp/lpjyn7AuUuLTBZDpT2aSxgAtP6jsOAfs7BX
         anizbYYk4ixsFk47zhnqdrNzqaha1yJxtgSvDN8tkCbRbvXSD9EdiLHjOJXucHQh16pa
         x2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677827534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi3e3zf8Klpq1iRcEdmcSTKwBOu4pz/Ei0EPeIx1fZY=;
        b=GO+7xv3Z8Y0TE/aHnjJbEZbGmqWEeCafHfd8OMNanbFYdNmlmUc0LBEo3Gvn2EUTSH
         bMyT5+TbZ1pMfMnhQiGjrI3DH33uydly17JnY4+ss90TRxtcr+Dv6YNtVGo0h3UhpHRl
         NRRgIX6CaD2IsnT5KX53jo3dvRP5GQ1+KEa2Foau71gbjJle0HmvwByo7pV/6cVEE+k8
         QKbnayzTxgRXK3q2Xi5yvn+7culcYk1fpBRCE4+EV+e9DBYMcY1qWh6QAYWtS0Y8JqMp
         70YMl+Jg1xKiQDfMc0n1Ca4L458PXs5YE5jnw9hQv4Rci+c9qQH/Gm325k8a95TJ8aU9
         cXCg==
X-Gm-Message-State: AO0yUKWWFbTR7TYax1sMyqoOglth0i7wqC/pOfx2m+F78j4nkx1hodN7
        DwsLSHiULUggM1SAl3b2BFT9ag==
X-Google-Smtp-Source: AK7set+r+vvJNdv0SgAgspPvo26Cw4Qq2bYappwi6VBNmRDuHd2TtvD3UYnxUh2P0DnOzbQxgvzdAA==
X-Received: by 2002:a17:907:7289:b0:8e3:74ad:94ce with SMTP id dt9-20020a170907728900b008e374ad94cemr866444ejc.8.1677827533823;
        Thu, 02 Mar 2023 23:12:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709060c5a00b008ec793ac3f4sm614812ejf.192.2023.03.02.23.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 23:12:13 -0800 (PST)
Message-ID: <8e695c64-6abd-3c1e-8d80-de636d950442@linaro.org>
Date:   Fri, 3 Mar 2023 08:12:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: ath10k: Add vdd-smps supply
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230303024246.2175382-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230303024246.2175382-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 03:42, Konrad Dybcio wrote:
> Mention the newly added vdd-smps supply.

There is no explanation here, but looking at your driver change it
suggests name is not correct. You named it based on regulator (so the
provider), not the consumer.

Best regards,
Krzysztof

