Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E867733F11
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjFQHP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjFQHPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:15:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4FF26BA
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:15:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-986bfdfe8d4so182746266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686986151; x=1689578151;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DncxBWQlcUNpstw3Uyqlpb1LlZypTxxD12g/hHvOzGg=;
        b=usmhpaEw3Au+u5l4p88p0tzi7rBdur4h7/4BSAv/vKf4stAq6YID+vZD+0HazLjd+D
         2QoqkUYvXt6OObrisr8IhlK0rcdvVWOCgobynsAlFif8RnLRopiLQtXtb/jaaZuleGd5
         Q4fV6ynClFUUMKWCveoUGJhj3tf8zl1B6RRnzMuoiZtAMPbbJC6bVSlxIhUNoIdxKZEC
         ji76lxFBmMia7R71uyiv1+bvB1jgjQWC76rbMPHBO+ReMzg8Oi5ngt8qDYYVZpJGCF1t
         dlQhyq3dg+OubbPXBa67J/sIYT09TzdZ2BwAkAa07g6IAFWU3xzcUUJw+IlNfVa5ZyvY
         aNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686986151; x=1689578151;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DncxBWQlcUNpstw3Uyqlpb1LlZypTxxD12g/hHvOzGg=;
        b=KEZV6wZWoevVVFnMk2FCNPBTRVPWDDyRstVDDYHC1n1FnkyXdICkSt9+Y6h9fYd00t
         TXcPEhGoJ2+K41PreTb978IYbVtMW6xGNZimuzWiH4PJzIregvJtZDjOkOBb1r1NdBox
         EmGxNL2CIuxy2EkRcuI09iSbOnjaJ07SrazBRL0G77VQqDVVQ+TdNp1yVgrZ1+Mz/qpC
         GP8CypRO/3SZq+0ArE7zeqYJC5y0yLK0dGYz4MzcvQ/LRRDkESzBBbJV6zrgeYZrUohH
         tsdMo2usKDBCiT7rHiypjODKQU86NZgRVxOnyRzN9tz+wFrlrUqveRlTmevghFtII+lz
         yvxA==
X-Gm-Message-State: AC+VfDwKv5NfiaQbyR3HrvN2dFuih7ohYG4APPIuA5WvYxDNDEhR/92U
        PJzsvXuAnFe35UOI82svhFxuiw==
X-Google-Smtp-Source: ACHHUZ7/jJE3fjrBXvzZKqNsxyzq7Um/rwbMXpWiWfxwRf6F9pBJ/5MEXt8jFSfbW6NgzWNeepqWAA==
X-Received: by 2002:a17:907:72ce:b0:96f:a412:8b03 with SMTP id du14-20020a17090772ce00b0096fa4128b03mr4071741ejc.5.1686986151441;
        Sat, 17 Jun 2023 00:15:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709060eea00b009745edfb7cbsm11620540eji.45.2023.06.17.00.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 00:15:51 -0700 (PDT)
Message-ID: <cefbb542-e9c3-8e4f-a3fa-542414ab8dc0@linaro.org>
Date:   Sat, 17 Jun 2023 09:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] pinctrl: qcom: sm8350-lpass-lpi: add SM8350 LPASS
 TLMM
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230616185742.2250452-1-krzysztof.kozlowski@linaro.org>
 <20230616185742.2250452-2-krzysztof.kozlowski@linaro.org>
 <835bc0c9-0218-80e3-f64f-bd4116ad02e8@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <835bc0c9-0218-80e3-f64f-bd4116ad02e8@linaro.org>
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

On 17/06/2023 01:36, Konrad Dybcio wrote:
> On 16.06.2023 20:57, Krzysztof Kozlowski wrote:
>> Add driver for pin controller in Low Power Audio SubSystem (LPASS).  The
>> driver is similar to SM8450 LPASS pin controller, with difference in one
>> new pin (gpio14).
> 8250*
> 
> 8450 has a whole lot more!
> 
> The 8250 in fact does look almost identical.. Perhaps in this case it
> would be sane to combine the two?

It meant to be 8250 as I copied that one. I'll fix it.

Best regards,
Krzysztof

