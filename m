Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8943861967A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiKDMqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiKDMqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:46:39 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6FA24BC7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 05:46:38 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l15so2928335qtv.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 05:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mj+WKlY1HcQxQ/yWU1qrQ6DNMIOjDVUH0LcSZ0W+fA=;
        b=unEXYlUf8ILSnT9vwL7798Xkt5Aexz4M8v4axj1/7yv3c+iNWdPmwEVNOI0gskLjyV
         53WPal+SwjlN3jD3Ef7PnwByo1YPsmfH+lt+1Mbv/boGDhsWn72p61fJr74aQLlhMNOs
         4KWk7N0KLPUSFcgsKPiqRzCRI1zHmJyuYrvib+GVC+MGCKHpLEEdMYa6rD+DDB5jmC6G
         vvLghRC6CXFyJT1hkaJm0TdFnJ8rcsp63pAcktv1di0g96lUOZhqIahbIxdkzgh/+nRo
         OXwwqFSODrz9mMS5Op0HM3HDld+NU6m0l0pDlYKdsP9gxwQ0PXmAstVwPBY84nUrA5Py
         7xJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mj+WKlY1HcQxQ/yWU1qrQ6DNMIOjDVUH0LcSZ0W+fA=;
        b=UrD1WrZuQyTmVZNzxA6ZxYT4yA8lIab0cmjx8ZFM39m6AuUqspj1XwJqJE+uNZ3Zgw
         n4OCd4qKHzD1Yer5r4h0CpeY4QBLPHGeRDVYb0P8risYH/FIW/9Elclc682FXRT4ovDD
         gafjge9Fj7djxCkmXaT9rEy9TWm7VhbbZatiFfkBBKE7jeo/MJN3eb1OFM6IXtOPBqZo
         lDHYLgsrhQxNYZvmENe96//SOz3pU42ZQJ9vmH6FO098HAK9L4UlPbK3nqROTrnnoTgZ
         mvypaVQD3u56kjY3MuXhUOsN1aKx4CHr8tu1xTduiHZ0jKDeX3W0VBnSV7pPWIxXdF7r
         CChg==
X-Gm-Message-State: ACrzQf1fkWq6zpzIzAHalmfQ0u5JOI6KG/zu8SvH4Hn6HBKPi7v/sOyb
        BrhPOFZDcARQgkGqO1by1gc9cg==
X-Google-Smtp-Source: AMsMyM4tqFfqwLOJfws9M+0wxPnylrB+BGQ7llCpIk8lmh4qqb2DGSHSEHE3Qb/F/O+F1Arw4YIfXg==
X-Received: by 2002:ac8:7508:0:b0:3a5:298d:c269 with SMTP id u8-20020ac87508000000b003a5298dc269mr20795904qtq.464.1667565997731;
        Fri, 04 Nov 2022 05:46:37 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id b6-20020a05620a0cc600b006e6a7c2a269sm2832382qkj.22.2022.11.04.05.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 05:46:37 -0700 (PDT)
Message-ID: <82801ce8-3a25-3174-65bb-239875065761@linaro.org>
Date:   Fri, 4 Nov 2022 08:46:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] arm64: dts: fsd: Add Ethernet support for PERIC Block
 of FSD SoC
Content-Language: en-US
To:     Sriranjani P <sriranjani.p@samsung.com>, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Jayati Sahu <jayati.sahu@samsung.com>
References: <20221104120517.77980-1-sriranjani.p@samsung.com>
 <CGME20221104115909epcas5p25a8a564cd18910ec2368341855c1a6a2@epcas5p2.samsung.com>
 <20221104120517.77980-5-sriranjani.p@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104120517.77980-5-sriranjani.p@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 08:05, Sriranjani P wrote:
> The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP, one in
> FSYS0 block and other in PERIC block.
> 
> Adds device tree node for Ethernet in PERIC Block and enables the same for
> FSD platform.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---

Same comment apply.

Best regards,
Krzysztof

