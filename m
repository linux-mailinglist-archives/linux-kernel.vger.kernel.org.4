Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE23D6F7D74
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjEEHGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjEEHGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:06:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5639A93CB
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:06:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc0ced1d9so2099128a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683270376; x=1685862376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrbFUAyVFD9qLriRvueXfcJuV6FSCnnUKcC6aUkxYOw=;
        b=RQOQvDrJz/SNjW6J4N8CmM92+IQtZ35EFC0xoDe/GJy1brFyTDOFZdA8sPGC9RuyE3
         /3Sj8ZnYc8BOtUB6m5f24zYqRu+y4mUN5QXl3E5wt3EQ0S9s2EVKIBAkiNSwOmlPdyGG
         o2ggCdVjErcsjN+/KJSfzQplsRyiYgxAaaWnfFmUq0g6jd/TsVgdr5ayOPcjTI3AFLo5
         FTZZh8GhnIAH0BdqveukEC4ROJ+pBepuKgHseuIZj25fhhf2evgWir9t4ziLdD+azaQn
         38st9CD8c3e7K+ikOZRQx///3DVyP2aOyEP0u5AO4hHXE9xtfSeWerILSYqeUoCJK5FM
         gImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683270376; x=1685862376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrbFUAyVFD9qLriRvueXfcJuV6FSCnnUKcC6aUkxYOw=;
        b=hatrs4ryJKLF6DUkWPD0v4WCCS2WKCAcoLotGXr6ycn2QT459UHfsGapkujIxTinbt
         hk1maCmoATTHjhIkPxWoWzPogdnNbMaiGHa1Wkv8Rs2WbB4upiwCmL2z71aIoAPZx6po
         Gld0FTEIA1nTHE99a0e5JNK4lMForoHx0d4qdAXApzS/ixeAhcU4fEJ7lI7hofvPhP8r
         6goTH74bAxHuA4SslcCYknEYyqwB1jJdaH385mzBqkgJ4tflgqYFhh+WIkFdssv/8bMX
         ruNq5xYUC8HJVcnXx3zH9GBQVyTPyDAfNqprqiP1J+3bzOvXP09wTXV74Oeel76CmMay
         qZFA==
X-Gm-Message-State: AC+VfDzNXj3UJD0EJ1EeO6mQg4uSw/6ko4+kF+qjKNeHUTwb527Zi3y+
        i510+ksTd/RV0bFaQK3c3bSVWw==
X-Google-Smtp-Source: ACHHUZ7p9ft6sj/mqQm2oCbqXxlMIqrnhl6gNXYEI7Ld3xj7KL3CDGYRlCBhJ4O+rZyUA6L/Kkmupw==
X-Received: by 2002:a17:907:8a07:b0:94f:695e:b0c9 with SMTP id sc7-20020a1709078a0700b0094f695eb0c9mr287881ejc.5.1683270375812;
        Fri, 05 May 2023 00:06:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id q26-20020a1709066ada00b00965b8a72535sm558682ejs.97.2023.05.05.00.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 00:06:15 -0700 (PDT)
Message-ID: <7fff6a7a-0b4b-e5a9-6da5-6411c0943c5c@linaro.org>
Date:   Fri, 5 May 2023 09:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/8] dt-bindings: nvmem: Convert rockchip-otp.txt to
 dt-schema
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Vincent Legoll <vincent.legoll@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
 <20230504200648.1119866-2-cristian.ciocaltea@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504200648.1119866-2-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 22:06, Cristian Ciocaltea wrote:
> Convert the Rockchip OTP memory bindings to dt-schema.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

