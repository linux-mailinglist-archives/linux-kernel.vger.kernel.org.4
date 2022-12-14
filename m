Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D5B64C9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbiLNNHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiLNNHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:07:11 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7440DBDB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:07:10 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p8so10294280lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19PlxTH6HjLj6MOm0r8d3Mtib8MDHGfQ7s1+Gv9Gb4w=;
        b=eeqAwjSMnzsoKYxu244d2zQV0IDPOBIUMVofetti+e7f3u1otrEzr00TP1Y+xlJhKF
         t23RLPY9Z2XV4jbk7FI68Ji3oGAlAobUUhVNLF0Fc9wvxJNhmUmlaYrDMiwCNEMaxU5F
         RqNsGokCArzYGmF8z2VZ+aNsu/LyJ4KwcbI9c0JP+h1Xqg46i6aIGswZ71Yo50lQSwOI
         wGUnwGQoMT++nbxo0645Q7UktAB7AQqU/nQgMnaWrT2huG92+3xoBD6IajjWSHiQi2oO
         0CBblc6zyCq5opIwALeMkmDT7Nt4cJCbkgIpXLgp1ci1b9wwrpGeCmlWc5BfGYkXIz2q
         DexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19PlxTH6HjLj6MOm0r8d3Mtib8MDHGfQ7s1+Gv9Gb4w=;
        b=8KwLL/8Yy9yqVGlGlYV5w7a7W/LM5/FxBQifdKH1wYpvIx/hjRByk7OQx0M0zvVc1N
         CQkvljk8gyejglpo2tg5VaZU9c0Udz3zSSbZdpoQCHUkRDz2NMgFxF7K6a3knBK8iQtG
         u8rsu9po9UO2HTf3HyForhgS0t/FEw5vWbiTO3Q8He0OClvC/kEUHzSckqPYLdIVCjxH
         fQfDi0wi3SXSg7zgTxdBwJBy6rWG7LwUjgDILoUob7QMuKUNxE6aKcSTJj6whcVgxJYr
         00w8IE79BVuB/ZcQdE4L6IHeGqTFYBY5frzsBPkZBqReyLeaplCnoH8aG92rENZSVahr
         wJeg==
X-Gm-Message-State: ANoB5pmw0wq8yYWqEtr7lofNBN+Wov/YaBnMnDjYiGR68X9zk3NQqGTI
        SIXJQSp+SRkDoKy00oZCYIP2Rw==
X-Google-Smtp-Source: AA0mqf4dZ1U0EDtYLZPQvJHrd4y4OimmcZ23hrR0PM6oFIjLPuARVLBasOUpG7OlFLdTLy63WZAHaQ==
X-Received: by 2002:a05:6512:12d0:b0:4a4:68b7:d63e with SMTP id p16-20020a05651212d000b004a468b7d63emr8868603lfg.37.1671023228860;
        Wed, 14 Dec 2022 05:07:08 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t3-20020a19ad03000000b004a44ffb1023sm805541lfc.57.2022.12.14.05.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 05:07:08 -0800 (PST)
Message-ID: <76b8e67a-c226-f604-81a7-f278ba35980f@linaro.org>
Date:   Wed, 14 Dec 2022 14:07:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 15/17] dt-bindings: soc: socionext: Add UniPhier ADAMV
 block
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221213082449.2721-16-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213082449.2721-16-hayashi.kunihiko@socionext.com>
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

On 13/12/2022 09:24, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the ADAMV block implemented on Socionext
> Uniphier SoCs.
> 
> The ADAMV block is analog signal amplifier that is a part of the external
> video and audio I/O system. This block is implemented on LD11 and LD20,
> and this is defined for controlling audio I/O reset only.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

