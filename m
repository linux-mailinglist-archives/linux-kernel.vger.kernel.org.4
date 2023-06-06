Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3740872378E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjFFGV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjFFGVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:21:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BCCE5E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:21:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5149390b20aso8567619a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 23:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686032462; x=1688624462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghjbsto09XqPnsXCUmUZKd24RXiWGjP2OfhheXx+RZE=;
        b=TupcBBlW5YEsh9v8j0nYCbVHO7kh1ulyfMEcAnHSvqrsAxbcWEijEqcLa3NoDkrLNC
         VZ5CLdNHUWr4YbJo1wXbRo6ScBX1r4AqA6CpiILcBP0d8KyHdJS/h5JH5fcbSimOV3TF
         CoQRcqjIH5RKYiXQLZf0jRjIsFnNiyqbFvMvbfIh1sSwe/RwpK0D57LcVg3u7Je4g9Xo
         5flyiey/WV3vroipsE+6eGIp8rgRrH2WAub63Rc3eUdapbw9iH5Ws3qdjT55fpvu+Kmc
         Nq0FzgL743GFM8WbmcVJ7QQn51V/xseA2jDS8D3WILlA9ZC7UJh4W0TwxA2wMN6qzXny
         cm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686032462; x=1688624462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghjbsto09XqPnsXCUmUZKd24RXiWGjP2OfhheXx+RZE=;
        b=aariPN4wkMz9p7oX3bpzfhgYpDr6goewQQEeZz+XsnC8hBSYOVbcXPtMo5w7lZPOxN
         lzjxBBj+oDjMm46R6kXEsWrSn0bWKSfiGd7xauHdMw8rDqGpy+J/U8WqJMknflY9hJgs
         kBdBq3mABKP230W9KH5UgBYSwDuzWf9P0HppZGPuBoTB2UXNPEl8ocUMKxkiWBFGwMKp
         IUCy7j3jOaRStPsQiH4akgYz+vW+PQeoCwrkf/8+6ieaDzwXxHNmU6MDDj/Xk3h1b8ba
         Tla0pZpG7t5Z16TduVSJXnXdmkJTvFDKuK7ZQ6fK53NWBqrkYJPuoGswBMI/fdn4627P
         enLQ==
X-Gm-Message-State: AC+VfDykJfDYOto7exyRbO3pL5hFnixQKw23ObfY0mqj9RE3smC+aGwu
        DbG+80QH90Fxbfe6pJCQH78Rcg==
X-Google-Smtp-Source: ACHHUZ5BBOuUVEcj0d9nizDVIPtOnYGoIXZ8X7BWvAVGbZl4oKgdIvd4Behhvjfjmvzv3MOC84YPMQ==
X-Received: by 2002:aa7:c507:0:b0:50c:3dc:2262 with SMTP id o7-20020aa7c507000000b0050c03dc2262mr990172edq.39.1686032461745;
        Mon, 05 Jun 2023 23:21:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7d456000000b0051631518aabsm4613727edr.93.2023.06.05.23.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:21:01 -0700 (PDT)
Message-ID: <ee60f6ff-42bc-d30e-8465-39d00320d48b@linaro.org>
Date:   Tue, 6 Jun 2023 08:20:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/4] dt-bindings: phy: qcom,usb-hs-phy: Add compatible
Content-Language: en-US
To:     Rudraksha Gupta <guptarud@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230604063032.365775-1-guptarud@gmail.com>
 <20230604063032.365775-3-guptarud@gmail.com>
 <3c781ae6-4a45-1d6d-840c-d25f33684b00@linaro.org>
 <CT583OP69XTU.3E141NE263OR3@Latitude-E6420>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CT583OP69XTU.3E141NE263OR3@Latitude-E6420>
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

On 06/06/2023 04:48, Rudraksha Gupta wrote:
ted patch soon that addresses this.
> 
>>
>> It does not look like you tested the bindings, at least after quick
>> look. Please run `make dt_binding_check` (see
>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>> Maybe you need to update your dtschema and yamllint.
>>
>> Best regards,
>> Krzysztof
> Sorry. I was only looking for expressatt errors/warnings and failed to
> see the other errors/warnings in the sea of text.

https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/

Best regards,
Krzysztof

