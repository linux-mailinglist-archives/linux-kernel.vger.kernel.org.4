Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA3D721195
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 20:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjFCSqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjFCSqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 14:46:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D47B196
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 11:46:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9745d99cfccso344721966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jun 2023 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685817966; x=1688409966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffGnCR1AWRVuPbEtVqod9VhAoeRndwMhCaIUDGcL49s=;
        b=oB65jSg2cZ/+UIohZAO5DQQBSSbEkl7WMyUssM0+mCNxkrI7/Z4K/iAYiTTrGPNuFW
         s1jFeQQlbIuJn5+cAULlRNcfH1ZJ56kvHCGYRYnlinClcdI1dOpNqAmKIsO21F9U4nQ2
         97n3lDQWRz2LhnWSRggMH7LgQ0XnTBe+uT4p8rd+8738YqjQ8QeHvFEig/aoNmvKv5t/
         Wtqsf8ru2HLeMMqyMulQ0hEPSmvHFDONVY0YAHQvaLIuDlQr5l8Zy8qUjr/GVg0L2sQb
         h/Ti3S98QroZ8wB61PMH9WY5NNZf6UuBXZmABC0P9pTCWvqaSPcmW6vuSh0Ef/rTN3si
         wePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685817966; x=1688409966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffGnCR1AWRVuPbEtVqod9VhAoeRndwMhCaIUDGcL49s=;
        b=Qjjvoulp+7f6DfLGyRVokrqwLJtq9ZCNXjmppwmkJPXc5sWwwGpoOikKhDEy3MCCFp
         qMqgFFeBs9K7mMvFMyaWurFOEeF3e1+KYfZ1yKigi98W2C4mJyu2zgqMKcLXsNA/xQjz
         empQAIcb4t+PZYV5Mt68vLYhoYlHqkw5GrGzx57GH3hQw+ZK7rv25WjTR2P5VkrRqiSR
         GaH0n9pJY+A57/7pt/gsvG+BMLpl//vmQ0tEZGC+9O3bQWf7mA2aXzOpycx8ym6fn2zM
         q7PVCTQLQ3ZFYZbxDCRxHvFUZFkw00dvPTDbGtuFKoZT2ajwJxO99M2NZEC1brDPR+r+
         xwzg==
X-Gm-Message-State: AC+VfDwU97sd8bciW8bWa5LVcyrM/y1sy59LH0rC+EpYTjr8jqWAxE8M
        iHCFajEM8Kkfzg4LtUvEqX/A7w==
X-Google-Smtp-Source: ACHHUZ5TeVnEF5E7EKTR0piomCgLM0TUkYQnJujj6vPOILoSM4N+GykILYjYN2EhtNp++/83scPe/A==
X-Received: by 2002:a17:907:7f8c:b0:94e:116:8581 with SMTP id qk12-20020a1709077f8c00b0094e01168581mr2767917ejc.5.1685817965751;
        Sat, 03 Jun 2023 11:46:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id a24-20020a170906245800b009745ecf5438sm2208699ejb.193.2023.06.03.11.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jun 2023 11:46:04 -0700 (PDT)
Message-ID: <651f8f0d-bfba-18df-b266-e2f95e6f7c6e@linaro.org>
Date:   Sat, 3 Jun 2023 20:46:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC 1/7] dt-bindings: connector: usb-connector: add a gpio
 used to determine the Type-C port plug orientation
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v1-1-d4d97b4d8bab@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v1-1-d4d97b4d8bab@linaro.org>
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

On 01/06/2023 16:07, Neil Armstrong wrote:
> On some platforms, the Type-C plug orientation is given on a GPIO line.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

