Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AF5662155
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjAIJVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbjAIJVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:21:12 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE97140A0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:19:07 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so6088219wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C06q0gIAm/NQX+5eHkx45JzvQYMJI7cdvsvTSfGywes=;
        b=LcKxqpEhz8U5r0a54uwBc/FASNUSWirDYAW9+QV/BCUti75CTu84kFl+IRyB85lwh6
         38wOQ+SYs48AXi7MAj9iVHYp0O9TdA7fPrxi4v8/DjPQfzO+7mXJQ7E+OAcKEv7zpXW3
         pyPOd5oaene1WmOXaf9d5qoIiCYPbnLowAi6VypeaMEdzgUCJeqWiV309En6D9qIegHx
         Mcws4B5e3LHx7QUsAyS3YRGtzm6GCsWMFWnGL5hHlNdMeleBgDYlphnFkwF/iVL8hKMt
         9f4Kcf7KYAV/S/q9WwabKiRZwocxhZDgMqUBatYfxoHq9o5JPyjOI57x515HhcJKFEd5
         Yjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C06q0gIAm/NQX+5eHkx45JzvQYMJI7cdvsvTSfGywes=;
        b=4ejUKgkVdO+E1r9uX5MAoSzAbpjt2RjxxXf7bxEu+goQRDGfuI0nfELrKICQRDAqc0
         E1ZEGtVQ4PACNvxr115nhwQnJaA6XcbgdZE1ll/hTb1fGAv4LNxA0DcqNJ8rJ6FXRvJX
         /Oj/sEJwMELICtPFB6wUDMx1OsOUIAdss+x9Ec6Hsi9DXhqSQThZYtHuExeWHJfDdRT3
         3gad5bMuqdoWWZVyH9A7GclBky5zJH9OfX24KRZYvWOmytduJDSAUyVCjAKJ2DohvA4S
         zItvrXVCRnFKX+a7lTRPPXBnEori4uo4WBR0Yz1a8FO97pIGvd8wg2CKw5ZwqdUs9Mi1
         p9HQ==
X-Gm-Message-State: AFqh2kpP9XSjy72bUUJs6gnecGopsl+tseur0yM1IxwFKaLbBmVdLxxG
        SZRjSUBKpRO+xZYzcVqvWYklOg==
X-Google-Smtp-Source: AMrXdXsTzngZimD6cB8N3WV1JcLup6CYEj3DCy8hNnl16qSsT/9bpMn4TZtHWbWDJ3G59qQqHQJkfw==
X-Received: by 2002:a05:600c:4a9b:b0:3d1:dc6f:b1a4 with SMTP id b27-20020a05600c4a9b00b003d1dc6fb1a4mr55574979wmp.5.1673255946474;
        Mon, 09 Jan 2023 01:19:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c42c600b003b492753826sm10175053wme.43.2023.01.09.01.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 01:19:06 -0800 (PST)
Message-ID: <08fae328-2343-6b59-237b-95fea0f3ddcc@linaro.org>
Date:   Mon, 9 Jan 2023 10:19:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/9] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: add
 input-enable and bias-bus-hold
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
 <20221230135645.56401-2-krzysztof.kozlowski@linaro.org>
 <20230108200845.GA212886-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230108200845.GA212886-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2023 21:08, Rob Herring wrote:
> On Fri, Dec 30, 2022 at 02:56:38PM +0100, Krzysztof Kozlowski wrote:
>> Allow bias-bus-hold and input-enable properties (already used in
>> SC8280XP LPASS LPI nodes):
>>
>>   sa8540p-ride.dtb: pinctrl@33c0000: tx-swr-default-state: 'oneOf' conditional failed, one must be fixed:
>>     'pins' is a required property
>>     'function' is a required property
>>     'clk-pins', 'data-pins' do not match any of the regexes: 'pinctrl-[0-9]+'
>>     'bias-bus-hold' does not match any of the regexes: 'pinctrl-[0-9]+'
>>     'gpio2' does not match '^gpio([0-1]|1[0-8])$'
> 
> Wrong warning?

No, it is still correct, just one warning for two issues:
1. patch 1 for wrong GPIO
2. patch 2 for bias-bus-hold

I can drop last line here (gpio2 does not match).

Best regards,
Krzysztof

