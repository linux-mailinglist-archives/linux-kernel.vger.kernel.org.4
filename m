Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E2A74886B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjGEPw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjGEPwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:52:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F7E198D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:52:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso10821162e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688572337; x=1691164337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=frIiMffWaC8FHtPAqH/Lcc+Tg0ak1iMFrHKKSrlhbsg=;
        b=Fpvm7gEqWEDqjPw1xIOrWFSEQfVGYSt960vTw2G47d8gOuulduiUv03DxXxWAOSIFu
         qDeIpn8fCuBUQMeaa9Lr8/JqQ/9wu8IvKPajkdb1aN1Ipu4WNcIrjg8ij2V4zEQpcmov
         PnFWXIJSIerq1nQ73kLpA+6TZatpJU9S5PrzxLISbcIXHxQBQuCqMTdgWnj45D1reLC5
         Iexp6ZYfPTDbDf1elyKYXVxwSIr12M4/7a7Gp5E1VxNlNSBzkWKyWHlh23TwSjd3sSfa
         dh728KqpSTH/4QozgW89qudRFj0woVTFCBHeRN84jG5ifc3Cgl4s4CFBUlf7QCAmBSm0
         903g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572337; x=1691164337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frIiMffWaC8FHtPAqH/Lcc+Tg0ak1iMFrHKKSrlhbsg=;
        b=aLn7yul9CcySEmoqJ0hoW8Jm31FDN5RFmnUQr7D1dNrA/8MW/eN+7AE9oGJyY60iup
         ZmIenQjn5hG3Xk/fnI9v2wYogNNKdvbCVQDiuSxw1gfmsDNZR6aL0Sj0SX6/UkzXn76z
         eLBTyloMpPwx5GTXS2RcGK4W/O5IDW/ReyPgN1eKyySObiAjeRfoTf+SFh4aaXxY+5UJ
         tv/ElfYrQwhMhlrLBHMzyKHKsdJHoZ54yn7oz4bNTwqCbOAz/vkqbb4HjDgrdpYmvAgT
         fyfZqz4Oq2PWRFuwcOcab4HzlpIBCOEBNgLou2mtQEls7uZPfS25hpaoxsfbRQ8e0vR0
         96pg==
X-Gm-Message-State: ABy/qLbJJapMkToObmZ6rBqVY2LQYHKz/31YXjKUG87WQLEXack4Ywtn
        83MxBz6Xwv2fKd9FIhG7BUMhyg==
X-Google-Smtp-Source: APBJJlH9+DrIDduKdVcn+U1de79ZRpouG66xAaa3U2wJ9/rGVa+4ffrY0QJOiS9Uf5W9XRp3ZONXEA==
X-Received: by 2002:a05:6512:324d:b0:4f9:6581:8b4c with SMTP id c13-20020a056512324d00b004f965818b4cmr10862547lfr.44.1688572337309;
        Wed, 05 Jul 2023 08:52:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id le11-20020a170907170b00b009927d4d7a6dsm9535076ejc.192.2023.07.05.08.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 08:52:16 -0700 (PDT)
Message-ID: <5804e11b-cfe2-2226-1c7e-199a7bbb58df@linaro.org>
Date:   Wed, 5 Jul 2023 17:52:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 2/3] dt-bindings: arm: rockchip: Add Radxa ROCK 4SE
Content-Language: en-US
To:     Christopher Obbard <chris.obbard@collabora.com>,
        linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com, Andrew Lunn <andrew@lunn.ch>,
        Andy Yan <andyshrk@163.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@edgeble.ai>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230705141011.111568-1-chris.obbard@collabora.com>
 <20230705141011.111568-3-chris.obbard@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705141011.111568-3-chris.obbard@collabora.com>
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

On 05/07/2023 16:10, Christopher Obbard wrote:
> Add devicetree binding entry for the Radxa ROCK 4SE.
> 
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> ---
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

